Return-Path: <linux-kernel+bounces-207588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C165E901951
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0786D1F21B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 02:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138F46BF;
	Mon, 10 Jun 2024 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGy2wb64"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA61C3E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717984817; cv=none; b=N52RdALk60bDVuG0Tz8NBwHY47C/GDsg2fStWfARA9DeyS8h/vbFGn52XlZxFlDfvKddRQwNtBMDugcdhPYslCyfbz2Xsdc/3ETZ6MG1znv/vmLTBQEsBC0sB7AmMBfRZslypzUQhtfBgeldm8jNaCaOm2p1wI6+un7XPGY83mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717984817; c=relaxed/simple;
	bh=SXB30ZzUlkp5H3QAvEGmgh4pmYdO5hRaa1DkR4J7vMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF0WccUXgA9bi1ZDgJ194X/aO9BvSU+H+/f1rxuzGy0jY7rJ6k+F5ecNfbQgA5KjLMrh3j7MwwHP3cz1MSBp4yxO0+qGNJYoi41bVxbrMToVo4wNbBmqQwwltWz0sUTdeo58ITh1/q5LibQKYAgwFDndwpEDo4Fu/OAdJFAatFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGy2wb64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717984814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOO4GVvcO0xxLYThv3Qu7QqLhlBUXRK/6CUBfcNRt6Y=;
	b=LGy2wb64h1F78ziEBLYogCwV4Bf9o6pr8jRJ4UiF7IEhzAjTbLNQH3I68oV6RyMwYuQfbf
	eT4t8802JECYwEPLo96VHxTMPk7dPBHyPv9JFytgiw/0b9HbK04xKVr0oLpqteHDOLQEP+
	RNos7VFur3ULf67CMtyijLzbHmcY2ew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-YTJnEZSHN1GUcLYIlQdWmg-1; Sun, 09 Jun 2024 22:00:10 -0400
X-MC-Unique: YTJnEZSHN1GUcLYIlQdWmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2CC085A5B5;
	Mon, 10 Jun 2024 02:00:09 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 97CCF175ED;
	Mon, 10 Jun 2024 02:00:07 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:00:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <ZmZeJVa/kpyfZ47g@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <Zl7Vd3BqxDXdMHkL@MiWiFi-R3L-srv>
 <epa3mtnac3ekyoq7zykyjnhu3i27mivbtlkss6mbjyaa3kmhof@qwbfshfbtei4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <epa3mtnac3ekyoq7zykyjnhu3i27mivbtlkss6mbjyaa3kmhof@qwbfshfbtei4>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 06/07/24 at 08:27pm, Coiby Xu wrote:
> On Tue, Jun 04, 2024 at 04:51:03PM +0800, Baoquan He wrote:
> > Hi Coiby,
> 
> Hi Baoquan,
> 
> > 
> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
> > > A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
> > > the dm crypt keys persist for the kdump kernel. User space can send the
> > > following commands,
> > > - "init KEY_NUM"
> > >   Initialize needed structures
> > > - "record KEY_DESC"
> > >   Record a key description. The key must be a logon key.
> > > 
> > > User space can also read this API to learn about current state.
> > 
> > From the subject, can I think the luks keys will persist forever? or
> > only for a while?
> 
> Yes, you are right. The keys need to stay in kdump reserved memory.

Hmm, there are two different concepts we may need differentiate. From
security keys's point of view, the keys need be stored for a while so
that kdump loading take action to get it, that's done through sysfs;
Froom kdump's point of view, the keys need be stored forever till kdump
kernel use it. I can't see what you are referring to from the subject,
esepcially you stress the newly added sysfs
/sys/kernel/crash_dm_crypt_keys.

> 
> > If need and can only keep it for a while, can you
> > mention it and tell why and how it will be used. Because you add a lot
> > of codes, but only simply mention the sysfs, that doesn't make sense.
> 
> Thanks for raising the concern! I've added
> Documentation/ABI/testing/crash_dm_crypt_keys and copy some text in the
> cover letter to this patch in v5.
> 
> > 
> > > 
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > ---
> > >  include/linux/crash_core.h   |   5 +-
> > >  kernel/Kconfig.kexec         |   8 +++
> > >  kernel/Makefile              |   1 +
> > >  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
> > >  kernel/ksysfs.c              |  22 +++++++
> > >  5 files changed, 148 insertions(+), 1 deletion(-)
> > >  create mode 100644 kernel/crash_dump_dm_crypt.c
> > > 
> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > > index 44305336314e..6bff1c24efa3 100644
> > > --- a/include/linux/crash_core.h
> > > +++ b/include/linux/crash_core.h
> > > @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
> > >  static inline void arch_kexec_unprotect_crashkres(void) { }
> > >  #endif
> [...]
> > > +static int init(const char *buf)
> >              ~~~~ A more interesting name with more description?
> 
> Thanks for the suggestion! I've added some comments for this function
> in v5. But I can't come up with a better name after looking at current
> kernel code. You are welcome to suggest any better name:)

Usually init() is for the whole driver module. Your init() here only
receive the passed total keys number, and allocate the key_header, how
can you simply name it init()? If you call it init_keys_header(), I
would think it's much more meaningful.

> 
> > > +static int process_cmd(const char *buf, size_t count)
> >                                                  ~~~~
> > If nobody use the count, why do you add it?
> 
> Good catch! Yes, this is no need to use count in v4. But v5 now needs it to avoid
> buffer overflow.

OK, did you add code comment telling what 'count' stands for?

And the name 'process_cmd()' is also ambiguous. We may need avoid this
kind of name, e.g process_cmd, do_things, handle_stuff. Can you add a
more specific name?



Return-Path: <linux-kernel+bounces-207585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5684901935
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED10EB21556
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6B11879;
	Mon, 10 Jun 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEUQCCzl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0C17C2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717982354; cv=none; b=dZtYdFROZ+17YjQTGrR6P96vyaQMz0vxQXqm8+WhnFR9+9Y7CcIoKO0mFBNKF4XNqciamCl6QZ9Yb1HMCWvZERq9iyqxqBe6SaR4QFkjgFJZTpEkfaSaP1c4D30vGmhSioVorhVOnt3l/BgEBAD8zh39TB7OKM4BNsXG1b6CmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717982354; c=relaxed/simple;
	bh=fqBk4xUxelINKuqmz+ewnOVgrq3/8aUv13chp0wuTaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diK5RyVW3/gXrkdfFrXEFMcUQnnjo27IB08ZaBmEwHVdbvRDIS+/Ka013lpo4uciSR3xAAW/mnAYk57Pt1liTRq0sK0MkbG3kjHt/OnMDIMLb5m7Pnu/W1zUIGO9TQQs39Yym3jOmv5e6wDoBM8p3pKYd9A240qOU8qaBt3ef4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEUQCCzl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717982351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uqVpGiW41LdDIPZDGk2krTR1nMbUR1Dbs/h7+D4MIY=;
	b=VEUQCCzlJGsP+gBWWFgEcEXt5nVUlSW7ghcIovM+Tyv9hPW/FSEOwePpZqzdJHEPcc0fP7
	F+2uGEDEbR9PyExixG21qPwHUtTWdArDoBZBFGQTjCBPf1uN4ekp7hBpVkzngtTbqKhM5L
	dgOqogFrb0C09Zfs77VBZBFvWD7I/fE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-OYqCyoXeOyS0ZDmtYLfsgg-1; Sun,
 09 Jun 2024 21:19:04 -0400
X-MC-Unique: OYqCyoXeOyS0ZDmtYLfsgg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0954195608B;
	Mon, 10 Jun 2024 01:19:01 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3D5630000C3;
	Mon, 10 Jun 2024 01:18:58 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:18:53 +0800
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
Message-ID: <ZmZUfWKovZLkXpJn@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
 <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5gj3rxxf7tgolj72mxwnbjirxrlx3pezvqcegyiuenwr55njoo@6dg2toxu6vah>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/07/24 at 08:27pm, Coiby Xu wrote:
> On Wed, Jun 05, 2024 at 04:22:12PM +0800, Baoquan He wrote:
> > On 05/23/24 at 01:04pm, Coiby Xu wrote:
> > .....
> > > diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> > > new file mode 100644
> > > index 000000000000..78809189084a
> > > --- /dev/null
> > > +++ b/kernel/crash_dump_dm_crypt.c
> > > @@ -0,0 +1,113 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> [...]
> > > +
> > > +static unsigned int key_count;
> > > +static size_t keys_header_size;
> > 
> > These two global variables seems not so necessary. Please see comment at
> > below.
> 
> Thanks for the comment! But I think it's better to keep these two static
> variables for reasons as will be explained later.
> 
> > 
> > > +
> > > +struct dm_crypt_key {
> > > +	unsigned int key_size;
> > > +	char key_desc[KEY_DESC_LEN];
> > > +	u8 data[KEY_SIZE_MAX];
> > > +};
> > > +
> > > +static struct keys_header {
> > > +	unsigned int key_count;
> >                     ~~~~~~~~
> >                     This is the max number a system have from init();
> > You can add one field member to record how many key slots have been
> > used.
> > > +	struct dm_crypt_key keys[] __counted_by(key_count);
> > > +} *keys_header;
> > 
> > Maybe we can rearrange the keys_header like below, the name may not be
> > very appropriate though.
> > 
> > static struct keys_header {
> > 	unsigned int max_key_slots;
> > 	unsigned int used_key_slots;
> > 	struct dm_crypt_key keys[] __counted_by(key_count);
> > } *keys_header;
> 
> Thanks for the suggestion! Since 1) KEY_NUM_MAX already defines the
> maximum number of dm crypt keys 2) we only need to let the kdump kernel
> now how many keys are saved, so I simply use total_keys instead of
> key_count in struct keys_header in v5,
> 
> static struct keys_header {
> 	unsigned int total_keys;
> 	struct dm_crypt_key keys[] __counted_by(total_keys);
> } *keys_header;
> 
> Hopefully this renaming will improve code readability.

If you add key_count into keys_header, then kdump kernel will know how
many keys are really saved and need be retrieved. What's your concern
when you have to put key_count outside and take it as a global variable?

> 
> > 
> > > 
> > 
> > > +
> > > +static size_t get_keys_header_size(struct keys_header *keys_header,
> > > +				   size_t key_count)
> > > +{
> > > +	return struct_size(keys_header, keys, key_count);
> > > +}
> > 
> > I personally don't think get_keys_header_size is so necessary. If we
> > have to keep it, may be we can remove the global variable
> > keys_header_size, we can call get_keys_header_size() and use local
> > variable to record the value instead.
> 
> Thanks for the suggestion! But the kdump kernel also need to call
> get_keys_header_size in later patches.

If so, you can remove keys_header_size now. You can define local
variable to take the newly calculated value. keys_header_size seems not
so necesary.

By the way, you don't need to rush to post v5. When people review
patches, agreement need be reached after discussion. Then next version
can be posted.



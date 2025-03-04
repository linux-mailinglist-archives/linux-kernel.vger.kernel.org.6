Return-Path: <linux-kernel+bounces-545671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF583A4EFEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A4218929B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7386226FDAB;
	Tue,  4 Mar 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWli1bN0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25B1FBC98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126387; cv=none; b=WwptXvNqxcLJOaJS8RjNiE7HxJ99+w3JQKiPAlTZDw5fZ2LTVh+WuBbBWBdnwRGOx4jABlWWysSlkU+A3s8ncl4uuAVxW2P+eYEoacQ2Gh9qsraViNsb68vrRp1MDcaxaXtxOQwTGf2RDVdG/Kmthjr4wXwpcHtZQ8diqrOwf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126387; c=relaxed/simple;
	bh=a4tkddoYQZCAwbSeOexG1IF/4ozopqjnclajsoXxAdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy+FrNPPEzqGzNxUkjlUZRpDE45AT5YalS34tEQji9k7w1mRLhcx0Zx/CNtqUMBqiBu/GmBjvqgqkfSEg8BJ7+1HM8jxtFJKq5O+NyeFZy7K8auWn+YIBPWLnv6P5zCbmeXe+n3IWkeE/CIYhggk/tmEeLub7YNDB4mgiIWqVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWli1bN0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741126384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xDY9DZSt/pga4XOkGDiwhfhBrFCi6In+qL03vH6vWuY=;
	b=JWli1bN0w9pBfeQSDNs2GY6iow5XG4+SmxASSOIl1XY7F3IK6UMDkpecdv5GxsUGFNjNub
	Y1hiJurk8JhpIT/jABxqzuE3IdSmeXEGasde4DapH2zDSw+YUFxV8tz7AE9NSqC8U8EAO6
	kzevtmgcd+0K3ShmztrlbPMkM5YuA98=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-aV3nPBbaMwi_wGSvEqJQug-1; Tue,
 04 Mar 2025 17:12:50 -0500
X-MC-Unique: aV3nPBbaMwi_wGSvEqJQug-1
X-Mimecast-MFC-AGG-ID: aV3nPBbaMwi_wGSvEqJQug_1741126368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5AAF180087D;
	Tue,  4 Mar 2025 22:12:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ED979180087B;
	Tue,  4 Mar 2025 22:12:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 23:12:16 +0100 (CET)
Date: Tue, 4 Mar 2025 23:11:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250304221138.GG5756@redhat.com>
References: <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com>
 <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304125416.GA26141@redhat.com>
 <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/04, Linus Torvalds wrote:
>
> On Tue, 4 Mar 2025 at 02:55, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > + * Really only alpha needs 32-bit fields, but
> > > + * might as well do it for 64-bit architectures
> > > + * since that's what we've historically done,
> > > + * and it makes 'head_tail' always be a simple
> > > + * 'unsigned long'.
> > > + */
> > > +#ifdef CONFIG_64BIT
> > > +  typedef unsigned int pipe_index_t;
> > > +#else
> > > +  typedef unsigned short pipe_index_t;
> > > +#endif
> >
> > I am just curious, why we can't use "unsigned short" unconditionally
> > and avoid #ifdef ?
> >
> > Is "unsigned int" more efficient on 64-bit?
>
> The main reason is that a "unsigned short" write on alpha isn't atomic

Yes, I have already realized this when I tried to actually read the
comment, see my next email in reply to myself.

But thanks for your detailed explanation!

Oleg.



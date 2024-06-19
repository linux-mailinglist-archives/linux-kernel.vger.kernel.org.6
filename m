Return-Path: <linux-kernel+bounces-220728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6F390E655
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0539AB224AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8917E103;
	Wed, 19 Jun 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCsL/qu+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E07D06B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787201; cv=none; b=MAgLybgnIq1I0bC/qWf7p8sG0Z/AHmyxYMnHpqigdWm9zi1h91rvBxHwOs2PTS5Q8LiAW7keJ0wv0djGWxUpr/lsJd0vG/B45lP3lekonVj61jxq7KWre0SUUnBvcsYsPh62C2XgIDWNOQ05KoCMreRJAsXHRgfoHN4Okvj/NuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787201; c=relaxed/simple;
	bh=+6Ph+TrFLry0RALJDZwC+l5NPuVfp+qEKrt9VTovrrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aka6B2tv1ivKjLrfvW2DZVwK+9ebFRATCyTpxTUz02NATWro7NPNR8mGhOk39TIIc3mseJr+vTwA8a378GVgAmqqRIXINipn6SGvQHerzsQo3d2vCGHR9HANoz5khwbBEWit+umLlZpQrC+OOh2JXQE5fhmQMESxhemX+Y7Ye94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCsL/qu+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718787198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPS8SS6ennjQHF2kXRfpt1rl7sSsrfRS8VpYtUApKVM=;
	b=RCsL/qu+fGVIx9C4b8/XrJ1W4zaKBpbKuk6quHUFL8HXtAn33EBYJ9kjFRyjxg0H+JqUSx
	uRxlQZbNorpKFJQ1Gmbs+ai1cWqJKdtFtlpsoa+w+gwf1U8SfnIKiprNBVgUuHatQpftCV
	FOw57oDmHD6C2LVFBG1Z1iBuH0prU0s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-GZOgIdjJMkKvE9J5rtC_UA-1; Wed, 19 Jun 2024 04:53:17 -0400
X-MC-Unique: GZOgIdjJMkKvE9J5rtC_UA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ebdc5ccb17so47225921fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787195; x=1719391995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPS8SS6ennjQHF2kXRfpt1rl7sSsrfRS8VpYtUApKVM=;
        b=cpNLCCwnzianadT6TLffZLZsEbJ0BKMLNJ03RoHE7Zx0Xmm5EA3e8WrKBQ2MDBYP8n
         nrCBAhQmrkMTPhZahoOBC64qk6fvM3bRAQ88/7Y4HGcw1A/8yJqQR/iITM3FC/60ok7B
         QNSwI26rQkHIea3m570woOrXIt2DFdWxzXwM5UyTWca7Kym8mk8HOJf8QfWr1Px+hFS5
         46G8A3cBZzO/zK4gfg3pJl3Q9MVWlcFN62KCBwU/9g74L5xKv7V7Iai2EkyCfvCLnFzq
         mAPKwgh0KZuN5NNNGTQDPbwX8uWVjhpNkiVCsXmrI4SgQF8b2lYBTN+hmzPeBwvrhZuJ
         zHWw==
X-Forwarded-Encrypted: i=1; AJvYcCXN+By63T5//Kz1f/z93SuqvBDFMUwe3hVruWlckOvHUrKli11FG3ggrnqGNPwhyhziaieQ/nnZnWD5Ll9rI1C5EPz/g/1IghK3FvYH
X-Gm-Message-State: AOJu0YzKIqoc6MIbM7UPvdZ4ThG8icUxhstS8XsCbPODdwUJkNB7OPmt
	FJPIcXIV9HEuBXFysS5+n7rPRbgKumblOlvQ+OwS9OiqJ8qFGOCLtaXCZGcWSuIxJq/pT95Gqr9
	6cLHoDANgonHanQQqfYqrj0U9zrch9Db6vTZoNTaWziqLNzUWlLAJiLH/L2ux+A==
X-Received: by 2002:ac2:560a:0:b0:52b:bdfe:e0c9 with SMTP id 2adb3069b0e04-52ccaa558a4mr1248387e87.9.1718787195420;
        Wed, 19 Jun 2024 01:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE14pHNTd76/dq2L2pGAL/VAZ5zNFTz33QD2tvo9FUi+TaA3x0uzc0+wECZLIvEP2JDyTVymQ==
X-Received: by 2002:ac2:560a:0:b0:52b:bdfe:e0c9 with SMTP id 2adb3069b0e04-52ccaa558a4mr1248366e87.9.1718787194585;
        Wed, 19 Jun 2024 01:53:14 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282564dsm1699516e87.9.2024.06.19.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:53:13 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:53:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
Message-ID: <20240619044810-mutt-send-email-mst@kernel.org>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
 <20240619043727-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619043727-mutt-send-email-mst@kernel.org>

On Wed, Jun 19, 2024 at 04:41:49AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 18, 2024 at 12:42:11PM -0400, Konstantin Ryabitsev wrote:
> > Based on multiple conversations, most recently on the ksummit mailing
> > list [1], add some best practices for using the Link trailer, such as:
> > 
> > - how to use markdown-like bracketed numbers in the commit message to
> > indicate the corresponding link
> > - when to use lore.kernel.org vs patch.msgid.link domains
> > 
> > Cc: ksummit@lists.linux.dev
> > Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat # [1]
> > Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> > ---
> >  Documentation/process/maintainer-tip.rst | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> > index 64739968afa6..57ffa553c21e 100644
> > --- a/Documentation/process/maintainer-tip.rst
> > +++ b/Documentation/process/maintainer-tip.rst
> > @@ -375,14 +375,26 @@ following tag ordering scheme:
> >     For referring to an email on LKML or other kernel mailing lists,
> >     please use the lore.kernel.org redirector URL::
> >  
> > -     https://lore.kernel.org/r/email-message@id
> > +     Link: https://lore.kernel.org/email-message@id
> >  
> > -   The kernel.org redirector is considered a stable URL, unlike other email
> > -   archives.
> > +   This URL should be used when referring to relevant mailing list
> > +   resources, related patch sets, or other notable discussion threads.
> > +   A convenient way to associate Link trailers with the accompanying
> > +   message is to use markdown-like bracketed notation, for example::
> >  
> > -   Maintainers will add a Link tag referencing the email of the patch
> > -   submission when they apply a patch to the tip tree. This tag is useful
> > -   for later reference and is also used for commit notifications.
> > +     A similar approach was attempted before as part of a different
> > +     effort [1], but the initial implementation caused too many
> > +     regressions [2], so it was backed out and reimplemented.
> > +
> > +     Link: https://lore.kernel.org/some-msgid@here # [1]
> > +     Link: https://bugzilla.example.org/bug/12345  # [2]
> > +
> > +   When using the ``Link:`` trailer to indicate the provenance of the
> > +   patch, you should use the dedicated ``patch.msgid.link`` domain. This
> > +   makes it possible for automated tooling to establish which link leads
> > +   to the original patch submission. For example::
> > +
> > +     Link: https://patch.msgid.link/patch-source-msgid@here
> >  
> >  Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
> >  they just complicate automated extraction of tags.
> 
> I don't really understand what this is saying.
> So when is msgid.link preferable to kernel.org?
> And when is kernel.org preferable to msgid?


After reading the discussion in the commit log, it's now clearer what's meant
to me, but the Documentation patch itself does not really make it clear
IMHO.


It is also sad that instead of just setting
[am]
        messageid = true

one now apparently has to resort to funky scripts.
Any chance to at least document the best practices - what has to be done
as part of this patch to make git-am create these Link: things?


Thanks!


> 
> 
> > -- 
> > 2.45.2
> > 



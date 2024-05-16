Return-Path: <linux-kernel+bounces-180835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A68C73BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572CF282CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1686D14374E;
	Thu, 16 May 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh9C+ORi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6E143747
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851511; cv=none; b=Ap3u97SsF8+KqE96Wzap4jpX74Ex34gjUarAe35f1Qxz8EOYI5rIH0RCahE4385cQIpLgkJmjAm2a2cIGEGFmY5QIuX2kRT2eozW3hVvTpLVFNq00AGKp/gSlK4PcrHN4+azuhmdSBfi1I2fiWLlj1SZD2TVLQyx26Wo8ekcjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851511; c=relaxed/simple;
	bh=gEOFfe6fLPIqAo1WPwEV/+B0Gd/krGruDl9V3z9ITGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRaFr8bhWn4pHnD65qXIU82QkSJgP+4+Rd0cgZE1axD11NQSrvzTPC3mharZyOA1L6u4Djn1AMSUeF1C3aNd45FjzUhgTJCHBuANOlCXbWUeQwFAAk4RW/DXLYY3QH6kLEXhKVq3b8sUs2x6/QJ3+6Ue5hm3ZsQ1Yk87f/Fyiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh9C+ORi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715851508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLsXGy9svYf5i7R9suDR3MeGGzNJZNzgdI1byXiF+rk=;
	b=hh9C+ORi72qltU2wpAxmn9bMpmeS0szyX5d7LJ6nLDMx/6PP4GGC+nAufSN1okavQDp/WL
	+K2cUcyCNJcs81jZAv6bp49CM0chdro3/PX5DTntQ9ezvkPfqhxUcbU3goCH7RSLcSE6EA
	oJ1BRt73poFW/mxAT001esyEAaNib1k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-_n2XhbPWPp2rKskO-x2jyg-1; Thu, 16 May 2024 05:25:01 -0400
X-MC-Unique: _n2XhbPWPp2rKskO-x2jyg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ec5104ce06so59616015ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715851499; x=1716456299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLsXGy9svYf5i7R9suDR3MeGGzNJZNzgdI1byXiF+rk=;
        b=KTVVs7lTQZ585AlYS+yvlR3PyBtU/lO4j2j2j26nRdR3FDIZAEo9wTEQO1uHoMkTll
         SgcmpTtnIiEDQxtGyKOhhV66chM51HvMAlbnC65AXZ0MMEJtHEikyZIIokYV25uGmSrA
         GsboPkVMWgVGjqvUp11CrL143AN94F9kJ2HfScv+mRZLkvlYaRsYxDau0C5YOzoIHftR
         QzQO+kMj3Pk6pbVpNfxvLGJt6xHRlADFE5qxMzk5TvKu709JzYjWfw5ZuK7FCHJcb+QR
         Cl3B3lQFW9aS2AW+zF9n4Xj9wzAbt5i5R0K9BE4+oABrSe3Epfn4aNXvc9qr6qGLH0C9
         zr8A==
X-Forwarded-Encrypted: i=1; AJvYcCVPOMvf3osA9u1nYdOadj0biCIa1ofcU23x+PI8QhVzxmncEUlYJMisp9m+hFYMg2uARxtWpFQb8NhtlCVHZ0vtPfEowtOqX6jRTtZL
X-Gm-Message-State: AOJu0Yz8hJgqMXyDaEd6eUChs09hEfP2oAW11bF8L68Eo4g9BiwdSVpo
	a9ZAzkDpchFq8mGhvSGx3XBLUUiPbKl0FUdHkx+KQFKL0XhkKOUSEwAZzh7w5OEwRoRT1kzt8Nu
	RQefJi3RQY7scCbV8aybMoSdCPitR1GA2JO2wgXrisw05Tpeb27wWcPkygCguGOQoMEdxALGc
X-Received: by 2002:a17:902:e5ca:b0:1ea:657f:318f with SMTP id d9443c01a7336-1eef970fe76mr310399185ad.0.1715851498984;
        Thu, 16 May 2024 02:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjtRRqiN2KZ/i8PorLnqYc/elVZ41EN74K0P7lJgKGNOObydeMIHF+IPQLRSpASMPieLNd1w==
X-Received: by 2002:a17:902:e5ca:b0:1ea:657f:318f with SMTP id d9443c01a7336-1eef970fe76mr310398975ad.0.1715851498574;
        Thu, 16 May 2024 02:24:58 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3565sm132966955ad.30.2024.05.16.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 02:24:57 -0700 (PDT)
Date: Thu, 16 May 2024 18:24:54 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH net] nfc: nci: Fix handling of zero-length payload
 packets in nci_rx_work()
Message-ID: <ZkXQ5h8fla1KhX6A@zeus>
References: <20240515151757.457353-1-ryasuoka@redhat.com>
 <20240516084348.GF179178@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516084348.GF179178@kernel.org>

Thank you for your review and comment, Simon.

On Thu, May 16, 2024 at 09:43:48AM +0100, Simon Horman wrote:
> Hi Yasuoka-san,
> 
> On Thu, May 16, 2024 at 12:17:07AM +0900, Ryosuke Yasuoka wrote:
> > When nci_rx_work() receives a zero-length payload packet, it should
> > discard the packet without exiting the loop. Instead, it should continue
> > processing subsequent packets.
> 
> nit: I think it would be clearer to say:
> 
> ... it should not discard the packet and exit the loop. Instead, ...

Great. I'll update commit msg like this.

> > 
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Closes: https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
> 
> nit: I'm not sure this Closes link is adding much,
>      there are more changes coming, right?

No. I just wanna show the URL link as a reference where this bug is
found. This URL discuss a little bit different topic as you know.

In the following discussion [1], Jakub pointed out that changing
continue statement to break is not related to the patch "Fix
uninit-value in nci_rw_work". So I posted this new small patch before
posting v5 patch for "Fix: uninit-value in nci_rw_work".

If Closes tag is not appropriate, I can remove this in this v2 patch.
What do you think?

[1] https://lore.kernel.org/all/20240510190613.72838bf0@kernel.org/

> > Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  net/nfc/nci/core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> > index b133dc55304c..f2ae8b0d81b9 100644
> > --- a/net/nfc/nci/core.c
> > +++ b/net/nfc/nci/core.c
> > @@ -1518,8 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
> >  
> >  		if (!nci_plen(skb->data)) {
> >  			kfree_skb(skb);
> > -			kcov_remote_stop();
> > -			break;
> > +			continue;
> >  		}
> >  
> >  		/* Process frame */
> > -- 
> > 2.44.0
> > 
> > 
> 

Thank you for your help.
Ryosuke



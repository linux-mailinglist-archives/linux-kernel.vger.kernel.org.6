Return-Path: <linux-kernel+bounces-176496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B148C30C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F7D1C20CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB853BB21;
	Sat, 11 May 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYIZLn0h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81572537E8
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715425360; cv=none; b=aMQS5q4vAYXwz5eidbCY/HU6ikQOAzuMjKQG6N2tqPh77/VgwQ52YeBn4ufsRsy5565ktqxeCQB2Xo5uUlOYPvpklTJ4QYYcIr9inOcs5jy5sZLcKE6bhVEWd7CCtDtSkcg2BqASlTQV+rGJg3Dvx5rIFSizXz4kTvchkzeo1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715425360; c=relaxed/simple;
	bh=vDqy2rUJHSBhHFmjJtm+s+VS/KY6qlG35a/J5pyzAcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDNXXeKP1HWuAF9DJCg5Gl+6dpZWd0tIgZN30k40XTW2DqIAolQBYUL7Inc118ZnL7M4X/4BMF0tEdG3V3b8JVsW6S/WWoOEbU+hnu/BLmel5ySoxstPURIcSZiGAlCizawXsLpv0BYdDLm/cA5Ozyv2f1/xgoGQ6u9wzVwo/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYIZLn0h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715425357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gnu1vXlSmPcmH/HpL6fCtMgv+98LozLNST85UYYD6a8=;
	b=LYIZLn0h7ufh15EoZTCZA9M89/9Cm2UYr1SReWORhNAke670Y+P3ucsS82SzaxnxH9Ft2d
	kQVAtgLooN1olNAG+qAUqQmz/7ztaJXt22wQmupeohAPmeAOefizK603X7fKsfCa23sLNT
	LZBvUQg5pZnuJV0cCxDIAP1rXVGiXEM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-6mlHjbfBN7yXssuTzXfdjw-1; Sat, 11 May 2024 07:02:35 -0400
X-MC-Unique: 6mlHjbfBN7yXssuTzXfdjw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ec3e871624so28318555ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 04:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715425354; x=1716030154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnu1vXlSmPcmH/HpL6fCtMgv+98LozLNST85UYYD6a8=;
        b=ZzQDFcExY5qzkv9Z2KhzWqYEiRSTg/dNPDHdPBsiO7PmRJcTfUxAD76ZNdtb0ulEBt
         j4bcgA8tT9Ji9njqzTPmq+hVK9bMV1G3vJGbd/Ov0FAY6ZfaC9m4tcNPysB72QaaexdE
         T6+3JvUTkmCx+YntvhDwbW+eVjgK2zdJoEAr71omL1kYlQVvRTOrFchmOHPJCUys7eHM
         NoV8yx7TZnf3Qw7c8Yz4K8RBRc+SkgJ4TTPtd91rhD+9uSOIQug49i1KpZ2TeoOmwLlg
         4R4H1ZDu4T8zAyrsvfbq+aLW0YFhMu3lCj526W/zgSkALuuc3L2WbKkH3/fQjP4FaHt9
         i0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi396wb26rKgeM/lmBrDwe6N+midlKk7KXhcKS6xPpMdZYevOrANxw3YRnfpTXF0fb25VinN5ukduG2RUKBCaBCsjraix10wNlN+rw
X-Gm-Message-State: AOJu0Yzj2t9zDbokJwoMoTqM+6vRGgue2K+JoVuxoJK8CX5UBZKPHOL0
	wRgzL4k7fuxteoLS2lnp7qQfRFTp0BycRsk5blERqlCATLc5gqVMiclmWnIl6UtdHfw9nHqfIO8
	YapTMriIM6uKpmbJwcB8xM+2PRXiwOeNBVG2kSWUj388f/N1KRihtulgW2GhisA==
X-Received: by 2002:a17:902:db0a:b0:1eb:75de:2a5b with SMTP id d9443c01a7336-1ef4405977fmr65410955ad.62.1715425354096;
        Sat, 11 May 2024 04:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW1wVcz3JzT6t2/hgM7DFD3R3lj4OMYE08lFFhh193x9UELxrofhUoXM2JG/MivKkiCPpO3Q==
X-Received: by 2002:a17:902:db0a:b0:1eb:75de:2a5b with SMTP id d9443c01a7336-1ef4405977fmr65410595ad.62.1715425353530;
        Sat, 11 May 2024 04:02:33 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1642sm46757925ad.31.2024.05.11.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:02:32 -0700 (PDT)
Date: Sat, 11 May 2024 20:02:28 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <Zj9QRIjGLbVdd7MX@zeus>
References: <20240509113036.362290-1-ryasuoka@redhat.com>
 <20240510190613.72838bf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510190613.72838bf0@kernel.org>

Thank you for your review.

On Fri, May 10, 2024 at 07:06:13PM -0700, Jakub Kicinski wrote:
> On Thu,  9 May 2024 20:30:33 +0900 Ryosuke Yasuoka wrote:
> > -		if (!nci_plen(skb->data)) {
> > +		if (!skb->len) {
> >  			kfree_skb(skb);
> > -			kcov_remote_stop();
> > -			break;
> > +			continue;
> 
> the change from break to continue looks unrelated

OK. I'll leave this break in this patch. I'll send another patch about
it.

> >  		}
> 
> > -			nci_ntf_packet(ndev, skb);
> > +			if (nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> 
> > +			if (nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> 
> 
> #define NCI_CTRL_HDR_SIZE                                       3
> #define NCI_DATA_HDR_SIZE                                       3
> 
> you can add a BUILD_BUG_ON(NCI_CTRL_HDR_SIZE == NCI_DATA_HDR_SIZE)
> and save all the code duplication.
> 

Sorry I don't get it. Do you mean I just insert
BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE) or insert this and
clean up the code duplication like this? (It is just a draft. I just
share what I mean.) I can avoid to call nci_valid_size() repeatedly
inside the switch statement.

static void nci_rx_work(struct work_struct *work)
{
..
		if (!skb->len) {
			kfree_skb(skb);
			kcov_remote_stop();
			break;
		}

		BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
		unsigned int hdr_size = NCI_CTRL_HDR_SIZE;

		if (!nci_valid_size(skb, hdr_size)) {
			kfree_skb(skb);
			continue;
		}

		/* Process frame */
		switch (nci_mt(skb->data)) {
		case NCI_MT_RSP_PKT:
			nci_rsp_packet(ndev, skb);
			break;

		case NCI_MT_NTF_PKT:
			nci_ntf_packet(ndev, skb);
			break;




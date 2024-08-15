Return-Path: <linux-kernel+bounces-288202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D642995373D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585ED1F21CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9211B150D;
	Thu, 15 Aug 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU6hUFFE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967041AD408
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735702; cv=none; b=MeU6Bo+SjpC+nXwMdMMjAvvr3UJbu3Xn6NiLbD+LheqwJKviGa1GdVnTvV22bosg/iPRrv1z51wDE4PgM84ulbIjAZaPrrkQrVk9S9IgQwcxvUBhCC871bWGksq5RSghhJnJxAShg3XLFYKD6BgjkfF49t8oDRchuMxBfvmWzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735702; c=relaxed/simple;
	bh=w6Y8keq7MC/RcB+oPriVQpHgxKv2tM3osBO16JjXgjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnvCDb1QwA5VJdjESvaUi2DRW6ccrimxET1pkGjap8S+nIGBXEYIBDJr8gOuVZ9wEKk9fs2+kibb5PuZUcgSXFEFBSkJoeqCVD9o2+yXZSGmmVs5Zh3CTw2YY9cFXmpG37XuFsRVZfKI7TSXkQEsHTnPBt4jGQ7EFKsoMeCFLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XU6hUFFE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723735699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnzeqT3NI2WawfrxS2a5Y4awkZprFbrha1qv4O7ZfPE=;
	b=XU6hUFFEIoZDqCpJ2h/PNw7RS1tc+fV+tuoXmnWp+HMkJ1D1Gj1nFQDlE4OqZqYqW7jvlX
	m8Scl+GTMQhJk6BAxFmByLWKe4mFVWEJ1vfL8iGuE9NMGwP1gmaWWyuysw/96L98oyZR78
	r1MHebdsN01dbRQhYCxVEJzaiJOSDcU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-eCsfrbmfOOq0Mc37jClkmg-1; Thu, 15 Aug 2024 11:28:16 -0400
X-MC-Unique: eCsfrbmfOOq0Mc37jClkmg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bec49ca724so292091a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735695; x=1724340495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnzeqT3NI2WawfrxS2a5Y4awkZprFbrha1qv4O7ZfPE=;
        b=xFjmMi1/LyXtrVb4X0xoZeBEM1VoIxkkOm//08nb6JqIm2yT65J4PrIlQCMiG5DapJ
         sFlJ3jHn5cb3e1xtkHsk8gqUhqPN0dhGMXXKmjT8mdqZYEnKKZGAlmcEwE9FyJOGFJv1
         mLggsgDVD3Ky/O0IyK/+sysYVzR1wuwtFKnMh7kA2g+Q+sCi7itBXhE9lkZPR2xkJMfA
         Rgp2h0Zr/uDChrmqT17V/6PHkcIf5pN6H0oxX1f9p6/1dlIPg+BODt7R9OOBJJCDRmvi
         G3syIs5nLYAv/NVXvDT6nhLjY24pwjmc5bKfU58lJRKivoOYTkSa/W0sCViivIcXRwF8
         gpvw==
X-Gm-Message-State: AOJu0YziFwz5dpI/Y9SZ9Dq2QK0mi9UZlvObbrMGQgzdfNvjq6Qu4ykH
	yIGV6oza8gcpOOrxJQ7Z+WZNrCb859pkDb31FTofAE02JXvmvIU72Q/RvtmJviqhSIqO/w+EyJs
	/aCx6Vi+3LMUaUSd/Kjvummvv06kk/3HTDd2KzStH5cABU+5f5kjNjtmvqBN0gA==
X-Received: by 2002:a05:6402:510b:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-5bea1c7c716mr4272244a12.18.1723735695169;
        Thu, 15 Aug 2024 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/D7aBbTHDx3JnriGHYm8AR362yS4TnGCkKy4ZMsjbocDfbfeVNGG4wtZoRfQcR4P1Ow+x2w==
X-Received: by 2002:a05:6402:510b:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-5bea1c7c716mr4272220a12.18.1723735694455;
        Thu, 15 Aug 2024 08:28:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:8f0f:2cfe:cb96:98c4:3fd0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f17bsm1022082a12.59.2024.08.15.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:28:13 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:28:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240815112508-mutt-send-email-mst@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
 <20240815112228-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815112228-mutt-send-email-mst@kernel.org>

On Thu, Aug 15, 2024 at 11:23:19AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 15, 2024 at 09:14:27AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [side note: the message I have been replying to at least when downloaded
> > from lore has two message-ids, one of them identical two a older
> > message, which is why this looks odd in the lore archives:
> > https://lore.kernel.org/all/20240511031404.30903-1-xuanzhuo@linux.alibaba.com/]
> 
> Sorry, could you clarify - which message has two message IDs?

Ouch. The one I sent had a bad message Id :(
Donnu how it happened, I guess I was mucking with it
manually and corrupted it. Really sorry.



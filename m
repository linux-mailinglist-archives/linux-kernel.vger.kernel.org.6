Return-Path: <linux-kernel+bounces-217540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A909A90B132
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC141F2418D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34141AB370;
	Mon, 17 Jun 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVoE/9pY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A51AAE20
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630840; cv=none; b=Vln7jD3f0JKVgdx3wsTQfHSLCJGtDYKficxn50Lq1cCK/0JPQC5nIuUpwQn+GGEJLCzUCf0eAxmia9LH31DadZ7mtBhjlOkay/AI1eMXtTx7nerC2m/EInmT6aZlyN6ZFHDMvJn9fYmnRuXdb+fllfVy0BshwJwUpkWFi7I5oDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630840; c=relaxed/simple;
	bh=BVnGMwoCZw7PxuD/QNYyTuQeJ5mFD9HFP2ibNF1eTeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3RHwy96q47+dxEegJ/xYpb0wznlihxzqHTIq1Jil8gsPwaHs3OACZb6UtAaR/NxsRSWJ1yTWO04yVsWi9lC6Dm03zoLNqymXGPmrESv1cPvqSPMAY5jifXvf4j7LCLC92BRR1s30fMyQtjMDZpnwgKrAVMe6Nm65QZ1rmOWCWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVoE/9pY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718630837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q84CXo0wUI7hBoP/Wd2wSAm0e9Fj0ilpl/ZCzDP0aQQ=;
	b=fVoE/9pYF/4QP5Y2SzVh5tCPk6w6WxxBx97pOkpPBHc7zKEJyvV/rcsH87Y/xPghD3Xmlf
	P/YW5Qt24JDxrVvGq4kIId+5hh3mUffgx6dqDRTq3ewdOAD0SyqvKY0BXNunOwqnOvzQ6n
	3eAkxw8B6Ebnog8vsWrit2h7iWVGIHM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-HpE1E4J2P3uBK9e5hHzm9A-1; Mon, 17 Jun 2024 09:27:15 -0400
X-MC-Unique: HpE1E4J2P3uBK9e5hHzm9A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c84d02b7fso3327589e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630833; x=1719235633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q84CXo0wUI7hBoP/Wd2wSAm0e9Fj0ilpl/ZCzDP0aQQ=;
        b=RlI3jKJR8bCOcknO+/DcxgXXAbxrEgIMuuyTSussaBEfLejR4r1VHgeLDbgxXW2a3m
         gNVfS6+Zg4V7tqOIfaaFYmexNSqSIq9PJjgj9zYNoEPI52jBywhpUBcdJ1tnVT6zRRq9
         MlV/cS0hsyTVKneqzwakgzCfaC2XY5za0CN8PnCB2MJIfgHLUiHbbUGgMH3j50bK/QA4
         B4fZkhcpDFb+Oeu+DRvF+29EdRRwteHo0/0MN1T0WzKKGBjC74/8SuUFCgxORGW11iRQ
         qRq2rOijC6h/hgisqz3J4nPfmTItdQLfCCvi+5n1WTABKupRJik/vYyrtqdlZU6E0MoQ
         bn1g==
X-Forwarded-Encrypted: i=1; AJvYcCWwvjynCoTHQybvR8aVnDfZQIhnoVa3C0Qk1YYW0o0alds/QpJQHUlS8p8DprXP+eMb3WZkohhV4Si8WFdCzy8COpVYYbPRuFvgKu9s
X-Gm-Message-State: AOJu0YzMetY8bBCMsFGm7eptUzH2KawsFo9Y2c48Sqr2fdw4TXK+eT/T
	VCZgZYy6fOq2NxaD2Og3Mi8RCcynN/fjDHjK2ixMhrLnSdDQU55D9mh1UVephH53hZs41BlR99a
	oUrTio1W7SsoipmFlajCzoRfIs3ipPOQ9Q1j9H9/THzsyT6+Q43uOjeqqKbgKIA==
X-Received: by 2002:a05:6512:20c6:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ca6e64378mr6296637e87.17.1718630833651;
        Mon, 17 Jun 2024 06:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpnKGZZT8Zk3aPPgtEsPpln7bsKIoo+bG+Ridg0DdcuVdy5+34CRZh9UkBKQn9c7obciZzKg==
X-Received: by 2002:a05:6512:20c6:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ca6e64378mr6296612e87.17.1718630833121;
        Mon, 17 Jun 2024 06:27:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509348esm11832788f8f.17.2024.06.17.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:27:12 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:27:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vringh: add MODULE_DESCRIPTION()
Message-ID: <20240617092653-mutt-send-email-mst@kernel.org>
References: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
 <7da04855-13a1-49f9-9336-424a9b6c6ad8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da04855-13a1-49f9-9336-424a9b6c6ad8@quicinc.com>

On Sat, Jun 15, 2024 at 02:50:11PM -0700, Jeff Johnson wrote:
> On 5/16/2024 6:57 PM, Jeff Johnson wrote:
> > Fix the allmodconfig 'make w=1' issue:
> > 
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
> > 
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >  drivers/vhost/vringh.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 7b8fd977f71c..73e153f9b449 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1614,4 +1614,5 @@ EXPORT_SYMBOL(vringh_need_notify_iotlb);
> >  
> >  #endif
> >  
> > +MODULE_DESCRIPTION("host side of a virtio ring");
> >  MODULE_LICENSE("GPL");
> > 
> > ---
> > base-commit: 7f094f0e3866f83ca705519b1e8f5a7d6ecce232
> > change-id: 20240516-md-vringh-c43803ae0ba4
> > 
> 
> Just following up to see if anything else is needed to pick this up.

I tagged this, will be in the next pull.

Thanks!



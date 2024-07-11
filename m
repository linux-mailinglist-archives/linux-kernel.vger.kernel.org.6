Return-Path: <linux-kernel+bounces-249769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CEE92EF95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325D31C22774
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C533A16EB63;
	Thu, 11 Jul 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWIMMYhS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266416DEC0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725791; cv=none; b=n9kHF8dlyHBftutTa/T2f3wDzpG3O9M4nyxO+JBoVp5N65pvdj+O/hYuL1TCRTGEY/r3II1m88ywA6bqX8+jVEVXxc7SyIcvMtqs86R/pzpmPf/elb9vxDa3UwEN5s3zpAFx5ebKQOYvo1u3Zg5LGAX1sX0SIwe1nF/T6lUysZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725791; c=relaxed/simple;
	bh=qd4JfM9C7XhNkDZ9MKhcRdWS74czpvCBniJo+nnNLbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1eaaDRGJHDbmFPd5WZ9e+jVkG0HDcXXXZq2wGG+mk3Gga3wePP6WSfmlJP6xWK5vQHsNM+9kIdrRLTLEca+z6DbQoD+xCRn4q0vIBzDcNKUf4aATuvqdaj96ioNIKvWU/J6HGXRXZrOroRzxuuk9Gy/5jsFIK3IQveBQssEpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWIMMYhS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720725788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qHMyJXBeRkRSNluth1L1mz9hL7fSL3Kwm56sBWnC+jg=;
	b=RWIMMYhSguuNKKyRAQGU4rnd2dE2YwIZRThP8rgyKRUTBp0adSCbeAhhlQ2PoDCvtngQpv
	4lDmuKTAxOObLarcp/ceTH0jlBCGMg4jn+lVqhSryVNAjxyAWglVFxVI94/2j0rDD7DvRO
	SHCdkpaf9IBNPIsRxxwafm6xn4hvm1s=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-iTj-XNOlPYeDMUz-KNWdcg-1; Thu, 11 Jul 2024 15:23:06 -0400
X-MC-Unique: iTj-XNOlPYeDMUz-KNWdcg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee8b7eafffso11831941fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725785; x=1721330585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHMyJXBeRkRSNluth1L1mz9hL7fSL3Kwm56sBWnC+jg=;
        b=rhRenNQUtfUfFCqi1FL2c8m95za/GXdwuC10WSRLjywRPYt2/KCHTK6Vda+M96SI2J
         Tz2xDQRigQW8w/xDWwqeH/OtrUlSuAGjJtZWJvLRUR5cIc93AiGDVYF2WVho1sfWsHrn
         Q+7dYvMqXqzks2kT8yiEDULW9DD2CoZOc3K7KoTmlEG9AsLmsI/4TLT6/YYbA83MyfgA
         a/SP3F/AyNSyzUM2W+S4gYfjh9Ee2Ac1H9oCAsKBc9Ao96A95WE8f2PmOuvG+ZSacWhY
         /pZg65DSIqTrXI7oHOTk2q3zqiI++ZIdJCOfkZEVC3rbN77A1afB9nOtsmx+snnZ3cU6
         +xpg==
X-Forwarded-Encrypted: i=1; AJvYcCXUm0gY27yWognAfyaOxM6ubJXJ0KJEsFNcg3Z+22EoEppruRhhDS78xFHsidbGhwxPSAeBpascbaPfL/denlfDF3K4WGm1EOl+eqQp
X-Gm-Message-State: AOJu0YycbBFdKxM4dTz94oaqIuvNAFeyjKCSncHWEF/4qf9mJaMVQtVh
	QNpbCRn84AKa4v9dRDTqpz21LXhERzmZ+OITk+YjbfTxfNeSXZJiEFsxPIi8g9vrRhzLfz+dTG1
	LuWoBbURP/6QHlwxcPPmiyAVQIjCHDbMgFcpHagFTiBC42iI7uNzDQtqzn5KoFyvfn6zDRg==
X-Received: by 2002:a2e:8691:0:b0:2ee:6a72:f006 with SMTP id 38308e7fff4ca-2eeb30e3ademr61595761fa.21.1720725784995;
        Thu, 11 Jul 2024 12:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlcdhPzF+B/x+wWIA8iNp5tqQGZgR9yQ+XfTnwuaunKMFe59pESZv2NmWVtBCYCvMz/J6DmQ==
X-Received: by 2002:a2e:8691:0:b0:2ee:6a72:f006 with SMTP id 38308e7fff4ca-2eeb30e3ademr61595591fa.21.1720725784330;
        Thu, 11 Jul 2024 12:23:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:2166:83a4:d566:a055:a5a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7362d9sm125253225e9.30.2024.07.11.12.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 12:23:03 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:22:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] virtio: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240711152235-mutt-send-email-mst@kernel.org>
References: <20240602-md-virtio_dma_buf-v1-1-ce602d47e257@quicinc.com>
 <ef8f00f2-210c-454e-a7f8-ab724a18bf96@quicinc.com>
 <b8b23dc1-7df6-489d-9638-db64a89c8a83@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b23dc1-7df6-489d-9638-db64a89c8a83@quicinc.com>

On Thu, Jul 11, 2024 at 11:43:18AM -0700, Jeff Johnson wrote:
> On 6/23/24 10:36, Jeff Johnson wrote:
> > On 6/2/2024 1:25 PM, Jeff Johnson wrote:
> > > make allmodconfig && make W=1 C=1 reports:
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_dma_buf.o
> > > 
> > > Add the missing invocation of the MODULE_DESCRIPTION() macro.
> > > 
> > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > ---
> > >   drivers/virtio/virtio_dma_buf.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> > > index 2521a75009c3..3034a2f605c8 100644
> > > --- a/drivers/virtio/virtio_dma_buf.c
> > > +++ b/drivers/virtio/virtio_dma_buf.c
> > > @@ -85,5 +85,6 @@ int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
> > >   }
> > >   EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
> > > +MODULE_DESCRIPTION("dma-bufs for virtio exported objects");
> > >   MODULE_LICENSE("GPL");
> > >   MODULE_IMPORT_NS(DMA_BUF);
> > > 
> > > ---
> > > base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
> > > change-id: 20240602-md-virtio_dma_buf-b3552ca6c5d5
> > > 
> > 
> > Following up to see if anything else is needed from me.
> > Hoping to see this in linux-next :)
> 
> I still don't see this in linux-next so following up to see if anything else
> is needed to get this merged. Adding Greg KH since he's signed off on this
> file before and he's taken quite a few of my cleanups through his trees.
> 
> I'm hoping to have all of these warnings fixed tree-wide in 6.11.
> 
> /jeff

not sure why I tag it and it gets cleared again.
tagged again hope it holds now.

-- 
MST



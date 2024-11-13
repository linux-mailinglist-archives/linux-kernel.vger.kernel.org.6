Return-Path: <linux-kernel+bounces-407842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D39C7596
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57721287410
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476C143736;
	Wed, 13 Nov 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4ukQDWx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF2757EB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510397; cv=none; b=bUd2muBcfHSLsGuNeB6a4eEJLJIcS0ksXa2UhOgUjL4Yg1+OQFwE4DFnr8VRHuFcCJdkbaezDlbr81NgrmCVvkBF21z8ohJfSTNzLFVLr/jjqYKomzj9TjwSGTis4vKWzZ4uHDWza1RcpYo1BEmeX/6tnKht2wpovQt27bD4Mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510397; c=relaxed/simple;
	bh=mpJgoK+KWuNIIegnc/x2H4Utp5hqy3HIkW65cX40Zx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5MD+2JUr2sAMXevxR0frLNdVXb/IKgoacBlhHrZejX21BPay68XlOLxZf3o0L6TREjzj5HuLn0uj/gnQZEYCNh5ArReSVlxibUcx30Bqa41Cn6jFd1zzZ3SpT8F5nGS9sOlzcTHRtvOBtblne5FVPmQNSJBRsfGzdSf/Yvkq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4ukQDWx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731510393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWLdOv3kD3hyDaciZE7jYJRmtPh0CooncSDI6Dayl5M=;
	b=P4ukQDWxkK/AJPitoTJP0Mk/Pcv3XlvmYPlOrsRuJ17dx0/+vycpeRDrOzxOqnoXrgink6
	hevJZvQVqZUUlwD/wMY1aLfq6qKVFOpxTXVV2zIaum5fyiF7ERHtUvvL8XYHoax132Vnfq
	Uq0Kl194PBxLKwXJVuAbn6BxJhsUg0A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-R2lZMt4CP0aLma7NnCS74A-1; Wed, 13 Nov 2024 10:06:32 -0500
X-MC-Unique: R2lZMt4CP0aLma7NnCS74A-1
X-Mimecast-MFC-AGG-ID: R2lZMt4CP0aLma7NnCS74A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso3809693f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510390; x=1732115190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWLdOv3kD3hyDaciZE7jYJRmtPh0CooncSDI6Dayl5M=;
        b=bGKlk3Ei4KD3iGW5exVc+wgGG6elgLDFVHRd7oqOqg36WRHj7la0bD64rVXfT1B0XR
         pFqwoqoxIbdhG6fnknWvELv9LA6rZR4BRiJuZr4IdaYpOrq59Vu2j2M2UimiU503FKV1
         m2uZr/n5+5BA+CHiAzAUEWGmmaclErUcYjRWd8UiizcITW0FwH4O051qF4fRmFOqqCX8
         JfUSbPbsItbUJpXNzvmLQ77wf07URn3SKe1FIY0WlsTp6WLxO/1FgPyHvny3r8W4sjV9
         xrNRcECvFQ85rBETnoS+ldKu/kL9EdFzzIdEmp1RiTGAFSn8FGo19AQEj5SPxvIdvizW
         ABoA==
X-Forwarded-Encrypted: i=1; AJvYcCVskvRMASRR5111+R7wFHGarZJyJgOGb8Jjx4l2CZAilIQPHr+bHMxp1juTgoCBp4WNmuKcoymti6N9R2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjKvhs57BUcxmfPTQBi3+DParPbe7Hk1RVd6ptR6pBUI+KMLi
	HrZhnDoGWsTYkbAcJLQE2BjAtuAmW+x1kFgVzU0zzsXhmIc75pwi9vuavmW7MbBZekKtY30xHD+
	qcAg2a+DbYkzqi6qSQpAIRv+sU8y+kDwLet8hCRGkLrh6F73gJGxswAYa7Zu8Pg==
X-Received: by 2002:a5d:588d:0:b0:37d:3bad:a50b with SMTP id ffacd0b85a97d-381f18855aamr18437798f8f.45.1731510389840;
        Wed, 13 Nov 2024 07:06:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR7SGrB4Fhm/j6pwU0uLR/0ukNIUrLvC+LHfK+NVU9lonHgPfDgfk60S9MS3/zsxXaiAHN+g==
X-Received: by 2002:a5d:588d:0:b0:37d:3bad:a50b with SMTP id ffacd0b85a97d-381f18855aamr18437760f8f.45.1731510389417;
        Wed, 13 Nov 2024 07:06:29 -0800 (PST)
Received: from redhat.com ([2.55.171.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99681csm19022148f8f.49.2024.11.13.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:06:28 -0800 (PST)
Date: Wed, 13 Nov 2024 10:06:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 2/2] vdpa/mlx5: Fix suboptimal range on iotlb
 iteration
Message-ID: <20241113100618-mutt-send-email-mst@kernel.org>
References: <20241021134040.975221-1-dtatulea@nvidia.com>
 <20241021134040.975221-3-dtatulea@nvidia.com>
 <20241113013149-mutt-send-email-mst@kernel.org>
 <195f8d81-36d8-4730-9911-5797f41c58ad@nvidia.com>
 <20241113094920-mutt-send-email-mst@kernel.org>
 <83e533ff-e7cc-41e3-8632-7c4e3f6af8b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e533ff-e7cc-41e3-8632-7c4e3f6af8b7@nvidia.com>

On Wed, Nov 13, 2024 at 04:01:05PM +0100, Dragos Tatulea wrote:
> 
> 
> On 13.11.24 15:49, Michael S. Tsirkin wrote:
> > On Wed, Nov 13, 2024 at 03:33:35PM +0100, Dragos Tatulea wrote:
> >>
> >>
> >> On 13.11.24 07:32, Michael S. Tsirkin wrote:
> >>> On Mon, Oct 21, 2024 at 04:40:40PM +0300, Dragos Tatulea wrote:
> >>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>>
> >>>> The starting iova address to iterate iotlb map entry within a range
> >>>> was set to an irrelevant value when passing to the itree_next()
> >>>> iterator, although luckily it doesn't affect the outcome of finding
> >>>> out the granule of the smallest iotlb map size. Fix the code to make
> >>>> it consistent with the following for-loop.
> >>>>
> >>>> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> >>>
> >>>
> >>> But the cover letter says "that's why it does not have a fixes tag".
> >>> Confused.
> >> Sorry about that. Patch is fine with fixes tag, I forgot to drop that
> >> part of the sentence from the cover letter.
> >>
> >> Let me know if I need to resend something.
> >>
> >> Thanks,
> >> Dragos
> > 
> > But why does it need the fixes tag? That one means "if you have
> > that hash, you need this patch". Pls do not abuse it for
> > optimizations.
> > 
> Well, it is a fix but it happens that the code around still works without
> this fix. I figured that it would be better to take it into older stable kernels
> just like the other one. But if you consider it an improvement I will send a v2
> without the Fixes tag.
> 
> Thanks,
> Dragos

No need.



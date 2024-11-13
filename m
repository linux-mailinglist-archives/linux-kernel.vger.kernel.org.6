Return-Path: <linux-kernel+bounces-407822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD09C74C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE4B282AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354A13B5AE;
	Wed, 13 Nov 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrmdHTvr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091923A0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509406; cv=none; b=Cd4i4Zt9S0remNd0XqAGEGlBciXqE9GoZEYGj0MrffGFZxQU7TJsnqO5j+MMJVAXK6h3e6B/B7EQCIg5JAkUxV9M6l6xooPxke9Bdy9bihUt4wrj8apnokPTM6Qsz8VohZSnqAq3rFtTesjplx/QNoOvS4udUczEKOu5HXVOaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509406; c=relaxed/simple;
	bh=F2V5lIDP4k54VyPQnx3tm95pRjfvhQH0+t+YIFhROXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZUcr9g+9KvXkF9dpP/Q214CuSC2zx7enQv06Teic07xsgQP1QN8Tz/zdvOAC0iSCw5eRDOM+E7mfEL4cCIMdxp4/vIxwxQAG5NuPHlzek+CjIhfwE2I/PhgzBlEvELYVzcPhUvWyhHOjtafUmw9cmt3n9HD0DQvtktd041QLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrmdHTvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731509404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpxWVmY9AA9sdaBT+FLe6ZwkY7JoCZPnsSDxJdlaOIA=;
	b=ZrmdHTvrg5hcohsxIDu0O1w0zhuowxohobfUtK/zYvipcbOlAfu1fXEJlwbFT4GwsMhSuq
	NMj/SbOOVgnWlGXkm9bwQBTxENR526e2az4ot1C/l+SpiQg5C0y7gAdOnLy7GRbMVqgCaI
	mpJQZ27jl/HRv4Fvz9C+Wj040cHY+b4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-XxBfO6eVPySTqvx-YwciSg-1; Wed, 13 Nov 2024 09:50:02 -0500
X-MC-Unique: XxBfO6eVPySTqvx-YwciSg-1
X-Mimecast-MFC-AGG-ID: XxBfO6eVPySTqvx-YwciSg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so4000276f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509401; x=1732114201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpxWVmY9AA9sdaBT+FLe6ZwkY7JoCZPnsSDxJdlaOIA=;
        b=vEhd0OD6FtXXmzkBkp4GyvslnEMoGRXhfIfvrkQa1JQQJGUogYrGkLBpfjd5momzVf
         R1WlpkGbVtZEiAQT6w94biV+ioSMoAM+STcuM8tdIbD9p/azu2wpnMclqf2LThS2+JAS
         aWnFFsBjq0xAKCeTLxOf8A0c4i2C+31OC/6WH8ljQRjt5la7BKQGb2FwMy7OQklqDZLV
         fmJRs4ZjpXLfNq5+43kndY1itCp4bYJYgUgTHfC9HRognvbYWIO5WYg/6gr4Vz1e6iOi
         9vIkGIZbIZVX9FQDoZ96Ephxxg/gTLg5tJgaxWTqDyJ3RmxKx4tF0XpTkCH/v/N4M3nb
         v6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhjoGJMQi5Lj5cld6Cey1AFUVxIV6Mu1P4O8joWTzWk9QHg6mSE6zSMX4YZaPWaHC6G7wJ0kzj0TT7gPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjRmJJVc9T1+1Url5SAz6PsWoZtdCRfK0JHbw1UrSyQaAiAKc
	je8CdqeHE0gpiKjSvBXx627CtrEXsfYtuN0Ova5QcHGI+4IMrV5Yg+zs4ZSg7oL8kVcfd6GC8HW
	qcooIWKld1BF7BrDOdDmILRd1LfnATyI/Iewm/8RblMv/nPKDr4Ie/1bdA3feEQ==
X-Received: by 2002:a05:6000:1ac6:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-3820df610a7mr2091463f8f.17.1731509401491;
        Wed, 13 Nov 2024 06:50:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/XkX2Eyjenwpa71zbx3wPsBlk1LKkpMGBXi84BvxwbrswsvZkqwBZ4ckZuWMD7vSuPV2lwA==
X-Received: by 2002:a05:6000:1ac6:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-3820df610a7mr2091441f8f.17.1731509401092;
        Wed, 13 Nov 2024 06:50:01 -0800 (PST)
Received: from redhat.com ([2.55.171.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea647sm18300658f8f.68.2024.11.13.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:50:00 -0800 (PST)
Date: Wed, 13 Nov 2024 09:49:56 -0500
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
Message-ID: <20241113094920-mutt-send-email-mst@kernel.org>
References: <20241021134040.975221-1-dtatulea@nvidia.com>
 <20241021134040.975221-3-dtatulea@nvidia.com>
 <20241113013149-mutt-send-email-mst@kernel.org>
 <195f8d81-36d8-4730-9911-5797f41c58ad@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195f8d81-36d8-4730-9911-5797f41c58ad@nvidia.com>

On Wed, Nov 13, 2024 at 03:33:35PM +0100, Dragos Tatulea wrote:
> 
> 
> On 13.11.24 07:32, Michael S. Tsirkin wrote:
> > On Mon, Oct 21, 2024 at 04:40:40PM +0300, Dragos Tatulea wrote:
> >> From: Si-Wei Liu <si-wei.liu@oracle.com>
> >>
> >> The starting iova address to iterate iotlb map entry within a range
> >> was set to an irrelevant value when passing to the itree_next()
> >> iterator, although luckily it doesn't affect the outcome of finding
> >> out the granule of the smallest iotlb map size. Fix the code to make
> >> it consistent with the following for-loop.
> >>
> >> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> > 
> > 
> > But the cover letter says "that's why it does not have a fixes tag".
> > Confused.
> Sorry about that. Patch is fine with fixes tag, I forgot to drop that
> part of the sentence from the cover letter.
> 
> Let me know if I need to resend something.
> 
> Thanks,
> Dragos

But why does it need the fixes tag? That one means "if you have
that hash, you need this patch". Pls do not abuse it for
optimizations.



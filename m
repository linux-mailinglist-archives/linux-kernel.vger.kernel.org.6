Return-Path: <linux-kernel+bounces-407139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555969C6952
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2260B25FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29D17DFE4;
	Wed, 13 Nov 2024 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esMKNkOw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494417C98C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479581; cv=none; b=U08uPxzibgYGTY1vQCw5ScDyCs+aYlsPYsDN5y+FM5tlQlphf4rxcfrYXmlmL+eEXIz1/A/6dIwWRD6yIYH+b/abtPfPaEPlC0Mweo59K55ZfhBZfwqfPdtBQkTm/mpDfHvxCJE/NZ1WmsjRb/ZoDdXy+FbJqnVZ4GobojpoxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479581; c=relaxed/simple;
	bh=Lw3nK/L1jm7SkFLesz8RoI/vr7mkD5mxfPU6EoBK83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb9nTAQqqv/eRFuACi96EEATHmMYU9aaJVFLDqr0BOOZNInPZXxZwKN8L+1efVOelBxnX7slNmlWJiPcR1B5L6lokh4uO6W0Xhg6JERIy3fSER5yRor0VMdjrMat3JQlM7Rh9ADvtVCNgxu2bpKrZt2effDSqyWn5PWoJGPoMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esMKNkOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731479579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rufpVhFdmb4VBRTafDBR2fxnE3o2Ggdk6Fw5zg77oVc=;
	b=esMKNkOwjry4rIOEhD59p7HbtG+nl0lhrHsdWdoj+XoI+ZXBkLc/vEmW51/rDaE0l5N3eO
	Tl1gwy7a0WAGVBH9B5+35m2kAHptdsX3gRcd6k4blpn1P3owkhsIwWimrlVptq/Ptzo1Dv
	IhTc8pSY8PfqwCutBPXF8v0iMEfaeGI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-yww_oKCqP8aXWTuAWb6YMw-1; Wed, 13 Nov 2024 01:32:53 -0500
X-MC-Unique: yww_oKCqP8aXWTuAWb6YMw-1
X-Mimecast-MFC-AGG-ID: yww_oKCqP8aXWTuAWb6YMw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so50872905e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479572; x=1732084372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rufpVhFdmb4VBRTafDBR2fxnE3o2Ggdk6Fw5zg77oVc=;
        b=kmlGe8xD4YAB9wqh8w64SjwB3HiJcSceMw9l3fcNQvOKV64H+v7Bu3NKOvRG76kF41
         z63RqcyjPgyrHCjlISHkBIh7eIbgTmWmI57wlhvWuIrs/M2xYUmIW2MPKpNYGpaIHzl8
         3z6rsn3t7oCsCSPfScj3I5Qouq3V8uACks9AB0Il8NDW8m6F11BEIHGljt85R5KiAQjE
         Rc/P7KbJANNWcoozH6mTamrpebOF/BUDrJPepgSUsV7LIVDbABnSrB5RGrLxM0jz8VGn
         3W6sUT/uiOYjB7KDPtZJ1Sxhf5vNWCIu6kNm+y2Sf62O3TJ7mHVT2K6z9I4Hi9Nzyes7
         xT5A==
X-Forwarded-Encrypted: i=1; AJvYcCVix0Kj1XJJfBDDnRgCjxtvhJe4ECvCxebW9lYzxDxF8YN7q1VJN18KHV0SrSpbYqqeQiK+zqvvbxkFtN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRP6lINmJylohT4SQiV0yKVSyq6A5roQxiRXHN0MEw1XcH1pVD
	ecaHFLJdD9zcR1AavOrHlXiV/caqtUEvQgJanZlmVMLaNAqFYdvKfGUD70a4egeXtr/FO7/QQsb
	dHRSCZY7my8sQM29Xh2XkRjtmKTDN8OYtO4rMhQa2grR9iRGHo4VAQ7QQ8jLhLQ==
X-Received: by 2002:a05:600c:5124:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-432b74faa3bmr153588325e9.6.1731479572324;
        Tue, 12 Nov 2024 22:32:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvSivPbOF1a3z2KjRJHfbTayaTS2MPjyFeMmHN0IJchZdRUqbmt8NJD00TQs1TXCkMviDiyA==
X-Received: by 2002:a05:600c:5124:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-432b74faa3bmr153588185e9.6.1731479571999;
        Tue, 12 Nov 2024 22:32:51 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5541832sm12580005e9.30.2024.11.12.22.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 22:32:51 -0800 (PST)
Date: Wed, 13 Nov 2024 01:32:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, virtualization@lists.linux.dev,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/2] vdpa/mlx5: Iova mapping related fixes
Message-ID: <20241113013105-mutt-send-email-mst@kernel.org>
References: <20241021134040.975221-1-dtatulea@nvidia.com>
 <8e93cd9e-7237-4863-a5a7-a6561d5ca015@nvidia.com>
 <CACGkMEtALWqmoyOBu8vywnk=SuU=N1zKt7sxwueKkYQi3LB0MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtALWqmoyOBu8vywnk=SuU=N1zKt7sxwueKkYQi3LB0MQ@mail.gmail.com>

On Wed, Nov 13, 2024 at 09:45:22AM +0800, Jason Wang wrote:
> On Mon, Nov 11, 2024 at 4:58 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> >
> >
> > On 21.10.24 15:40, Dragos Tatulea wrote:
> > > Here are 2 fixes from Si-Wei:
> > > - The first one is an important fix that has to be applied as far
> > >   back as possible (hence CC'ing linux-stable).
> > > - The second is more of an improvement. That's why it doesn't have the
> > >   Fixes tag.
> > >
> > > I'd like to thank Si-Wei for the effort of finding and fixing these
> > > issues. Especially the first issue which was very well hidden and
> > > was there since day 1.
> > >
> > > Si-Wei Liu (2):
> > >   vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
> > >   vdpa/mlx5: Fix suboptimal range on iotlb iteration
> > >
> > >  drivers/vdpa/mlx5/core/mr.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > Gentle nudge for a review. The bug fixed by the first patch is a very
> > serious and insidious one.
> 
> I think I've acked to those patches, have you received that?
> 
> Thanks

I saw your acks Jason, thanks!
Patch 1 is now upstream. Patch 2 is queued but I asked a question about
it.


> >
> > Thanks,
> > Dragos
> >
> >



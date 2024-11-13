Return-Path: <linux-kernel+bounces-406971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54A9C66DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE811F25788
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B761FD8;
	Wed, 13 Nov 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFQQflXR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83F22092
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731462345; cv=none; b=lsu//asWb6INfaSNNrX/qSDcj+RlaIBuXu+XY5QVn3dxAELPU7HjtvH0he3QkEXt2SBPyYE+6h+2cgTfBKSvMBZPCxHn+R4840+dMjuqiCmlO2mxve9tbHbWB233RgXLfMAtd+DbsXfDx61HVBMRnnjXfILYEZxDf4Ot3sAAves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731462345; c=relaxed/simple;
	bh=IHqK+x1Y09bwvF/XCMLoniBLajGJIlrCvJ2pbrpso1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BR9QuJ4QK/dMOpx229y8fb3Plczqiqe9W1aC3ClJj00WVKXPXKj90fByuT5t8mg6Pgpjn2qkKqnzka3+MyOL1iS1F0ZE94KGM6rJn67FTJI/G148FgoKhRW4BEPg6xkN1UF2XAUfEBvGDo1fTFBpNOlXEwSLpGD2pXH7Jq7/+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFQQflXR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731462343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4PfKM7yVBtn6DsluopLq3/TSPiAd2245iTdr55Tku6s=;
	b=fFQQflXRk0v2WJYFgEzSwNYVRvc2rPmsD8K5CWiq9Szi6JoW+r1lmFPjJj8U6Bsz+3JqR6
	u/nw9AIYgt0Xz2rvneIa9/RhkivzhIayzr1oedChQQqQ90Zu4RY9IemLoyPKOcKDQ4Vbx0
	k/cN6+foxCOf2itYy9DcFMj6acw4VH0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670--0M8u1WDPPSPtcxO-Xs7XQ-1; Tue, 12 Nov 2024 20:45:37 -0500
X-MC-Unique: -0M8u1WDPPSPtcxO-Xs7XQ-1
X-Mimecast-MFC-AGG-ID: -0M8u1WDPPSPtcxO-Xs7XQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e9b2437b19so6028075a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731462336; x=1732067136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PfKM7yVBtn6DsluopLq3/TSPiAd2245iTdr55Tku6s=;
        b=AjsGmZCECRgobQ8arZxQkh7MwfWZZSQtB7+pffNmlVLceRqu2Iimc88LV1XWRDN/oa
         Wnydqh/yXdCkrTXYqSH5ZN3lqZvoFjT/9v/SvXP9vIV/2sNRnyPz5C2Oc35B1LEFTU99
         thXW+Q+tRZ+qXSMc6Z/d3qSnhezv0ETf6Wtm4JlZLMZzHK/Otj/mHQmrdKzxCJkGhZ5A
         9WMkRlIVXnQ0oA7qGMAd6FFdqiJgqhzchni7zDoHlIQl45x5IEhzLjBiZfdR2ZY/kDTh
         i59TPNLaIK0OjpEWj582GxsgN4BrRCrEwlJq62nx8BCpMVrJ/6MYts3Asd4k6DLQSaXq
         LXjg==
X-Forwarded-Encrypted: i=1; AJvYcCUkJSoglXBMgce/Xk3+Wi00t90K9UCPdGDtuYhwxFEaiMi6ZcdYs+DREjRerdxq+SCfVhhOqAWuQDo0nbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySlLuhyoRma1u8q7ZY3SA1kOREdcQZkO5TF4towQtg0rpFL7+v
	I1JIMx2he7RsJ3cXdmH/5Cnqwn2HqMjxXmJbuQdF7WXbCXVqVi35Yg8x4cQFqFl9rrV5afING/i
	g40jmJXPDfDOXotBHAgI4xNF1Trz6Onynz7NLCX8Q9/0Qaf6nZq8+rJ4LHwyGTj8SNnTELr6zcm
	ue39ly+D8mZwcGnpNldZoBLL6hPPL82e1cW0H0
X-Received: by 2002:a17:90b:2688:b0:2e2:cd80:4d44 with SMTP id 98e67ed59e1d1-2e9f2d5e8e7mr1164935a91.28.1731462336100;
        Tue, 12 Nov 2024 17:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpt28y46cAkPewPR7Xrwmv966EDN/L2ttyudwenZUFGZgN49d7cCsAg3yPz/0wpucLUNN5z0msD0DruQuHYlQ=
X-Received: by 2002:a17:90b:2688:b0:2e2:cd80:4d44 with SMTP id
 98e67ed59e1d1-2e9f2d5e8e7mr1164913a91.28.1731462335659; Tue, 12 Nov 2024
 17:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021134040.975221-1-dtatulea@nvidia.com> <8e93cd9e-7237-4863-a5a7-a6561d5ca015@nvidia.com>
In-Reply-To: <8e93cd9e-7237-4863-a5a7-a6561d5ca015@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Nov 2024 09:45:22 +0800
Message-ID: <CACGkMEtALWqmoyOBu8vywnk=SuU=N1zKt7sxwueKkYQi3LB0MQ@mail.gmail.com>
Subject: Re: [PATCH vhost 0/2] vdpa/mlx5: Iova mapping related fixes
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:58=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 21.10.24 15:40, Dragos Tatulea wrote:
> > Here are 2 fixes from Si-Wei:
> > - The first one is an important fix that has to be applied as far
> >   back as possible (hence CC'ing linux-stable).
> > - The second is more of an improvement. That's why it doesn't have the
> >   Fixes tag.
> >
> > I'd like to thank Si-Wei for the effort of finding and fixing these
> > issues. Especially the first issue which was very well hidden and
> > was there since day 1.
> >
> > Si-Wei Liu (2):
> >   vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
> >   vdpa/mlx5: Fix suboptimal range on iotlb iteration
> >
> >  drivers/vdpa/mlx5/core/mr.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> Gentle nudge for a review. The bug fixed by the first patch is a very
> serious and insidious one.

I think I've acked to those patches, have you received that?

Thanks

>
> Thanks,
> Dragos
>
>



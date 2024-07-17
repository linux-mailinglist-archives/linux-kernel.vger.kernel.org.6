Return-Path: <linux-kernel+bounces-254718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D899336CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F81283565
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203612B6C;
	Wed, 17 Jul 2024 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4Mv3s00"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE613AF2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197231; cv=none; b=cTH6g3icDx5zd/u0lryoOUlW+cc5ZdWHsKrRRGL2KEOId+fGU/HO2wg0p6vnfNzDX7RJm8DJ22OJjW0jbXJXYnUB81JTEQfooZrweIycTRXjDx36ygx4WkHuSgkQ7kBtKvsFlOxQdUKIrAwVagkjO9Heedhzv4fxaudopxXeTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197231; c=relaxed/simple;
	bh=fuYYqKnWe21P7S90TuWyp9Xh/ju0Zz5vCdGWuHFaPkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfC3oOvb5Z8qoV5zH85TZwIQQTemav5kXJkmMx2I0u2TzhFMwM3f7L3u8+Iga8rwLjy3pnDqcvkiMIOMkhOdGdY2J06iToA/r53wQPvm1ePMySwB+O1fF9LTxBfRy2X4XG/NaT34ZHkgpsWpQnYU7o+BCIzc9c6yilz8Qkenmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4Mv3s00; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7035b717880so269122a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721197228; x=1721802028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eUk5AKTa+NgE29BVsgda2YODyyZi8Y6LkI23EVs0Pzk=;
        b=N4Mv3s00iZgfs6XXY2NAYoUFb8ET5qyybAcqSm6s44Wo0pJCR5hU+xnRij86ef7nb1
         bLtu7uPtrvKWPyCqV+qhFRT5lZDszxybdn7KHlMA6KsMZmgPy+eb5f6rkqCUtzSaEiBS
         dvN0AleUPFBo+DrAZwBIB1N2XGVbHjqpNt52naMuYnvQS1koK9LAqAa140vN5JQljdI6
         05O7TjUcSQMuIaI+9K+SqTbNRszrQsF3+grGuPKPVOM7xjhYYhHzck5FH0+bj4o/Y5Mr
         cmCTKKPltnwdDdFQfphclS5af3RyvUog95aVYtjYVJ9fD+0iG+SXo1Wlo/wfsDAg6Her
         H1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197228; x=1721802028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUk5AKTa+NgE29BVsgda2YODyyZi8Y6LkI23EVs0Pzk=;
        b=pKLrt+eUwtL3wQwkOUoOpPS6ROuPj6mh9/VohCVJCakg7ZhrDQNUj+55XWlnRnpcU6
         y1lhgVmJz8AQ0V4FCQxHYu3WzinGHyTySx2tvQn2SZ+YBxr9nNv4UQgE30/9htufpR0G
         tyBf0s4KhTweamxcW8WlluqHLz753WmFqbnUJtPkpw+dhgj0b9y6zvGMb1U7jNWliw0m
         pBrp73YLEPdGd7RunToY5wVdlaiZo2+fzRJhwwym0qSy98hfMNjC+w6jdmDfAbthuEq6
         lcQbaWIQC/Ji+83SnfPn9rIxOiU5XGoT0g5Y8giPMAntyIdkxYKrkkfjwZBF9vlrLLaP
         DoZA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ58lRPQT3hinDf9gXKY9ULg+tzF1k6X7279Zmt7XDJQGm+z2Sk9xxeE0RgJNVWsezAvbHq55IRcyniJOCJZh9JiTb9zAr06c3mZK2
X-Gm-Message-State: AOJu0YxX85jD4abG0elHph1FKTJbo9pxGW/j2hU5j6x2Umr7kYNLTN0G
	m1x8EbjBkNMz+yonDeOdFHPoe51Fb/xtLlZT2iTtvvQHrAnUgr/Z6gW3FyRZ5NwuErgJVWXLOOY
	Oga13mD93K5Cuojxg7arCu1hGmtQ=
X-Google-Smtp-Source: AGHT+IG8KWkl0N2UQKmtfWWcWEy/a800FkbA04TPkcjdkKhaQV/8fG76CRxtJXD9yF2rJJ3JdkTlpU7tKyR92wkfWVI=
X-Received: by 2002:a05:6870:d38a:b0:258:3455:4b2f with SMTP id
 586e51a60fabf-260d8b06f9dmr354259fac.17.1721197228357; Tue, 16 Jul 2024
 23:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 17 Jul 2024 14:19:51 +0800
Message-ID: <CAAfSe-s-x0igV_Zoz=sCXjBByjR49pxGcAQnkZEFobjOCGuVDA@mail.gmail.com>
Subject: Re: [PATCH] iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 20:55, Artem Chernyshev
<artem.chernyshev@red-soft.ru> wrote:
>
> In sprd_iommu_cleanup() before calling function sprd_iommu_hw_en()
> dom->sdev is equal to NULL, which leads to null dereference.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 9afea57384d4 ("iommu/sprd: Release dma buffer to avoid memory leak")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Thanks for fixing this.

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/iommu/sprd-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index ba53571a8239..a2f4ffe6d949 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -232,8 +232,8 @@ static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
>
>         pgt_size = sprd_iommu_pgt_size(&dom->domain);
>         dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
> -       dom->sdev = NULL;
>         sprd_iommu_hw_en(dom->sdev, false);
> +       dom->sdev = NULL;
>  }
>
>  static void sprd_iommu_domain_free(struct iommu_domain *domain)
> --
> 2.44.0
>


Return-Path: <linux-kernel+bounces-287715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B715952BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54D21F2218F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19F1A00DE;
	Thu, 15 Aug 2024 09:08:52 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B61BD004
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712931; cv=none; b=HTGruuEEmfz0ad/+JoNKrQL3CHE+yyk71SRliS0+viAEQSlk76z64Mp6AdoqZ93iQIZxiHLlhQo7S/srTZE106+NkZ9XTlJ69jLxHw5GxDi0Zj/0UTnSOYUTJoD2TxxbPt2eOasPgHCUBdjau+4eWMn4SzVwE4mqFjGq16UAVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712931; c=relaxed/simple;
	bh=SN6j3WE2UIAXJsoHn44NG3GR7SAk5QMcbc6Aa+bYvGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJoNShdUX0t44ybgc/bhB3TYjU2ISu5Caemnd7EgOgR3HSjGvyXCy4IouHIg+kdNQ3vKJH40LqvzIeDpG8203mVB53W3wO0k7CS+eRwVVRhQTqn0m9GqITDP30egt9WtZvyrxntLGXq5H0gPGAV1t1RFE+63h2AJIQ152zOKhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f51af903a7so970489e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723712929; x=1724317729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/CWSZADW7omRwvwkV+hlyqW09yOSDatZ1zvdznqBXU=;
        b=XUbwp765cFP9jgiYygmhk5UCafF3zlP/oV5TGgaoRhKMrIDzBeiOnPAVgFs+huyvzB
         A/lVveRkOEdYNNvFzXrYn2heNn/PkoHCS1usJUTgj5wsjTW4hhJemYIhXR2AotBS1Et3
         u6OSLrzkRfCjOBF9Hc3WA+3t3+zTAniJ7opo5uSC44l5BNjmbFd3e30mUqAz9lMNWTbi
         mZTtfOHa9X1+fo3jiCSnsCS9xhIo/ddCWPpK8fB+/yWUnMNMoApxTdExcyNV1ITh6GnD
         LAS5wYbprDgyx0PLB9hlCi5gpEdL2JALQy6X1qRFyjfhFTZ9jtPp5/0REGHLceyskfg1
         W9dw==
X-Forwarded-Encrypted: i=1; AJvYcCURRSMFIFIlnzcf8nf32FEpvmR440aZYv2khaVV7tuPbKdxwZt9eE5wbwAdsBL9x/DglUrMxzUDsfWd0nbNAd4dDVxvC+F3KhxXJhO3
X-Gm-Message-State: AOJu0Yy6Mr3UgnAdcUYTjbv0UHqc3/AVfF5l6ZpD5dWqqtS0VXjzfbbk
	PZzVRUjPHiMruXAWx2Fhn5EP4lapialQZy3tQp7BjmCakK0zjEzPUcGp34cdUqOYw5mAogZxa8i
	+f5s91QN2treVZllns4AtLle6zJU=
X-Google-Smtp-Source: AGHT+IFVeizXgqiVB5P/hEFZcZD8zza5iMWyBiL9JKz+y/KneaKvIPZ5gjCboLcOGrAFJOsPtfNFH/PmhdDGPueiDrc=
X-Received: by 2002:a05:6122:3b0c:b0:4da:ae51:b755 with SMTP id
 71dfb90a1353d-4fc59083be3mr1359519e0c.3.1723712928905; Thu, 15 Aug 2024
 02:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815082508.15722-1-yangyicong@huawei.com>
In-Reply-To: <20240815082508.15722-1-yangyicong@huawei.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 15 Aug 2024 17:08:35 +0800
Message-ID: <CAGsJ_4yeA0oyezky=QbkpoV9+xK04tRygp4S5S1V3nPZ5+Zbzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the maintainer of dma mapping benchmark
To: Yicong Yang <yangyicong@huawei.com>
Cc: chenxiang66@hisilicon.com, hch@lst.de, linux-kernel@vger.kernel.org, 
	prime.zeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:31=E2=80=AFPM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Xiang will no longer focus on this and I'll continue to take care
> of this benchmark tool. So update the information.
>
> Cc: Xiang Chen <chenxiang66@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---

Acked-by: Barry Song <baohua@kernel.org>

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f328373463b0..c0976c375f0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6625,7 +6625,7 @@ F:        include/linux/dmaengine.h
>  F:     include/linux/of_dma.h
>
>  DMA MAPPING BENCHMARK
> -M:     Xiang Chen <chenxiang66@hisilicon.com>
> +M:     Yicong Yang <yangyicong@hisilicon.com>
>  L:     iommu@lists.linux.dev
>  F:     kernel/dma/map_benchmark.c
>  F:     tools/testing/selftests/dma/
> --
> 2.24.0
>


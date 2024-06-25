Return-Path: <linux-kernel+bounces-228646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BE916428
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD911C22415
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4968A14A617;
	Tue, 25 Jun 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vy+NdduB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED91465A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309253; cv=none; b=RSYU0WfLbR4oZAhRjczgELAaGSJ+ePAjXTl0ZkdgQUMg/wQ6CqQQHQT/yZScOCxjUPDc+nyBOWZoLcOxzB/PbQ+I7m3GiUd5H1+J1/iBruB+7LePjrlmZ4HEDL3JzsJ3uhjMF5olDcqMqGUrWyxTdO1+zGgOi8gwmnDwZmn0iHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309253; c=relaxed/simple;
	bh=vCZknvWy4gZ+0EG4By1EfCHN6bgG2+2IALEZDL9WTVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP0qOiYGkk/uYwgjsTJdeWXMI20gMOpvZyxktf8EG2k8OVgSKYlCmzuFv2FjfAtpmbIrKpySbnDGSTzT/bP9bdsM1R3S0G9Hq6kn52uKoNxCon046tjqq771impV/nT+ToJ49YhipweMgiruSDdAbUhZu2nSkDFcVXfMY5dUlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vy+NdduB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a725d756d41so239388066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719309250; x=1719914050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeDhT7EoWv2TdoSvGYalLiHtwKn/aqX3ezTK+oGJl0I=;
        b=vy+NdduBHLIE5sqQ8E7W8zCNIyWUHpo3upCyEYtx0MU5AVlgHUWlucmrC9L50JO65E
         5bbu2VwmnCAHONPOIr2FGMAdKh/Ja89sqsXnhUrMw2ly8s0frtmL0lr0BHrB4DPMiLeW
         a1269YoWyGlSRw+sud+iyktSxIHF4IM51UVtZjZD14HLb7UGWs5VkxUWGP7u63T/9twK
         NWqM3+Qszp2/GmdG+G6hcaKALdkuP1re/rsUT+7fhVEZ4EqB44tK7vfedFVo8gvm12LK
         2nNjD0haXqECJp9ZUv98q4RWrG1M/nmQ+JvbfDctbrfkDVR9z6k/APOeNwmPJsA8Z2v+
         RipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309250; x=1719914050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeDhT7EoWv2TdoSvGYalLiHtwKn/aqX3ezTK+oGJl0I=;
        b=DOu5NB+cX8kbSPnuJ5I1CfxkqrYcky4LHEfphvAJhhkyxg1QyykSceUrkCPa8YSh77
         MDkhoBZPN64tPVqb6oc4Fp1q+tKjSzHkc3fYglBCbSZL+Z7clS5z4tbansmT5GEqzEJS
         2VIQAbWKhFvwf2WnqSVFONYShxIdpCmlMJVqWnBhKOtfDZxKx4DIukM5NEU8dE+iBRoz
         zP0BAFzWdeolQqSKbko89VV5FC7DY+OzrVfbkQ0jdj2BCVfpZEREMX+OJYSJ9PfUb9gt
         RGBjsctjfwwoWAWlaEqsDBpZF0QpEmjpdJRDJd8/zf/4JvJTrpYwo495YEqoTXBOMQ+Q
         kQBw==
X-Forwarded-Encrypted: i=1; AJvYcCVc5OcXpgpVvr2kdJ7ikMvyG8cH9wUIMI8EChGoiON9KkXySvKtcXW/ePBpZjbYi8DQKSbYsdC6jx0nUA5yRILqGR2DQtzZLbXkSFxo
X-Gm-Message-State: AOJu0YwUhZ+OyLFqkMIyE/tIb+7lBJMUpJ82WecqDdTDgf77Oly3mk/f
	xcYCLa1aGIWYUA8B8sY/6xe8aU8aX05E8o35hu2ZUn34Ww7NdXM4vjSTPOE7bWd+bd69OuA49w6
	5flKf0K/7/BZZRfkB1JfKNQ0H5hOuhU7B7d9L
X-Google-Smtp-Source: AGHT+IGQr3gDvpr8JF7pmHZzOzdkUDy6Ofz3HL4FcKxDHJdY48KE95RHXANN2CuKb0IZFWJK6QYmk9mXx8vyBQulAKk=
X-Received: by 2002:a17:906:3593:b0:a6f:b352:a74b with SMTP id
 a640c23a62f3a-a700e7334d5mr575850466b.38.1719309249848; Tue, 25 Jun 2024
 02:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625-zsmalloc-lock-mm-everything-v3-0-ad941699cb61@linux.dev> <20240625-zsmalloc-lock-mm-everything-v3-2-ad941699cb61@linux.dev>
In-Reply-To: <20240625-zsmalloc-lock-mm-everything-v3-2-ad941699cb61@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 02:53:33 -0700
Message-ID: <CAJD7tkZD82pVHBV68DoMXsrjfT8ntiwZ5Oe91LpOc2dhy9G3nA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/zswap: use only one pool in zswap
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yu Zhao <yuzhao@google.com>, 
	Takero Funaki <flintglass@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 9:40=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> Zswap uses 32 pools to workaround the locking scalability problem in
> zswap backends (mainly zsmalloc nowadays), which brings its own problems
> like memory waste and more memory fragmentation.
>
> Testing results show that we can have near performance with only one
> pool in zswap after changing zsmalloc to use per-size_class lock instead
> of pool spinlock.
>
> Testing kernel build (make bzImage -j32) on tmpfs with memory.max=3D1GB,
> and zswap shrinker enabled with 10GB swapfile on ext4.
>
>                                 real    user    sys
> 6.10.0-rc3                      138.18  1241.38 1452.73
> 6.10.0-rc3-onepool              149.45  1240.45 1844.69
> 6.10.0-rc3-onepool-perclass     138.23  1242.37 1469.71
>
> And do the same testing using zbud, which shows a little worse performanc=
e
> as expected since we don't do any locking optimization for zbud. I think
> it's acceptable since zsmalloc became a lot more popular than other
> backends, and we may want to support only zsmalloc in the future.
>
>                                 real    user    sys
> 6.10.0-rc3-zbud                 138.23  1239.58 1430.09
> 6.10.0-rc3-onepool-zbud         139.64  1241.37 1516.59
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Acked-by: Yosry Ahmed <yosryahmed@google.com>


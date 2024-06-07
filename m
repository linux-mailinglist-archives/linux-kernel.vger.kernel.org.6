Return-Path: <linux-kernel+bounces-205721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17608FFF62
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A26FB23A54
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DC15B980;
	Fri,  7 Jun 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW2gcdnR"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744615B577
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752376; cv=none; b=hr7t4J4lnuMjhQ+sOvxi1rPpFOBqDjNsvnXcvYoyPygYUw6HFHJju3PWFpgPSPz6N+7XIDfi82PRbu5EHk5KJ0EHIbkFbI5uFzweErI2CGQU5/dWF58ffL2cDwTHFiOQo5OynQDlq9oQasSbwPucup8RkhClueoMcvdLMYx7eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752376; c=relaxed/simple;
	bh=qiQBad0hXLeHHqlaTx1LR++dN0H67gnsXnKq8sMaJPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwPma2KM0HIG+7YMuMYHucQGe9bdPMfzjhKYvam0SQlcwrhISEfm90S0xjqb0CDniqXi7k044lT+RIhSlqIC+N1WYYJh3CUq2lesoc58M4G8VXCOEfHrE1HsQKjrSLNkYcL+kVtCbxestpAhqLRkXhJC7inWuErr54zUi/lUnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW2gcdnR; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so10210986d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717752373; x=1718357173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIozoC5nwYY7upU/SpQMJJZkDEb64YetkVQTfRBe02U=;
        b=fW2gcdnRyOTMiRMu2xTQTx3zXV/aWzxmEvoIax/yZskf1xo6BME6MUA0TtoixkAxbW
         ote8VkpJdG9AWVQLDW+j3P9vXs0ykyldAR4YbC8YxAmj6rn7KBqlNhHCgulwHtRPff65
         Lc0Mj63xRTjRr2tSHLznxW71+sXFc6fXprJppI3hQ7dbBMBSxW5fYGipJCCcfcXnIJIc
         R2W3n2YgH37C58uwUUX/zJXgohnbTEM21uBKxG5r2qPEvtp9QJcNP9a3fNvijkt/Ciez
         K5ZoaPBy7kf+QDB7r543uapzynYQx/AStrvNpCpexCNHjd18aLTt1cBAJxtQKYgrfjc+
         MdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752373; x=1718357173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIozoC5nwYY7upU/SpQMJJZkDEb64YetkVQTfRBe02U=;
        b=HBvsCp/xsj8U2TlqaKz52eXSQyy/ABs7Lxl3PPJJVLSK8GNgQfUhBWQIW8bgYRDNgz
         168vMJPdn7FkVoDmiXe+PSuNkCYEk852KIcrV4Bck2hdnq3CaVXsai17ZWL5Z9YDeRu8
         1rCV0z4nzxLSWO08sTAnY+93tgqyrqxL8VoMkzAUEVQ1L1GrTgfdDDeHhH77cUHUCTcY
         qhe70U2TASyLa4IVWzhz5pO1ToQ0fZEQQgELPOyM77Najc48lU5kx8xzVQCnhLFenKJ6
         KlPOFjx6xpZ/89LJrEk7CDAF69StLtaM9iVu/iBjBkcwqO3q9yCuHrmWGhhtF5U1IJ8S
         6lpg==
X-Forwarded-Encrypted: i=1; AJvYcCW+S904Gzs69RbIcPD5tlhhHYVgAY/i/Iqz2p3x5haDBE8TYVKeATZU3eH8wZ+0605uXXOec8sHRFtor6h2OqQNeH0jj8woxv6JR/Zq
X-Gm-Message-State: AOJu0YyVU779zJZ38UJNg+ffdp+ib602SfD1/72rT1gHRQKk7rV9YMgY
	3R4d2iRwrRwX9saP2LqUtETnjV0CNYVtk+sxnP3wKuKMRtc1LlIwAX8l/0Bszsu5yGRVso+VLrT
	gD+6RE01HZbFkPeFVDbeAQV19pAc=
X-Google-Smtp-Source: AGHT+IF7DzPWIdcQI0xDVXGNgiqETlF0CcM6aC1lJ7ACKSiX8Eh1ei7x7iwd4JliMYzB+ZO5Z7jLHgHu+ersMMXDcQ0=
X-Received: by 2002:a05:6214:3d9d:b0:6af:c66a:d5a8 with SMTP id
 6a1803df08f44-6b059f65400mr21667096d6.51.1717752373411; Fri, 07 Jun 2024
 02:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606165303.431215-1-flintglass@gmail.com>
In-Reply-To: <20240606165303.431215-1-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 7 Jun 2024 10:26:02 +0100
Message-ID: <CAKEwX=PBcxsCK+qRvsPLRnDobttzm75YuS6Js7Y4R1MKSf_RxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: limit number of zpools based on CPU and RAM
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:53=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch limits the number of zpools used by zswap on smaller systems.
>
> Currently, zswap allocates 32 pools unconditionally. This was
> implemented to reduce contention on per-zpool locks. However, it incurs
> allocation overhead by distributing pages across pools, wasting memory
> on systems with fewer CPUs and less RAM.
>
> This patch allocates approximately 2*CPU zpools, with a minimum of 1
> zpool for single-CPU systems and up to 32 zpools for systems with 16 or
> more CPUs.  This number is sufficient to keep the probability of
> busy-waiting by a thread under 40%. The upper limit of 32 zpools remains
> unchanged.
>
> For memory, it limits to 1 zpool per 60MB of memory for the 20% default
> max pool size limit, assuming the best case with no fragmentation in
> zspages. It expects 90% pool usage for zsmalloc.
>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---

I think this needs benchmarking. Theoretical justification is nice,
but I'm not convinced it'll translate neatly to the messy world of
real life systems.


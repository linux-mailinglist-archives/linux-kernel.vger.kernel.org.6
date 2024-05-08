Return-Path: <linux-kernel+bounces-173719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E578C048B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76544B237B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77A84A34;
	Wed,  8 May 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiqabZC+"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39A1E532
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193724; cv=none; b=s1Mag6tzLzzhHRMzgyGegMRJcxbPzOjGKr0NGEnyhJSFIYcYiUJ8v43zG7oXMXhl58ge2RlUVk2896Q5+peQyjgf8BmSr/YJW32J7s9N9/ya8RBWy6Omb/JK+743J55muic3oNOFjhjDwPLkzaz8YGeu4dxSxqNm/5GmCPKXIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193724; c=relaxed/simple;
	bh=vFdPFF0dNrD43OCn1kFg4dcxXm80CX72R0QLEvmoDpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCp4cfr0A76YUiBBZEYj/o2n3CLGhEWRq8VfvevZ6JlHeIZZ8e8bwPaMjbpF4ye/st4+FfopfoU50n22CMj6aicoTU+UE8I0XnvNQRTp1CgV5DlfTc71PxfdccvUbbHuD8sY36zykTeE3G59kFjlqgEf33bW8nlt6HzND8Kh/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiqabZC+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b514d3cf4so1193176d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715193721; x=1715798521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOhbrZERCeHf78/czfGhCxYJwykoBE5pBt7dFK07oas=;
        b=KiqabZC+IpbKPCKFu1O4U7J/mSbs+u/CYRwEVhadw7mtkpcUgnDN+nousjD3FN+dk6
         hsQUSO1wU/ih0hwV2kSjV7yCwLsunE5x7+0xjZLRLdjQzboz8rZAVIY2QV64xZfuExgY
         /02rKAQ8nPDVEVp4fKNmrkFGy7LPwUHvxT3pLbsojtFywnUO25BHV3Eo9fBU1EwKEjrF
         GWriFLf/VnZY0QB0J+BGguoA1B9aK///XLrtPqH5nPXqsE2ACLe83a/IU+G+X/DfqTCn
         nCHlNobowZGpt0AD66sjTuJwndzHMPtrSudfaLO/DyWzBZjnGFroe3HHEwk/nO79sPi2
         lHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715193721; x=1715798521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOhbrZERCeHf78/czfGhCxYJwykoBE5pBt7dFK07oas=;
        b=pC5WLg0wPh/EfBDrEziTdcH59D7P6UzNiqTBweEES2VRuniKg+S05XJtt08hKpxRa8
         Hua+XRERAgsQgpVyaCxxGXsVNAveO1t6c88E7WF8Y1gH3PCaCkZS5+PwE4fNA0VUiUkO
         lGBw+D9l1lF8w/yGmgaESd3ezKOsdetohjEd3UhqTvwA+FkxlksXfF9sUKOrzAWHMjrm
         oeF+VKIrbQWishooZr6c7t1D8fuXNyK6QSJfaJWJ+lEwj3XK4GB+909HBhpfWUml0Jus
         eR/sRwq+dgkHA2gv9ZCc74ffzci6/qubHN984U5OvzYNcfdFTajnwIjMkCqxZTgwYNFj
         nBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHh+bkS3O7piXaVVtP/ViX0e43SgFx44ikdq5/rK28+73+41Ji6cv9zsTyqn5cCfOb2Hl2BlJozSpkk6V0yESLBodobnLoEgndPvoV
X-Gm-Message-State: AOJu0Yy7RcsKbVeIH5MzkxfxEfDVW3u4EmD3IjmCES/Iod5S5kmRilFg
	YidzWQV/BiNpot2MW+slq+a1OLI/IEBJAyBrgBrUN8lHkTgQbKBMRFzyiXbFErLN2ZXny77VF/I
	MER8u8R7Uksy0OoaYs9Ru7Niz6n8=
X-Google-Smtp-Source: AGHT+IEudjFcnjUo/x+2Q8EScBNESxfCoaD7Vi/iu+2UPW0/TmP5z5N7tQTW10ucPdWgfbO+5qlgkBjI6N3JOvcivhs=
X-Received: by 2002:a05:6214:19e3:b0:6a0:c143:5535 with SMTP id
 6a1803df08f44-6a1514bc5camr46576056d6.10.1715193721376; Wed, 08 May 2024
 11:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508171359.1545744-1-usamaarif642@gmail.com>
In-Reply-To: <20240508171359.1545744-1-usamaarif642@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 May 2024 11:41:50 -0700
Message-ID: <CAKEwX=MhxjUsOq+W2Tf1fdc5O-oyPUBdsct1-Df8VQf8-Q2TuQ@mail.gmail.com>
Subject: Re: [PATCH v5] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:14=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Attempt writeback with the below steps and check using
> memory.stat.zswpwb if zswap writeback occurred:
> 1. Allocate memory.
> 2. Reclaim memory equal to the amount that was allocated in step 1.
>    This will move it into zswap.
> 3. Save current zswap usage.
> 4. Move the memory allocated in step 1 back in from zswap.
> 5. Set zswap.max to half the amount that was recorded in step 3.
> 6. Attempt to reclaim memory equal to the amount that was allocated,
>    this will either trigger writeback if it's enabled, or reclamation
>    will fail if writeback is disabled as there isn't enough zswap
>    space.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks for adding this test, Usama!

Acked-by: Nhat Pham <nphamcs@gmail.com>


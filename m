Return-Path: <linux-kernel+bounces-575576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCFFA70455
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5ADF16B4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266325A640;
	Tue, 25 Mar 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvuJa/dw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC327456;
	Tue, 25 Mar 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914393; cv=none; b=VfTRF3hn9wntqt223dvVKqGBQPqO9bnvamT9AvX83WxDTwSS/6ZKQ/lAsbee4zWnbGsaDXlu2S8JAxA0D19ho9UlYHkM18eOcAc1V1JxZACwJ+k+MwuhULj1Q2If4dmvsaVYG6vHso6mAzq2ay7SIhC1EdVd74yJqWSrTU1L3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914393; c=relaxed/simple;
	bh=TOkLz6mRTGWS4FifolhJ5PIlrqTalQbrkuwn2eCQM8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXrrccaOs3WMFKNQAUiBf1oDggzfd7nfVvvGALzKPP/b/w9iR00acpsPes1O8K4PqhVjwM1NasU+/neWOmh9Be+5fQDBKj5D7h+U0iAszEGQat2rPax+raGMBQmegW4DTfI3JiOh3uHELiGDR7gEvmUNp10/8bV8tvvd/Zq0dts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvuJa/dw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso613801966b.3;
        Tue, 25 Mar 2025 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742914390; x=1743519190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOkLz6mRTGWS4FifolhJ5PIlrqTalQbrkuwn2eCQM8I=;
        b=ZvuJa/dwgiV96uXbTA+VBHTaPuwwfyobxcHLQgZ39gPnEbNrOTcyxZAvjCrVaNuWJl
         Ck3oaXr0xRaXvpT8YrIAfRX5Q9RIQ47/1QnTmE2KWcdwzLHD2wI4EWghhPlufH5zQuAo
         G2gjRZ0Fa+Bs2nCMVM8178XhGkaBQye87QiSBXjcvYqTA1Vln5aLo7D1VUs8T7ZA59QT
         sw/GQMjnykMxU1PaN20tjhRo6p7R2DpCEUL90oAaumLZOf4zISPMXQlUtvsB4zSm6Y+A
         745JSfgo7kqxfVjpOzVQIgciwSPf7dzvHHO1lsCRxReG/tVtQL+9H8hWoS6FjC4Y/CuQ
         ZgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914390; x=1743519190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOkLz6mRTGWS4FifolhJ5PIlrqTalQbrkuwn2eCQM8I=;
        b=vBhcgnFMzX4IW9ETa+avTTr6Ofo44KLHVDJVZcFXoVlTWW5koIcGNDDrfG4c2k/Mdi
         +8KNtpxn5w2W9R/CgtrQMC54QpWyMbqqFqGJHd53r+8ZSw0+Xsr23MIKQcvtWsbOQKjR
         V++WXXiTvkjAH09lU5cVCrAYeaZ1xWhfhHCa0zJalltIas9fyruheyZIeFvKpRfLh9Ts
         o2W3zX+WvX3rbyo8QpPCQ0KlktYoHpOFmZB3GTcUhlz+URKr2pG9D+BRW5wGvAKq7MET
         +x7CQHt2TSc4/YUEzrrlZkKkHnLqgPa9va0NQZstGs5n6P2qDRqJNIl9SCcFnLY5MO+M
         0GBg==
X-Forwarded-Encrypted: i=1; AJvYcCVZjUzo1Tc+tuMBCTjhB57Q8sv+EOIX3GyCBnBk2Qyy6JPImpvoRRf5ZTYqmE+adnjACRRKzfxko0lvKLU=@vger.kernel.org, AJvYcCW3UblWkpv4X3wB/m5ePjZfJJVkAWZJWjaoTKNyUBs09rnaowvRMdJxjwlhXn3IokZd0b+FUYHFflJ7+cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEoVKfU1fKnlt5/ZV2qeUAmwLMYTBBR/LxmN8+s4AsuDqu83M
	1AjdftE9aei81gY1FewRwzK5vCPG+a18Er5KZ6yl0NFWcyP4jFQcvW9sdcZZFYm7b1gPUbgMBau
	jpOfaX/qAvcOz4h+7G2Jt732LIPk=
X-Gm-Gg: ASbGncvzzhFpRDQQ3BhXzq/ZkgUZru5plws6/+XPNToLURGhHb5Xn+pPSmUVY5yx85O
	5objaFw83RMEuNVjLois3Jt6zpo8XOQ1PqBSGae4PJeS0FnHlk4MfHRqXacsXLFaaxXV9pkW62C
	udyDF5Y84wQyCKZgJ5Aog1vvUjvGHBAetvLyNPjz0=
X-Google-Smtp-Source: AGHT+IH7lN5CfLZLavK97BN7iwMt/ktAkv6chOHZ+24E39mR8J6eI1+P/F0cmxCLQz4nXHsw+IQ++Em1RnDC5kIBM6c=
X-Received: by 2002:a17:907:940e:b0:ac2:9683:ad25 with SMTP id
 a640c23a62f3a-ac3f23e5d2fmr1952450466b.34.1742914389822; Tue, 25 Mar 2025
 07:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325032226.603963-1-nichen@iscas.ac.cn>
In-Reply-To: <20250325032226.603963-1-nichen@iscas.ac.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Mar 2025 16:52:33 +0200
X-Gm-Features: AQ5f1JqB3_n7wRPOyndANI8VeuPDptNV_crShDtQnUHsVNMYKd4aVNeBOodvySo
Message-ID: <CAHp75VdPFsg9z+SVQHgCWqg4eA5nmXCvMhi7=-xmsSUCJq-=rw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sta32x: Remove unnecessary NULL check before clk_disable_unprepare()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	u.kleine-koenig@pengutronix.de, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 5:23=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.

IS_ERR_OR_NULL()

> Remove unneeded NULL check for clk here.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-kernel+bounces-354701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3C999413C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8037C1F29B14
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBDC1E0B9B;
	Tue,  8 Oct 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aWjg4GLz"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B91E04AE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373870; cv=none; b=pwT5dhva+U56/aTBPHeRwn1m+J1+DjEFpjPqbZCTGGQR+rlj/x2v9JwoG8DntCFI25mVl/hMtGNuy0mZf8G3PlR3PNw238c4GiW0JVmzwBHD2BCwrx5TWqnO5YtNm4GR9yvRk1q9C1XZfzH1uozEoJ1CNRyswFcJmw6fhL5ELjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373870; c=relaxed/simple;
	bh=A8Mbra+3HoV5Rric4cOcRyNbfJDCD2pS2U/9iSQvG3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJoOe+7GlZAfJB719dh3GSx07XG28AANNo3FGQmKtfs8MvNDr1XqS/h9vm71QS7F4LZSAXoFKkPCJfzw3F5gZmu/GJJbOhTkQapgbht2w1N0v50DHtIaFsbOOdGyr5AFViJ6EVI1tZmcDnp7ZUuDw5b7wW3OFQm4dkc8uRvcqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aWjg4GLz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fad784e304so63921631fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728373866; x=1728978666; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KHz3KiZo21KykOoqgFqxWCqTKLqgL0/6CBnTEd5EiM=;
        b=aWjg4GLzLHrsiONIOjqh5mXsY3S0/V6WQCES4NSJKxf6VnSVLUO3uiF7mi4gFyu8XB
         6j4qmxb33kRiCiLykNmT75IV3JpUgvyMUAAJyA0Eqs3zmZe6TBtOnBqPG8k3/E09LyiF
         pkLEotJDGnu1qMCjzeEisG1RSTXNgmXFv6YBf0Ps96LyfR9ovSAZeBZ4tOhPj7IqpiPW
         1ACNxXP6LXjYwu7JyCI796xZIzwbG6i6HBBdN9JzYi81lMZWvVk8MzB8hFG+odNPCKyN
         q8MPawmwlsR19Nd0+Z22Yj9gGIDrVKypBawj36ORcL4a049ycB1GcryghUrCIXQ9QN9M
         pg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373866; x=1728978666;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KHz3KiZo21KykOoqgFqxWCqTKLqgL0/6CBnTEd5EiM=;
        b=SHbJwzr7/P0NHwNM06XfEm4qXr5PI7z2qNnWFKlglpKPj24SwV4XTs4rkmoYO+VUeC
         aSG5urGU5PW8GXg9pqOs/BMZlGwqgLjgcFegGF0YY4zwnuqrKBF/cu1lreJ0ZeutH5PC
         55zv4u+2cpYg6AdrIX8tj8YtdHXILnpwOQ7x39NKa+huUzltjPEj6am9btOdbQujuoR0
         I11CBJaIj6HX8pSq6ZvKXiZOgLU09ogwR200lZRQXgV/pz0OXl//yXQGOv8sJwNldxTh
         lNHcXOAZlVTlBnvwU8GqWGYEJ9Sz+T5OHVSqHEsLrL4bffQtvx9eE8MPMEXlJB2b+pAO
         Xm1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhTSJY2XMDQM+oWaptKlfq6qjGdnsgT1UJTHnjrzpLixkPUO4d5nc9m8fhIPwjpdULkrjDggO6XGV5s+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2wYrzIEDJyWZ3HCiXyX7ptMG+hEJ4FYKskNwE/sE75m1yVqw
	O2rXU9WA/XwgC1WZlwvjhoxzR1XozlBJ+Z0TJRkIxdERc5MBN4tymOuKK5Hl8ciGdAPPSOESaDV
	1q0c=
X-Google-Smtp-Source: AGHT+IG4vpUdXYwtmOCnAcFKZqVApaWhwicEgsFa7rtwGdLJNYFbFhoeLDq7nn3P7PK4dXCmzuxWyw==
X-Received: by 2002:a05:6512:2349:b0:536:a52d:f94b with SMTP id 2adb3069b0e04-539ab85b54fmr7094255e87.8.1728373865922;
        Tue, 08 Oct 2024 00:51:05 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec644dsm100527175e9.37.2024.10.08.00.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:51:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Jiucheng Xu
 <jiucheng.xu@amlogic.com>,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] reset: amlogic: split the device core and
 platform probe
In-Reply-To: <21c65903b243b677d8e84c84acf89c93a45ab1e5.camel@pengutronix.de>
	(Philipp Zabel's message of "Mon, 07 Oct 2024 10:37:46 +0200")
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
	<20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
	<8cb81058c8f45e378675e078e296336a2cf74308.camel@pengutronix.de>
	<1jldzwkpsu.fsf@starbuckisacylon.baylibre.com>
	<01aff9c0f129f8c1cf41c7ae53dac38048aa34a8.camel@pengutronix.de>
	<1jsetcro5n.fsf@starbuckisacylon.baylibre.com>
	<21c65903b243b677d8e84c84acf89c93a45ab1e5.camel@pengutronix.de>
Date: Tue, 08 Oct 2024 09:51:04 +0200
Message-ID: <1jh69nrq1j.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 07 Oct 2024 at 10:37, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Hi Jerome,
>
> On Fr, 2024-10-04 at 15:30 +0200, Jerome Brunet wrote:
>> On Mon 30 Sep 2024 at 18:56, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> 
>> 
>> > I've applied them to reset/next them unchanged, at:
>> > https://git.pengutronix.de/cgit/pza/linux/commit/?id=5b93105afcdc
>> > and sent a follow-up patch to fix the alignment.
>> 
>> Thanks Philipp.
>> 
>> Would it be possible for you to tag it, so I can pull it the amlogic
>> without waiting for the next rc1 ?
>> 
>> We have couple of changes pending depending on this.
>
> Stable tag at
>
>   git://git.pengutronix.de/pza/linux.git tags/reset-amlogic-aux
>

Thanks a lot Philipp
It will be in my next PR to Stephen.

>
> regards
> Philipp

-- 
Jerome


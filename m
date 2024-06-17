Return-Path: <linux-kernel+bounces-216925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49990A8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E7F1C21268
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD29190662;
	Mon, 17 Jun 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuP+TKaF"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E582190493
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613634; cv=none; b=GSwp6Wp1DlvVjemQFx6J7ccypdFXB0FG4Ca8lxaAeGXA/97pgc2N0dVnMA78+ThaGCRzgTVzl+KL27429gX9oPEqpi4SGOSwq+jhZfI/ulu9NYG2Yy0BOyHelbIUWBVr67kZDtGMSe/vLfKHvWSD1XtGFsJKwvatsyo0OJWQJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613634; c=relaxed/simple;
	bh=X5VHLKuA91ZpUWQy97LJXKuQHjNSzTP1qecAbqNklDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJko9+V4qExFUOoOojXRH9gjDxVBkleXEWLKyXto2vJCSj7WJ6FUsMjmQ/fuk2FqxTV8Pae0xQbgMG0KOvMNYciST4xTYhsiePDtuS+g90YK0AkNEmMT6BsVLFnKYtNtn1gX2MzcrBVvhz9eB34p4G3RYPuw9pb2Q2VImQyox7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PuP+TKaF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cc14815c3so10675e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718613629; x=1719218429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5VHLKuA91ZpUWQy97LJXKuQHjNSzTP1qecAbqNklDs=;
        b=PuP+TKaFcoQZXfKfG0enBeRcQa3/YXmPpyclJc0D3DMnV36/HLwgxJqZA378yJEzs0
         K9EONNM0A/Z6qkgq+RMNZaRLadKUwdk9QiXGnRW2uG8yLkGDJVVZ3jYXKkfantl8JGkU
         PCzYt9NMBYTJHl1pUmndVmn8qjaPFNoLqprY8yEDyM2Y/aQJN4EgSA8LezjmS3hTiNiR
         Jn7qfwsXqjTLPmwBuLKGbUfd4SB3AqOGHuRso8ZB34xQWhE3iXJAFm1dtBizoEirkyof
         gkzRo6kBi9+wHMx9gFZSdMRLyLeIrg65zQ/oWvFNbNWwoI6mgj0PhV2IiyeaHdwIu5mW
         c2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718613629; x=1719218429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5VHLKuA91ZpUWQy97LJXKuQHjNSzTP1qecAbqNklDs=;
        b=QazIsHKcrC5q8OPYAjB3uNPJBjiq+rLMMR7nEXrrDNInw4b6iVMtt4nOus9694AwmP
         aLwHam9y1kYWUamlAoqPrDRPO5+dKmDu0x50x/u0TVr7FbXm2shIg3IYu21MbFkfBvEC
         BdR4s0m9kA/wT/Llqmk9Gy7h8/3YBAi6QNBNuf4r1Kqcrd3Y/UL+daCwLqnMOxMV1Idy
         iNAiISsizHqtMxoTTWhghctedtlVM5+B6cGQAgUjR2ds1U1JYb0fBV8mv6fYR8FFpPq2
         Q1iDGk6Hx1PybPwFoDh5Q6Cb3ckVrLAISSZtjKZhwf0zvLdBGApx34K+XqoAheOIGqg3
         rBwA==
X-Forwarded-Encrypted: i=1; AJvYcCWSYYaFAnlLTekhErwxc0xcVu4E/uPf2EzUjN7byjfx4aTDhf+FOWW/f5Su3haEfy9ssukCk+4s4w17pyVa9MMF1zOPbVUcc2f9y++P
X-Gm-Message-State: AOJu0YyFhvueVhHbFVLNXELwPm4C5Z2E6p/SfemjdMhdKHpAh3PEhZRC
	Rpw874rsUTP9MwGau0nI2k/2ZBmBdxV7LxVzLRUH56MQ7XaKS9EU89B0ZZy46rdPpEEkUOEHJiZ
	cNJqEk2Ga1DKtgTMuS2L1ZVfYHJXDr2KOfp4l5Q==
X-Google-Smtp-Source: AGHT+IHENtu6w62klaIyhfrUf1JcZGXfaS8EPrhivXycsqfsmezoTTmR2Ssl5Ad4Ty6uSMvA0yU1itjnM3xuW+u1I6Y=
X-Received: by 2002:ac2:4e04:0:b0:52c:ab2c:19d0 with SMTP id
 2adb3069b0e04-52cab2c243bmr5978403e87.1.1718613629599; Mon, 17 Jun 2024
 01:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606072814.3572965-1-primoz.fiser@norik.com> <20240606072814.3572965-3-primoz.fiser@norik.com>
In-Reply-To: <20240606072814.3572965-3-primoz.fiser@norik.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 10:40:18 +0200
Message-ID: <CACRpkdaFiGhsytjLKpvGU3T7F+pshYOsB6T5ez7Mk_NtPnNRkg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel: simple: Add PrimeView PM070WL4 support
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Sebastian Reichel <sre@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:28=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.com=
> wrote:

> Add support for PrimeView PM070WL4 7.0" (800x480) TFT-LCD panel.
> Datasheet can be found at [1].
>
> [1] https://www.beyondinfinite.com/lcd/Library/Pvi/PM070WL4-V1.0.pdf
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


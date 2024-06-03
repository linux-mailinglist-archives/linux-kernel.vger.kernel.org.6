Return-Path: <linux-kernel+bounces-198936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B94B8D7F71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75FBDB210C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4EE7A140;
	Mon,  3 Jun 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3XkSH6c"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93807E77B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408231; cv=none; b=BrUTU1W0xg8TTD25pdzUo+P1/Bs+Ppwhu0DJVhNP23lg14/IMpCaQc3TgShhQ+pBnDPQWtQh1/LYWp9GVuJc4cbDTChsyg6TxXz2oIpgei57ZuT9wTE0kfRbjnmyZLmXm9sN/VV7gxiRZzSqwQkrJqv6p/E3BO2glXBpMOehK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408231; c=relaxed/simple;
	bh=UGbpAXfiIffXUhT5cT7RbwPaAQgHyUQYJsPaby/ZjwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNuASoDMBQrG5h5kalSTUsivAvuOTksC/lpbhNCSDjnsdzt8xNnwtAPIOLWN2OgLFfDMSNzWFWjHxLVyh9JrFab98aKH2+2pDC2o76QuycUjPrIgRHJi7I33tyFlBiEq2DVGFHhyj089P/eB5BH74kYABtoRTvQkwFX1FdRliPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3XkSH6c; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfa79233c48so2553344276.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717408229; x=1718013029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5nz9246Ps21QPYHtyYcEBDruS5lYzYtnj0CsAL8tho=;
        b=Y3XkSH6c2i0tnQ0IERCv7eKHgjirio+/IYwb1EPn/wr2bWU7Lr73cjcKgKSr0R4BDV
         Ncy0kUX4ZmaDTJOW0oiCp5MXuSqZ08myRUy/FWyflmg64cXT1EPE/97kEkg89mjzLIuT
         8EKJ4YmBMgqIR4u3SmqHxejC929XbhuPOB3FJZOHL6+Y5gm+tLoDuJO3dup3+hUuSbug
         6UhcJkjtVXL9UQX1W16E/RkTvgRpnrDF2CHMTN5P667x+cf6TMh3OgrDiNhA3rBU/3e6
         /gt+/VwIWeQKIoIjWoY7nu3b5Gt/OBpKXl2LAONKXoxXrwFqSU8Uqevi6uX1dbkyBgWJ
         UNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717408229; x=1718013029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5nz9246Ps21QPYHtyYcEBDruS5lYzYtnj0CsAL8tho=;
        b=twbD7TYHFISXz88rIfdW8LvrqBIU9CCiO/IO4keCVwyldqRBBWkvXRcUvjjrXms1up
         1dxEOdclU92LbD2la5cU7wjN7/PpZV1vtcc72uAkKBVbQznXXpFu8FTAGHoo40YU55AY
         Aj7qo04CyacDV6OzAT8bS0m8nCHFXJ/6D4aqTaMXFjn3aECTEqasQok+OTNlvFUrNXau
         KQA597JowBsRc/mtgKcvKiRffvMGjzR46x0aptRQcVRdah01aGQqsOvbPr+SfiT3I7Sl
         rUNMEHJyyLs67hSoMCgqwRh+YSHuCEfsh3avatIhiYWVxL5chYHiN7H84oJopRUbCJx8
         kxbw==
X-Forwarded-Encrypted: i=1; AJvYcCXroqlInJehlewXREVUpOZoLEmSoL1fKN2ST64RfFnvhgfaUaSt12/pIbUB78X70yRYkPaVbDrNXvVsmqZ5mj256wpgfx5BfbEflwPk
X-Gm-Message-State: AOJu0YxXwpWgsqZffCldIOOX27N0fbjRnoChlsLSsY51XAyUTb17e0QX
	unzsNnp3qRteH/VjIW9s2PeHlcQXDu356nlhde87ymLrCkVj8zqh2Q3QF5qLd6xxfGVV/IgS01F
	RgVvRNy9hMKW+OoipyO12vAkrAgT803HtXaJUPA==
X-Google-Smtp-Source: AGHT+IFX8/te7tIpL5Qv+VQ9vIlt9MUlzTuq3gwcja2kJCQVfUhpQiWc0hD9HOlOLPLd6cmtI1+BGOq1zlez1/x9fJs=
X-Received: by 2002:a05:6902:4c2:b0:df4:d05e:2286 with SMTP id
 3f1490d57ef6-dfa73d89123mr8208938276.49.1717408228703; Mon, 03 Jun 2024
 02:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-x1e80100-dts-pmic-glink-v1-0-7ea5c8eb4d2b@linaro.org>
 <20240527-x1e80100-dts-pmic-glink-v1-2-7ea5c8eb4d2b@linaro.org>
 <Zl2DUXWUN0088-Af@hovoldconsulting.com> <CAA8EJpp2hK1P86vrZOwXfNBz3nBXugCcERE9yBRCaCE3aDbqOA@mail.gmail.com>
 <Zl2MRMqY0Y3siXFm@hovoldconsulting.com> <Zl2RkMMk9B12t2CM@hovoldconsulting.com>
In-Reply-To: <Zl2RkMMk9B12t2CM@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 3 Jun 2024 12:50:17 +0300
Message-ID: <CAA8EJppHv+L-FxMZmroZvpGfp9nE+ENPPD8qJH_N8pNGDQN8Tw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: x1e80100-crd: Add pmic-glink node
 with all 3 connectors
To: Johan Hovold <johan@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 12:49, Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Jun 03, 2024 at 11:26:28AM +0200, Johan Hovold wrote:
> > On Mon, Jun 03, 2024 at 11:49:51AM +0300, Dmitry Baryshkov wrote:
> > > On Mon, 3 Jun 2024 at 11:48, Johan Hovold <johan@kernel.org> wrote:
> > > > On Mon, May 27, 2024 at 11:07:28AM +0300, Abel Vesa wrote:
>
> > I don't have time to look into this right now, so only reporting to
> > Abel.
> >
> > Looks like there are two more warnings earlier on boot which appear to
> > be related:
> >
> > [   10.730571] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: invalid connector number, ignoring
> > [   10.730656] pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: invalid connector number, ignoring
>
> Ok, it's just the pmic ucsi driver that is hardcoding max two ports
> still. I'll send a fix.

https://lore.kernel.org/linux-arm-msm/20240527-x1e80100-soc-qcom-pmic-glink-v1-1-e5c4cda2f745@linaro.org/

-- 
With best wishes
Dmitry


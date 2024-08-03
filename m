Return-Path: <linux-kernel+bounces-273605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C32946B63
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC5C281FF4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57CF762EB;
	Sat,  3 Aug 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aG/gNvhn"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56D3F8E4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722725537; cv=none; b=txjp2aRTAwLl8Rguuprz2WYNduKzZxZ8UPuO8hJBDrgyfvtNDcFhluUGVuqgnqnTmRNAToN32sVgoWLUQTpN64Vb8/BQ+aNnYgzFPSfDYT7zg3TLWqEHwjhWfFmic/b0TwPeEBZsS3rDLXFPzc/BmmBWQ0G6DhmkyQRLQH3vjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722725537; c=relaxed/simple;
	bh=VS/k5v1QNh+3vyYqhg9LJgwdVa5PJldl/+U1/qKG/94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqy/fC4vQEVdLr7BFfBeRHCrfoXr15ATMuu36wpssmcCktFUTpKTDcU4PIb6Uob63YRhhEuR1Z6PfiAFGUDyw7ThOkgWoWAy2gHFX+B1+lM5Z5oW+s4dTMXhi/HxO+gkafiVnLrh5lELUkq7AqLEr2T9M5IQXF7z3ZlKcXJJpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aG/gNvhn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f15790b472so41416751fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722725533; x=1723330333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS/k5v1QNh+3vyYqhg9LJgwdVa5PJldl/+U1/qKG/94=;
        b=aG/gNvhnhPVXdVIbUpb5vM+gjqnnDkbGjdaSXiGEZ9IdwxFb1JMgeOscKyKswlhYI8
         ZH/zbOjetAcvnzyYbIXEcXyT9xmdcqD29i50eUciHnqsD4J68vzY29Th4REvH1GHvRp+
         OMdg6Bwvqy7jwNyt38JgGBFKBEuu/rbTDQP3nnjq2YdIX8C4sr0Wo/5eNBSkiwLSyilL
         yPce+2Nl9CBwf0LvS4HOLH+59ABHICHZsj7fZ4EUMVo3HNsq/3K2EpttMRgeCCrhIsRS
         r9/ccDCRJLwEid+zyXOqIIFh5LkPkwsWLJ1Kiv8fabuVVIqul+gnzyvRZVlIn5iTp1Wi
         YdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722725533; x=1723330333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS/k5v1QNh+3vyYqhg9LJgwdVa5PJldl/+U1/qKG/94=;
        b=afv8pqxzp4Hdp6c7qnMDdyqLNZyMIGiF855VqMxE/xf56QaJYJ/FUHfiuS/9jAhrOz
         ge2IFLiols4EFQSCRufg0SYCFI+P/ICkbV8P7XgjMnlRZlS8f/SaUsWv9R0olG4ZvdRB
         awoB9yW+n7gbXAvbneLYp2bvRxWT3z5o52+f3vEVx4Kf5F2qyD0mse1W9eKAj0qRHweF
         MGRbk9gi32U5wzM3+mxMOEi/1xi1zYnT+gGsMhzaD09FBssutC1ZDx/rH8eVrsHcOI3v
         UOxKcD5PgrmEyRTy87ZMNZwCvTZk4M49EUs17wHaL19ScvPT631uJSU92wHNrOTGaEdC
         ujhA==
X-Forwarded-Encrypted: i=1; AJvYcCXCPClxcrza8FdS/bIKyk8m4Sw8qB2wTC+Zcj/0sO/tDpzm7EpryU2jaN0JLoNvLrJg/LOUvuXS4pKo6xcxsOL8lfjjrQgAn6sD+1hm
X-Gm-Message-State: AOJu0Yxk3V42A5L5Q55uRQffweXSYFTTFCHH7zhnbK7Yoe6nqz/LEWXt
	GtlMs/BGPaS91Cp2dza2hGZCHB5FHj8iyVzfFe/j32GDvTfhgiX+Yk87lWsHH3kToEtaHgO6/Yu
	3fNThZDvVMzib0635cPSxjAUh4sBTlnnS1hN/ww==
X-Google-Smtp-Source: AGHT+IGtKbqnwPRPd/X8SX60v5j4Xq35XV3AX5MwZR7GvVw8lAT724joPpRICFpM2WIHSkOHDQu2mGHM8Arm0D/qCKY=
X-Received: by 2002:a2e:2416:0:b0:2f1:59ed:87b8 with SMTP id
 38308e7fff4ca-2f15aa84f4dmr51196711fa.3.1722725533354; Sat, 03 Aug 2024
 15:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-mbly-pinctrl-v2-0-d470f64e0395@bootlin.com>
In-Reply-To: <20240730-mbly-pinctrl-v2-0-d470f64e0395@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Aug 2024 00:52:02 +0200
Message-ID: <CACRpkdbM2CQdgCq916kdObXUH3_73Yd897QxmY13mPWAzvHbHg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/2] Add Mobileye EyeQ5 pinctrl support
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:08=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> This is a new iteration on the Mobileye system-controller series. It
> used to be sent as a single series [0], but has been split in the
> previous revision (see [1], [2], [3], [4]) to faciliate merging.
>
> This series adds a driver handling EyeQ5 (and only EyeQ5, not EyeQ6L nor
> EyeQ6H) SoC pin config and muxing. It is an auxiliary driver being
> instantiated by the platform clk driver.
>
> Related series are targeted at clk [5], reset [6] and MIPS [4]. The
> first two are receiving a second version. The last one has no change
> and stays at its V1.

Patches applied!

Yours,
Linus Walleij


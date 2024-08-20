Return-Path: <linux-kernel+bounces-293644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512C958250
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C961F2472A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227918C007;
	Tue, 20 Aug 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFc0bSXR"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053918E372
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146467; cv=none; b=oMr5cyCLAtYGrqbacPrON5bsiikMy/HI2FM1FDb0v5nInAUI8/MmHDU7fLWOeik+W+hhzIRzlr2H9ehZONnM7zTpSHljLjt+AHAZlSeURxN5QXV0btRb6eR4TDt0W+iD2OGXh+/Nkj0bkN4L1EvMSgqcOMRCxuBJtpZoAHMWOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146467; c=relaxed/simple;
	bh=Cd3m6sDP+PpZ5ozSxzMnm1AaYM8h0uJ0cyLb2lStyqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5PxMxSVm8mU8u0em+4k8a1opk+Nydm46rTIywsvUw2Bo3VmfulW4MjbwhuRjUXf9bLojH3Vt21Ac5ER58F3f30SBto9i+/RN8lB9+8ipu/Fbp5JJS80224KDb9IbO59Q58AjguDsPc0qMrnVOW0crFMNUgE5/8Kbd4kQZr2Eiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jFc0bSXR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e13cda45037so3435437276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146464; x=1724751264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aSXCAFYTvpfQfHjHP6dIA3NLVm4vtDOO89IX3k2TK1Y=;
        b=jFc0bSXRYMyRT4kmX/VXIQGj8D55Iig3y/38w2irmgDjevsm4/Pola2AyYg6kKGSSV
         xFfPUywFgCDQPHOvFpKUtby9Lv9vPPLr2nNwFCMgQNiZ3ubNiGvgCFP6rdsibsABPK+P
         1QBrYRvI1hdwh4cnyfsrapU6FwRZTT6WEpF94t6pZo0D5hVAK4Td/eJd1vDc3K7dKV29
         fEKoqg0x20Jt3Rx/eRnlDK8nBPU6MYC12qCaxDDPzWd7UTvnmeS6ZrQChF6vFv+utzBY
         gfJpe0eJCDS1oRYtzycTbar/ixfiI48HEwcs9S1I/WZma6JfZnKwlAWLGlh3fhLfFUp+
         E6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146464; x=1724751264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSXCAFYTvpfQfHjHP6dIA3NLVm4vtDOO89IX3k2TK1Y=;
        b=gAY53nvHudcepljglWZLdpAJ0jHMEHUQe3OMrknSOz/PxgTfiL5E8htIFc8aKChbNf
         6UWknhiMBgp3qxs3H1TKA1CgY31+9vtOBJcky7UbBObobA6xVUugNAPnckEHvPJiYGQs
         Y8TXJ9Uuqqxs/o4J5kI+pnCx6hBzgvdbRIRW0U1GmQITxD/bfTWbHA32bnywr6PG7xV8
         vIW/9OE6Gd9m4P/GitYhjdYUMWK5ZGFKAjygfBc5zwFMJLO66AuejI0GiqJN8ahmn+aT
         nG5R01JVpxAe2h7ErRw/YuxHnkwDnz5mZ5UC3Yr8KgrCAWRrloFeDNFRGRMVDkuD+47i
         sKcA==
X-Gm-Message-State: AOJu0YxX4cEDEYQwYasEXHaY+23J5rAu2+B1QhUmH4EXkS4AupvPgepX
	hPqynd+OfXhRk9v9zjc5g5adl7DBNT0ivi05nZ0B+9zFhaaGJa87L/Lje2ZSQrDUFBOLlQUfbo3
	BdjOy4cQBf3m0w6/3Y5QRI2v6FhkziOfHPxnk0w==
X-Google-Smtp-Source: AGHT+IFiA3AjMQPNBeiejtIMDCLmON3LWIAb/PR9mOtMqct6XG5GSoya7WrnNNdnhEBwTarC4WErTc/FTZbw7fqFJDc=
X-Received: by 2002:a05:6902:12c3:b0:e0b:43a0:3ce with SMTP id
 3f1490d57ef6-e1180faa0c8mr13052250276.57.1724146464513; Tue, 20 Aug 2024
 02:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814222824.3170-1-detlev.casanova@collabora.com>
In-Reply-To: <20240814222824.3170-1-detlev.casanova@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 11:33:48 +0200
Message-ID: <CAPDyKFpdCKkwVJ9+rOAw4oZOjaxd5PYy-sswTRk_o-MCL41KyA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add power-controller support for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jagan Teki <jagan@edgeble.ai>, 
	Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 00:27, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> Add support for the power domain controller on the rk3576 SoC.
> Patches from downstream have been rebased.
>
> Note that the mentioned TRM is not publicly available.
>
> Changes since v3:
> - Remove unused g_mask and reuse DOMAIN_M_O_R
>
> Changes since v2:
> - Remove unused delay for npu and vop
>
> Changes since v1:
> - Rename rk3576-power.h to rockchip,rk3576-power.h
> - Add memory reset support
> - Squashed header files with bindings commit
> - Updated license
> - Fix commit messages for subsystem.
>
> Detlev.
>
> Finley Xiao (2):
>   dt-bindings: power: Add support for RK3576 SoC
>   pmdomain: rockchip: Add support for RK3576 SoC
>
>  .../power/rockchip,power-controller.yaml      |  1 +
>  drivers/pmdomain/rockchip/pm-domains.c        | 45 +++++++++++++++++++
>  .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h
>

Applied for next, thanks!

Kind regards
Uffe


Return-Path: <linux-kernel+bounces-293646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D7958256
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D161C23AED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB417C8D;
	Tue, 20 Aug 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt+Nk5xw"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F918C351
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146473; cv=none; b=geSUYXCw0sR4B8WZ0pkJU3pZP23BG7eRXJenH/3yynkZYk0bNn7m+v5JnXswYkWQQITgEG+WJszyZtH9Bxr5iuK1KwtH8BVt+YWDcP6i5paWMtuKx0xZtH72azUgFftaMF5n0KhJ4tnOz2z0uubyUbf5fcZiAxjHBUHcV9h9SZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146473; c=relaxed/simple;
	bh=bctGAWm4CZMTjMDHoBpmhXLrDTWUC45Rryu9n2fEaS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0vWEGfQGXwyQ2bdYSwcpbSQWWq2cZzwToahBNAYX76E3Djwl52DzrOp1ysnm7CBwbq6v7mVfVDIKbLmm2ZZJ9LbxAx7u0v6foKFDyBQCPYLZ4VZIVWpPsKLk+O44VcMvlPHVUmxQ2YMDHbvsyforZjWqULt5eCazvDnkuytjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt+Nk5xw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1171e57a0dso3617316276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146471; x=1724751271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYmbMxrJSnqH0+fr9BmoI9eFFc5ifdthYZwO1eH0jRA=;
        b=dt+Nk5xwb8KdU7Z8wEv6luXaJhNZU0IZrU8b6cwXQgW5FN2Xx2JExNYPnq+6EOGcP2
         MPlQ3xvERm8hKTRdEe6IUdW7LH3prPfMhFJ66LgKfdguiohiGEZWGVyHm2ci4pgynG12
         onDmSFgmwyBFBCEV6AVg35a/HfatpnMN8NBhF/TqE0tfPOvszLnKF/qnR4Ipd7CXlAv8
         xOI1u51baLQfg0iwOBvZ2qfb8R87wH+DN/TNIoMS1sFk5ozXg//Nzxy3Ms1NoKH7S5fn
         9N9o5Y/ygZnk5vIoE/tPgRQliwTu5mL4zvDhnboNV6e1RepgvFP4hl4T/YmJ8hDlyeQT
         Zf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146471; x=1724751271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYmbMxrJSnqH0+fr9BmoI9eFFc5ifdthYZwO1eH0jRA=;
        b=L1qx/JWTT8b9DA5JrsysazARNvrEvujxclRS4g5OkNuKpukyTugCoV7j+h38rV7WNM
         utDcOGFDWbaoVrSPqe8JLz/5goJhPb/wjZ66OB3SIEML0qSepqvrBTkE1l7E+8GEO2Dj
         dqBc6Tkzt1I1/e3H5Z9na6DlU59zgLeIQ7+9mp6PO19TGIgSreuoHMGSQXQr6YdqawF4
         f6gks4+CsALBfktqVCYph/PNb3JgYljSbxw6Xb6hqAH6W4t4+7lfbD51uMwpLJW5QkVs
         +TjlSGsX7NWKfC+vhh0Chn2GV+1z8H2hZmmiawEUrVByILtE8kEb4c21gTEhK3VqYSb6
         aFOw==
X-Forwarded-Encrypted: i=1; AJvYcCW/d5ay9hKFY1Y+kSBlvFeYDUL/oUkzW+iBdIvxP1ofaaubxySeRa18GnPCjhE+FbFHdfJ6A/kiAbtxDgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSL9Gy1RKKEEyt7omC8AdftcCW4cbPnAR2YKTa7HS5jN52/23R
	6RmRMq8/uGXuqQVIB7Bicqthi5mrsTSGfaqAUa4qQQB7Tju4sIcN8ZWxFFez540Tq5AoNcPer2S
	VmFzyc/VB77bRJhkrZUQDSFaClo1CHAAzYp/07w==
X-Google-Smtp-Source: AGHT+IEFZJUEoBqdNNpJET01NaxfTcS9rX0l4uTNuyoyoMI2z/9cYVc5bx/EgPUxFSfpoLbSTEzlZup78ErabF/VoWU=
X-Received: by 2002:a05:6902:a08:b0:e11:6940:c29 with SMTP id
 3f1490d57ef6-e164a971878mr1895149276.16.1724146471063; Tue, 20 Aug 2024
 02:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819115956.3884847-1-ruanjinjie@huawei.com>
In-Reply-To: <20240819115956.3884847-1-ruanjinjie@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 11:33:55 +0200
Message-ID: <CAPDyKFqLejTCtQfU=MX587D7S3O15dZm6S3Ecz4qJTf3GOOGfw@mail.gmail.com>
Subject: Re: [PATCH -next 2/8] pmdomain: Make apple_pmgr_reset_ops static
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, 
	p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 13:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> drivers/pmdomain/apple/pmgr-pwrstate.c:180:32: warning:
>         symbol 'apple_pmgr_reset_ops' was not declared. Should it be static:
>
> This symbol is not used outside of pmgr-pwrstate.c, so marks it static.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/apple/pmgr-pwrstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/apple/pmgr-pwrstate.c b/drivers/pmdomain/apple/pmgr-pwrstate.c
> index d62a776c89a1..9467235110f4 100644
> --- a/drivers/pmdomain/apple/pmgr-pwrstate.c
> +++ b/drivers/pmdomain/apple/pmgr-pwrstate.c
> @@ -177,7 +177,7 @@ static int apple_pmgr_reset_status(struct reset_controller_dev *rcdev, unsigned
>         return !!(reg & APPLE_PMGR_RESET);
>  }
>
> -const struct reset_control_ops apple_pmgr_reset_ops = {
> +static const struct reset_control_ops apple_pmgr_reset_ops = {
>         .assert         = apple_pmgr_reset_assert,
>         .deassert       = apple_pmgr_reset_deassert,
>         .reset          = apple_pmgr_reset_reset,
> --
> 2.34.1
>


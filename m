Return-Path: <linux-kernel+bounces-299297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968695D273
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F99D1F22F58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E94189905;
	Fri, 23 Aug 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aN/8Iiao"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657A188001
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429274; cv=none; b=ID2E1MlvRcI6xsK1i8pWsT4Fx4Q7gFJXOuR1XQ4MjcL0Rxk3A7xC34D4CyXbd8VjB+H/Agoln0PBXKL+MSM42xEOzcp8DMu2XyfYp4ou/EmhbEC3GQmK6bIGjmLWC1dWO7ImiFIync5Llf0ZzDPRtj9FHxmjWGvQpShg1e7qbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429274; c=relaxed/simple;
	bh=TeVMpeQdg2wG0XosoMdsTgxo9Xce9on002pqxPK6pjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9LX8c/2Owrxg8gl6eokwvNYDFVYHmHvtGxqmng+HQed0LEGWyEtDq9PcF2J7eVD2phz4+4a6EFQAhg2dR1YaBdp6Eti+6akKh4iBjhaHg62v/mWWOaQGsUj+qWN49LcngF7DO3KzkM/fXzu2Mgthmck5IDE8iC8joABKdFKT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aN/8Iiao; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53349d3071eso2666644e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724429271; x=1725034071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OCNvj/wx5yxOsb2/+mcktbpA3DNvcmR3VULCO7umQ0=;
        b=aN/8IiaoxsYMBfIxY5DMV9NyoGdUpCAeWs8GA0TvLvmbp8qV5CjYTQpR0HPS1mgxh/
         oYZzfiWFjbgt9T/DWGgp2iZ1HFj+qTS3UUVSZOcSbaOq7Ar39UtvGdzrnLf/3J37iP7z
         8BVawduf1kac336bq7ntSt56Gt3EILfWxygocK+7ZDzyRcFM7WDnyPnGwjEDzQ2i3/p+
         0jyAFvpEX/wdL+YUR7QsmoRWqbFgGOo64av2YGdQTNOSx/m3VZgS5F0KpnO+bXv6Rtmc
         MRRNouHh6/NKaseRECZSL9oEYT6tXw5cn/MsQDIN+9EYgx/NR/r3EjvyWSeJwZpzzwqh
         lWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429271; x=1725034071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OCNvj/wx5yxOsb2/+mcktbpA3DNvcmR3VULCO7umQ0=;
        b=JA6IVBeeD8MrY6weeApmJ7cUqWwU8Y08nBIxpYqaZk1WQATHr6HOa2IN1fN81d8Kta
         I3IJ9PMRL4Hc5qc00P4c3PhuMY40eiS3bO62YjHYZ2yKm4ACJV0uOkDa1OqaSkSKlizi
         FbqgGUr3j2G3bN4HC6D9i9udSHTA14Me8sgBVl+LUZj4f3ChBNiSZux1pnR8IK6n0zIH
         vA1AL/piG9syfhymd3kIWsnGxWintneXCxCiSktVutLxrFRMjdIQe/E8jph8ZBrPn2za
         yWVRofsoxZke/ZSZbeYidexlkOwJLVupCa5Lh1QZg3mBhDakI3KhhmYfyt9Sn5UanBX6
         HA+g==
X-Forwarded-Encrypted: i=1; AJvYcCXGMFT2qruEizm2lGzxvAPoSRwzA8QAP0oHezvXuAHxRE/E8L/h1wY7d3Ln+V5YaBq24nF4rZtCF15kHes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6oQi8bxlrHVjYzyDRMdZSL2jnMcGvnYbAVYYY5GPHf6JE5CS
	6v1q68JTrFV7U1iAce/y/hJzLzaJtc3L6VnJK4cV1e0sTU3TV3oefR3RNIenN3cUmtXIvXrUCn4
	UnbXuC+mVzfJL8lphdFQk7lydT6YX3OuWZzpiEQ==
X-Google-Smtp-Source: AGHT+IGUI0PY8Ux0OZKUd+jbtCpSnv5I/wL6SIyMbObq48C6tOrwmIkWL6by381sXMMlDTaIRU35sAsSSqAQhXmpqJI=
X-Received: by 2002:a05:6512:3c9a:b0:52e:999b:7c01 with SMTP id
 2adb3069b0e04-534387bbf66mr2088604e87.48.1724429270252; Fri, 23 Aug 2024
 09:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-mtk-rsel-bias-disable-fix-v1-1-1b4e85bf596c@collabora.com>
In-Reply-To: <20240808-mtk-rsel-bias-disable-fix-v1-1-1b4e85bf596c@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:07:39 +0200
Message-ID: <CACRpkdZy9F-oh0sT+YhvgzoSrKQL78gK46wRbQ6d6jHYS5nzfA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: common-v2: Fix broken bias-disable for PULL_PU_PD_RSEL_TYPE
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 1:27=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:

> Despite its name, commit fed74d75277d ("pinctrl: mediatek: common-v2:
> Fix bias-disable for PULL_PU_PD_RSEL_TYPE") actually broke bias-disable
> for PULL_PU_PD_RSEL_TYPE.
>
> mtk_pinconf_bias_set_combo() tries every bias method supported by the
> pin until one succeeds. For PULL_PU_PD_RSEL_TYPE pins, before the
> breaking commit, mtk_pinconf_bias_set_rsel() would be called first to
> try and set the RSEL value (as well as PU and PD), and if that failed,
> the only other valid option was that bias-disable was specified, which
> would then be handled by calling mtk_pinconf_bias_set_pu_pd() and
> disabling both PU and PD.
>
> The breaking commit misunderstood this logic and added an early "return
> 0" in mtk_pinconf_bias_set_rsel(). The result was that in the
> bias-disable case, the bias was left unchanged, since by returning
> success, mtk_pinconf_bias_set_combo() no longer tried calling
> mtk_pinconf_bias_set_pu_pd() to disable the bias.
>
> Since the logic for configuring bias-disable on PULL_PU_PD_RSEL_TYPE
> pins required mtk_pinconf_bias_set_rsel() to fail first, in that case,
> an error was printed to the log, eg:
>
>   mt8195-pinctrl 10005000.pinctrl: Not support rsel value 0 Ohm for pin =
=3D 29 (GPIO29)
>
> This is what the breaking commit actually got rid of, and likely part of
> the reason why that commit was thought to be fixing functionality, while
> in reality it was breaking it.
>
> Instead of simply reverting that commit, restore the functionality but
> in a way that avoids the error from being printed and makes the code
> less confusing:
> * Return 0 explicitly if a bias method was successful
> * Introduce an extra function mtk_pinconf_bias_set_pu_pd_rsel() that
>   calls both mtk_pinconf_bias_set_rsel() (only if needed) and
>   mtk_pinconf_bias_set_pu_pd()
>   * And analogously for the corresponding getters
>
> Fixes: fed74d75277d ("pinctrl: mediatek: common-v2: Fix bias-disable for =
PULL_PU_PD_RSEL_TYPE")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Patch applied for fixes.

Thanks!
Linus Walleij


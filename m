Return-Path: <linux-kernel+bounces-311073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146396848C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376E61F22742
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB913E02B;
	Mon,  2 Sep 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ivD0ScDQ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B213CFB7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272627; cv=none; b=XZdEIfcvBxV8TPvlYZwSV8OiWu9e487ZN9HAs7jrTjVTdRNQo9AFcs0QGsD+iQletgTSzGjBZ8TuhDJ6mym9224Tdba5p8BtJ9hhW6C9BGZ03RNUghcPtZAgbpcyj0QtdNRwqT/baFarRtOPtWBEJZAHK+M3Hu0FhM77NtF5jCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272627; c=relaxed/simple;
	bh=f9WJMkYbRt8YK7yhRRL6oORLkdkbI11PAS9Vd1uLV18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAbQ7/VhzIXc8YByVoUVFtry+ol4jb5IDryrzt7dnk6JyCuF3i4omcACkfNP3OnXzIGqPm61bo70JMJWpBqge9gFceNazejvPDHgDBKod/PCodzj2+PxA5/qdYGnRN/QWGrtvl83bAp/lj/WKWTPcHGM+KBsvQczMHgFJdya2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ivD0ScDQ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso5637322e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272624; x=1725877424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDD+TxaL8OzI4Gtek8H/QCUJmX/MpPhe6xEdoZdcnLM=;
        b=ivD0ScDQIYhDCteGO421Tk/FATLFNh/Ty2axupttUamHspwj3eSrK7scEC8IpkQZ5B
         p1XMAS7C1VGhVJGp5bJsYF/TCb/SVfsANS+vP16tAdb7RdTMkQUXADxIybGnUkSh15qM
         Go5sg9lviUFAAht2qbQBytgGN2ilxYonAJ276IW6HAVcZKNMH9unCWi/x9toWhXo/xkz
         84HxX8ylE3lCuDHkM3IjROr6hwP8/Nh88SZhlI6pSaeWUxkENruhnraQjw8smjZIfthx
         BTu+nfqXTyC8YYsvz4ar0EV6DUExOPMaBymVGAqodMry0HP/W0Ci9PI/MX2dSdjHL507
         kSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272624; x=1725877424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDD+TxaL8OzI4Gtek8H/QCUJmX/MpPhe6xEdoZdcnLM=;
        b=KBls5zOZUtxZHjawQaiz0Aup54HwQVZUB3+fUM5LaUXitjewZ8iE0NOL5wJBlXxw2+
         ZxTCap4KkCcyzKRZk/T7oPBOU9J/h569BwhOXG29zR+WMtb0V+aHF0mtqMjInnm2SolA
         dt8TLZGRSjVdVpyaxsGJvSkPxm0Cj2KmOTWOmY1m5QZnJQNT21CS3UeFWIRn592se9d0
         1/k4/vc5n17wW5UGILpMFrY4EwYJwVPCPqr2fBO+wGvhUO6R7TQBBH2/rH52O0com08T
         ehjpKVsdjimtz/D/U6J+P9IjmUtiyfCnvj3wiKAQ74DvsNkRUkp+DCp6S+dE5jZG1XWu
         pk0w==
X-Forwarded-Encrypted: i=1; AJvYcCVDnjQvEBx4irYn+eElC8JHr55oQIC/vLBAE/Gr04/6fNLOhAiywPMnuJ4MMcHP9DKlRbzASXFZwOAj7nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTD6AmhbUh0AZnr7NFZSeVZM5m248RMKJhy9iW/wM4aReLgCb
	E5PFqD5Bg/F42oJp4exBOQBKeQBd7bLeP9qiVRJL94JUMy5X3o+Da8NZsj6sxIXMcsIEWzGGsNv
	JG5b6Q8l9hCt8bms4GrfJ3IYynUWtNBSMnBOsGg==
X-Google-Smtp-Source: AGHT+IHIVwNggH5LxD0ZEJiqmV7/TbCJy0HDvDM1xWG+Bc0YfVA8LWZ9NHRHYFVkYMBCC3Xi+/HAVQJJJXZCSx66Bvk=
X-Received: by 2002:a05:6512:118a:b0:52c:e133:7b2e with SMTP id
 2adb3069b0e04-53546b4b08cmr8020045e87.35.1725272623132; Mon, 02 Sep 2024
 03:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826150832.65657-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240826150832.65657-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 12:23:32 +0200
Message-ID: <CAMRc=MfzApzPVauqTm75PTGogRsW=cHH_zu_mCKnysvDTY8R7Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: rockchip: fix OF node leak in probe()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jianqun Xu <jay.xu@rock-chips.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:08=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Driver code is leaking OF node reference from of_get_parent() in
> probe().
>
> Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpio/gpio-rockchip.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 0bd339813110..365ab947983c 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -713,6 +713,7 @@ static int rockchip_gpio_probe(struct platform_device=
 *pdev)
>                 return -ENODEV;
>
>         pctldev =3D of_pinctrl_get(pctlnp);
> +       of_node_put(pctlnp);
>         if (!pctldev)
>                 return -EPROBE_DEFER;
>
> --
> 2.43.0
>

How about using __free(device_node)?

Bart


Return-Path: <linux-kernel+bounces-226747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B15914306
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442C1284A06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CA239851;
	Mon, 24 Jun 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAtfD1Te"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02718AE4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212011; cv=none; b=r9hB29i7PC4JZ7m+bZi/dp2u33JRTI4t/Gcd0FniJdgYR81ZKN5GI8hgcfntJqlcpSCE5BU9KVThkSdxU71NAYFDOCdYTs8+UIi7ikX7l1NN5y6o9UO9q2oUzPR7zjRPE4g7/Bgwzj9ulEJPpb8rypZ/sA3XmHvjtV21dt3yvTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212011; c=relaxed/simple;
	bh=m6hw8A4gvRaUoj5m0cceUufRHh5SxrWmL82hcXLV838=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwWS2LPwBvBgwU1yPkjJdKmE3xI1POZ+5i1NttnC3ibqwE+WbdKK06sdPJX2bySW7evnmWpzPL8YhyNJ0bTHKmrcjJXsxFV8WQPfNCiyStV5VpQqYZZjKHE3pawrf92hvatTtKlFveTM8JuKriZlrD8rgH4+iGCoZ7rpofGDQYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SAtfD1Te; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff36345041so3888615276.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719212009; x=1719816809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0K5qNQse6SSXbSdMb0sCW9E8jgK0p6v0+BxHocogiRk=;
        b=SAtfD1Tepb5RQPuAPJdoYXEWI8mcVmfKNNVR3MCm15s6qXMYFFpN7+ZIzbjvenZTms
         rtJfxi44x+3mhZ10DzLYhXTVUMjXdRnecj0NDME4iE2PyWrpDpjP5rNitVdwxavKMiH1
         T/dyxyPeDWEjJTcWZDdBVHrIXQNaNQx8+Sb1XbNco3SqN7KSd3ceXjInaHuBJpPgEHxt
         Yq7ZrbiMbrHIm+NXX8fs5LVwl8H6DLZBQFxXnY37ihd5E7eFLDkzi/F75hQvISgG0rkh
         0SrXrDsS1MRSifmG0grp60c9azqVtsqEvL3Y8JPHveNw6QD2Bjsee6dE7qK8Mv9O55Zu
         3a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719212009; x=1719816809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0K5qNQse6SSXbSdMb0sCW9E8jgK0p6v0+BxHocogiRk=;
        b=SRP2oMRXwpGRwvPvBFDDOZwOaHOLoUSTlFya5cUiN9xIDZZ6tMa227kdYNgtHQNwZj
         9DAdMCcAuLTYpkgVJhMBzKRV2PSrpufmXP70+0OybqZvRRBb9J4gUROg951kSBeO8jcF
         E2aNVwViTNlyrS1/h/IaY+mkA2YXyXv50b+WwRWyKs5ceubGAwxCPdVk/+b8fTlpVHol
         0c7Mo+XLaWUvitDzNd/VbR5TiWJt1tuVQDtTL3LfxvcIDarahup/DGXnkYDO71W27CYP
         2EjRzcR4XRPTulZ4E/FrV6PlBo3e8pm41ehUiXZ8fIcBEt155B7m9apAxZTnK/nWUgUW
         mGIw==
X-Forwarded-Encrypted: i=1; AJvYcCWIiUKqX5bhw84t/imW2C8hWAaDf5x692Mq32Iry7XZdZt8yHGTrlWLtj5cvRqnesGsFWPOshULdQDetbn3UvJMpRfUbP38XlQhxj18
X-Gm-Message-State: AOJu0YycoQ56FzYF2K5t2H4TCaqFvsroCZoFVDeTDXOoghB00oj3g5pp
	0VIPvCg/KcGI7vaSAvF9NaVEVeibEsXRk3164Ol9uMsxePDIlc5OymzZRxQtvspWQ6jPR2uTyBa
	raFxNtdax86iqLEknArraEzdpovDQxJTR33jEUg==
X-Google-Smtp-Source: AGHT+IG8iogWhwm+14T9U6hQxg5/SiSAsCag93taFNe8go3JrA/0AIiWAZJcDngcCXKTQ1sJVROmPqeV91OmfrgYNqc=
X-Received: by 2002:a25:2b87:0:b0:e02:b79c:6ca9 with SMTP id
 3f1490d57ef6-e0303f407f0mr3530507276.26.1719212008984; Sun, 23 Jun 2024
 23:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623171352.305053-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240623171352.305053-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 24 Jun 2024 08:53:18 +0200
Message-ID: <CACMJSetg2hNn9GAH_E_0EffySP_uojQb93VGoe=xKRT8PjYbEA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci: fix build when POWER_SEQUENCING=m
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 19:13, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> BT_HCIUART_QCA, which is a bool and an HCI UART component, uses now
> power sequencing, so we need to be sure BT_HCIUART_QCA=y and
> POWER_SEQUENCING=m cannot happen:
>
>   /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_serdev_probe':
>   drivers/bluetooth/hci_qca.c:2401:(.text+0xc48): undefined reference to `devm_pwrseq_get'
>   /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_shutdown':
>   drivers/bluetooth/hci_qca.c:2192:(.text+0x29e8): undefined reference to `pwrseq_power_off'
>   /usr/bin/aarch64-linux-gnu-ld: drivers/bluetooth/hci_qca.o: in function `qca_power_on':
>   drivers/bluetooth/hci_qca.c:1808:(.text+0x3390): undefined reference to `pwrseq_power_on'
>
> Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA6390")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 87484f5de8e3..90a94a111e67 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -105,6 +105,7 @@ config BT_HCIUART
>         tristate "HCI UART driver"
>         depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
>         depends on NVMEM || !NVMEM
> +       depends on POWER_SEQUENCING || !POWER_SEQUENCING
>         depends on TTY
>         help
>           Bluetooth HCI UART driver.
> --
> 2.43.0
>

Sorry for that. Here's[1] some more info on that Kconfig trick. Thanks
Krzysztof for bringing this to my attention.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[1] https://lwn.net/Articles/944368/


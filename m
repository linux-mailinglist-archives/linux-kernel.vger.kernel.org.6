Return-Path: <linux-kernel+bounces-549224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A18EA54F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F6E3A854E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DCA214238;
	Thu,  6 Mar 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/5PkE30"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FB214215
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275037; cv=none; b=jkZJGhNHBWB+8QjW6cyEYzHp9g3ZmMpoyHEjxf+gZtIT4oqfivRf9rvc3wjl6RGdX2HKxoUumZz1GDOnOc739ky6gcupMvxOPM6lukMR4eQhEmzoeHpN/b48yL5JL3Ke0Vi0Q4NQqgje+wXXaVePXfWsLKmlsF+MyZ4ubG0UwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275037; c=relaxed/simple;
	bh=pyLJpR7peyTXQEIa1NqkvFFGoT0NVWTptWjHyPuIU5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IinB6Ct5lt71pDVbW+YQEDn88B5eKBSVFt9YMQLkkJh2OY9GMNcOeVO+wnmcgL8Pi0+zuaDbVrTinZB8CHV3kdjdykOcxFp/IHqAhTzzy+z6QSZZYmf16Vc5GDhI46BTpfvZcOZVvEvpc+GrHP1NYSIRs2I9sHNGbBXUUe+RIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/5PkE30; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60018b29f51so515458eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741275034; x=1741879834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sNQBMMRurtTMZcGexPMcCrxPkfGTs27WGkh0+nCXqaQ=;
        b=G/5PkE30c7cWkGushzgN7wSveOWz0SndRjYy1kbwB6rwHClaohFZ1xxVCQteXp1/KY
         BUapkBUk823ubTBZycMMSO2etpNGpHH9ZzeU80BwjLfEfWjtfSaW+SNqDnMOhqiGgUjX
         bhvS/A7cJvoaIPhElOInzr6LPN9FImMDmX1Gp9wfrDKqD+etHyd27LKQaH2hTcZpvCjr
         +rZ5n/t/cNnEtz4uV3lOrh4n1c6s4n+HKNIxJY9PYouMCN4Rj0a0CSTl6X/5fqVYPwvE
         1WS9Xhh12I4hTmIpGuMJVzDeWSdnP/ez/DxX48t/6ickqnwsHw03jjVZlhY0h5do679m
         WoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275034; x=1741879834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNQBMMRurtTMZcGexPMcCrxPkfGTs27WGkh0+nCXqaQ=;
        b=J95hn10eWMOZD4XHI8gsi+ewGzS5bGofV8wqctqR5DOgvUh4NjJDo1CIFth8e7bR2l
         HBMY+5Lwjr47Ypmf2SIYg8kBmew3d5uF9MRjnGTHTKxX7xje+Wk3zmSQYbONdrG2P2bK
         HeizvLsfJcpE9R4iQo0gslW8e1068peN7xKdjmryJNXoKKyC/c0++LAa/00XS9/DJecH
         2QRaUaZKSxfU96Z53zEVDyV/Dpzp5A7gNTyxUp1hGWQp/rQDLIojPUH5shdeqcGb7ps9
         qz2/B6Y9vl1Qk70sOekk1jwQjJdAnNuzKl3z/UHxuu17pAvyC6L8IXTlH4D1W0e3QMlM
         kv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ059Cnw2dnnRQu3XZAgK6w31jviKADF8Vd28uYxnTfcQ4ow3KF9Gqp3YrAklhj/HCFy1n9jJaQUS37rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9bWWGyPrICQUGNchC2CvEXo8yt1UY1Ou2YEXve0dkfMkPHDL
	Cu8eXywIDthKAs43xl70EN2HNcsCQIGadojpxZW+y/uabksW82vCUs52JhQ6+jD8DgCcOYuASOI
	8R0MptRk0fS6OUe1PyMUwYJ4E5+IApUfLRRuEYQ==
X-Gm-Gg: ASbGnctI067gynBvTC4/qqXzYakgOIioMtMxxtNpvNPWOrlMpUehydEf3MrhZiglIAJ
	j+9x1Xg2olPrLi2IxQanhueh683ekgCZ9VPlZ8lCYKqoCWKh8qozN9wR2RXGx2ZcAUuts50i0gj
	XuxProzgYKwunS2jfEfmkNI0vMHVtlUYF0vZTArJThxrf0zML0+SzSyzFv
X-Google-Smtp-Source: AGHT+IH4W0yRe4u7K6oiBA8ZPHCttgqzGQ+tvEf5grhz1HVFab5HIeIG6RBvk1m41VxlWCFwvUQmmPKg1pQBl0yspIA=
X-Received: by 2002:a05:6820:2709:b0:5fe:95b5:78c with SMTP id
 006d021491bc7-6003eb2a7b5mr2022562eaf.1.1741275034380; Thu, 06 Mar 2025
 07:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com> <20250227105718.1692639-2-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20250227105718.1692639-2-catalin.popescu@leica-geosystems.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 6 Mar 2025 16:29:58 +0100
X-Gm-Features: AQ5f1Jq2gqYinafusJfYgm1phirMzxRY-qnbeOTyjPqUfqREkO3jtYUld7G10d4
Message-ID: <CAMZdPi-4rvKfPJ2zQJ8mMOkuJ7SSXk3OePKrFYapFmdw9KZs7g@mail.gmail.com>
Subject: Re: [PATCH next v2 2/2] bluetooth: btnxpuart: implement powerup sequence
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: neeraj.sanjaykale@nxp.com, marcel@holtmann.org, luiz.dentz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	m.felsch@pengutronix.de, amitkumar.karwar@nxp.com, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 27 Feb 2025 at 11:57, Catalin Popescu
<catalin.popescu@leica-geosystems.com> wrote:
>
> NXP bluetooth chip shares power supply and reset gpio with a WLAN
> chip. Add support for power supply and reset and enforce powerup
> sequence:
> - apply power supply
> - deassert reset/powerdown
>
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2:
> - rebase on linux-next tag next-20250227
> - add reviewed-by
[...]
> @@ -1522,6 +1525,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  {
>         struct hci_dev *hdev;
>         struct btnxpuart_dev *nxpdev;
> +       int err;
>
>         nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
>         if (!nxpdev)
> @@ -1549,6 +1553,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>
>         crc8_populate_msb(crc8_table, POLYNOMIAL8);
>
> +       nxpdev->pdn = devm_reset_control_get_optional_shared(&serdev->dev, NULL);

Maybe devm_reset_control_get_optional_shared_deasserted could be
useful here instead?




> +       if (IS_ERR(nxpdev->pdn))
> +               return PTR_ERR(nxpdev->pdn);
> +
> +       err = devm_regulator_get_enable(&serdev->dev, "vcc");
> +       if (err) {
> +               dev_err(&serdev->dev, "Failed to enable vcc regulator\n");
> +               return err;
> +       }
> +
>         /* Initialize and register HCI device */
>         hdev = hci_alloc_dev();
>         if (!hdev) {
> @@ -1556,6 +1570,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>                 return -ENOMEM;
>         }
>
> +       reset_control_deassert(nxpdev->pdn);
> +
>         nxpdev->hdev = hdev;
>
>         hdev->bus = HCI_UART;
> @@ -1583,6 +1599,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>         return 0;
>
>  probe_fail:
> +       reset_control_assert(nxpdev->pdn);
>         hci_free_dev(hdev);
>         return -ENODEV;
>  }
> @@ -1609,6 +1626,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
>         }
>         ps_cleanup(nxpdev);
>         hci_unregister_dev(hdev);
> +       reset_control_assert(nxpdev->pdn);
>         hci_free_dev(hdev);
>  }
>
> --
> 2.43.0
>


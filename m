Return-Path: <linux-kernel+bounces-210554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B190457F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A816B247CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B791514F3;
	Tue, 11 Jun 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lDXiPaFK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BEC7BB17
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136372; cv=none; b=a5L2qIfLUPes7vv+ykhKCurl2vUkvMHzy3gbZHYA8Y5s4FzJurgX9MZeVNXuUN9PPJoZjNQ9BkSqQYD3WlZRXoFgmRxrwf+t8BnXLy98lEVjPCksYQCgNxsKGsJt85t4bqlco14bNy/b/ngbGwf4gDp6k0ImFgbzTVt24+MP1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136372; c=relaxed/simple;
	bh=uHnbK8yZ9GQzrqt+GVlF51JCkKEzN8ZWdF3jcm+f9eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=si1VmQNlRKbF35H6hLoRFoVSCfcBdNEfbz4KDF3U7BEWlxpJVVDJOJZrePnVedyNiNZ+4HmNnwHnCOirLQudNVQjefoTOlSSEj1wkYOZBfoniyTsNgeNbDTPzp87yZHJYh3K0gEerO4OQz39YHksSkizsxLs9F5o3esCn5E08TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lDXiPaFK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c8973ff29so1737263e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718136368; x=1718741168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHnbK8yZ9GQzrqt+GVlF51JCkKEzN8ZWdF3jcm+f9eQ=;
        b=lDXiPaFKuovlZYK3il23Wg5MewPD2fut+IdNs/xXt0jIgm2xmMmXE+y/fre4x5GqsK
         NCzmzTar6Jw99zD8UuilH6uG+Xrp5Ioy6EYHtsVSlTNDAarndn3Zo3iXaaUX1HOfANdK
         UC+Je0/6JHMDLlVvLVR9JUTNs7qMwjAJHnKonfbs8bi3SyVQxyVR45PWiIGjpqbyMK40
         l7ip7rsasFHt3X+04ngrpj+uIV5xcl0AROL14tuQcFiuT/J3dm+qMI/WtYbTgLh+PuNv
         Ec6B7rIKumfUJ0WwrMChJHnq2CMqtDgu+O8eJ3USHaI8+SL6lsZoxBG0jEcMBWvWiSO0
         YeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136368; x=1718741168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHnbK8yZ9GQzrqt+GVlF51JCkKEzN8ZWdF3jcm+f9eQ=;
        b=L2UmouljVtuml+jwYeImf0SF2mjNDCOXooZBR3Eww+LkK//bnghv8mnc50DeQ9dnTb
         Y63aVoz5NpuysbsCk/OkN0Z3F5lxIAz5HWI6kHx/PLho9mUA/d5fk3HKBXPF86UvmB+G
         CZaTmoJ11BBfLbFh9EAfpPe/Q0cxsH6HeseoleA5Y2aIGof5SN/6VpXIVYVsk1heuhTn
         u4g/mQeJQOc+NtJ3feDwVx/pHlVthWt2u0KByjT9XtqRl5r0QajynrhjcjESWuY7DU14
         AChklAgoyV8OfJC2uWlCGqkxC9FvwjI78gXSLCXBRb5d9pSRH/JKtRjtpBSI0E2sohMh
         5xHw==
X-Forwarded-Encrypted: i=1; AJvYcCWHN40T1HJb+CzjrFRTe7akKV+BLnuUlFk5k75PhKaggfxFqO93m6qSxlrXVVxb/aNxRk040yOJvsi/9mo72TnZ/ZfeZfXoxUIKqk9/
X-Gm-Message-State: AOJu0YwLe7u7AjJyzwTly/4lf5XC2MrURiENlYEWXeLWL19osw7kIaqw
	R4iAXAeXpDurVCzYJCNYtsCMlMLYmX1Iho2X1nvOtcwFpIwcR8TfJKwle1MsBXKg5iKDFjLp4Jj
	TN4ViPUEMZkQMFNce65oR3cqpwdOyxkGwaNbu2A==
X-Google-Smtp-Source: AGHT+IHo2kDMYmvh1Fiuq6Vp0TjSyMZ5wd2GkAYNc1OHzZu/lwJY6vNBizdeJ06QMzbe9upl8ARaKOiKysYnJKD3dmc=
X-Received: by 2002:ac2:5148:0:b0:52c:5f12:5317 with SMTP id
 2adb3069b0e04-52c5f1256a6mr5730643e87.44.1718136368542; Tue, 11 Jun 2024
 13:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-2-brgl@bgdev.pl>
 <87h6e6qjuh.fsf@kernel.org> <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
 <871q5aqiei.fsf@kernel.org> <CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
 <87sexqoxm9.fsf@kernel.org> <CAMRc=McYAbhL5M1geYtf8LbgJG5x_+ZUFKXRuo7Vff_8ssNoUA@mail.gmail.com>
 <8db01c97-1cb2-4a86-abff-55176449e264@kernel.org>
In-Reply-To: <8db01c97-1cb2-4a86-abff-55176449e264@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Jun 2024 22:05:57 +0200
Message-ID: <CAMRc=Mer2HpuBLGiabNtSgSRduzrrtT1AtGoDXeHgYqavWXdrA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:40=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> Kalle,
> All of the devices out there need these supplies, but they are sometimes
> provided by generic PCI supply and on-board regulators. Basically your
> PCI adapter is not the same as QCA6390 chip on Snapdragon board.
>
>
> >
> >> Based on the discussions I have heard only Snapdragon systems who
> >> require all this configuration you describe. Of course there can be
> >> other systems but I have not heard about those.
> >>
> >
> > DT is not configuration, it is description of actual hardware. It
> > doesn't matter if Snapdragon systems are the only ones that actually
> > *require* this description to make WLAN/BT functional upstream. The
> > chipset would be the same on any PCIe board, it's just that the host
> > systems wouldn't need to take care with its power sequence. But for a
> > dynamic board like this, you don't need DT.
> >
>
> Correct.
>
> ...
>
> >
> >>> If your detachable board "just works" then it must be wired in a way
> >>> that enables WLAN the moment it's plugged in but this doesn't happen
> >>> over PCI. The chipset has a power input and GPIOs to enable each
> >>> module.
> >>
> >> I don't know how the boards are implemented but it could be so. But fr=
om
> >> host system point of view it's just a regular PCI device.
> >>
> >
> > And you don't need DT anyway for this type of devices.
>
> Detechable board, like PCI adapter, derives these supplies from generic
> PCI whatever-3.3v through additional regulators. All these supplies are
> there - on the board.
>
> >
> >>> Also: I doubt you need DT for your detachable board?
> >>
> >> Sure, I don't need DT but that's not my point. My point is why require
> >> these supplies for _all_ devices having PCI id 17cb:1101 (ie. QCA6390)
> >> then clearly there are such devices which don't need it? To me that's
> >> bad design and, if I'm understanding correctly, prevents use of
> >> qcom,ath11k-calibration-variant property. To me having the supplies
> >> optional in DT is more approriate.
> >>
> >
> > We require them because *they are physically there*.
>
> I understand that for all known DT QCA6390 hardware, the supplies should
> be provided thus they should be required. If in the future we have
> different design or we represent some pluggable PCI card, then:
> 1. Probably that PCI card does not need power sequencing, thus no DT
> description,
> 2. If still needs power sequencing, you can always amend bindings and
> un-require the supplies.
>
>
> Best regards,
> Krzysztof
>

Kalle, does the above answer your questions? Are these bindings good to go?

Bart


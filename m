Return-Path: <linux-kernel+bounces-439560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C29EB109
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DA718882BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426891A9B30;
	Tue, 10 Dec 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R7ZkHnPB"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502A1A4E77
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834430; cv=none; b=kBYjAnHq8J44HeL5YbsaK56Xc0kE2ZMNcQo0cV40vrrnUp4soZxOOxPMqUhEQs+yh6U9yhJrUgKr1NCUWoIfgaq69xa2y/9Czn+CIkRPYwQ45UyrKquaZJlz1/4+8qqjcG/MnVbXEBETZNBaU2WP6yR5C/o2iVzbHkci71khoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834430; c=relaxed/simple;
	bh=qoCJN0XDlVXX2rDBm9MupgcHVuexB/4QMq/Ob6ML5Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG+gJQAUMW9I6/KRg2zw8Y0DIYRS58SeLetLvdqltD8VVIc4+ElZFKQ5Q3Uv4A7KJT19r6TIsYjLepyoGBXspKuS7LgoSVv0N+cfXf2uO4gVFjpYnpChrnEMK5vpjVKl2+e3T9NFZ4p8uRVbXHchomEP0F/zicnxihqjKW0Mbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R7ZkHnPB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso3051309e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733834427; x=1734439227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uec8wtN5bXe/z6NMkpZDWqH1CVWwSVG3n4rX7hz3fG4=;
        b=R7ZkHnPB2KaMhz+CIlrSzDtLCdfvUz9lnID31x/AxCKNd22Bzhb5ZF4ue3m21E3Vhq
         wuYthkWDFMZggycfb3Y/ZarU9Y3esqtAwV2mAJ4oJr9pIm3bQGcK0IvY7PJZKgNXOfbG
         Xfwpuvq27yR8Ryl3bkI+5EWEA+oVHckneTn1vTlvEEfMoqhYFA4mvEd59ejOmkIUwFJE
         duzNdVic0KMFWfBK4w2U2ulw/CglfUBUlto5uBB+RGx7JimdeL2bFbHmJtLOSIm4pcf6
         hyNstnVpnXAUjTwg050g6x+M5DKqCCk3oscXJPLn7L4DMVy+FVVG9zkY3Mejl1xO5+Zq
         QIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733834427; x=1734439227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uec8wtN5bXe/z6NMkpZDWqH1CVWwSVG3n4rX7hz3fG4=;
        b=VLVRxsJL7TT5eQYUp+gLE1UAH5di9JfsZII2cf8gkFe26cCelzwuICdiSEoS0wUuMI
         cTlesTN3y3DyfKA9H5RQwjzoPVQhbzO/AaNE7Pqm0Y9D//4pdTAt57mE/AUE4nh/lXto
         X9VjsWqTXNkFXhG9b3mB/ovuXUyFL+W0K6DBEVTAfXmLdgJWCqQjcYrmH100+PZOPWC+
         jSB8up11LJWdsJTCXp1TNmL8T+E0/fjbIHuA57e0sQSq2/f4cnu7A0JEtefdsxGc/8uQ
         2R5k/nB8yue38aRDibLyl3pXMsyWws2cQRT5EHnhVskM/zsjkk4iJ/XbYkp/MIl95wbA
         Wi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3JxplRAQzA+Xg4vtMg4R8yF5cq9MO2Zi88VydaDeyBO8Y5TqioBxyQx4ZyPIhfUfKnMDE8biOneDTHTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNSOPGzAyQeyiMaUIEHged5JVZ1PDni7amqx7r8Blwx+7vPK0
	KiBTDqoIO7/kbYtzkiH/JVkRJJIJ/M5M+mt/tuRURzun3vTZNdE3d4Eb5DQG0cloUxPB3SoFoWd
	RdvLIBMP3hAbaisubd3T+LU+dkcCS3G1VMSSnGg==
X-Gm-Gg: ASbGncutI5QAJLdwCPx9dz9avf9xOBH5uLK4D+Zi2xy6HR+do7zKTFhk5KXC7VPyLvj
	LdEylUmAbYBCgoJUyVv0BjdTsIfM/T/zRr5G1kcqr1v5TAbzDJ6RTfoQNH4iv2NtQv90=
X-Google-Smtp-Source: AGHT+IFVqvL+/GHDQ61RDn9o0FC8nZtPyXuew4DHpnWom1eAfh3AOK8aU1e1lybYBJfU4Hxy8Svd7zdyP/lhOowaxnw=
X-Received: by 2002:a05:6512:33ca:b0:53f:8c46:42bb with SMTP id
 2adb3069b0e04-540241078d3mr1419815e87.40.1733834426836; Tue, 10 Dec 2024
 04:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
In-Reply-To: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Dec 2024 13:40:16 +0100
Message-ID: <CAMRc=Me39w3oPWQkiGBqY3xSv6AphX6f2oBSEA6WHtmaSbKb3g@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Qiang Yu <quic_qianyu@quicinc.com>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:55=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> Hi,
>
> This series reworks the PCI pwrctrl integration (again) by moving the cre=
ation
> and removal of pwrctrl devices to pci_scan_device() and pci_destroy_dev()=
 APIs.
> This is based on the suggestion provided by Lukas Wunner [1][2]. With thi=
s
> change, it is now possible to create pwrctrl devices for PCI bridges as w=
ell.
> This is required to control the power state of the PCI slots in a system.=
 Since
> the PCI slots are not explicitly defined in devicetree, the agreement is =
to
> define the supplies for PCI slots in PCI bridge nodes itself [3].
>
> Based on this, a pwrctrl driver to control the supplies of PCI slots are =
also
> added in patch 4. With this driver, it is now possible to control the vol=
tage
> regulators powering the PCI slots defined in PCI bridge nodes as below:
>
> ```
> pcie@0 {
>         compatible "pciclass,0604"
>         ...
>
>         vpcie12v-supply =3D <&vpcie12v_reg>;
>         vpcie3v3-supply =3D <&vpcie3v3_reg>;
>         vpcie3v3aux-supply =3D <&vpcie3v3aux_reg>;
> };
> ```
>
> To make use of this driver, the PCI bridge DT node should also have the
> compatible "pciclass,0604". But adding this compatible triggers the follo=
wing
> checkpatch warning:
>
> WARNING: DT compatible string vendor "pciclass" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> For fixing it, I added patch 3. But due to some reason, checkpatch is not
> picking the 'pciclass' vendor prefix alone, and requires adding the full
> compatible 'pciclass,0604' in the vendor-prefixes list. Since my perl ski=
lls are
> not great, I'm leaving it in the hands of Rob to fix the checkpatch scrip=
t.
>
> [1] https://lore.kernel.org/linux-pci/Z0yLDBMAsh0yKWf2@wunner.de
> [2] https://lore.kernel.org/linux-pci/Z0xAdQ2ozspEnV5g@wunner.de
> [3] https://github.com/devicetree-org/dt-schema/issues/145
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (4):
>       PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()
>       PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()
>       dt-bindings: vendor-prefixes: Document the 'pciclass' prefix
>       PCI/pwrctrl: Add pwrctrl driver for PCI Slots
>
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +-
>  drivers/pci/bus.c                                  | 43 ----------
>  drivers/pci/probe.c                                | 34 ++++++++
>  drivers/pci/pwrctrl/Kconfig                        | 11 +++
>  drivers/pci/pwrctrl/Makefile                       |  3 +
>  drivers/pci/pwrctrl/core.c                         |  2 +-
>  drivers/pci/pwrctrl/slot.c                         | 93 ++++++++++++++++=
++++++
>  drivers/pci/remove.c                               |  2 +-
>  8 files changed, 144 insertions(+), 46 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241210-pci-pwrctrl-slot-02c0ec63172f
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
>

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


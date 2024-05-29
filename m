Return-Path: <linux-kernel+bounces-193809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921A8D3268
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3099282D76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208BE168C3D;
	Wed, 29 May 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RYPmipFT"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CED161933
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973076; cv=none; b=rzBN4NSbBcy0sckRCh86KCjqIfyD8DTMeMtjFwFuWU+iyt66yv8xo51N5yIAW3GRwwWFNM3akJyX7i2gpMlaxv45JXVbfZCX3oIELppz5zYK6m2eD2uCC892wI2oGeKwbGapCuM+V/FYYeNrOkOmf6fVAFa/lQOrtvfkTZdWqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973076; c=relaxed/simple;
	bh=S+X9GXGhHwTcRuSiC9i/SHon03qhfv/kK9Vaiu+hrio=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INA8JFE/06QYFcKAWcJTNXNPvAomi8wHkyvXZk01YF3i5FMlRfBto/LT+S11C6PDWvjBE81msaSFdDNByw+NomGt2LTN3hWQ/4T1/MtnzCmA6qTaCTTV7hXs8z04JL+KE/QO6VyqTd8k3agOChE+7+HkC3lvixkYZH3aUOZ0Suo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RYPmipFT; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1F4EC3FE64
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716973066;
	bh=7E/ixyFBMdyfw3d95h9lXIVPkbHsrCtTkTVK1phqYPQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RYPmipFThOvRZamXv7dKsE9jv16hu36nElWWZR0hmdeNqjpEcU4PPVIqo2WqS07Md
	 a5olWPRMVUZ9lRWKy/KoM7sueb/E/sYZ1q73ysDX6r7g9GtrmUCzaBGQ2qZMexXV3J
	 2XKDKrPX6Tez5RL2Z7vcZLzUPsadEK+Pg6TsShTxrpLIGMpEtDfqKFdZf0AWm3TMWx
	 DSIlt51COg5wCDbOtLMW39LrpvR2A9VewLABU8m1MvlL+QGHqk60vjEqAGj4Fd4d7R
	 bVvKafUCi2/b+2cJb37EbTEb0qoBrR4FmoUfHCJ0LESbW75qLsP1YDqpvJFSAlMc7k
	 iPufM8nr9fKYA==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43fc79f9250so17515041cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716973065; x=1717577865;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7E/ixyFBMdyfw3d95h9lXIVPkbHsrCtTkTVK1phqYPQ=;
        b=PAXe60PCMuV9l8TKqjUpeujVoK+CkKXX08DSYvHFNLyyLcfHxG/KlOaByNbP00dTjb
         pzWnv+EKUBFtei0Vtq9BVC7UDPDti28xVZ02Jlt6LvV/2PxP32dQ2xfEgpsVceKRD116
         EHKv7xfsk4WVVM56zb9228Z3EEIBYMa+QxzB3HFOrDQdC9qFa2A0/dlwpyunPNQJjPy2
         fQocZ2u0b7FXUs3A2o0spxxfQe8um7VwQFgPYNL7Zd9ftrJTKWNxZJWnXW+Qke991/zz
         6I50Ma1aVchXLbZNblwTKnHWt2ZH493N7dZkwP/eKboXLgCwOyqmlb9QLdmssmYPDnmx
         pTvw==
X-Forwarded-Encrypted: i=1; AJvYcCUxfvZnFDhKG/M2mUxTT6Ly12fMivaqG8s8idFF5FeD+1oBM3SzPINrewpva9HWzyEAXwS2UybekRAC6G2fYb0cwT7oj1LiMekHCHnz
X-Gm-Message-State: AOJu0YxZyUdollPYUg5d4yuIT67C+VWUV0MD8B7dTLRJD4GdOcMKYh52
	ES02PIul8O5Susb5rWUq8AsizfaUsbYg0berqQBJSviWSWg0ESkOMTaqxj/i2aRokNQA4q7U1IH
	aR4X5p8pEMi6UBDVqLh9kwDbCZmJzLbMwNzb/0DGP2pBEb01EZuqdx4EgeKRKKd1xKXA0JWFMwV
	RbH9h0wElYnxrhhNBmxU5lnIvUqMKnFS/26m6un/dyDUtQnX4rkUEX
X-Received: by 2002:a05:622a:50a:b0:43a:9cd3:7fed with SMTP id d75a77b69052e-43fb0e6de43mr160149051cf.17.1716973065074;
        Wed, 29 May 2024 01:57:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1j+AFmFPVCTE536njafbvZ4XRvDNgWG8gWthUfQYV0su8dbTfEujaBQjWaVYrBYJsDICRI63w3lUZ8Q15BP8=
X-Received: by 2002:a05:622a:50a:b0:43a:9cd3:7fed with SMTP id
 d75a77b69052e-43fb0e6de43mr160148901cf.17.1716973064666; Wed, 29 May 2024
 01:57:44 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 May 2024 04:57:44 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z8Ce1i==pSUj0z4T2y71g713-675mAYQP5qSN5Euz=rLQ@mail.gmail.com>
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
 <87wmo2nmee.fsf@linux-m68k.org> <CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
 <87zfsy102h.fsf@igel.home> <CAJM55Z8Ce1i==pSUj0z4T2y71g713-675mAYQP5qSN5Euz=rLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 29 May 2024 04:57:44 -0400
Message-ID: <CAJM55Z8Bhv-CSR5PKhFfN7dG-rBcEeH+rmL=i2Ass_QuYtBi+Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100 boards
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Andreas Schwab <schwab@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"

Emil Renner Berthing wrote:
> Andreas Schwab wrote:
> > On Mai 10 2024, Emil Renner Berthing wrote:
> >
> > > You don't include any information useful for debugging this, but if it get's
> > > far enough to load the firmware could you at least make sure you run the
> > > version below, so that's at least the same.
> > >
> > > https://github.com/esmil/linux/blob/visionfive/firmware/brcm/BCM43430A1.hcd
> >
> > That didn't change anything (and there are no messages related to
> > firmware loading from hci_uart).
> >
> > [  +0.879623] Bluetooth: Core ver 2.22
> > [  +0.004843] NET: Registered PF_BLUETOOTH protocol family
> > [  +0.008787] Bluetooth: HCI device and connection manager initialized
> > [  +0.021944] Bluetooth: HCI socket layer initialized
> > [  +0.008488] Bluetooth: L2CAP socket layer initialized
> > [  +0.006333] Bluetooth: SCO socket layer initialized
> > [  +0.097478] Bluetooth: HCI UART driver ver 2.3
> > [  +0.007943] Bluetooth: HCI UART protocol H4 registered
> > [  +0.006066] Bluetooth: HCI UART protocol BCSP registered
> > [  +0.006962] Bluetooth: HCI UART protocol LL registered
> > [  +0.000015] Bluetooth: HCI UART protocol ATH3K registered
> > [  +0.000084] Bluetooth: HCI UART protocol Three-wire (H5) registered
> > [  +0.000247] Bluetooth: HCI UART protocol Intel registered
> > [  +0.000455] Bluetooth: HCI UART protocol Broadcom registered
> > [  +0.000084] Bluetooth: HCI UART protocol QCA registered
> > [  +0.000008] Bluetooth: HCI UART protocol AG6XX registered
> > [  +0.000057] Bluetooth: HCI UART protocol Marvell registered
> > [  +0.051854] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
> > [  +0.000387] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
> > [  +0.094658] hci_uart_bcm serial0-0: No reset resource, using default baud rate
> > [  +0.990297] Bluetooth: hci0: command 0x1001 tx timeout
> > [  +0.022893] Bluetooth: hci0: BCM: Reading local version info failed (-110)
> > [  +3.306159] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > [  +0.013336] Bluetooth: BNEP filters: protocol multicast
> > [  +0.124262] Bluetooth: BNEP socket layer initialized
>
> Oddly it doesn't work on my Starlight board either. I was thinking the firmware
> might set up pinconf differently, but comparing
>
>   /sys/kernel/debug/pinctrl/11910000.pinctrl-pinctrl-starfive/pinconf-pins
>
> on the two boards shows no differences. I've also not been able to spot any
> differences in how the AP6236 module is connected in the schematics for the two
> boards, so not really sure how to proceed.
>
> If you're also testing on the Starlight board then I can update the patch to just
> enable Bluetooth on that I guess.

* I meant update the patch to only enable bluetooth on the VisionFive V1 of
  course.

/Emil


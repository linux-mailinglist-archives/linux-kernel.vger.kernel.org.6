Return-Path: <linux-kernel+bounces-291412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB3D95623E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49C51F223A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34114A4D1;
	Mon, 19 Aug 2024 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PVo5IldN"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1114AD3A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039817; cv=none; b=h9bNXv2lDGc7OjWt6OSl2TbEN2jCcWvHwATTKgm0iFTTVseSeWRUJRexdkzdf/vIjXQiugPQxLub1DttD+154j8uC3ALlcDe6u77/HvguBpHm248Vaiqa8KQ1bvPIT2+WmeMIy4wYnWO6d3gWplpPKTgbqoUKjPoCbb/6TQXT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039817; c=relaxed/simple;
	bh=b2XP9qt4WiDnxVai+yZ3Q/QEPSSxZYo1oeVtpDg2Qeo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CbSMrDYh2asncSP8Ey+HPXSQa9swJV2ChrUhEb6macDnZc9U4TfAkcGkenSbFiiBYXme5+IaySkl3qVaRAD++oZwssAgMshn3wcwBe3Ikr0jujpUNnKjgpsxXU4tx11qGwTSBkxToFVM9aHqtIFXl96oneRGvTQfT3A9y+OSkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PVo5IldN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-713dc00cf67so1427505b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724039815; x=1724644615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b2XP9qt4WiDnxVai+yZ3Q/QEPSSxZYo1oeVtpDg2Qeo=;
        b=PVo5IldNB5Xw+VwUZD8qLvFF2doxgTQoKAqilAA+Xibs0MRhamRBA/ZdDu9DotymwR
         /0eZwbf/bt6AexBKzkjax5HQKfkQxbHIVWNeCgCRYeNsOLt7oV10xXYW5ifwWSAaZQhf
         /87b4ZXfnHpcSaneymuV8vXgGoxzbX1mxVFyEyVENhsABgKIl9DNWh/pCQUZ4VXeUXXU
         WzhyvwDvcZ/y7eiO8+Jmnz8meR+43/i0/dPvXvF/ra7gFmwDc0HgeH5x08OmrDxpuNHb
         U2e443PdG2V/EVrnmDGNZl/Sw/YbaEakBYetl+RnD+/yIIac25iGvFNcQ65HZcFZR63Z
         yRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039815; x=1724644615;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2XP9qt4WiDnxVai+yZ3Q/QEPSSxZYo1oeVtpDg2Qeo=;
        b=embjnTjixcgl7S6zrzuKDNWbf88DsJ8hqX5UCmoHV+Da82WsN3TE/WBeh7DJBWZZI2
         I2IJQs8UGB7A+eY7a+u5UnmsZ8Zvbchkw5FWzfIDIyqotlwZWNC3+O97Asg7cJfkfz73
         5NgN95D03twggDquUBjVuwijN+t88ibYPVVn5PLk+G3VyCNaHrs7Lgb2fXqxwneq69/X
         qkSWeTwKYMkpHGqXZOHDiXycVIX+pGzuxbB+eTJkngOmo8IOYyz7jWQ2wMpguTRINLjB
         77Yhz2O2SzZxY1Na/quIakk8AMt7F/lwdARczqVtNHpxaiO+wLsIyLBIlrgmROYoOOq9
         qkmw==
X-Forwarded-Encrypted: i=1; AJvYcCVxzrMc007k5+vTM6D2RQl5qg47NXOPr2cyfSSdcfT6aqzUxV1BUJaNz5I4JsFkqda2D4otj5l/rNH6Jjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKtS686iUA2R5w3vDXvCqjCSkCR4SEKL++HYQKU8HQYUCPLQM
	EUHJ+CYbETzqtu9g1JUdIVvbokPmoK227gxjIrwwwVNQbgTM8eXP0JeI7JHPpfhUWQ1SRvCcNCY
	dPuLbkLSt/lHR5EyLA5yYWYg2iBvsKWQQRm5h6KfHLTdz6xrZkibuuA==
X-Google-Smtp-Source: AGHT+IFRmeijuWgcIPUvZe5rDsbgHAprwbzoc9Fm+JAZIl1kHl+S6Lh8Zl5U6KX1nM3J1SaiRn5Awcetq43jZJrqJWI=
X-Received: by 2002:a05:6a21:3a81:b0:1be:d1bf:a371 with SMTP id
 adf61e73a8af0-1c9050477c9mr13184110637.33.1724039815234; Sun, 18 Aug 2024
 20:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 19 Aug 2024 11:56:44 +0800
Message-ID: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
Subject: Some feedbacks on RISC-V IOMMU driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, 
	Hangjing Li <lihangjing@bytedance.com>, Yongji Xie <xieyongji@bytedance.com>, 
	wangqian.rd@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hi Tomasz,

Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
lot for what we are doing. Below is our feedback on the existing
implementation[1].

1) Some IOMMU HW may only support 32-bit granularity access on its
control registers (even when the register is 8 byte length). Maybe it
is better to provide a 32-bit access method for 8 byte length
registers like what opensbi does on ACLINT MTIME register.

2) In the IOMMU fault queue handling procedure, I wonder whether it is
better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
bit. Otherwise the ipsr.fip can not be cleared and a redundant
interrupt will be signaled.

Best regards!
Xu Lu

[1] https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/


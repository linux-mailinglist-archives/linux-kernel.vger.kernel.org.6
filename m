Return-Path: <linux-kernel+bounces-256352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73257934CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14ED1C223AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4518613B2BC;
	Thu, 18 Jul 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mWufwUOg"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8032139CEF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303913; cv=none; b=r4URG9MzN9RVHhnuJv2DWtQJnNqKVCNHlyRIbsZEDwnf/FqBSAjOr96QJWtkVuMRwwUlXPaCabK87eOzwLX3t77o4NAzS+WcHpmB1nUIDYxIrXQwrghHnZofR29paXZExmHnjtoQyC6NZz5r8kmkYiJ66To25z6Brsh+tH6aHfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303913; c=relaxed/simple;
	bh=FFrNdvWWjN63s42BKAKBM8xaz6ftXrgEKRS6jcbmJL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoLHkSkSYVuBOHHueNnVi/nEjb3on9XJwwvSrbazXt6d5lQbCfxo1H8VGqCsVBc08SAqmFhcKF8h3HdHpK3mQQrFMMA20ZtK4yscj3zryvQZkBMibBvu8NNpdU/w/TW0LaiY8JTJQFz2d6q3Zg7xXx8n8Fe2XwgyPLjHuLHJkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mWufwUOg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so1575225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721303909; x=1721908709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT3/r8iq9vh5IHb+laarDBOv4FqNaSgzXd7Frm5ubA4=;
        b=mWufwUOgGu9tdiTbF+wwaBViwZ/n4VkZG88CacADd3i1zoS9DkkZusfrOmHeK/jtli
         Np/roYCnPe/6gkZWafuTul7lmwqWOct92+bai0+qHrEjtsqT/9krxKTRlxCe2zq2rYvv
         ASYfWg4jaZMhWrVKMb9zOq5kI/rJQviCHWeK/o9qB7DB2ECMjFjn7SMvqlH8SLgGQGxz
         CJplTKapwkiyg8sm6kBEKMrj68Iez0l3L60XL0SrUo5m82q3VKstqAULLMEROCSnuErU
         pc71vIg7gz5X+z4zGwuqAeyodqQUmUyBvspOf974PiNE080Sr97Gn+/iH0N0vhRxCO7z
         NxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303909; x=1721908709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT3/r8iq9vh5IHb+laarDBOv4FqNaSgzXd7Frm5ubA4=;
        b=nABCLLB2d9o5QQztxLF3uNjTlTJ5Wuy4BwVMyCH+yistbipB6/mMwi6qjIMUPIRMIn
         nGT9ggFMIf8BrhewuzvPZGLkkSlYOarJY65HG+f2JGRo73NuWf3zRelJmG+yQyNOtj8x
         mjhGZEZWnPev1l7AldTAJ5TNfttvy/3n3ZXuF4C6767e2ekFMRx18Ee1cCne0ciHC6pC
         H3tb2SuPFPGddGm0KgZfHbox4q7St0pd96AGGxevVI41LC3u/FUw1MZEJVznsi5BoFwN
         4tgRpOB2JIMMdtVqwznWUAyt5aA+H+42E4M4htdnOBT00VGzKuNLRLeWxvStzMAtuD0H
         RHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8HSRDWwTUnuhsfTE2FH8j3jbPG0Jz4r0b9NZGXEi3VSnnWPflPf2IsykMxO9ya8jahDwFfjQwQtD9L5H49KNcJWbMshE/jkEC428V
X-Gm-Message-State: AOJu0YwgiiSN2pnHXFnblupJBF8OXCocJOwPQS+ozxo0bwZaJUAZygRc
	JsUE9YM2dZ8lw708WpwdbVOdszsH3OmtIK9VQoozFxHDiFRHcpJrzlKEeMnpS34=
X-Google-Smtp-Source: AGHT+IHpOFhVVOR50WDCPfi6DXrjDJkGmwaqmpgdsmAo5+FCsTxtL42b6u3Rfj/yngP1z/p7fq9EnA==
X-Received: by 2002:a05:600c:4751:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-427d2b527demr5295885e9.13.1721303909431;
        Thu, 18 Jul 2024 04:58:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58d4:2f84:5fcd:8259])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368467a34dcsm2258703f8f.109.2024.07.18.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:58:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Kconfig: reduce the amount of power sequencing noise
Date: Thu, 18 Jul 2024 13:58:27 +0200
Message-ID: <172130382340.64067.7765392027721457700.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717142803.53248-1-brgl@bgdev.pl>
References: <20240717142803.53248-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 17 Jul 2024 16:28:03 +0200, Bartosz Golaszewski wrote:
> Kconfig will ask the user twice about power sequencing: once for the QCom
> WCN power sequencing driver and then again for the PCI power control
> driver using it.
> 
> Let's automate the selection of PCI_PWRCTL by introducing a new hidden
> symbol: HAVE_PWRCTL which should be selected by all platforms that have
> the need to include PCI power control code (right now: only ARCH_QCOM).
> 
> [...]

I'm picking this up into my pwrseq/for-current branch. I'll be off next week
so I want to give the autobuilders the chance to play with this and I'll send
a PR to Linus with another pwrseq fix I have queued tomorrow evening.

Let me know if there are any objections.

[1/1] Kconfig: reduce the amount of power sequencing noise
      commit: ed70aaac7c359540d3d8332827fa60b6a45e15f2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


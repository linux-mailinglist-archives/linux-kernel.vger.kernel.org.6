Return-Path: <linux-kernel+bounces-303388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C222D960B68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C5E28650B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B1E1C6F45;
	Tue, 27 Aug 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ar4mYpLY"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E41C689B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764115; cv=none; b=N6rcfT2ZpnNNQzq6m9poSH9JFA6qlsSZo2ZKgD6eLp2X5bfQxt4ycLoL6r7QrV0SqLYyK4nTm5L3In8rCXvBbe/eem9mtLc1JLBn6JxAXDZJ4RlwE7NLpmJyB0pK9y2JcPwwGidNOhgWrCep79eDCdLkTKOQztSVb3HFtS7lpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764115; c=relaxed/simple;
	bh=aXlqjOf+2RvyqEdGkHnp+gbVK7RCcBbO0Rx1Vr5MLN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FREvjPASNz3GOc0Pb0OTEF0qkSuLT1K+wDzCtN9Wqa05QNriiVkt1TSI2gu+VouMYBoowWxAhbRB5IUbQKiyhMNivJk/N98xYmmLixYXUXZp2e+45/suzXkrHlTtxastBwwfjyrNvls4jGYYM0QqBJ8YnHkrqzLn9abbRgY61mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ar4mYpLY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371a92d8c90so2869445f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724764112; x=1725368912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmhgoThXpsRE2ZPXF8R0CGdwPpFNc8Epv22ahkVAR6E=;
        b=Ar4mYpLY2SN+jFaDls2QYld+i4o1VZ42yk36K9B3dOAM59MgHVz9UQoAdprzkRB1ZM
         itMsXs6oaRXk46qOJms6eec2nGDpNbl1FW1Nr9Ca690yg1vICUk7xTunw4b6WrEl6OC/
         7wII5r+Zx+BRzisctCb2evp7lW7XRIDz3C+/EkfFnQaEXPJJh+RXiR7RRliu0dBBfxQa
         rw1DZAbH6OfjlD5HeSHHOWYeDmcvnonSMi/8yiJCUeJ/0RFrCjAudoxBsVLZVHWO1CpL
         NNMZRT+7yXA0ftqJk4i+Js/bnGq52JXK5EyBjIjrkYuT9ZqeCpdT+HFYWoTOFRq4cPEv
         dMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764112; x=1725368912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmhgoThXpsRE2ZPXF8R0CGdwPpFNc8Epv22ahkVAR6E=;
        b=Dc5goP9wJvcN6DqNWQThmSZlr3FrE7rcbLhDwPXNahz/pdSB3XktmuKFbBk296Ji4o
         4D3E81/MrmcpAp547JWeeSR3LSXhxK/Lf9QR0oDrwGnAYWgpTv6peOV64OU64rfUh1t0
         AohVUkRvVw6C48kcfEV/zfiBe71b16m2ldTUp9qfNh1xyo3g6PSomWDJ/KV0G3Sowhob
         dkBnAotdbiOn1CjrIj2D5la+wsBYoZpaRMWzV/wKYjm9C9YegAESq/Wodj0MMzFekI14
         khvEyFGTZxgC0oGJaQfwxjynP3GkLXFaJx2OjyDdsenuj9LGxtQQTsaezR+cP+iLa2s+
         7kGA==
X-Gm-Message-State: AOJu0Yy5HpDDMOAyYRQfH5VyckLdYKOGMvcnJmXNmOuAqcxlKg4ZVQS2
	rfAespNYuADpQpniM4ZdeV7fRTy113+Mm56m5fp4yAK9DFVb6svQN8sQ+bd8JWk=
X-Google-Smtp-Source: AGHT+IGHn0fUmNiXD2kqIU9eVqVFjdu3ykcNSCWApUcSFi9kVI2cR/nL4JnTMb6vecuV/AX0n7YrfQ==
X-Received: by 2002:a5d:570b:0:b0:365:980c:d281 with SMTP id ffacd0b85a97d-3748c81a115mr1892925f8f.45.1724764111532;
        Tue, 27 Aug 2024 06:08:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac516252asm184573695e9.26.2024.08.27.06.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:08:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 0DA6E5F9E6;
	Tue, 27 Aug 2024 14:08:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	maz@kernel.org,
	arnd@linaro.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/3] altra workarounds for PCIE_64 with instrumentation
Date: Tue, 27 Aug 2024 14:08:26 +0100
Message-Id: <20240827130829.43632-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

While testing virtio-vulkan on the AVA platform we needed to include
some fixups for its PCI handling. As far as I know these have only
been included in various downstream kernel repos:

  https://community.amperecomputing.com/t/gpu-support-for-ampere-altra/274

The initial two patches are as we found them save for a fix to
align_ldst_regoff_simdfp in the alignment handler. The third and new
patch is trace point instrumentation so we could see how often the
workaround is being invoked.

Combined with Sean's PFN patches:

  https://lore.kernel.org/all/20240726235234.228822-1-seanjc@google.com/

And the Vulkan/Venus support for QEMU:

  https://patchew.org/QEMU/20240822185110.1757429-1-dmitry.osipenko@collabora.com/

I was able to test virtio-vulkan running in a Aarch64 KVM guest hosted
on my AVA platform with an AMD Radeon graphics card plugged into the
PCI bus.

I don't know if there is any interest in getting these upstream but I
figured it was worth posting to the lists for wider visibility and
discussion. For now I'll just carry these patches locally on my AVA
until I get a better system for PCI GPU experiments.

Thanks,

Alex.

Alex Bennée (1):
  ampere/arm64: instrument the altra workarounds

D Scott Phillips (2):
  ampere/arm64: Add a fixup handler for alignment faults in aarch64 code
  ampere/arm64: Work around Ampere Altra erratum #82288 PCIE_65

 arch/arm64/Kconfig                 |  22 +-
 arch/arm64/include/asm/insn.h      |   1 +
 arch/arm64/include/asm/io.h        |   3 +
 arch/arm64/include/asm/pgtable.h   |  29 +-
 arch/arm64/mm/Makefile             |   3 +-
 arch/arm64/mm/fault.c              | 726 +++++++++++++++++++++++++++++
 arch/arm64/mm/fault_neon.c         |  59 +++
 arch/arm64/mm/ioremap.c            |  38 ++
 drivers/pci/quirks.c               |   9 +
 include/asm-generic/io.h           |   4 +
 include/trace/events/altra_fixup.h |  57 +++
 mm/ioremap.c                       |   2 +-
 12 files changed, 945 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/mm/fault_neon.c
 create mode 100644 include/trace/events/altra_fixup.h

-- 
2.39.2



Return-Path: <linux-kernel+bounces-389997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EA9B744C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEBF1C21C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA013D8B5;
	Thu, 31 Oct 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZj6LZx0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CD1BD9F7;
	Thu, 31 Oct 2024 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354972; cv=none; b=UggBGLBPCcslG+X6VCh89q/cJCbyW/G18u4IC7OFhfga6t8iVa9Jh3AfcOwF+mlzI742hv4B8i7vtXKB5RP0qtS2DfB1lPXl73A5jf0QtaaHJ18zFut8UQjJJqcOC4PMas8la7v+dDcGQESInitxPivFIaEON3MpuQ6cqO3ZKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354972; c=relaxed/simple;
	bh=k+IKgICo50bxvpdTzQ5J5z+mwLSc0mdJOiPmP1rCxRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZNxFDSQs3j4PRmca8dtN72spXSllDSy2pCGyiMY6vKmj3AeRI699PsF0r9TPeLYOBNBJD+c4rXO2XXi7aK9oOQdweg+V4LI4D3z5GPCpwdyyP+HhIG6A8vPCzCmwDi+Y/aoPCRiiJrcusTYE8eDFYEEXGwIx7DuUXigXRfMkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZj6LZx0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e983487a1so454597b3a.2;
        Wed, 30 Oct 2024 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730354970; x=1730959770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hXhUJ16K48c/4M1PVquU5XI4OJkfgD0FwNltOSyGs8=;
        b=kZj6LZx0ncl6YVrT70xbZvFBpwlYyclie/N9gkTf34o0arZGh6Oaf4wfQp8cfy2Vxr
         hbNGi+LyI5Fi4oE75Q3L2PRiL7Ami08wcdvcp62lDQ+1yO46YdAexaal0CkVb0Bk6GmE
         +3QnXD90FM6JyfDNmXczwmeYD8Ui1Q34StQW/qF9foSdzEvAHCW0ztKG684cNwS/FkBI
         2AS0bFWBKzI9Thxkk75iNrAFXwTJ2T3xvrn/5Emd6FHajQ9cvLZVtkRtIbQfxgZiJ9L7
         sdgD7HMQkL4Y174UdtDidKpfzNpG7tPG93Lucq00syyjrJYvfFmCsrohdWN+bzI7yXEj
         o6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730354970; x=1730959770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hXhUJ16K48c/4M1PVquU5XI4OJkfgD0FwNltOSyGs8=;
        b=P4SvJWn162bK3MiFx/a1mj29z5WhZij6EQumtIBAo+XUDo+saeahO/qr/+MdN4NNe3
         IJV7UBX5IG5Z0Olp+VwvnToU07atZUe8fHeS0j/shVAbYQnabrDXNiDzXU9XNPf8vRrK
         /R4dSAlsautZCZ3WbPnr5i9avmBzDy8X2V4TLajtqej7hvctz7QnZ+jvHaqNB0uOvmlk
         TnXQ1ii6obZnCCapV712C8OK+aOmkUJ01olAz4bVz7kjZkKONBnkncx41w9nH/JY9dZa
         xOPi4eeL8NtReyj6v8AbOpcWILXuEdzMs12eaGDbLSyM8pjV90qcQfBNeLbfnWEqDk+S
         yxWA==
X-Forwarded-Encrypted: i=1; AJvYcCXqHZ4sJW4kgYbzh/UHpvhcl2D8C5mxXMv97osVopCdf+0bjwJ6a8IRO+35M4n/6SkUEGag1iSaBBAXGe5w@vger.kernel.org, AJvYcCXqbwKNLxcQmtXIOsn+LcDK/DZ7xHoScaOd7kf9zqyFaUa8luEl7Ez1ya4XbQrb/wTJpH+NoIAeF4ed@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dhz9Jr8YeXprCHB+7Lm8bDdoFuSKBYcbi6Vr7l9C8fwkcQzN
	0A1BQxMUnVLwOTgwH8vqVgfsX9aJaxwKst5IC9i6d4MYk1c2C+mK
X-Google-Smtp-Source: AGHT+IGZ8LKVJxabPfVlar0jt5TJvCKTWMjDb3+j9MXgWzPHCHpqAnxCluoqe0yzk5w7hesyU6UCxw==
X-Received: by 2002:a05:6a00:1397:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-720b9c96d0emr2848144b3a.13.1730354969715;
        Wed, 30 Oct 2024 23:09:29 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b86b2sm572230b3a.37.2024.10.30.23.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:09:29 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Anup Patel <apatel@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/3] riscv: interrupt-controller: Add T-HEAD C900 ACLINT SSWI
Date: Thu, 31 Oct 2024 14:08:56 +0800
Message-ID: <20241031060859.722258-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New version of T-HEAD C920[1] implement a fully featured ACLINT device
(This core is used by Sophgo SG2044). This ACLINT device provides a
SSWI field to support fast S-mode IPI. This SSWI device is like the
MSWI device in CLINT/ACLINT, but for S-mode.

Add full support for T-HEAD C900 SSWI device.

[1] https://www.xrvm.com/product/xuantie/C920

Changed from v1:
1. patch 2: use computed reg offset to avoid uncessary reg additions
   when setting/clearing irq.
2. patch 2: fix mulitple format issues and improve some comments.
3. patch 2: disable cpu irq when CPU is stopped.

Changed from v2:
1. patch 2: add SXSTATUS.CLINTEE check for T-HEAD cores.
2. patch 2: add select GENERIC_IRQ_IPI_MUX in Kconfig

Changed from v3:
1. patch 2: add SMP depends in Kconfig

Changed from v4:
1. patch 1/2: update the description to mark the device is T-HEAD specific

Inochi Amaoto (3):
  dt-bindings: interrupt-controller: Add Sophgo SG2044 ACLINT SSWI
  irqchip: add T-HEAD C900 ACLINT SSWI driver
  riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers

 .../thead,c900-aclint-sswi.yaml               |  58 ++++++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/irqchip/Kconfig                       |  12 ++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-thead-c900-aclint-sswi.c  | 176 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 6 files changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
 create mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

--
2.47.0



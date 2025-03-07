Return-Path: <linux-kernel+bounces-550920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1AA565E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034FB3A8AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA520F073;
	Fri,  7 Mar 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="NtDU9EOk"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2D20CCFD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344936; cv=none; b=S9C8ljjzNKvqyGTTW9my7yE97LV/zU5SS0HDVTgLutNMZDEBfEj1Xw6S1yDoZii3xDc6GVSLTvLras+/0NUFJLelHo0gZDWMOcFz+U/oT23ZhWl4W1sEtBlJeAiqSZG2x9EOWGDimhXTku/VfTI9cJRPjbMxuEEpOGdGgUah2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344936; c=relaxed/simple;
	bh=rUgfMxakYAyG1K2sQb8oARmISO/+0M15GeWTZWVVqQ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UFnIJuPA4OCJfsb+OUTEaPe05miBKWUkaNqbOBbpPvEmrsgQnvaESdNFY8CANydQVzSXXCMy7ftXqq/XcWJiucn81cXqSTX/4lDrbhwPZjB0Rwv+/UszHKDY5xYbzk6F9pyzrZfFwSMPWM99NLrpBD8NfbF1R3NpgzMldJ6YVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=NtDU9EOk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22423adf751so20489445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741344934; x=1741949734; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHGAvVOy+z7tslJkuRFoq74XjD23wZovKlYyMhZTzi0=;
        b=NtDU9EOk1csE7HtUpTNDGLJEtBbjEIa4qU1Z/12E/XP6iHFcEzSyJAh3ScO/YFf1ha
         BQmGKYB2VhDlusyNRaaib768SUmz6bFUx7ZkVDvW5ovGO9s7CqRjS9q4qNsxdTssiHEu
         YW0wt6ShyUJR3OZ5z1EK2xqvTQEXtM1b27c49Uy/si83GpM7SDaOm4RQqdMi5rxCqf09
         T4zwCllWHuYGv0oJ7tlRzSe5ED5RA5mNPIe8lHdS7P1jJ3AkhE+2DZguCYuepD1BB3SG
         j0uhLNC3UusN1mePTc/4Q42e5mJxFCBkgNbZgI1XFFQ4Iw+HeeGHdMXD1shLpjVy9azX
         UAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344934; x=1741949734;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHGAvVOy+z7tslJkuRFoq74XjD23wZovKlYyMhZTzi0=;
        b=oMe0WoIrt3Db5n3jL+ndyC4lvNne4VRl+cKG3aY0clE7if7e7n9hzO4KbzG1rNZ1F6
         kl1gH8gIHWzn3zgFLPdPB4KZOjmuX22z+Cfc30JxNB2tjZqAUuyB5i8azmPOcBXj8rop
         9GGCP6IBNOTUBYYaz+nD6mVybbAo3njXBeBhuYQPLQ05GhJ6F+G16pmd494PjQ9vMO+w
         wgPzAjdwxdJxnYPAjgV0miRXYHawL8/v3yXV5x3enpNt5BRC7fdIhZUYExaZ9ga7FaQE
         AflrwXnMI9/lOVqK2bMQRXaI3CS5D9h9bgENETJHdz/gEjiHmhCw2vTbr59st/wzoiAt
         eqzg==
X-Forwarded-Encrypted: i=1; AJvYcCWP+NuyoQMuqnwhDE6IbQmkvb4XJ0G1KpE2gCahUNF7R5QvrEKLwDxnFdFjn3auTkWaF+dTG9GP0MsUDXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtqu/0Gqv3fvU7EdLKVRSIIn8X8pLJZUykC/c7z4LE4639syb
	kALfDQHYIjW5G/5KC5lLRIFIT4FQyHAqxdytN1Q/SHaMM1/1Fve8qunBrt7W4k4=
X-Gm-Gg: ASbGncsXV3+XmtoRddnGsp9HHZBWzpjn8hAmW3O6iYYtQHe1DfAYviQaihHZ4xfxdW7
	h3yH316odcuJnsjDkuAZbvhAdpCzOTHD5BIY5DocGRb4F5tjdjJFIpLLE5FLC88IZnWm8B2rKXl
	+/KwVnm1A02RjompOdHXFGzK5m4VjGEfEbkTHKDRGPJ5cbAZmgnEh3XX7hQAB4S+IWRR2QvIsK4
	qPCwIbM9ISPguETrF0d71p2Mu0zuY3cn7HZjufKQDye3QIeB/GllL/D8IPv6ubYO7aLw9hvjupw
	hleOhPzAGURa2K8hdS881h4Rzjo2kcsD2OP0nSLBV3SkkX36
X-Google-Smtp-Source: AGHT+IEiVKc2iHhF+yedYxasrw/RgvPlEuNFYHbgkXWiWq7Wuopt6Hk+svT+6fLFsvnb0h5t9ef08g==
X-Received: by 2002:a17:902:e811:b0:221:78a1:27fb with SMTP id d9443c01a7336-2242887fe65mr42409665ad.11.1741344933733;
        Fri, 07 Mar 2025 02:55:33 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a91e66sm27027945ad.202.2025.03.07.02.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:55:33 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/3] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Date: Fri, 07 Mar 2025 19:55:27 +0900
Message-Id: <20250307-pmc-v2-0-6c3375a5f1e4@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/QymcC/1WMwQ6DIBAFf8XsuTSAtZGe/I/GAy5Q9yAYaIjG8
 O9Sbz3Oy5s5INlINsGrOSDaTImCryBvDeCs/ccyMpVBctnxlku2LsgmxXX/1E49OoT6XKN1tF2
 V91h5pvQNcb+iWfzWfz8LJhhq51SvuGoNDkbvnrY7hgXGUsoJXHQftZcAAAA=
X-Change-ID: 20250302-pmc-b90a86af945c
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Prepare vPMC registers for user-initiated changes after first run. This
is important specifically for debugging Windows on QEMU with GDB; QEMU
tries to write back all visible registers when resuming the VM execution
with GDB, corrupting the PMU state. Windows always uses the PMU so this
can cause adverse effects on that particular OS.

This series also contains patch "KVM: arm64: PMU: Set raw values from
user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}", which reverts semantic
changes made for the mentioned registers in the past. It is necessary
to migrate the PMU state properly on Firecracker, QEMU, and crosvm.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Changed to utilize KVM_REQ_RELOAD_PMU as suggested by Oliver Upton.
- Added patch "KVM: arm64: PMU: Reload when user modifies registers"
  to cover more registers.
- Added patch "KVM: arm64: PMU: Set raw values from user to
  PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}".
- Link to v1: https://lore.kernel.org/r/20250302-pmc-v1-1-caff989093dc@daynix.com

---
Akihiko Odaki (3):
      KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
      KVM: arm64: PMU: Reload when user modifies registers
      KVM: arm64: PMU: Set raw values from user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}

 arch/arm64/kvm/pmu-emul.c | 19 ++++++++++++++++---
 arch/arm64/kvm/sys_regs.c | 44 ++++++++++++++++++++++++--------------------
 include/kvm/arm_pmu.h     |  1 +
 3 files changed, 41 insertions(+), 23 deletions(-)
---
base-commit: da2f480cb24d39d480b1e235eda0dd2d01f8765b
change-id: 20250302-pmc-b90a86af945c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



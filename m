Return-Path: <linux-kernel+bounces-364117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1313799CB4E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95691B23AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50B17625C;
	Mon, 14 Oct 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Lx35A2N4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01381AE003
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911587; cv=none; b=CvEriHy/zHTZTkzMuvtzCfK7N1BOg3zgu9IBR+p7354W1/NfmlNAElEfF663nc2vDO7Y/ccVfMfPfEbrMyYBsJxSC7OLvgdRzpUZvsE5O2pCYbs3611UpqHoCXHaqWsz/g0HWmfTSHXdpQhKLelPkIOB7GbRAPnW3tqh/MymoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911587; c=relaxed/simple;
	bh=cBmS4a05aaR7mbhMwQWco/X9t659MyL7blbdEaWcl0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErJf2CO90PKG2tFLncSUjpF5CxycwbHTSN69HcwI5siU3sMUjTtvGplC4L+AEGwqje9zQRd3WBg82wMgerMxMd2VK8R2+ymCrt4DO/y5JjPIshSM0GJP0K4nT4AoiqEdaMOcslYjMJtAX6gQcs0ifxjKUk2Z9pSgzsLAnIKynJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Lx35A2N4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so50003355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911584; x=1729516384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=Lx35A2N4vxj7OYWfIIAkoF+xhkj9bAU2IO+3j78890L17Esrp71Mwb+AAh9u+WrqX6
         gU5zeMao/GInt/yAVNmmjun6KRd+evEA90cnTD9B/0/08Ai69JrDwumKvzwgJsyLZTID
         jC1joJYNs4HEefC2LeACKUhW2s7wmqmvTSmA98qcbhsEYgmHqP00ZJZvNglwyfqZ1MtY
         u3EICXy7TbWZKszgsr4ihPTVa6pSrhJrjyJFZ2DW3D133Vg5nWhK6DcttZM2F69O6/ZZ
         a33RL9ltcW0Izm5N2f5XwwTElaNiK2v1xXsami6ouT7m3wM1XaEWonnxZ06GNEZLN5jm
         f2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911584; x=1729516384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
        b=h0Njr8HFnVLqJtcUp16hQDPg5rPeoooN5RJdg5bJe5v6c13F5OcHExuhdhS+VtmRtW
         DdlsPMsogJaP6k9oQbLIpxGkC+6Qh+hH/a+aSPddfEtCdNyrfDq8loNU/wED0GB4rTGc
         9vqrOEnRn/bhBktGhZ1lxCuqosCj7/Zj2RkgflPu0yi5HP8IwST6zIRE7KKM4k2Gyl1M
         GVQ8uUfbdaMUuCtH5iXprQUFWY/3V79YUY+gw9dVvqeXDFqwPh6G3mX9hGb6lX8fHHJo
         OR5gkkWDWFpSbWgiQDbAtKhqCMdRrAnGMpwvWNy6W+lqErGOXU5Nx/ySITHPd951IKv4
         xYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn86gOs4pDquHRHbifcygYX/8F6r5Y7S9t6Z6jCSY0lAERUJuBJ1k8ZxEm2JwbtE3kI9a+LNLiXwKObrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM5ygD+YJ6Z/79ma8JK1jKW7VZ0Vd0Mjt+UC2DfRWiuluTKpY
	4lq9gBR3HktlbpQjR4Oh9YFiZd6RSGy53/4Qjr/GXxtX4aqrDQpg5O8uV3HOZCc=
X-Google-Smtp-Source: AGHT+IH2GWLzAQw/te43dYy0dVJiY21oZeXtwmtdL2hpOlzksZL6MD4EorkNDlnjyP7fdTbxMbpEeA==
X-Received: by 2002:a05:6000:11ce:b0:37d:3e6d:6a00 with SMTP id ffacd0b85a97d-37d600d329cmr7828611f8f.47.1728911584053;
        Mon, 14 Oct 2024 06:13:04 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:13:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Mon, 14 Oct 2024 15:10:47 +0200
Message-ID: <20241014131152.267405-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the generic entry point code to support the ACPI parking protocol.
The ACPI parking protocol can be used when PSCI is not available to bring
up secondary CPU cores.

When enabled secondary CPUs will enter U-Boot proper and spin in their own
4KiB reserved memory page, which also acts as mailbox with the OS to
release the CPU.

TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/cpu/armv8/start.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 7461280261..544a4a5364 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -178,6 +178,18 @@ pie_fixup_done:
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
+#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
+	branch_if_master x0, master_cpu
+	/*
+	 * Waits for ACPI parking protocol memory to be allocated and the spin-table
+	 * code to be written. Once ready the secondary CPUs will jump and spin in
+	 * their own 4KiB memory region, which is also used as mailbox, until released
+	 * by the OS.
+	 * The mechanism is similar to the DT enable-method = "spin-table", but works
+	 * with ACPI enabled platforms.
+	 */
+	b	acpi_pp_secondary_jump
+	/* never return */
 #elif defined(CONFIG_ARMV8_MULTIENTRY)
 	branch_if_master x0, master_cpu
 
-- 
2.46.2



Return-Path: <linux-kernel+bounces-409637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40759C8F99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C2E283023
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F01A2658;
	Thu, 14 Nov 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K04vfsoH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4719CC02
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601146; cv=none; b=ldSmFoVbJa/xHOW1HUO4nhoxmWsQPKxPxVoFsmQtkENZVZjkYwsu8h35ndAZmNcWYYfpMTU/o/rfwUnhbLOR0I2IB5a66KXPfV5aDkxw1xuKhkgxSIQzNJE5Yc5cJOra8//MQif9ucjXrfTMKi8AkkYSdQWRl6vlsfqj7NSbypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601146; c=relaxed/simple;
	bh=zG8rAEuB5eoKnSaZdksATDcRCj9Xf9/S0fQz+A0rat0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+cSpy/24AqbeR6r33o/qNi/N8wgQ7oyM8DoQ+cmpIU3Buw6mvN3pTGhGHk/fLjsFD3zdTX7vNxSAb3yENJcvZNxvakd30dyCSlOjTsYMP/Mw7R1K/2Phh/lffkJgybI4KP2L7yvq0e6R1JojaHIFIRhi6EmbvwDjYPEWgTePGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K04vfsoH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso7180905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601143; x=1732205943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ylj9cSUnN7lZBYMxGOa796BuugfVNbbIfct9OAjDsOY=;
        b=K04vfsoHPQ8sPeJn6OLhB5+OzhmlWfrdBFhPGKUrNINOuOXu7fCIATXEeIeCvnOEeg
         ybzd4rUCMGjVI6vyH18f5fd+tj8MT3QzxXD6mYG8Dukd3Tkd9kr6WuvHibe/cElDo84M
         0XQ47hsTA8SgFAWvcegXtscWvB64wR6bblP3U40lR+deWbXLx5c7KoG9dKxm8l2LndGz
         /lKctDSgyMzk7cKrQGXCfasEn1ANX8BdXepDysl8yQbGzlOzrexRXNHDv+x5L7BXKg6f
         YNwRxI0Lo8dRbPahvtSCpd1SO/EXlyJUZL/ZC0nr1X0AO8ZuLMsqechg5oc3rCAlY06J
         6wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601143; x=1732205943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ylj9cSUnN7lZBYMxGOa796BuugfVNbbIfct9OAjDsOY=;
        b=JYAxDn9mLZuquTVxcBeOZI3IN9ASKFL3hyhcDDDOoOvkpCYLVhaBInBjIUTiKWa4ek
         NndDx4Cn7ulmO7KNyzp9gabxsKNZBF3Esp5MzcRM6fS0s+WbuoSlcXKVM90JMGJknhkI
         CgTENeduh6ycX3aoD8uOCu7PScYwCuQIwM1HPRYQkwQ395enFP/Pss/iCqMJ857+8sxU
         EVOkSKKh7GNUJizeqcnG5DJt9/fsKkNQh+Zwm0vEG/EP4K8flolilTuT1HpdepFYHpn7
         OgVXTqaN+ImTAoV8UciXHexoPHtrNJ5q4+ispeV+lquk4ZK4lLfEOhXltDO2XGIAxX35
         bNgg==
X-Forwarded-Encrypted: i=1; AJvYcCXaY+8dB2IWwY0wtGxSqvV8NHf16Y75LuNku3eeUUefNRtrGhOx147GkGl3/cBpn1wzlp7iyStfdzV+DMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuaYdN4YsQOvoX5PiX1Gbl/hTSnAIoxK+vpcMF71vv4QTYqlW6
	sfOyqVgS5IR3XuTU5CT8RMRadFnOCshmvlcOgEZ6BLccycsPggcIcy6hw5S0ZmM=
X-Google-Smtp-Source: AGHT+IGWufmtM+epbPX600D1VFEI9w8hjUWbvA+ZtsTOBkgX8kbCaXoJN+2t/PgDnUc4rlU+m8h9BA==
X-Received: by 2002:a05:600c:3114:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-432d4aae479mr69854575e9.8.1731601143362;
        Thu, 14 Nov 2024 08:19:03 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265ca8sm28719625e9.14.2024.11.14.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:02 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 09/15] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Thu, 14 Nov 2024 17:18:54 +0100
Message-ID: <20241114161845.502027-26-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index 0c3cbb0915ff..333d95da8ebe 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -29,10 +29,12 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
+	select KVM_VFIO
 	select KVM_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_MMU_NOTIFIER
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SRCU
 	help
 	  Support hosting virtualized guest machines.
 
-- 
2.47.0



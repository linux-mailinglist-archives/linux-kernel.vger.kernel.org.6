Return-Path: <linux-kernel+bounces-528235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E48A41547
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626A918906F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7831C84BA;
	Mon, 24 Feb 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMTkNOP+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AB1C7012
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378083; cv=none; b=oKgnl3E2sbYhMq4sXmMxBoUP31/7Eo/bQ/qPZIDmsoqkmg+cv1YM8t2vvdWrQCwgGHDlvZWrHwXiF2cfE45E34/DXdRmoLWH1e6MsQmY78uq+FtN6p2TcMI584fjK4GbEkifdaGJE4vvFCoEsPLUciueX5YBUQ4EEEq7Vmhc6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378083; c=relaxed/simple;
	bh=ciShrYJXjTiBmBNuZ+kJSDafrQK9Pcz4WheG87twRBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HWqx1wX2kZGU3b0KNWbtK6GD5Q0IlH/7c31T2x5MxaXbZ+C90HkXHQ+RRj45Y8MlT6lfu/qcBySHmVIkMrUbTVwsuJSW7izIfY+bX7nouXODYt82Ym4G4FQBPBG57eVI544SXCaYlF8b1PlhcfNY1/az6blcMeRcC0ZmEtJMKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMTkNOP+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab771575040so877945966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740378080; x=1740982880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmWnaoXiw9bvC988XKjb1pxIMeweo2f9aT4aiVIQmfU=;
        b=cMTkNOP+S7NlfgnS8+Mk0JoZFJQuGseWaT0QTgnKlyDF5JU/BDCPqs+HpnRIcEBymR
         YisSKG1/55D4B9w/LT9s8vbMmM6AeNCLohl5orV1odDVvnYDUrFMu85Dgvmx/2yjQ4iO
         KOslrphhhqmtfduUwzI6aHHhgFgENEoewy469kzu3HqIA4mVHivIdcxdGSvzYtOOxrmz
         AoSRCrkqjhtyBnTgKk17GgrZn4aghKdow3olHpq0gx481epD+n7PBUfgEsgjYeNRHnPu
         OtztCJNeC+UiMEoWeRbfOI+sknhTVD9fwF+BhtRI/m+glo3Yq6MSmmxTVnIKgtO726HC
         /zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378080; x=1740982880;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmWnaoXiw9bvC988XKjb1pxIMeweo2f9aT4aiVIQmfU=;
        b=MsB5Yf5FEGqTKmDNtsX/3cTNEkmcR/9Yjy2kC3XQ0u3MUQmJZH6HmJ6/TxhjE7lWtf
         3POLqJrUjVp3oU0+0zOfCsMWVJZ/JbblqeOwUH5hTw/0cq6FoXg1gxkQVAdgykV7QZQB
         mHw+BW6bd7o20M9mC3+VmHMOTBCh+ny86Iqm3TAa+kPk5KgIQFwtFKhSQumgouMW4++I
         a2L4o8KLENShbmrxREwycbSHa/yBreout9NTmQ8tWruSB2vBC8CMfleIUO5tQZOMTqnd
         uSe79zYbZqjHm5MEfFhrMf5JlU1FsghdfOi4Yix44hSqeahmDB49TWxdtUHykNDSfMMs
         VwHw==
X-Forwarded-Encrypted: i=1; AJvYcCWRx4QuS0/eFy7/SfUjX/D8I8QXeYcrNotiTf/Oh+H7lKWXJ8Bq7xUjzlItVlPFeq80ybWBuQjJD5q74VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvE7nPsnYMHnUz7gCYUOXa002wprb7uQfthhjvuBARFvXwyB0M
	TtgZ130KUwFl9HtY+HJ38TJOpBHubBV4Nls5WgC7d9Ob2wnvPJK1
X-Gm-Gg: ASbGnctmnxISxnYMB1MLoUfwSGSeYu4R8k6A45Hzp/0WJn2fdqLrodXFcBDJvOmbkpm
	JfZFsCcuFvCXx8RI2f1qVC0L6WIvh2e7ZYUhufT3tw+KEspW6yMvzgBpX9VoDGxYmcqVEJh7cHF
	lVFX+q/FxKuTAzOhSHrIYbtWKrgBcEriF0A447Wi98Ukat0ktoMxb9ueYsPc0Fr0ki8ZLuAOzjh
	i+1VoEP3amEF7k861Kx/FgGYrtiqrFdsuCYJPgDSjBzMPRqJyhTC+G18dt6SrLJQ7LiEMbxkEHs
	nlYWT4JON+KD6ry2YHGOoN2OPw==
X-Google-Smtp-Source: AGHT+IHsjFhFKXCpBbExhxMEiZqvYYVtXiZHd3OZG0pPrvCmize50lMccoY+FNwAAW55lD57cHl6Eg==
X-Received: by 2002:a17:907:a317:b0:ab7:46c4:a7be with SMTP id a640c23a62f3a-abbeda28000mr1446440766b.2.1740378080123;
        Sun, 23 Feb 2025 22:21:20 -0800 (PST)
Received: from Sahara-HP.. ([2a00:f29:201:83e5:28ef:beb3:776d:dc6c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322d0sm2195183766b.13.2025.02.23.22.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 22:21:19 -0800 (PST)
From: Keun-O Park <kpark3469@gmail.com>
To: ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	Keuno Park <keun-o.park@katim.com>
Subject: [PATCH] arm64: kaslr: consider parange is bigger than linear_region_size
Date: Mon, 24 Feb 2025 10:21:11 +0400
Message-Id: <20250224062111.66528-1-kpark3469@gmail.com>
X-Mailer: git-send-email 2.34.1
Reply-To: keun-o.park@katim.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keuno Park <keun-o.park@katim.com>

On systems using 4KB pages and having 39 VA_BITS, linear_region_size
gets 256GiB space. It was observed that some SoCs such as Qualcomm
QCM8550 returns 40bits of PA range from MMFR0_EL1. This leads range
value to have minus as the variable range is s64, so that all the
calculations for randomizing linear address space are skpped.
As a result of this, the kernel's linear region is not randomized.
For this case, this patch sets the range by calculating memblock
DRAM range to randomize the linear region of kernel.

Change-Id: Ib29e45f44928937881d514fb87b4cac828b5a3f5
Fixes: 97d6786e0669 ("arm64: mm: account for hotplug memory when randomizing the linear region")
Signed-off-by: Keuno Park <keun-o.park@katim.com>
---
 arch/arm64/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9c0b8d9558fc..2ee657e2d60f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -290,6 +290,11 @@ void __init arm64_memblock_init(void)
 		s64 range = linear_region_size -
 			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
 
+		if (range < 0) {
+			range = linear_region_size -
+				(memblock_end_of_DRAM() - memblock_start_of_DRAM());
+		}
+
 		/*
 		 * If the size of the linear region exceeds, by a sufficient
 		 * margin, the size of the region that the physical memory can
-- 
2.34.1



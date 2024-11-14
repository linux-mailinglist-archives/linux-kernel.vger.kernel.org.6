Return-Path: <linux-kernel+bounces-408796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9669C839C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D4B2821D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77CD1F4718;
	Thu, 14 Nov 2024 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bp+Vpfnx"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA951F5829
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567700; cv=none; b=FfEIyc7TC9Gc4HSzpmIYfRDQymaH5HJRR8hcJqQ5fnO6w0gSWZxPe4IAdaxPZ9iNiRq4vqTafYs1SBqG00AWnhGL+/HAGKIasVWTUrHSM3I0AmjSPlICe52GZIJTK1xKouywgWzUzkW9dHjCWlAYNTvFf+qOscx+Ue9vrs1/bcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567700; c=relaxed/simple;
	bh=//tZic8NPzM9Ca/274IBsMLwUM8Dwx0QhVmk4xzlaPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNucuwLRVWhLhaH5nMMyNpkwNuzBGoqjb/YG3RIeTevEdyQa6EKeTVXQaMKJjHIqa3OvvtH/xybsBg3z/eQEbTBNNBbYmzmUhWaO1PCC69WLpCgpZ/pUv3h8yZ2A1G27/DFsCgNUZdbDpNmd22o7bhJhnW5iFr/O30rKopWmUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bp+Vpfnx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso239690a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731567698; x=1732172498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux2VNbXo90ImX5V4UUDESmDG/GCgEeKifxWHEZQhBkY=;
        b=bp+VpfnxS1Rjfcq1e8PMQv5JKrmFcZ5GQthu7bQqdMNBXyTN5y8K+aeTruvX6n9rkd
         0sDb77nQtrJfJ98J7forcrNokyiyiSR5H+Ld2jkY9fANRezKZP8A+n6SFl5M8EIBFt/2
         iuPLwWkbNvhQHaeCqirlEwJvrQY2V77/Q0hCTkgLmRlRDpD69Gno60Th4mcCgXe9/v7Z
         nRYIpWbXqTnXpe4qwrlZ3n0wCRMXTX9esrYeZjzOm48xbD46c2X8YurVF8KT/sOCCHX3
         voXdnGMz3l/QPt+cvwRKjIfzmKV1wzHD3en/efsYQyU4vO6/HVO4R6wX+r2EC7mk440U
         m/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567698; x=1732172498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux2VNbXo90ImX5V4UUDESmDG/GCgEeKifxWHEZQhBkY=;
        b=vW7CwgpBvNiD30tmrWCm+m81ypr2EGhsvqWGeQj+p2MbinK6CMantvBqd5KP8LKXvv
         eDnlE/WQ4XhEsq5RjBfSVH1nrXZQ8dy3PGX50A4rQVsNGzVkSfzckvf/c6vf7k88Opcg
         P3pa83bIwTMgkx8UPyh6DtiYTqPbnG7XSnNUbhP26KgQyiOGdhgkSdw8M4Ffh7IlGynu
         3djpSd16coLquayLoGpcvTE18UiK1sk0uOhE/Zeeol2UtkAa0f9s5e7pEEYQ8LsIL8x2
         73bXaE0i6aMimXxq6ifCo8KZdXwEdcvUJ9HbRr++HinpC/Clfe1KtbAyEXbkTg1SqJIe
         oclw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqFwV4gm/SVRBCF+ItNsMHspNNmjzm4H9sP8cw93cIY33WPjijXapAlUKpZHMhfhs0uNOT/xncbL3ErY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfUNSip6cDcXNV+6JntUrMf1f1zt8I/V0Ai+FycVqy0eWyBkJ
	iimNopSvbh9+raFCaJDQKCPZOeuaE4ZmkWF32pmPyrLDZmkTluW/nQ+Jv0xE75w=
X-Google-Smtp-Source: AGHT+IGD/Oma/paalKZqrPUZZp2giaMy+M6Rqmdoz0DNDtq/SsMG2116QxX53frrrDiQ+TqULr4MYA==
X-Received: by 2002:a17:90b:17cb:b0:2e2:cef9:8f68 with SMTP id 98e67ed59e1d1-2e9b16ee943mr30937378a91.4.1731567698222;
        Wed, 13 Nov 2024 23:01:38 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d389c2sm4119065ad.268.2024.11.13.23.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:01:36 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	peterx@redhat.com
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zokeefe@google.com,
	rientjes@google.com,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 9/9] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
Date: Thu, 14 Nov 2024 15:00:00 +0800
Message-Id: <69c25b17661499afe4b35f1d30b26dd346a649ec.1731566457.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1731566457.git.zhengqi.arch@bytedance.com>
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, x86 has fully supported the CONFIG_PT_RECLAIM feature, and
reclaiming PTE pages is profitable only on 64-bit systems, so select
ARCH_SUPPORTS_PT_RECLAIM if X86_64.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e74a611bff4a6..54526ce2b1d90 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -322,6 +322,7 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
2.20.1



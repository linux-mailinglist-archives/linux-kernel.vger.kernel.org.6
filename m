Return-Path: <linux-kernel+bounces-515602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2839DA36694
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47FF7A472C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9B1C8618;
	Fri, 14 Feb 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAmhUAIa"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E11C84C0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563011; cv=none; b=Agl5EqH8Mk4f39szMnLG0LFbXdRJfDNSVRGWCBuhD4UhgODjVb10R+WU7OMVMjKKxkxDRKx4v9ofw6bFKexsfkIN7pAUHsqGyW0dXh8KtgXWjbN4Gm5hMkQRw4tZ0n70o/+H8xXFfMI1NveocqbLQZ0qSC+/MLoXZgvlRucg4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563011; c=relaxed/simple;
	bh=YBwPeQCDJxOHmq/Co+incHBL3UWPQ6vi3ncG/nUGZ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwHGQUKPmAyYkTjS18YuCU36QrhWN07w6DNHE+YscBklL+JyDmNqRrL4EMCbaEpMm2PvRfZxyt0d+UpOxNM9uk+kqc+7Sl/SoLCr0eZtlrFtufvoF5EmHOnfotq1+82gyBLghFCOyiwWUYdEh6l72qWw/hSzph89z1rN1f/OODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAmhUAIa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so532039a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739563009; x=1740167809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZe63HKM8wngZcB9fftBtwVVvlWOpcDUXEwsaiq1API=;
        b=OAmhUAIa+FC9BIkZhoIBligo50PCQbq9YfjLkvd2ofouUh8g4IkZFndJ+LONkcG4TD
         CIUuRrLrBnX6PHXISlwg/UmfqJJPb6N3RmV/y0w3AAr745r7V/kClCEGyqZhCqyi7Xoa
         TaJ4OFnyHhdaySa5PY0weQRc8qcqDTPuGXs/4U93LEsdvmCFbfC/wVLbEJqVLGcoO6w6
         QSIogXSSVt5G5VcC6li++Gu7ucDK2wrdHG+plXXf4E9AhUs1eymJzLbTfwh988dbdCvB
         cBujqoEqV3EYLLTRllQDlUYf76vvjNshJaKgD9PLnJN6AhvX62vWyBsBquErsxpfG5sY
         md7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739563009; x=1740167809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZe63HKM8wngZcB9fftBtwVVvlWOpcDUXEwsaiq1API=;
        b=JjdkEsCQfYQD3B0PvHz1rdoNPnyCN0b/h4Na5RtrMf/FCapV5dXSoAiOUi2EU/E6qs
         +fCphFyzif/D/mt4+8AaksZY2735ckYBkq328dzIY9OptnNoSf5Ksx+Z/v9g0z0WE9ft
         fJtwYPZ6KyUtN4Xr0F6OOQUrKRl1hC9Kb3EMSeoEqDUJhYOY/0CZrqqAGeu1ViIeMC67
         8bF2vQB2wbAlfHQo8nmCQIDUVI0XV2B3OnRJcUw3PO3rKhVrMB4clM1YIpe6e9vAeCMD
         aUE3xVlc2ZbOXfbY6M+KNl00LpAaN+5+TD1PQyN2HXlpzF35Eu0DOb66VWyQcmIiGvA6
         ZN4w==
X-Forwarded-Encrypted: i=1; AJvYcCWZedmSiH8Tf/6hnMDEy+GHjgqvYDhwvGMEbTWL60Uwcsq3zYgzM2gB8MEd+BpVsacpEurVfBiswbApNAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+js0g7f7jG4EoBDlk5MZ7fYpg1F19OtWHwdxL/WgN4c/Kk+9
	JxejKEYWPiS+Dlnnk9cfQ9iGQQBTeZEy6HZIs+3ZNiDNhfzopcJj
X-Gm-Gg: ASbGncsNBd5rukM6MHgTaPOpF5efEhNXM79Yu4LCD+ft7JVjGwAl45TVHFWWNxOYv6q
	fInUFZn9ByqdSRlszTaEtlDZ50UNKBQwQMGJudeD9pe3FvHqvrLpELsuLYGCm8KYLV/vLwukKAV
	3SIlSmFdYeg6Uq7UPRPlODgjoQOHZ8d39j0DDaDxObkXsonjGmQnTlZaa06JGRP6UdpaDcYzjOA
	i8jfVXSvy9QNFVLlR0iHubZBrfAt9xlQvmKm9gMbBhJdHKH0qJbC+sjWN7KyQZHpdajRAOWXcDf
	z7N5p6qrAj1J7Bx3r9PNB3XK2nqPLr4=
X-Google-Smtp-Source: AGHT+IG+/GJB7UKuBoebjGFibYJBhi5i0M3ekF7jrMwSS7Pg5F3IV+gTj1kHaiZigFpU3lR6DmIt7w==
X-Received: by 2002:a05:6a00:3e0c:b0:72a:a7a4:99ca with SMTP id d2e1a72fcca58-73261778caamr439948b3a.2.1739563009122;
        Fri, 14 Feb 2025 11:56:49 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2670530b3a.75.2025.02.14.11.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:56:48 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	ajithpv.linux@gmail.com,
	roheetchavan@gmail.com,
	niharchaithanya@gmail.com,
	eleanor15x@gmail.com,
	everestkc@everestkc.com.np,
	kees@ijzerbout.nl,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	gascoar@gmail.com
Subject: [PATCH v2 5/5] staging: gpib: ines: remove unused variable
Date: Fri, 14 Feb 2025 16:54:48 -0300
Message-ID: <20250214195456.104075-11-gascoar@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214195456.104075-1-gascoar@gmail.com>
References: <20250214195456.104075-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove unused variable 'nec_priv' in function 'ines_line_status'.

This change removes the following warning:

warning: variable ‘nec_priv’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v2: no changes in this patch.

 drivers/staging/gpib/ines/ines_gpib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 22a05a287bce..ba07dfb0697a 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -26,10 +26,8 @@ int ines_line_status(const gpib_board_t *board)
 	int status = ValidALL;
 	int bcm_bits;
 	struct ines_priv *ines_priv;
-	struct nec7210_priv *nec_priv;
 
 	ines_priv = board->private_data;
-	nec_priv = &ines_priv->nec7210_priv;
 
 	bcm_bits = ines_inb(ines_priv, BUS_CONTROL_MONITOR);
 
-- 
2.48.1



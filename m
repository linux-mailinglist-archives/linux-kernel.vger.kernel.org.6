Return-Path: <linux-kernel+bounces-250167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4876C92F4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FB81F22759
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54A2E639;
	Fri, 12 Jul 2024 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gs9fwuyu"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFB1BDE6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761545; cv=none; b=g7cmoNMT3+F65AppIe5bElLVI5vk4Z+Mj1kSbPFULhJNuBdCvnikYPA3EJ2g6X5o1X7sLv2aV56MhNMck0WlUaZEGJGc5aTiOndCzXkDjsoiOSpRPnSxN1jnJrZ1132exjIh0SgcIeG+7jwtk9LvYn+zV/OXLnARcUyt3RCSyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761545; c=relaxed/simple;
	bh=xetQK4NvrTVzpEMIZzjKGoPzjTKxq2X0OCSfKW+YHz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUUrbUWFCBaO9ecs9usEaQt+IckWuBA+D9nW+tWas9F7Y7Uvdicj3b2VmDr5R4RcGbjldaNW0ahaf9C8ZlqK1cH580/T0q5LkL96uIc+QZpZivk8o68ao9as/pOjiHXZgQecn4jx/2HRGHkqkSlcK/kgEwBhCBtiVjTI8BgzLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gs9fwuyu; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d93147ac6bso901509b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761543; x=1721366343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK4yGCTZGoA8FfUJeWZ5DsSBcIzSsvHoyFCV3fGU2TI=;
        b=Gs9fwuyuwT0kLv/YmYZLYneamvUz1jIG6WvpKn1TS0NSn4JSX2g34UOGo9UzkKmDql
         yeptBi49sxyYygyQpCTGELDK02o+fmdWS7+xYXiJe8Kqwu8i+p28F500ZegVY9lHMQR9
         Vp2mL6yRYQckISDI/YzwEHNVwAWsOegcbmCSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761543; x=1721366343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK4yGCTZGoA8FfUJeWZ5DsSBcIzSsvHoyFCV3fGU2TI=;
        b=bU1N+qJAFLi5/1Lm2atPAJsjzlK3Gp2sq6d+2nRBgGozGJwbgH27oeo1VcXu1kOJvS
         l3y4NEF0369NhddD0Msm65K2ywKrHrL65Ge0R7zNnRO1ag9DTJh1Sjx0In0XP0fxA6NP
         eyeSwBU9NF0cFiaSLGF2bWhWuP4K3TQpNnJ1j0J23gECpHZ+y9kpTSCMCZZNaXNFRhO/
         yxpxrKzgmJ416bXWOq2pWvG/WAZuCl99l3QLYzTW8kitSSreOZTdhUCRGn1HHG/92vnP
         Djt6uaIhCdbCH8t3ZnrFEt/9tCwPupT28JulduNEayXzpnxYwNhC8kciPFHz8Bv9rgsT
         GaXg==
X-Gm-Message-State: AOJu0Yy8iUSkyqyLv7dGbx4g1/j7oKZ7NuM5WvhLzjq/k+IS5Rd1ULfh
	71yGxFzuW73Vf6giJXnzTsGL6Gry+ZJo2uCR9JGv27sZ6a1/kXk2upQpEDqVQg==
X-Google-Smtp-Source: AGHT+IHVu0899IACUROmpvF1H0znP5GmchmoXxv8zKFqxqWYcBpnyKonZrqH8uozm0s1Iz9VsavLhQ==
X-Received: by 2002:a05:6808:2395:b0:3d9:2fd5:6c14 with SMTP id 5614622812f47-3d93c033989mr12604186b6e.29.1720761543355;
        Thu, 11 Jul 2024 22:19:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Terrell <terrelln@fb.com>
Subject: [PATCH v6 02/23] lib: lz4hc: export LZ4_resetStreamHC symbol
Date: Fri, 12 Jul 2024 14:18:13 +0900
Message-ID: <20240712051850.484318-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240712051850.484318-1-senozhatsky@chromium.org>
References: <20240712051850.484318-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This symbol is needed to enable lz4hc dictionary support.

Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 lib/lz4/lz4hc_compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index e7ac8694b797..bc45594ad2a8 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -621,6 +621,7 @@ void LZ4_resetStreamHC(LZ4_streamHC_t *LZ4_streamHCPtr, int compressionLevel)
 	LZ4_streamHCPtr->internal_donotuse.base = NULL;
 	LZ4_streamHCPtr->internal_donotuse.compressionLevel = (unsigned int)compressionLevel;
 }
+EXPORT_SYMBOL(LZ4_resetStreamHC);
 
 int LZ4_loadDictHC(LZ4_streamHC_t *LZ4_streamHCPtr,
 	const char *dictionary,
-- 
2.45.2.993.g49e7a77208-goog



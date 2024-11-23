Return-Path: <linux-kernel+bounces-419009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8A9D687D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D9E281D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781A189F47;
	Sat, 23 Nov 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2qxKVK9"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64586185939
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732355266; cv=none; b=jc57UMhGH21O5pI1cL0Wldopv3SD5tVfRT4nLBlPVUhNgNk7aOu9AMWCizTJ5iqvYSbe4L4VwMor/gBMddqZIdhcf+CndO7RN404Qvc4DF0NN0FUbNn06ekW0egViZwrcDooujLsmYnGGc8wXwswK6H6/p02KmqyPQN7yM1AA4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732355266; c=relaxed/simple;
	bh=lk4JULyB77R1m3+zIEqqwIEYphVgQiXFvTfAM8r1YpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI480cEvjyRAAJ0AnWKo/50+b8nwVCcWxBYNsCWwg0btFTinFD6XTtbd9bwnF1bav++WP0yZSdDOP3YmB4P3wJNHohksmz/JeL/IN80z4JgzFHW1tBGTPeFUShMUc/bB0Lk5jfsmi96m/VyNnDQpNQFMHW4g3oU9aC/IDScfss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2qxKVK9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so34696141fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732355262; x=1732960062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StUlAr6p77Gw1Xl5bleouTa+4voBxpVFLX0KT3Pnj6g=;
        b=f2qxKVK9iLTLFxiwxar2X/gN06vAb9MwlV/DEDxXux7kb1cWk3WO2IBQ/aCpA4VWQr
         wpUCEBL+O2HjoaEpke7vuD3NHxQwlFkl2zVKpfMSVJZLYPKn7udaCDPzGuYYCazBBvgK
         HusbPm3E7ds79KMHrSdGU4s6JG4cF2plUmibTE3es7PSI0oTIv7oO1/je97lSeCwK1Vf
         oW6jIdu8gMnUfwiO4WjW+1/1zymlAPeZhK3jo/0ayOFrUvxxgNzmo+t++hGyp6cO1R+A
         WHYxstoa0XDpLQu/fU7NfHB4qcJzqUfTF0r+wtWAgRN8Ut/FiB+UUda1KRZUudaW0KF4
         ZC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732355262; x=1732960062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StUlAr6p77Gw1Xl5bleouTa+4voBxpVFLX0KT3Pnj6g=;
        b=MaSJiNDrWLfrGVbWwJFiW01G7pxyE+G1Mgq612azCMeHvBNPKIEZlye8EKGDXeW58k
         VGlbMFa/6K1ntgEBEjwVwEebuJanNsM3d0tn5tLa7BFgUz+vTj+tAruODCc1b59Goyi9
         tiJAf4cQmJe/K5q6TT1ekl1gCr/ypKwt3FflQSfs3wt8R4yTB7IlOY5cLGTSCs0NSwXg
         vb/NgT+7d4e1mQg45cUigH264+7ue7GExlNPtX7kyPAgc6FBedV4stzEqhJ6GkYLlMNI
         5wTxk9Y+OPJq+2ItslczaBu65UjFQd0LAAwvOUDFkd61bZKo6KJLjHVbHyAhazYB7yY7
         DjWA==
X-Gm-Message-State: AOJu0YxlXMoxkVAmg06/5WkaZTQzWfjUFCcPTE3tUOXkolKOvi9izmTp
	3JpgGbxC9Gm+CtXvf8W1RZrEuowHTaHEshNeBWRvumLjmBtJXVWg
X-Gm-Gg: ASbGnctVDdWKHFs3Rw77E6KHtQwO0thlArdOLAUu1BFUoe/vu/hFM4QU3S008heYqO9
	M+UwlCel6mn6IHFs9N7YNuU+X45bMtK/0el2yxl5P1YrPFQJYHWPqjlHrmkBEoo18YLmGlsAWJi
	XP44RBog99+n/R3GylwwffoCAJxywy+bCclO3CInAx6I77iMfRVzGcNObjXIHGPM+5rrRWMUG8b
	rFQvNA0Sxc5ObXFbBhFdnakD+nkbA7qVNk6BuTd6MF5AKZqiJFj5oFOA7D5NNRv+A==
X-Google-Smtp-Source: AGHT+IFED4EXtryokWjqi11tEn3yvFfrmgLfyFdFW1l/DMA6NOv3mGtQgRYzxT/BKaCx2yS3PBy8pQ==
X-Received: by 2002:a05:6512:b12:b0:53d:d242:6bb0 with SMTP id 2adb3069b0e04-53dd39b6ee5mr3476480e87.49.1732355262113;
        Sat, 23 Nov 2024 01:47:42 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c2294sm1817427a12.53.2024.11.23.01.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:47:41 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: tglx@linutronix.de,
	bp@alien8.de,
	andy@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] x86/callthunks: s/bcmp/memcmp/
Date: Sat, 23 Nov 2024 10:47:28 +0100
Message-ID: <20241123094729.1099378-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241123094729.1099378-1-mjguzik@gmail.com>
References: <20241123094729.1099378-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcmp() is implemented as a call to memcmp() and callthunks is the only
consumer.

Use memcmp() directly so that bcmp() can get retired.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 arch/x86/kernel/callthunks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 465647456753..dda60b91944f 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -188,11 +188,11 @@ static void *patch_dest(void *dest, bool direct)
 	apply_relocation(insn_buff, pad, tsize, skl_call_thunk_template, tsize);
 
 	/* Already patched? */
-	if (!bcmp(pad, insn_buff, tsize))
+	if (!memcmp(pad, insn_buff, tsize))
 		return pad;
 
 	/* Ensure there are nops */
-	if (bcmp(pad, nops, tsize)) {
+	if (memcmp(pad, nops, tsize)) {
 		pr_warn_once("Invalid padding area for %pS\n", dest);
 		return NULL;
 	}
@@ -309,7 +309,7 @@ static bool is_callthunk(void *addr)
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
 	apply_relocation(insn_buff, pad, tmpl_size, skl_call_thunk_template, tmpl_size);
 
-	return !bcmp(pad, insn_buff, tmpl_size);
+	return !memcmp(pad, insn_buff, tmpl_size);
 }
 
 int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
-- 
2.43.0



Return-Path: <linux-kernel+bounces-517372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4DA37FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CD171F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6E219A6F;
	Mon, 17 Feb 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsEMpFNt"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67254218AC1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787480; cv=none; b=t+e6DXrQnjxK3LGfncreHbN1rqAps0BkpiLgL8D40qjrXnkWXh6p1ilmreub6iDdWKiWvdc9wk0U8ReO0/Sovj0uItL7kXPLzCj5Uyfqt0SoeqfPdtYzq2D6bkFuS6rxAEU8ViJeQhBbSBwVat4z3NZuiVz4bcsmhaBwu0ZOu6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787480; c=relaxed/simple;
	bh=61J2pu5l3ndGn9woBnkjvneIE/RD9R+0X2yrx5ajIWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPTEsYOs1hWLSjWznf6D9Wdiu3/uC8R18/uOQOpV9L+BLLHdMvNKjdzcZEui39+cGODHyPwFnNZSPDOXNG6g6Q1dUb1kTwHuV7316Ism28V6gtq1Y+z2SJhEKWuBtd6kdP1sr9ffZ6kNAFekRNNckSgzQaqZ7CFGkzyUOIponU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZsEMpFNt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so8072862a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787477; x=1740392277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldGwrx2cT3RoWK8xQPpncYSf7C74wmzaVDctYgnNzT8=;
        b=ZsEMpFNtgC8tqQQhhiNG9KGHmENdgB4rAu9TzSfsY1MSvj3kXgq+zR+OVmeyE23lfY
         hIOT3cC2fIbGcc3Hzbf1dVsmey8oQxNt9XMXlNncyUSDe1Rvj2UouxOZ4iGlTzGRBfoC
         pZksizHBgwUvweaz535oIlBw/CTWRn9nfeek0P3NytAJ/ck1PqSOG75pFOD7fYRIh3gG
         O6nwqs5eEGWqJfIuGCDSIw9uRuAMXV92lTqoOVNC9s8i3VuzuxUFB+lS3gs5+9o1ecq/
         Leib4/k/6UMbNc6yq9iTHWf3RDatAVe5pYDPb+fGwOIwr77wjdmuRPqiVrJlBvBC5gUk
         uP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787477; x=1740392277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldGwrx2cT3RoWK8xQPpncYSf7C74wmzaVDctYgnNzT8=;
        b=G8TkH6x08/Lqoyn0Xph0iCrmD4kI/EXsMm7bCIgzfalbWbBbcEDHqswUqtT/r28scK
         Wu7hpDsj8wkZWieusWYNTxJoQez/T+l+KqlmgNOu7D+07kqnccvp3ZgXUu9VaaHOsHcf
         K1w0vXALk8KS3OWk+/ad3tB+s6VxWW33+NojSBHgL++kJBUcY0vyESPm1OiEogEjkDSc
         suct4wmIPQ3gGpeA9yIcRNZ+n1S2/OMMRwvkInPyrqoX/cXeAkCRifZPtzsSVoJXQyB3
         Emvch201+KQfjm/Mpdu6mS/9iiJUvsLCyamGwaUTk2G5VbWQMLCPKFZuR9QLXuZdNKd/
         RT6Q==
X-Gm-Message-State: AOJu0YxN++EXerBwuuHltMO/pDECpKkIM4PD/zSai1qd4jsA/CCjtvjC
	AJ94C33Tf4NbOpiO/PL5Tbqw6FQW0ajUQp9YwVKR5pp9YCC4Hnj9aX2R6bT4tWjTRf8Dc9OWgaS
	ZGBQ=
X-Gm-Gg: ASbGnctw4n2e68RUeIO72pMN5xU4VRkInCyaMwFfHu1VvSlP05f8k51FTUxfYFgzSjj
	ajrk1q1izi0zBMAhrAh+vll/8HBJM5Q+vX35eUCqP7bPW9tDwi4VMN++2502XM2cA6DHuW38u0R
	6Ccz9aSgNzMgU8rqWKKh1BIHrAxZUfHjWu7TWqczv5Pg9BSagI2FuXZN9L6OigFSRyAUBhlXChB
	uLikWT3L1mieNMYD2KRauin6MH2DkjF1GRc/z/GHpff+gkQuPr0RiZIWVotu0fRgPkD2Ebj2xgj
	7BXoYAnlhECXMoJDQB2uHWo2
X-Google-Smtp-Source: AGHT+IGLJ6wBq1Q2Otx2cXUsLqwI686ZT/K4uXqflhPHhYRM3ByDKMZpdTFQUXVBYhqRHLkwN7a7fQ==
X-Received: by 2002:a17:907:78b:b0:ab7:c115:68fd with SMTP id a640c23a62f3a-abb70e61a23mr916824766b.53.1739787476706;
        Mon, 17 Feb 2025 02:17:56 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:56 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 07/10] printk: export symbols for buffer address and length functions
Date: Mon, 17 Feb 2025 12:17:03 +0200
Message-ID: <20250217101706.2104498-8-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

log_buf_addr_get() and log_buf_len_get() can be reused in another module,
export the symbols.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 07668433644b..022947f9b61d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -588,12 +588,14 @@ char *log_buf_addr_get(void)
 {
 	return log_buf;
 }
+EXPORT_SYMBOL_GPL(log_buf_addr_get);
 
 /* Return log buffer size */
 u32 log_buf_len_get(void)
 {
 	return log_buf_len;
 }
+EXPORT_SYMBOL_GPL(log_buf_len_get);
 
 /*
  * Define how much of the log buffer we could take at maximum. The value
-- 
2.43.0



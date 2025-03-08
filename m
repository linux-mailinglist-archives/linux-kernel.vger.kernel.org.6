Return-Path: <linux-kernel+bounces-552401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC7A5798D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4556D17299D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B44E1B4251;
	Sat,  8 Mar 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5m9xadJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30981B0435
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426520; cv=none; b=Wg5gcntFF2ytpGgn25IpdYLYGU1HxGxGWlLYyPlucZDOPnPiqczCMdg9mBmYpGiKQTJHHSQXYcO56WtgMn4zulso+N4WsWj/G50onsIul1RVai9BcQdlyGbzS50SU1wDfQ2yF2YRTVW5lPIVMEDrl/3N1EAewYRki3wfqd5tEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426520; c=relaxed/simple;
	bh=4TWWcOGt87pDlGMnt8USRTVtLWmp/L0eOPEnxcJOKNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUl2iBh9ot+Lf2qoDv/zFKJS4F1HLH08bNJivLmZi+dXWkvAU6ZGbTq/IAHW1neRo6RnhPm+HGf98CZF9PFDAaxKoAWuvYiDBJwxJV7j2RTgBWMuZkoTEJCp0mJSOX2Rh2qm/2NNmSwf6SFsbhdm1d9VYXfVxq2kcHY7SzDrSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5m9xadJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bccfa7b89so22328125e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426517; x=1742031317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egKKaEVuZCvmZpPyEYq1kxS3wPxzdvw1j9Mda8j6VvA=;
        b=P5m9xadJ8DaXvzYdtRXVqh3DFHppQcVaihmPVOTY2149v7raDRFyNl3wW0EtG/dVbb
         oaKQ+4WVPVzFw5RuPgMV7uUzVLcV/RFUpIPbovlzCTs8wJtzQtaQWGbrtcAyjvRTKxJJ
         xJ1bqmAAELg8VP6x2DYHIvKAkxVwFT9axSp3mbkUx8tyjai02bcJASA5UGi/HM3FYcKw
         R9nBhWzUJT6Qb5W201Io7Vgja8oiODP4bUEeZmJ7LjnTbAyrOEdIhiJNGszJ/o9NAhtl
         buq3BsOLcl7yUcpIHcod06adHl68fnD9AK/K364p3mXuBpSYL6s3U2VkUbOFavjRcnYC
         7FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426517; x=1742031317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egKKaEVuZCvmZpPyEYq1kxS3wPxzdvw1j9Mda8j6VvA=;
        b=DlbiX41w7GgF1mqAY19/XowJPShEswikC9TcwbOFhCImWwvgQbr/VqI0BuYm16GHZ+
         dI1zo+xipkDU58ognlqKvQHVq90edhrJiNrKFnsgskZtNo5KBZ0pcBfcMJEyynqSKDHX
         xK0W5fKkoBbg2VzDlIFSquaYSyrgNPEOdrOKNLL7qbQNNWriBP4VhkV1YbYMNHzn83GD
         5QQ7H49kOLUWCh/XUQhyWDxgH/jdwBRnIBP0he51+CrButcgy3RVbI45nFYt+mvLfJCQ
         Iz7KYV+C8hUiVLpniTr+7BgcNVGwiMzqLCSY1SwKu7ztmpgdsjVeodXUoXK5NmU0jwUv
         hNnQ==
X-Gm-Message-State: AOJu0Yy/j7mI72QVRuZoxbSAbEP/SsloP4asX4WMwlfANJTqpdFrG6VF
	EqqtxI3ZKcQ8ecEkbLqBkb388u79m2NI5xWpvh4/DyfsQF8gzvAVREKugQ==
X-Gm-Gg: ASbGnctMH6VXEDZBTuPy0szYaAxxHclNWfkQDDF+DFwcEWToij3V1j3+C/FwSu2FOcX
	Nv1QNEIa2yXNlMzBlpwmpl48u7fe88eQThFbjC/Aqpja0DkDWiTWPBr4l2Iv74x/oR3GMqhYbcg
	G5fhxCro+T1GL750BwoF+X4m4Mqle+1I3NtQdMtsC034lC7kMxhMuh+oGCOaFUf9kaY4AQxpPGF
	WpSvHN0nAew1ghc1oxbQOKpOS4WBMSlNsIMr4Wqvxw+lrRQV0MQlMRdym6NfJKgCUTcU/ubh7n8
	TghYOacAQxwCg5jDynPlotLmfDgbh49lN20V9Ad0OECqxyaWbpczmjaUKKM1CFlrRtPWaHkYrK6
	7i4MvTJiVupRrVaofeM9VIK6C1w==
X-Google-Smtp-Source: AGHT+IFdwfFvnAY318GElxbu6iJWO7wLPbhjDXVMUjbWTm33nvlc3UO4LXAbbtCyiNTBBEYfWr+Wkg==
X-Received: by 2002:a05:6000:144d:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-39132d98bc3mr5135942f8f.35.1741426517172;
        Sat, 08 Mar 2025 01:35:17 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:16 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	nnac123@linux.ibm.com,
	horms@kernel.org
Subject: [PATCH next 5/8] test_hexdump: Fix sample output if zero bytes requested
Date: Sat,  8 Mar 2025 09:34:49 +0000
Message-Id: <20250308093452.3742-6-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308093452.3742-1-david.laight.linux@gmail.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'len' is zero the expected output is an empty string even if
'ascii' is requested.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index ed6f0b0a1bb3..07a8cc7e9088 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -29,6 +29,11 @@ static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 	char *p;
 	size_t byteswap, i, j;
 
+	if (!len) {
+		test[0] = 0;
+		return 0;
+	}
+
 	if (rowsize != 16 && rowsize != 32)
 		rowsize = 16;
 
@@ -58,8 +63,7 @@ static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 			*p++ = ' ';
 		}
 	}
-	if (i)
-		p--;
+	p--;
 
 	/* ASCII part */
 	if (ascii) {
-- 
2.39.5



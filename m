Return-Path: <linux-kernel+bounces-293442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8477C957F59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0DF2837D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A9189527;
	Tue, 20 Aug 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE12ydb7"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209A173336
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138632; cv=none; b=e7g7rJwg9ei+zX6dFqTabOfQrMWuRM8Y3Ya6J0bO39fTJDwgAkjRFrgq3ZupLflefLT2du51rfsjQfyrr5hUcZq1fpkypif75sNvPajkeHk/cYKr4w3Cjg/fAB2FaIdKEk5eK+8G0HkzEk7Ee+JeAiLgCx9jkE8KYn8Fgn2TNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138632; c=relaxed/simple;
	bh=4r9KeDTziNOGAPHCxTYIYRDSVDQEQpFhz2wqohRB7U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvXP9cFf16JaW9QvZMj/5fzyjHp9dcFYsFZmsQg7QEqvC2gtH4rnOSfyt7NTikD/WgxuaQDCZ0TQzLEkExAdOqrQoe//kg391mpzThm8fKijwoMXHtFCSDSQWckz7AKqYIPS/U31i1fvIQ9SMH+elQIOfoO+HFYgGFgDeZGnM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE12ydb7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3ec4bacc5so2438857a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724138631; x=1724743431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rRClE5o1ghrjqlAP52ZzXECC06eAT5V2Ir4kIZTo/g=;
        b=OE12ydb7Eusw21lrMJx8sPhyaGJ+apB6R5yZlVU39GRc9Tkbv4/btCAZX5UeY/PM00
         /mHqQYaqRQk9iozlnyvq9cHV5lE5cRhdMDIe+HlUI74VB49QMnbs+KJJkLI7rWxja0p6
         1cxwGmwaJZVAfVcOsi5v+CbbPSnkiJ6L03lfmtORrPnkL2/WGVa8N/SaTiYWhZrAOEWq
         yfbResRUs8oYvw0BA+NmQvMWFgecgHRfE/phPIC1EsZEVULN6L2gQNAn61UwGjZ8LJQu
         bDIISG3uCX614a/2mEjLEbIyZXI0o7rLtNMvffL+lcPemHZpCYnOCszWqtAIQ8PgltOW
         7Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138631; x=1724743431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rRClE5o1ghrjqlAP52ZzXECC06eAT5V2Ir4kIZTo/g=;
        b=Q6wRzlU7IqjJ4CUc8A9vD+omtLwlz0P47dR5jxAcM3ok4wxrM0usoPCAef/282xViC
         bKQEFN2iu0V+UtydqPz/COrdhgvxHiLuKT1IaqCNOPQ/33PJ3Slr324uQ17uKUXge1x0
         iQoOTT6AIyTBbEgHzii7JJgdDU79GEF3xju/EYNV02CX5ZJAvq+c6Am9AVtKlw2wMRGL
         aPG21Rxh8OSPka42g/Bq8e6cCHQu31Q88924hIeiI7LNRKyqU6aDR679zcRs1F3bEN4T
         Acn4Pm0ibFv4QA+QXG+jGgN5xIKQwMeOj1bl7o+BdRFFiq98kpcy2XIfleUhZrqK1IyU
         Eg1w==
X-Gm-Message-State: AOJu0YzCZrrsbgkn+5e6yeNeMpfEXXQL8+puIs/TmOQKL3aVCnVOPOlN
	O1JGTh9nu+QsAl5ffCnq+YbG/IUhp6vFgdoPsIQktc967GSmRgv6HUIwm/fZwYs=
X-Google-Smtp-Source: AGHT+IHV95HUvk0k+It5inRwBlFT9Asjuh28yDJ/Nxxb9/sC7R1DZfK/mB2PHWrXzUyPVNuYDgW3yg==
X-Received: by 2002:a17:90b:380e:b0:2c8:4250:66a7 with SMTP id 98e67ed59e1d1-2d47320b63dmr3233337a91.1.1724138630629;
        Tue, 20 Aug 2024 00:23:50 -0700 (PDT)
Received: from dudes-co-ThinkPad-T460.. ([49.207.208.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6d16asm8642488a91.21.2024.08.20.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:23:50 -0700 (PDT)
From: Rajkumar Vadhyar <rajkumarvad@gmail.com>
To: jacek.anaszewski@gmail.com,
	rbmarliere@gmail.com,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rajkumar Vadhyar <rajkumarvad@gmail.com>
Subject: [PATCH 1/2] tools/leds: Add '-h' & '--help' cmd line options to uledmon
Date: Tue, 20 Aug 2024 12:53:40 +0530
Message-Id: <20240820072341.41153-2-rajkumarvad@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820072341.41153-1-rajkumarvad@gmail.com>
References: <20240820072341.41153-1-rajkumarvad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add '-h' and '--help' command line options to uledmon

Signed-off-by: Rajkumar Vadhyar <rajkumarvad@gmail.com> 
---
 tools/leds/uledmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/leds/uledmon.c b/tools/leds/uledmon.c
index c15a39c1f271..6609235d80b0 100644
--- a/tools/leds/uledmon.c
+++ b/tools/leds/uledmon.c
@@ -11,6 +11,8 @@
  * CTRL+C will exit.
  */
 
+#define	ULEDMON_USAGE	"Usage: ./uledmon <device-name>\n"
+
 #include <fcntl.h>
 #include <stdio.h>
 #include <string.h>
@@ -19,6 +21,7 @@
 
 #include <linux/uleds.h>
 
+
 int main(int argc, char const *argv[])
 {
 	struct uleds_user_dev uleds_dev;
@@ -30,6 +33,10 @@ int main(int argc, char const *argv[])
 		fprintf(stderr, "Requires <device-name> argument\n");
 		return 1;
 	}
+	if (!(strcmp(argv[1], "-h")) || !(strcmp(argv[1], "--help"))) {
+		fprintf(stderr, ULEDMON_USAGE);
+		return 1;
+	}
 
 	strncpy(uleds_dev.name, argv[1], LED_MAX_NAME_SIZE);
 	uleds_dev.max_brightness = 100;
-- 
2.40.1


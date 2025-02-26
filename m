Return-Path: <linux-kernel+bounces-532725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26EA4516C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0C216C1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB84778E;
	Wed, 26 Feb 2025 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcaDthCY"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735F383A5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529634; cv=none; b=XLGoYTSI5RyguBWwo7cX4NTEF2MtWKCb8RpLnl8xkxabY2BkwWFGp7FQ6ZXuBYuABmXgH3nt9hLGm+7zLJoJczKwParZL2Q4mZ9Aok0yMPHdM7C48OrUEdSZp1hwSyP4Whwtdabg2Zl9uThqik2z67CONh1eS+c10S7QmK7+G2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529634; c=relaxed/simple;
	bh=tQgJnKYGkMnbbA/wDCn3+cJc7NEMxBVFwcI2AOxiDU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kpe3IspFYxFAc+oR/d5Fz8gI+riWAXUILLEvy327nSwGdoOtBvJIeSn2/Xlf/B/F4KihyKu7isfTuVR1ApBa6FJTE755VHKazEsahE1ECJrKznlQyAjgqkKfYcn/D4kGDkMC4zp2HJEV92SyS+rUBMaKOpChc9rBC3p10CUTg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcaDthCY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc32756139so9641324a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740529632; x=1741134432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBTDkKhpQzNOkjeqjz5g1YE0mhCT5U0ZyWvRtu7wKPc=;
        b=LcaDthCY2yk3eDUopZhh2424yHorGD4vza1JYoFh369/+tnb46QHjKpDs69HqYPb/1
         gwJ1UhoiusXsJjxaBKS1XFliwrv2m2prKeQ28IFz1//UEOczvFPHDnMLn79lY0dluVav
         5GnGkvNfdSiu1/kKFpcoc8ZzlOdhN5NzrwvsPmrbIw8SLWw4n9OPrtjkefQL4eRavjnz
         eV8I1sMoxJzaKFdo2eO2aRZGa9m1aDXF2QVU4Soa94gS2M1hTBdF32FOlcaZqxMIDL75
         1CtDwZt/CHpq8Ju97nZwutn1NahEFQCEX6VKuxaqkFJ4vhoSQBikISMiLlOS5bZ2FR7s
         WMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740529632; x=1741134432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBTDkKhpQzNOkjeqjz5g1YE0mhCT5U0ZyWvRtu7wKPc=;
        b=b67jlDtXXtt2IS2IQpXYnLP6F/Kwp6iOGcctzwUrpr0vRdvKXR35OM7VUlVVIa30pB
         6/sRdcF2+bBJ238cLnDZ9UZJAPFOg6X2Bi36KGUQn48fNhlF/RPYRhH9fcDBDjZMT8Z5
         682hklYFFzXGYuTcDcOfzOQv24GA47gO5D+VFR9SvWIut7I2EvBsCnTvpKqxtPl/ntFm
         HCmhh57geR8PaQ/TrU59+Xb1kYYITjpdyltCP4LeDm14AtU/iDNoluTt4q2eohS9bdYT
         MBtxsRJI5wywE11nmHzM80c+ZErDZOZp6xtp/cKeiWAwd9Lg4mHFjDhNo0GMPh6UfCve
         y4Wg==
X-Gm-Message-State: AOJu0Yymc35ZmxMrl32CKUuEKaIsO9oVOHBuEpncW1NqZfXy7RO5/J9w
	kLd/nu4cugTykiBHb+FEiBKku7H/Q8kwh/MaEZkleEOsJidPVBhVBaxDtQ==
X-Gm-Gg: ASbGnctK8fITpmjkeEs26hWLD2fu/wR8gQpC3jSDoUQBsTtLpHcpL67SOeRS1RGgWME
	C7kNqSbbKBwiWR9lRWnvTrqnsqxhnKuZ/P8jKqXvjyfhv808KKWIbz/lHCGLq0pLCblvK9bwRUD
	u6Xp3iLThCHdYmASRBykH8P2YleblJKqvfAED3JIuPCk5tmDJeIKvoa2X6p8ULCXgkDdho4Y96+
	/HUmP1UtoXAZhSaZN/fKZUnGh1ZKrAir/Jc5wqofGPp2Kkm3hmJKG4HTAJsQV8FM0tfxpJkXkUk
	eghPSfkjsVeWyz+wN7bvW1/qLUf9M2By1fb8zcYKr+sua3JhaAL0VUgHzM0NSgW0GcBZ5ArPJls
	z2kG+d+Bb0lQErPsB
X-Google-Smtp-Source: AGHT+IF9o7+WSvhvFwKtOtALZtCqxD9D2Q3TZt5mFeY3aUlILjylLpvrbMqfW33jsiAbiO4bowQFeQ==
X-Received: by 2002:a17:90b:350c:b0:2f1:30c8:6e75 with SMTP id 98e67ed59e1d1-2fce875a087mr26635796a91.32.1740529632430;
        Tue, 25 Feb 2025 16:27:12 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:24d1:e158:5cf8:56d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b23e9sm20382645ad.256.2025.02.25.16.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:27:12 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: add ftruncate command in f2fs_io
Date: Tue, 25 Feb 2025 16:27:07 -0800
Message-ID: <20250226002707.358601-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

add ftruncate command to do file truncate.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 tools/f2fs_io/f2fs_io.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index fa01f8f..08056a9 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1887,6 +1887,31 @@ static void do_get_advise(int argc, char **argv, const struct cmd_desc *cmd)
 	printf("\n");
 }
 
+#define ftruncate_desc "ftruncate a file"
+#define ftruncate_help					\
+"f2fs_io ftruncate [length] [file_path]\n\n"	\
+"Do ftruncate a file in file_path with the length\n"	\
+
+static void do_ftruncate(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	int fd, ret;
+	off_t length;
+
+	if (argc != 3) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	length = atoll(argv[1]);
+	fd = xopen(argv[2], O_WRONLY, 0);
+
+	ret = ftruncate(fd, length);
+	if (ret < 0)
+		die_errno("ftruncate failed");
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -1932,6 +1957,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(removexattr),
 	CMD(lseek),
 	CMD(get_advise),
+	CMD(ftruncate),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.48.1.658.g4767266eb4-goog



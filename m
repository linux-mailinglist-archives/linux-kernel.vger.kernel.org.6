Return-Path: <linux-kernel+bounces-539213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC200A4A211
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8160D176BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2718277015;
	Fri, 28 Feb 2025 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0cWeGUn"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B42277002
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768481; cv=none; b=k7WL5K1ts51uO/G7aFn1gozM5erg3KwYj0IvcUomJbQ1n0STTg/hxxJ3jfGEMn7p3INVPNNpeiQ1ge//F+hQdEoNj3XTSzKopqUAwQOxQbUPltyHQpeDIC0AHACrSELlzMltGQfxpST7DWX9lkfZn1GHoQGgnQpDt3yS4fTgMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768481; c=relaxed/simple;
	bh=7Ax2R60DBU0bzgjtg/yzopptdmhv6jVuXKP23Jyuie0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gc/uPb5Odx6RcoYXeiiexbK7ZJCrAWhUAyQSQZCOdga8A3qAlzQPk4zFCU5/JG0MZMxYqrjqR7w7Hc6g+LHrfdzS3fVUAST76z6JHkGyqCbwlWfFIvyzbNgApcwi4Hq4f0qE0oHXfhVyCSnCa23CZgBRmrb+mJ9HQTJFOGHlq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0cWeGUn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso3722078a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740768479; x=1741373279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3dgsDqmXfnliiABPeZAGz8rEkw2FZi/RjCThCqfSpo=;
        b=W0cWeGUn7OM+qP3V3M07/qBFBBw+uzKYNW+ga2QVahlsIuMydfLVANHdZNw7q6DjwD
         a1JIPM7gbZGnTHxkBOmEwicEwICcv5BQkmXw34au8QG4xvQhuZCzGQC5ItvcjzudOaCQ
         WXvHpONJeMmHEvsUbsiA3hSkKSOoOiPMQ5HGO0uCRB7jsMAwJ/kixIK9lhtcJLmflgqM
         k63tY9SOrK+sZPIwglPZscrad63OXTTPpVdtOaguVnG98raGh688YZ9sjFjS+xldZ3ZY
         akUZEw9tDT+FpSf2vSn7q/Ai58KxciZqCuugXNsNw8T/qjQVz5fZMT04UEKgAPvXkzI0
         G//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740768479; x=1741373279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3dgsDqmXfnliiABPeZAGz8rEkw2FZi/RjCThCqfSpo=;
        b=XdfRLhRi+E2bm9Sz5Sqnp9/bq6CGAFHG0qDb66bX4l32IdNT+PJSvXBKRvXUaVkArS
         5vL6TZ+UhK5sRZmvnN7AcptbzucNFhM7fzsmAxrVrLECp/XDzqR276jKCjWFxywcBUVt
         cH4qmPB0xrXnfXqWY9jvLXOKQ1W59aLVWlPMEEqWn01gJ0P+QbazaD5LpdeqqjTj1tlU
         EG1hxb6UnrDdCptzYBsDduIS/APLTc3ODnSYMWiXsh9+NDt1x2kFkHcadlytdu5ogTjm
         M2FCIMf2qhIcZ+120tvrkOwuOPJsB3TY40lI5xPQA+P2aYG60r+ExJmKZKd5ZTQK0JfY
         zsZg==
X-Gm-Message-State: AOJu0YwLmtYyeqkOLwbCelm4LCDytwFETW/UCUrqMEv7euXj38ZtBGKu
	UZPKpOeqRfUAixQRbPUBKN8ONT2to8QNRwZHLnxbQzsfTpnvYOwRESL434yY
X-Gm-Gg: ASbGnctUU+R20dFlRjtrEhTc0UFd6rQN/i8ZVtdgBsFHi1Ab+5acofWOrkDMm9T/Lug
	MvvwnjjRpd3Qc/OIQXRaZFWA5aZRoYcifCaK28BXccBPB+x89SHwexZ0306Hr4/flD5DKyM4ug9
	WSOjaz27A045KHX+sVK/58Dgmu6AWh0fj0wlgjj4IRDtlcE9MMY3bm+H5h54XAsPENIDjwRNtHm
	q3Eq3MVmc0TxFriPGvcM6WA/JOMGRFIYRdVfZv49kkrFbR9ppgPw+mYLeBzu7tILwHzLOeszZqh
	fU78GXcnfdsE/IU6C0KYxVLhoe8tcYCUP65vVgYFsaYIiJq7xFBZIfsyRpdq7A/4jstewSz0PpY
	/QCdj5xygS1D1ThpNCQ==
X-Google-Smtp-Source: AGHT+IE0AAxJrN5/b5vWobqize86OydpOF89aPSPX1g8h8GWdL+zHxB2tvIYlSBKzE1qSJDUXslo7w==
X-Received: by 2002:a17:90b:268f:b0:2fe:b016:a6ac with SMTP id 98e67ed59e1d1-2febab71afcmr8040270a91.15.1740768478584;
        Fri, 28 Feb 2025 10:47:58 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:adc7:2cc2:39e7:4e21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea696d58esm4164285a91.30.2025.02.28.10.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:47:58 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs-tools: add ftruncate command in f2fs_io
Date: Fri, 28 Feb 2025 10:47:52 -0800
Message-ID: <20250228184752.1668252-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
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
v2: update f2fs_io documentation
---
 man/f2fs_io.8           |  3 +++
 tools/f2fs_io/f2fs_io.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index 2ff22f7..648fba6 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -180,6 +180,9 @@ Trigger gc to move data blocks from specified address range
 .TP
 \fBget_advise\fR \fI[file]\fR
 Get i_advise value and info in file
+.TP
+\fBftruncate\fR \fI[length] [file_path]\fR
+Do ftruncate a file in file_path with the length
 .SH AUTHOR
 This version of
 .B f2fs_io
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
2.48.1.711.g2feabab25a-goog



Return-Path: <linux-kernel+bounces-562678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7BDA630A6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10A63BCAC5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73552205AC0;
	Sat, 15 Mar 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="mUmkojfm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC917995E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059438; cv=none; b=hRzQWKfLnsGPlT7lKn2EV8YODKvLoKcip4dmUYhKikF8xsKiBdbsBgPwtrgrt57+8O2BPkg/xlMlMvLJoW7PLZK9BYaFzPjFkxGgX9AsSX1SAsGRl1hJcWsNBEWs2pxPFIxHRroCBocfH2MT6C0w+HuPD9Ys9ormmjy+tODqBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059438; c=relaxed/simple;
	bh=1PpG5wl2vDgUXZOFXh86OOBxn7Ar5lt5SQ/Ndxx/TgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOnhmJpKkN7Kz0k/KBRlXdbRmJfdWXl+Zf+FEG2gJo4XBFhCBRqANK5DUuVrhxpMCdUhJvQqLnXVeA0V/vuP20pB7X8jRUtMYFzy+NJ/WUl/qfCuQcFHoGuxNUkt6ATRbrIyC6MHeTBH2ph7WfuWwirkjSepOmU9Z16Rtqfg4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=mUmkojfm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22403cbb47fso55821845ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742059436; x=1742664236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgnlVIlZsctNY//AQHA0xHAjDyuSTMqzdv7gveBxpzM=;
        b=mUmkojfm4Jcb/yjrSlX2/J3IyGZbInyaXOMqgP5/oLof8lIGSJ6HRoZYeRiONfI59Z
         3OUXxBF4sXEP5gNPrld/1Y3UHULZ1TDJMruTeE1MCvgxkezjiAZUwrx1Wnf+L1TFW+ck
         fm/9ETpKMv45bMHzQdBToCzTYB0vqCiAVPeMNsC97JjHw7SlWWjWQTHvne4SlXIrGMbK
         KHxkekftWCtvV54bCCcANpfDL7krEAUXaiN+JluQ8g/KRgPm4H7o+zwDectpzfSg0WQW
         aNk65GGodAy0tDCRBmoEUYj/YrMMKj5CXJtYZBmUGlTsYyeHP80MqNeUQg8qDYmUIAW0
         yytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742059436; x=1742664236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgnlVIlZsctNY//AQHA0xHAjDyuSTMqzdv7gveBxpzM=;
        b=OAE/BlJyu+ZRyQ8VrAR5Om+5cs026dKQNIyiJ2kuuAsNRzrVvAXVm0wulKcqmtDnWM
         BeMZitXKC4zMREcfUigLdqOSNMNGtvFYerLhrRXh6ecgK2USdyRzMZId8Lz271y0WCSK
         AXXFyvIEMIdI5Fk3t2fxfv70ldodIrAS/a8Lr4nC9KPJZbdZmmLCVDvtxY6bFA2hlGuo
         +XrsFuJruMcW4BLya7gHQYgRoxi1w1AeSXqmMhfhv46eQPQWzON1tQaSIKmL/BhKCknZ
         efI9oF9/uXSQzMJmVs3JUuEt0jeAiE+PYu99kAggLiZ0PEn/KMIUSruOHb4dGJo4urdu
         K0cA==
X-Forwarded-Encrypted: i=1; AJvYcCX/TjU+3dGSwPqeDtiq8rYmA78eC6tsvDG2MZLWB9fNRqo729/HWFu3A8ixAUiwEzUhYffiur61KTPc6F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlhSPIQweEa5+5UsQej10EriJlc9SBzI6usdEFdFgYie5IiBiq
	Pdv9905fQID5OGGWW7qMOYuiDshvmskQEp0HgXPaTN9GLU9/hlQqBqF8QSKs4bs=
X-Gm-Gg: ASbGncu2lfIZW9YXLuT08DnfIfyeIrCbPdjLvzBnijgyDCebebgTVMc5MlSPN9ZGvGR
	g5/N3idwnXp/BUZasfQa94P+sswGZc7hbPjSBe1OY5O7deXc1B1ozPdF/Gvm62YOXlUBYkmvDpJ
	umJxJxbwBzuuWPDP9tGpafeA0xVcQGNaQSMRgUVrDZgxS5XpoDy8oV7P9871L9s30J+5AbxsZhe
	byReFpgDKm1Fh6CCldHq12uZBRaA8fNGDnQEjuwn1WNVBaeAcR1H2leM4hNTFdE9en+ufdBkddh
	w/CLMri2N/eLi63199dappPeQoaCSTd4g6PxzRYV6Q==
X-Google-Smtp-Source: AGHT+IFCDUOQgEkaQUJPOtUek3RyqU4kZwZOL0TnYTplGs1jgZy9U0ZODBK3dFkuMeQxYadueVihlA==
X-Received: by 2002:a05:6a00:13aa:b0:732:2923:b70f with SMTP id d2e1a72fcca58-7372237712cmr7727611b3a.11.1742059436632;
        Sat, 15 Mar 2025 10:23:56 -0700 (PDT)
Received: from sidong.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115512f0sm4673013b3a.49.2025.03.15.10.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 10:23:56 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 2/3] io-uring/cmd: introduce io_uring_cmd_import_fixed_vec
Date: Sat, 15 Mar 2025 17:23:18 +0000
Message-ID: <20250315172319.16770-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315172319.16770-1-sidong.yang@furiosa.ai>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_cmd_import_fixed_vec() could be used for using multiple
fixed buffer in uring_cmd callback.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 74b9f0aec229..2c7ae8474a56 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -45,6 +45,12 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter);
+
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
@@ -77,6 +83,14 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter)
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 315c603cfdd4..e2bf9edca9df 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -267,6 +267,25 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct io_uring_cmd_data *cache = req->async_data;
+	int ret;
+
+	ret = io_prep_reg_iovec(req, &cache->iou_vec, uvec, uvec_segs);
+	if (ret)
+		return ret;
+
+	return io_import_reg_vec(ddir, iter, req, &cache->iou_vec,
+				 cache->iou_vec.nr, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.43.0



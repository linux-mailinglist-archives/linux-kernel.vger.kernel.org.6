Return-Path: <linux-kernel+bounces-216468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3035A909FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C4F1C212D7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53B50285;
	Sun, 16 Jun 2024 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUDV1HOS"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D474D12E5B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718569969; cv=none; b=Wf2oy71KYWtJNdc6cWxFyqsaMborct7JvhY4KB4/BoJm/CWA+r40HNeIvgrf2v6D+QdTLa2qkL9DBbymlJnxN+QrA8lWUHmtfyNn+MOvfd3uGoKh1+H1h8L+8Um+A+92lmPRWxTRGtFexRQYp/XiYbmuDYWKBOeu7pD6X023DtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718569969; c=relaxed/simple;
	bh=ia4edk8RmfbVzS93m+pKUdA00RtrRqwyHnd3U5dDO60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHpUgW+kPDmvQ7a+rtc7x7Y0e9wHLaaY8fz1IxHqWA63hvKRtdhD7ruPEIL4T7okz0D0VLI2SgaXc/nsmZV4HPlwBEB/ZxDHfFSHa/TqoyYyrQ+XTCZQ+asAB1IaCFRi10FVdOVRcLEQHh2mo/ihHlAEOFA6Z/0XcpeKTpVvudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUDV1HOS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e3741519d7so2593845a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718569967; x=1719174767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ruQzJtdDUUq/rH+dZqwFNhNxz0nTDbK3w5CfEy2fEI=;
        b=LUDV1HOS5gx8/XYtlx/VV1kCvHtVTENF4zC6MBQuudVe6zobo3WkzEyIZXJfP70AdX
         J2DlVzmvMICHTGNxQVy4X2B3ToZG02GsZJn8PXnWB0rfAIAnyxw/S12oI/3yPuLWhec3
         avVyB0EyrR8dfFf/tVyE+7kR4m3Ljgqsfpee9bJ5nk7G3dxIyjpJpZUhr6pMuS6TN+2e
         4eUYG4iTmDO7kmmXjfqFlRBxPgXTKk22GYcFpqLiAQaHg5ad/k1pcjdJVrVMLrGP1ctL
         ZiV2/E+JLMxt4NHa6IY7Xc0OYTKjZEO6R4iMZpBhIlwcUKPL0AZDKVe4E+lkoCpHzddr
         UpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718569967; x=1719174767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ruQzJtdDUUq/rH+dZqwFNhNxz0nTDbK3w5CfEy2fEI=;
        b=KuxTeprqdLbsd1LQZ3jbnsfh0mMxFvA+ORRopqvRCxf+3O1AujPU59PA1/YYKd5fMT
         rnVLHjkdnqdDbxHiwzsXWwMiVKI34HNxqvnIRvoCknK0UlYe0iOPAePh7HpO/+1SqrXt
         zWoc5m3rEYXa4xioNP/K387Yev2ibOt+7PFP+hU0wMatICnag4atOJJHttb34+2LLb9Q
         xMYY56GHxus23lDyjRQZvwoX47md0OsQlYR6TVDmb3S/vtso4fq5JXaBw81fb6G/5WhA
         G9apwtpvtBrTYFbmOraZJLgwCuNMGOLlePIym/ZOXfbDbPE7LyrM7XCBznWsXVMCAkcj
         vsOw==
X-Forwarded-Encrypted: i=1; AJvYcCUEDNqGQjy/6YDw258Mu+j/ljHM5Bkr23Fx5R3EGkAIBhRCL5/TtA4HZsoWIrjWyCTdz5vkSlsoeX9FNrdBCIdpD6EPyWbWEJcF96Xy
X-Gm-Message-State: AOJu0YwAbQT9e7hynbTgKwtpP+zpaW8jMPWU3yvWhhGmhONoYQq4Cs5Z
	5coYWAsfDchwI2XpXZkdU1QLMM2aeMpF2hoqeSfsV1H5CXqnEc2F
X-Google-Smtp-Source: AGHT+IHttRPT+l3u7KhI0+XnNjSbaauE24Xxu5vcXgX8eJpy16mVVB7TSc2rxGcJwba3DyjXRzPUMQ==
X-Received: by 2002:a17:902:d4c4:b0:1f8:44f8:a364 with SMTP id d9443c01a7336-1f862a167a1mr94641395ad.48.1718569966812;
        Sun, 16 Jun 2024 13:32:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:10da:1462:6c5b:68d6:dcd3:7aed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee807fsm67611455ad.155.2024.06.16.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 13:32:46 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: srinivas.kandagatla@linaro.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	rbmarliere@gmail.com,
	skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	av2082000@gmail.com
Subject: [PATCH v2] slimbus: Fix struct and documentation alignment in stream.c
Date: Mon, 17 Jun 2024 02:02:31 +0530
Message-Id: <20240616203231.43724-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The placement of the `segdist_codes` array documentation was corrected
to conform with kernel documentation guidelines. The `@segdist_codes`
was placed incorrectly within the struct `segdist_code` documentation
block, which led to a potential misinterpretation of the code structure.

The `segdist_codes` array documentation was moved outside the struct
block, and a separate comment block was provided for it. This change
ensures that clarity and proper alignment with kernel documentation
standards are maintained.

A kernel-doc warning was addressed:
    ./drivers/slimbus/stream.c:49: warning: Excess struct member 'segdist_codes' description in 'segdist_code'

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
Changes in v2:
    - Removed `static const` keyword from `segdist_code` structure declaration.

 drivers/slimbus/stream.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..863ab3075d7e 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -18,15 +18,17 @@
  *		and the first slot of the next  consecutive Segment.
  * @segdist_code: Segment Distribution Code SD[11:0]
  * @seg_offset_mask: Segment offset mask in SD[11:0]
- * @segdist_codes: List of all possible Segmet Distribution codes.
  */
-static const struct segdist_code {
+struct segdist_code {
 	int ratem;
 	int seg_interval;
 	int segdist_code;
 	u32 seg_offset_mask;
 
-} segdist_codes[] = {
+};
+
+/* segdist_codes - List of all possible Segment Distribution codes. */
+static const struct segdist_code segdist_codes[] = {
 	{1,	1536,	0x200,	 0xdff},
 	{2,	768,	0x100,	 0xcff},
 	{4,	384,	0x080,	 0xc7f},
-- 
2.25.1



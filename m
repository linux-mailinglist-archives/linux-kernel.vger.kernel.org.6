Return-Path: <linux-kernel+bounces-409084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695E9C8764
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B22428549A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465391FA853;
	Thu, 14 Nov 2024 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="kFX2Bz/D"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF741F8194
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579248; cv=none; b=Hk5aAoiT5/cjf64DJHtNsfd20u0qSJ50d4prBhUpPIiZeaVdl5NyTi3w1LtycNCZ5fivR2NcqISvoOBhFGBVWmdSqo92f/PqUOj0LBDtBPRSTaTygHBat/VkVtjkaIkyUx4ORK9qFuVa+7EfredYp9esbLHA6PlDZ9mArq4C/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579248; c=relaxed/simple;
	bh=LzXQqpEuqMmSUJxm/liNxfQnP2SfNO/MZC1JIv85GOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSsRid6VqPt3Tl46s1yk0iWsomuQ8FSnNUPhreZoxntdDg5DCHi1pUMKUZsO9LF0pStFMrlFFm1uSE2NYNcV1zHpRquDRYb4MWujOWV3m3obPPjlAydscsnF/p8Y9mNz9xf38f+pTEkir6Pr6KMNj+taKZq4jQKLbKiB1Jdj2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=kFX2Bz/D; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99fa009adcso26970366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731579245; x=1732184045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ/zrN5sRtBVMflm7R+qmiosmx+ZNNh9BpAvkYEZgcc=;
        b=kFX2Bz/DMOe8Jn3Kh+Oz5s3J7cRspAkJwiNiX9/hZ0O0Z9ZJfy8/8z2TJZ7b68lRCc
         yGQ6LeOigQG63AuHOcAAHUfDFKfNuQzDpiStugL855EKzt0Z760m7PKWFM4VZ1K8Fuut
         ESJ6Jk2Hl1Alj3rHf6OaR7reFBCZ9Dm8eQgalpYBNtfZ3zJHyDlKKNy7/pKYiTbkyqEX
         AYlso8f2FSNcMSZC9BG4Bqz6j5jWW3ThmsadkYJ8acpgvu1TsKxLZoSXyEkSvvbqbozV
         FaO4OA1QdNB0ucKAUR2ZrqXRwZlge70pyQEw8a5ea+dAnKjsKSv3GleMx/NW5722ulRs
         a69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579245; x=1732184045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ/zrN5sRtBVMflm7R+qmiosmx+ZNNh9BpAvkYEZgcc=;
        b=lce9Dk0pb/Po2hiFLxX7PRtwnLFUisBpckvzvQ+abcdfO2dmSCFtcD62m4omj/ndfG
         /4p5fVwlU3No0lQ+677LAStnPiUh8CGdbozGj85V6/SXO+N+mWgiyqNJ4clbfGe0i6Cd
         pFbmQcxO+cjQ62uJOLaK+E8gsqRV8e5hUxX4NHczOulJNulh2DBEkDmz2P1zOowN6mJb
         ICWOhlB5ccUyJqlTZotLxnYPa9Efmrj4r5Q2qgJK71G6c2kbZPfESss/ttYWRdsA+df+
         h55LBHzUHvUtw8r0NmvAUtj4Eu0XD/dzQ/mxdlV4eAXBXso+8QGI7VxxyuZujm96zGZI
         0UlA==
X-Forwarded-Encrypted: i=1; AJvYcCXCFWIrnD5+p+wYqyaCrNANXSRJ26BF2s+OuZgj3Xsm7Wbqou1GZMt+PEviW/7WHUV6ZjnQJbjVCMAh9dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRlsCCspMxhP6Qy5Y9EWMlN0laFzon93me+6/YqooCgx5sH2M
	Sz+EppSenp2QMQtMFBi+8KA/ZLg3XdfvTBj4+WFhMYyPv4qyMRnEwFt3Ql7PCNb6Eu7PPgV0Nce
	thUU=
X-Google-Smtp-Source: AGHT+IFOIdhn+CO79i3SGeWv/TK5AejMCKm/AqH6QkLNChISb6RWLQC6we/lH0D4AeOxkuY6Je35/g==
X-Received: by 2002:a05:6402:51d0:b0:5ce:af08:a2cd with SMTP id 4fb4d7f45d1cf-5cf77ede3cfmr2170100a12.33.1731579244701;
        Thu, 14 Nov 2024 02:14:04 -0800 (PST)
Received: from ryzen9.home (193-154-230-113.hdsl.highway.telekom.at. [193.154.230.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26c84sm46139066b.35.2024.11.14.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:14:03 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Add missing include in compiler.h
Date: Thu, 14 Nov 2024 11:14:01 +0100
Message-ID: <20241114101402.156397-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A compilation unit that only includes linux/string.h runs into an undefined
BUILD_BUG_ON_ZERO(). Fixing that.

Philipp Reisner (1):
  compiler.h: Add missing include statement for build_bug.h

 include/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

-- 
2.47.0



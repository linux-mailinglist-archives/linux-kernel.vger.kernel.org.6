Return-Path: <linux-kernel+bounces-561420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD05A61185
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4323B85F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52F1FAC34;
	Fri, 14 Mar 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SNlztqnb"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2203C6BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955877; cv=none; b=nzurLv+/3wzupqrxF5mEMVwHURsvBiMTd97amZ50mJAjZ+5/chbYXwVo+nzXWdtnNDcVzdzcaObdkJMNX3v8SBOSK8Qh7tEJMgU/hUc23o2k7FBpR63n/w3VfqUHjk8Nj1taJrHTijFrMHF9ekStTLXZon+Cu6NG++Q/53j+dpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955877; c=relaxed/simple;
	bh=CyjMAiEeFUtNgSv1RAtmuvW70JbzJKcBVTy0vnupSwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K8EnD9VP5knMz43r9ONlYd3FN9qXeqlDoEWB3ap3wFO9sMaryYGaA0L9gUMRxQM5keWeIqs9kqcmhhkqd5H0XTU5hK/La6ljfPtt89c2cVIi8cCEHHBrsSTur2OzG+sBZG8txSmC68C69kXt8gzmgqDdsX0C8RStdvfILWDRWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SNlztqnb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so18335026d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741955875; x=1742560675; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHKlpL2RKV0yw156H7btRv6hu/hx5zQsm+jaj7sz2is=;
        b=SNlztqnb4OrwXw8HP7z4xJbpDVbvZCfEfPpKoqtLFY9iHpQU4hV9Zcstyl05ALHUCm
         56MtxxAm4lKtAVAGB/HH83jjhmj89+TKih4ibicDoyNlH/Y51/py3zKTRuOisA6vz5Pv
         UvEdz6V9mnPYOX6ZG7q0AI1I63EuKmgfOIUd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955875; x=1742560675;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHKlpL2RKV0yw156H7btRv6hu/hx5zQsm+jaj7sz2is=;
        b=b3geKwHFQ5m2m2MpWwk7Jjbh8bOJq6cn2fZcRTGqhyDJuI7FmubR+TUZj7QmRjrpsX
         C+JW6dJpxcz6+dlaFpHutM4a11QHIEinB6889B00064sGxVRoShKNSxCsiruhoWSISH3
         YWvr6J/eW5TmOGCY8TmxMzu7dW1Mef441xGOhZK8VEePUnHEGTsBFgLbGzMJTAoaAyar
         Bg2GisJMXCnLhcIj3zPThXS3oLXkIfLKZyHJcNLqlwJZLKO6CFu4FB05FsmQKPwfRLiz
         DTzhFDC44ssxWMJeMwHyok4P/shn14pyQjigG8nQ92XAyVK0LCkTi5gUsI79kEbJfqa8
         UbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTubSg420fwRz9sSrN98gh12FYzDrIFXnKwPGwZgdRpwlsiiEktuzOaF1E/71NQWTY8kfvo4PDmYSvU0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YXS84sv6Np4BphLZUTeyFKJHLLRLW8KOaveUHXRwFZupPYBf
	Tn3aZoDujE4m8YVDON7dpb/cwUQwt6gbVHgF9LjjRmnG9WVeHpSiQXr6Vnm9FQ==
X-Gm-Gg: ASbGncthAs6SrdN2KMZHKBMeZTThpNLwAEbMhhiXmEpKF7hO036BsuNcCHNpO7f4Gky
	aDkVj8eHoM38Heg5jorUT6xCHTEqX6T7hO5vPGjab+GBT6O+K9i8k0rF8f2UD6eEbSw7NBCDOuU
	CNRcgq4X5/CYjBR1dmCxaYWkrimWXLH7W85bNjVPfbVAoupNQQKxDu97HhNWdyi0f6XHAWb0Nho
	nrYkSNZkBGSwE1Pm3SAnpsjZ9ITvrU+7ula284YRZksKAnW6XAU4aCPwsJ1mbWsaEAxE/mI09W9
	tU0B1D/zr4kdJ5xJ05kADEXzDLR+wOMnK3DkDw+2mkLQVszOfQOXfgae7Df5snyfZw4HDLP4gr+
	f279gGyP3bCnokB2gUzvzsLmJ+prMcu81
X-Google-Smtp-Source: AGHT+IF4N5/K+n3WOj5VRJXsw726X6NC4n3Wb6cTFeYjOX0yen0c0Fly4FJFAXiEldxekv1Gjk3/5A==
X-Received: by 2002:ad4:5cad:0:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6eaeaa62615mr23084946d6.26.1741955875133;
        Fri, 14 Mar 2025 05:37:55 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24dda0sm23168706d6.58.2025.03.14.05.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:37:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: vivid: Add more resolutions to the webcam
 emulator
Date: Fri, 14 Mar 2025 12:37:50 +0000
Message-Id: <20250314-vivid-fix-twice-v1-0-7463c2b0ba63@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4j1GcC/x2MQQqAIBAAvxJ7bkE3A+sr0SFsq71YaFgg/j3pO
 AwzGSIH4QhjkyFwkiinr6DbBtyx+J1R1spAinrVaYNJkqy4yYv3I45x4N6S1obIWKjVFbjK/zj
 NpXwaV45rYQAAAA==
X-Change-ID: 20250314-vivid-fix-twice-9e5821142248
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hidenori Kobayashi <hidenorik@chromium.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Add 3 more resolutions, that are present in most of the webcams. Now
that we are at it, fix a comment.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: vivid: Fix requirement about webcam_intervals
      media: vivid: Add more webcam resolutions

 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250314-vivid-fix-twice-9e5821142248

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>



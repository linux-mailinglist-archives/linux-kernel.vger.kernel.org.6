Return-Path: <linux-kernel+bounces-561422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63811A61182
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF90168A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7121FF1CA;
	Fri, 14 Mar 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ct0fMGqj"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1B1FDE29
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955879; cv=none; b=VtffJCk+V01dQe5guIpFPZHf/aMaOWF/BnE40/dhjMkn5fL/4qaLQn9DS4CAnt/w2+NZ8SeQOXKIna1fi7agIZY29ehZay56bOFyU10R+S5r385L43YMDXqwnbQRW7buL8UWfYIGXX49VxuRQNOq1LH10JkIdcDoYoJGgTmXohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955879; c=relaxed/simple;
	bh=Z4vVBZrwdsora5jaavoKvH4SBMRfW+n+z+2ksvCX0uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsdUCNa6rgpfusau01Ikb7wQHB1vs67uTyOxQ9XD+zeCUKEEBzwmKO/eh550L1l8CtQ3j86Xz51U5wmoeBqzd8m0usiyU5jeQWJ7LHZsPGi8dE9omdvsu3JpLiiaeTs3dPvdU61QxUBNuVWx/w4+Ug2lXRga0igSGfteLuj3Ct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ct0fMGqj; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fce04655so18509106d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741955876; x=1742560676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Mt1R0EC3FYz66XqhH4MaCDZ6sflbyDD7zxn5LRYO4w=;
        b=Ct0fMGqj0Zq8y6F7+IU1iK0RUohll3LgpOZJf7Cidnyoh+M6nk52fghd+lNBG/dRPA
         XXBj0FYXMtZKcOJBMRKpx4NXtc2xWcJ3DRW9fg37sV7rG9bRnpqFWRvGGyNnOdGOkGWz
         1GXlZ9oBOGwt72dDKU4fD7P0gaNiR0YtC/Unk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955876; x=1742560676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mt1R0EC3FYz66XqhH4MaCDZ6sflbyDD7zxn5LRYO4w=;
        b=GmBNpIwN8kgNrOpPXcp1lshIL0P9S3QuhnqBiMjMKV9RYqJfT2FpHDOOOHmqfTCFHu
         YJa3KNgildhE79LcVtzpmQPv16FwmOC5jaBvLQggIHUXursN7tJxkE/N+YzuCwiDJAO9
         Tu9Bk82BRSc4Rx+DwawaAYkqcAjLkhmhWQxdtcc5xE8Nb+3UM47ACnTssgXsY/2j4Yig
         tULfgdN/htHi/wNIpqQu7rwnt/k9Wms8h7NWdYxThhLMLL9JEO36IsfWKfSQSfVMSB1u
         P+OAKEXTmhk4NqUfM+gkGYHYoig0P2Or3v4w7GX2uV3W1W0G6cyvXM9CnpWUdhwvvQJV
         Mwtw==
X-Forwarded-Encrypted: i=1; AJvYcCWe/iroFRWREv2BurbYx4TByK9dAp9i91RJH+7OpC7IpvvxNJBsumqOWkUY8S8OGwWvOLDy62A30qTd/nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOTHkT3FV87T3ICcFXdr1L1qpZhwqZ1bfsZeZK6lldekQbFQL
	tByUSPWtMA2+vH5wKscbyO0GUXdiCEVpUh5v56UJuy7eRKAsp/SzYVoDoZKEO/690HcvIY8vaY0
	xpA==
X-Gm-Gg: ASbGncu58MGYEYZll0k3WbpEG+wCp6dX62LiuJnTxlZ8/bup2R+jCe/p7wPyvDojD+g
	+EXgKQbwi5ssfP38B7d8YbMZHXIAYCKJP16olcKa4XC8aMQplSL92rtZLu4aoTWVEd+JmtXmO9j
	rSIer8CqUZqjKCCM0/O+8Y9zftB51MEdtt9eSm4Ga5MNdZJOit0YyirW7sp/5cSt1S9tR0tiWlz
	IsbJdEdG4qdHeGTs3W52NnaubCE4fXDycDZvaWHO3PXQyF/qKNAtSwZuOZ+52a6o6923csAvgUr
	1+k76i3KDZVhVuop/9MyS5FhiUNgk/mNXogl+AupMmYXpqIVx2S5Ee86i5ohyyQT4Um59UHu7g7
	4EfCpjUjlV0bCd4sZ6v2jCQ==
X-Google-Smtp-Source: AGHT+IGMU11VsoezNLSdINUAsRSlE0CW48Y+kQb7z5VQcOk1VIrvuaXDWSla6So21S8lMPm/2Jii/g==
X-Received: by 2002:a05:6214:300a:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6eaeab5a2bfmr28487096d6.38.1741955876613;
        Fri, 14 Mar 2025 05:37:56 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24dda0sm23168706d6.58.2025.03.14.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:37:56 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Mar 2025 12:37:52 +0000
Subject: [PATCH 2/2] media: vivid: Add more webcam resolutions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-vivid-fix-twice-v1-2-7463c2b0ba63@chromium.org>
References: <20250314-vivid-fix-twice-v1-0-7463c2b0ba63@chromium.org>
In-Reply-To: <20250314-vivid-fix-twice-v1-0-7463c2b0ba63@chromium.org>
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hidenori Kobayashi <hidenorik@chromium.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Add 3 more common resolution for webcams. This is required to increase
the test coverage of unit tests based on vivid.

Co-developed-by: Hidenori Kobayashi <hidenorik@chromium.com>
Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 623ba1e5e54791c0ac62aa2f0fcc3dcd444c873a..df726961222be874c39d19e1fb457bd816ab45fd 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -25,9 +25,12 @@
 /* Sizes must be in increasing order */
 static const struct v4l2_frmsize_discrete webcam_sizes[] = {
 	{  320, 180 },
+	{  320, 240 },
 	{  640, 360 },
 	{  640, 480 },
 	{ 1280, 720 },
+	{ 1280, 960 },
+	{ 1600, 1200 },
 	{ 1920, 1080 },
 	{ 3840, 2160 },
 };

-- 
2.49.0.rc1.451.g8f38331e32-goog



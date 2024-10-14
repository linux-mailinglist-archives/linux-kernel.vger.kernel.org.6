Return-Path: <linux-kernel+bounces-364081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271BA99CAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2AE282048
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621B1AAE18;
	Mon, 14 Oct 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CbkdEWNL"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F11A7AF7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910989; cv=none; b=R0lfo2jg8H0PMFSdgEK+lHzTiAy7YHDyvXIJaOyc5OTWeDTmJZibMid7ZwB6D8wtL9T1wueOSRNQhV/0kj/770YMBrifqigShpXsA9DtXZTMozyBWbJuwPwnab4ltftxANC0jufNP56j18yixWJg+UsKgB2RROMM7gQUg1jh4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910989; c=relaxed/simple;
	bh=dCK+DW1YbqRVuM/4/F40f1zS9DYsJ6d8yLlFIWV+hww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKl/6AQzxo0iT+Xh0izBISMeMVeRDpE4p/ljdfgHzdRE58iwo/Sz5+0hFoFBh0v+NS86qmrTM0CNMOOS88Mg02gTOERGiuUH74QI2Y9gV870GJBsOkp8gKiYJL4xPM6oN9RgFcUPud5jPsC+fqR66G8QmKVBVK15JazpCS73ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CbkdEWNL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so904551f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728910986; x=1729515786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJYNt081JK85+5Dhz0NObH0VzYCa5RTJdLoiL++atAM=;
        b=CbkdEWNLdA31yBsQdMYR2ve5aw713k31Z63PAlDSDrlM1nBeolnHkBqZvgP+xTdfut
         AAgi+Kub2ZUXjCxLHTk/jThDARJS/ncN2h7r55/CN8iWewe135XZpN5MZ82E+JPqPL8U
         IikgxfWySjNY+aOf5byXvteYhgfGrlRDvdQHX3DJQru5mWsXj6PVdQD3m6xridOo0/aU
         3OKnTIpKTBiPDLeldc0ozC3WtAVaifvfdcVFAGIvct+PYcz5b03puh62rCevdFzFlVOk
         8Ghwp25f9s6CbAHnnbst/uBV7Jblx76RuJuQfBZae1SGTmO5QAeLhMrUrD5XNPRl/1Lm
         eQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910986; x=1729515786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJYNt081JK85+5Dhz0NObH0VzYCa5RTJdLoiL++atAM=;
        b=ff9SW6MtU58G5szYqclmxFn91NPLE2x6hrTiLgYccS+C+gMhQPyGxwtYH+wFmugiyg
         H086HPdQ0TgJfLToEPyWUcEPMZu9OiADiYbRWQwPUlrTy4CDsoZFbMdtSAvlrsXc9At3
         FRrYrJoXxL64fq+Z3SifQWlamJ8SWIxvwFuslGNfLM8aIRaM+ZkIAMRnvVu707ySXhte
         SyK9FXGJfv6uguroAC9il1d0AuzXZPuaTrRBNu3VbNzcMqou78w06ab8rg5LvhkYH/b+
         NykDTZi4ugMFv4WxdEyaUgC4WrEmPz3N9FE4LKz2Jhd61E+PvJx4ymLcyjMiI20cU3SB
         Co/A==
X-Forwarded-Encrypted: i=1; AJvYcCWxehJohzF2R3Pzm1/Da9hKmXegAC7WX7SVwL6ZZBGP7hyVNlp4qVV5nThLOUF1JYA+VY8MH1y+OIBNKJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrfxHzyWb4R+A0EDcq7qAa+RK3/lIVkjdwJErHUj0B/kxY2xSD
	jC28ekgKn0tB9VoEqaL1/3ZwnACLsJgiboD2qRjqKRbFg8v+6kFGiZL4ZLLID0U=
X-Google-Smtp-Source: AGHT+IHBs/LOJaklozA5s6rUdu6NT0YhsseIgrE6DLZ49XBCQe2RyNV+MrhEXo64DyAswhy5eLPQvg==
X-Received: by 2002:a05:6000:1045:b0:37d:4a2d:6948 with SMTP id ffacd0b85a97d-37d5ff6a4d5mr5078819f8f.33.1728910986429;
        Mon, 14 Oct 2024 06:03:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cffa5sm11360500f8f.53.2024.10.14.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:03:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] soc: qcom: rmtfs: constify rmtfs_class
Date: Mon, 14 Oct 2024 15:03:03 +0200
Message-ID: <20241014130303.123394-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014130303.123394-1-brgl@bgdev.pl>
References: <20241014130303.123394-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The rmtfs class object is never modified and can be made constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/rmtfs_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index df850d073102..469e34864fbe 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -125,7 +125,7 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static struct class rmtfs_class = {
+static const struct class rmtfs_class = {
 	.name           = "rmtfs",
 };
 
-- 
2.43.0



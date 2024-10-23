Return-Path: <linux-kernel+bounces-377645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D689AC1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619DE1C24973
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42D16A959;
	Wed, 23 Oct 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D6+evchn"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105D15B971
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672563; cv=none; b=YSOFQaX/fHhJFR44/0yj45cLb4MVlUhx55Nzfngim3/E6FMMhE4Xx3anKmqC9U/F98kMMmH+EuHd5aR7llh63CnmvuO09aL9zXufWAbGNoD+PtThQT+xNpatvRK+AX+QDOxNitQhUZi8+73/Bxyu0H+OcWPFyqd5QxEaa+LUdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672563; c=relaxed/simple;
	bh=ZmqZesWkmKDpfQBS2PqvoTt9Lz68MjD1xrW+ajCGwx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T83156HEhA+IAGqvyBwWRD9/tLn1nIp4Qss4GKc5LBxpSsFrlj4DJri4aXEYvxNrzmeQ+yxTwRgWiAvFHYQ/KhVIhzNHAr1rSkOO4gGwZRyIu7FQEFkh6Ty/sWOydPTdANGWV7BKIABH6v3Rag8q3FXPHuzX3C3zDrZjMiTbnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D6+evchn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso57276405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729672559; x=1730277359; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QwvtoEQR5nwNt1/OFE1SknpUzsjIa6cmq9F3f1dlifo=;
        b=D6+evchniyiz35v24dBF4zhN6N0y+cvTJlpc6hIUUnGDP4TuIPNv5dwySr0KYXlmku
         6W3aBmwq5orhlrweabce/RRlgmmy4UkvXe7IA3AZjj3mD2PDkduVhvI2xnPb3DZ4lcCA
         JnyJjrB1yHxp1pTGL/CcNDg/6DqLDY6ilTUBrZoMLAdtdxMlYWZ6qiFXW3ozj2RQwur2
         Wmn+TPdVVRDYZKPDlq9obnuQ2pu6w01uPIJJIwIk6MHBoBEUqWu4j7Q7acHwCwbJByHH
         mnwCokktAdea5P5fGXs407JNQOa2EgOUhIL8tZcYOh0E1w+KTV3X6JohI9SLbPZkqOFv
         h26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672559; x=1730277359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwvtoEQR5nwNt1/OFE1SknpUzsjIa6cmq9F3f1dlifo=;
        b=qsyW89U/PiE1Gg138Czl4Ipr9WHTrKIa8T+vRtlGdZmX1ustvHXoAmlVanYGvRHC1V
         lJowcnCwEfc/UughCC/pPxyGOiYJC9eCf/c131gEXVdTagl69BpQ/T1w3xjrjv+pg5/L
         CfQWMn6gb27a6jfEVf3r8s4SVIuRQ/gIFuCfAFwprEVgDknMgMLVhNOImchbYuvH+JqV
         t26HIWGIr7pJStuKov0OR50nrW+kpswxP/k7+tZUzwlWZhoZgNDXQpXGqGwKVJoUJaAj
         NowUwjOM2NsSQ9zEJFNUeHoqhnBGUM2+5o6B4sdCmx38awIIq7gZAjXEHX0P268l+ejB
         91CA==
X-Gm-Message-State: AOJu0YyuheANGhnfe6RskNTVr4uURUmq6SP50IWn3TSgJJuc2XIjqLMJ
	S8MMOXRVLHq94Cz3wjbkY7wmgp/424DpBRJaFVUrtvNuLOSO6QeLhiya86f6ukHYF++Of6jtjFA
	I9os=
X-Google-Smtp-Source: AGHT+IEFAeQXMAMTJ1zUJx7LQYkdBCU4XtUnwDgxpeYebFYbZ+hhjyid+5c+1IbErnI4aqi//ZfEWw==
X-Received: by 2002:a05:600c:1d9a:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-4318412acaamr15084505e9.1.1729672559144;
        Wed, 23 Oct 2024 01:35:59 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ee3f:9900:c4e6:69d9])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8435736f8f.73.2024.10.23.01.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:35:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] regulator: fix documentation warnings
Date: Wed, 23 Oct 2024 10:35:42 +0200
Message-Id: <20241023-regulator-doc-fixup-v1-0-ec018742ad73@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF61GGcC/x2MSQqAMAwAvyI5G6i1dfuKeCg2akCspCqC+HeLx
 2GYeSCSMEXosgeELo4ctgRFnsG4uG0mZJ8YtNKmULpEoflc3REEfRhx4vvcsa6sVa6tG+8NpHI
 XSuK/9sP7foSFuCVlAAAA
X-Change-ID: 20241023-regulator-doc-fixup-76550a978dd4
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=679; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=ZmqZesWkmKDpfQBS2PqvoTt9Lz68MjD1xrW+ajCGwx8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnGLVrcCsYfsQUTysNncMOlbaeuc0nxAIjiApbb
 rW//TQ17YuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZxi1awAKCRDm/A8cN/La
 hfF/EACZu7p75yMqz00jX45nwCOZ5v/5ObIMaHQquRlgAMqfmBevovl5cX/BLOipcedVRkDI2qi
 qatx4jSoMPkg1UdcHmUWJ28CkEFH8NoBvKYrhibK6jo2pmdtV1tuhAC+GWOP77bzLjeD8J32T9n
 VWQzorlDoU4n0uao76jBYbqWrut1jT7Yb9aE3yJ9dwWbRjfNM7gKrVmLLpqeXaJfOIUKpTmjXMD
 wjeykGU6oTyjR/HRkgWEKwmkCxXH3hll3K7bep0nQM2d5Y6qJw9P2KqovdrKMBRzCeh96OaFiO2
 LMrXIUtHgn70U3izZ0q3ioZhBskUi2yAdczpfxv37daA0hrv/G635tPP7Y8rmXMMxvw2FRJ6nh+
 fBjUfeXGGCjsOuxcogUcSsyEL9Mdq/zLPtQDMuItuGgrFng24i51CpPKSkhRwIACzJKZFUlpP+Z
 Rf/7/VHcseCmP/TKkmvj/j4BKryv8WAEMMVr1rQsM8W9+tEKvcDj9I0deKIxTQ0H1wdCw3UkEAj
 VNvyXSWo2MJ+tuVFZnqu8GDjUp8cf5arL4aLf+Ma+uiQs7PtG4FE8oDTTde3sGYjxRpCPqV5dJ/
 Jj6egjGzcpojbchDMo4YViJbq8NTGS0ZaIK5Ja4iXciP4qfYy77cKmoU18LVrKZfzqACkA5AGcZ
 SOU14yzcuF9ghEg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset fixes the documentation warning introduced with the following
series:

https://lore.kernel.org/lkml/20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      regulator: doc: add missing documentation for init_cb
      regulator: doc: remove documentation comment for regulator_init

 include/linux/regulator/driver.h  | 5 +++++
 include/linux/regulator/machine.h | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 5ddc236d094d496bcd1e78aaa88bdde530073b6f
change-id: 20241023-regulator-doc-fixup-76550a978dd4

Best regards,
-- 
Jerome



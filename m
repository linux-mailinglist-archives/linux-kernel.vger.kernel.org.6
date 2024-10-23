Return-Path: <linux-kernel+bounces-377646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E04C9AC1D2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1A7B227E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993316F8E5;
	Wed, 23 Oct 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Z7cL3s/"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58A15B551
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672563; cv=none; b=nq+atja9YpNPumcqD+tLUGItylPmoL9SUvmRF1nUPZy1Z9Y1jCf/GNIe4OIyaZylnYKdsnjE5NhLwz92cAttKjErUEV+ovVpL72Lm48HO9UCQsKjPThj0kXNmGSxGQNjPjr3y9CeReHqjKCPAnqMHIcxNDJAhsaDxB9/r+pPSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672563; c=relaxed/simple;
	bh=22PUekDJ/BZBChqezFLIbZo+HIfdrQs6Vn6KTsob18Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxDLlePwQDRFyrNIOa0LtFmfHQd/fIAw/HmJNyaXitzL29ksrP+GChUqZUhmFUa0nlpa+5cbN3r5OLcAYGM1Cx2YoKLCI56Ws6IX6EO81bmNw41HQNTh/5dN6w2VbrIDAJe6X5h5bAh2jA1t9ExD2eCQBlsxPCEkB9cFW6Fe8C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0Z7cL3s/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d5689eea8so4332781f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729672560; x=1730277360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN0qSodm0TbBEMpCbusTzit2AiGW6RcmHnZPYHSxahg=;
        b=0Z7cL3s/H77zlZfn/Ewr4EU8GqigBBoYW7a7b8z/TzCGo1I6iJo5LKzhqBarcddSgP
         0CaFkexbhS4zgGO1Ig6NBQ5o6To4evv4mdr8N9CAzcfykGk47v5UYZjP/yfQWRKY/AZU
         KfI90QVFq8v+PSZb0WmpxmInRlGsftdnF4bIqpDLJCCIHF1f7KoRv0ZE9k/mV69hNtvD
         wH5pJ6HDS+l/0M1TZbIQSlbL/lybrzkv8a9pbZltSRBC4/6Z8vnjnPoMw2mgKAHDdz5q
         DlDVda4Hc910+NzxSHT6RZwl/BLZ6sm6Jl5oPjOIPUooWX+O4Si+PztChhdQ25M069S7
         U1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672560; x=1730277360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN0qSodm0TbBEMpCbusTzit2AiGW6RcmHnZPYHSxahg=;
        b=V1rSBoO7S3QjzCv7M4AYbsvzYuvFRjpPnoDwTeFrDRhm7j32AHAuCUL19SSPEIT7ZD
         8yDZmHkjf5wWNIns9Ft+LUpO5his1+ECK1/04aBwVjTms/PrqXIJ1W4j1eXlk8vXjyml
         7k2ZJZg/Q30m9qfz5/pj10ltdNE0N27NYd1WHZke8MOXdaBKW5v44yVXJNiXy4hEQepK
         P64e0IwPohH28x/pUSGZKFjdgCLiNYxNLw7FtZJ0564LP+utqXux4DVhs23JattM2fQD
         NUBFLrXEZfVuW0RGzAhzJK73ePKeyvbeVscZzH0NuqtXTVjPcMrmpRR2Rdw/vThulAWb
         08cw==
X-Gm-Message-State: AOJu0Yzk2Vw3JZ8dxrAWztuo+XYmauSKWjH4jtv97ey/zY9KZkUhjj92
	iOfEQzgGBKQ7NRodtp46B15bPhiQtfbIItbL9Aw/5h5OxuptRFsE+aGTa/XDE9PpOz57LlzKJpx
	e7G0=
X-Google-Smtp-Source: AGHT+IHHDep2W2DCwAiMlF/ZOG/3YJ2WQ8a3O7hrRncH4b83mpdG2ukmOottDIDvc3PTv2I2vz3c8A==
X-Received: by 2002:adf:ea47:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-37efcf0621bmr1374359f8f.23.1729672559941;
        Wed, 23 Oct 2024 01:35:59 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ee3f:9900:c4e6:69d9])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8435736f8f.73.2024.10.23.01.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:35:59 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 23 Oct 2024 10:35:43 +0200
Subject: [PATCH 1/2] regulator: doc: add missing documentation for init_cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-regulator-doc-fixup-v1-1-ec018742ad73@baylibre.com>
References: <20241023-regulator-doc-fixup-v1-0-ec018742ad73@baylibre.com>
In-Reply-To: <20241023-regulator-doc-fixup-v1-0-ec018742ad73@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=22PUekDJ/BZBChqezFLIbZo+HIfdrQs6Vn6KTsob18Q=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnGLVsOIt2Ry316NUNahy3C3/vrL5BMLuGE/tz8
 PeniTuKBwOJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZxi1bAAKCRDm/A8cN/La
 hX7vEACSV9lPfyllOR2FreSOn8rItQlQDpK+mLbecc6ndhBIr41RyTZ0TnVRbFCZHPcsq1pICj7
 OYyCscZe6/JlbNXhcK6Xsz5elO590saCkg2u1W+eE/zfwD61SqCW2AGWTueprGmy72A8r7ymBAE
 4aJZGTX6VP3kj+ADJVXhWk54JckFo2G/0wb1XZUOSZ5bMrV50mez6YCe7WmGOw/0zKFJkSK8YKe
 xBZxKAok8rgMOhjlf+XsqgnY3+6Z6Nd2YsSfiT+0frba1HNX8Ft0a0hjmS8msBhOszOl8AkZjXb
 xEXE8Au9xP0umjpC0gZrnl5SUmXBVMaONIXQw10yLaL8CPIRTf0w2fZvv1xoFu0FM8oZYmtlh4Z
 sYRgkeBhx74B/4zlnicbGX5p95YFR8/I0E5kcJEI/2JK7hvAzw5IFYM2XHfJJ4z/OUqtAwGNy9K
 l+N/i+e5WPun6vQV4lps538wN+tGHD658fyHfpSa30cyo7s0YpLu7+465p1Yw920ZLHkjnobOxV
 8NPkGUWBrtf9KzCAJ/5Vm5A93BO0Dya/F4OpZqXT7M+5WAuvoxFFBwgX7taXwin0gE2JOuhmPl9
 trEyXnOaMoyp4n4IhiopB3pycG9e48eCWQ5WhWewQjOUakjrNFncvf/dR/cA4+vabP2924ostp6
 BCwSU4Jd4kuclZw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add comment documenting introduced init_cb.
This solves the following warning when building the kernel documentation:

./include/linux/regulator/driver.h:435: warning: Function parameter or struct member 'init_cb' not described in 'regulator_desc'

Fixes: cfcdf395c21e ("regulator: core: add callback to perform runtime init")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20241023155120.6c4fea20@canb.auug.org.au/
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/linux/regulator/driver.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d2f4427504f081e28a0c5102f329eda48324f163..5b66caf1695db2ad27ed78cf6beb8ae55052b5b7 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -269,6 +269,11 @@ enum regulator_type {
  *               config but it cannot store it for later usage.
  *               Callback should return 0 on success or negative ERRNO
  *               indicating failure.
+ * @init_cb: Optional callback called after the parsing of init_data.
+ *           Allows the regulator to perform runtime init if necessary,
+ *           such as synching the regulator and the parsed constraints.
+ *           Callback should return 0 on success or negative ERRNO
+ *           indicating failure.
  * @id: Numerical identifier for the regulator.
  * @ops: Regulator operations table.
  * @irq: Interrupt number for the regulator.

-- 
2.45.2



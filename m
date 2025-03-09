Return-Path: <linux-kernel+bounces-553167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D5A5851F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542C416B2F8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA51DDC07;
	Sun,  9 Mar 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onsszDeH"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AD1E885
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532252; cv=none; b=nHML0U5MlSsnDobpsAjPBYABAaqKOCxrRadnJ65hkROy76BrTAXhpvN+RQJPfOG55spoVM+qQy7U05LCAEZMu2ILjQXmTjN0JBuVixhsEymzwqeUY+0xTdS37dPFnIqTev3WeqtETA6pLbD2Ry3Ph535ZByKiUIGtG27e/9lm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532252; c=relaxed/simple;
	bh=KC0l/ss0JwxRpgxTEM9LJu30+8jgTxoakl7UAcCPbu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tCdw2S84WFpmw+fJpvtJ/kj3SmQsY30ySaKkG3EVjnQ4/OYIXHsCsJxePifISQD+Hi30sK9K5c/hmizLU+1HhlvOY2//ufQwdwxcNf70cq1IFESZN6lR698p3FPFw8mvB54g/QdEph7kM/wjcsqyud1kIZab8ploH5M9wa8Dujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onsszDeH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391211ea598so1954103f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532249; x=1742137049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+JSJkMrwvFhUQPc5VJwS29z+GuXIGVUSIm/mnNCd6k=;
        b=onsszDeH8defE5NpFBW23uSEPOOJ/X8sMxB0E4fUs8ugTxxfdeN3U3FEYrvU4yXKyB
         vxSGdl96zmfsp6Z0+3alqVSRwKofANc3BHSY/Ahb5PxXMGyvtyK+AW/sEK5YggXoc0aQ
         AadhPp/XZWlNnW3XpxieZ1Q9TMwyeq6/6VMzAu6yssDGru1LY/E9rOCoEKCfveygPLR8
         dPivqc/Tpv+UnC0Lx9pTWzK0NZBtXmX5d583yhAvWrdSjv/1GC74relXgYU0ZTfqwFEt
         nJemrUlPAqTtRpqsD4/PLkD4uWm/4ujDHfuqVVj4JFQydKtjBFktdqB0ndi7RN3CYv2O
         ZHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532249; x=1742137049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+JSJkMrwvFhUQPc5VJwS29z+GuXIGVUSIm/mnNCd6k=;
        b=rfjtYOHYvKVB3EcpP3MfQkJ+4THaRi5WRzsKk1ztQnOPhmW9fWhalzDH9iYvaRb/EM
         2zcfM/aS+aWSKY+2hTZuGMEmpPgcGyFAbPU6RPAoCdTILlpOwCF8I8z4ujgwmyoihpSQ
         P83jNdkxCRRvIBFtZyhUOt7q822Xb4uBhOOWN8voNzRUIpHgYtM5CGVK9W9byDifl0iI
         KRZrnGrOpbphOcqB/yvtfkRdoXmdsWYRyd1opwUV3BDbLD0V5Wlh7E2cjYjrz459YXw/
         CP6ozDqHTUU/ipqtvWzmtHiQqLgKfZNyZ6/IqZLrOlat0KY7PJMrWtOHEV4EosTQttbd
         Luww==
X-Gm-Message-State: AOJu0Yyg84URWugyyJKDMm64vUW/8FuEbWcfdKQVcz/sFK+GQAxouYRw
	vRGtbLmNEzbGLpU4WI/O9UBV9DMqnuctvMC+vMQWz91QxRDsPSwePwELoXnLbNs=
X-Gm-Gg: ASbGncuqifpwNV6sufmEPbg1E5oE8PtvuhB8U3pRsjB76n55vgfrMXwCtGSsH25Vz8L
	jK9ZsCtZwLL77I74uChwv7NAtBnRyDiGNpuBWLuSK5hCUa+9Z8eZ8I8w0Sn3t1QNTziLuY3hYIj
	6U/KhbwFjMGHFFuc6gNgxKXnwaCVIuzulUmzE9iMhp7v9mFyxrqqTLqpvn3gTSAXvrsKpr5KNb/
	5C8ccUq9fFDhzngL31wQQqBIqZbkh24VO7Naljm5KIjJDgN/EP1Lq57Mskx0ELfu0s1PbfK05tM
	q/BPyoecrskyTLB6WNyz4Xyz/N0i51lJVkbrhQDFV2LNi2KjVIY4ECz+4dU5ZPzqSFhq2A==
X-Google-Smtp-Source: AGHT+IG+ir9Dkx2EVlMlkkSQjsEFFZMtFEqIgysFkQQs9w2zDwp4p/S2ELkX6gpV8RtpriR+ygkUQw==
X-Received: by 2002:a5d:64e9:0:b0:391:4873:7943 with SMTP id ffacd0b85a97d-39148737af1mr738709f8f.32.1741532248846;
        Sun, 09 Mar 2025 07:57:28 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:28 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/13] nvmem: patches (set 1) for 6.15
Date: Sun,  9 Mar 2025 14:56:50 +0000
Message-Id: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=j0jrUOf2O04vwZDzLO9nPSEgckJ7DwqAHTZ0StJbRU8=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw1NyqmwIjrvq/+/3AgySzaRV00wEWttmAZj v8AcoWrooOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sNQAKCRB6of1ZxzRV N6pnB/4gwrW7Uvj4n/6LaoCIe9Y7/pYFLQ9bDcLGpA4HptuqL47FwL7Wwq/fZAw4mDtBHVvbinC sRw24tnu89foHejP+sSKOit2qssV0vIG1nqZOGicekFU6MFu8R1OZDCj+yELYXdVd9Cn4ywGDCg YXVHknHIxeQ2lAFNj7DoS3l6y/LfewLYFWyTrazLizWFY8cfyf45WLEEh48mzodpH/+5ltZVgbF 2crSY20sSzFPKpVSIY29w01tQfbnTveDwv0nIt7ekit7cRLsWSJ4inGqRuqExITpWXVSve41IJx D6UFvLyTfnmY/r5xFSNqDhtjWL36aAGG96kQihnyG0WsqJMW
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few nvmem patches for 6.15, Could you queue
these for 6.15.

patche include
	- updates to bindings to include MSM8960, X1E80100, MS8937,
	  IPQ5018
	- add support to bit offsets for register strides exceeding
	  single byte
	- add rockchip-otp variants.
	- Few enhancements in qfprom and rochchip nvmem providers.

Thanks,
Srini

Changes since v1:
 - Merged fixup "nvmem: make the misaligned raw_len non-fatal" into
  "nvmem: core: verify cell's raw_len"

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Akhil P Oommen (1):
  dt-bindings: nvmem: qfprom: Add X1E80100 compatible

Barnabás Czémán (1):
  dt-bindings: nvmem: Add compatible for MS8937

Dmitry Baryshkov (5):
  dt-bindings: nvmem: fixed-cell: increase bits start value to 31
  nvmem: core: fix bit offsets of more than one byte
  nvmem: core: verify cell's raw_len
  nvmem: core: update raw_len if the bit reading is required
  nvmem: qfprom: switch to 4-byte aligned reads

Heiko Stuebner (4):
  nvmem: rockchip-otp: Move read-offset into variant-data
  dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
  dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
  nvmem: rockchip-otp: add rk3576 variant data

Rudraksha Gupta (1):
  dt-bindings: nvmem: Add compatible for MSM8960

Sricharan Ramabadhran (1):
  dt-bindings: nvmem: Add compatible for IPQ5018

 .../bindings/nvmem/layouts/fixed-cell.yaml    |  2 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |  4 ++
 .../bindings/nvmem/rockchip,otp.yaml          | 25 ++++++++++++
 drivers/nvmem/core.c                          | 40 +++++++++++++++----
 drivers/nvmem/qfprom.c                        | 26 +++++++++---
 drivers/nvmem/rockchip-otp.c                  | 17 +++++++-
 6 files changed, 97 insertions(+), 17 deletions(-)

-- 
2.25.1



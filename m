Return-Path: <linux-kernel+bounces-300448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD34495E3C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D34BB209F9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A6154BFC;
	Sun, 25 Aug 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymPC2Up8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DC242AAA
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595275; cv=none; b=WxF6G4rAnA+d1mE3Vr+RnIf8/MK7ecrb+37tzRjHx1RgcsRTVv0LcR6eH3ADPZny/etwD5lEDQiJqO8Sg/GO5TAgZD6fdifNRttaoGPXM3acAhYdCl02GZQBNdCrb1YQhYQwJmGUk2IGy0XRfsZgtNbJGQhUa3704j7iVb56xbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595275; c=relaxed/simple;
	bh=yxPhDatH5WUc7tuXzelfpRYfEptizh/+MwSKeXvQgIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jQ32N0uqcHOw4Hb5B7/LHUNT27QePKodXyaSvQdObjaffjY1DknhInL1afq+s2KQBAEi3U+ODia+XnGr50Ixb67SvAUE4u/z3bTCBrK1PRsDg5Xauozp6cGze1DloztCMNtSP5ySKV8cRcI0t7tdmS/jdsS2t96QW3ad4zeWAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymPC2Up8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280692835dso5406505e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724595272; x=1725200072; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoFcw2YSN8fNBQRdNUDdvu+2vkq76xrOuLe4i+hjOWM=;
        b=ymPC2Up8PIw3YSSqO9mKrSmECpqJbSeZEsUnRNNwzcx0im55BQ+NK3Tpb4g+LHd29x
         lJ/nx3SpmPjZYo/GAQfhIJO/6E+mmtyb4nCgsAmlA0/0wFGWNtI0lrrq9n7ZWchjMyvL
         95NpMBfPtm1BiiqV6MTqc+f6eU+1pk/Or19Kk0aUpIa+7djt1HsizSWTE/zS3VOwytsc
         VoQQ1iZEPO4JBm5H+CZDT0xdHI1UZXLnPwQj9xkiz62667wm9KmqzQMnsGob8ZcYZcgj
         hYNH4WxpTryGw0jO0PmKBjxgdWQ8n7i+XPFPD6RLKQH1V7LWwldS+ZbdgEMXetZ4PSH6
         +pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724595272; x=1725200072;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoFcw2YSN8fNBQRdNUDdvu+2vkq76xrOuLe4i+hjOWM=;
        b=SDg49rfZi+JYJqMU4TQZB3etphBTAKxu2OzoFxswFTPPpv/n2Xa3C4ETUmHlhP2Xfd
         HJrNZ/9g3uTPaAA9eRzMUDINfrXErZ6nmiZuECvPTSV3u1ewNvuGDMsKlgM743oiDMd/
         +3HEXkHI4r3Dstyx8rMT9jzDFBPGbp5vgz1UfXExTlBB7BSnvXBU7i8rea20UcwqLc3D
         XVyAv5/DrXDtpt3D6WBDNh3CNFu62tXwmSPACsS0iG34DrxSgfFaJuwpV6ZFJxSwn+X+
         24x4YCVJkIj3zBJ7bXLoFcRwPwy22Qz1/hY8hSdbWIlHma5YZOs4cgorm1+4A4vgNGJM
         0wRg==
X-Gm-Message-State: AOJu0Yy2B3a+eNrC37JLz1EYFES16azQGR93kal7ZqwyVtd0pJ1/WN56
	ypNmLx+lzJeLKzeXJ783P4BTegCrEPocK5hLaE/yzTDX1bS3CR+wDrHDsmYJJvE=
X-Google-Smtp-Source: AGHT+IHh0Ll1HP8N31WmwAl7OJfgJMORIGH4OQ+QLhHwtkBEZUZkP57+M7JOktPIULTYmTf2110+Ag==
X-Received: by 2002:a5d:6d0a:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-373118cec54mr2938507f8f.7.1724595272516;
        Sun, 25 Aug 2024 07:14:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162347sm122556045e9.23.2024.08.25.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:14:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] reset: cleanup and simplify with devm and scoped
Date: Sun, 25 Aug 2024 16:14:23 +0200
Message-Id: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD88y2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNT3aLU4tQS3eSc1MS80gLd4uT8gtQUXTOTpCTj5CQzQ1PzNCWg1oK
 i1LTMCrCx0bG1tQBYNjHeZgAAAA==
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=yxPhDatH5WUc7tuXzelfpRYfEptizh/+MwSKeXvQgIQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyzxBPdLr1mvgz+JNMlIGh2xNjNChB919QhZU6
 kvQ8y8h6bOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZss8QQAKCRDBN2bmhouD
 1+EVD/9IX0z/uMDEcCWffD+6AVh2mpulFnyUArfMZtoDny3TDw+LwhtG2MOgcd9dhJYuzm9hQa0
 APUdfdmV6DTjCyHzq1pxl7SZMVlcCYuqZqZce8CuGlKttARH6+KD4m5mHUnH+W2ABLWfS7SS3mu
 XS3nBC7x+ouFQ0Svd9hapBqTXq8LCK9JLd8Ih4PDKqnQdDlPa7Dy0tpDtAXOYmIwjj8Zu1fWjaE
 ngcLT48ZljMHLcUVfW7p9CAxLAy5HXOtTCG4Pb1jQyxiNSBC5s8GMR4MDfhGiHnlAiAYf5eevH+
 PvDTa3WQw3j/noAuW47zJIJE5OIdIwGGJdxjZ70UMryRLOiklPAr27xfF81UbVustuaFRdos0Kq
 TLgy9tVZ7KWlPEEGQvDholuG1prUa6R0jxTzs1PbWaEPXp6YQgSCUsVBeMdpsKzFxzCSvMOL5kK
 4yGW4Dc0ObHHDqRc8iUmAV9twMbsLmhvZaVNLQF1hMJkQpVtySBBJHLLBlJqfibxor99apan7y+
 rUvRW6WLc9RbzVydkFV/KmCByBGIfDtdjbIBWfzY7cjL22JYVxzwNEmaQ5P03BXP5mWK1wfMT2e
 QzrTz5sbuuzpJrtsigAVEgtr7rUAUdCJGZwlUrG14XjbBUM8SPL3eORxPod5QxdIQLSSTHDDUTq
 lU53/aEgBhcTKyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Two simple fixes, which do not cover real scenario (memory allocation
failure during probe), thus not marking CC-stable. Rest of patchset is
simplifying of code.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      reset: berlin: fix OF node leak in probe() error path
      reset: k210: fix OF node leak in probe() error path
      reset: simplify locking with guard()
      reset: lpc18xx: simplify with dev_err_probe()
      reset: lpc18xx: simplify with devm_clk_get_enabled()

 drivers/reset/core.c          | 15 ++++-----------
 drivers/reset/reset-berlin.c  |  3 ++-
 drivers/reset/reset-k210.c    |  3 ++-
 drivers/reset/reset-lpc18xx.c | 43 ++++++++++---------------------------------
 4 files changed, 18 insertions(+), 46 deletions(-)
---
base-commit: e706b1fe2384d38e6e9edfb6d9e11e26873c24c7
change-id: 20240825-reset-cleanup-scoped-64bb3cb6157f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



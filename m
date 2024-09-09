Return-Path: <linux-kernel+bounces-321959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6709721FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD441F24FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435CE18990D;
	Mon,  9 Sep 2024 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2NhEjDn8"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F818951E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907158; cv=none; b=TYI2aN+s6pd2DOYjBJCE/THxeWdPZOvokJPAyCRRgnBkIZbXv8o5Fby8YKWTgkvSGpVIqPtF3nsx2F8nttXnUPgA+dtYKdktTRXUyL5G+7aZcSLANsv64YtbY+/1I1RHBzfsJWrxRgterjY3qFqwnD3Zc0ofY4y2GdBZkFARBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907158; c=relaxed/simple;
	bh=iWrq6UBhR8f6M7tXQeXFemZD3ZNgfCl7tLXN1WTI6zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dO0OM4j3ZBhCmIddkqSlF49PCE/U+FSF6pdkN0GDImUkMpWHrNKY9diZGZqDmFZDSBnMjXburawuPJqnBvTBnqorz+NI9FmFncS41oJ5d2boPbOCSlxEMtaXLEt4mLDMgRS/P2huzqpSQsKa+ii6w1dc5nWv2OHoCFc8Qd0WD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2NhEjDn8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3770320574aso2863368f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725907154; x=1726511954; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MO+4DRAhaFYMqm8lS+Q2X93z6fwY26MweaD0Xnwgks=;
        b=2NhEjDn8q24wtMbpyLGglwnRUsYJsVYldzPkQhDvwHuuUrK/qWQc+FHWYnU16IJXhF
         WQJkx1fzn22pBuG26Jl988gGqzt2gsoaS3VzOREHrot33EBblBtntMxHk7u5BSrMzfrA
         tG0ZF0SIp1dl3+fzW29VtxNEEdIWx7TWiDExqlCP68l+Od5tFTe4XM3HUjvBnU4ClBBN
         nTg7yJUKZnaHvoGHydibeGbBQWT6ZWXu/bNXBxxVCHYDTsLRIvDyoppj2Ep/GB4r5HWV
         7nqlHRm63vfQeK5eqCjUAGuOqgx71M+IW+YWsjByqVJSSCrP0c+kk+jr5SElFfJysxZs
         SaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725907154; x=1726511954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MO+4DRAhaFYMqm8lS+Q2X93z6fwY26MweaD0Xnwgks=;
        b=NhTej232clCoR/o8VOQjymzfYBQNP0IJmJVISWGOhkrHsBE8oy9c6x2Mi4SEApllWJ
         TOehGl/lgio7TwPVHI1QyZf2NsnGZOJe1Y5v2jetnPz/0DYRruLrl1h0lnOxM4W53TrN
         cLzcpq5FnNRDfUcH2244pdt9GINPfe3DyY1xX7B3OHrA8NZYf2/zs8l+AG8KbxZKHOpM
         3/YEphXLhLQoPxI9fnuuDjQhd84gzCGdKjeIIlbuulx26kdBBXfrRgNR1E2byC9CUZwW
         OZTmgrmSy23W0kUSXMR9TkPZgHilD58UqYfyEpZYVJv4FHlLJguPtrnzeobQ8F7lt3SV
         I4iA==
X-Forwarded-Encrypted: i=1; AJvYcCXq32G1zcxupZUcy06Ta+dUmOlvalaQZeeUevxquIB7IIRXBzJdyJ22erzsUy4w6dPIjeDvwnuss5wG35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlc+PX2EWQSOze8Cp0WKpGPZbq8/jS7tSUEBQ7v1n0FnqLFTNt
	r6YrW319dCb3KxRHxvdB2JwD8u9Duhidk7Xj4sYu5xLkfeDd9uj+8EvAQU/WnPk=
X-Google-Smtp-Source: AGHT+IHWFSg11GYuEIC6afVJ27rnkhJSb1qtAvUyBztND7hgenH8trtr0vhUefpAiCF5RLzozlT0CA==
X-Received: by 2002:a5d:54ca:0:b0:376:5234:403f with SMTP id ffacd0b85a97d-3788954e720mr7658633f8f.0.1725907153487;
        Mon, 09 Sep 2024 11:39:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c15:247b:9be3:37a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653b0sm6731721f8f.44.2024.09.09.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:39:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] firmware: qcom: scm: fix SMC calls on ARM32
Date: Mon, 09 Sep 2024 20:38:43 +0200
Message-Id: <20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNA32YC/x3MQQqAIBBA0avErBswadF0lWghOdVAWmhFJN49a
 fkW/yeIHIQj9FWCwLdE2X1BU1cwrcYvjGKLQSvdKlKE5+vYob+2DY8zoDZkraWuI2OgREfgWZ5
 /OIw5f8ZktBRgAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rudraksha Gupta <guptarud@gmail.com>, 
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=739;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=iWrq6UBhR8f6M7tXQeXFemZD3ZNgfCl7tLXN1WTI6zw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm30DM6sEnSwIi4smIyF6fBYRN4ITvPFKsc4uiR
 RAgOrwU1VuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZt9AzAAKCRARpy6gFHHX
 cqXWEACND4Ezln2MdDnGK8+H7+VG1cpX4vqfcSdao26HtdmQE9tQ/FEcF5V0Gb0EoYO4gCnRR4s
 un4/d/ee4eicWilunZxSw1npLB/4TMXj3DS1M2YEZaanO3dgkaFMI6VYFFGE32ZhUViEQU6xLie
 97GDLYgXLLyFyrinsaWRZvreCdq0s2XyFi7mpYxmN5VqfhpFFQqxmv+vEkciHDsm7gmY7CSeHQr
 l9iQhaoiG46WIsAWo3+/UxrVUQml4xR7u6LSKlyZ4iHHBuoj+OKDvl3chbnMiKIHvxdMq4RzKcP
 5H9FqlVf2PwogVnT/SGVt9852IKCWMhC+ihI6p/qCva7qGP8jCYDV41/x/Yjd0ESDUo16ctXY5H
 HEADhUxTtwrUuBWLVXWwOsuTSsZMJjvvbNhagEIP+ORRXOLrVayU4/MUwfciJJ6Xq2ro3gojpZm
 CTFJANNTsyuKIG5fesJjvdc2PpGO9rqU9kRgGU/SObA4BaOmIzSAaFuP8XCTHUHSGMO4amf5rPW
 RRsnuYoxCX8+M7EpTU6bjIIiDfS8WuFehsJg9tIvpZdugn4uD+bwnE+C06iydwdRtFnxQUzSGNT
 ocAWjxHYGMvbhO+fNfQjt3hWa9kfc0XCdqX3qHjIAjbjom6/wJHavL2DYQ/R/R/IGoJwlXEnL3l
 B8qOFmN/OiuPf/A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The new TZ Mem allocator assumes the SCM driver is always probed which
apparently isn't the case on older platforms. Add a proper workaround.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      firmware: qcom: scm: fix a NULL-pointer dereference
      firmware: qcom: scm: fall back to kcalloc() for no SCM device bound

 drivers/firmware/qcom/qcom_scm-smc.c | 28 ++++++++++++++++++++++++----
 drivers/firmware/qcom/qcom_scm.c     |  2 +-
 2 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240909-tzmem-null-ptr-2a9ddd9889aa

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>



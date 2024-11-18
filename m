Return-Path: <linux-kernel+bounces-412345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC49C9D07DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C542281FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C92BAF9;
	Mon, 18 Nov 2024 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tygw5ctg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E8EAE7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896678; cv=none; b=W8MqqCDCaLxMDmWoSzkl4cc/vOLnY8/8gZQhKGzwCVYSLozGOLSnmfWfDkG1wzjMbNe0XuayXLrOsdj8NofGRACfZt+cuBtoH+KS463OSvIMov9J6DPxEfIj5o0Ou7RiOJ6ccqlerFSuqDt7QDroCDmue6yXoDg7a1C/U9Q7nzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896678; c=relaxed/simple;
	bh=k3eyVUgvTJkKbvoXpMka4VR0FOUVAWdTrp6FJEjjc0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rtDtg4UHLj3X9cxc4fhfhCoG8p35wdjxZ9JWWsr+bRTgkiTvX4USl78vQ9isADX9S3HoA90LVUBEIWGor7/tbOdXrnNV4pZ3ZAqaWB2LD7IQ9Wi2OPfCDi43whGPo0E96mTTvTzRq3F+i2jQqT0K+gDmMJXp1Rv02mbNGR3mhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tygw5ctg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3824a089b2cso49096f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731896675; x=1732501475; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPjgWhLQCkTakjfZhT/uUqtaJNKJd0vGZgcQQ4R7uyQ=;
        b=Tygw5ctgnQNfwteytDhRTYSHu0qKkLqgi0PBBggtGC2Iil+B5aWtYIPBe8JFGiKDom
         uR5DW3Wbs7oP8u0m5/M/ZTEybkB70ughhrMmsZgKuS7lazHEB0nSLV6C2LLnrXqa5fjK
         sJa8uZSkgXnBftHDHscXeZKH38P6hZnn2rHTCXpgYv+AQqVGjSLRTwpK/lBlvwRIUvcv
         jNOHN4YFdWt++JE/TmqgTgdTbBp8UJMSN+rax6J7wR4309QyITuZtyC4mkCFvBGk0jta
         7Fa3Q/6cIgTeEuw6H1XYbqUsXU8qM3BriOyPcNKj+Z94YxcZmdrjhnkPs5pYYIG11fuQ
         cgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731896675; x=1732501475;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPjgWhLQCkTakjfZhT/uUqtaJNKJd0vGZgcQQ4R7uyQ=;
        b=TRguFgrApA0cRTKRhXbE/0u8UREHSwcR9yqEY/t7ByTKY1dYmKyPIhPpxn0K10/JmV
         dFPlvhybsxqW5s4b+i12XYdXG8NGGHrx0pi/GuiHp+84ZBELol10MGgLAx3xNTsbJg20
         SXM7J3nR9mRKuXpJxSMqALFOky+VVUNSCEO+f1Ff22QxSZsXeP6kW53A3kWSsGJNVp73
         AKgqDVZNHhlG7NRS++chIgl1YkGWDS0Gq8zxm2uztLRmh4wnI+nZ+lxNHLh6gwvZWR/+
         tZkJay6n/2XyVU58wRY359cSHajamMhw5X15uZgihR4TY1Cy5EJi9rGmHMf3pKZsZcGB
         g8mw==
X-Forwarded-Encrypted: i=1; AJvYcCXc2JKUK8qNpfy4rdwprZY/HoyUKhUXU2mXrmIGCKHTRshIL4atKCkdJOgNerVepcFttKb5G8Ft6IZxRWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3aMM9QXvFywlDBCNWXfkl7ziGVgHvha54j5dEArr2KUBjR22
	xYp+Fu4S/1SqBwWUNCo2bQCtpK6ZCHNn+o5Woiu8Pqhtz96WE1wHBAl8Gtxgva4=
X-Google-Smtp-Source: AGHT+IHoVxhlL4UOF7WDoLOsycgCb1o74foUHlXwahjrJcecC+yRs/vAT7J/fQ/8T2Sm873bRa/fYQ==
X-Received: by 2002:a05:6000:400c:b0:382:3afd:126a with SMTP id ffacd0b85a97d-3823afd1568mr4338493f8f.35.1731896674856;
        Sun, 17 Nov 2024 18:24:34 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada2e35sm11387902f8f.5.2024.11.17.18.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 18:24:33 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] clk: qcom: Add support for multiple power-domains for
 a clock controller.
Date: Mon, 18 Nov 2024 02:24:31 +0000
Message-Id: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+lOmcC/x2NQQrCMBAAv1L27IIbUrB+RTzEZKuL6SYkrQZK/
 27wOHOY2aFyEa5wHXYo/JEqSTvQaQD/cvpklNAZzNlYIrrgw2IU3RoqtxWNRSLs2sfk37hscZU
 cGXP6csGQFida0Y3zNNng7Wgc9HIuPEv7X2/34/gB8bMFNYUAAAA=
X-Change-ID: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

On x1e80100 and it's SKUs the Camera Clock Controller - CAMCC has
multiple power-domains which power it. Usually with a single power-domain
the core platform code will automatically switch on the singleton
power-domain for you. If you have multiple power-domains for a device, in
this case the clock controller, you need to switch those power-domains
on/off yourself.

The clock controllers can also contain Global Distributed
Switch Controllers - GDSCs which themselves can be referenced from dtsi
nodes ultimately triggering a gdsc_en() in drivers/clk/qcom/gdsc.c.

As an example:

cci0: cci@ac4a000 {
	power-domains = <&camcc TITAN_TOP_GDSC>;
};

This series adds the support to attach a power-domain list to the
clock-controllers and the GDSCs those controllers provide so that in the
case of the above example gdsc_toggle_logic() will trigger the power-domain
list with pm_runtime_resume_and_get() and pm_runtime_put_sync()
respectively.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (2):
      clk: qcom: common: Add support for power-domain attachment
      clk: qcom: gdsc: Add pm_runtime hooks

 drivers/clk/qcom/common.c | 24 ++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.c   | 26 ++++++++++++++++++--------
 drivers/clk/qcom/gdsc.h   |  2 ++
 3 files changed, 44 insertions(+), 8 deletions(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>



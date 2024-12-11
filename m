Return-Path: <linux-kernel+bounces-440549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27109EC0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670E6162BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D409B67E;
	Wed, 11 Dec 2024 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N197tvYY"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC046BF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876868; cv=none; b=Vq80ML6SuJCxUjp5SFl3+7kSIR0AfFJ0bcFQP2otlXHq/lXwlQAE36Sy8RAT5f73zC9OKaMFKYjnzElGyQ3QN4SBP+LlAz5rHQY/jrf1lGDLcaz7CWP7lrFvUBWsmPRdNNNJ4FXLduQ4qxtUKVwSI82wQjAruCHr77yZl1k6D10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876868; c=relaxed/simple;
	bh=IZnScJCWw2di1Ucru5xjCCPYOOOLHnIzdIyVDGClIGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JPGA4SX8EenlL3dzn5+B2AIIyy4CTEnOxoi7zuHUarsqIGvH/34T7LSJ1xG/WNmxtDwYzI/kGKBcU4x3gJqiQiW8hmulPs/IGx81tBhniUu9hB6tzMFinJyU6Htp+0dkEzWBoAxThtmIy3cj9tjbTCow+G3/PgN6xKGn7DPzyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N197tvYY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so8116429a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733876865; x=1734481665; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHaGG875BMmdCURoXM8YuQd9zkcx4I7X8kS4c6Lb4I0=;
        b=N197tvYYVrqCF7ub40AbfKw76bBRnzQV0GIWLdwo6/+loJwJZLQhM9UaQGz5/gwxJh
         02+RzXpgt4l5S6UKX3nKR7NeHUdKgJ+z29w2i6XXft+83l3835Uonj38lo7Ug75aCqo2
         Voh/uaCWs7QxekMm2tI8g4ZUSON2fikPgLpgHbN9rCtXAn+2bOPpi/EWaTnL25Gmk59d
         TEjmKJ5yBAAtLSUN0TlThQ7FDtfmooot1ILE6BNCx+X6ZOtNzedqvY+zBADNcTuo25rH
         yv4JXfoFweDBD2HZPzR5qc3C1Ga99tA/FKsDHinQ9Qmezi6fXQktaHkYe746gmiVAaee
         aCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876865; x=1734481665;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHaGG875BMmdCURoXM8YuQd9zkcx4I7X8kS4c6Lb4I0=;
        b=jMQOK2wRipJqlf1biWp8YkjlkpZ1+nBHJvyv1YwCM5rBQSqzUxCNcD5M7iDWWpWc1t
         SY95vKcwzXREgZPK4p0D1IzuzA0SYgB6b/CuqyYLlkF/qvdaH28PvR902LmOKl2sNpFj
         GGybAZ9OEZ/0MNtY2oVmvC0Xrqs0xHCzS94ZK2PIubvHgtuMp8UAMfGKdBdWcMmlT9ah
         ugCQDDQ41/7EUQdP7JKviYDVy/eKbwYZYQDXRpHRaewVqLLPWRyOEDuC3w9rowVlSU32
         p7sckIb+FHx5/kqR5wJY4WOBCrHV9GOtQY5rd0TC38MwRJ42IO9xHAn/2tDIG9w2Dv0G
         ATYg==
X-Forwarded-Encrypted: i=1; AJvYcCXmK9GiFPt/Sv6z9ZKlwLomf2pu3HnHb/D6QHPqPy+O097kEVFCMVD1pgzq+e6dcMbJS3XSyWyUOoDydPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTpDP2x5ZGPLqmZXeBXs2wu5ULDv7G8X5pGDPq+Zc5HHyq4gq
	nKQJaUHfI5Ku/ALlxygx5fMCagxPqJ1mZGQq2sBLiS3N6+TGbxr8oSGA0Hx8+2g=
X-Gm-Gg: ASbGnctV0yQhEp4GpGRbNdO2c2mTM8nEpwLSd9+IsRhMIvI79DHnG3FbqAlWQQDwRaA
	e6EYYkoIFlNUiUXeYZbuH06Wr6fxtwmbQkWidJScn8nGxgR0CMcsrfUL73VHAmST9K11OJrm0+F
	HeBtATqUIdplW1ABsjTCNRlzQ2nIt5mNsLExRjIDfWX9Hov4h7+f+3mS8J2rWKmQwazA4/KACRp
	6JXtA9qH6ILhfHd6GPR1Y6Y12ZcXCTpM0b00ucJeO/OZLpk1IMfyLYhr074qQU=
X-Google-Smtp-Source: AGHT+IGFt9DkYm7YbU8JTE/bB/VF5FKaT5UXMIHMvwZPMpTwxuI0jZHM1ACAwI0TrBleY9Ufrtxb4g==
X-Received: by 2002:a05:6402:3546:b0:5d0:d84c:abb3 with SMTP id 4fb4d7f45d1cf-5d43316396dmr566413a12.26.1733876865118;
        Tue, 10 Dec 2024 16:27:45 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa97asm8155530a12.73.2024.12.10.16.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:27:44 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v7 0/3] clk: qcom: Add support for multiple power-domains
 for a clock controller.
Date: Wed, 11 Dec 2024 00:27:40 +0000
Message-Id: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzcWGcC/6XRu27DMAwF0F8JNJeFRVGPdOp/FB30SiLUsQzZc
 V0E/vcqmVx4c8d7Bx4SvLMhlhQH9na4sxKnNKTc1aBfDsxfbHeOkELNDBskzrkBR9Cm7jZDF+c
 RkIBzqLVvs/+C660dU99G6PN3LBDy1aZuACtPxyMFTxItq5P7Ek9pfqofnzVf0jDm8vNcYuKP9
 n/exKEBpy26YNBZod/rCFvyay5n9gAnXCEo9yFYESujlpKCjiQ3iFgjah8iKmKECjYIIZHbDUJ
 rRO9DqCIkyARqvFNie4lcIzt/IiviLRpUnpThtEHUGjnuQ1RFkMgoqxrjjPqDLMvyC6z9lqjwA
 gAA
X-Change-ID: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-355e8

Changes in v7:
- Expand commit log in patch #3
  I've discussed with Bjorn on IRC and video what to put into the log here
  and captured most of what we discussed.

  Mostly the point here is voting for voltages in the power-domain list
  is up to the drivers to do with performance states/opp-tables not for the
  GDSC code. - Bjorn/Bryan
- Link to v6: https://lore.kernel.org/r/20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org

Changes in v6:
- Passes NULL to second parameter of devm_pm_domain_attach_list - Vlad
- Link to v5: https://lore.kernel.org/r/20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org

Changes in v5:
- In-lines devm_pm_domain_attach_list() in probe() directly - Vlad
- Link to v4: https://lore.kernel.org/r/20241127-b4-linux-next-24-11-18-clock-multiple-power-domains-v4-0-4348d40cb635@linaro.org

v4:
- Adds Bjorn's RB to first patch - Bjorn
- Drops the 'd' in "and int" - Bjorn
- Amends commit log of patch 3 to capture a number of open questions -
  Bjorn
- Link to v3: https://lore.kernel.org/r/20241126-b4-linux-next-24-11-18-clock-multiple-power-domains-v3-0-836dad33521a@linaro.org

v3:
- Fixes commit log "per which" - Bryan
- Link to v2: https://lore.kernel.org/r/20241125-b4-linux-next-24-11-18-clock-multiple-power-domains-v2-0-a5e7554d7e45@linaro.org

v2:
The main change in this version is Bjorn's pointing out that pm_runtime_*
inside of the gdsc_enable/gdsc_disable path would be recursive and cause a
lockdep splat. Dmitry alluded to this too.

Bjorn pointed to stuff being done lower in the gdsc_register() routine that
might be a starting point.

I iterated around that idea and came up with patch #3. When a gdsc has no
parent and the pd_list is non-NULL then attach that orphan GDSC to the
clock controller power-domain list.

Existing subdomain code in gdsc_register() will connect the parent GDSCs in
the clock-controller to the clock-controller subdomain, the new code here
does that same job for a list of power-domains the clock controller depends
on.

To Dmitry's point about MMCX and MCX dependencies for the registers inside
of the clock controller, I have switched off all references in a test dtsi
and confirmed that accessing the clock-controller regs themselves isn't
required.

On the second point I also verified my test branch with lockdep on which
was a concern with the pm_domain version of this solution but I wanted to
cover it anyway with the new approach for completeness sake.

Here's the item-by-item list of changes:

- Adds a patch to capture pm_genpd_add_subdomain() result code - Bryan
- Changes changelog of second patch to remove singleton and generally
  to make the commit log easier to understand - Bjorn
- Uses demv_pm_domain_attach_list - Vlad
- Changes error check to if (ret < 0 && ret != -EEXIST) - Vlad
- Retains passing &pd_data instead of NULL - because NULL doesn't do
  the same thing - Bryan/Vlad
- Retains standalone function qcom_cc_pds_attach() because the pd_data
  enumeration looks neater in a standalone function - Bryan/Vlad
- Drops pm_runtime in favour of gdsc_add_subdomain_list() for each
  power-domain in the pd_list.
  The pd_list will be whatever is pointed to by power-domains = <>
  in the dtsi - Bjorn
- Link to v1: https://lore.kernel.org/r/20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org

v1:
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
Bryan O'Donoghue (3):
      clk: qcom: gdsc: Capture pm_genpd_add_subdomain result code
      clk: qcom: common: Add support for power-domain attachment
      clk: qcom: Support attaching GDSCs to multiple parents

 drivers/clk/qcom/common.c | 10 ++++++++++
 drivers/clk/qcom/gdsc.c   | 41 +++++++++++++++++++++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h   |  1 +
 3 files changed, 50 insertions(+), 2 deletions(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-a5f994dc452a

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>



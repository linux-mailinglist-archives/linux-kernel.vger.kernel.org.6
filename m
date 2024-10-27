Return-Path: <linux-kernel+bounces-383402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871FC9B1B50
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 00:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BE1F21B05
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E31D89F5;
	Sat, 26 Oct 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp0vzamv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338C1D5ACF
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729982562; cv=none; b=BE0pQjXhj3kmteG7vv7+hqPPfn3IXiME+7/I7DpxVcoB4ymyDOUxWs5CE91KUs9afDQxv61ahnJ8y41JwhPKlq3UwzWJFnKtMEshI9D+Pp6Gc4vojKW9Nr1rg0ZDviD316MvDYvo/LDyqiU7P/CbaR6P9FLhHcp7ZWnkAhmtYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729982562; c=relaxed/simple;
	bh=NJ1BLUzZziZQGnCcbigI1s7KVDxfC/rl5dNPdp/tBK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z/vroMuQIzC1kr/uzTISpSgcuq48wYd8r6i4yHTHrUyn54gGaSjvfRdXu2cz13g5lwLLAIC24AkMTSqMVVNifRE81aYI3pf8I+37cK8IZH7BNUpgslC45c9/VuGrE+hQnhLDWiKXkbiYCKIdoNdhHhe0te7fkBYHY9DKJcBEyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pp0vzamv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3804333e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729982558; x=1730587358; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JT7ynFjOiqO43ek3BlB2/z1cu90Cj9KPIONIRGCeLeA=;
        b=Pp0vzamvJ/XO+whIIP3QGXjuUVOrNF0Bhvq3Rn3wyk+ktCZys7CUHhyM4Z2uOxL+kN
         Zl5sDAtC7LnQmjjkbhxKH+5LTBFXT9L2GZcVwpMOBz4cWKSMPBYXlop0uH01j2V2jIqd
         uN5lrl9OxzPZpdyn+zgwOaYW6XDOaImZEMmJLDopESgCGKXaw6KKemif92BctNkeACt+
         duqUGqVDhHfnyMolinvCoVb5IxHuSvukVP4Nq2ity1Z7lOl+V94ZElch7y8tdRmRjpIM
         KjSVSI62NfjHrofSXtsmeSkYBBxpzHCpRrMk9O12HzQjMdBcm0aTPuszNLGrT7r4Lb7v
         Wf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729982558; x=1730587358;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JT7ynFjOiqO43ek3BlB2/z1cu90Cj9KPIONIRGCeLeA=;
        b=cAy0uw8ChDwpVGeuQDn2f3YdtaBcOUaklq0D8Nf07mLZtIN/mQBQ3C21ztRFK8aJNF
         AjxrcqGiFQ2b0VfJlXB6+Qk2oJQVjHGs0gc8A44IrF8dc6GXTZURi4PnsmZGWZ9T794c
         pP9dEhLqT5MO1yYloSk9ghDa2bbiw+yX+M4Pwyl2LmlER0xVZ1FmgZRmDTXQNP3dxvFC
         Z9qWEujtKuqcQks4RWDGGFXWqi7XtGtC0I8b8/8oqu1ZEAbT1Eg235ZeNgNCsuh6TZRE
         kefaGFk2z/H4o/Eu1jSdx4sBw858ghZg+c1twpL1bncQscYun89QOrAKkzfa2GEObOc/
         pFYg==
X-Forwarded-Encrypted: i=1; AJvYcCVEQ3itHl13gClpWH6UP1RyVgxzt4zkz28wsX3VkOFgE+5rRZ30kTpx9QjBgohJ4d95o9fL1etkQGqKs2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxURoGw5inS9sI/aeFlCJiZI8ed1lerasqnlQhVhU6XWEBXlQvy
	g+P7f17STNuGyFPYmJhb5vhPCOoUX8cpFDzQjHDbYx0vfk6TwsXFVHrIviyDPt9AXRGzSZGOrj3
	7
X-Google-Smtp-Source: AGHT+IGwKqjUR/k02327Gng/eBwtd6bNHoKMLWVY9gwxgoqMlCTJxjsbqoINsR0IHX5zpnrkFqF6mQ==
X-Received: by 2002:a05:6512:1190:b0:53b:15dc:f15d with SMTP id 2adb3069b0e04-53b34a31d30mr1523933e87.50.1729982558321;
        Sat, 26 Oct 2024 15:42:38 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a6a1sm610517e87.47.2024.10.26.15.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 15:42:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] nvmem: qfprom: add Qualcomm SAR2130P support
Date: Sun, 27 Oct 2024 01:42:32 +0300
Message-Id: <20241027-sar2130p-nvmem-v2-0-743c1271bf2d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFhwHWcC/3XMQQ6DIBCF4auYWZdGsIq66j0aF4Cgk1QwQ0PaG
 O5e6r7L/yXvOyBaQhthrA4gmzBi8CXEpQKzKr9YhnNpELW48ZpLFhUJ3tQ782mzG2td33bzMGi
 tJZTTTtbh+wQfU+kV4yvQ5/QT/61/qcQZZ50xjZD9oJzp7k/0isI10AJTzvkL2fVOEq0AAAA=
X-Change-ID: 20241017-sar2130p-nvmem-5f856d99bbb7
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naman Jain <quic_namajain@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=866;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NJ1BLUzZziZQGnCcbigI1s7KVDxfC/rl5dNPdp/tBK4=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHXBcuHP4SwKbHZeZ2cciSugk9uDNsgbgl4XX2
 cU/fmqcM/mJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx1wXAAKCRAU23LtvoBl
 uBGREACT8FYWRdpTEB+/uCtSOxzk70l6d8cg9eTihZoZUEFDtBKhgOXyLFiF5FYdzxWFTAhrZJJ
 0zshGxR0LdMpi/AWBSoLrScek5mveLCeU7GW3NfWlOeFAJjTmXWrrCbZkESqvgQQYnjK2Ufeeyo
 AAod6RIpNRwdkfXFVWYtBTL4W7cq48HTbcJB8U8R1BA4+qGb5enfyMnWtndYsVh7qatRhkucZ5X
 LjXObth8FqkNnHWhjdIt0RCN8jxzvU73QP8AANlspLzoxrHstMPYy0brrHx9Y6Hq8nndPOCIlwH
 1BkVRb1h/KXJjCBH84EPlk9YMrxf/rr2n6drTbEDqJKG57EWIF49gvrD6dTlLfHiSed7qulIIkG
 k10CZ6rcBKjllD2xS1H5u5U+5Uw8ubiWZ0sNUy+JrechUGN3Y3hCh6XlsUv4vGlJ6G5/o21rqCs
 cE9nVIzXj6TTGOK0ioJ0E9//xHcS8zl1p+SMYvZzQQhLmbBi7hbuptEAkVAll70/p0J44V+bd8+
 K95CRfmw+EaqtFWQERyoX4mWdhs7Yrb6seB6+NErn4yY8PtjICLEzdi2g0tg5uhikTtnXkPFEJU
 DNJnwI36awc8LlwsAr5cqQiFfntVOTC1vnmipxMZpBPejasAJpZv2zDM86uvprsMdKZF2nWxHOu
 NieHLaFJcXUkFOA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Pick up a fix from msm-5.x kernels and add compatible for the Qualcomm
SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Picked up required patch from QCLinux.
- Link to v1: https://lore.kernel.org/r/20241017-sar2130p-nvmem-v1-1-6cc32789afc6@linaro.org

---
Dmitry Baryshkov (1):
      dt-bindings: nvmem: qcom,qfprom: Add SAR2130P compatible

Naman Jain (1):
      nvmem: qfprom: Ensure access to qfprom is word aligned

 .../devicetree/bindings/nvmem/qcom,qfprom.yaml        |  1 +
 drivers/nvmem/qfprom.c                                | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
change-id: 20241017-sar2130p-nvmem-5f856d99bbb7

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



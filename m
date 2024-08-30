Return-Path: <linux-kernel+bounces-308392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC29965C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599F51F23B39
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D416F282;
	Fri, 30 Aug 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYkMPE5K"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F8172BD8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008969; cv=none; b=tdC5ZTMCBrF+UU3T5QNL2qQYpKlwfoqm21X6/lngL9wO5irz/jwbMNjNeLUBwj6uDUUVtW8UHbscsQghMmNsVWRbO6OpAj5aLKFjKGOn9eJ+5S8WbT87hyE/cKqPPefTrQvszb592j1PVjNLkPt+XRQk/WUgLwiU+pErsCUpBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008969; c=relaxed/simple;
	bh=fFcbqZ/vIeJ4VTNjMGaw5nvoy7YsGVIv1hnF2lSSras=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o3bL8Mh+d1Kl7vas7X+gVSyTBylG1TlwRlIdNGySFdLvJH/qZRC3yi62ZqeJhp6jGfcLCMHtRSoUdtHFrma1gHl0I1XwzE0+D05Tr366me4/a69dj2xcxQ5hvkXYlThTOQyQJgC9+6YMf3Y7ePFxkqLdBb4xkKMkqDhUFg9KGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AYkMPE5K; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83597ce5beso263823666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725008966; x=1725613766; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jtniPcEEBTRKcAWG7MfiUPW0tfxRZJxn6QjSld5MsQ=;
        b=AYkMPE5KEaYvHGbHDi/8jLYKwyexfJvnA+FLmM32SNiu1p9SVTnxG8vHc8wbUiWXTQ
         F6ZQi6idVn3kz7jWa4hYbUsfmJwet+saW2FegsQ7pjEuB0K+2aitgD22TyvudrzQ4rmd
         ANU1qmd49vJ5CrVKJyqe2oOH3qaOq+O0+ueHptnMTeOL5iWCbWK7MhVo2E1Kf3a9giBE
         25llPWYcp0gTIAcdFdkuiab9O1j1ZsU7ojEH+x6szNSJQFWCO+zySL5Msd0fsx7FFy/e
         xvwUmk60gJDC1PeFkCz2yhh0mO9lVtvTb5dvK5g1pVOZni/APjxN8blTLeUvtC1sUwq4
         1amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008966; x=1725613766;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jtniPcEEBTRKcAWG7MfiUPW0tfxRZJxn6QjSld5MsQ=;
        b=ZBh4n0fQ+ZjRok7uUhaJh+EBswvOsTMCKVdB16dNkn43GZNi8Z5Nf6CQfC2Dp6Ckvw
         D3Smt4F9UmuqUdROpx1Yk73casydf/5zVeqxAqdwoPxMyNS3FdgIXryozz9pxxqGZe5/
         NHD917w9URADOg9MNXdpvfNS7wudJR4wZcuXHFGmpGYaxLi8h1nruiaajmuDTyncJ6jb
         OcjO10FtQQxMNCUuHB2onpJ8P5ImTc/ax0QYn0RZwg32RFRWtsup42TDXXskw8xB8S73
         nRm+zvkmcl+uJYvTrSK14Bveiv9p8u8nF6gLdQ+lAvasw8r+UriYZrbI2sJ3tNMWjQ2T
         kB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfHQ/0QiOe3oa5dcb8NInJiuwf3WJ6NsfEOlD1O5AtO3H3Ztvcqozfc8ywuNQQbvkYdqh0ho0q8MaaNPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28fOjjsNkBQsNDlE587ImJov+NVoqKxYiUeXnksTPp+ye7O61
	ZqAluBsr6jlT28dAfI1pWhPww5Z5G3frNbivDJwBzQPQmTYnB+HB70X6pKSxKr8=
X-Google-Smtp-Source: AGHT+IHHiJzGies10GeD/T522u3rTjWbrbBrndvVaP8DwgXwoy/eAbJ2HNCrySNv/05wNTqDo8+X5A==
X-Received: by 2002:a17:907:2d21:b0:a72:7a71:7f4f with SMTP id a640c23a62f3a-a89a249ca36mr173053966b.7.1725008965594;
        Fri, 30 Aug 2024 02:09:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:c7ae:74d2:e4c4:8f14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d698bsm194860366b.145.2024.08.30.02.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:09:25 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 30 Aug 2024 11:09:07 +0200
Subject: [PATCH] pinctrl: qcom: x1e80100: Bypass PDC wakeup parent for now
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-x1e80100-bypass-pdc-v1-1-d4c00be0c3e3@linaro.org>
X-B4-Tracking: v=1; b=H4sIADKM0WYC/x3MPQqAMAxA4atIZgOpP1C9ijjUNtUsWhoQRby7x
 fEb3ntAOQsrjNUDmU9ROfYCU1fgN7evjBKKoaGmI9sSXoYtGSJc7uRUMQWP7eCsN477oYtQypQ
 5yvVfp/l9Pz6rARdlAAAA
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Maulik Shah <quic_mkshah@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0

On X1E80100, GPIO interrupts for wakeup-capable pins have been broken since
the introduction of the pinctrl driver. This prevents keyboard and touchpad
from working on most of the X1E laptops. So far we have worked around this
by manually building a kernel with the "wakeup-parent" removed from the
pinctrl node in the device tree, but we cannot expect all users to do that.

Implement a similar workaround in the driver by clearing the wakeirq_map
for X1E80100. This avoids using the PDC wakeup parent for all GPIOs
and handles the interrupts directly in the pinctrl driver instead.

The PDC driver needs additional changes to support X1E80100 properly.
Adding a workaround separately first allows to land the necessary PDC
changes through the normal release cycle, while still solving the more
critical problem with keyboard and touchpad on the current stable kernel
versions. Bypassing the PDC is enough for now, because we have not yet
enabled the deep idle states where using the PDC becomes necessary.

Cc: stable@vger.kernel.org
Fixes: 05e4941d97ef ("pinctrl: qcom: Add X1E80100 pinctrl driver")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Commenting out .wakeirq_map as well would give an unused declaration
warning for x1e80100_pdc_map. The map itself is correct, so I just "clear"
it by setting .nwakeirq_map to 0 for now. It's just temporary - this patch
will be reverted after we add X1E80100 support to the PDC driver.
---
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
index 65ed933f05ce..abfcdd3da9e8 100644
--- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -1839,7 +1839,9 @@ static const struct msm_pinctrl_soc_data x1e80100_pinctrl = {
 	.ngroups = ARRAY_SIZE(x1e80100_groups),
 	.ngpios = 239,
 	.wakeirq_map = x1e80100_pdc_map,
-	.nwakeirq_map = ARRAY_SIZE(x1e80100_pdc_map),
+	/* TODO: Enabling PDC currently breaks GPIO interrupts */
+	.nwakeirq_map = 0,
+	/* .nwakeirq_map = ARRAY_SIZE(x1e80100_pdc_map), */
 	.egpio_func = 9,
 };
 

---
base-commit: 128f71fe014fc91efa1407ce549f94a9a9f1072c
change-id: 20240830-x1e80100-bypass-pdc-39a8c1ae594f

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>



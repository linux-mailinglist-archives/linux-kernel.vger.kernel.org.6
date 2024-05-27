Return-Path: <linux-kernel+bounces-190131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C5A8CF9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83941C20DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6D1CD25;
	Mon, 27 May 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhSQqmj9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84212561D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794450; cv=none; b=LvU9w5GAns+SkbmHK4Tj7y6ynSL7rctnxtln/UR+jVhGTBYSBGc4ZBjFdUlFO9cX3MD+v9bqStA3/NSPKmtkaWTYDRNEs8RzVtW2lnDXxo7bpyMy+5IM106I9umuM4WtGu73nBo/Y+up73UMlZib1RHrPSufsf8DpaUZhWhcHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794450; c=relaxed/simple;
	bh=dZjdgueL6cvr3JXpH+eAzbdQJ3QnE0RMjGUz6fcosb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HcQ2wYFKaSQiFXtscjdVqU5woUhsXPRIilvxbLEyUfq8yj8JHJlglwRgGbnxKMIi4mrMeyrQx2wcf07NwStovDz6vYUrvAv3pal+po2ksNtlNy5JnckqNLg1FIP7B8JrVv16+vDTXBgmJVsHrG6tFaARHuFW/C2P7+iaEz1CfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhSQqmj9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57863a8f4b2so2405482a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716794447; x=1717399247; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkdVlAH7H727EJKfv8gTzn9ghdbfncnefHYXkt3aRf0=;
        b=JhSQqmj9v0oATCI4p1CajF+xsxIQPLJF4j5v5hzwnA9GUsP4Bnq/V0Av/xMk92calf
         T90TLou0Yh20KA9yAX+qWFu8IO2ICZnNEb1+BSWYA/onWFlItRmSwl4/nog+ix50rx8Y
         3I9dkIO7qKLz8bssHE0/xPe9d/hj88731be6I1jzCs/fAyLcWhlNC7BSx0XZ0O2z1DW1
         sNVh/CP/YrRsSi94lzXlNBdVqVsSeeuG/RiqasiEUk0hwqN7rzMJTbeAarzWtb2ddMie
         HOWf02lUxCOiqSojL6M0SJWD0SN+bOpd4mr5NxRBUZ1yfEBIDPBds4fSylVVhiqCRBCq
         BGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794447; x=1717399247;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkdVlAH7H727EJKfv8gTzn9ghdbfncnefHYXkt3aRf0=;
        b=rbe7Ypw33uPFCqxENDa3w6WmfakGX5zeeCw6hzwUtbDR20NLliV6fNkEd/ilvkNM9j
         ML8Ivxs5IPqoS4q5ZuBEkPyV47DY/QDUJVKEFyU4l0hkJNeKT3RDt0rS/FFQZ5Cqynl6
         wnP0OVYZbLb4ShatJ4cQynne9MktqoCvNXqKNcBatmDXmHn7Sc08Lo6toRVXIMBInpIJ
         DWVyPhi7MPhk0oxN5mb4xpwDV2syDzkkSssGhJnZ5MxGNxnYBPBBDuJweY1bhKr+/TI/
         Q59dcGJ+Fy2QVHOGTm/7/ApzopGwi3Pr4AGR+Sz/E1E9eo6OLtwMu2BioVQPk/ASjFB7
         r0mg==
X-Forwarded-Encrypted: i=1; AJvYcCXoorxqCbobG3ZXQb5xv2jhrUuXLCPcFuAiG9HsmbnkNtai/ckwOb+MKg0p1zT10l0RA0jAiOt7lLUXA0VwrCyxMPwfIlNwDxWLTnip
X-Gm-Message-State: AOJu0Ywjve86+1iIbNRWNPF7jpuOQHu7FQjZa1vm7Zkexw7QOi5+rYFH
	0Gkd3m5kKkRWi/MX8JOwvbBBmm3aJT5x7+jkq8opjQuXgc4CqPD2omATocb3+WE=
X-Google-Smtp-Source: AGHT+IHyXTPfpGiqJNGw/wb//hf46P2Ia3frMuqLeuTwELxuQnRyb4yg3XTxGIm8oU9MYPEgdl2oSA==
X-Received: by 2002:a17:906:dfc3:b0:a61:54c3:9f8a with SMTP id a640c23a62f3a-a62641aaea4mr581240966b.7.1716794447039;
        Mon, 27 May 2024 00:20:47 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e295sm457915666b.185.2024.05.27.00.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:20:46 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/3] phy: qcom: qmp-combo: Fixes needed for DP
Date: Mon, 27 May 2024 10:20:34 +0300
Message-Id: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEI0VGYC/x2N0QqDMAxFf0XyvEBSpo79iuxBbToD09YWxSH++
 8JeDhwO3HtCkaxS4FmdkGXXonEx4VsF49Qvb0H15uDI3Ym5xYPlQUyEafriuvWfMc4zGoaIQQ/
 0CV2QuvXBN0PdgA2lLFb+J93run4Xn5mDdAAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=dZjdgueL6cvr3JXpH+eAzbdQJ3QnE0RMjGUz6fcosb0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmVDRE0pYpvgLqgkNRQ2L6KXta0oULvu1fXPt8M
 tQtLQ1ovMWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlQ0RAAKCRAbX0TJAJUV
 VopgD/4iX+SadAWdpw3UjTZRH50ZqGTJl3tgu/GtYzd66CDmln4TwOguoD0w5awiRfwvh1XRfGq
 fF9+h7WJlLOj6cpRfW7exSUjaIUyAZRzCrGkWrmP3eWZsWcirkgIQrZU4PiXpNs3Mn/LBgqWjZR
 6Ii/+3Vb82tfUFIj5WjURoFODAbC5Y+ajan153dI8LfuytjvJCcjIrx20tSBRgcN1TOVrQmiH3l
 aB4PvUi3T7/+saX+Jp9LkNf5wwmiF5PhsoxjJsPzNYRC1DlMcuEWCldhJHcGu+W4U+zQUsNX70d
 1ebdLbXZ8tmTwN1sp8FliWsdYolPyBocAVFZLab69XEp6WFP1zM1UXd1ceZMYUDTDuOwUedoA7u
 V8hMRgSBMl9lCcdeAlPijp6YPewoOlP+H9Ff7+iww7UUcncwmfkm9wB3PAbaA90Ve1QJw5uknjl
 UTBjc6b5TuJrqFtQpOl/0I9Zb9pxguC2fBf7/tI2TnjzDxM4k8t6Hy42DTXzaaCOtqx3lqODhSx
 T8QhzQI/cjevJnpZm39grYZj9h2XaPOZviVWoz6Gn9gqFBtEZc61seiuotr2vZp9E4tI2yYd0tZ
 eFNUo5IiJSebTJy3gRNrXHvY6OKMRGIQKHOtRjZBmKJw7PEwlMZgoTzG7M597ErZLMpsNVR8Yug
 d9g+sbCFkjBC6ig==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

DP is not currently enabled on any of the X Elite platform boards
upstream yet. These fixes are preparatory work for when the support will
land upstream. The USB part of the PHY doesn't need these fixes in order
to work properly.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      phy: qcom-qmp: qserdes-txrx: Add missing registers offsets
      phy: qcom-qmp: pcs: Add missing v6 N4 register offsets
      phy: qcom: qmp-combo: Switch from V6 to V6 N4 register offsets

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 189 +++++++++++++++++----
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h      |  32 ++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h |  13 ++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
 4 files changed, 207 insertions(+), 29 deletions(-)
---
base-commit: 3689b0ef08b70e4e03b82ebd37730a03a672853a
change-id: 20240117-x1e80100-phy-qualcomm-combo-fix-dp-2fe57dfd6b56

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



Return-Path: <linux-kernel+bounces-524417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F0A3E2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BC51898460
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FF2135C9;
	Thu, 20 Feb 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STjaQMZD"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883901E2848
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073374; cv=none; b=SeSr7Ru8Sk+HXCZpnyRrocGuK+DXu4lUUhAQPD5GqHVW9At4LQ56fEJjvklUQqTVyOvAtiQd8kSEw7T9W+4SIudqIkaqFsrm+Fwd1ywtJ7U21fftPysrjZwnLyXK5psgKl8B5SOi17skUP5NFkW/TPO3X3X6IYn+g3U09NCkU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073374; c=relaxed/simple;
	bh=yv+7nS4jmbOfp98rdkRLKvJ23EP9E+LK1yT+sD3pURQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HixYDPfoIpXLf2oaKWpw+ApCHIB/i0ROVYKNnGsmg6uTlY16wPjb1ZWRbQxfAfiieMXr78Ttcf9/2kdXDOjYqwfcTXnBM4glGtOKIFSwuZ+PisL2gTmm89MlLcuGUy3X0Xpzy10b5JPZ/zQPbhkWh7bPrfizWIhgIPvDXtDkal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STjaQMZD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaedd529ba1so154177066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740073370; x=1740678170; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WY6MGz2rquwJRcV5RL2GgHgNIJy7CNe31ZrnCOkUQzE=;
        b=STjaQMZDaP0gxXlhEQhead+XTFRSQo0x23SwBBoLE6IshHqXv+AwEmcYCjTpfBcf9f
         xo6KL8usy0EvtG87oqDH8gVv8frvgm9kcd3ZsCWg5KPOvRtWZmnKZ58uFgqJVHGzPGxR
         DVkYp69atUkphUS9gvmN7qOeu5K8CYJZnY0fCkkN4STzyxVDcEcUIKGrlUyGtjrbAdiS
         3PZSSqrq6qGpxQSBhVRlkZriiCikCMFNrxgyGAME9dGVBJw1YfNYTeO3W07ySim+W/I3
         ivelXkAEjOAF/J+bEm86mUvg1trEbtJawCQOQ/b9/+dXlyQjk9/9NSO1QyNJnaZ4aU5u
         NXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073370; x=1740678170;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY6MGz2rquwJRcV5RL2GgHgNIJy7CNe31ZrnCOkUQzE=;
        b=t9FvR82yvImetFz5Kd4UWo8gv+1OQGgAYmcTc6Uddu58ajT5Hxa/DztL9MSuOfwN2Q
         2XchaUWOsn+XrH94RsW8Y93Mn3MoRjJ3yIteiKbcC5wtCUu+mX5fbUdWfHTZJeQM6U0H
         MBMBWWz4MgVJXw1Ib7QF6HWKNBlQO8GpnBRuSOabsG97AuhtFhtaF0QtYRvX3gyV+Mxo
         q0JZd6kI830JKmy15XRfRuhLc/lt509G6+nslurCtwJfPoksAbWfvUERlP7jWMDOneJV
         Y6yl9a80L85Nu543JjmTdfb8Vqx5AcW3p25oK4Wit9YEUCQwNwHZ8/dRFESnxTE0b65m
         5P1A==
X-Forwarded-Encrypted: i=1; AJvYcCW9trKRFve+OR/5Uah5Nfm6/S0r7ttzjCojsrrN9qNjXWTY41EeF43OjmVr3uv3eYlza6KIAfKv/QaaW8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwS3vLdmaF4SJ7icHzQRbGpAeENNeGjm1WF5O6x4N6wateMZW4
	puXvYMKyOvsE2yZR9432tvUIoF4KZHvzjfVUzABfXmaciUmvWbrALUrCkMJVHl+tRzaUBwEem35
	0
X-Gm-Gg: ASbGncvVYHLsy2mb3f6tMHxHRW6VOFcpQv6zTXwyUt8aXmzinbGrk/NJYs/OejWQ6hu
	T2iL5YVHbGSkcJl0s1HjnYnUG97hw6v4Uu5UjWy3zIUOluT/dVE+mixB2J3+8xP6B5VkC5oaJX5
	c8rb0XJlBfNrJWidMrZIAE+I1YdLHzOn9stbLWjmM88f7oFo4CsbUwdw1FrOcShe95f+pOOjLLi
	l3mVc0i4lxTywxyWEe6moPN1jMvz9jCXfbNp6UVT40NsBOjjcjUqWW62Ca2llrbIqpR99IPPFRp
	Yb8qnLcigxZx+g==
X-Google-Smtp-Source: AGHT+IGGCic5H8dbKxllODGuwh59PT6wMRxRiuH3+9PPFnm4mmjjx1fUWv6zjRIrF0o/8TynlHUNZg==
X-Received: by 2002:a05:6402:4404:b0:5e0:9250:435a with SMTP id 4fb4d7f45d1cf-5e09250445bmr16398290a12.20.1740073369800;
        Thu, 20 Feb 2025 09:42:49 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8190d1b6sm1014496166b.36.2025.02.20.09.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:42:48 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RESEND v5 0/4] arm64: dts: qcom: x1e80100: crd/t14s: Enable
 Parade Type-C retimers
Date: Thu, 20 Feb 2025 19:42:29 +0200
Message-Id: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVpt2cC/x3NsQrCMBCA4VcpN3twiYaqs10ddBSHJjn1QGO5C
 1IpfXeL47f8/wTGKmywbyZQ/ojJuywIqwbSoy93RsmLwZMP5D3h6HhLjghzNUyasbqNIZc+Phn
 rd+CEylVerIZrH1KObaRdm2EpDso3Gf+3C5y6c3c8wHWefw2WZsuFAAAA
X-Change-ID: 20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-325cdb7b097d
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=yv+7nS4jmbOfp98rdkRLKvJ23EP9E+LK1yT+sD3pURQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnt2mMUW7zhiHHheV4wQHmQqEaccDmsUdljcjOc
 OxvyCUlbPuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ7dpjAAKCRAbX0TJAJUV
 Vqy3EACHbgUqlVCCkn6PxP6fiSw8onlGk47j7VfN6KnhNPKg30UsWWiGfWUbgkNxoovu0DG6gJ7
 SjMl4PAMOakT+fqvP4EsVGjGKfbKviYA0exxLMRZUBEMrip4HXRUjdIK10/UgyUr4ed7Lj6BpHL
 kIUA06RB86xQAW6beOEtHqqx/4jjd1suSk5WJ9AJ/r/3WY2IjDss9ueHRj/Rjpc3b+FARZBj3m6
 ttP4OzGMFSb2Z8GXIio3FL+fdaHKEitxs6avl4223Y+RRm53pFX3PlPUdoByjM7WdpwiyKfKCUV
 wPK1fhtqacVkoVvWAAqFrvYOLmhzhqNglS2gy6P5TE3karUT3SuN2UufsYdWLqPF/vwObORNLx+
 pb/5G6S2f0kaL4GatlTlHMF2a3gLAgviwZD71InXSJDdktLDMoFHUQGWAtjaaoCKbW/9P4wiHBa
 IMrwbODrzCPpN7t1L5qMgpPzO4dkpEogATd+Zu1TExGql3fWdjLvXZmhqPOMN92Mn6UTrd2XxSN
 nP1Oj1zsY5bLgyUW4LfIoWbeOP/5YQzEYlVnnbZ1G3GcMwDkqWj10kxWTbmFwmDmb08/Oi+ubyL
 HEmCexvsH0B9Rm26BI7ThYCFYO7rzOsFp4y0A0WbAekj9mAdFh61xGa2xhz9iEpeBBojfc1zAo5
 RaKTp+St6KnyG9g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Since the driver and dt-bindings have been alread merged, it has been
agreed offline that there is no point of holding on to these DT patches
even though there are some issues with plug/unplug during suspend in
both pmic-glink-altmode and ucsi-glink. These issues are being worked on
meanwhile. Merging these means that even though this will provide external DP
and USB orientation, plug/unplug during suspend will give some splats
and render both the USB orientation and DP broken. But then, other
X Elite boards already have these nodes described, so lets bring the crd
and t14s to the same level.

These patches are just a resend of the ones found in v5 and dropped in the v6
patchset of the driver and dt-bindings.

Link to v5: https://lore.kernel.org/all/20241112-x1e80100-ps8830-v5-0-4ad83af4d162@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (4):
      arm64: dts: qcom: x1e80100-crd: Describe the Parade PS8830 retimers
      arm64: dts: qcom: x1e80100-crd: Enable external DisplayPort support
      arm64: dts: qcom: x1e80100-t14s: Describe the Parade PS8830 retimers
      arm64: dts: qcom: x1e80100-t14s: Enable external DisplayPort support

 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 321 +++++++++++++-
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          | 474 ++++++++++++++++++++-
 2 files changed, 785 insertions(+), 10 deletions(-)
---
base-commit: 50a0c754714aa3ea0b0e62f3765eb666a1579f24
change-id: 20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-325cdb7b097d

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



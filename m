Return-Path: <linux-kernel+bounces-557670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC00A5DC38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328B5168072
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F824290D;
	Wed, 12 Mar 2025 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="tcbA6y9K"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55923F39A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781117; cv=none; b=MJYvynfj+3FywPV5ZJsSSNR91IEAgDg4gxBdiIQ0dee//QoQhj3G6dNcaylvse6uA/STOugVPw7ykxknsWY/enTHwq3cN7qJFkXdMy5pZaXuixs13bpWu4CDT/L1poSY3pRJhJFBx3dAsmx2WtdZLbU1kuVyYSOEu7FaWMCVJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781117; c=relaxed/simple;
	bh=s18H99Qg8l+CBnR31Xn4OrMryEza5CUNK6AGHXXA8F8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q0K8YXgwtNOS9WjPHZeJ+hnVH1nlVVysQ0me/MiNq88weAN5Qma9csPH3tWEG7Q2PN6fnKVliegVt9bGW7ZtRLM6OlHOuLwnmPn62qLqU/RSGsPzV9/5mN4dLQEHUPOWLxk91fAhzst0VWeB6G65BfmiWmsoOonJKoQXcJSuZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=tcbA6y9K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so2501795f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741781112; x=1742385912; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/qhahxkC87okdK8vzcBKv94aryasTsuguXF0TtMtHg=;
        b=tcbA6y9Ko0x5I1zla4WCuRnqVdAGHiWV56EmoqmAiTYOT3WuCwBoQ4VGtLPjuJVqGq
         0M0hUP4mow2RH2Uow/JT1qZUAQmsBHtMSw22Xuy5VMkriZx0YOBIFcxLarEODNswe+Cz
         Y5/ZhPNWNMU+GNIrHBvt/GZ3Ei0cMLdwM3TKcrXpa7Mfyt4sb5uAxUAJslZGyr4AYWBs
         5X8WojC0jVY73FZQokvzAUtgAmhADCZzl1LVzhZFahFn32SSRAj7/praH2Pf8apNrrnr
         kPdI5fBcRi5CVPWiz6b57AVlKygKD0quuj98FNaqvrArrOBtHiewcmDC95Tp7hCDxnEJ
         dPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781112; x=1742385912;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/qhahxkC87okdK8vzcBKv94aryasTsuguXF0TtMtHg=;
        b=dfmxVziCVep4qm/wB2UbxQgQIQMn50/hKiif3Hnff4rNGxA40h38z1rnZTSawr5iuZ
         2pT7q7W9INX5LwmZoRukQozvogY56Y2zFs+2XQij2iLvsQFIjPls7XDNguhtNpfVO94d
         hY5iN0ogqrmqcQmgsejs+i1d0qTkVJIn+Ql2a7DrBnpzfqxVpHjXcluPBg2pp6+vCxzy
         dgmCra2sfoHS2gxL4Qd/EYG5MsDLGI+tLPs+yxhns2dFlnKEKinR9o7rvMa7yNSdPFky
         gcgBe408SG0YscGG0MjXJbn3b8NksWmJUXoXQsSuWp0cEcjKASuCVYKmtD8m9EhQKkpu
         7Qvg==
X-Forwarded-Encrypted: i=1; AJvYcCUxCe/AXCcP3A3V1b/UPH0Rk8RYKmET3Ra8UOruRM0uIyupXRGuGd7ZxddElNC1bBeT9O7nnxezj8CnDtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUyNO5GGfvti3aLPCVE7lO/T7+EWK2OxzPYFXz5frTx7XEZ2A
	KB9SWLqklZthw1rmNZAt/9i3v8WnAuh8uyUGzKpa880wBOv8Zxe6Pu4mf+qqqYc=
X-Gm-Gg: ASbGncuS10xaxTnpgGdHPHfB5yhmfROIZFhNdmForSUrUIVEpXKef1ZmNzcRpGwtiHb
	JlSIqCBJCq8H8OSAGOMt1o6+2RtPgJ8XQa5/z/HcmFKFp4L0flbUarLMvfa8leaTnPY3Y3DsL5Q
	EWneLn3sPaIQaJaREXh6x7CqQmVxMQa5CtEV8PmvQklMD7e3mOQ8vcMbO1vMzeyevutdfAke4M3
	IYU1Qw52lGIiNFhGcbyJ3dzOSyzeyutnrKX7NjaJ6f32BB8Z5/kPR13U9Y2btRekJbWrMww2u7t
	OvFSz+B7GjoBZOFVeAGkOay1rD1bU69tWmdqjdpH65b/FyiPaWWfI3MXrQlTpKAw2HL7wnVPdvD
	I0EUqKIoFc3ypJlk9eA==
X-Google-Smtp-Source: AGHT+IGC4xxP+Z3Fdvh6MXVOV92VRfrBtvnApHrB/c9+vstSSu3u4t5eJnb+88jYtJPAaZNUMHPC5w==
X-Received: by 2002:a05:6000:1542:b0:391:a43:8bb6 with SMTP id ffacd0b85a97d-39132d8cba3mr18453006f8f.33.1741781112389;
        Wed, 12 Mar 2025 05:05:12 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb799fsm20810608f8f.2.2025.03.12.05.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:05:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/3] Fairphone 5 DisplayPort over USB-C support
Date: Wed, 12 Mar 2025 13:05:07 +0100
Message-Id: <20250312-fp5-pmic-glink-dp-v2-0-a55927749d77@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHN40WcC/22NQQ6CMBBFr0Jm7Zh2kEpceQ/DAsoAE6VtWkM0h
 LtbWLt8L/nvr5A4Cie4FStEXiSJdxnoVICdWjcySp8ZSFGpSdU4hArDLBbHl7gn9gFJm+5qVH3
 pmCHvQuRBPkfz0WSeJL19/B4Xi97tXqsUkflTWzQqZGOM7svaVGTvQysxTN7x2foZmm3bfnUqg
 Xy2AAAA
X-Change-ID: 20231208-fp5-pmic-glink-dp-216b76084bee
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2

This series adds all the necessary bits to enable DisplayPort-out over
USB-C on Fairphone 5.

There's currently a dt validation error with this, not quite sure how to
resolve this:

  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: typec-mux@42: port:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
          from schema $id: http://devicetree.org/schemas/usb/fcs,fsa4480.yaml#

See also this mail plus replies:
* https://lore.kernel.org/linux-arm-msm/D0H3VE6RLM2I.MK2NT1P9N02O@fairphone.com/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Move adding "*-switch;" properties already in earlier patches
- Move wiring up SS USB & DP to SoC instead of being done in device
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com

---
Luca Weiss (3):
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add PTN36502 redriver
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add OCP96011 audio switch
      arm64: dts: qcom: qcm6490-fairphone-fp5: Hook up DisplayPort over USB-C

 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 103 +++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   9 +-
 2 files changed, 104 insertions(+), 8 deletions(-)
---
base-commit: dcb11dc4740372cd4cce0b763a4a8ec4e9f347a6
change-id: 20231208-fp5-pmic-glink-dp-216b76084bee

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>



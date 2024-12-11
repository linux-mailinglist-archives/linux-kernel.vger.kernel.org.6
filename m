Return-Path: <linux-kernel+bounces-440915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180A59EC667
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7D1282F18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CCF1D14EC;
	Wed, 11 Dec 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkuOqL3F"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EB1C5F2A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904203; cv=none; b=iLC4lU/vSQjTiaNKdtLGLafKZeWYWYwHHJXYjZkkNicZLy+9R7QLU31gaVxaikm0kqyRbL/AFhMuQab1NEeKrKGr0vHVcPN5wmdIsS1lM1xdoW/KsVQo1l7j4hls+QtCgjqX6X/V4aYoY0H4pvS/WaBneYp/zSZd/hcoK/zzXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904203; c=relaxed/simple;
	bh=18dfAsJlCKKxYu008KH/doncLm3ahMbb5fWFgsTqfyw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=syxhqMMaQozYBmZDFM14m8Obv3lqBonRs53JzQhmgcvN4CpT9keb61NTcN6cRabSPT8r2Fz35RMDedXiV2BWRWKwebjsBDDEUVUppzPgTK6OzTFIzutIE3PJ31GGOOxwufmoK39S1UVovI7J8I5Rjm8ArmR4KSZJPw8pGKR8QT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkuOqL3F; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436202dd730so599785e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904200; x=1734509000; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUTjWCfFK25O0mEpKlAILv7lGyjXAlPoRvwgz9GDlh0=;
        b=PkuOqL3FAjYQcpuOqolMi36wbu1B6wmA3J40QoY9S9iRT2GPJRmglbloX9Ka6xs9En
         mP3JGAPY+6Q9HeSwAC0mfIzMUNTmMHpYf0IDmbatTdbB/hSbjL+HppvEZimc4YCQK7yi
         4lbZM2bGr6+J/GO7kf/c1W3LHoQ3i9Y3fBTAM1NTx9dHmkBgjqmW3QoJZy8Xv73AOFtw
         3yWYisWjJGeAyIzwI1seiZCgsCo16qOT3NnQsecWv6EgIBtXwA3LuH1NCuMCtf/PpJ+H
         Nbc1gZ+rNdduPNG6LSdPDH/2qcdfgKPwlc9sI4yUPPMY0tYbO75i4Ow+v0BNquX67dIS
         1ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904200; x=1734509000;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUTjWCfFK25O0mEpKlAILv7lGyjXAlPoRvwgz9GDlh0=;
        b=XVck8AITtRin+3xWrdaeAp0t6WCMOQXrTJt5ha1uiRjehOD5nFs0sttUURA1PLXsm5
         Ta7iNDWBPQQs5t7JLGNdcqRrCs4NMVn9knTMGw40Cltv7biPpvIeGbijZ8T45M9uaEaG
         al6xNCPRybkJaSvBlq9amTo9GOQP3Ksvom1BBVsHBb0wL/QdaiM55d7I82LGJW4FVLNY
         RTgzSTJV06bUFOr5WidStpjpBwVRmYFmNUKD8zRAEdoBtHPlvfUwf2DluhmXoGCzNcUj
         Tgzs99Ufx27Xx0/YJu+WesuG+Z/DThd4MIRKy1MEiVh9UIMIufSCsosIbX/UL4QtqEmW
         z5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq8VH9PbCljSMoKXafVA+VA/NVrkXE8WKNzwwUOg3zR7kFxSU/qzlaLbj8C4Jo4vaDBEiw2EN5ADq80WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyArQb3/dGI4lzM6TiqluKaFSgdR+rtoTTN3kiCV6K/KEzXiMF0
	6T1rtDxIzI4Ln7hFOInYEtAQ1Wx+Acl0/ebAvz22wwYKbKv2go+JBsG3Zv3uAes=
X-Gm-Gg: ASbGnctG+fqW8y2NeIuiS6RAd3hH/TVYZ3F7rgChGGBWxXgOJVl8JE2c3E7D0IqcX6G
	llfwJbq59pwfbUtOrpFjockBze1cWdVuLTWgk5S36NnaUB1gKSskcY0Eu+5CET6c8hH5v5MmYsF
	XAQQoqfs1Nr/QN8p8sFRb+vM+6gWmDT3lzD7tdZSyIhKf2MsoMx1pVrKtTB9/lDMP46+PG+oTq5
	raoVQm7TJsaB9i2LwmOAhXQXGW7TKkshllq4xv1g3T9U7gRdzX7nTL5Rh1WlZFIDbt962Sfjxk=
X-Google-Smtp-Source: AGHT+IGYzjF2GoMN/mzbTBQZ9HSt3+0BYcYYNQD1nS7FVlmWb2TbC/8TDIB4hAO+rR8sQxvunv+I/Q==
X-Received: by 2002:a05:600c:198c:b0:434:f3d8:62d0 with SMTP id 5b1f17b1804b1-4361c375f53mr13238575e9.3.1733904199425;
        Wed, 11 Dec 2024 00:03:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm24205795e9.4.2024.12.11.00.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:03:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/6] arm64: dts: qcom: misc DT bindings check fixes
Date: Wed, 11 Dec 2024 09:03:08 +0100
Message-Id: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADxHWWcC/33NTQ6CMBAF4KuQrh1TSh2ElfcwLvoHTKKUtKTRE
 O5uYaWJcfne5H2zsOgCucjaYmHBJYrkxxyqQ8HMoMbeAdmcmeBCloJLmP1EBh4UDdgZOnq6CCj
 xbFVTK2k0y8spuP2Qh9dbzgPF2YfX/iSVW/vfSyVwQFsJrlGepMPLnUYV/NGHnm1gEp8I/kZER
 jqNujHKGll3X8i6rm/nug5Q/AAAAA==
X-Change-ID: 20241204-topic-misc-dt-fixes-6468da97a4cb
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Felipe Balbi <felipe.balbi@microsoft.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=18dfAsJlCKKxYu008KH/doncLm3ahMbb5fWFgsTqfyw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUdAoAOYV7ddktvLNtwMgnWG4pTDqVf71cRha4C0
 m4EJO2yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lHQAAKCRB33NvayMhJ0UHgD/
 450PKIYFMPm+C9+o5gXBK79aUxibPFi7jkG/C7GnZ+VIxF+mJ/QAo5GXrQAN008wBTyDGMphlkonCw
 YPdQJpaNE9MabBLO+JQExLfXJEji+Cw2MICOyIQaEQGe+XiWyEsKFriq2wgAzp/PTe/4YyL32NHn1/
 idFWfZEu4boELbTYUGQYRnHJ+BkY90BqGzR6aFLTHidPVJQ4Qo1MH0gAphDjS7vv8MCOBr9dhuw1r5
 9ApHjWlyBXk2J6kuzq3Kq+yn5YtDxiwCQ0pH+mer0EEUHJeTJeokibhSCuJsvv9WMD4RWqixb++4Ie
 LQv36pR5/gjevwZzYgBqWHi3deL1WFTIpH+LKsoku3IbHbD374fGOYxq4J9xJFVczK6P7xTUSOIdsp
 NCo87Nqm01J8TCmy/FNw394ZY65Y5qQIoXQmUlCjj1DtkyqDM2rQ0ZYSj0l3XEKVhO4nqUatrEmgTF
 wbjXYuWOhm2VXdg1FRr0exXq2RJJqwDZ2l9lFXstOxjKYu3muO8od2BxmrHnMHyJ3XvGMfKuihO5Cx
 PlX0lJug3SE4nIYBS/yJE+5e+HDu6pQHgAvVfs/+LxEI8fBQ8hRN7XpZkYBMNcyNb0A6/thzb7e5/t
 3LbWapA8T+/po7Ap+HtR6W7hk0LLsolqNlHq5e+/lNiJk5ByC/gmhNQbg58g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Here's a set of DT bindings check fixes

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Added review tag and missing fixes tag on last patch
- Link to v2: https://lore.kernel.org/r/20241206-topic-misc-dt-fixes-v2-0-fb6b9cadc47f@linaro.org

Changes in v2:
- Collected reviews from Dmitry & Doug
- Dropped camera support entirely in sdm845-db845c-navigation-mezzanine
- Added fixes for sm8150-microsoft-surface-duo
- Link to v1: https://lore.kernel.org/r/20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org

---
Neil Armstrong (6):
      arm64: dts: qcom: qcm6490-shift-otter: remove invalid orientation-switch
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: remove disabled ov7251 camera
      arm64: dts: qcom: sc7180-trogdor-quackingstick: add missing avee-supply
      arm64: dts: qcom: sc7180-trogdor-pompom: rename 5v-choke thermal zone
      arm64: dts: qcom: sc7180: fix psci power domain node names
      arm64: dts: qcom: sm8150-microsoft-surface-duo: fix typos in da7280 properties

 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts   |  2 --
 .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  4 +--
 .../dts/qcom/sc7180-trogdor-quackingstick.dtsi     |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 18 +++++-----
 .../qcom/sdm845-db845c-navigation-mezzanine.dtso   | 42 ----------------------
 .../boot/dts/qcom/sm8150-microsoft-surface-duo.dts |  4 +--
 6 files changed, 14 insertions(+), 57 deletions(-)
---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241204-topic-misc-dt-fixes-6468da97a4cb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>



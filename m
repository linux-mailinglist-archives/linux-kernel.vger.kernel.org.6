Return-Path: <linux-kernel+bounces-518219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E18A38BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4423B04FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C7235C0F;
	Mon, 17 Feb 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUdfwXWD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F943137C35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818584; cv=none; b=BQgYxlPQAGbLJcKvrzy4jbtDPBfXTZ1bPOJYCARnM6109qDTI968DmKfUqRtpPZlbPk/lfhmufoTm0RawgdYJ9YJ9y2Jd3n8/h6t+lxJ/sHfiOPn0ZzqIh5P0h5byoww7zP41a5fisc+jjjTT2t7BnACy6pVmHV56xs9i2LXvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818584; c=relaxed/simple;
	bh=21GINV+jTT0ljh6iGdE46yNUcUdBiV7LkViktY34c6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lkY6Ixqyza39cDUlwJGbe2gQBOyvKTtX11i83w9Znqeiwcc/gkdqFxucRq2QsE7IphGg7WAvxJB1R6ijWF2/k8bp7I3a6lDttAGvh7QHpSmiG7jBpA1P94WYlt2Dw/eZTU+icgjl3NCUxroYybcpxvOfN5/C9+5YIf6SpqdqFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUdfwXWD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54605bfcc72so2129267e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739818580; x=1740423380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAW81WUtaGDrpjLpQFuAf8r7igrxWydrW/CS4LG6Lcw=;
        b=DUdfwXWDXbJ3zRHYRYMQzfEGUnTzfpMardaJCnn6vjoCU8Cs6fEha0dWus6Z+XEJqQ
         MR7V8it4014lTyV51JazCh7RDTICk30uhF/B54wo6nnCt68e2b3LStm5NDCVZ79VBETW
         Xjb4ogk0u40EeLXZeoe7BYfFkZi9wU7INzpqg7mS8169yrwt6oT7Tz0Y80rtfy89x1gx
         IMk1A3Z0zGFan+GKzfdloX27bxwB7VGRi3VTKD9CNnNOeug7AwxeZPoQ9xRmtdbiTx5n
         lHIoXnUhkAVT4F3pQghdrbNy0+LkVcxRds3C3FC6VCepHg+f1vxRAipp6hHHSb0k9Ek9
         RwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818580; x=1740423380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAW81WUtaGDrpjLpQFuAf8r7igrxWydrW/CS4LG6Lcw=;
        b=ME8u2tup5x9jWENjfAvYsVdJMnT437XRfqJ3Rpw6R12ZGUeVR69TD0GBIdMbOYsC6X
         G0sqiZ5QGVGPPstlnA4AMUe9h10qasAKoP8weIV1exQJgGgLpUQrU/aWxpAWa4gJ85tE
         EEotnv6xlynuqrYt1gaUPFHAv6JXdCOE4YvQi+1eWbNq8BdN1UtqBov/8LBWKn3rT/aM
         3LqgOU7KmRZN5EqH/4rtIhK9xA017IC05MVtcrVr/9YRwpvABh1tYRG/IXzy8bMsqJzS
         QUFenHN/XWk56tJ4Kl11z5j+048N0SBUl7FnMVAQhsR5lqPVwEpyLSpYmRGM2V4sltmZ
         0mPg==
X-Forwarded-Encrypted: i=1; AJvYcCUeG6K7fu4mOplF/WroXm+dB2I+bkvLMs3oJAWXZ+8hqzs84RuRAKThTllejls851Jk1RRRdgGBdV+C4NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzETPA0a9TJzsF7TEzrXYxaOlUXXBJOhQ7o+jhHNFw4nPxoPJ1f
	RpAEmsuHTmHY7ta5oYuNjE87xyXcluYXSfvispDkgsV6uyZ3ntR0hihYV4/Tz4E=
X-Gm-Gg: ASbGncsjB41VMmtqmnDr+9Xduz8wE69so88U/x4lEVjhI64Cn2ndfU6vfBgp8utVsPb
	1HW5Uv73PtL7omqWQbkyr/soqotGieST18oMtnluc54KwCMpPVLCKBiBrzgmyIvGNj7FsiLhHyB
	qNHqcH7L3cIE4fWOmrgnFfwd1sPK5w5aFy6Kwzc7XM5wqh6dmXNEEMZMyjXxF1GAhAEjg/RNkwQ
	kWFS3U5HcKHU2OCIOZyYioCvlmMKYubO6xqqxDJ9Lji//DwRJYbbXl4aCTUhDF+pNh9Jy+rJyqM
	r4Os+KJeBTOGhbFjUqBShQeVDgFWbx/qQZmy6PudcHK9XNL4CtZ+SPO8F0I=
X-Google-Smtp-Source: AGHT+IG63ghCxYPnwVWx4j5CKiVfpEwlnjS1CxJrziNrE6kVkwoM1IgOqX0WRSrlQIdssIrnOIfZtw==
X-Received: by 2002:a05:6512:3c86:b0:545:31d8:f384 with SMTP id 2adb3069b0e04-54531d8f982mr2456362e87.10.1739818580218;
        Mon, 17 Feb 2025 10:56:20 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462006b0ecsm559806e87.160.2025.02.17.10.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:56:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/6] PCI: qcom-ep: add support for using the EP on SAR2130P
 and SM8450
Date: Mon, 17 Feb 2025 20:56:12 +0200
Message-Id: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEyGs2cC/x3MQQqAIBBA0avErBMcrZSuEi1Ep5qNiUIE4t2Tl
 m/xf4VCmanAOlTI9HDhO3bgOIC/XDxJcOgGJdWEEo0oLivUMonkWVgZHOnZLYYs9CRlOvj9d9v
 e2gdugY24XgAAAA==
X-Change-ID: 20241017-sar2130p-pci-80dae35a67e8
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=21GINV+jTT0ljh6iGdE46yNUcUdBiV7LkViktY34c6I=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns4ZP0jFRqK6qM7lWJy6cx2BjsR04fO27y4jOd
 r9Hus3kApOJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7OGTwAKCRAU23LtvoBl
 uEBcEACuIgxA9prRR/xwlBxoo3AZmYE8/63IIPLOGRh7R7tcaHvJdytVxWaZhqcOlvqZf4okNP5
 5Z1UOE6tOd/FU7rJPT+xUOXlcUZTH9EfThdlN/vVRqUIiKWQhmOh6bAc5c+ABLsyQwzRIxtFUMM
 PuIoC5w/IFZ7Bb+wCEVlV6dOmiItiVKjoFRtDXabZCu10h3KlIQ2wEqCKg/L2aUtd8GjiV6Nrpd
 rvcayMWA7kQ5dem+kdho1Ya6QYeDJr0nCohNTkQhEPV/9VO+vtel+bE8+o0k1wxaWxn3zNrDjy8
 264bEYvFSkmmsltk7hssijQsHpujUpYQXoiGJX82vSiZFLMGepdhYIpCv22cIjKYZ4qEbkNehpx
 r1fZInrtPsvvulmrxBz5A5S1IutG0rHqQVBU2NHTcCrIOxeEpgRQxC9oGsCT74BPnWwvN4g2wJE
 CP5PpobZWDBAvLSs2VmTwE0duE1NYFQDgrx0w+J/4rptKjtdWUPBa0H/dxidHb8gloWtwPUuLSR
 xP48B+MYUuWF6H1UMTAGKEgdYkpVDVGjgoeZNoNcS/FTDTkPYxg1rDt3EiYTJO02M96vSFyAs/y
 9zoRm+S5ddy6EH9tpwEaMvM9jHsKP0H7UMLGQW8zRhw/KAZctK6RmHSzyNDLo+pUYjkum5tPIZy
 QM3Nusena5oU6Uw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Update the incomplete SM8450 support and bring in SAR2130P support for
the PCIe1 controller to be used in EP mode.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (6):
      dt-bindings: PCI: qcom-ep: describe optional IOMMU
      dt-bindings: PCI: qcom-ep: enable DMA for SM8450
      dt-bindings: PCI: qcom-ep: add SAR2130P compatible
      PCI: dwc: pcie-qcom-ep: enable EP support for SAR2130P
      arm64: dts: qcom: sar2130p: add PCIe EP device nodes
      arm64: dts: qcom: sm8450: add PCIe EP device nodes

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 69 ++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 53 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 52 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
 4 files changed, 169 insertions(+), 6 deletions(-)
---
base-commit: 34598f5b38950c59f15caa5194cfccbf6ec03c99
change-id: 20241017-sar2130p-pci-80dae35a67e8

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



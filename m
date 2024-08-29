Return-Path: <linux-kernel+bounces-307494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D89964E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA79286E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714051BE86F;
	Thu, 29 Aug 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lt9wHwxd"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05051BE255
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957083; cv=none; b=U07EXpS5seUVDIuaZ0lRIV0Ghqan80ocsrkYzqs8qnHoETer3XO9hGxHdrEEuNL1SAmGr+p3/X1dZtfu+GyGTDXwodwuqDOxgd4v4OGPbRELXJ+DrcuIAhd3/ct2r04X1XjPrXSaACdLfbzcEF6hXJZCKcIn0pfZktPG/aacbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957083; c=relaxed/simple;
	bh=XVH+qw8w65unaRXW0f5lRb3ixXIvUxmzc94Q95ng4ZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B3V2ho49grP58/oUFv6jxKuiypRJIhy+m5lQRIZtcwER+Ij3dm5vC0T0m2jW2bd8O65pzc0w0dgTupBg2ZIgKdMKl1XiFU3X4YvmLIKw7tD7PC3IQOqzL9Ata0BT0ndGhfsAzWURV5xe3QBASCaFndlJzWu6lWxqZSRMVSJsO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lt9wHwxd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428119da952so8807095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724957080; x=1725561880; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPihfaKA2Ncz2MiX/m9dykVkd/DtCZT9+2T1uLNZPSE=;
        b=lt9wHwxdvUuoTIhgD6aGT4XXlEaa0mznpoqhHzJP9r2IjhJpHYJmPREN+4hIP7NyHY
         gBZkhoDTVFEBtB7GrIAR4qWia0MLjWtEOPc9k4XSa+QIRX8wbOwe07Uj9V9SR5ZTF8EL
         6i/qbv1Dadvttw5k/+tJohpejHd2o4qqe6QrSkfEn7fodg8KopOeAWlEGG/sv+wz40dY
         40WF42bgqfclFS+j/iHXPct3yQVs7RrNKsxeFz1HgI0mOhZfJT1HA1ZXUU1FvooCdpxU
         NWGl7Wky1ORP2Uwtc/hTxvzUWMZSLmcsEzTAuBnoe8JYejkmmDO6L0PZIiy2GqdMiPz6
         X14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957080; x=1725561880;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPihfaKA2Ncz2MiX/m9dykVkd/DtCZT9+2T1uLNZPSE=;
        b=UUJcUaf0JjUXoxu2sf2FGGOI5+J9aJbd344almxU6TqlL/sMS7CJKSSJ5sDnhowlYV
         Oxj2Itqu1j9qapxdOnN7KkOfOEsGhGcaMyXIC4imneLSkHQhO2/j+7cdFCnOaQjA4VF+
         zaXq9OU8xv2n4FQpim6bgpYDFk+vX8Qbo+78PlykNCHkbKSQfjvAjFeuUzyyRkjnomRv
         kTI1pH5uSOHL0Xa7GisfSdoWMsBAFPCFSFuG7oqKYT23Xb7xjWGHIPCKC0jLbmiE5iOv
         M3R8JlJ5WAQuYpCmEXazWBG309rdg67cLJ5G+rmxehqq4qilHmcDTqFcb50g/u8HnAeF
         hmfw==
X-Forwarded-Encrypted: i=1; AJvYcCXOE+lStdcTQ2RtE8Figf24PlFgqHyVbnDVtJr6wEuBBrwMXMsgpvYEaYIDzKcwwu7KFs5735aW2DLgJMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrQfF77OVMPIEzpN5AZdBBbAtNcj7F/iRRyoPNy0/BA3kCCqS
	A5bdEdoIAVM+EYNJ1RVqLwJIZlkKB+IH/l5f+TNEgiKsvD/rk/MfkZkHTa3Wx+A=
X-Google-Smtp-Source: AGHT+IFrgJIgqAeicEyJjTgtyNnUEWmERidm2ah//MyAABKVE0BHwAU/Z99LitUrA38Qh/UbVXPMNQ==
X-Received: by 2002:a05:600c:1914:b0:42b:a356:a780 with SMTP id 5b1f17b1804b1-42bb02a8517mr32499365e9.19.1724957079716;
        Thu, 29 Aug 2024 11:44:39 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33b41sm24540885e9.40.2024.08.29.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:44:39 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RFC 0/2] usb: typec: Add new driver for Parade PS8830
 Type-C Retimer
Date: Thu, 29 Aug 2024 21:44:24 +0300
Message-Id: <20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAInB0GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyND3QrDVAsDQwMD3YJiCwtjA90U0+Tk5ERL0yRTU3MloK6CotS0zAq
 widFKQW7OSrG1tQDqFIg9ZgAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=XVH+qw8w65unaRXW0f5lRb3ixXIvUxmzc94Q95ng4ZE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBm0MGNGMQDzX3Nx5DsiYFHYI6pN0gQaq2VaDNTj
 7Z+byN/pdaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZtDBjQAKCRAbX0TJAJUV
 VrzjEACkXmp19AD7f0T1wRa6RLzrEPyfAU7fAOv55K7ac9Yu5dHsBuUU80KfJFrWjZf4EbYd4ad
 4I6Vh8SBhWRaFhXxNtbKKU4otMeYCWGGRWEEzZsQAjhoXcdgR1JpuJxyZMT2kyOUI797PQJRbfe
 BummyVyoaRfNUYVWHJlq7jQgh2nQS8DG58CaZfeiNe/ugxxSf2TtE+JFAB3EhOVvybhUAe8hKLb
 axDY57mOojCq2kvUvwyTrtv/S1TF0tJdgnkbPg2C2ozskbGK0yRo+OhUQrh0AeK1ViyQTPH8gvT
 Oep18JCLkyH6wTybd++euBxw8lvnKw7GPf0bw6g/QNtT60Y/5qjhx/cm3NmJ4ugx4HQsvNeVx6Y
 6lHSuCQmvBcCwvFydra3ynq5sV5b3j0uVMi1v0QqQF+Rw2UQzaCfnzCAyRqqKA39y0zkZBYwFmK
 hIhshtRpKSLKrKFIm5KIEqeaB0e6F6Qo21qTjEJozDIrDVIb2lcdEqQcrKYjtW6l71n89g6pUN4
 fLe2+UZUczJBydDxk1Uq7Vv55Ljs879I4DX8yrAhKBI7VLQggDYtgJLG2BeistCm/cWTV4WgT2m
 arFyPihthyEXNWO3ayxk8wK8kMG6/LQepENmu9IcW78x3ncWv2GSM39sMw+6CrE7d3mGqw2lr2J
 gSWX9bsN33KaMOA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Parade PS8830 is a Type-C multi-protocol retimer that is controlled
via I2C. It provides altmode and orientation handling and usually sits
between the Type-C port and the PHY.

It is currently used alongside Qualcomm Snapdragon X Elite SoCs on quite
a few laptops already.

This new driver adds support for the following 3 modes:
 - DP 4lanes - with pin assignments C and E
 - USB3
 - DP 2lanes + USB3

Only DP 4lanes and USB3 modes have been succesfully tested on
Qualcomm (X Elite) CRD and Lenovo Thinkpad T14s so fat.
Devicetree patches for these 2 boards will follow.

The DP 2lanes + USB3 is still work-in-progress as it might involve changes
outside of this retimer driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      dt-bindings: usb: Add Parade PS8830 Type-C retimer bindings
      usb: typec: Add support for Parade PS8830 Type-C Retimer

 .../devicetree/bindings/usb/parade,ps8830.yaml     | 117 +++++++
 drivers/usb/typec/mux/Kconfig                      |  10 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/ps8830.c                     | 347 +++++++++++++++++++++
 4 files changed, 475 insertions(+)
---
base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
change-id: 20240521-x1e80100-ps8830-d5ccca95b557

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



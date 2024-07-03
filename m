Return-Path: <linux-kernel+bounces-239899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F38F92669E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BE31C22E09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491D1849C4;
	Wed,  3 Jul 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3ofSfZi"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298F17C9EE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026061; cv=none; b=F4zQdRHDlMT2X+3lqMaHGVescqNsSGY70ne2t9f138HbF60ptofpULu4/pc4AVs+AUcqdL72mKQ2WPrLnZLUMe83Xkndn9X8Ehu3qInWzcy8A350fAYEhNrA6lGo4EL1TpuF7zWkertYx4aEIEYJ//QkujkJQjlwPrkhWjgdSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026061; c=relaxed/simple;
	bh=y0zHZnBhe/X8wnZs8QZ5TYJP4+86aDrCxJdiCkTLEhM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=afozNixw0n8BANWPqVFongQR0X4LYBRM1jn+H29Uu7aodssp3ItVI0zrHnO0cRM9H7dqTwy4rr9pfHT8s+7wtFpukhjiNAfN7EptTGgN4rtJdMkrK9/LLoqwhUCdtD1KCJgU+R/sNuhtz2u2K+wn+YwjvP4/rG5Ji1xTORaIHoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f3ofSfZi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42138eadf64so40141715e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720026057; x=1720630857; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQxm4MXhdO/Ccx6raqWeDezg+JMq5tqzpnV146by4Ww=;
        b=f3ofSfZikq6pFg8fGimzGCQH92DN9BIVxTZd1MK/LFLYcoX51yXtW7TEw5GmeETKwn
         X4Hv7QXK9O0IObRPfl4w2GroCMJecNQh1ZigXuCNHQr0hjqWstq+Q/Sfn+JqZup5La+J
         qN0a7AiFrZrhPwfkPUe/l+EWzP+LZ7kjHtVWGM6nGLDOpz++UjuPV/Y7gZLXdqDBTyTB
         e5DyZmlgbodY1WOVDKYBErvk2UwGFI5e7GdSmUjBsihlF+2ph5NAUr9kvNnrfKT7kMYH
         wKNbh9S6QIj6Y4xXFv9x05lsvWlA8frBL9ynxJTIcogWQpmc8XAvtEupMXQTts/noRJF
         /Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026057; x=1720630857;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQxm4MXhdO/Ccx6raqWeDezg+JMq5tqzpnV146by4Ww=;
        b=cYoc5PQxr9PupprHlMzUBlMPGqSfzvBsRAoG7tTZmqU8TMGwSdk35ZBxlDx2/wzf0A
         jkrokzKJ//QBbwFajwAEiltDVfswGAoz1z1QJJfBAPM94txNRhD8VX2h/mIy8RHJKDLn
         2HZytYk90kGQFH6Cs0zNd5Xi7RKqZRZT19f3LnuAeskbfxgopLF2aUQg7cZIfH5ImKy5
         KSad6m9az+Llpn6cCaOc4r3cdDM3WylEGaOpK2AOIgFSN/EYm2BkLKD0w8O4f8FEN7y3
         Q4tppWT/Eaa+8Jlfeve42Xk8mYCSd17L0qyen7uGXsGBtIZ1yK/WDqjhs4O0DMWwS13Z
         uX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEQY+QpQNlBKRjknSovA3YPMrP8qVj+o27Bw3meCjAu0S6HRtJ1Mkwun03aYOoJt2g3p+IvATmIwSvxejG+9QyMuH+EgIgMwqjZ96s
X-Gm-Message-State: AOJu0YyErYN4My9ZPCzPKl28odaKo4gKXwt9tMFYPKgXjA0JdMYED1KM
	6u/kegMaOWJW2jCkRnmTrA196Q3rGEU9wStT/fi7wFZ93HxcesiYiYNhO1zK2Ms=
X-Google-Smtp-Source: AGHT+IEcR7djVr+qUOG3e6ZRpwKNaMhbNJ3iKosELfqtJMxGjBWnAVgO4GF2QY8V8nDx2EAwja1GOg==
X-Received: by 2002:adf:f1c4:0:b0:367:938c:29cf with SMTP id ffacd0b85a97d-367938c2b1dmr1530049f8f.71.1720026057345;
        Wed, 03 Jul 2024 10:00:57 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba2dsm16403776f8f.73.2024.07.03.10.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:00:56 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: x1e80100: add Lenovo Yoga Slim 7x
 support.
Date: Wed, 03 Jul 2024 18:00:52 +0100
Message-Id: <20240703-yoga-slim7x-v1-0-7aa4fd5fdece@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSDhWYC/x2N0QqDMAwAf0XyvEC1OmG/MvaQdlEDWzsSGR3iv
 6/6eBzHbWCswga3ZgPlr5jkVKG9NBAXSjOjPCtD57rejc7jL8+E9pL3WNAPfI0hDNx6gloEMsa
 glOJyNFNWTFzWQ32UJynn6P7Y9z+V5cMgeAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=997;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=y0zHZnBhe/X8wnZs8QZ5TYJP4+86aDrCxJdiCkTLEhM=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmhYPHX8qJRtVDCDa3Dh9334JNqUTBLxzT97hpm
 0G6RS3OSLiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoWDxwAKCRB6of1ZxzRV
 N9obB/4jry+Wq6/O4Vtu3hPK7WPV9/89K9Aa6eI0rotij6XXqL80+43XbCTHG07Oljqwi5qGBxm
 KKotnjFQRPYxOKq8mcFHf0Qu7l6KbUP+o3F+p/i440YDHDnNWA153N9vXXPoGsH086BnHmqDnQH
 YlsbRiQ/OpFWw4MOPiiKT6y+LsMHul6UV1wkWwRupPUoMkfuYLQDi2up40+NbxSWGFwb58LaDUd
 B9iNWVegWJv2BUCeBS0Ds0naQ/6+Nv3PLBYuQqr5njBRkwzNmSnZ++Q/V4OHGDXaq0H1uWxMvFq
 JfsSk27QXqo37bvoeBWES1GyVr4XCt7ATZCCh5V+gBwwEYxh
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

This patchset adds support to Lenovo Yoga Slim 7x based on x1e80100 SoC.

Tested features:
-> Keyboard,
-> touch screen
-> Display,
-> Speakers.
-> all 3 usb ports.
-> WLAN
-> GPU
-> NVMe

TODO:
-> touchpad.
-> 4 x dmics
-> Battery level (Does not work)

Note, All the firmwares are copied from windows for testing.
 

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Srinivas Kandagatla (2):
      dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x
      arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga slim 7x devicetree

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  | 910 +++++++++++++++++++++
 3 files changed, 912 insertions(+)
---
base-commit: 5f18d86e750408030e3980e566ff87f0319d7f34
change-id: 20240703-yoga-slim7x-35e6cbb5e13a

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



Return-Path: <linux-kernel+bounces-402511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE4E9C288A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE4E1C21574
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67B46BA;
	Sat,  9 Nov 2024 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLrt9XdB"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC938B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110663; cv=none; b=naNaCNPHOix6QI3jXRkvVCDg3hC/9MGC03oVJyZ0vLeEMkPXzhDjdmW27wmuPno6/KOVlzfhx6xdPRLmNz0Z78BvI0Z7oAxenCx8wc0ZIK6DnoQVKlwiS7w8GzRI9ThCq+A5Fcly6r/y6/ErtYjLfRNglXtS0j036jBqTuWeyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110663; c=relaxed/simple;
	bh=ywQdZRsjrKo4sX83lUQ0A3enWUCZaVbl7p53C3732sc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PyB/u4kDNw1xDHl5uU/ZcBVrMpvW9NL5ZXAAB9HPTlz8/TKRNzi3q5gfoKHwx2DE+Lr9YmWR767T92YekA7vqGZBFzvn/ox5t0pAHPasu5aYvQ4Wwth9+gGSfJ/CVOBJfhcSODZbMSfrNiH13ZX4gMRjwsG3pLxQgupi5eNCqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VLrt9XdB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so32871201fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731110659; x=1731715459; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QqKyKuDkp5tv5kEc/k4lzuIOmv/CxXKRi9oTcpz+qh4=;
        b=VLrt9XdBOWnq6rpmg6rZCnozAiXXwkUo/7LciqhDCD0M8/oxxtgcexjWJLuFAyRU+n
         nQ75uakp0NRIE0siWOCHD0zvv1D03Uh0+1JjRunIqed/CxjZN82xB/3YzQPb+bOMFtSg
         BswpmuQTCBvckFiYwPm4qGl3BPAo6yQj7ZNYIAy4IGLtzmcb2cV37YhZtneLo8js9V7Y
         QARLZ6BO9D5Lg6z9hZb7Fq0eUNQvt47b4iYoPFs+UKLgumkZTqfgrdENSyR0/mXHztp8
         usA5v1wXbEPPVmJtFQZl4MdlwC6QOZR+1ihaoE1fwNWxDVG3uyIca+IoefPuspmVH1nt
         knbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731110659; x=1731715459;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqKyKuDkp5tv5kEc/k4lzuIOmv/CxXKRi9oTcpz+qh4=;
        b=QW2spa2E+4piCMLyJs2a0ds18rE7l3nvjFWSDxP1i+5W7BNwLRRXoOda4x0kzJoFjG
         435tY9gmfiTLY1Pr7iWiK1oPdc9DcRU0sIid1z+XXa19vu6C1mlLylWWTWGPU+fBaJ0A
         byKw5v0Aauutvk2+3Z3lA80T6NNVe8m7lbT8MknqveeIO66bbA+k6eiHLzkHtrz1SWew
         vavKBufYIdUnBugVIUnSTx2UqvYpOourIkzBaQM0bD0/Skv/WBfDgVrVNhN+PG6KhkMK
         9j/tbg0StjmrQd4Ox4Ki9w15uoIHH3pMnsPL6+OJAncrlPvG+/yDsCbUfaCPfwb41usk
         0YAA==
X-Forwarded-Encrypted: i=1; AJvYcCVJLK+xaB3N2A/8wqcLnuq5u/75OmeAboNaEaUwxpPIm7uLqRe/zuNGSAfkhsrsjAMurzsTK8nbubRPqDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0luX+4eYp8dMbzElLI32OqlPGiWdWzRflVyhE6d3RIR1+f6TR
	11040d05iT4jp6ewewDblB4smMjXwoM2HBNOSejYGCw23bzEMcrHnVfod8jl6Hs=
X-Google-Smtp-Source: AGHT+IGkg8/1BmV2RcN7nA+ELa1/ToNCfGFI7QEJI20rxGhEwGc1qiymsJbIBZC6WhdCZ1RsdodnSw==
X-Received: by 2002:a2e:a813:0:b0:2fb:569a:5543 with SMTP id 38308e7fff4ca-2ff1f4d06ddmr19124921fa.19.1731110658590;
        Fri, 08 Nov 2024 16:04:18 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17902152sm8221431fa.57.2024.11.08.16.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:04:17 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] usb: typec: ucsi: glink: fix and improve
 orientation handling
Date: Sat, 09 Nov 2024 02:04:13 +0200
Message-Id: <20241109-ucsi-glue-fixes-v2-0-8b21ff4f9fbe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP2mLmcC/3WNzQ7CIBCEX6XZs2tg60/jyfcwPSCsdJMGDFiia
 Xh3sXeP30y+mRUyJ+EMl26FxEWyxNCAdh3YyQTPKK4xkKKD1uqEi82Cfl4YH/LmjIYU052M4t5
 As56Jt6JJt7HxJPkV02c7KPqX/t8qGhU6pYfenQd7JLrOEkyK+5g8jLXWL/4kkaivAAAA
X-Change-ID: 20241106-ucsi-glue-fixes-a20e2b2a0e3a
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogeurs@linux.intel.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ywQdZRsjrKo4sX83lUQ0A3enWUCZaVbl7p53C3732sc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLqb/wcBOA2fCkr7Uj/OTtbPQMqlXB8DxA4nBW
 CBSJEuWI6CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy6m/wAKCRCLPIo+Aiko
 1eeSB/0QLsAkw8ZhGtj67u//gMuspxnLH5IBy+q0uWEoTEYqX/jZ+wgMQvGG0zt0ElJ2shTp8IX
 f9jjaFzblI4aJiGLGFqOycZ/bBe/AKl0l+SvFZ5xAOoLtuumDTtbKQh0X1/NG0lgezffdDsE8Gc
 qncddeC0lWX0b+O2jIhDeylsjhngKoR0ApV0NXdVHZQoqE/dhkVW314W19hqfxnPoemKQK0hP5e
 PtF0EaOBdxdSpqdWPCPi1/yWVWAvHHotqZ0EgFrADg6qwYRTU/GtRW8ooE3AukDHC1VOFXGh8pU
 ri0SvSau0rXUv9J/VwcplNTN65AlLLlDWFcEG8uujox4WHNd
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix an off-by-one issue which resulted in USB-C connector #2 orientation
being reported as unknown. While we are at it, correct the way we set
orientation_aware flag for the USB-C connectors.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Added cc:stable to the first patch (Greg's bot)
- Expanded the commit message for the second patch.
- Link to v1: https://lore.kernel.org/r/20241106-ucsi-glue-fixes-v1-0-d0183d78c522@linaro.org

---
Dmitry Baryshkov (2):
      usb: typec: ucsi: glink: fix off-by-one in connector_status
      usb: typec: ucsi: glink: be more precise on orientation-aware ports

 drivers/usb/typec/ucsi/ucsi_glink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 0a2598971f04649933bd38f5db241b3bf23c04ec
change-id: 20241106-ucsi-glue-fixes-a20e2b2a0e3a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



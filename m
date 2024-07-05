Return-Path: <linux-kernel+bounces-242080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB792834F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F81F246B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692C144D34;
	Fri,  5 Jul 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVoGKiMd"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40F143C7B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166345; cv=none; b=QbcKlyB1BQFkQXS22YmHlkLOIRsuB2momx2yFClSxSYHTWebm93Zsl+umdHYHYJ7l2qnUIyw6YhLhKd5O7f91JKT8BF+CW1197teJpGFshBLszzYj68fU/bvc8PvkAbEkg/VJSS67kUxdYzLjZ6apPslSr9WmruVBgNl0PcRmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166345; c=relaxed/simple;
	bh=b3OgVcYpzyQk6HGIJEDS6Zxj3HDAmEod+g4xVvDoZ1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9yY/aaU6nmO1liWsbWyKV7Qn0RiZfg6VZNlGe5Io8q38TpTonX/5AFynUxKd49grNsuDC5ejeUianKZbonG+ih1WeraqnKnJUmTut+eFFcVkO1cj7PCJJr1noQAXs54xXg1dPmmhKRIzDbkIKE1y4jUQNeHl4O6u/a3MZohAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVoGKiMd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36796a9b636so999334f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166342; x=1720771142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3mXWZJ0LB68ReIZeR1sFEO+z4RqsbmVI3arE7ps0f0=;
        b=oVoGKiMdY0HovkBtI833K0qvdOcfbONrtACQrlU68JQQ+8gv33Oe4XxpR/b91mth8t
         B0zI/ANdgDpV25Y9tBh1ydMP+naX0wRExzEHmqbT4H+F/vG1AgHTRreMNx+Dn5qa+sJK
         vmTNZhfZfrB8JvIrd70FMbaST3rKIxNa2JD18eo/ypBXJ9+uFwqN3okmZleJFgU7QURQ
         notg4LHBvl0s99/B+pEwCkqm2OZfqSlqe18hBnhQ1dWNsU+9Wtw3H1YnGUqIbhMR0381
         x3O0YAEk/xv6mt1cuiGyvR6uk4BX3phAuRDnxLIkEGROIap8UulBnyxRA1ZEta1qoNNC
         C3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166342; x=1720771142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3mXWZJ0LB68ReIZeR1sFEO+z4RqsbmVI3arE7ps0f0=;
        b=IJQW1yYVqYXSKF86hHZmeWoGAd361i+Ry9tEIS9aRYw50qutz7TauRGqVVvyAR4A8e
         clGfDdJWz4jHfGcSvL9DnND32244upo59iZ7bBXwQ4K3UNR2fvOGXHZ1UPU8/azaJ5g3
         wehvr4FkEFRRP7p1Qm4/G6E7XKnCETxRs8cuSmOxis4gAasSyXx6gmyOzAD9ZBSZOg3U
         icTHgn7mGB4SzomQSwA5f11m1US6Gx/vJ7ThVydfpUkWf9st5yIyRup6+iD3ynKgQbh3
         kDgdNJ7HU6WE8Ox/IILXXBZKizVUncKp+1/WDWxM+wXK5c6zEV72m802k8il+ejVg/NJ
         bjkA==
X-Gm-Message-State: AOJu0YygmBUvJP2fU+Ybb+DAUDVIkqErZHDWz69jpsMM5sZihJK9u6Ko
	bR82tkKytOzwo9AsrbhfycAXMmVw9XTBGsWprnpwUMnETsiCylo7tVFivfxk+Yk=
X-Google-Smtp-Source: AGHT+IHRCukZ0ZCD0Nm1/upLGEuX8u4CAdELa42gLrMDshsIxb+pm+Q+tn8c8lnFOr8omjvvYj8B8g==
X-Received: by 2002:adf:ebc8:0:b0:367:8900:c621 with SMTP id ffacd0b85a97d-3679dd67eadmr2228181f8f.56.1720166341974;
        Fri, 05 Jul 2024 00:59:01 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm15315485e9.0.2024.07.05.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:59:01 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/6] misc: fastrpc: patches for v6.11
Date: Fri,  5 Jul 2024 08:58:54 +0100
Message-Id: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=KQyUbL8I/pNv0lsr9kapGIPYDOWe/YMMWmb4FHwOohA=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6fDJMLdQ8od9waCAJNLLuRmE2NiLeanPa9S3 q/VmQftzO6JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoenwwAKCRB6of1ZxzRV N6vfB/9k9XMANr/kxx0NBCN9pnhb1+ACRfotoPqXL1LdlVi4QBn7VLBbBckhcuwblxwKqOTmmiN NGp2byj20196kLIZaoDMfd3U1sL/bq/brBriCTVJlEr0VKDvpIkvUPmC9Z2ZhD4SeqWEvrmkUqO CweGGe4Sq2izAoAfap3emtE9QjEchid+usHOUiRxM1KeAnK0V0R6eeBhKr2+yaSOm5uNxEURAO5 S++9vpzPWKb5Vg89kdiYQOKb8RsmlbVNhpb1NylWuck++42jGBkWXnA4g/QKoQdVUunhYGcWFg3 /stk2yQpf1Qtu93ty5PwJA731X/xPuhIF2RmMh3yNzKLB0F0
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few patches in fastrpc for 6.11 that includes
- support for sensors on SDM845
- update maintainers to cc dr-devel for dmabuf related discussions
- use MODULE_DESCRIPTION
- use memdup_user

Can you please queue them up for 6.11.

Thanks,
Srini
Changes since v1:
- removed stale slimbus patch from series.


Dmitry Baryshkov (1):
  MAINTAINERS: CC dri-devel list on Qualcomm FastRPC patches

Dylan Van Assche (2):
  misc: fastrpc: support complete DMA pool access to the DSP
  misc: fastrpc: use coherent pool for untranslated Compute Banks

Ekansh Gupta (1):
  misc: fastrpc: Add missing dev_err newlines

Jeff Johnson (1):
  misc: fastrpc: add missing MODULE_DESCRIPTION() macro

Thorsten Blum (1):
  misc: fastrpc: Use memdup_user()

 MAINTAINERS            |  1 +
 drivers/misc/fastrpc.c | 46 +++++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.25.1



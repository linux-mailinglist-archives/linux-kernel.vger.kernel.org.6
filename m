Return-Path: <linux-kernel+bounces-530513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516ECA4348D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B81189CB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1B2571A3;
	Tue, 25 Feb 2025 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grf/fUEi"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756DD17E4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740461697; cv=none; b=lSEhjQNFJzPMdK+1nl3eP5h+YjJXf0NsHyNU/Ve8TP4QbRyMT4qjYmAWEkZhZtmhF5CI+d6tgmqSmHWpaSpbfzBxTh5mgwtH7w0GVUxAYXGvVS1qagyAwt6+vYJpU22o86tMyfLyQyxsNkhNboP0UqRe8bEQmoX6Wmj4pgqKVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740461697; c=relaxed/simple;
	bh=mmG+LHSr5wQDq0zrxPGlfjS43+NwfjSyToS3LM1GNsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=htRU0DxYk4HxSPz8nfpi3WX1tVkhNWQLYz2r22CwhF2r5FZOYXdldZh/DzR+y8voGhIQY5sml4YhwdbRyyCLdxGnvWF2xt8N/+NOzcYbIduc/vNtfgG3ivP21RR6vjiub8AjJ55X1lOU2XzNxSYgvSSS4kahq8hrS0pZOzQ5r30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grf/fUEi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22104c4de96so89050895ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740461695; x=1741066495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COFBXMHPskIsoIit0YmVND2fstaviJl+t/pdbf0Dt6Q=;
        b=grf/fUEijyXm7cdF4rfiALoJX1KlFNYcQRFjraipbtaOVT7Zu44yZFIvONOrAcW3S3
         WWpv7LPztVoEKntFjoyIRNs7HaEw4hpYVFPrKlQGYHS4EsFMg0Hmpacr/Ko/x4OGMZCT
         X9SaYfwKxv45WZdcRjNmYdCVn06LwCvuPVfoduWNHxwCTBP9V/nriGCajgOCB6wUG34v
         fuoMmN/ZYonehhZiFtkX9wOd/ERkv0dnbSbWgsnKa+cx2GsXnCUsyIZfO7ECi99atoB1
         +e8rDhqE6SNRGVFy8HmVzEtdpnHU7H7cNlEiAI0Wid/9lOyHZ44hAruuxC+o23bxDIYo
         ZRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740461695; x=1741066495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COFBXMHPskIsoIit0YmVND2fstaviJl+t/pdbf0Dt6Q=;
        b=r6e+chcsQodf+qtgbheW0A8q5cmt/vFdcIWWlmYOKNM+nXDnhI+hbrxVRjKcxqDw/5
         tKHiEWv2xhi6wTolR/qV8G0ocY7P1w4NR/TgDkgYuFC2N5pDRkhluypMaPnQ7TrMLT+L
         U9F6BGWn2jddNCNJ++ZhpIuR0sYW3cV98JsgbWoe+bNuxb5Tkhz6bAdzENfgHRh9WTCo
         rIMQNfiq2/IF9BnAEfTv5oOqkDvwxhLwEON9HNofsAlbOkQGLGRJyxTG604q9ApIm6br
         9njCtD7Yt7UzUYiufhJgGOsqy5xvvYO985UjjrmsT6BEda8RiKK1OW3Fy4qZ8TetsSjm
         ZDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtPoX06N5oZtnQYwbn8cc+Om+ZE5meefl5gfVU291bUh+5La4U7D1x/wegvMaRafP8xB0ad/MlMmCt810=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/XebVfgyrlXB+l0NfOcHWjEUeQs9axidjbJmVjayfiI5A3TV
	BKNVfMjKb63C1+78+76dozG/TPdyaV+k6HhJpL5JeOMux+g2z6CylY2UaZnNsQ==
X-Gm-Gg: ASbGncvCbTLK0VG6rn7HCZcx2wgtfsKxur5NDTeepxdHPoEQzbe10SWWHWRVK9fbUCy
	t3g3+pn7pwlfoAgi5oqhmtIxY6LJZJAQhq3Rd4u/bPBFkc7JQkSE7Uye54wLKpOVAHXflki4RK+
	t37rDgvTrBKoSVxh9bPoi3JVjCphGN98XfSBdcCmWBWRAxZYgtYu4iCRqf6Ufk5ib7p421954h9
	aZf4jyn9X8o4eCy795MUJ9kXIMI/dGs6ziziJ95W6DRGaNw7S0RMbcso2ISYAfUGFxg6UpRPvuj
	KhNuYq9dNAVn+XDvsSIV1A8W3x2bMicAhV2BaaMPsYhUCsVxh4Obnw==
X-Google-Smtp-Source: AGHT+IEcKJ/dXx95j55XEtJ2Yr2v+/ULOkI6H8gKJVMhyZk/j4JRz3SW0id9uRnQMpLfQLa1g1/udg==
X-Received: by 2002:a05:6a00:228c:b0:730:8ad5:90c1 with SMTP id d2e1a72fcca58-73479101286mr3756467b3a.14.1740461694618;
        Mon, 24 Feb 2025 21:34:54 -0800 (PST)
Received: from localhost.localdomain ([36.255.17.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9af3sm582101b3a.110.2025.02.24.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 21:34:54 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] wifi: ath11k/ath12k: IRQ affinity fixes
Date: Tue, 25 Feb 2025 11:04:44 +0530
Message-Id: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a warning from kernel IRQ core that gets triggered in the
error path of QCA6390 probe. While fixing that I also noticed the same issue in
the ath12k driver, so added an untested patch for the same.

Finally, updated the irq_set_affinity_hint() API in both drivers as it was
deprecated.

- Mani

Changes in v2:

- Instead of moving the affinity setting, cleared the affinity hint in the error
  path before freeing the IRQs
- Rebased on top of v6.14-rc1

Manivannan Sadhasivam (3):
  wifi: ath11k: Clear affinity hint before calling
    ath11k_pcic_free_irq() in error path
  wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq()
    in error path
  wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with
    irq_set_affinity_and_hint()

 drivers/net/wireless/ath/ath11k/pci.c | 4 +++-
 drivers/net/wireless/ath/ath12k/pci.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1



Return-Path: <linux-kernel+bounces-182708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0370A8C8EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F3D2824EA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC25653;
	Sat, 18 May 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cakDVp30"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F243201
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990591; cv=none; b=gLBZNm8uca27hhZSVAfQdRCZiFUEP9kwlSbCVBpzO97OaG0GhQTqEdjckq2K/Z1X9APlmx7Cw8vQshrxFrdgmqPk72GJ7xdWthIC/FIwTehCce9TGuehbydYugaMR9bHXA5V43znw+CU3SH+6mFE+3o4L8Fyc50q35U0jrl0Vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990591; c=relaxed/simple;
	bh=r3whb1M4sItdxnWLJVz349QzeARsDZZAAOMuIqEjru0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mg9z/en4IPe0RAhJpJVjMpj2ekOvtYM4CgShGGgs9n0VCor/ae7DkseX9ubqGz2vz3FyUujFPhh10XQWRGTTHOu1iXbvnnvlKHqrukF+/lF/ZA8J5fCdKqaZTA+fAmzQbgejycxIfwx2ux4Li65PT5HcRq4L/SHBOfR3jId9bkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cakDVp30; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee7963db64so25235115ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715990589; x=1716595389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUEnkAcArRRmpLRp4/nvXAmInubnyq06DYqDZwf8mm8=;
        b=cakDVp30Ri1RKVjJvpga6nObWwYioCc/TKVhs+71zKzmS5r+rrDO1CWPmfi2LgcR14
         ydotdZbLjdIMgcYqgoOTMZ+RsbtqIxwFmHmt2WoZAv3xtUkXmRLcF6YJAqQFF0C0qD9k
         xYI9UpBCn1bC6QV9Qzi75VZL93ft4up18Orhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990589; x=1716595389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUEnkAcArRRmpLRp4/nvXAmInubnyq06DYqDZwf8mm8=;
        b=JTmOKsH0wPMBd4J+HGD6YdufVznM+glin25AMmD3NrPaUP/ga3F9PTjL6i5yR9l5jk
         Oj2snkz7/zo5s51QNWlMB9NA1xPeLHfHraVkzi6SUs3zIXKwhRqIy96kHcmhBNVVcWi6
         SQXrjSZl6jnaYEbKBnhG0qHg8GQaNUG8+sW3exCdXVP+BuxTR9z8w/t++923KnlArp5b
         UJW7hm8fRWARHOi6GMZd+1Tz6F2Vmb8U3nT6B9ZRXaxnSam3il6xRrFIPDM3vdReK2KN
         My4E+82OB8FdEXqfPNUIAt5bQq5CZqjXqHAwOv+RhSA7wLGiEfBCvqtJ6OZOAjaD7k3U
         JAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoxAH56nwK/GfJ5RPVBOFcnPvd8a4pDqF0qUGX1aAh+zFb420eC9T7Vhx5alQnWfLYIIDb1DzvRc4oeww6FMaDt2ZfF+qPbrzqM+IQ
X-Gm-Message-State: AOJu0YxOlLmYcOohBzELOYG0j0wyx0vtoKYeojfohGNOW8GAc17JXRvl
	GoriYWvdL4h2oY+ZiteZ/A8g9DnbCgrWCbQxRBDbzYLZub/jIJ2FPFsyoBPllw==
X-Google-Smtp-Source: AGHT+IEOG6HPDJFK6vYgQBtD9jxWy7OIhkCMVi3oRs2g4y0sfBe1bSWs69Nb2rWkw8Yv74K4NQG/NQ==
X-Received: by 2002:a05:6a20:729b:b0:1ab:82fe:910b with SMTP id adf61e73a8af0-1afde1df2b3mr29013106637.58.1715990589009;
        Fri, 17 May 2024 17:03:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f2cd5c71sm11692201b3a.25.2024.05.17.17.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 17:03:08 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sai Teja Aluvala <quic_saluvala@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
Date: Fri, 17 May 2024 17:02:46 -0700
Message-ID: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems in the field, we are seeing this sometimes in the kernel logs:
  Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95

This means that _something_ decided that it wanted to get a memdump
but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).

The cleanup code in qca_controller_memdump() when we get back an error
from hci_devcd_init() undoes most things but forgets to clear
QCA_IBS_DISABLED. One side effect of this is that, during the next
suspend, qca_suspend() will always get a timeout.

Let's fix it so that we clear the bit.

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'm nowhere near an expert on this code so please give extra eyes on
this patch. I also have no idea how to reproduce the problem nor even
how to trigger a memdump to test it. I'd love any advice that folks
could give. ;-)

 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0c9c9ee56592..1ef12f5a115d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1090,6 +1090,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
 				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				clear_bit(QCA_IBS_DISABLED, &qca->flags);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog



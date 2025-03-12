Return-Path: <linux-kernel+bounces-557387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D8A5D83E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C321789D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E1235377;
	Wed, 12 Mar 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Le1U6ds3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E879233D85
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768324; cv=none; b=rpDiViuxh0YA/0EnAplEmkc7ksrAIQ9LnGn/sfR02QA0j40/Ty1ZeR3a1yqqwPSHRRpBVUYBuRBPFISfCuEy0VyCVKRsBWiF4uWjTHlJOu+czgKTPPgmRJupyj2GXMnqkLs8Erp1M2UyC01yg/o94P4N6BXPz48/8azvMcNZyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768324; c=relaxed/simple;
	bh=womKgPEIT9EPwHvn/d7tEBavuKDefTq2w7cv1JqJo10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bmqNUag/8lCYDkr7XozoISIj9Y9cny4CExJjdOsQOWsK5ZYz+RMxt1DeO5zxiVaqO/TxjcyaPM0RaYzxKzchUKKZBciN7WfxnuRg0LLOv2a8UYr6xPrbhkzyNRtsLFFLtYjV3LG17oaXyh7L7QVmIHnlBZRpziwcZTOnz5w364A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Le1U6ds3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43690d4605dso39362245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768320; x=1742373120; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEv6giHm6T/LYVWvdNBEPXKv/Lj/EjidI+nVqaZEF3I=;
        b=Le1U6ds3OByim1KX+KsYcBV0nC8IrhcoiAmLnIj6dgUvE7kggJMijxcohvAWLFXhd6
         y5YzDrOdNeoiESvnoBmg3IXnSH4hIV/92b8M82ypcMaMiUTxmIEfSl5HWs2pFgGUdKcd
         W50BWXEH87p+vUxWS+VrAUxM5WS2/soN6WhVEvkIVINYqWZdxjpGdSwesWtxbbEZVw+J
         BFpeCDub8VTPgAk6EQviwICPpMh0/shkp9TC0qkunb/nWXhswapJ/DYShlbYKPHOyU7X
         9ysfBqd8ZUCw5WRfyfpd23XiCcae4pze6SmsaQZKwqbdywrVKuCHbJ1/cu0e6zaxk3W1
         nfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768320; x=1742373120;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEv6giHm6T/LYVWvdNBEPXKv/Lj/EjidI+nVqaZEF3I=;
        b=rR8RZyEFDglYSXC8FuBdznlpNqXpnrn3m0Y+RB2ROJhX7hjKEK0xV2Gwv+WTAmJDdb
         vQ4DKyY029XiyR7M7h5Y9zTigjg/ZAgM/oyX1xt42zN1Q6hUWX7c1DJ+qB7PEDOO6bb5
         0rvTMFz9cmiSJEUIQOgb/h4GXgYCNfzVvX5btuHgb8o2LSBLuFXaVUg10W0cLsM9oGt6
         4DbNEabYqiQiF7xXWE3g+Uw3OcW/I9lBKhI9uPO6MDNoP4G5BdPNmPScS0lHGKHBW9Xs
         191djuu2x7rcf7rPWMxoGAhAi4HRy9EANFUkrYWfJ/fDE4eIZLqTGee8ZXkapUmGZZlT
         uSZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8wxEGosyQUmR0naeu1LmKVXZtNYTODjxGLJjerv6suL16Nejz+weUAPjzfzngc3ybY49v5NVixQulKxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BPSzE3DvJKjZeRffvntcKKVn2IwnpTamiF6AvmhGjdJZ2Q86
	/4nUcFW0wUiIYQFHtm9sEVQyW90SxOO1HVl7YvGNIsspIXYInUPOUdZPTXOqfLI=
X-Gm-Gg: ASbGncv0gjymdGnPwEefAat+K3fEgVz2rnpwwoAR/XVLSVbYaywZ6t0JEPjWUXnyDyA
	QCCoKMyt/bYRhXguVQI8UK34QRMbN69oKfTyeoWVG97/yqwd6lSlHV3Tu+N3k0ebVwg7U/DNX+7
	PMkjTW1j/+m61jow6HDuceAZx/6CAxWJeRco30sO6ChE/tr86wTpwId8IQBjfoKDc6SBqAi/EA4
	IrjHYq2V2jVdQyXwUCfb47RvYoNcTKkIapj7aAh1NglOrwVaMm8zdRNIIQySfgQURfFb7VIl+ls
	GD5IpolrMqUPOIncsPuCJ5n4xBGjsCypEDI/HTZBrH28Q6q/Vg==
X-Google-Smtp-Source: AGHT+IEKC0UilnD8jhLQLusELnZkfDUTC5jmF/RjVLX0yHm2cONnPd8ZMZIZ6muxPlcdhALj4OaMng==
X-Received: by 2002:a05:6000:1fa9:b0:390:fc83:a070 with SMTP id ffacd0b85a97d-39132b64eadmr18012730f8f.0.1741768320619;
        Wed, 12 Mar 2025 01:32:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c103035sm20021324f8f.88.2025.03.12.01.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:32:00 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:31:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] platform/x86/amd/pmc: fix leak in probe()
Message-ID: <65e2fffb-a1cb-4297-b725-661d6b790a05@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call pci_dev_put(rdev) before returning.

Fixes: 6ad1b2dc0f2a ("platform/x86/amd/pmc: Use managed APIs for mutex")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/platform/x86/amd/pmc/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 84bc47009e5f..d789d6cab794 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -785,7 +785,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 
 	err = devm_mutex_init(dev->dev, &dev->lock);
 	if (err)
-		return err;
+		goto err_pci_dev_put;
 
 	/* Get num of IP blocks within the SoC */
 	amd_pmc_get_ip_info(dev);
-- 
2.47.2



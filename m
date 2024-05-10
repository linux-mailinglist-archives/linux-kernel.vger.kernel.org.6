Return-Path: <linux-kernel+bounces-175974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A334F8C2813
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E4281A44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1317277F;
	Fri, 10 May 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJAnfTAW"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20275172763
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355818; cv=none; b=FmOUs6lLygt0a2dgpzYCl8Mu5KAluofbMfGLGIhh+yExt5nF/E4UogPkBEuy2qyvuCjAAOn3spqjL1hxH41gibCU9+Qs1SkhBDhzV8TIuOKpQIUFlJY637rp+uOljeKLpgZEaKflXrv9IYpY/ee4uLxyr1eiZH/TuO+3AmKwPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355818; c=relaxed/simple;
	bh=G+xH4AF7qc1ighXdU78nJKRNV28XMKcLeMrlk66frcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HtUf9S9P8jOYVA4w5XWUxB80zhLG+ZbPgvhxhBa20DzUCBH+9BG84ar5vM9W/wjmvMMG0NhSMsxJdB1Noc1RGZvX0+b2a4SPAkcDNr42EuHBx1CBJi7Ipbe6BHYMmfkQzjeDJ2r2nfDXkyV4GckRYnTUAyoWcmdsrUh7l+B3HTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJAnfTAW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a352bbd9so371687866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715355815; x=1715960615; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I2JjkdieyXRbDrING1zf6naqG91T7vTKCJRxlvQiF8=;
        b=lJAnfTAWr0eB1d6zLYyals0T0hmKJdgXD2083m4Qck2tgYJuM+9RWaWPHbXmTB2Jyd
         PpoSuQvD6rZJ1+mnscgQe92EaZNrN3xdlZJ3TtZSaOgrBVW+g0xQgJdAhenaHS/0RuzD
         ZuTgBt+1ah6VdyCIttyrupILsEd5Wopg85SthMfUgFwXGLAZeirgWMeRXq7RVcQnh+vF
         21mHwxTvPxsfo5/wXTAxlnhoXw17yKD9PE+IqOC+DVy0P/dWrp1AahAWCkb1z4LeD3ml
         Sp7f70efSwRX42iKufIKrjsmEa7JWu0O0mehT5BuM5Qu3i51aV8b/AEM9jWPlsQXqpVC
         yOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355815; x=1715960615;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I2JjkdieyXRbDrING1zf6naqG91T7vTKCJRxlvQiF8=;
        b=jUY8CoAkqsWO1WKiEUbU5tEkM7YOaLkkDtaNkE8uZzCzfbH4C14qILv91m2vEnwJJH
         674aKyNnjaxlESV591mddpOHT5CbkAwIGbbljfEhE+MawwlcSb90F5XnJ7Fu9FZg0GtJ
         YmZIOlDHI36D1jgVBG5VX0TtX/Q9/Kz26mDbnrLDF6t9vXuBpZWtf+fPbkg0FR8dz1DS
         JVEJO8gCD2t3/OfTmoJad5bmgEkC2YFepNvj+Q7FrkYEvbjSHWf9a8wWPXBTlUa0wFMz
         FrAAPw9DYLXXVn875zJnd+kCQDvVj6t6ry9tYQeXA58j2lR49cph9Px4STL3ylR2tyrc
         5a3A==
X-Forwarded-Encrypted: i=1; AJvYcCW6WxxnjeKtPpiUXHdexSPBRAKYL8vhCh7rhwCV2/rWuhtnve9KSxriVN8fv0nOrmbSbR9G5SKm+RAFtg5dIcpv/4JDLokSXKSN0mdW
X-Gm-Message-State: AOJu0YzHCBYi3M/goRf32bZVUMCUhPRfCOLk/SAv+MogWyQ8pR3fpynq
	sRaqRpGkKa0muGzdDh4PcOQDRNwZ9iB3/F6WesWfLSEDmyBiKwI5TmJVhZdoIto=
X-Google-Smtp-Source: AGHT+IE3xlquVur7sdhTe5QiuL1P4R6FQeWnDOJzPQFLVv0j3JLJeMKX/K7tBPcM2yD5KDE1rCRCRQ==
X-Received: by 2002:a17:906:b7c4:b0:a59:bb24:a61 with SMTP id a640c23a62f3a-a5a2d292a23mr261622066b.30.1715355815485;
        Fri, 10 May 2024 08:43:35 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d27bsm194279066b.21.2024.05.10.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:43:35 -0700 (PDT)
Date: Fri, 10 May 2024 18:43:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bingbu Cao <bingbu.cao@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] media: ipu-bridge: fix error code in ipu_bridge_init()
Message-ID: <f468c4ac-0629-41b5-b5d1-e26f70e44800@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -EINVAL if "bridge->n_sensors == 0".  Don't return success.

Fixes: 881ca25978c6 ("media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: style change

 drivers/media/pci/intel/ipu-bridge.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 61750cc98d70..44a9d9c15b05 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -839,9 +839,14 @@ int ipu_bridge_init(struct device *dev,
 		bridge->data_lanes[i] = i + 1;
 
 	ret = ipu_bridge_connect_sensors(bridge);
-	if (ret || bridge->n_sensors == 0)
+	if (ret)
 		goto err_unregister_ipu;
 
+	if (bridge->n_sensors == 0) {
+		ret = -EINVAL;
+		goto err_unregister_ipu;
+	}
+
 	dev_info(dev, "Connected %d cameras\n", bridge->n_sensors);
 
 	fwnode = software_node_fwnode(&bridge->ipu_hid_node);
-- 
2.43.0



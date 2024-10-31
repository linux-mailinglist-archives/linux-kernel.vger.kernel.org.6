Return-Path: <linux-kernel+bounces-390781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256989B7E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E861C2242F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1941C2DB8;
	Thu, 31 Oct 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rDECpU8L"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E591BD501
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388443; cv=none; b=p8Vp7coQ19XgPDkUdgItHzJNRsmgI7aM9jCNG+O/0Ky2Xzk5t9XREsWNa88FcD2E8Bil8ojOBFnVkFPQZ+27m0f3hV69G38TE3OmZPIdwztrqloE+NVH+BC53Mb6JHh551XWLAYONFYfOk/qkknjnwpHJaTZhR5FwiCKsxE7ymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388443; c=relaxed/simple;
	bh=PmGalM7Ef6Ks5hbegfAqXArWEMF8OjNxmIq7YA4FlKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHlf0kX+SLuIfbbSxB8vg7a6C+gyZZMDfazlD/NRHBhyoGiVMZoUUoWfKBt7pXEcmSn4yASb/OuDvdLQpn4AuA11o9LILS4kxXUuLUE3iALaoQEnTgSSUMlsdWeWCScsfyNKy6KLoBlll2Cyyaoubxrhw8WCIxEWXMuvBXFHuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rDECpU8L; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315baec69eso8784485e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388439; x=1730993239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+Wt5gEXGTTMFhAf0TDuO7kCimt1FNZkZpqrNk88/+4=;
        b=rDECpU8LLFZNExbnFx3LPyTbxhRbjy+IHzff9CkDrdLdngzlmF3rVQgDWKISkXwNZo
         siJueAzN6qWTeVGie1eIHUHv7RRWZ+3VMzQ1cQZwzzQfJs5r1HMpefIVIzF9473Scvyl
         SvsoiVbCmVvVKi2ceFUAMPP1xqUI0x4k1x+ERF20OlH15hyLKW9dmgQwxhd/40LeOIvL
         9J9zw/rsfEjBJ9k2BDpNedgjsUx+3PZPyPdG8t36vPUk5rkOs1EoDmIAlrOFzFOarEaQ
         Eu0kd9xHmwUdQK5JeZgzlpqgc5WPGkGmhPu8+sNd9Kh9LfhynDwnSClH2Z1uy6msvXLj
         RVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388439; x=1730993239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+Wt5gEXGTTMFhAf0TDuO7kCimt1FNZkZpqrNk88/+4=;
        b=P7gc8NE8IVxJh+m/3EF0WWX806j/zxFTaHZt2qcVr1nzKeG30Ue2+FWeZuzKyFa9cg
         qUyFRWiuiYPeLEmsaJ1jXGitKU6T6hwAZLnNLUbgIO3CWtMJ7feYfQrTnCGcWkfr4XV1
         2ezY5UXP3XrM6ER1CXy1Edg3cCmuCgnTxvNRc5pKljADzOoa+TjHVcOdgKHyXva1u/zZ
         D4IS1014qLdErgdtFIbrK6gR5YSFWtNi4ER1+hy/sA0bvV1sADpObFCKui2X1w4M6hqU
         8XAJKoodSXc497xyV+Uj1sFcpj2+716/UyBvtThGWaz2/3ql2128J8FBpdPjsyWsr9ea
         ULBA==
X-Forwarded-Encrypted: i=1; AJvYcCXfKzBJtGaFEbezV5t2zhrRFK8q2YNv9VPYUdpONlU00Gh+qVjFWDyYboxDU00WoeQ/Cw9gRh9A+ghzXrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznNWCx2nxELEsMgDfn+oJWies0k+gAVe/EaeLylcQftVbmUrEs
	eniF+XqZrbNtIXWLvFGrfltUertZY6ld0pyJXk3rmiNpqPAUlEY/lsfq8/QRFxs=
X-Google-Smtp-Source: AGHT+IEyu6FJS8+aBQtlI/2iMWr0qg8SLYMIc2U9veyCeAFrXBtLbW2/W+xR+K+a9Ow41bs7++cXAQ==
X-Received: by 2002:a05:600c:3ca1:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-43283255489mr2254255e9.16.1730388438884;
        Thu, 31 Oct 2024 08:27:18 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:06 +0100
Subject: [PATCH v2 11/15] iio: imu: st_lsm6dsx: use bool for event state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-11-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Since the write_event_config callback now uses a bool for the state
parameter, update the signature of the function it calls accordingly.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index caefa15e559b8808051ff1c7f82c3f36c947933c..509e0169dcd54e773540c4e3f1b56e5b737f80c3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1865,7 +1865,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	return err;
 }
 
-static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
+static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 {
 	const struct st_lsm6dsx_reg *reg;
 	unsigned int data;

-- 
2.47.0



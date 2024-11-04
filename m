Return-Path: <linux-kernel+bounces-395282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17EA9BBB42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34B41C214B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3F1C4A18;
	Mon,  4 Nov 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MblyU2Nu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B11F942
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740589; cv=none; b=UZFxba8W9K6JXXlbif7iZD1QH8n0kZYoZpNZPb65dpcZ1AewflAcovzjMYmBkHGsG4xyLYpnpOFr/Mwzpp+4IqZlnn7wu4RuXmGAPyyWGqK+iD8jjRnoTuSa6co5f2wbhFbFVF9qLVf2rMl7zCdkJbgW4/k/o+1XXfG5NQcTT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740589; c=relaxed/simple;
	bh=oCbyiLng8gGHLNAG5imDAdJ2j5aQ/UDK+Oox/7J/Y2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tGPUSQ/ibFcxJNL+iFZ+yIgiS01pbZQ5s6KQ8S94QKtBxUGVhPXt8Tn9BADbcFFTw4hRX5QCLMkYfUmEwLhmIf4CKuTbYsREr64yHstR9Adz4W6TXzyUQ0RtkOKpvTSP0CL3I2Ani6loqBAPjvOJ7wX0o0xq5uLdBTjd+zhFZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MblyU2Nu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431616c23b5so27322105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730740585; x=1731345385; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=la6xj5vR8nTJ73x2ZaTngF8peM8uUMZUxIbbvjw1ql4=;
        b=MblyU2NuR5et5Co8CUw/M252Zxk2rgeLO89bWr5qJSO6eID/08G9zbvolfF/dM04vQ
         I7u7hijE/iUMBAZ6BgbhAEKwAej2JqdBOUicRje9V2nkk9JacfqMh+pwWSTL+b5600ay
         utRr3fx87bPQHL3iewOPXMWK5H24eSGkitz2DWocPhydPOkFyVWI4w5/nJk/BC2Jf/UP
         hsevU12EEBnE/cL15UNdaZ1pKwM/4RLtk7R+JuxhJBqKGzbo0iLnQlzU1CGRwLF3xjl0
         /ysVE+wf6Sh/T8InNYQkBrDDoY/uLgzW0ddE0KHPQ9lpeGCrucSRTkZIVHEZS+7RiMp3
         sy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740585; x=1731345385;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la6xj5vR8nTJ73x2ZaTngF8peM8uUMZUxIbbvjw1ql4=;
        b=rsAwsGdceF8N5oYODGyJoIuujY+Na8noseORpQZpFWyC2Xnxm3XLi8BtNn50o7JdyZ
         dOpFxmsmKbz1CZUJxe8f84nvVrKFssWXQjBj64UhQQ7qxrXDN4F0bNMm2xlHdBAo39fL
         QeIeI1o5sRnTvZp3cUH8UQ0VZONnORdmtJtUj2YDJ2rDvyBfSt23t8WoU8NyY3qucEww
         3yBuUZbB427IZrL+p6ptWwcEermImEr8NQQOJiUBKDjR+e8ygdjYcdBegKDRej1SpOvO
         khs64cIAUCTFFoPArh7z2QhdiJhvS8hjRENHi7L+/8keyINyf3PjG3TFqj1Fg836zVA1
         BxSg==
X-Forwarded-Encrypted: i=1; AJvYcCUEuXTaxGcsFQpIZ2hzIbob0Fxr9kRplUUhAXPMJTVpBcktiieoUoJAJXq2ULkuux3iB6/PoqdwALEyCUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOB8Q5pcDzqejb5TenWu4x2NJ+fyl2Gkpf6NZRdzGd10A5ZFJ
	9QwrlptVxNZIQILflGctasxuNMty2KIrnnGNamB+7uDX7qI5u29776332zfj1ok=
X-Google-Smtp-Source: AGHT+IExVi+NfBAt2whjsx+0Pt93IxelL6rLzuY/ubpqgPe9heWtnY82NiVFj7fqgDFJGWhQtWWPcw==
X-Received: by 2002:a05:600c:1f92:b0:431:405a:f93b with SMTP id 5b1f17b1804b1-43283000cdcmr104416805e9.10.1730740584601;
        Mon, 04 Nov 2024 09:16:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd91096asm194139975e9.13.2024.11.04.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:16:24 -0800 (PST)
Date: Mon, 4 Nov 2024 20:16:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] media: xilinx-tpg: fix double put in xtpg_parse_of()
Message-ID: <f41dfe97-6e6c-47b4-91bf-199c5938c6d0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This loop was recently converted to use for_each_of_graph_port() which
automatically does __cleanup__ on the "port" iterator variable.  Delete
the calls to of_node_put(port) to avoid a double put bug.

Fixes: 393194cdf11e ("media: xilinx-tpg: use new of_graph functions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/platform/xilinx/xilinx-tpg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/xilinx/xilinx-tpg.c b/drivers/media/platform/xilinx/xilinx-tpg.c
index cb93711ea3e3..7deec6e37edc 100644
--- a/drivers/media/platform/xilinx/xilinx-tpg.c
+++ b/drivers/media/platform/xilinx/xilinx-tpg.c
@@ -722,7 +722,6 @@ static int xtpg_parse_of(struct xtpg_device *xtpg)
 		format = xvip_of_get_format(port);
 		if (IS_ERR(format)) {
 			dev_err(dev, "invalid format in DT");
-			of_node_put(port);
 			return PTR_ERR(format);
 		}
 
@@ -731,7 +730,6 @@ static int xtpg_parse_of(struct xtpg_device *xtpg)
 			xtpg->vip_format = format;
 		} else if (xtpg->vip_format != format) {
 			dev_err(dev, "in/out format mismatch in DT");
-			of_node_put(port);
 			return -EINVAL;
 		}
 
-- 
2.45.2



Return-Path: <linux-kernel+bounces-317310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C496DC2B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD80289315
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016681BDDF;
	Thu,  5 Sep 2024 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a89zwGdP"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB81BC3C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547342; cv=none; b=inMQFeKSs39XHud0KydylCl3gTWeK4XgVhBoyUNFK1RZR2aiehVucjnYY2Vgv9azUslNNUhdzgUITtlnmsmaI3JEGTxQrErfURlt2qEzq5Bzculaqg6FWQKiW1uwrBNw7gbYhgV3YGvdo6QXGo9sSPTaNBkMBWA/OpomIvi3xhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547342; c=relaxed/simple;
	bh=aXfRlCHO9U73rweATb+imgYLC7Nj0b4oIsmJXuGFxgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlKt9qGAP1+MJUSeqePLzRcB46Js0ZnUi+KjYZYlAnILmy4s23vpKl35HGgWtOmK7obLpDEfwaS3N/YQOPX9AGEl1fp1mrL/Y6C3BPb4J+ss6VjFyekzdpiOGSxhRc/BzOWHpbfkLc1nv4GatnfLPlYHrAxl3p17UsvoqYPX01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a89zwGdP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so627111a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547340; x=1726152140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CaWdTcmyOEM+3lRJdsVZfW3ZYgCG1mOBZ0L8KgSClI4=;
        b=a89zwGdP/tB3MGgxriaDucWGXEMKDwpcm0Myg8CSN7lH45/ZED0aarPLZKcxH83L+E
         dZl39+puUvAD/1zGQy/Gxo9pfRE8IfsuT4Chag5YKMNfJLGXeC1DgpkZvIetEdTJ6oUn
         dBzmFDWyn6rwx29iIQFcQUgi04gPj73PmEX1MwUTUc3sa7/xLQO2WPUNNcqGgWXOIZDX
         HmiqfdRikQ4OEEiGaAhex9QH+2WXvuxma5Z/LhdZMXTClz8tbAj+E4fWipPHJVedbjAN
         /GOyC1euP8yXO8agMiB+AaGButJd/mBUq85KG/0Ngtc8zUGdSn0XUiimZZBZ98VZbsdd
         HkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547340; x=1726152140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaWdTcmyOEM+3lRJdsVZfW3ZYgCG1mOBZ0L8KgSClI4=;
        b=Srz676V+PM7hsLPr6DkQlPJHOxiV/8hBXC3l1fSRFb6i44tM/SkQlyul1Y/OMybT7q
         IiZzHaEgHEvJjg3TDn/XvJcSIcKygTxjJxYRxS8OlRsISCeIFaA3HmaFrL5TXYYpAllw
         jWmociZrG8pu1H+11RyfEgEr/HVT6Bj+H/wEV9YlOsRimimSxO7bHFJpbHfc65uqQLfF
         Sg0ennsAbACwDefKl5P31NDBHtPMW8qMqIql6k+6i7FEK3bhvKjgTjVjFxInUSJk6kMe
         1kr52DATz8zozNAKjKJX1IX+xYWF2wWMAC0s9KqBhcOW6+TGT9Ww2osk98RAZJ6ngY0I
         VvIg==
X-Forwarded-Encrypted: i=1; AJvYcCXtCghKmPFE5kVIZY0ueeuCck8XfgB++gwIOeKdZ4XV/L9/jlDl/oxGhid8TcfPr3JKIwOtajjWfN890uI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DKiPIVRISZNst5x3lS8wLhQOuSwbzFefF0ELyDhVg6jPBUP8
	pMKdMfp5ccD59HTlYB6yJFabbjASl/ERQ56WsAW0gDiET3QYKDpD
X-Google-Smtp-Source: AGHT+IGoA29ipD5MndtKLzk77etEOqRPaJ8Gk8hi6V0znxcTsl8g2S1gRdg6y0CxoNhffns0tVpmbA==
X-Received: by 2002:a17:90b:4c48:b0:2d8:25ce:e6e3 with SMTP id 98e67ed59e1d1-2da8ebd33b6mr9814349a91.5.1725547340047;
        Thu, 05 Sep 2024 07:42:20 -0700 (PDT)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da7532583bsm5135186a91.8.2024.09.05.07.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Sep 2024 07:42:19 -0700 (PDT)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ni_routing: Check when the file could not be opened
Date: Thu,  5 Sep 2024 23:42:12 +0900
Message-ID: <20240905144213.8954-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
---
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb..d0321a7565c5 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -139,6 +139,10 @@ void device_write(const struct ni_device_routes *dR, FILE *fp)
 int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
 
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
-- 
2.43.0



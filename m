Return-Path: <linux-kernel+bounces-242060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA4928324
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550CA285A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E08148848;
	Fri,  5 Jul 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+pXy+Pm"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E91487C6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165764; cv=none; b=NxXq0ockqRqAj2zed6hDht4NSSA4r+F488oH+YbP1ah1ARdFNZBSA4BIFzn4EcQXE8yJT3E57O8y1qIkOBLPA6HnpcGUtQCx9wXSH7u1/E/Utt/0Vh7nOE99eI7SgSPMBGk2QJuXumjCqXppB5THohqLKNnFFlopVtziBe6iBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165764; c=relaxed/simple;
	bh=ovbfKmCLQ8tQJku7TqJaIpcegQLVJ/qlt6pe+CLD2LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMDoQIkDvYkoWxyKL74UKjfP50B89Ix9E9P4pchbtTfZRLOnnlSd4aP5BxPg/XvqCAbeHpa9cq+gRkTKWJ6JwN4nMcD4WU65DQl/yGmJnRqWMuoy05F8E6qu8XLl9K3+UeCX97j5wIr4STwU3wGmHvizWxxTtIWS5hMGluk6KWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+pXy+Pm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea79e6979so174424e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165761; x=1720770561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNhG8coS+s8cdVOrxBSzuNnMnI9yHdY2rEbzIVF31LY=;
        b=P+pXy+PmWX1j8QFBQa7G1inEjgF7kNXCOsILXG+1WJ67/YsjCzXYxysuwaCNVzgJYu
         Yslf0XEUO4uGdHUD7gupdZochRZ6KBb8/U0uHYnDknaAybIPigOJQSjV2LvfvICDYO1D
         B5bx4u4bqNsT5PLNPcTN8nH9gelywnYpGnGwaJ0P+GUXgoVDVXs7puxNJHWBp9JxKwY8
         35Nf9ZkYXj7jCwr4uFEB3BppnGd/Hx5fYJBCun90tjVs0Cwho+LYRb+Z227CE6rJZSWr
         xh4jOfXDKEnKn892NO6zNwJSJ/WLlXi3SvJwNAmaBznDtk1kKQepXxSd7DdqXeZXeUID
         d4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165761; x=1720770561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNhG8coS+s8cdVOrxBSzuNnMnI9yHdY2rEbzIVF31LY=;
        b=AjgmDmfDTm/TCuQedly+uHJKbtRDrQXRQQ/3AMUpmEGIOeZtwLwdvUUlUrsQ9IkGLV
         fOwoXXYg73yYNqH4dPhV3+mLVQ+L035xMk7CrKLJC1rHPifBYv86nZEQ+k6q2g8XYfAN
         Ab1h9dTfDlA2CkJ9/Yy/c4SBUl+ux9tjM4KfXdfkkmBtUCTiqxfza+9VheCe35iAq5Ny
         blslcHo+pFKpWInqwpHD+gnHnoiJmERrCdFAmjVyJdyUq5oz0OReR5LRukcD531iAQo3
         4qex1nkArzO58VVchZ6GwH1FWi+kVpi7gwi7RmNTPLLaylUaiqHjZ0M0iQTHyUyOt3Ii
         uxlQ==
X-Gm-Message-State: AOJu0Yx5iDKJlT9g8bIlvBrubNCjHxceKdWBdkD6rxdu3iuRGHrlNXU+
	qB737i3b7LHTe0RsODAEOr2c9Y7mAGBwsHW0NmJ/8MBS/jQkasm+Hxm8wSMimpY=
X-Google-Smtp-Source: AGHT+IHwqdZVL9KI2H+Vpv8rZZrjKcO3PVV8F4KUSuMpkLSOzHvWHI2Y0V9JCDC+UlWviaKXjRgvZg==
X-Received: by 2002:ac2:5a50:0:b0:52c:dbc6:8eb0 with SMTP id 2adb3069b0e04-52ea0632ac0mr2966146e87.21.1720165761167;
        Fri, 05 Jul 2024 00:49:21 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:20 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/15] nvmem: Document type attribute
Date: Fri,  5 Jul 2024 08:48:50 +0100
Message-Id: <20240705074852.423202-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

Document a type attribute used by userspace to discern different types of
NVMEM devices. The implementation is already present, the ABI document is
missing, add it.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/ABI/stable/sysfs-bus-nvmem | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem b/Documentation/ABI/stable/sysfs-bus-nvmem
index 854bd11d72ac..3f0a95250aa8 100644
--- a/Documentation/ABI/stable/sysfs-bus-nvmem
+++ b/Documentation/ABI/stable/sysfs-bus-nvmem
@@ -20,3 +20,14 @@ Description:
 		  ...
 		  *
 		  0001000
+
+What:		/sys/bus/nvmem/devices/.../type
+Date:		November 2018
+KernelVersion:	5.0
+Contact:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+Description:
+		This read-only attribute allows user to read the NVMEM
+		device type. Supported types are "Unknown", "EEPROM",
+		"OTP", "Battery backed", "FRAM".
+		Note: This file is only present if CONFIG_NVMEM_SYSFS
+		is enabled.
-- 
2.25.1



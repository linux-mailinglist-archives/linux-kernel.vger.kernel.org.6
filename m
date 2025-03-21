Return-Path: <linux-kernel+bounces-571146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830CEA6B9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32167486458
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF22D221F1A;
	Fri, 21 Mar 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NehhPLtx"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAB1F09A8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555914; cv=none; b=DnyHlh2Vwt4fe0UG2OYiU/ORXrYlUfP2rC/vukg5n8nio4JSIP5qDjiKgx5xQMhXp21oaXTTMzU9YhCof2cDSm2qkEiP/rMzmnK/Dy+Mby2TkaOrugWJ1Nee4uSv0rWEi2Pny3/7sb5qYS2xYTktBx9XQYgvX3E03Qog72t5RCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555914; c=relaxed/simple;
	bh=chu5tQdbQx5dQxAsw6RktvD0RuLpKPm3d2Xa8rL0zy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CP2/ebclXqtyj7OErnZZ/WZOG1YHGPZQgPBKS34xWGt3yQeg3NFOF182bOB/9X4AiV7+x7+Xu3Zv47tH9+BZoYlGNGAc5vChWDLuf2wSRuW3XDn3fry6LbXEiiLE3USCvgP3lwEHV5llbxrLbZA3tjKmlUSNAPLTbh388Ozl7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NehhPLtx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac289147833so78331066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742555911; x=1743160711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFeE6aXRmnU5O//57W5zBrrzKt/ORqaMUTyJo4pUduk=;
        b=NehhPLtx7IWpO1VU7Hria98UeTj7RZhahymRmrgvgSu2WBnjvIeD4Wh7hDYK0lsD/3
         haqxWPQ4ZhOhVqhSJQcvUH10eTJYmSrkJLFFHY4RBYtg7WC+ajh72c+D5eXyKy45zzo/
         etBPaudAt+VfB3xdDy+wNLfMA5uc1hH2VJBjLR2b8mWK1nFo6ECSiTbjj/DUoU3of8CM
         6Wll/8uQfIoNK3LkFnfsT6uR/xgfE+auPnRpjmFLDiGA8PF0eskNB2Ngz1UPj7ftW+r2
         IjqPjhs68pPqwAkWSydE58SydNeI4jGLVcVGgk2cGbdXAT8wVVdFMjuoHW/RHgjzR2ws
         D9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555911; x=1743160711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFeE6aXRmnU5O//57W5zBrrzKt/ORqaMUTyJo4pUduk=;
        b=a460eGmKKD2dnwoSHI+Io9iEdAj/lxP2cYN9m1SRPXUcQtiZncLYtMw43lT6iXDO6p
         dss1uh2V60ehK4ABP9ejavBMtc0MQrC+4UUu3zCSo2Q5Mg6idpzxQzvch5aaQYzEQcfp
         4tUiw8dP3/qqoN54sot9Ua0B/4J9vMs2Z6hZG3YmrZIReXvhWxAv9kDL5XXKo8VLt5Sj
         TrFobJwvG5zebBr1AQMJTvxv6Ysii478iEdrdCpd445bZvCIDvdtgYTuuiykWSw4Amx9
         hXuwPNvX5jBjovOeHPu1+Z7LOeC699go2lIIk2qherCOiEh/+yOOex2B1uajc+Sc1yCG
         i+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrWdhraO+zestfBoMnpAOPkZyU1eP+5MBqgQK9Tg22roQ2NtfvhN4IXZxnRsLuGfXZH70lDOnP0oaENcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdC4NMF12Bl1w8ef04Wtf8ae4BiUTDCFFiwm/oRTuAwhU5iAE
	qEInItm4gzimuBoJVjrQCVAf1mY2qjbAV9ekqOh0LYSNqTPQRI4D
X-Gm-Gg: ASbGnctwjAbIq1cFXtpHwvGQBZfjN4y+9/1dSu6r5vE8Ts9ILlpo3CrJwRFFxTbiPbi
	7K7U5yFvsnwmwxJsJQc54Ef1ZIQsEA2Dk4XSFpk8bUsHQspPBuakWzgAlGSDpAAqaB934XroOmW
	mE9vpf3JoWuus0TqFqSms1/6FjF0C+FqnwQqUmsaWZAahAB76xxEq2pGsA4iez1fT7X/yJrFH00
	lr8QilybeBL+iCIJLKqWpyM+uGmCvmTi438kofz0M4E0gzOno2opgIIh39HGUi6Tod/ijVb5MOk
	7J1m+g7Q9IbYrTFRSbAeqU7YN7H8zyqgpDI5/KE/eKi75hnU
X-Google-Smtp-Source: AGHT+IE5AEMn7ZUeb2CVfS5jr0PUwywmRwn5qtw5LvUiFwpEOWtN04m99x6ubxHzMaM5o0+/15Tz0w==
X-Received: by 2002:a17:907:9718:b0:ac3:ef4:d34d with SMTP id a640c23a62f3a-ac3f229369amr281711466b.28.1742555910584;
        Fri, 21 Mar 2025 04:18:30 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd569f3sm134228866b.171.2025.03.21.04.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 04:18:30 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: 
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] MAINTAINERS: Add maintainers for Ultratronik SoC Boards
Date: Fri, 21 Mar 2025 12:18:17 +0100
Message-ID: <20250321111821.361419-3-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321111821.361419-1-goran.radni@gmail.com>
References: <20250321111821.361419-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Goran Rađenović <gradenovic@ultratronik.de>

Add maintainers for Ultratronik SBC STM32MP1 board.

Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401e..26896dd2ceb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24336,6 +24336,12 @@ S:	Maintained
 F:	drivers/usb/common/ulpi.c
 F:	include/linux/ulpi/
 
+ULTRATRONIK BOARD SUPPORT
+M:	Goran Rađenović <goran.radni@gmail.com>
+M:	Börge Strümpfel <boerge.struempfel@gmail.com>
+S:	Maintained
+F:	arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
+
 UNICODE SUBSYSTEM
 M:	Gabriel Krisman Bertazi <krisman@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.43.0



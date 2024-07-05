Return-Path: <linux-kernel+bounces-242059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5905928323
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812A328651D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50D1487CE;
	Fri,  5 Jul 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyFEI64W"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B631482E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165762; cv=none; b=RVa+MwhIe6WPItWvD23w/MBES14An7dC/oLYRlC6pDWFpatZd1FZhF4OXHj0ewl2Mukl6ExeMhdb8VKhGEQeFWXtWmJ2AiuYhqp9wK2FONmzKPZ9gdFxt0JTBvz+Fzv5HnTNun8o5Ileh0sM3zg8TNBqNspkd6vVerMOdLHikAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165762; c=relaxed/simple;
	bh=DMCdzn4lsRMoH1EDvKoludOa1bemgtjph7OKGjhUJvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcxRL7MJ49fC85vNDRc/HYf02CKlTa7hx3qKt0c00bOjM9SVikebWh3WaQFU7Epe3VW4o5jhhnIdk5bdEMId+Z43OpchG0FKOLVIiBhBEUf3yfRmz1a+Sv0CLS/tutpil+Ty4zCCBmBoFqP6PjnFMJegtmxnvTFjroT0bap4HyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DyFEI64W; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-356c4e926a3so741127f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165759; x=1720770559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzsIUUlH+MlPnhCm/A83/7nDy6Hh13MepVcPKiER9xQ=;
        b=DyFEI64WfWMTygA/JoCxU3tFjZ2sary5Vd5B6wd1kgN7u8SJziHGJcY8Mv/TZ5nhoH
         Mv0qgitJ1jtp84vdYFwMVLO4ZvWpRSoSL018eOLy/Zn+VFKnq2/2sGRIgcvEXmi4SikX
         MaPieLGHoTrK71D2M6cCcEv+/e1fP0ifkoWLhrMMdJeEaw9v9IbOnnohVkyOd4Vk/5dG
         3gGx51Yhs3lh2qqBua/km+lFhvj79BhuABMrJAt8e99ruiHHD/pVyzKsqVJ+vr6275yl
         /4fLyxb8BDnZukEtQaGUHmgw8GwJxkzCOzUePkUiwVlk7ciwknGnFquMVpLVAhbHktmK
         Hf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165759; x=1720770559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzsIUUlH+MlPnhCm/A83/7nDy6Hh13MepVcPKiER9xQ=;
        b=EQcTRt5WNbMayLkJYLNPutfnMKvFZXy/2XUDh4WupkexXWa2sS5hBTRRYWq98DXPo8
         HDLfwxqItt1LmLKIZTcLXwgybDdeEqZkl4gY62kxOa4r0vEAJ/x4HmMGz0yFCeLRgsSi
         uj+sbfqgj+oOLSMF9t+PDpCjf96Z0eR5d8F2ArGNRtFlrdEa1wz6p3qvII8nHYgeezxJ
         eARP1aVaSN9KCKuJ+SLZv010Zh+DLmtsdpnZRz54yHuc4EOiFaCXLf/0fAnbeND3Sf3x
         ebl9IpVhjm3IApJvPxd30W3IYehXXlIMwRPv1Nc4O/KLqncWOjTS07GfHkx6Ywgf0zIw
         0Dfg==
X-Gm-Message-State: AOJu0YzZk3CtBi4W1oHkrVdX8kR2lk+/54AB4td8AT5xJaNYGWIb1SUn
	7+1T0zki2aieVAPLWQVqSOskam9lXju9srrUTD8rjPm1r97f8nX/HCKyFV5v+YE=
X-Google-Smtp-Source: AGHT+IGmGzU58oFlqtGm87XuCKdMR/Ds4+L94WKx5hOP20Ch+4R32B3NV91i7JobhrxL6bpR85gnbA==
X-Received: by 2002:adf:f8c5:0:b0:367:4dc9:efcb with SMTP id ffacd0b85a97d-3679dd7bd10mr2523568f8f.70.1720165759616;
        Fri, 05 Jul 2024 00:49:19 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:18 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/15] nvmem: Replace spaces with tab in documentation
Date: Fri,  5 Jul 2024 08:48:49 +0100
Message-Id: <20240705074852.423202-13-srinivas.kandagatla@linaro.org>
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

Replace two spaces with tab in the sysfs attribute documentation.
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/ABI/stable/sysfs-bus-nvmem | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem b/Documentation/ABI/stable/sysfs-bus-nvmem
index c399323f37de..854bd11d72ac 100644
--- a/Documentation/ABI/stable/sysfs-bus-nvmem
+++ b/Documentation/ABI/stable/sysfs-bus-nvmem
@@ -1,6 +1,6 @@
 What:		/sys/bus/nvmem/devices/.../nvmem
 Date:		July 2015
-KernelVersion:  4.2
+KernelVersion:	4.2
 Contact:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 Description:
 		This file allows user to read/write the raw NVMEM contents.
-- 
2.25.1



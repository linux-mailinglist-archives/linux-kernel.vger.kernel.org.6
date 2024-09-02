Return-Path: <linux-kernel+bounces-311513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06B9689FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF5B23296
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E993DAC0D;
	Mon,  2 Sep 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Huqd/a6j"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C72101A4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287414; cv=none; b=u8n1mxAzVKHJ8Q1JXAWMhGy7TYg1B9WbleKwuTfjQbH33bKLWcHeNe6d35VpO9tPumJ9il1Da36mokLF5bWalx6rtTox2iW5LFJ/U3dXLCbJzVjXnpMrTzEjNtrnHM7/y56lhzsBiJB2/aJrJ52f8Fcd7uVoeQBmpqGjbUIhK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287414; c=relaxed/simple;
	bh=cAWGZ//sG6FfvQrU9FuP5gcKwJBjNVFImbAO0zgT8MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZF/FHtDGHH/TsgzBU8P8fMq2MDCPEGxlzydV7Kk3DOST+jn3IZvAZKcjs/x+3P3G89H6BrMj8vM7zNOHczNqAL2OasDIcW78P7SJKmceR5YSjO2wln36wazUatCk++m7+GeklYYK8utzxsfEbfG86rrQtED6kcAFW+k79+T4pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Huqd/a6j; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a1d78e7b0so15284866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287411; x=1725892211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35hy4fLRqiaIxXHyqs55ENfHcWcbMlUJr9u5FrPl6mw=;
        b=Huqd/a6jMuV0cv1MfXOODLdyujfwmuaXjjd+xJEtkGgFf6BkahyMw/9/sbsEv9/bVm
         JiyNyZltFvKID/X4mAA5YS/Avz0K0PYyloH6BP3+/xS9Uo+c/c8y7swVtqhF/RmlyUhk
         nmd4dJAWbaxGOOKcFXkoOgXgJqs9mcLMqEYDAKtvmVN6geLbeNy3aT6nRBkozi+rbsCX
         c7QHTAu/wzl2HFgcvik3x46xO4TeWfhf8SECdu6BABIC18dTAHaX221gdGD+SRiOW74/
         nBTdHyDAwt7/ZRYtAdWZMmYvmF26+6FIs4HdMzBxyDZRuX2xwXdTS/+SwAswPFnYVj6h
         EIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287411; x=1725892211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35hy4fLRqiaIxXHyqs55ENfHcWcbMlUJr9u5FrPl6mw=;
        b=PRfsdWZHPpEB9wltfdQoMR0cEIr+jzk7ZLS4l0HHRkzfyhOkpDwMsHbswYepLza+7O
         34P+W83fuPeITHziJCmDqE87LTb1UMI8j7R4ubZ3oyzvSVvlom8VZkNMbieqaviQVH28
         dRCmTUAALNUvyNt88Hr5L7VfPAoXS43RogGO5LkPXPZ1sq0HLVWoyhrwFTVnTDLrGggZ
         bAHhe7pci7j0BGBzOO4VswF/b7Yv9BsajP13M5m7uW/q1gkiwPV1HIDy6p0gPs2GKWhw
         Tw9kpKva85gGmNdwcYisApREL61BG/Yx0wBoSQR7tz6mGDejA5m54Qz63lpEJWNRLAyk
         A8aw==
X-Gm-Message-State: AOJu0YyGtcxB2bIDLwg12SWkDa1GVVUPlwc9A0+pv3xXup+OSW+7Nb2/
	0+P3htTUB1FYJpP4C/K4JAyA29QqUo+SeYNVm9BTWueDpXmFYqYaFVXAoCXAv1U=
X-Google-Smtp-Source: AGHT+IHxXo2Ts6mGIg5sXlbQZgoVwIjRVVVsHyvyU1v7sPkWub+0tMhbk87+ZARLsJYSXjcjyrgZ4A==
X-Received: by 2002:a17:907:36c7:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a89fad7c539mr313330066b.5.1725287411023;
        Mon, 02 Sep 2024 07:30:11 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:10 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Marek Vasut <marex@denx.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 8/9] nvmem: Fix misspelling
Date: Mon,  2 Sep 2024 15:29:51 +0100
Message-Id: <20240902142952.71639-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Wilcox <willy@infradead.org>

There is no function called kstrbool().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/ABI/stable/sysfs-bus-nvmem | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-nvmem b/Documentation/ABI/stable/sysfs-bus-nvmem
index aa89adf18bc5..0ae8cb074acf 100644
--- a/Documentation/ABI/stable/sysfs-bus-nvmem
+++ b/Documentation/ABI/stable/sysfs-bus-nvmem
@@ -11,7 +11,7 @@ Description:
 		Read returns '0' or '1' for read-write or read-only modes
 		respectively.
 		Write parses one of 'YyTt1NnFf0', or [oO][NnFf] for "on"
-		and "off", i.e. what kstrbool() supports.
+		and "off", i.e. what kstrtobool() supports.
 		Note: This file is only present if CONFIG_NVMEM_SYSFS
 		is enabled.
 
-- 
2.25.1



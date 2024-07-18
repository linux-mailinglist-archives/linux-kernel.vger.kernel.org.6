Return-Path: <linux-kernel+bounces-256137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF60934994
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557861F23AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5245978C8F;
	Thu, 18 Jul 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcRd4FkX"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421EE770F0;
	Thu, 18 Jul 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290174; cv=none; b=tJCfVxuPG+k28KqHql5PvOG3l/pVyld4VvgHx5Ej0zNjctEq922JYwOo3cP84fxBnR1FqoWX+KUZ/OpKcXftpErfeMbgb3bng4piJtkZVAUEWeZN7jBpfLlkIFt6l1SsrUp9XznpEKZ77xIFcI1MTYU1TWTAizg5fETeeIGWFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290174; c=relaxed/simple;
	bh=nPPGkjCBXcZy8CLRT0cJD7884CLC3WrqOg2b7ns6i9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kOVNQT1K/89KKMDOa/t0Qdx3UIYQ5rZ5nC5DUezHD2UJMxdx0Boh6vnamUkxMMm3jBTydwMijjnb0QH6RXQqPnmgEsrXy7P8ifCZ7g8QG8Msditi48Gtkyv2wpmwotkQbzZSZhdTD1UwpoOzvPrNlIoF6o0WqsYt/ZOYIOLb2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcRd4FkX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so384779b3a.3;
        Thu, 18 Jul 2024 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290172; x=1721894972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYE0kxNgpzBFZuSh3Xys8pyqkbR8GwZWtw/ulDzehsU=;
        b=LcRd4FkXad0NVTliJlBiFEiTecjfyUJmaACKw6tfnxJY50SVgBlwt5Is/+7TgXwcJE
         uUtdxHkFVu8R0CmsZOy96bnOeB62anhimVNY2bfj94gjZ/vwQwuCp1fblQKQsE9dR34t
         dUZhOo/yghByHmPOyvsVrpwxSrZK7/Cs9oePN1mi2w7zhR0d2pHzz+D2bbe7pIazO/7D
         3KitkeaPvNNpLYlPbaf0nphWGNO7oyCtx6vDBlwJoEomIZz222D6ZQONERx4zKQBxTYP
         2IhpoVIdgTrLCbMnLnWMnhNq2/2yMKEcMiazFGxMrBlC+tM4YI7T46XrFgpK+71Rp7gu
         XUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290172; x=1721894972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYE0kxNgpzBFZuSh3Xys8pyqkbR8GwZWtw/ulDzehsU=;
        b=RPz3AIb/X5vPU46++eJa19my7Fi9rFFo5pYPzOF5776inyV2pF4188L0GSRcJi3Qcc
         kBXT5n90N41Al78ealgEcyBlgzzIbcY0ffFrr+3ILKHzJl2yhM81KiBTvq8vYabYVxLT
         m3hWd+wzRmdVRrUuIRtpUIByb0kwJ7MzvbKoAzhm9RzIs13EH6ofrCUz9juZ9cgLMIzs
         fY4NpMvAD3kWTusHR7Vcza3aouG42LIaPwVfg/c+F7mbwwzfpynzhq4R6RKuHZ10x+Zs
         w+9zNof6O4ffGYqTYzoqdXMAX5dk7AXqCV3lnIvBNBN3s8pqFW7F6k0lIGhrRS4nlQB4
         WAEg==
X-Forwarded-Encrypted: i=1; AJvYcCX1f1UTkHlSG+A1keQIXd19CuIG48siy4Ai0ulnOrTEGEgjJg8ni658uoWTtjM7PR5lItWFM8ZqmWh6gCqNZ4SOUm3VlzJ4AFwWTsl5
X-Gm-Message-State: AOJu0YzQnun62hWWNyiQI3WuCSrJOIrzejEUOTTzhIpaChqdEIGOXeO6
	EHrrlp07VxZWfkbLwwhR2Qaz49OeYpErHXP6Hw2Fmgo6Kvx2eHm0
X-Google-Smtp-Source: AGHT+IHMRLmDiAcl7Pqn1GXhu0ffWS33/W08KsV0d2/sCdDvJKIsPYf63OIffpqWMfOu0JtnBzyAxw==
X-Received: by 2002:a05:6a00:2296:b0:705:b0aa:a6bf with SMTP id d2e1a72fcca58-70ce4f48c3cmr4581346b3a.2.1721290172391;
        Thu, 18 Jul 2024 01:09:32 -0700 (PDT)
Received: from localhost.localdomain ([221.158.180.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e290sm9432160b3a.5.2024.07.18.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:09:32 -0700 (PDT)
From: Seunghun Han <kkamagui@gmail.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360
Date: Thu, 18 Jul 2024 17:09:08 +0900
Message-Id: <20240718080908.8677-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Samsung Galaxy Book Pro 360 (13" 2022 NT935QDB-KC71S) with codec SSID
144d:c1a4 requires the same workaround to enable the speaker amp
as other Samsung models with the ALC298 codec.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d6b6a97600fc..c3a86a99f8c6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10398,6 +10398,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a3, "Samsung Galaxy Book Pro (NP935XDB-KC1SE)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xc1a4, "Samsung Galaxy Book Pro 360 (NT935QBD)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1a6, "Samsung Galaxy Book Pro 360 (NP930QBD)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_AMP),
-- 
2.34.1



Return-Path: <linux-kernel+bounces-264970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3993EABA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842F41F21916
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9A377105;
	Mon, 29 Jul 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A002RNVm"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D618C36
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217681; cv=none; b=iMF2HJH7mvicLk3NTxlZk4MtNqsHuJZGiqyOMIl4TKr+aQNwIbYmTGiiq5H9oHNkItXyTaJfz1N55fO05Qfzw6kyudHZkIL54Z54/d++iQCdh3u4ea3NNPesN+0/cxZh94v5L1kibwxkyoxXdff8RVEDLZ6CcdLnr2/D4n9pqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217681; c=relaxed/simple;
	bh=ujM1XJIxa/ere7mxRTXOLq9tnMVH6DzADLhZoNYsU94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OGMmSOmCl6Y2e9dSsyere1pCdI8R0D3VovQkX9QtpUJYf3kSkCRFRRcg8gyYXXrbg0FpKBoJPfrOKeuUNizAP5zOaZhsCSkokKIykZFx/RgDJiP3MdlWKK335Z26XqCHOB4hVhe64dfe4yb9eG71FiAXcruWiBKrPEVWeCe+DJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A002RNVm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efbc57456so3034293e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217678; x=1722822478; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=A002RNVm0YzvLJ9JQBmwyfhmkd/0+a1ZiIJRUyWPuuP/VVxhOmgx50YciHp+g/isIL
         49fR4xNXq7D5OswK1+ObVUiKUMJ2ORmfGawW1LkNVLUwdrfzUQSq+jEamIqLeF39ZmJd
         WkTf0t7HuKVqEyOxWQmVRwCHMAIHcizt7AKZRdZyLbGSpok205qt3/IthnteG7QXbh7c
         Urt6GFmm3eRK02nQrFxeL9J2BRwVI22LBkEEojMxGdal3megB+DK+C3HjmTTCMBYBwxX
         +ma7vVVK9X+WG604gAz8pa8X5zc+qgezDlUAp80V5RExPriEuXm3XgoswhXQvD0Ka8CH
         Gqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217678; x=1722822478;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=DwgJ+NAo71rVG1pCJ2C5DCvBhBFZVJO8XYx1PYdW37T2cUM/mTp4GpGYCSxElPnGaS
         P3r0+vO+y5i/MaUK9FuX9dhCO5OCsDoFfHXFNakf78gyDcNZefezts+Gfo1hyN724eaY
         VA4C27svCzLl8Dcvqpm8VFVualgnW3/FEOAiRkr9RU9MwXDJwiLF+Kjc4n+7tOwPN0+Y
         9tF30tBWtP0qaiZDZvjzLpocYZWj8JOPRo3ySuxjtCk7SyJdSTr/J3f4YIPexr5Vpfpy
         ZZ8N/co6AXOfWSh4HRfvbBIEV1PragFb5ny7GChoLl0zXP3qy9NvgGVc0nyt+2Yo4E6J
         eGfg==
X-Gm-Message-State: AOJu0YxGSbVtL41TgovP6ToPU+aoqkNt4iJhS5DVXkN3bG0tKEYN91dU
	H64mO/LM+NJTWBytycbQqxPtheALXtRzT1yuUtP7nK4F/QAs/wUl
X-Google-Smtp-Source: AGHT+IEVzBqqk3h+Q+ML88j7YQtqbRjU/2MEWf7kaMFlyHzEl7/UyentabOeAYROp50qc9GhPlsyIg==
X-Received: by 2002:a05:6512:3504:b0:52c:de00:9c04 with SMTP id 2adb3069b0e04-5309b2c2ac3mr4293542e87.48.1722217677979;
        Sun, 28 Jul 2024 18:47:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac63795sm448355566b.95.2024.07.28.18.47.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2024 18:47:57 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/5] memblock test: add the definition of __setup()
Date: Mon, 29 Jul 2024 01:47:22 +0000
Message-Id: <20240729014725.29839-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240729014725.29839-1-richard.weiyang@gmail.com>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce usage of __setup(), which is not defined
in memblock test.

Define it in init.h to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/memblock/linux/init.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/memblock/linux/init.h b/tools/testing/memblock/linux/init.h
index 828e0ee0bc6c..036616a25427 100644
--- a/tools/testing/memblock/linux/init.h
+++ b/tools/testing/memblock/linux/init.h
@@ -28,6 +28,9 @@ struct obs_kernel_param {
 		__aligned(__alignof__(struct obs_kernel_param)) =	\
 		{ __setup_str_##unique_id, fn, early }
 
+#define __setup(str, fn)						\
+	__setup_param(str, fn, fn, 0)
+
 #define early_param(str, fn)						\
 	__setup_param(str, fn, fn, 1)
 
-- 
2.34.1



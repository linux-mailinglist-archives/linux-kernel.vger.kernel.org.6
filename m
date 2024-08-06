Return-Path: <linux-kernel+bounces-275526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30499486DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992EF1F21F20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A418AD5E;
	Tue,  6 Aug 2024 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKchdEPi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F45263D5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906215; cv=none; b=JLqS1EJiJ68gxOTl1rkAcajpUrP2krf9ToCgGiZGTAPNyz4/NsiUVLyweLppxDIHQAtKpM+y49jMMgH/YdqSxsmChgi/XM8ojEUrCJRf5BpSXGeeDzPW0X54L7JIKLO6oKi6cWptEgiipJtz/zDc4WnqVduTz5YDUNB03f3TmCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906215; c=relaxed/simple;
	bh=ujM1XJIxa/ere7mxRTXOLq9tnMVH6DzADLhZoNYsU94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ccxL4ww5Fzwu1A70giTqt5eWX11pBzb7gM0++FNtVRrG6VDJJWej0dsWilfXW+P+eplYc1+sz788iyDyzGvLAlSG45vccMiRKFN0g3C2CIWJfgGm1O1eS/LsLJA4vg/3p3Qr0wD8tI2PxfXh7WYonL6dv4mVE3GgWoag4yEwZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKchdEPi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so54311466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722906213; x=1723511013; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=iKchdEPio0v7PKJHcP9ts4vZfxBA7kMMejzDWTW7+V9xQxt5OuIm6RLbPhYCO7T0fc
         vJbehoNySlWLeoiX3bigPma/2e/LR1sr/ypIAnf11sB4XezU76XtLo8lI1vgXkPtnED4
         +dqOR0anl/V/RbEu1UxcOX3jufQymPHRT229v/JRPIVVA3ErjmfGWQ7Cr0ego2jOCjrQ
         V+aWFIObB7ybQg4wsxwBXoMJ9ChBD4B8eTma4Jmw3lT1fQHYzkfoZYnz4cVrROrG1GIb
         Bq72YTeZ73fkIyqO9NOR9IQWE/ZXm4uce6j9jAyVoWeTScq5ORtchicAx/2MkAdFv8td
         C81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906213; x=1723511013;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbCh2qq+GqJnDj1NLZnr9Rls+DkMZwrRCOx9dR1Do1E=;
        b=CEA04tJuad+C1WNl/VGJXemPIaMDfIv19Vwq4oKcROMLwFpNi9YMaI70O2xOLVkAi/
         MkPI3tt/GYn/mJOJvU2MYCgVOAJ0Y+poEREFu4avrPQffELmcIs+23YsvHXuCTYN27ax
         vFOb42MQOgf+5M/K9/xwqi/16dHV4y56/lWU5s9I6zEIUE3bF4JqEaA7k4ywuqHIFJe5
         rLd7wlRGtMgf1ulAdPSg+7KCpdCOOYhJFdefcuWWIhkctHU4Mflvg82GK9jdl5FZ9FYv
         C0R2Ktoh5KCMgYTCEoh/k4NeUXw0rqFDP/zCORN3DcIo0cTtKbv5Ye2i3zEwyyeFF7ml
         AkGA==
X-Gm-Message-State: AOJu0Yw5/aoCPXJ0rSbF07YsKn9iSk3u3mhGCGTMYbwxkCQ1ttQIhoDL
	Z6XNwt5thDR45Dj5+2lN/yon/KOZ+FpdDFKw4t6WlX8qNnhh60M7xwK6wQ==
X-Google-Smtp-Source: AGHT+IGuTf/b4YdpgjtwBg1LhcMiQUU+y1pTk83h8KRO15nmAc7hlDjau/mLVdeNvR4tOYDUcVe/ow==
X-Received: by 2002:a17:907:25c5:b0:a7a:acae:340b with SMTP id a640c23a62f3a-a7dc628bf8fmr1196681066b.31.1722906212844;
        Mon, 05 Aug 2024 18:03:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3cbesm501271566b.5.2024.08.05.18.03.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2024 18:03:32 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 2/5] memblock test: add the definition of __setup()
Date: Tue,  6 Aug 2024 01:03:16 +0000
Message-Id: <20240806010319.29194-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240806010319.29194-1-richard.weiyang@gmail.com>
References: <20240806010319.29194-1-richard.weiyang@gmail.com>
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



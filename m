Return-Path: <linux-kernel+bounces-559773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98818A5F96C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC8619C1D87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F2E267B7C;
	Thu, 13 Mar 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViPXV73u"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA6FC08
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879075; cv=none; b=WlHsEouLAWzjJNpP5Czh3edyOMeha5S2Y+vkHx/yecPzuw2XWKqPfuBAk2GaK0YmlBKfe7DE7vIh2tKV3oa1X6GbmRaBGfPkfH7ciWzb4tgM0hT1QSkHK8orAr9sF8xWldKOVZBnmYxInR9rSix5cSKM1W40UxYY766wkg++eOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879075; c=relaxed/simple;
	bh=ThI337BEiaAux5N9KSbi4eKsLKbIdTd/AC+VMxWfUiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OlDxpvOPBg0EJcIKBzEm72/O3Mts+OAj4aayQ4j/Twqan7swZw9IR61S28Gs44rZnUNAYAkI4rMja+sV8Gau0QzgCCXvfQZ6ymEh0iuvNDjXR82ObDBgWodPzx5Ohi9gtP4ucuqmCLRNXrJvNOV1jhbb7CKgmQdq4EBOIa5kF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViPXV73u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe574976so7134855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741879072; x=1742483872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ4dyl2SSC5RxbjLxhmveA0XQcNxdh88W3Cj0X8tSVc=;
        b=ViPXV73uTrGzHhrkx54OKswHNzv2DdNXBcSCH5BEkNEtq2IXteqndGVlKhjyxZdqY+
         00JuyVWFuWCbh27SAHRM+qACBYf2vI34rJy1s+B8N71YCuAnejcM5s27jkjeLVcNrnVg
         Cro4CRuJNV4Fe0jXt9rcxJjll7+6csQT5TNOmMNA7JcELvWNczhaYYUehCgwq88oQTJ7
         MrJg0WfEGe4KWMhcIcItyhd/es4xYHEJNShI36DPnb9L4p3JY5i4tmvi9Z+FEbOBlCro
         QI97E2gUWVcqbJRS8qAnPXFlt5l2BEA1lcc1662j/LgH19RrmIh9eFswMZwSoY/6s5Ft
         vJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741879072; x=1742483872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ4dyl2SSC5RxbjLxhmveA0XQcNxdh88W3Cj0X8tSVc=;
        b=Wv6sOlCODlmKvRaE1qrHBVo2d/DjToJjQWLs47BiZu0pdlvSikik6eBeL325aWQ5iR
         +aLOwn50m5rQ0IbDIoCUmVMuY7ZWbK/ksAbp9ixhF1AdmSL7BTxNmbdd4TpwCDwmE8x2
         n5jF6as3WQoJvNH7BqHWEBgR/6cDY/TccLMqZE9dstO6uNfiKk+C+n6OsrpDGxZL9x3/
         kRIvg0WLU1W1WYmvTQb4+pM2GtxTWlyn7OTYVgq8mbKIvTMjuGJWYqAGxvPZ9CRBhmZU
         73izeiQN0/gBO+UOjTDkAH1B/Gva1kotCfzi030hAAn2AFS6K4uWAauXF+1aML93yTJQ
         tzIQ==
X-Gm-Message-State: AOJu0YyqmME8BzHUd+x36s/TzC/X4OSmz3WRngBN84OORP3fMk0acuLa
	tKlY8N6bAG1YvYAd7jyz1Sy/+UciaEHwSXkctE4UHiJoCk3DcCGlpaxUnplKRvw=
X-Gm-Gg: ASbGncv25Y9lrFYKVPxXoLb3bMyZYR6yKvHv54ptTt5nCBR9rb843wJsCn8XuTpVrRq
	TfnP5S1AkuASp4RXGQ4PkzlZd7tnl+gWoZBYuDAh3b1XipB96xU2qpHul6JoUz+dopVuon9zgv0
	3EGyyDIxwUi1PwQ/UIdpX9ItpA+hhqv/P/UMAzH9tOg+ajqEUu2Se7uv/bJYBnRx+mbBmVFSpI/
	HsXEAE8J/Dv+uD/fzXoTxlGPv6PUtW5k5HoaBi0+qdglwj3j5kPR6tTfquKkG218zx/wltagVmd
	CIhYXKjczO7c8S1CvX2idKdRaGE0J7nPruO+B4HYIBUX1x4ma/ZKDpXYjb9NaeOYxg==
X-Google-Smtp-Source: AGHT+IFd5q0FNym6quH3oLaAFjHn04wguzzW7PmbHpJIb5JYMjEO98Dpdq3kcGi48QgekGM4AKM8Pg==
X-Received: by 2002:a5d:5885:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-3926c1ce288mr13622609f8f.43.1741879072301;
        Thu, 13 Mar 2025 08:17:52 -0700 (PDT)
Received: from pop-os.fkkt.uni-lj.si ([2001:1470:ffef:fe01:9672:d80:2d1c:7196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c258bsm2364961f8f.24.2025.03.13.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:17:51 -0700 (PDT)
From: =?UTF-8?q?Ga=C5=A1per=20Nemgar?= <gasper.nemgar@gmail.com>
To: ike.pan@canonical.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1 14imh9 unknown keys
Date: Thu, 13 Mar 2025 16:17:44 +0100
Message-Id: <20250313151744.34010-1-gasper.nemgar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 30bd366d7..af124aafe 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1308,6 +1308,14 @@ static const struct key_entry ideapad_keymap[] = {
 	/* Specific to some newer models */
 	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
 	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
+	/*Star- (User Asignable Key)*/
+	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
+	/*Eye*/
+	{ KE_KEY,	0x45 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
+	/*Performance*/
+	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_SPORT } },
+	/*shift + prtsc*/
+	{ KE_KEY,	0x2d | IDEAPAD_WMI_KEY, { KEY_PROG3 } },
 
 	{ KE_END },
 };


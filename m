Return-Path: <linux-kernel+bounces-349876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67C98FC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47370283D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE8B4963C;
	Fri,  4 Oct 2024 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/NC+9yu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F992868E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728013358; cv=none; b=V4Cam3v148neVK/NtLFd70W6Hlttx5JOI70NI84SAWEcC85KMAsMs7mcq/uae6QSjxgnyZOrVyd0NfeuXwzCT6yaPc+m9ik7XDGng1TK3FgnjTGUcob+ZcJG2vM57gcV7lkH4d5b13jW0FYNLtGpu/PJO3T6fbFHt6bhQmS1ElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728013358; c=relaxed/simple;
	bh=ygoumjvvpD03rXn4lXHpRfOxm8Xc78EOLyKBD5+CPO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPPzXfC1gU+El9dOujBUUFcqcQ6099BtyH+mpsjzSUcWFupN2LwjHVPcGBFCzlYmCKpaB78qI/qtHjZxcAE4xnhGM7VCWYEjnqkzwL+TqUj43v0Ouf1cV9cYPnzP/FtxnYx+tMcJd9Tlg/FexWEi97h9MeMa+hFwHV6MiNTt81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/NC+9yu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20bc506347dso14260095ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728013356; x=1728618156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeNiT/wDOeYcpVybzPgBu3y8LHsbCtXdpl7PFgZAEyE=;
        b=W/NC+9yuodby22Hb9kxcdXK09jMui5g6s1cWke5TVZJtiSr42R+0wXIMyTq0YYek7m
         GR2OK1dqdkvApkT67ztNea6VWW5LojRg0OjyHjlBP4NzulUeYtB6dFHzNicfPk36Xf3g
         xYC25NDRxG5Jtx71f/mx+/NvmfvXuEzE0PpdVKeyCKNZKxWUAFAeTfSWZpyTM3Qrbe4i
         D43MJpCwdwHt5aq1jMtdW7x6ggVqa5zyGeV5g+dGGh9z6HOJD8gEvw7nSFNmCPH+sTw9
         97kkq9zbPsXFJMewhwDzqhqplkgxvmfhxECTtds6clKtRlkXR5n7DNxnZ6dRAtj+NIQW
         1LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728013356; x=1728618156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeNiT/wDOeYcpVybzPgBu3y8LHsbCtXdpl7PFgZAEyE=;
        b=jnhmr1tTCk+pNXDtSfg77Kyr0/LKG0tvhbbI9xNoPbtdJPRbzAIh/CtxB8icoQEtm7
         YpgYo2MhMIFPae5QLsx3WpZAokvyM+HB1rgAHckAJFw/LqJD3Gg97LCqnsLbfdUAjh0Q
         z+3xQqL7mTjXTmL/XiRhsVspv7KOsjvum5n0CwCdcgX+kF3PqlhR1Ap/B6DLOcV0C0ir
         fXEE56tWYpVS8naOBh7Y7DNQM4Esdn0cmQkqmjgmc07gs2FJIEu72WZvuxzH9qcHtrCs
         vba2s4V7RPkpMwF+1vXEy+AjExTHMU5IjsIy5csSl3HQ7M134V+hHd52qSzm9zUq0xwl
         zSAw==
X-Forwarded-Encrypted: i=1; AJvYcCW/wIkRtfwYqzF6zr3YycGMBt8Lm0LS6KGCoEdo9fKtqtt8Vz8O3urVjrHq2uKu39VPD30bARkFZ37KkmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbkHkKUPF8tEWqRyeOJMfo0rL2Wi60h1O+nBvmCAcumkko/Mam
	G/TrPWXZPBubx6MWfjBqmUSSImRjzGR0Ns8E0sgdaRQd5zNquvMB
X-Google-Smtp-Source: AGHT+IHE9Nstzd2pHqK6NJFCdFL23c5IKhAWkuys6OR9pdXaruEBosszP83PsP8ZctEqnFRLgJj+EA==
X-Received: by 2002:a17:902:e852:b0:20b:642c:223d with SMTP id d9443c01a7336-20bfdf8045amr20505725ad.11.1728013355963;
        Thu, 03 Oct 2024 20:42:35 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:b8ac:3fa:437b:85fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8ec6bsm15806365ad.158.2024.10.03.20.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 20:42:35 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 1/2] phy: usb: Fix missing elements in BCM4908 USB init array
Date: Thu,  3 Oct 2024 20:41:30 -0700
Message-ID: <20241004034131.1363813-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241004034131.1363813-1-CFSworks@gmail.com>
References: <20241004034131.1363813-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Broadcom USB PHY driver contains a lookup table
(`reg_bits_map_tables`) to resolve register bitmaps unique to certain
versions of the USB PHY as found in various Broadcom chip families. A
recent commit (see 'fixes' tag) introduced two new elements to each chip
family in this table -- except for one: BCM4908. This resulted in the
xHCI controller not being initialized correctly, causing a panic on
boot.

The next patch will update this table to use designated initializers in
order to prevent this from happening again. For now, just add back the
missing array elements to resolve the regression.

Fixes: 4536fe9640b6 ("phy: usb: suppress OC condition for 7439b2")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index 39536b6d96a9..5ebb3a616115 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -220,6 +220,8 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT][USB_CTRL_SELECTOR_COUNT] = {
 		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
 		0, /* USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK */
 		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT0_MASK */
+		0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT1_MASK */
 		0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
 		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
 		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
-- 
2.44.2



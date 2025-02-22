Return-Path: <linux-kernel+bounces-527153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F5A407ED
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58FD19C4F41
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FEB20B7F7;
	Sat, 22 Feb 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnTcM0Zg"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756020AF62
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224240; cv=none; b=j2JZSfc/YJ+WvXbzrSah+3gPYbV1XM7O5+BYbtPxaUr8XxpvJJfy6rNGZrC4Xu35wgZ1gkKTF/Cu0MHPalpcMHpR516A2+0AnobTazKyhISoX+idq2S/DBV1r2/C1NhxjNRynUoO3L8+iUYi3+CCcINiy8OXWSZ2qNRzEoZMaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224240; c=relaxed/simple;
	bh=vycBcYDrBDVOei3loymV0QktvZaM3LRUV+IoroMJxes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0fot58ULLRb1TNPNZDq64w8BJvpskqSP8oHiT16E6tIOGE1+2RsPsHrhQWWQaJfirIm+PV+L/ihC3zzgNvLwGh4kWxoaoOe/+vvP63lsnKhd/ctI45qlNDklwvDkoK6PWtclCxIYrytS1CUHTRZTgh7zYnyFEL4vHUbNQ+z0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GnTcM0Zg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de8e26f69fso496559a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224237; x=1740829037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TIM9U75umqUIBuvTyU4QEuOihhyR+UUhXilGv0cqhk=;
        b=GnTcM0Zg4gIQUbbYZANMkZl/8bB44gJ81LpKysTzbdUFJG1D+3HCLZW68BEewO7rck
         EHALkYpE2+yJu0mKZwrM3qnEeKKEjcwAjaE//mJ6IEGKT+NtRMs6QoWtPFUdMsxntj0s
         NKItQcuK5ctY6g0Jn7QdWN/BrkIFIr5ksge4Jt59d92C/35qxrrvtX5l8D2WzTXybXEy
         ozaOVqPbNS1miT1OBWeeoJwtenRJ+vVCXyPr9/dMlz4kUgoHrRBBUgzsUCg4INawDRi4
         mhJcReXRN9tD+GevBaaOTlzUC8uCdpwUsgRlRrEJxgUGBmpNqOxCv01cMQIB3GpKxT+U
         qZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224237; x=1740829037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TIM9U75umqUIBuvTyU4QEuOihhyR+UUhXilGv0cqhk=;
        b=fDiwlpTB2rWYlBodmmkmDRDXTrMsLE7ZYKlMSUL1bkeJ5OM14NIK80GjGIBxpRIFT3
         lj+FPw7IWlg+EDg+pFhwXdmHQCaTJyzpF8QTKr9nxTbsm0iTQALwXHjqp09J5lvW+3cP
         Wojw2126BX/LcRoWACR9A+BOC8YZbFuHKUAklHFwBjHQMoJH2NYUotWzrka6Sp2CG9By
         946CAU9MdVDV2IfPEy+YuXDs5Eounw01P4XJafpDG6Um0o8zsxW76RCvu+N+lLf9qz/o
         yatNzJEyjpVHijaTYYdPuz2uPrl/uMqLaT02rWTBjFmsh4cVkMpHyl9yHsWM1ejuPj3o
         A4Nw==
X-Gm-Message-State: AOJu0YxjeIMI0Jl8/cVCQUzKWRoXqjDkdxFzHneI7o30lS5T2/z8d/Yg
	yfZ2vXnGN82pBM+SjGAQ70TZApyskxA5cHFuyGBR4/PJNGeMTJczBdwtLmOCJe8=
X-Gm-Gg: ASbGncsaKXeZE0Vzc8e8US3zwSM5JABi0+e+MrfPlfCIbwlLa60nrXrrJcdNpg9Kgzh
	kpn/dje4dqaPA0b8JkvkXud8W4IBaDBQhdIGn9R67nat48kAVlrcEcKPbjzOM/bBDvV7fvLkfEP
	T6r9Nfja8DPv/lZZl8fkbcY/TkZdov3KYKEE+K1jMK+PEfBC64DPPRzySgTrpj11LZQtPARiVxq
	Fizu6MpwDkjuEorEXewHS3xTH2iJbyWB+A1aKcH0iaRvQURwugaVRS3oX2WJxdBkF7/JQDWUTbW
	csKz4GzTJZ0WaMw875+mmCBXnEZW5xdkNIqgdVAkUM3WyusK2X0ZfJVMXFm7+gcBod9x0GZx0dg
	f
X-Google-Smtp-Source: AGHT+IFXcNBp7scYJMpdtyrRaoJElrLOkHIu6Bt7e25+0sgqaHIuEsh74MKOorpZTNnliwmkTEwegA==
X-Received: by 2002:a05:6402:210e:b0:5e0:7afe:4e06 with SMTP id 4fb4d7f45d1cf-5e0b7248542mr2267379a12.10.1740224237452;
        Sat, 22 Feb 2025 03:37:17 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d369esm15011493a12.37.2025.02.22.03.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:37:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:36:21 +0100
Subject: [PATCH 5/5] mailbox: arm_mhuv2: Constify amba_id table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-mailbox-const-arm-id-v1-5-d60589215a24@linaro.org>
References: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
In-Reply-To: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vycBcYDrBDVOei3loymV0QktvZaM3LRUV+IoroMJxes=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubbdH0IVAxX/lVa5nVioFlJWqFxG8dcYvFyy9
 clhmynByl+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m23QAKCRDBN2bmhouD
 16x1D/9L+7znzwSB9tnw+emL6TBRxRIpy5qdvIxCkDbWnuU2kutSjwNXndliB/3mrBhd6+H1FF4
 BMakdLWpqzmzV2VlnOxwk4kYKUfSwUXtTsE7DjgC73S7dhPzGQybbfAOWzAGfGH1YFKZ70LHkgU
 wOKf1ckjJupaeUTGjmEvWzA7lPHkg/y8GlY8MiUD/zA6ZwlgIiHxWSf8kyHH2RIV5UBCJIv9RmO
 cjRq/iMGuAsEZ4sO0GPNzKD+5IRhTvoMdknxXio/Tu+qL/9WJT1HfJghPxd7L22twtplfPSTt1N
 vG3uBsbYUzszRtxJVG7RKWzaV2Ofo6f2z7N0uA9T+Cejk8+8zL51LN05Di/T/MF/CMykGM9fDU0
 0PZMxtfpQBhliNWj/7qWw+DPZtNRBYQflMhyXFG8z2JSUr5sO//rM3VVLDDq23uPfmszP6Ac1U0
 xYsjb9NNel+JhYBi2DCW0vI+COQMG93bVGQT9bSPXHeUNECD3dKQtX/5CpD3PdqdDdw48c707HF
 hFdVGc6oL/SIgH9bUHeDp2xPfkrG4u25NWXVEgnO2SkBOW6r6/Z1fLAyULXITh0ATgL7F8mFGIW
 UKNoLek7/kXFGjTdmz4HYuf/ptpoWgNPs//paCOo9ymLJzXWRnQYqefMDF3w64T9IVTQ3NBN+7s
 bWuo6zDdskayQmA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/arm_mhuv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index cff7c343ee082a6dcfaaf3633ee2f0e090b702e9..f035284944c05643f40ba55399a2dd34088d1e28 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -1107,7 +1107,7 @@ static void mhuv2_remove(struct amba_device *adev)
 		writel_relaxed(0x0, &mhu->send->access_request);
 }
 
-static struct amba_id mhuv2_ids[] = {
+static const struct amba_id mhuv2_ids[] = {
 	{
 		/* 2.0 */
 		.id = 0xbb0d1,

-- 
2.43.0



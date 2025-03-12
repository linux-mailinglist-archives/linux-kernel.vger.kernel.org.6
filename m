Return-Path: <linux-kernel+bounces-557373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0760A5D7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD41764AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66621231C9F;
	Wed, 12 Mar 2025 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkHTZFMo"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E52309AA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767131; cv=none; b=fqgo+iSXrEll7otGyE8SzdCHovBVi6892H7Bjh5W26vLXAIYFHNwChM5Z9hOqBJPIVF7Vld1pvrqeqiAICaADHKaqAUA3peK4akva7w5ohi5dspff6kLQ2Rz4x5tTvwesgiLu7mCZjYvZPvDQmKaGYeqpaUKPJdSoAxt8TG9tRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767131; c=relaxed/simple;
	bh=Xghgyzb17v1VyBdWTSBaW/0/LSOy6j2Z/NIFPnkqDzY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BGHkRWP/q1+G/xevXW0jOtQrW8mtVi5/CfUIggoW0p8FH0qEatJOsyaX8tBWtAkeD1wz5TDWfKf1lbsVOdwx9XgsDmsQBajbpK3g8sAF99dLOEpLXsZXmg3FVZqOmLB3zeoKIIehaJq71Nxtsps2+EaBeZkrwOE9ScRtNBNglRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkHTZFMo; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438da39bb69so44959875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741767128; x=1742371928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UrHxXz2qV11iAYgjjIuO8HMti1rpHNNZR2xqJjIYPjY=;
        b=NkHTZFMo1tIrIO4lY9Z0hwZxQqi3bea8jhgzI8BCEHTr3zQlvB3i7/UaDP+xM7QIif
         pSvCv7oZLhngxP1Lw6ys64n8Mw/VxZUYJ44pQ4QlAsfyO9wEywxQ+EDXQBQe9nQH7Z0T
         zaJM3cYta3MrfQ2+o2TBJ1R3pxoTmyGWd1+hDV00NiU7OaFv2ccZ1bk5v59IIUf0zqOR
         6srxwDK2Av+EpcVJKwPnce8VLF8wkcoerHECMNKkEwDxW41pI6comXP2564Ml1ehXHQk
         foSCX1DxjtkeyVpQWsULtJsaV7nNwecEMfoftkHwXlNXxMMtAzH921pZJc01rTxB6tKp
         BlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741767128; x=1742371928;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrHxXz2qV11iAYgjjIuO8HMti1rpHNNZR2xqJjIYPjY=;
        b=HvMcCkt93sycxmu8SZoOajX3LQXPSVnOxdVAY3/TWEPrljOMmuSRl18STofy4b7ZMU
         XALAaq78y0ITJhdMs9UdtO3w04Mv+A9AL7/lXdQlkFUM7sOMU8D80cmsW+0IuVimjx1w
         BQ2+m405uvOHbHybg8wtzOe9HGD2PD/rSJum/D2YFf3V3teqldYRdYtduZpQlJMEQl3M
         JAx2jc3K3fnsA9+uH1Pbd2er6pUV9GCbOCF8KCeIEYkmnW/JBM3XKddEsxfY4nn6jb5Q
         pdgb1aUIPGJ91Vl6miJGcTxSpfJfXRgXhR9A12jnS+auyvM2l8L+nnbOdKh6gQSy9uai
         xFQA==
X-Gm-Message-State: AOJu0Yw+ZePlJmEtBKtVFhrI9g9owcjahILiSALrdyPJJmwPBx47FhT3
	oFWNSE3QjxMutBBjvc/GBSuUD6VeGv5n0zsxUgT6zxYZO+d17bqj+XSZnRlZ9hZllRjUdwqpwOI
	VAdayh4mKmFEMZIBpC6MBJ0ZeQoKm+2T+kfDrm4GIBXX3PdnDYbXsFCozHLiF9EdrlkVnYx2gss
	pggbNWduckqpqX4yiw0YYqDz1+8a11Dg==
X-Google-Smtp-Source: AGHT+IEwjcaymHU8DejjEzmZeign3/gmnl3W6L/PX2LiHA9fDQHJ+RSSRoAAm5LkASsxa/M98+DPtHLj
X-Received: from wmsp24.prod.google.com ([2002:a05:600c:1d98:b0:43c:f517:ac4e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3791:b0:43c:ec28:d303
 with SMTP id 5b1f17b1804b1-43cec28d49fmr137054335e9.5.1741767128648; Wed, 12
 Mar 2025 01:12:08 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:12:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=ardb@kernel.org;
 h=from:subject; bh=q0+SBVmNbAi4gval7tz4wQn/Nt7OcD55iwwcTjW+eDQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf2i4xV9paj/TP8vGLn6peW0WL16WjmRJ8/+1KlS44fK3
 69betzrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOxPM/IMOuKrL+3Fb+52Y7+
 ub5nZzCpaF7k2NLc3blrwsKKqVPDtBkZbv1+VXi3WPuIm+Jtu/KZmTFKrivfzLE/mPltp1/99xt MTAA=
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312081204.521411-2-ardb+git@google.com>
Subject: [PATCH] x86/boot: Add back some padding for the CRC-32 checksum
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, hpa@zytor.com, mingo@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Even though no uses of the bzImage CRC-32 checksum are known, ensure
that the last 4 bytes of the image are unused zero bytes, so that the
checksum can be generated post-build if needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
As requested by hpa, this applies onto today's tip/x86/build

 arch/x86/boot/compressed/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 48d0b5184557..083ec6d7722a 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -48,7 +48,8 @@ SECTIONS
 		*(.data)
 		*(.data.*)
 
-		. = ALIGN(0x200);
+		/* Add 4 bytes of extra space for a CRC-32 checksum */
+		. = ALIGN(. + 4, 0x200);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



Return-Path: <linux-kernel+bounces-510242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C663A31A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47061653FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21C1DFED;
	Wed, 12 Feb 2025 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TslQGlfy"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C7FBF6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318902; cv=none; b=E30q0SG69d6CGM/ICslnX2Fe/xVyqL/HyCOCi3IDvjic5333PmqTq8GFJ/XXkAQ2I9Qj1Il2u7W6lNQN5O8roz6VlSIJEmx+/MLK3EBn2D6X1UyQ0dx4hQzMT2vmLM5uEYiH3Id5Q6Skn0mv+rgbPm+USJ17Uya+JhvUSL+7UVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318902; c=relaxed/simple;
	bh=oLYsr5K/EnOE6Ps4r/pTLeznQ2IgY4c6G0iy2zWPqsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AXW3KQ3dxLk/eANSLo8r2ip92BZywk0Ixy4o+3ZsUtptSSqkAtsv0iFiBfZV7FVLcI4b8tQXbDjYvFBNBL+Nx3k/Y9mIFXvRdulmoR3wTES5QCCzcQzUMY3CIFxsfAl4zA4onF6G47DutOJVkiKo0BEVMsB2t8Ii6+l1u6KYJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TslQGlfy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa34df4995so13318905a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739318900; x=1739923700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1XiCMBzc5zO/l6anZRBbtwTnK6rTlocvFZ6R2e8ekk=;
        b=TslQGlfyCdtaTcXqVxnV0PEfi56qHRVm8n1Nk9GA4W4vHhj4DtUVVQlejw1SvnMaV1
         5BnQqYpif3a9U5O+hoPK0UTXRyRNN/OqUsPmZLp9vWlpYofyigUvKw2Xh6LseKhXSzT4
         ZKSHfSXBiVC4IRjBwkxzdySUcg+Jjua1lMVgKo1+PrmwFjs2kDNDiQ9hVv3iRTak6G6R
         44mTPIGk4U3xydd7A1mbkhwwLluyMYwu8HLGEyT5Ca+rQhtUs82WCvYf11RVjPIQ6puk
         UoA5hp+Bid4BMX4Sh9jGwyX7q5Y3VD/gNC/KTdLuNWYlADFPjOk/KHZClJuoSUWp1yIl
         5gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318900; x=1739923700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1XiCMBzc5zO/l6anZRBbtwTnK6rTlocvFZ6R2e8ekk=;
        b=N3nLzXUpSAxxjmAWQAzEnZJVJYOQMB4l3ToljxmXWdrb/OadMlTFmqPXyCpMBmbEaU
         LAZu5xI1bJ3IDsaK6MVzaDgZHXUuuqkyDMJnguK8p2VOKEoWQtuTPim2BgF2+atLJjUm
         zqfwL69vzdVRehYmbYDJ5rMHPzyytdhZqYfLC8cvNB59jiatLowb7gjC9bZVqBNX011O
         npUufXx673Y08S6qR9wnZbWE5/u5p48Z+c4vo+t+9BLhkuhSKOTnxmlGR0DS4AePqGZv
         96ZqOAw3Ib61M3H9+3TIXYFdWVxu2dq2YQZla+z5hv9fm0iyrDWR1o2frZsJBNNDnbmu
         MAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEr0YvOMsH75yULfSfFudMvc5z3Sya/FgiVRE2uNEr7elrwDsdpgQkENhNgNZYUA3Of4LbutNS+HGRZv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywly6H2BGkpMSTHpemB2952aO51vJd0BBvamgy3eJZz1AXu3zcQ
	20s3DXpekAxEVG628RjCSgYBvBkaigtK5RQ0uaXOP+JgtMx7QvBYrJPDU8Kizk0M6MghJ7OD8W/
	kFNBuNYyYCY+BTlYstA==
X-Google-Smtp-Source: AGHT+IH4Aastc89G3lK7Kpren76shMv1ca6utCycZ+bUZsHekNg+thxZju67dX6Db0XVVQa0m/oRTqmDN+BLbf48
X-Received: from pfbit9.prod.google.com ([2002:a05:6a00:4589:b0:730:8636:67d7])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c8d:b0:730:9860:1240 with SMTP id d2e1a72fcca58-7322c39c33bmr1528792b3a.13.1739318900587;
 Tue, 11 Feb 2025 16:08:20 -0800 (PST)
Date: Wed, 12 Feb 2025 00:07:46 +0000
In-Reply-To: <20250212000747.3403836-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212000747.3403836-4-vannapurve@google.com>
Subject: [PATCH V4 3/4] x86/tdx: Emit warning if IRQs are enabled during HLT
 #VE handling
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	Vishal Annapurve <vannapurve@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events.

Emit warning and fail emulation if IRQs are enabled during HLT #VE handling
to avoid running into scenarios where IRQ wake events are lost resulting in
indefinite HLT execution times.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/coco/tdx/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ee67c1870e70..54baf93d9218 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -393,6 +393,14 @@ static int handle_halt(struct ve_info *ve)
 {
 	const bool irq_disabled = irqs_disabled();
 
+	/*
+	 * HLT with IRQs enabled is unsafe, as an IRQ that is intended to be a
+	 * wake event may be consumed before requesting HLT emulation, leaving
+	 * the vCPU blocking indefinitely.
+	 */
+	if (WARN_ONCE(!irq_disabled, "HLT emulation with IRQs enabled"))
+		return -EIO;
+
 	if (__halt(irq_disabled))
 		return -EIO;
 
-- 
2.48.1.502.g6dc24dfdaf-goog



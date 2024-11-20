Return-Path: <linux-kernel+bounces-415863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAE9D3D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2BAB2D6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620CB1C7269;
	Wed, 20 Nov 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cd7sfR+k"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107351B6541
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111789; cv=none; b=ewIC+c6krqHac7gzXmcciUyKs6fPcoMglBvOnGRRfA0Sqcw5574p6vIcagRB0zhYqlZ5igHh2PN+j3hFVdNZFxSWOig85fBKVdwqkZqSBO2hmFSL+v5eCcL/dkXUNnITCk/GNT1xWf76z7u1BAlowWM+881HSvdwoQ/A9F5vxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111789; c=relaxed/simple;
	bh=G4f8dg0A+liIdlqDQ5PGVlbXce8P3mr8X0xg0tMM1ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qO6hfRok5YXVxcm2t8RW2Mw5FfVfDI7OFbVWMgMfx7iTfVTTWlSduE9Pzz9lrZh2BRq+UCU+oETB0D+v4F9U21+rzGuoX010V7rM9G6CL+QfUDKgs/Edi+jkc+SvteJ72hIQzVjDLT0XaLC26b3EvzPIt9c80iemYcxqIDGwV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cd7sfR+k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211fd6a0a9cso18998245ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1732111787; x=1732716587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlIs8ciSuCEurat2M6T5aQe/KW2jWkSeCjmg9uXPSa0=;
        b=cd7sfR+kIPJc5DJpKoR8guCdM6q4TTy6DonvW8d9LukT+Kzr8gJz9lBS9RgDU70xL0
         nCpGrV/7nx6eQquocsXWsCUR4HkY0qNuVirqy0nstW/9kRi2s0RyMRPvpicZhK4iwTLI
         pxjahehG1xzXMx9HLDeqCwwSa6lNgKQkrE/q6pExd7XW2t3RcQiGiG9jN8bzgteE+uLO
         S0tMwxK+HyXbJWILZpvvJCboyu60XDScsAJR1xdPUkBuNs8Thw5SxOx6sb97MWrYXuAG
         JP8HsJTi2metLbk7exk/ofeS/JZ22oKK0+1KoWzN5fZ/qTONzQzhoE6zBNLPgkduozWt
         L3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732111787; x=1732716587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlIs8ciSuCEurat2M6T5aQe/KW2jWkSeCjmg9uXPSa0=;
        b=LopfDoKMSRch5PsS3Il+ebT9GPl10Ks7spVqOLgfy/8j78uPeKY71uQqbcnNsj6/sN
         mlVVLZamTj5uaQXicsPkxgCky4UeLM5u8zqLuMXpjSmbrLb/bnaJZDq/Xek8QpN1LR9+
         FvSBl81p/1J08GVK9wE6DcsPE5vVy4G/x808sAxZBDlO7OjpNfvwPJoPsnLZSqJfcsvI
         rarCK+x4dyBR3zVmTmxpwDhioc6VcekArooPG+8kXBMOFnNmhPSl8Xr9hR77xMGKEYDw
         UwJPMIYabnbK5PraiJ9kJcCfNrEslRrRqvt2XtfRGQv72nGhOMAjek7N5WX/AhzMTUh3
         P/hg==
X-Forwarded-Encrypted: i=1; AJvYcCVWjuPi9BWHY18FHJCu2LItcMwH18CKuTWQpIdEedBTvYNAU+954VlDvzUM1qFdQlfqo8gcPaip7e8GcCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpWdvSIn+pnZAIDzm4wh00cXWVejMJedXmRp4frto2Oo42Dg6
	PYhwHsIQbTSdyEMEVNH9wc3FNwlH0v/FV510PdmFeL30Fqhis+yqDS67xEFl3S4REbE04RLWjul
	r/EutNg==
X-Gm-Gg: ASbGnctS+UkTfTtMIjbaJcvMb2GbYxJCR5lUpm3WmhGPeilauaN5+5qQi4bUQh+JQQm
	wp79UOhirLTRAdBgXxsoiVA7uJQ37Nh2zSQCB8saGLSfPGD9UUD3ihnygkjGdNU3/YOkFJe5iGO
	uf+J0U8603pOcqD1MaFJ5oWG5tVNZolyvbcOY8ZvyVnikTL9DmG5zmqxI8MAgF+/oc4zT/dB/ge
	J+rgHPpTQdJdL86q4hr4JF+aYl0FALY5q/SKQs9z+S2bRr4kJvTvTo7JOKQZhUDaQK6R9BZwScf
	boWZMg==
X-Google-Smtp-Source: AGHT+IFrtEPOuxYYxZ/A2XZltJcWpegyv2Dbfy8kT3MJUJFj7OhNvu/6CxPQYQZcLvYMlhhsU3kN5g==
X-Received: by 2002:a17:902:f549:b0:212:deb:71e8 with SMTP id d9443c01a7336-2126a372c24mr30209125ad.2.1732111787242;
        Wed, 20 Nov 2024 06:09:47 -0800 (PST)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f474fcsm92502505ad.213.2024.11.20.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:09:46 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Wed, 20 Nov 2024 22:09:32 +0800
Subject: [PATCH RFC v3 1/3] dt-bindings: riscv: Add Svukte entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-dev-maxh-svukte-v3-v3-1-1e533d41ae15@sifive.com>
References: <20241120-dev-maxh-svukte-v3-v3-0-1e533d41ae15@sifive.com>
In-Reply-To: <20241120-dev-maxh-svukte-v3-v3-0-1e533d41ae15@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 Max Hsu <max.hsu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=G4f8dg0A+liIdlqDQ5PGVlbXce8P3mr8X0xg0tMM1ms=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBnPe2k4LuiDqPUonIF/e/ODWE2vS7bEQWO/KzSL
 gPzEPspzxiJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCZz3tpAAKCRDSA/2dB3lA
 vQbzC/9AwP3Nmt74myupKpFJKZXM2QnkuxXGfXcitojEe/gMao05/SkOAHIsf3yJj3RhoV0WzvR
 FiV5XbmZ+jumctRNOxQGgnrBoQV8SpcEOjGN/XKYE1k4eP6d1jtU4WOskADAWK5VSeqDLp+VYYI
 YrcM7vbZ2iimjRdPfPsoasi4+OaiXAaz0eIaM3CHawJR4neDhyVpOzZwBD7IETt90VeEkzrVP4K
 3ltoTNi7EZ+udq7q7ndYCxi/MXYKCvimTV3M39pHneUSPY2cyxtlJu+n9EWZJYL84J9yZtGPlYG
 m2tZd0oX6xwiv1Uh5Z9tqs4UWN35Y8LutJjkKG7vm1Bg9H967btc6VGXZUki6zBLKR5bW16GxZo
 ktGe6dTU9hn2GEOtZjuRD8CmLsTFWW2tMjULAX4WL6++j6B2UgjhxMQ2/2Tjbstu89shjOa0XVf
 b5G5ilXCiSxfoO+EIIhInJ34nsUQzIaicdyBt0mzyfUlH1UiV+E2MVjn0TY15eiqGYZCI=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD

Add an entry for the Svukte extension to the riscv,isa-extensions
property.

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index af7e5237b2c03085611daad9e1e39aa93cc8ae95..bf177274b5c6f4cd1c842b4221ca5bbfc2960a0a 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -189,6 +189,15 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: svukte
+          description:
+            The standard Svukte supervisor-level extension for making user-mode
+            accesses to supervisor memory raise page faults in constant time,
+            mitigating attacks that attempt to discover the supervisor
+            software's address-space layout. Currently under review as Pull
+            Request number 1564 at commit 81dc9277 ("Svukte v0.3") of
+            riscv-isa-manual.
+
         - const: svvptc
           description:
             The standard Svvptc supervisor-level extension for

-- 
2.43.2



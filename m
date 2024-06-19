Return-Path: <linux-kernel+bounces-220950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC790E990
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACB2281268
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5F13E04B;
	Wed, 19 Jun 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="u2PEiiON"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE913DB92
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796939; cv=none; b=RDTwCmjbni4L68dnqk8GjP2bEiC1UWOxL8NtUB9hG4cIH7crkINV39No4DPiuQ/PVN6uA2s/+99DK1NO6v4kRH9A7rdhbUeLr5Ec4VJVqB+T8F91IVP58cdPhIAS8Iq+5dE1E37SYmJditskPU8HzIOB7Zz1EEWzp/nsDo6LrhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796939; c=relaxed/simple;
	bh=/pPeKAKHhM5dioXaKdW0+1A0gvhpNEvKq5S12HlRxII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvXzBZQxpcUoGpFLD+7myBZwFMzKTlyZTZZS4+qoptiCdBuCX8Ih4nyhcXReTQ8AdCdBkvuZwkB0ec1MJeIR9l0rhAM5/s/GRXBYz26JNdU2IwvIbcvKXXX2UCUT1IAPR1BfIA6YuiDQATXFUfjjuWlVd4LdBiPDaRFA2A+xwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=u2PEiiON; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eae70fb324so7080881fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718796936; x=1719401736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0PmMBKub5I32kw3OQ7yKpgs2VnUnUQFxbp3Wubvvb8=;
        b=u2PEiiON1zgiurpdfxaf4OswkXZ+PMZfbMryGz94S+ZhT3B5Bf3ftzJugcD3uSZ+bt
         wnGzaf6ekL34WXAaOHeFdnSrbH8cBOVf2dpccTrsPc8iDpi/J8BupYdmRXoQ1OCbqjgZ
         XxlqS5jM6f6/DbphT8ttubV5zv1/QEgQQ2R46lJhEDf8t95X91wErUNVXy6hrN75dPyL
         CNRhEmgLJgShqMa+jPRvv9yaKKXldQf+HKzG2Xz9NCWlPsIX8x8ZmhzrNWznNuceKuCL
         w2bznsArys1UhwUtT/TpPz8M/uFQTteVDg9yA3MrqBDHZg3VRUAlsBsmyHWrys5XpFKL
         EFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796936; x=1719401736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0PmMBKub5I32kw3OQ7yKpgs2VnUnUQFxbp3Wubvvb8=;
        b=WBdMILW0V9BMKFybaxHhGJPBY55vgCG1nNBlxx5vgu4F7+wnobglYH/N81V7HYWYHJ
         nP//0Qb3fDq6gXrEhuCdv6Zc3Xa3S3o0B42gzdSsMCPKl5y2pMuyGOqiyUfGqMohcuJF
         ALUK7Zo08rA7qkfzPbQOHflKZxr/2STknHa/kSCT5IsGxHivT7n/Mg3usFYsQzFBjLX+
         EMhmpMz5uoYBoeM4E4LUeo2wdggeW2Dq9E6Xc3KMg7vkQ532qbh+WAL4FIpCrCSTo13h
         ctxVMz8OsNoXGfn8LzMfXrY9YgG2h+gM77MGM45Y1I7K7YhU2wqdd6Jfp5r8UvQMjTDN
         LuOw==
X-Forwarded-Encrypted: i=1; AJvYcCV45Q/JihgNRU0qWu5rZ2KPSptr9lmdUKerem5gCQjZ5OdWSL+mjQSbfPBPBXrIjp9wNNJn1WTlGDRTquXlCrO7XgMnqmxqVD2AAJ8e
X-Gm-Message-State: AOJu0YyfF2J+4RvDJYWEPwgdT0JA0qs2OQO1soUEF2gBVhhLKFGz8OEK
	l9MlH0BvOqzrjhxwTlVZPFPswhxGLpCov/mLFUqknah949MiL9QWGfQoh3MQEKI=
X-Google-Smtp-Source: AGHT+IFuiQe12ySMx1uVFaLMWupgr3h/vsw4XsgpQWD0r4gVFKJnVvYpOMaUKCr84w7Jsgw+DR3BMw==
X-Received: by 2002:a2e:a553:0:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ec3cfe8333mr18233921fa.4.1718796936025;
        Wed, 19 Jun 2024 04:35:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:e67b:7ea9:5658:701a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9681sm266192075e9.28.2024.06.19.04.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:35:35 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 01/16] dt-bindings: riscv: add Zimop ISA extension description
Date: Wed, 19 Jun 2024 13:35:11 +0200
Message-ID: <20240619113529.676940-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619113529.676940-1-cleger@rivosinc.com>
References: <20240619113529.676940-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description for the Zimop (May-Be-Operations) ISA extension which
was ratified in commit 58220614a5f of the riscv-isa-manual.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index cfed80ad5540..e214679ab6da 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -363,6 +363,11 @@ properties:
             ratified in the 20191213 version of the unprivileged ISA
             specification.
 
+        - const: zimop
+          description:
+            The standard Zimop extension version 1.0, as ratified in commit
+            58220614a5f ("Zimop is ratified/1.0") of the riscv-isa-manual.
+
         - const: ztso
           description:
             The standard Ztso extension for total store ordering, as ratified
-- 
2.45.2



Return-Path: <linux-kernel+bounces-399238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9DB9BFC63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570A81F220A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB412C470;
	Thu,  7 Nov 2024 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSLMN9Rk"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE06F80C02;
	Thu,  7 Nov 2024 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945370; cv=none; b=PkFhsY6rHa+RwhEu5u7W28MBYCwJJzzTmZSHghHUNNumnTrorKKTpMCWe2SlaiPJEorztL4X5oiJdf6RtYtrf8isrPeLKuVnUhgED8AZgRO/y6UngcUAHWgy0hZjA6ibjIu3A8/wdC2AhrAcKnqMBaWYetSolsCgo2/RBFfm60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945370; c=relaxed/simple;
	bh=THALx6/SA7vgMB0fNthGERaMX3KtQjTrr06oy67fAKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2+bPnzYdn3/qsNn+Rcr7DqJf+ubWBTFfSYE66F1mkU9ZyGuxHLLgvLvxohBLGYFQlsxOch4+GngBvUslalT1SJEyQ+Vsg09F6hXTwUn1zM/8WL7LPplsg9SxFz8tW9FlY5MYb2VmmpTFL0ReMHWvIPTnjNz1WCKqdbtYPeSm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSLMN9Rk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso356178a12.0;
        Wed, 06 Nov 2024 18:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945368; x=1731550168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJCHg6qrJs7dLJIvcvqQ/vPlMx9LG52SK0oqQpnSpq8=;
        b=lSLMN9RkU1IPej1lxYN8vE54EE6Fxduruxqe/0CiGL+AvowIG0p5FALMPHx3OAcKZM
         o3o4utAbPFZWWH77gpVky45enNqvq5Ixh0Ole07z62N6BRsctrEBhucTMlivVKsEiekj
         jjkVWnWLtp704L7fimH4D7WEN4X0cdfVWbiYYvkm6iJ01bD/UF87lUo4mYLB6qIwciTN
         ENa1SNiHlOYlb4euMt3yBAv/nvvkDzXzPAmiNpOSqwqu8UHWfZE26jmfIhJ/1DMyIfus
         gM8XWrrstpLcnpdaEjEJckWxrTVKZRdkCDMk+9XX7S5N4Jy2EvQJH1SI0IDFbwa0d05/
         CRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945368; x=1731550168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJCHg6qrJs7dLJIvcvqQ/vPlMx9LG52SK0oqQpnSpq8=;
        b=WsmicePS91v7BOYza0Bzg565UVMipFmddECz8HNlWWZ/xhnmIFmE0rzibDX4otGknl
         NWR5ujnbHmjC2wdhMQ+zVEZKq1kXbjhtbUFdHV6Rn8/LwQKZ8fiIAd2adYtbROr/oQsL
         mhrHcnsuA6jf/4jhyh5WbXNWh2Xk6kWA7Gkq996pRzcUgHbZZJ5YXBkugWWd3bi40UHr
         yYvVIyFAZa1OVRCoxJMKf/m48JMIyo3kwa4G46BRqo6IxnpEz/LEvPG+izB/Udbf15Hu
         3tV+qskwBwyauEMZD26BHIir4UvrPF03ZZ/mWXjW+l+qvHd18kBq/gey8VLV0JrcxkmE
         NgXw==
X-Forwarded-Encrypted: i=1; AJvYcCVZIQjUgVjRW2Vea3PKeB2+hClZ++4A/wF6WGfKN1tRZyHQjD15ltC8h/HAO5Ju39UZ4RDvrFCvTa+2zpm9JMU=@vger.kernel.org, AJvYcCX4bG7HQk57XrnWmq7b0u/oux/cc/iBPuDPqC1BNBIpSfu8nsSiXwUzyViTxPfnhgAOfn9ZiFMdoApsCUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznh01RzCE8lvc3u/CrTgl5UsdABVQ2cyrRzK7H4S6c/SZzSUbS
	acLWAi1faA5e7y9W0I4zm4MV7dYcnUlaOHv15thKuld9EfE8M15D
X-Google-Smtp-Source: AGHT+IFLMcVJEIOuBfmHaFdH/TIIaN0pvetOd7shLa7fFrSkeovH2ekptGpT+dQ0JOMrwKIuXLm0nA==
X-Received: by 2002:a17:90b:3c49:b0:2e2:ad11:bd36 with SMTP id 98e67ed59e1d1-2e9a766ad83mr239868a91.37.1730945367978;
        Wed, 06 Nov 2024 18:09:27 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	me@kloenk.dev,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: alistair23@gmail.com
Subject: [PATCH 09/13] rust: helpers: Remove some refcount helpers
Date: Thu,  7 Nov 2024 12:08:27 +1000
Message-ID: <20241107020831.1561063-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107020831.1561063-1-alistair.francis@wdc.com>
References: <20241107020831.1561063-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions |  3 +++
 rust/helpers/refcount.c       | 10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index e464dc1f56820..9c40a867a64de 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -15,3 +15,6 @@
 --allowlist-function kmap_local_page
 
 --allowlist-function rb_link_node
+
+--allowlist-function refcount_inc
+--allowlist-function refcount_dec_and_test
diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index f47afc148ec36..cebdeebcfd08a 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -7,13 +7,3 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
 }
-
-void rust_helper_refcount_inc(refcount_t *r)
-{
-	refcount_inc(r);
-}
-
-bool rust_helper_refcount_dec_and_test(refcount_t *r)
-{
-	return refcount_dec_and_test(r);
-}
-- 
2.47.0



Return-Path: <linux-kernel+bounces-343458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B3989B29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ECF1C20F28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D3714E2DF;
	Mon, 30 Sep 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgCFq6lN"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3315442D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680536; cv=none; b=r9iiW4OkbIGE6ewISntN8/vGiVWJEfnM6CFMtSgQzk0JgtP6n+MppGAQX1KwcJhbU3gC33j1XoCwMTz+F5YCYfAmjNat/8/pQQ4IXVoK33jMBYCSE+rojmBwKyVmKRhHmJqSXJ3oevP7fnfSl6aBt1LuBAYXiMNt9e62iD3tOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680536; c=relaxed/simple;
	bh=McqxNGvWHOX4N3k/bY0DDkzLy/YxFHb12NUUhv4svE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GWdWxDHqKAtGg+RYUhRQWofoC902+AFHysLdfOuqMoLCeb1Y3d0jXRNNTbbkpIpW9t04tySvnLMBf6nCYrqQ4S5IuuYLMEVD9QCEQvezglxo54OsMFJR/oVw6FJL2WH5V+H8S34aMCu1+fYhX7gAN4pKhE1B9I5l0FO5PZXdypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgCFq6lN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37cd282fb39so1763996f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727680533; x=1728285333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih9d+rTLUr2iQKQ8WDSsNfedIcM8p6qAJVAZ/ooKdqM=;
        b=wgCFq6lNloc+7o87evcHlIuK1Tji2/u2y2PLzTdHtbHJfUvPd8QF5gFluD08F7T5BU
         GjBURt4rD6GEjNvMEzg+Jz98fsLB3JUF2/S4Xf806oNHWq548C5ljdmgWdIjcDzySN42
         4FjU5GhY4la01gZdIe6PRPoGsHfD825VSgdA2cFWZov9yQ7cxnTCvgPrgcr7I5B1xlhO
         dOAFxb/tjGeSysosbKY45pwtpIuI7L2sfhpdIr3KIPJyZAtLqoNx07c4LuB8yf7tz0vd
         O2hMTD5Ln5uo5wkvHORytlC/JEw6VHEBWhK/wwcFgq7eDNJGphzivpGaGeN57mhruNKe
         QwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680533; x=1728285333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ih9d+rTLUr2iQKQ8WDSsNfedIcM8p6qAJVAZ/ooKdqM=;
        b=f97Rr0isqs31yAdhieqKjekqxw74EMFGa35Xov4RPui8xI09dAzj/+FiXyQNRttZse
         TSthlmyWr04paioyOjllvlNJjdVX/5Xa/O+ohUm8cSf2uKbqjYFu8WGi2uYqNqB874WP
         1t8DVO3geIn52NTPHpkbBjaTWEBo51OzqTKrsU7zsJ4urkWjqhE/L3R8O9yresznA9CI
         aThKCgHsICFj4eMnLzejUsqa2FwaCYzlCuEDprx8QRrK3nFNYdtpkzeYu2cHynbkxGkX
         HzdiDK7Ev3dcGgEc4/eXslkQ6n8BiMr2PnxJkhDRWneXIWZggf3MfJsLMc5Bl5c8iLTN
         zNrA==
X-Gm-Message-State: AOJu0YwNQclQCvWbZ17Z+NQsZq54mB6+keGY2bupQH4JybXlyOUsVJ6z
	1/YqYX35eY6bTqXznYAP99ZJeEtjHg566FosFYuHZb6d6grkXUfvr9QFs+BS5JgvHrrWmWQeU9q
	uRKYGrXArePonYs7rpp6Qc08cScHLwrOJhfushpjZWeHbKvmhfFzg8Jfe3OGr2hCWo4wJ4tIUrW
	GHj6QkF9inMgUaYI2c+XQ6/Dz+eiYBTg==
X-Google-Smtp-Source: AGHT+IGgyhRnUwbTAj2kGZmw/vLPY3l1QpRNk0KAuY9a6bXPJX2/eiNIm+l7VxrERelrDYte7R+7XXJS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:adf:cd90:0:b0:37c:d569:467c with SMTP id
 ffacd0b85a97d-37cd5b1de24mr6223f8f.9.1727680532382; Mon, 30 Sep 2024 00:15:32
 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:15:17 +0200
In-Reply-To: <20240930071513.909462-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240930071513.909462-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=ardb@kernel.org;
 h=from:subject; bh=EGjxvAOcfFb2eior18qrLfn0YVRiZmxOws+RVk4EJNQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe1XAFs4e+aKv7/bb1hbz/Ja+/n4Jcvni89UOJWapK5ee
 6Zrb8rxjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRU1sZ/vC0mHzPPSZTfPbz
 upN7a2oM50gu7Fx0f6rGJ8bu9o/y15QZGXbybPrXdTs3WODNymtrszU/y8/kq363O9D9ZvHiwpW iOqwA
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930071513.909462-10-ardb+git@google.com>
Subject: [PATCH v2 3/5] x86/pvh: Omit needless clearing of phys_base
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Since commit

  d9ec1158056b ("x86/boot/64: Use RIP_REL_REF() to assign 'phys_base'")

phys_base is assigned directly rather than added to, so it is no longer
necessary to clear it after use.

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 5a196fb3ebd8..7ca51a4da217 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -180,13 +180,6 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	ANNOTATE_RETPOLINE_SAFE
 	call *%rax
 
-	/*
-	 * Clear phys_base.  __startup_64 will *add* to its value,
-	 * so reset to 0.
-	 */
-	xor  %rbx, %rbx
-	movq %rbx, phys_base(%rip)
-
 	/* startup_64 expects boot_params in %rsi. */
 	lea pvh_bootparams(%rip), %rsi
 	jmp startup_64
-- 
2.46.1.824.gd892dcdcdd-goog



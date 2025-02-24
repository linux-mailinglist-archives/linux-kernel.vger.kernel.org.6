Return-Path: <linux-kernel+bounces-529724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A665AA42A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C577A6B88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128D26659F;
	Mon, 24 Feb 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rseh1RhV"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E94266565
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419125; cv=none; b=UeNBI7AUPRxBuIpsU0UwMqjH2g05MhOuz7zvvwrhPPzXBsPy8Q8QaQSbP4xlyNp4gRr/yDTyejw8ASLXc/hp/L6+7KdRYrivePk1cvnaqmEDFCCmEk8OHqM2+KX7GsibyMKWRq+Ch8Fis90TFB52vpSaNo2FSNeSQd0cc60uv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419125; c=relaxed/simple;
	bh=1BOlD3CY7Q7i+Oz86sDe82UKyhlevhIg+0IIHAWWAOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEy3PQBrcZUBtPeV69uZ+tNNHtwhxZGa93kUU+ErB2Ynn8xgaMjQhG4tyADQFpwFmmtPDbkRgosFU1hkdTKf8Xs4dZ0O0gEptw5tIYVVTXORM1Y/BugV5T6/afqmBgLiukeuF+wclib+bhI/M7QQHiEjT+6cFoQi3Emu5Ocq1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rseh1RhV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f8f3bd828so10201025ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419123; x=1741023923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NedlQ833R+dfasjp2xtVkBoypa1M9tQutc1AiNG511A=;
        b=Rseh1RhVrbWeM2VulixoeyKqs9Qj49KooO2MR9jLWT03wzMGYNUsJUm2SoH6a5vCxY
         A6uJfT+81yL5v20/BLjyROgzUGW3SiB6pJnqpDH4gXD0UDzdkmiPcUz2eglNmAU0qfOq
         wa0Q2rbElFdCHaN7l785aOqpbiJrKkdHwzquE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419123; x=1741023923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NedlQ833R+dfasjp2xtVkBoypa1M9tQutc1AiNG511A=;
        b=VIU07dgu/T07lm702IF7ASPGYjQNjSEg4vHI/UQI1tlzSkjaIJ1ViIe3KAz2wWNaRB
         88PnsPomlYw3Z5UdYAQEGRNNn1JpKgC85Gzq8GgoTX+TM/Ml7h98W+oXtb27AfYzgB5Z
         BVsDJl5O6bcpUMtd3LWWi/XQjBiVwiepM9vFG3k2k3na/8x3DGtXAkn0IClPdlm+6h/l
         YW8PEOKTgZ+IAboYLzHA3i9XvdVUASboeYoJ3INy4JgeM741MUZmdwkHmwbX2vcf+V5Q
         vQW4f6PXrEghI9AVa7aiyzJ54Y1kDE47l7P3P1WhaQ4OFXApgAj058xwVlZrb5oV9AmX
         iKHg==
X-Gm-Message-State: AOJu0YzjwAavggU6r2jBmiCsDjigiG9tgfPpjsAhvbNB58kiGLT5YtCC
	PwAYge6PHKAjYWUtiLEijiBNsAscNxQ9OE5Mu3aZK57eXBAtuIiO4w1salt19g==
X-Gm-Gg: ASbGncse23xMCls+PAIhxy3aUODMsi3n0J0GFk7zOrE2ZasgNCfM0SAjPY2l5/lO+4F
	ZKLzvhnkK4kiGp4EHuFln8E4qG78kDXoGKHJWVA/dpwotiIEFXEJ1psVQklIUagwVcY28i7fDqn
	yR99xWI8xyQFEHWJC+FNltR74BKhukSShSiQCjBuPIybdt9cLM40rULqeG4mpkJwqqlntmb+zrk
	swhCKHdOsqit/P1FmfysDGuj1GAZJG9R9EkrZ72mJXpo6piJLYElUzNeryopQH4Eqe/ILXk+C3r
	NNWmMlYJMoZLB0QpsuMydf87JlFsHCJ6MkpobPHgSCmhx3d3uSOsoz9SGJJ9
X-Google-Smtp-Source: AGHT+IFZVTqhLnFv9AH6bcykjpAlvnpYSGZUQrdwYTW7+qFqbmLc8OL95CLeT9nCPZhlXuZDXrrHjg==
X-Received: by 2002:a17:902:d488:b0:220:e98e:4f17 with SMTP id d9443c01a7336-2219ff39595mr87888225ad.2.1740419122867;
        Mon, 24 Feb 2025 09:45:22 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb093d96sm6756326a91.40.2025.02.24.09.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:22 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
Date: Mon, 24 Feb 2025 17:45:13 +0000
Message-ID: <20250224174513.3600914-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..10147281bf2d 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,13 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, vvar,
+  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr are
+  known to relocate or unmap system mapping, therefore this config can't be
+  enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.601.g30ceb7b040-goog



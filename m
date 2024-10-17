Return-Path: <linux-kernel+bounces-369563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290FE9A1EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5166D1C212EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55831DD0E2;
	Thu, 17 Oct 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aUBdWec/"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E91DA63C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158515; cv=none; b=qzzxkeUtFL9c+P9Kug94/T5hK0bC+p9CVkbpocJh2gkltVJanxhRYgbrwS4ofYUJ6nisZj7uLDrfTBU5ZS5RWeKMPC7nPlN1GzrAaJbSnw2KkwHzTS7pK6mUFfAF4zL7jmMN2vZ9BmVrZepOQjyy/qtvrppEPs8tsaaRnc4ONh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158515; c=relaxed/simple;
	bh=qqQo/A6GgJalHO8lTKPH/NqobaJZhvja7PakqcVbblo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TC9GjT8FNJjOcdhcL82QYK9q5/WRfOiWixcblWafUaPTZJCNMWDVnwh5DrzSkUlBzIdC3fCykme7a3IIPjyH+u6gTJtElP7wD3hDbF0E+R/Qza+uO30KqLtBLwC9Oz95v2SDLZJ9x/kuRgWguce8MFRM+L+RR+hm6SDzG7n0vxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aUBdWec/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso619492a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158511; x=1729763311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfwXxKs8PIaYIos0iWI11FlNBR0N0b0qINIDJ43u9VQ=;
        b=aUBdWec/yhF9Bpd1W0tMrBCqD4U+uwzsmvwKXazQzw8kHTUyNoYEatNit4kG9YNyaj
         j4tLcmK3QxN2neVuAZFX9oDokjOtHsJvxwh1CgERTcKHr6lMiReeZgqVJaOiqVhpdRu9
         J2Oe33ZUmrVubMKVR7JS6HJLqa1NJ4ZP5tHIkjsghxh8kSjO/6ZMgu0iXJPmRwQO2qit
         Ee4bFooeRQN1OLHw+328LeUZIla28sAvbjJ64wdk9dQnk9OaKBF5NQsSw40iF4tKEIbq
         0HOw4xRTlYu2ZkIcj04NT7WRVlv5VIbxKLyC3H4vrHnqHE046fXDTWSOrJ00/gYXtgLV
         M0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158511; x=1729763311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfwXxKs8PIaYIos0iWI11FlNBR0N0b0qINIDJ43u9VQ=;
        b=b7yVOJepBBkm4YFuwheZ6uwZpiO0wQ4YVhbpyHR9NgpvDOc3cy4XaLjyvkZdYfMZEY
         l6ByU/fyj/crqOb4w282GeQ+NO6tTetF85bhU5Om3vG1oAuu4PClQbXh8iRQTcE79++q
         tbZhEX4fStbNhFtPJsp+9ProjBESwHnHeK91H/sUAKYEDXKeUM3vMSKfmm9w5Pqk7iC4
         J+tPCfeOk6PZXigQxlpybzEKdoOrw9FOr3grdu2hRAbg9+RU1mxbemyCAFW0nppkFjza
         ijndnzWunAoHnIINFt0tlD1/66kSInYzKsibR1rOiZFmb8SKmM6w/jDYaZV8liRuW0qX
         VK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk9aJM/k3jYZ/AF1kIsTEP8qOuz4L21tST8zOEFxH8bQXrKmDa3LX5g/MP/MgSNrZj7Hduh65lwD04hnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/v1uJrEvtlKTHNkiNagb5b/aO2U5lFqDusfT46MdSEyTBJcw
	0j09SW2jkXOkr13QTdvAN7Ai69bLMoAR6PacK7Vfe03NQhGn+8yhhkk7qO1MiW4=
X-Google-Smtp-Source: AGHT+IGzAl2OFA6S9xDWJuD2m0DVBLlwiMdwmaXRwCcTvTu0dK+Cc+T0fsktUtSx/wfralK9s8v26A==
X-Received: by 2002:a05:6a20:6f91:b0:1cf:3677:1c4a with SMTP id adf61e73a8af0-1d905ecb8e9mr9815945637.16.1729158511599;
        Thu, 17 Oct 2024 02:48:31 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:48:30 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 7/7] x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64
Date: Thu, 17 Oct 2024 17:47:26 +0800
Message-Id: <0f6e7fb7fb21431710f28df60738f8be98fe9dd9.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1729157502.git.zhengqi.arch@bytedance.com>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, x86 has fully supported the CONFIG_PT_RECLAIM feature, and
reclaiming PTE pages is profitable only on 64-bit systems, so select
ARCH_SUPPORTS_PT_RECLAIM if X86_64.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1ea18662942c9..69a20cb9ddd81 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -319,6 +319,7 @@ config X86
 	select FUNCTION_ALIGNMENT_4B
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
-- 
2.20.1



Return-Path: <linux-kernel+bounces-189807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7118CF521
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AF51C20BA9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8012B17C;
	Sun, 26 May 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KihD5xGs"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA17127B7A
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716746227; cv=none; b=OQMfukP6iYFhG0c+viQul3DXjHVtS4f64tqXcKY2+fUMae930oCZqFzyeZpBTf8OcOeiIGgLRLyCmMOiAXoJZ2JW/bthJzKP9u9s1iHtCpO6IzlIVqKagSA9jlaqY+Y8P6wpalKozu1JV7t4YCH8T02zU0OxZyx+7fpgJ1YOPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716746227; c=relaxed/simple;
	bh=gwrkl0x0ZYQXDs57tv+T6mmq3c+fVkN3vQ8jk1jAIGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmAc2DglCFHdZjnxeUuDak2UQRMNJ5EZXGm/LoeX+tD7oq0v+DJgCZbz6gyJyivnChD5zQKZ8aQWqz7HrO9pp3hH7shS+FSMeD3RT5fNcUPrCkQW3dmR6jdCYZr4Apl2YizRmSZfniQqlxgM0sOTbOUKYbpHdXByrkt75k+VeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KihD5xGs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a62ef52e837so31940066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716746224; x=1717351024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wdEt72NXsmqG4ZgtbWkypOIL4UtO8kSPqTnYgEIfbA=;
        b=KihD5xGsGFxOQItH2RtVfRUVzHAlF+lMkLaWFVEZsRCpDcvMYd6NZlhMfHKn++Twcv
         QwOtdefK++LHVNra4GBXw1yEcsT2rQtgzTzUu58utBx+4Hezwiv3ChP+Hsjadfy8lmRi
         92xB9+idVzYxRAkkM5ZAU6hVB9892o1/qu3227GgXw42FZV627OjPNnOShtlISz8YLL2
         28g7/He5kzZ9zbfeZT54oCj/l9RheUq/5ZDYP0c8lktL4OzetqAt7+889riiFMv2JHnF
         7nYCpCQ67pCeo6ohN84iux9EKVmNq+4xuGuJoruOcCGvsyTiWdmBwuVgU0G2dL/GwbTB
         4GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716746224; x=1717351024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wdEt72NXsmqG4ZgtbWkypOIL4UtO8kSPqTnYgEIfbA=;
        b=VFKX6wL0UpBqaiiZf22MWDdH56iRdama7VlHR7pLJYVuFRlJItAq0k+8N4u69j58nq
         mU38htuEf0zm198kcbqZR6XHiTbLMacrKRJjjcNMSKR+FI+s9tzx3lLcGhjJpbJTFL78
         rRyK/+2Xner1nCgbd4SiLqRAhxTPUXCWfrpr2G1aL0T12EV+xgOVn8A7XIoc2wSPsToV
         KFSX/hEmSRB3DxfB4dmo5dFQTsQAscEzBbA+A9nkanJ7SOj6EZrcHCnc+drA16/0Pp0p
         ORvcbctETDwtKN3pJPK+e/27e3CF+5nxozELjDg7VwUKQBNuTITYxNDk4+SBiHwggTqk
         k5OA==
X-Forwarded-Encrypted: i=1; AJvYcCUtaON3HuM4Fh6o+YBlFyt3T9eKzJL8uNhHoJT2v5aHs66E6yBo0eijPYuHsFTHEBm3qNNgNbmcQZUlliTvSNurfeHraju64b1b2msx
X-Gm-Message-State: AOJu0YzBpqbrrlNYoizx88ME2F8xFPoFbcM2t4ksOr4Yljony96PmUDW
	IlIfazDzVtXZvkNpKVKjzOzaRjT7elKedwg/4CVAKsg/1ntEoK3W
X-Google-Smtp-Source: AGHT+IFPAMK0nTnoFeh8iBe1mJjQQc3xu6NNyMU2yvsrihWDwbp+bHn8GX1qWvA2iHXNjMEjyNQuDA==
X-Received: by 2002:a17:906:d18d:b0:a59:ab57:741e with SMTP id a640c23a62f3a-a6265112305mr520494766b.76.1716746224366;
        Sun, 26 May 2024 10:57:04 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817c52sm406424866b.1.2024.05.26.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 10:57:04 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH 2/2] x86/percpu: *DO NOT MERGE* Enable named address spaces for clang
Date: Sun, 26 May 2024 19:55:53 +0200
Message-ID: <20240526175655.227798-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240526175655.227798-1-ubizjak@gmail.com>
References: <20240526175655.227798-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable named address spaces feature for clang.

However, someone from clang side should qualify the compiler
before this feature is enabled for real.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e8837116704c..08455e62f994 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2433,7 +2433,6 @@ endmenu
 
 config CC_HAS_NAMED_AS
 	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
-	depends on CC_IS_GCC
 
 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
 	def_bool CC_IS_GCC && GCC_VERSION >= 130300
-- 
2.42.0



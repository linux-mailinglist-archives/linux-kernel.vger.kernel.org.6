Return-Path: <linux-kernel+bounces-569864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B9A6A89F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF338188B905
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197D221549;
	Thu, 20 Mar 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiCiA1cR"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAD2144C9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480789; cv=none; b=Lx0LeUcXzQkF3lJEfDe+twampWxVr55psD+QwuC/fLszRXtbkd4IKKCyW+FLx9qx6HI6p6FaWZG5bLKjYL8K2LgNNOxad3xN9U+SyztDvaZ/QD9ies4jZj/siDwwOo544iDcAXq/UL3NG8Z8N/JO7F0tM3z7D4kx9+Qp/bHqMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480789; c=relaxed/simple;
	bh=XvoMtFQu/5mLGfm/YlEYZey6eEGMtp23wegCaBbXJv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhqGQz960uYRhlFIK689vjx+merc0AmGaZSLZW+Li/+7cS8ZgSecpYLQLw0j7SYTIBCGGXqcjMtdU3szAplEU6OZbnx92lBllaG4rSyRg0Ar8cUBo+4UalhyQ1097KQpc0WNpdtHESLUKv+JzAX0LF4+5WUr8DKeBUMG+8SAER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiCiA1cR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54298ec925bso1422682e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742480786; x=1743085586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvoMtFQu/5mLGfm/YlEYZey6eEGMtp23wegCaBbXJv4=;
        b=XiCiA1cR9DHJbh5dfdUIXibFQScXvhnCdwm5rtk6jnX6XeAkKdJbEUo2YkGArqkPfF
         rGCjqIEUF5c+DRwtvDaWqDuQr4OLozwkw1QWi/yIru/rV3wTr+XNqwOE9HUN5bjZD+mb
         7QEOzIF/qNjmrBKUg+Oi+mNWO01s6ZMVLiZg77lWyrDMnRmv61acsgVw1iEYFhdlWSHg
         UGiWaBZqMImKo0SW9zIw2QZZ6TJxL+5Fzpw68sEI4ZWrrxlVREMYvB8uAVG575MYh+R9
         CS/CpSkX+5yIjW1FZ634ihX9DiFnHvoSiROc1kZy96DVeurX+NJ6bSDjLKD2CItQKRrw
         pnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480786; x=1743085586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvoMtFQu/5mLGfm/YlEYZey6eEGMtp23wegCaBbXJv4=;
        b=dk6snkaHY5CJQwFuCNIfc3i/ioh528COfuI+F3LhrNS5Tj4a8Pk+ycNeF0yaU5vxDk
         6zn3kBJboOIhO6wg+LO8Np+UjCzpKxOGl7IAj4XUmAgaAFDhQXQ+Aspgv3BkYPgTUBux
         MjcZWYZ4tGeNXn2cILCf4Hd1ycJ7I7c94z3jmGhlyf8h7deRM4oBczMOuoFcKj2uVDla
         aMt2cfKOh/l0u170w6c/hYoTHnqLA5q08/Ny/hBFj/GIU0Rn0TM7JBfn0BlM3Zy1Usf/
         5v21RkXNLyIobfY8OgagV9Tf8exAIrT5hZ+kMMLq1LxJMbN6sUDQa5l58866Uo7Np1JX
         3ZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnpIPcqmHFB1yx7IHPvhRdllspSnBoLWem/ErOqkWcex+QmQBkMBD5+ho4RIe2iqxAENg2B1g6nfb/cB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwosrJrB4iwVEw6vm0o/ygGC/ErfZnMY22WfFzHDcOb5k8B/v6X
	jc6cRkqCwsDWl9/8v1iR7/WlOSuKyvvoH+b1prbuBEeHDXm+IaU1ztcksR+jQBI=
X-Gm-Gg: ASbGncvzOdyF034nbFA9iCbNO47gv6P83Z5IEcaASiuHGPQDQiN/jj8huFvU/uNjR+7
	w1bKM4gdb1qrAP87CK809erG+NLyqJELKLSExlmJrQPz4Vj+e/QweYT+CvUori5VkAMt5PyaHrH
	SWR0cQTo4wTp6kAgeCjNkn3j3uK+7Ro7gcShAN42DliUQd/XXRVPn+Q0ZQviVzo4pNIpZaJezWE
	oJWANr+lkI+9OEewMM2Qzzqd2qLZaq0E05fRwWQBKrChIsBL7dzjnCC6G3vu0OrR3bhqvHNK0gY
	DuSYeAisa6/xGmz+uoLnvsVaOzLp8GoyQmerPucbC7DrGqbiilaR5PFdUG3NxDIUVnUwQG//5gA
	9eUYT
X-Google-Smtp-Source: AGHT+IGJdiwH3GLesSTdhfruK4DZmmmGPbFFRhIvLmZNGlq+ysSxYFDz9Vi7Dj6qQxxwk7XjYXZifg==
X-Received: by 2002:a05:6512:1153:b0:545:d70:1d0e with SMTP id 2adb3069b0e04-54ad061ba69mr1646599e87.3.1742480785393;
        Thu, 20 Mar 2025 07:26:25 -0700 (PDT)
Received: from Fecusia.lan (c-92-34-223-1.bbcust.telenor.se. [92.34.223.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a9201sm2216816e87.250.2025.03.20.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:26:24 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oleg@redhat.com,
	sstabellini@kernel.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	luto@kernel.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kees@kernel.org,
	aliceryhl@google.com,
	ojeda@kernel.org,
	samitolvanen@google.com,
	masahiroy@kernel.org,
	rppt@kernel.org,
	xur@google.com,
	paulmck@kernel.org,
	arnd@arndb.de,
	mark.rutland@arm.com,
	puranjay@kernel.org,
	broonie@kernel.org,
	mbenes@suse.cz,
	sudeep.holla@arm.com,
	guohanjun@huawei.com,
	prarit@redhat.com,
	liuwei09@cestc.cn,
	Jonathan.Cameron@huawei.com,
	dwmw@amazon.co.uk,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	ptosi@google.com,
	thiago.bauermann@linaro.org,
	kevin.brodsky@arm.com,
	Dave.Martin@arm.com,
	joey.gouly@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Cc: ruanjinjie@huawei.com,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH -next v6 1/8] entry: Split generic entry into generic exception and syscall entry
Date: Thu, 20 Mar 2025 15:26:12 +0100
Message-ID: <20250320142612.396250-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213130007.1418890-2-ruanjinjie@huawei.com>
References: <20250213130007.1418890-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Currently CONFIG_GENERIC_ENTRY enables both the generic exception
> entry logic and the generic syscall entry logic, which are otherwise
> loosely coupled.
>
> Introduce separate config options for these so that archtiectures can
> select the two independently. This will make it easier for
> architectures to migrate to generic entry code.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

If the generic entry maintainer (hi Thomas) thinks this patch is
OK it would be nice to have it applied because it will also make
the ARM32 transition to generic entry easier as we can work on
exception and syscall entry each in isolation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-521661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C99A3C071
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F356C7A3318
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F51E8339;
	Wed, 19 Feb 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K05k9B8i"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DF199E80
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972937; cv=none; b=P1HXFxL3+S8t8Uc/2oXtAQN7bD1LFl++3Bj+Eo96Hf5WUWtqcObHmxHc8g05Skc89rEJaZhUq3LRwIbJs2g/K5s4SsR15xWWNAXc30PT/wPGKsC6+WFirVErTueu7yujhFWfGrVn9TpYoEOug8wLyZQKi1HXvgueqW2Dxy2yWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972937; c=relaxed/simple;
	bh=oMwaFNRSxLI6lNwV/DUx9I+Ovl1YavfQaqXHXDL8Ito=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JaYV/we169vzUaWqmc+99fX2lFEr1K99K/W5YsXTCtTUa2XdIuYFuTXvzWr6V4mVox1PiFE0B7sHYquiZE6YTqmXc7hkbtruCMJiz5a/r/Gk4fSOrloZe8bS04gfhnFWfzvQmyhrEFPl0wqmE46tFxVKf4bFTjh6GdzrALqxEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K05k9B8i; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1016515666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739972934; x=1740577734; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIzLBEimKpadUH9ewb3+li+IYyg2jvk1s+5b+2HIs6I=;
        b=K05k9B8iTkOh12rSVkvqXRnUOotxg7UNJQSehggQWBSIAj3vdaXfnpMTjCp/kkNfMp
         8MvAckYpqNdPe5XqeXpv4cyQB2Aue8lP+73+B1l8imOaQPOYTAMLJq/N6O8GiqoUHdm4
         2H0vsxef45+rKNHFaTxcmTRG9jznlYvUO6C1Pk2j6ZO0hPiyJAsPMZ+ZDK/Lpd+LwLfW
         9Val9YmZUoD9LK9ymCevSnHKDfxlUXfVHOkJqg+7j32EYgLDtw4y+Hp/xo0bBWkFcv4c
         k6+onWfNAszcJS6zsNGI1YMagPGp4yH5VlWhx+mogjHCsDSwMKfY60yOvr8vgQAiYsPa
         Hyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972934; x=1740577734;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIzLBEimKpadUH9ewb3+li+IYyg2jvk1s+5b+2HIs6I=;
        b=qAsWUR+fM+WTUAX4S4hbc+IctqjJGKUtD6SoW8m82VZSHQLoVUDBZBjVCAHFcIK9BX
         NV0iDThidZhwZxE5pyn8Nz38YzCJJPv5hvMD3zqPqjgnFelgsMFl9tBD4m6exOljtsNc
         B53oWW8OZgpvkESQ2e84Imym6Kg/DXz9WzPGi6nkhMlBSwcBRw52IJddL+NFHeoWHBhJ
         FXIJyQYlKAWKj1FUaYMJNkg6ww/gbGY4kc+Qzn4/HYAWRpww31Kkclz3605CV8NtLf1y
         vcEjYw+yW+Tfomp5DtROdVfD/Qens+6qetyi9yqtbnHMnX6/N7HmXYLVkSzocZLsvaZq
         bNHg==
X-Forwarded-Encrypted: i=1; AJvYcCUBzLzxhWdfT0aRbldwKQ/ZwY8Qe8Bi9EBogZ/RwEOqk4ySXmfLq2Fb//55fzt/q0ICxiNXF2Ty0m/lBDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4D6WmGipHbEp4iMognB6jCpDEpaAUgXq4f9iRU8NMCLzXLvE0
	D+T4zI0zINT/vwq+XkvBZ0Gg6kpoU6zi57XB69mEJh2dPGTeyqcmCFF4bp8yTGk=
X-Gm-Gg: ASbGncsgBBObdUoTQASL6pYRyrU9l9JjBnTig/VQf6uC2OuJ6S6x8JMzYiGLXg9qYJ2
	ir1ivQ6DpCq49UXmY1wqVC2aePKmViqTgwGeUi9gAwJ1zI1Q7If1+0yOB6yD26gzp4ZAOLUyJ9j
	rAENru3EAhkEEjC7x+rNWZonUn+51Im7QGJYjfdtOb85Y2zUimST+C0is19Y4WBTd7Fe3nPohUr
	paLzATb7hnW1GbxwZrW+yio6l9/rPjCXuCVmkt9qxfa9vlQ7Wh/GP3OOUxkZoKOmKtBqxqfnlQF
	P+rutm6GpRko8/W5FUpY
X-Google-Smtp-Source: AGHT+IGVvTzWtsgWQmX9AYDEGxJVEA48DTkqKoPAbaJuri2XyoyiLcFTQ9TnZOBStmbppRu4kyBHZQ==
X-Received: by 2002:a17:907:7ba4:b0:ab7:eead:57ad with SMTP id a640c23a62f3a-abb70de4097mr1690745366b.52.1739972934169;
        Wed, 19 Feb 2025 05:48:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbad297430sm437130666b.5.2025.02.19.05.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:48:53 -0800 (PST)
Date: Wed, 19 Feb 2025 16:48:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Will Deacon <will@kernel.org>,
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/module: remove unnecessary check in module_finalize()
Message-ID: <fcbb2f57-0714-4139-b441-8817365c16a1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "calls" pointer can no longer be NULL after commit ab9fea59487d
("x86/alternative: Simplify callthunk patching") was merged.  Delete
this unnecessary check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/x86/kernel/module.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index cb9d295e67cb..615f74c4bd6c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -278,10 +278,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (calls) {
 		struct callthunk_sites cs = {};
 
-		if (calls) {
-			cs.call_start = (void *)calls->sh_addr;
-			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
-		}
+		cs.call_start = (void *)calls->sh_addr;
+		cs.call_end = (void *)calls->sh_addr + calls->sh_size;
 
 		callthunks_patch_module_calls(&cs, me);
 	}
-- 
2.47.2



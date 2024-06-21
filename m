Return-Path: <linux-kernel+bounces-225016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6F912A97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7A82899CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF915B158;
	Fri, 21 Jun 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLmDAh+6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4B15B13E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984898; cv=none; b=d2t0C/0oROAgTsAgUoUxXsK5mo394PT0jaun039dOxqdvySSV+djTPPbB6V+eEtQOEmdzaSDAopXLpxuOEBIZAHwqMb59hJfpRYur8CC3PsnMEEOhBEMmr5gTqbzQ+4VCnaPAyYzheuvmhtxeFFIT6T4GC1yOm7IH9pbupHvYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984898; c=relaxed/simple;
	bh=L1YMbzOrFM8zwukjLhCpmGkaKvQnm72ZBxPdlTZBKG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oia9vaIn6K3ONVPOZT0zsHjg3d4ipZeScwE6f4V//f5hV3O1TQd3eM1wGJYVm8ta4Rmkm+zeqEGDe5of4a9meGwuqEb5lQUCld212E2CM4V4NmqdNJcga64/QDg6/KVdErHawNp7Ozakd6Sw9sIKoOhZ3nRk9sFdITDUUgZMv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLmDAh+6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421757d217aso24191065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718984895; x=1719589695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neX+8CRvvg7ksBoKfiyHEJPasCffPwQipAQb1LpEj8k=;
        b=NLmDAh+6s4wh/gi9EAB2thY3UmXxFXc+ZQOflE+U0c4B+lebrLM5ONxi16yng0sYDt
         PMZ1LKS4EOLfW8uD92vhK6QSNjTRK0R2x0uB5uh3McnAospcG+0mJEkzhFl2FTRxXoUr
         ISLHzEPGlG/IpMkPvcL6yUmBZlIMBX3ajcVSYRdo9rf+7D+zhbgBsYw8zw5e0SeI8YWM
         IAorTOMu3ZWf3FJX/kG8Y4r+81xtaIWk/yTedP7YufGMA94E4EurMmAVO+T4naEJAwu0
         QB2Zm+ut1TAWi9v5aona5vAPp/1dyCZhGEu3M7ib2gILg2umaK172hmdMHtd93x7NJXH
         8phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984895; x=1719589695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neX+8CRvvg7ksBoKfiyHEJPasCffPwQipAQb1LpEj8k=;
        b=GVSQCvjt/nCt4nvGpuhldKGy+YpywE+NrowF3lpw89Q5udA7Vcyz4xNfgj4IH9SmPI
         NuUaYUojZbctHalVGKztiWguRvFr49RQLZq2HfqWad1GE4C4iU7T3SH6AgAc3sA14dcP
         tvnFw2mGrPvPYW1z3QHXcmK5uSCrQYirhCF2EOd1KGIG2xD7Vv8wXPuWqOQpc1PfhWf2
         XVIyjHyrQuowoB/QzKVk42cW+KcbdecZ2sJr1TL9/zIexlWDtzI7uX85FJba7LzRhgrE
         XZnGK8I3FPPWJQ7HV1d20lw56sLpYemegurrAGUnrqYTRX/0zZLm9qLmRf70C31RWz0o
         5PqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4DGUuypiUKr5xlRBtVU9GJpfa3Zv55U8/yEC81rBtuSM8shOmgMjZLU07+fOM5I1R0kzD8EbJDary0lDpJm3E7jKcugDzlIcOg5Oy
X-Gm-Message-State: AOJu0YzMmzw2fzYqaCoh2ojQNfmcdx2nR79zP/kpp8hB3ZKyQhCEsq1H
	X8mOdzScryjcjwp5AnY7FhTC+4hgn33omn3C+3TPB+mGPkfpxC/SsZglGAv2/UQ=
X-Google-Smtp-Source: AGHT+IGSN9dO705LMnmE0ip2+Yv9pSi+6V9MD6uEBQZ4VmLNGrxZti+8kFojOGoTosAa0Qj/n+Dl2g==
X-Received: by 2002:a05:600c:4907:b0:420:182e:eb46 with SMTP id 5b1f17b1804b1-4247529c65amr83989235e9.38.1718984895317;
        Fri, 21 Jun 2024 08:48:15 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be9fasm71314525e9.16.2024.06.21.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:48:15 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jason Wessel <jason.wessel@windriver.com>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	John Ogness <john.ogness@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: address -Wformat-security warnings
Date: Fri, 21 Jun 2024 16:47:50 +0100
Message-ID: <171897701322.292511.3640595078155351181.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528121154.3662553-1-arnd@kernel.org>
References: <20240528121154.3662553-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 May 2024 14:11:48 +0200, Arnd Bergmann wrote:
> When -Wformat-security is not disabled, using a string pointer
> as a format causes a warning:
> 
> kernel/debug/kdb/kdb_io.c: In function 'kdb_read':
> kernel/debug/kdb/kdb_io.c:365:36: error: format not a string literal and no format arguments [-Werror=format-security]
>   365 |                         kdb_printf(kdb_prompt_str);
>       |                                    ^~~~~~~~~~~~~~
> kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
> kernel/debug/kdb/kdb_io.c:456:20: error: format not a string literal and no format arguments [-Werror=format-security]
>   456 |         kdb_printf(kdb_prompt_str);
>       |                    ^~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] kdb: address -Wformat-security warnings
      commit: 70867efacf4370b6c7cdfc7a5b11300e9ef7de64

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


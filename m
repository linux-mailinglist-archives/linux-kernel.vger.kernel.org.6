Return-Path: <linux-kernel+bounces-547859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B0A50E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BB33AAAF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D42661B3;
	Wed,  5 Mar 2025 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUUL1H7A"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7551FFC7E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213092; cv=none; b=Y4Arl4p2rUfBXw5Py4cXGx/O307W6+4ZA+29//Kw3L5m0Jtf30IUKreEty6rjPg/uytfmdJgQhlV5fnNDT/NG3p3+Ae2qxEC9Sgu3RFkKh2d8Gj64meaKRvdSSCsv2jWg800vDpjYmMceAWq8JRyfP53tvgsKBYHy/18B3yJ45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213092; c=relaxed/simple;
	bh=4cfWO8Yj6d04AnoSQtflHOyvcE27k8sYwQ1CDe3NE5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDhcVGmbA1MNzCHq6jKdttpaLtAGPiuiapcaX9X2R0roPgWmd8NWh1CS+5LSP8iCzAQoFcfYFzuyv1MUML+S/HrDZkfptH+Gx3LwvH6bAEZDRK6WE0ERushwjABv4S0kPlbLMj5VVBuswBNl3RtSOZtst72GZfoAZNhFatGN/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUUL1H7A; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390e88caa4dso3739334f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 14:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741213089; x=1741817889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOZNX3gKnQPew7txKyrctAu7JSbEQnrnprCnUb7aAJg=;
        b=QUUL1H7ANvW4HVsYMvlD6JILxRsTDbAWRGnIwslvzct/HB1O3gB1hQ6+OEUy+y3MHG
         E33tJ5thOcw7zpEGH62SKeHhOCxhSZubXTHlwaVp8LplJex28p4eAN1x5AWJZ8aZQ/Vr
         6Ou9zm65n77vzirgnGTijDcXt8K4EFOS+/IpeosRoS8xGBWrBaoGns/7S4A7XjKyzvRX
         XBeRZCZLE6Wpb+EFotRNpMmwSIgtXwcUNYvc65xXG5QxIHL2WXQOsOHnvVrqG4vhSlLC
         mBzQZzw+uLYu0OTj0SDJywfb1jY5PZagglD1lgsDFisNTM1MBJ/bHGES8VFcxpdGY7aN
         yknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741213089; x=1741817889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOZNX3gKnQPew7txKyrctAu7JSbEQnrnprCnUb7aAJg=;
        b=k2Wvo4IBYE/R0zFYARpM3ivIVH6lzFCTWxEO4NYp0WHzYoz/bbCjBuW5sSBk5QAlyx
         3M9Ll5HlE6AZ6ppB3fsiVtIycjQ57LT7YbAFJyAIKRS06qA79kBYjZr4GgNMvBpgArTv
         5hSNddvRKN6rqSut5Z/epqOkyLnWFwxbYFNdkZoWjbEm50Ov4s+98qE5VTKCA7dS8OIw
         LjlOsJMPMg+o5roE7aLLvFTj07TgZyR3dJIyCPa0ZwzVKnhLyc4JOehb2/CWnWId8ktq
         GQ2dSRWUhczUL1NGxlDpR02UofU+/Nmz7wlddh9NyxtqXgVOP6wYKpd8q21dnjqZU/kO
         yzmA==
X-Forwarded-Encrypted: i=1; AJvYcCV/xDX3zvPm7KynyyqADyKIznKqaubi+FNJasGxoGqDF7xOtfSOEVND9i5V2ABqBtw9F3OavAAUvlcRR94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHz9UbrXZH7OtQF0dI7blvYvjiwR7lfiX6gHrDB9GzwPDsYJC
	FFEeaGpOtFgpl0rOE7P+6BeNQnoauTkNVq+OA8JbVK2VWPQD/RFI
X-Gm-Gg: ASbGncsG8WEQNmYOLwQVvUWXbktD52AehRPjt8Hgs9lh5lKvEaFHd20JCKbWVSqiKat
	oxdYcKiWflmvUFYNRjILNGqxlSwInv65RJMsk66rlNc2yFw/VqQQzqeomL7Oc4dUt77DHLElkcb
	xJkNATRjT2uVowdc+BLTYvczj5k2yzMBp1XgCR5xgkrjYoXSeB/umm0ZYt497NkN5ryaCXPLU7b
	rUsJ4I8JfgDC+9vDdj7+FR6h00l6PdhjUjrU2tzxdJykzP4xJzGISGrd1728enP2HsPEVuyyftS
	fsB5+TWm4gUOJfO2JmaEPKPjfmeRHEcTwAEZmzJOPc8ZepiBkhew64idrcenEp6/a98VkcEE77R
	zKCafzFE=
X-Google-Smtp-Source: AGHT+IEr5nOoTaExHSb8p2vSF/KGydetuYekTDGZJO2SpoBVqouVUnVQTXu1uqYRvCF6pnkyFIDFEw==
X-Received: by 2002:a5d:47a5:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-3911f72f96dmr3480448f8f.5.1741213088775;
        Wed, 05 Mar 2025 14:18:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6d31sm22056501f8f.42.2025.03.05.14.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:18:07 -0800 (PST)
Date: Wed, 5 Mar 2025 22:18:06 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250305221806.7f25108f@pumpkin>
In-Reply-To: <CAFULd4YNvz2rJEJDjacCeWak-JZNUfMB5LuM+qAwn_DCcn-CUg@mail.gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
	<20f1af22-71dc-4d62-9615-03030012222e@intel.com>
	<CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
	<c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
	<CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
	<20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
	<CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
	<CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
	<CAFULd4YNvz2rJEJDjacCeWak-JZNUfMB5LuM+qAwn_DCcn-CUg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 20:47:46 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

...
> From the compiler POV, now that "lock; " prefix lost its semicolon,
> removing LOCK_PREFIX_HERE or using asm_inline would result in exactly
> the same code. The problematic 31k code size increase (1.1%) with -O2
> is inevitable either way, if we want to move forward.

Have you looked to see where that 31k comes from?
The compiler must be very near to inlining something and removing a couple
of instructions is making a big difference.
It is quite likely that some other change will have the same (or the reverse)
effect.

	David


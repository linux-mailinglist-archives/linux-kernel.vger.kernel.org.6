Return-Path: <linux-kernel+bounces-358542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B6998099
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8B3283110
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62E1E884E;
	Thu, 10 Oct 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6GGARyi"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DF1E8829
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549050; cv=none; b=OAcuGSu7qZoq2dAETZVYwP2MPCAUccHy2fCgHTfMDwdmXdCT6bhBH8IjTv6mIZw2BahT2iPFbfV9ua6fozFrbroxo4Xxwgvw33bX51fMX1plFruasePfxHzM0Ws0cXwhYM7393vGhJToj829pbhVsKkk+pdfWBSRpapCjuYeGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549050; c=relaxed/simple;
	bh=ciGEzLPrN7XbFB5cK/viPY+fgmysJA4dkt9WpJTF0yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8TBwOqox0yKjvzq6vfW/sVEOcH4IMVorGz4rFKja44E6WWxD6CWzojwCB8JrYNYqEhWxHFmbmdPymeubwnMf2kaTM8DPTwMXiOlGpQrX1KK6ZgnS+JVpZ1QO8dGFKIbX4jRG/ni/oWKCRoau47Jzte8Ysd/BQ2MjDedFeqIPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V6GGARyi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so562553a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728549047; x=1729153847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=;
        b=V6GGARyi90X+B17khH8hgRXfkBE9ec0tP9aPBognNcsNGhdlAyv2TpWda74Rrygr43
         wm/TFHucQh7st1/A3E0U/wGDw06wEopcR47DAwsyoGCllaHrH5KtzktV31CtVJ2punOw
         q/WMnORmUlcaLeudv40KSjAkX+bc+k5zSVRLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549047; x=1729153847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjRgM2erkgK9qh8AbT3u9Jz1xqlQ+SHokymxxsnkwPs=;
        b=dm7WTPZN3LWb/rDQgYsN+yJqIGYsbsiry8VgOm5/IKliGx8Xd+OZj+CmAdMUwCswKz
         MJ/GDN0cuJ6A1AUomRNoRLqiOuVmYdk9U+b/UHhJxYeqZikf8yfnO2Tcx1rDwDOApAY3
         h1fcHvkJfKXw7jUo5MWiiq0PPfGOvgV0rpt8vPtusfAYpqhHXH2JhEK+r3irfy6cZWgo
         Z4L6d512Eddt7RD8k/bYSBjYxjr2oUWbUuqB/hBs03aXdXfiqBXXxHU3buyRZ0S1rAL/
         mcoI4Uuvup/W4D/ZBttLNTGMLoktzvY51taj0kldlf07ySuOq1vfVfvMD8R5wrL7/+9h
         9d2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxBLHdJ7fPQ6AHr/TzxD8NGAHmXNAtmQMpmSTVlA6u10ISa4eZlOzQQtZvn9D/Mz9QxOr8FOAb18eJMLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8E2YPfcHaRj+I6pnxD+ut9yMLHkuxsz8fw1KFAFwE1eH3hcT
	AnSF9lvkcPmOYhj8uEu1t5JYkTeB0hVRL4EvYj2LW3IZer4FFm8yNevS0IzNBg==
X-Google-Smtp-Source: AGHT+IGiHJLVn7EEJZoiHDg1IHJwEmo5BKI2W3X+EqMqHJDA19Xi8bq+M3epyy60EICvZVegJa7iQQ==
X-Received: by 2002:a17:90a:178e:b0:2e2:cc47:ce1a with SMTP id 98e67ed59e1d1-2e2cc47ce65mr2245610a91.1.1728549047177;
        Thu, 10 Oct 2024 01:30:47 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c13a:abb0:1c8:a3c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f0a424sm730808a91.28.2024.10.10.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:30:46 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:30:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Bisected: [PATCH v5 8/8] x86/module: enable ROX caches for module
 text
Message-ID: <20241010083033.GA1279924@google.com>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-9-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009180816.83591-9-rppt@kernel.org>

On (24/10/09 21:08), Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
> text allocations.
> 

With this modprobe disappoints kmemleak

[   12.700128] kmemleak: Found object by alias at 0xffffffffa000a000
[   12.702179] CPU: 5 UID: 0 PID: 410 Comm: modprobe Tainted: G                 N 6.12.0-rc2+ #760
[   12.704656] Tainted: [N]=TEST
[   12.705526] Call Trace:
[   12.706250]  <TASK>
[   12.706888]  dump_stack_lvl+0x3e/0xdb
[   12.707961]  __find_and_get_object+0x100/0x110
[   12.709256]  kmemleak_no_scan+0x2e/0xb0
[   12.710354]  kmemleak_load_module+0xad/0xe0
[   12.711557]  load_module+0x2391/0x45a0
[   12.712507]  __se_sys_finit_module+0x4e0/0x7a0
[   12.713599]  do_syscall_64+0x54/0xf0
[   12.714477]  ? irqentry_exit_to_user_mode+0x33/0x100
[   12.715696]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.716931] RIP: 0033:0x7fc7af51f059
[   12.717816] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.722324] RSP: 002b:00007ffc1d0b0c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.724173] RAX: ffffffffffffffda RBX: 00005618a9439b20 RCX: 00007fc7af51f059
[   12.725884] RDX: 0000000000000000 RSI: 000056187aea098b RDI: 0000000000000003
[   12.727617] RBP: 0000000000000000 R08: 0000000000000060 R09: 00005618a943af60
[   12.729361] R10: 0000000000000038 R11: 0000000000000246 R12: 000056187aea098b
[   12.731101] R13: 0000000000040000 R14: 00005618a9439ac0 R15: 0000000000000000
[   12.732814]  </TASK>
[   12.733362] kmemleak: Object 0xffffffffa0000000 (size 2097152):
[   12.734800] kmemleak:   comm "modprobe", pid 410, jiffies 4294880489
[   12.736334] kmemleak:   min_count = 2
[   12.737228] kmemleak:   count = 0
[   12.738043] kmemleak:   flags = 0x5
[   12.738917] kmemleak:   checksum = 0
[   12.739783] kmemleak:   backtrace:
[   12.740606]  kmemleak_vmalloc+0x29/0xc0
[   12.741532]  kasan_alloc_module_shadow+0xbe/0xe0
[   12.742649]  execmem_vmalloc+0x116/0x220
[   12.743596]  execmem_alloc+0xfb/0x3d0
[   12.744479]  load_module+0x1e84/0x45a0
[   12.745383]  __se_sys_finit_module+0x4e0/0x7a0
[   12.746452]  do_syscall_64+0x54/0xf0
[   12.747319]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.748772] kmemleak: Not scanning unknown object at 0xffffffffa000a000
[   12.750364] CPU: 5 UID: 0 PID: 410 Comm: modprobe Tainted: G                 N 6.12.0-rc2+ #760
[   12.752441] Tainted: [N]=TEST
[   12.753165] Call Trace:
[   12.753760]  <TASK>
[   12.754279]  dump_stack_lvl+0x3e/0xdb
[   12.755165]  kmemleak_load_module+0xad/0xe0
[   12.756165]  load_module+0x2391/0x45a0
[   12.757068]  __se_sys_finit_module+0x4e0/0x7a0
[   12.758135]  do_syscall_64+0x54/0xf0
[   12.759099]  ? irqentry_exit_to_user_mode+0x33/0x100
[   12.760292]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   12.761508] RIP: 0033:0x7fc7af51f059
[   12.762372] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[   12.772361] RSP: 002b:00007ffc1d0b0c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   12.774957] RAX: ffffffffffffffda RBX: 00005618a9439b20 RCX: 00007fc7af51f059
[   12.776635] RDX: 0000000000000000 RSI: 000056187aea098b RDI: 0000000000000003
[   12.778283] RBP: 0000000000000000 R08: 0000000000000060 R09: 00005618a943af60
[   12.779949] R10: 0000000000000038 R11: 0000000000000246 R12: 000056187aea098b
[   12.781619] R13: 0000000000040000 R14: 00005618a9439ac0 R15: 0000000000000000
[   12.783319]  </TASK>


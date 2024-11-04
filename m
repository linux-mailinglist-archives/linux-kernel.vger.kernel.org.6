Return-Path: <linux-kernel+bounces-395046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647059BB7BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C69282C92
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6FE1AC43A;
	Mon,  4 Nov 2024 14:27:54 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300E25776
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730474; cv=none; b=MMKOxWGxr9xCEb8+wC/Nr7H6NinFc8AR4KIPZVBJlr4Zf3YKVJ1tAiNOfDJQriSEhXOdEFfoP1JoTtKoNZHUMeSv5uulHtoGopUeam4knKneqzGBEy7z58I25cquv+UE/r0BbI3KkTY3U3OQzZjSvkJJadzgWCxt+UOVXruYyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730474; c=relaxed/simple;
	bh=BzrJ6N3QNuHRcVk8wm/vmgY/RU26zYQ9LyG6vqWlqlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Iev9+hUoCI3XWdJIS0jkO99o7esSKMBfU12s6UDto9FxTCBJ46ixVLhWzExn+sg+peEL0zKPH73BOc9YUuWhLNgepp0QWejS24b6s7apJCqtKe/bU6OlNv06r6aAwQsGZ+n3U2YWFplOiumgovHu4Wos25hoOoa/+/Twx5JXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9acafdb745so746307366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 06:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730730471; x=1731335271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isN9Ps/gLnEyDuQpgnADyJxf1zJtoLZcMM+6E1KR1JY=;
        b=BoE71RWtkmkDu6FTq4fn6NXI2oDg/yqdoaTtRUND1i4gKHMD5ESmohXcfJ9L8/2V8q
         06a63Q6kzrlrWSzfLex/AxhwuKgaLRogp61LeZFOrKFinWux6dw7hQ/fNRTclqJG1BKT
         PZIMrGlPpD9nfCstSrEYy0ZHep3Gug8Dneym+X4vIdRR15uzEWJp/g4yahVdOSQr2Zri
         9gObHdWWh6CuRTusqxqj+k8r9BpAwDWSs67YgI50dKt557rxD+78M46WfWmKFEyiWtAA
         A1pblSAuY+afCfCdLlm5VBwlo+xyx+oI5Zki4bnpH1Kif1/ej/ieWjjgCD4nwQxiTo+q
         AGTg==
X-Forwarded-Encrypted: i=1; AJvYcCVyPYsyv8bzh7yUW7+NR3XBxV+beQ6f7dm8BgLMLJ1Ebr9pw41w7Uz2j49Hit9aJhjTW4CFSl6el9F3g60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFfNC9mn7JTDNOCo94eF2T6SsPejNUqFQI4C+MSgkk4bIaWZF
	QgVRcBXHdc5irMVWIhjG9YyU4V0MVw2CrAYM9khaARjhYUoKjeU9
X-Google-Smtp-Source: AGHT+IHORFWIN4tYcghfdXF6lQTuclCRRHh4TUUMvwA3JlRxkrLnaSTwD7zeFUNFURKiQxsS7Jx2yg==
X-Received: by 2002:a17:907:d27:b0:a9a:f19:8c47 with SMTP id a640c23a62f3a-a9e55a6fc0fmr1552692266b.13.1730730469107;
        Mon, 04 Nov 2024 06:27:49 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e9ceasm558811666b.96.2024.11.04.06.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:27:48 -0800 (PST)
Date: Mon, 4 Nov 2024 06:27:46 -0800
From: Breno Leitao <leitao@debian.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: msghandler: Suppress suspicious RCU usage warning
Message-ID: <20241104-jasper-chameleon-of-weather-59bcea@leitao>
References: <20201119070839.381-1-miaoqinglang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119070839.381-1-miaoqinglang@huawei.com>

On Thu, Nov 19, 2020 at 03:08:39PM +0800, Qinglang Miao wrote:
> while running ipmi, ipmi_smi_watcher_register() caused
> a suspicious RCU usage warning.
> 
> -----
> 
> =============================
> WARNING: suspicious RCU usage
> 5.10.0-rc3+ #1 Not tainted
> -----------------------------
> drivers/char/ipmi/ipmi_msghandler.c:750 RCU-list traversed in non-reader section!!
> other info that might help us debug this:
> rcu_scheduler_active = 2, debug_locks = 1
> 2 locks held by syz-executor.0/4254:
> stack backtrace:
> CPU: 0 PID: 4254 Comm: syz-executor.0 Not tainted 5.10.0-rc3+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/ 01/2014
> Call Trace:
> dump_stack+0x19d/0x200
> ipmi_smi_watcher_register+0x2d3/0x340 [ipmi_msghandler]
> acpi_ipmi_init+0xb1/0x1000 [acpi_ipmi]
> do_one_initcall+0x149/0x7e0
> do_init_module+0x1ef/0x700
> load_module+0x3467/0x4140
> __do_sys_finit_module+0x10d/0x1a0
> do_syscall_64+0x34/0x80
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x468ded
> 
> -----
> 
> It is safe because smi_watchers_mutex is locked and srcu_read_lock
> has been used, so simply pass lockdep_is_held() to the
> list_for_each_entry_rcu() to suppress this warning.

You probably should use list_for_each_entry_srcu() instead of the
list_for_each_entry_rcu().

This problem is still happening in 6.12-rc5.


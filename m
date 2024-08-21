Return-Path: <linux-kernel+bounces-295198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7EF959881
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1805B22F21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026761E38A1;
	Wed, 21 Aug 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QKsaJyEy"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEA1E389B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231498; cv=none; b=algaq1G7W7pu4saTyjjhtcVLok8hvblXiz6BsvyEPva1DSyAzNiQbn2Jee6eiA6zprbrsQLuNImqvCA6Zm4MXF1xpA8vKhwAjWeNu8Zc2XGRxHDqCtauRCVQynpt21Dw2zThA/xpVfNcuzZVppHOaHLz1eFbKXKZBxUnAUhGPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231498; c=relaxed/simple;
	bh=zXEV5HZjh0lMXGVGXnSuWlam1fCnkPITWd+ApK3jCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI61+1WQd0M04hMmu7h9NaJMyQhQKc76HDFMgyTyOCLcAQqZ4DYaL+JABt0wfQdLtLlFLY57y5Ybl/mtkzuV2He0RDGpNacfF+jkg9On5+PZunFw3PA6FWytillUmFypSXbt73qM+48EFCumQem4HhxE1evBn0bfE3nksD8GZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QKsaJyEy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aada2358fso88116666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724231494; x=1724836294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+sj8nzrFjGqpPl1f7mu/J3rtRAJr3MnTK6gY3AHP84=;
        b=QKsaJyEylQK8DpGpjiB252ciRSoP+jvLR2qxPClmKin3bsS1UbuC5GqEzhcW55NRzj
         iq5EntQvIR3QVaHesEZsVF0wKrq6Ee5XW3yhCB1N1yjFFoqxItOpggHROo/1hZHTK2MF
         zHozQY/9ndKzJ0UphVCGG6O7InMm8dUIOBsDuehVBUoXq8rnI6vx9XYRMgR5UY6Ny/Wr
         YS6O/IzYihFRdboqb+Xoos+EYmRxqJDDPW0zOHAheVSrG+/QBhqfkyepfCZrD3QUr79p
         gQz/CRE/hRO3uYpMv9xZBrCE0s/wGBHrQRPNXjKPM9vNwupeqxSzmoTgCPvb4ysrPOJO
         ksvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231494; x=1724836294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+sj8nzrFjGqpPl1f7mu/J3rtRAJr3MnTK6gY3AHP84=;
        b=GgLFbK99riwzO6ZnuECd2Dnlo8psuHTBSCp//J5flRYvD78avh6mj59EE7/deTS40E
         jrH66lwwasnj05kkH56+/Ro1YuhNqxDbx1NEU+WTM3UlUb1/521jDSq5CQcEG4oqwtvU
         wfU2qj3jzchB9cV4SqAwP8LMnT7jMQUsxnbBhkDnxbszHSF9M3tGMMqr+3xAbO5Y7T2x
         jfv94Do9t6VuH1zxM/Mhptmzw4F/SpZDSrwaXB4a9Td/QvxOlMTrCKKk//6ACaJjfQno
         oxKTWs0hAhvZONMPQ4+61VGtTMIa2kbbMaE/bsFtOSA6p0kfcUhSJJ8X8ku69yq2aDFg
         +yeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJmTGyH1v0gtO5zoN7OsJ9/3DzaUGAbsmYjEm+01thX/qaEn02wxfdobN8/bTiQA3/EVSyCR3Mz47eO+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI804yJTSbwNavYq12lxH4L/gLXJVlEsKCh0PtJ/TjnAquJ9dA
	twh0zorIuLVRMRl4JF6D5jHGlwLi0guVp+HlHio83Jo1+JOQNjfoBwtD9mgy8D0=
X-Google-Smtp-Source: AGHT+IHJ7Pjlh8sHaAUDmY/jSXewONWCL8yN5Cg0SHNfj8LBJ1fU5MDSDZxJTDK3uvnQr7ts0IMkNQ==
X-Received: by 2002:a17:907:9708:b0:a77:ca3b:996c with SMTP id a640c23a62f3a-a86700390cbmr142913366b.16.1724231494332;
        Wed, 21 Aug 2024 02:11:34 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cf0e3sm875146066b.54.2024.08.21.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:11:34 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:11:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v8 30/35] printk: Add helper for flush type logic
Message-ID: <ZsWvRETyuh1Yq80j@pathway.suse.cz>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <20240820063001.36405-31-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820063001.36405-31-john.ogness@linutronix.de>

On Tue 2024-08-20 08:35:56, John Ogness wrote:
> There are many call sites where console flushing occur.
> Depending on the system state and types of consoles, the flush
> methods to use are different. A flush call site generally must
> consider:
> 
> 	@have_boot_console
> 	@have_nbcon_console
> 	@have_legacy_console
> 	@legacy_allow_panic_sync
> 	is_printk_preferred()
> 
> and take into account the current CPU state:
> 
> 	NBCON_PRIO_NORMAL
> 	NBCON_PRIO_EMERGENCY
> 	NBCON_PRIO_PANIC
> 
> in order to decide if it should:
> 
> 	flush nbcon directly via atomic_write() callback
> 	flush legacy directly via console_unlock
> 	flush legacy via offload to irq_work
> 
> All of these call sites use their own logic to make this
> decision, which is complicated and error prone. Especially
> later when two more flush methods will be introduced:
> 
> 	flush nbcon via offload to kthread
> 	flush legacy via offload to kthread
> 
> Introduce a new internal struct console_flush_type that
> specifies the flush method(s) that are available for a
> particular call site to use.

The function behaves a bit different in this version of the patch.
The paragraph should be updated according the current description
of the function:

<proposal>
Introduce a new internal struct console_flush_type that specifies which
which console flushing methods should be used in the context of
the caller.
</proposal>

> Introduce a helper function to fill out console_flush_type to
> be used for flushing call sites.
> 
> Replace the logic of all flushing call sites to use the new
> helper. 

I would add:

<proposal>
This change standardizes behavior, leading to both fixes and optimizations
across various call sites. For instance, in console_cpu_notify(), the new
logic ensures that nbcon consoles are flushed when they aren’t managed
by the legacy loop. Similarly, in console_flush_on_panic(), the system
no longer needs to flush nbcon consoles if none are present.
</proposal>

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

With the above changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


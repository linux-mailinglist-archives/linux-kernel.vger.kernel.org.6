Return-Path: <linux-kernel+bounces-379491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F19ADF47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE81D1F21605
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05251B0F05;
	Thu, 24 Oct 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OxZN2Jev"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57018B46A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758901; cv=none; b=h3wx60tlK8CJTrsYvf+T92VMdXM7742++mrhz+Dqsf7hAHRk/Z+LRtBa6CSwy3naAjmvtDnnjG1JofcY15t5oITYEdort9esGHID5PwiDnX5rk4cua+DPMZccnN3J2bfbek6D0Bp9QRKPqpAmgDU3OBqRvoNCnOJV84qyEoGDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758901; c=relaxed/simple;
	bh=xJRgSKPTW//y4N0qDBNp340kpAEEE1G/wOAMoRlGLVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR46hvbcaPUX22zBcG885e1TpBxbTDoeVn8pWRHnCrqjplvG3UNcRPOc9opIBWWHqYPNrS/3W5bNyCxkerq2ogAOnhYj/Y49zPHXc62Q0sFdkKKfuHewmonJbYLij3aEAt8iOqVqvE4Yn57fxztcvKwI6382tf+61rdy6xRGkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OxZN2Jev; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314a26002bso6802765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729758897; x=1730363697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U3hnG6kUasRgo7MmwBN61ENgj7Tvm7iouRipv+d+4kU=;
        b=OxZN2Jev+BwMSxMC4KtGRW/f+d+ARUVNKvVGn3i/CXue43xVRxTk/cQmZBwrRM/xuk
         ZU1Qcz/KX0WjalXlpNkaYFP/M+p/gFX2cl/Y5ILvZH37uzQdw4jE+/tVjp67oSCA9Jq1
         pRs0O/bKjTSUMGtlNyjuR9vhoU8yMVtaM3pCALeQn3opTj8Fug4/E0osc6Y/eLZ3X4kb
         me7sS8RQoH5b/Q8aHB5Dxy3AEorKXlNpnEN757QDNtHZlF/V+HFcN/+jNQzu0XTMnpa+
         nElQr863e3lH7cFr0Sy9LOHBg/A2aki9HVIoZ+w+OSfCFpIivOLniTpv58il76fbuSto
         cv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758897; x=1730363697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3hnG6kUasRgo7MmwBN61ENgj7Tvm7iouRipv+d+4kU=;
        b=EGOTrqnXm1zbMJiLS2qDYgyIcqOGbyBQbASu6rU5U8ktZOgmP3eAWf3ImnCFVeC64/
         XygSdaXoVUIIvhwyTj0UIYL/JMAmGKJksyE4LNh6ZI+i2KZzt3Veik/TtkqE68BlO9En
         bnMhb6t66W1JJSOjsWcAXecpxttKvO/O7g0vS6z8k/Vv3oUV3CQW0uN1St459dpB7cgh
         Z9LjgNWA92DQSkV2lKGyYVLtUzE6dPW5Nfq3ILTQX4pRACII33ncvX7542tcVARmyMhi
         wm9CtlHo3TY+no8DDGgik8f4NK3A6XexNk7/U8HlpDOCj5kpC9i7/VIr1362Rc5H4E00
         3qVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFyAqg4bBU1g3h8AEbnSQr7xFY/a833qMuMB8kP/JusJXRD3qLoMlZtzkiZD9H3v1Vbx+VuBr75YENoAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQb+UQm5iaiw58jJJrtltVs7AhGIZUyXvbHM2yCtI4uGv27JJZ
	xSn3zk57kKZZRxWmSPqOQxfTLi9pvzfOTc/F7Wa5Fo3pL3hZct0sMAKgtWnEEac0vDK7sazBXtb
	s
X-Google-Smtp-Source: AGHT+IGttkM//WyojeDGYn9Lj1Z4+3EZSZteZF44Ruav/px318p2KtzUl9T9lR1Dxi6OlwDs18wvdw==
X-Received: by 2002:a05:6000:10c5:b0:37d:45f0:dd08 with SMTP id ffacd0b85a97d-3803ac846ecmr877594f8f.11.1729758896811;
        Thu, 24 Oct 2024 01:34:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94131sm10731293f8f.81.2024.10.24.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:34:56 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:34:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
Message-ID: <ZxoGriUNSepndV77@pathway.suse.cz>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
 <84plnz29zv.fsf@jogness.linutronix.de>
 <ZxDl-VcVAI8DGM40@pathway.suse.cz>
 <847ca5rigk.fsf@jogness.linutronix.de>
 <ZxZYKe0t7jWX-_1K@pathway.suse.cz>
 <8434kpfsvr.fsf@jogness.linutronix.de>
 <533f6a578d8489c1107ba83ce1e49b6e2d5c84ce.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <533f6a578d8489c1107ba83ce1e49b6e2d5c84ce.camel@suse.com>

On Wed 2024-10-23 17:36:04, Marcos Paulo de Souza wrote:
> On Mon, 2024-10-21 at 16:17 +0206, John Ogness wrote:
> > On 2024-10-21, Petr Mladek <pmladek@suse.com> wrote:
> > > > That will not work because migrate_enable() can only be called
> > > > from
> > > > can_sleep context. Instead, the migrate_disable()/enable() should
> > > > be at
> > > > the few (one?) call sites where
> > > > printk_loud_console_enter()/exit() is
> > > > used from task context.
> > > 
> > > Hmm, if I get it correctly, we could not use migrate_disable() in
> > > __handle_sysrq() because it can be called also in atomic context,
> > 
> > I am talking about callers of __handle_sysrq() and/or their callers.
> > 
> > For example write_sysrq_trigger() could do:
> > 
> > 	migrate_disable();
> > 	__handle_sysrq(c, false);
> > 	migrate_enable();
> > 
> > Or a new wrapper could be introduced for this purpose:
> > 
> > static inline void wrapper handle_sysrq_task(u8 key, bool check_mask)
> > {
> > 	migrate_disable();
> > 	__handle_sysrq(key, check_mask);
> > 	migrate_enable();
> > }
> > 
> > A quick grep shows about 25 call sites to check.
> >
> > > I do not see any easy way how to distinguish whether it was called
> > > in
> > > an atomic context or not.
> > 
> > There is no clean way to do that. If this information is needed, it
> > must
> > be tracked by the call chain.
> > 
> > > So, I see three possibilities:
> > > 
> > >   1. Explicitly call preempt_disable() in __handle_sysrq().
> > > 
> > >      It would be just around the the single line or the help. But
> > > still,
> > >      I do not like it much.
> > 
> > Not acceptable for PREEMPT_RT since sysrq is exposed to external
> > inputs.
> > 
> > >   2. Avoid the per-CPU variable. Force adding the
> > > LOUD_CON/FORCE_CON
> > >      flag using a global variable, e.g. printk_force_console.
> > > 
> > >      The problem is that it might affect also messages printed by
> > >      other CPUs. And there might be many.
> > > 
> > >      Well, console_loglevel is a global variable. The original code
> > >      had a similar problem.
> > 
> > If disabling migration is not an option for you, this would be my
> > second
> > choice. I assume tagging too many messages is better than not tagging
> > enough. And, as you say, this is effectively what the current code is
> > trying to do.
> 
> Thanks for your input John. I talked with Petr and he suggested to
> follow this option. I'll prepare the changes and send them after
> reviewing them with Petr.

Just for record. I propose this way because disabling migration would
require checking all callers (25 as mentioned above).
migrate_disable() is needed and can be called only in the task
context.

I do not think that it is worth the effort. And it would be error
prone (hard to maintain).

Best Regards,
Petr


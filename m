Return-Path: <linux-kernel+bounces-184661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A078CAA29
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A4281EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D155E53;
	Tue, 21 May 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hw1dhuy5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85592C8D7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280904; cv=none; b=M8+ALj1zEyqRZsjMboxNWA2OZbm8SKyLA4YBp8E3VS9osfXjb56qEtrgJzJ2KiltsNHOzyLDnNZfYYcO0mNSz2aob/7qFYu7f/zh2m/X2VpqwJwrr5SKT8JBuITvkhQ23mPSwEKk5zPpUZIn5s4fJA/5I94PSk2WFi5FZlyuT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280904; c=relaxed/simple;
	bh=KvTpZ4Yf8yCiZrKxLo/GSRiaO58j+Ysk+2Rz3zu0/Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNW1lujjbTT5uRH6UTDygwUu4PiloVp6tQJkqwu3bRn5lzPYujuOTSlNJ7aFiqpsataPxeQas2+HLwpYtmRKI0Gh8wkBte0nP6Xd0V519mGJnWNwEAD25AdXBEy+hmsU0NmVgFrI+PgGB3hnBTUlysNKY9GcCvDZAVaDLo1McQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hw1dhuy5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59e4136010so862612766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716280901; x=1716885701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPC6agpk5iopVfITW8oGp3F+WUrfJXa++l+A0Fj8wr4=;
        b=Hw1dhuy5EZvWkFpEvKqn6HSrBaXfVj506EMCyYcGeKQ32A1NfMnFSOlwMhApF9Tzxd
         it7pwef04wWIabU6j0WjqMhMopjBfW/HLrnqjtgqsv9IC+xFxqOSB/8x8WJGDxhVqgYg
         vlAAd8GAYLHt0PaNJQ6w9MUp5AAYeQyIDHsbnZIUjLhxSLuRZn+fgQJ7G6aI+oIpdgZN
         IkM4T4p9w0kYe2s012xKlGUJ4nF3EDsiIFnypmbvAao61KbSO8CfM3a/LMLwB2VAFKfi
         gLnJ1IDF59fQDURNbo7A3gP0td4QIyZMz0VyHxfkUGJFB8K9pgicAbPgMgn/1VK+nRur
         hLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280901; x=1716885701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPC6agpk5iopVfITW8oGp3F+WUrfJXa++l+A0Fj8wr4=;
        b=XdM1Mhi0ZhkVvaxUG8v7hFwnGs5//uLE5jKc6IbvHaaxxN/K+ZnY1u7oAXG45S+Lfk
         t4gO4fyuA6vvgT2TPL1zsxIGVVnTx/7l4dx4FelrBlDCttWo8W4jvoD0ohx/JJYGuhY0
         m9mZBs7fbGEJfvafvXvl3KOll7PJ4kw32YyrUJWrEHgGr+Mn/KXkZWel644XnyG50jwi
         vGw2g9Ql6M1ChB6lDD15khKRKREtZn4EGQQIpPMX+ZFpO4+ubYAzqU22qxpuh0P2HySI
         64tT7gOCEX8rJG0307H+QoGlh8UfLW3fxSTVIP6sk0tqxgh6GFFnOQwZl09M9JZwa5pJ
         XDew==
X-Forwarded-Encrypted: i=1; AJvYcCV5kOMlBhhquVXeFMUf3MC+sq9kKUgpQph6AdQ5spuKLR453y1To+FQ23HzBRPeRfvvgpZps0ONZqsYT33iUkBHDZUPHWIkvYilQgME
X-Gm-Message-State: AOJu0YwN4lpKRSQd79yKLOD8dDspnEm/+dtUL/BD3qY7ao640e6TSTKj
	H1jOrmeBBvwRhkSiW29n0llrxHiNXu8SW/BwHWx1RJU06T/XVS2zlg9+HDv6iPtttlPEfjrGdU6
	z
X-Google-Smtp-Source: AGHT+IF36JNnxBHTVU8/5+zPH+12sJYpzCiEUeGsgNa7L1Yxi+dZR9V1SssiYLz3GHWEC0Zs25y0ew==
X-Received: by 2002:a17:907:25c5:b0:a5a:6367:717e with SMTP id a640c23a62f3a-a5a6367bc70mr2033181366b.17.1716280900863;
        Tue, 21 May 2024 01:41:40 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d35sm1567476566b.81.2024.05.21.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:41:40 -0700 (PDT)
Date: Tue, 21 May 2024 10:41:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 21/30] printk: nbcon: Use nbcon consoles in
 console_flush_all()
Message-ID: <ZkxeQsaPcTIbkqMZ@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-22-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-22-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:30, John Ogness wrote:
> Allow nbcon consoles to print messages in the legacy printk()
> caller context (printing via unlock) by integrating them into
> console_flush_all(). The write_atomic() callback is used for
> printing.
> 
> Provide nbcon_legacy_emit_next_record(), which acts as the
> nbcon variant of console_emit_next_record(). Call this variant
> within console_flush_all() for nbcon consoles. Since nbcon
> consoles use their own @nbcon_seq variable to track the next
> record to print, this also must be appropriately handled in
> console_flush_all().
> 
> Note that the legacy printing logic uses @handover to detect
> handovers for printing all consoles. For nbcon consoles,
> handovers/takeovers occur on a per-console basis and thus do
> not cause the console_flush_all() loop to abort.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


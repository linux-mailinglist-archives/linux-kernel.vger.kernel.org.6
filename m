Return-Path: <linux-kernel+bounces-192073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D88D1806
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E271C2457B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756F13AD3E;
	Tue, 28 May 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bvOIUnGL"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF4F9DA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890655; cv=none; b=dOHxp6fn2HFVpK0QA+FiiCcJTUm1YFrD+FdcBGWcQGZf0BJ6sEPjuTeO+zxQ7o+0kEBAp5yIGlwiXlcpaBkBqXx+OJ3UyCfuRJ79tiBIxeRdnKx4YlpZgSbLGkEusGX6ixm8c/xYrgJ2LUZ4+0+YRDZvrCGaYb1UImBiovwPgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890655; c=relaxed/simple;
	bh=1yEvxg/UMf7DXoCsSdoVaI8TMmEaatz23H4XZLpBSjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjxa2HzqNjubG8sENZd8V63B92VOYFc+yj4zJgLXOSgbCnExiP5o04489x1M1q/OIN628IMFTLQKj3qhLIgaL1hAX04EG0aHfzYdzAWOHUmHE5JlSHZdn4yTPGs8N1ZDZCKQTbD6+0N5wqBRtF9u6OBKwfl/wf5PipfLTwoSlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bvOIUnGL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57863a8f4b2so697349a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716890651; x=1717495451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zuLcdpryWUXbu5ak1d/oYJThVncqY5Jd7DeWCPAKJnY=;
        b=bvOIUnGLgHpa9sx5dl9A/ko8z7FDaT8PyYc+cF9O1rQF7RUSp8l2QiQtxbQNT4IHj0
         9M/a8Di2H+eH6FMTKWQDT06oNocUyHlTvPMoufo671T72Tz1cNPCPCKvNgUZLsBX3Bix
         9gSHTc7pZ20du1PwK3fOEKWTQgSWqnz/R440617ohHE6NrBLGOtQ/Qd0ruc7qPmIcq7J
         Imh/Ou2HLsKM/yeDrNd+uS0UkiBncC5OatcfjCDqV6yDyaBzY/2rjDgsGTS+XmQFfGdQ
         nprb/w+b7QNSa1IYJ0XVy42rnOBAz/TzeyStbSq97VLXpTCzFzDWyIIg8Yx0/QuiW2eB
         yrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890651; x=1717495451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuLcdpryWUXbu5ak1d/oYJThVncqY5Jd7DeWCPAKJnY=;
        b=Dp8DKNHRVX7A0c5yFINQINvQka2/PTnjUFtWAcoTZNF4iEn32RnYzJnCCJT65IWbCq
         MP7K0lDC481PLJc2RmV3E/bbeM5xiH1bH+N6GkV1Fw4VkpRWUCUyLPSxnFkOPJeUSuaG
         niuo3QNJri4QOEZj/RCHiycABZn5vreXgL8eIQEH+GVxqvKXok59/HRfbHGLNNVkJ9nx
         8G6i5EivoSX6Gdnu+QfnSptuig80Uf9S9illaiBEj4uVXul+8BHySpMP8kJ6ZZm8hKcA
         2k3Xw/dohXROmBLZt0/l1cZ+2mCyDWgNRSmzxHneEYbhx2xm2+0C4Hb3TjPJh+XlDOK5
         W51w==
X-Forwarded-Encrypted: i=1; AJvYcCV1tbtT2dm/zKXAvzNHWqQlBNiJbqBMhvR/+bi9KjJckhLMiUPF2CksZ8l8XhSrGu0t9OZwr2wCRvqyuAh0VGT201+lUN6MbThE8ppH
X-Gm-Message-State: AOJu0Yw3ED+RffRXzh1Stxm8DQl1heS5pk4g3MyBjPn7lTkCjhKhEzqU
	sQkLe9ntcLR6qspgWGXGY9PgNXGhT74lueh7RDPNlE5NZGEFo8+uMJbgeSCq0d0=
X-Google-Smtp-Source: AGHT+IHStxBPW+RVZLC/cBlGPEigVgucOLaLZJoJjANp3IgFGqIqy41pQ1K2ZkdhIo3YDJ5C/j8z/g==
X-Received: by 2002:a50:d789:0:b0:572:4041:5637 with SMTP id 4fb4d7f45d1cf-5785199d663mr7353637a12.19.1716890651285;
        Tue, 28 May 2024 03:04:11 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852339fc4sm6975423a12.15.2024.05.28.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:04:11 -0700 (PDT)
Date: Tue, 28 May 2024 12:04:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v6 29/30] rcu: Mark emergency sections in rcu
 stalls
Message-ID: <ZlWsGd7ajyrlK-cB@pathway.suse.cz>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
 <20240527063749.391035-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527063749.391035-30-john.ogness@linutronix.de>

On Mon 2024-05-27 08:43:48, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> rcu stall information are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


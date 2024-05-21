Return-Path: <linux-kernel+bounces-185057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB49A8CAFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0945285EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E57F46B;
	Tue, 21 May 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FF5lPCJA"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6077112
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300234; cv=none; b=bl+DEr6Ff5y2FyDEaKl/y/Q6no+fJk1qqp1ICgKL26T1zWbS/qx8YLYE5jKz7xI6fe5LMdnC5MHnAT2zwjMvblOBhAyTy5aWnALZJLEfDAuZ5Y1RQMa9CFmqffuJ4nMEnsJsja8Tgo/+wWy8nkuXgX8PyzPF+fqM7XceZogRgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300234; c=relaxed/simple;
	bh=jD9lqUXVtwzsplzjO6LumEIjzZ8PUD4gwVqpPcQiLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wftp5lA2c2nkkuuQK3bmCrB1YEDyA5TawUuCVxYo/oevOAvJi33ntYMsyymrnQGR3j6pMRWAA4oRhNZWayrymGZRlKfgXwkXX2qqDjA305zSl+pcM6l6wk10Qq3M6O1DNaGG4a7IXdWYoDpmO6W8lPRAAm3mOmz1Nyw+2gm0lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FF5lPCJA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so759672166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716300230; x=1716905030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpCzsF2SjpoS+vP9sOIIVwewUFNHOIPX1cF6BrhM6sI=;
        b=FF5lPCJAvLfgmJtSIfN6TUaF/cyilaBngzMtQ8wgEO7gD1RpTox8bX35i4a8LI4Tcz
         twh7vkye+KfG8nXH4L5mYi0QzoCTQo7oYf2D+nihqlf0Uh5NbX79DdQSPUKahWD1A73U
         78IMc75yde2DdRKirezXNP4mgMdDZRA3Nwn31dHTJovaMsXTJJDqW+MraVC9dIJbjzR0
         HTvGrXFoV1LCHu1xjZIoNULyDkqnaX0yBaKuUVGtq2/Fmsx4lluAtcTDDzodAYCgUdj1
         ADl9aUB6hTuU4Tz0cXDeXMA1FgmjMQWHWQ2d8VSO8ZEr4wAi3VETuGBJlMnj6SfIKCmv
         lRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300230; x=1716905030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpCzsF2SjpoS+vP9sOIIVwewUFNHOIPX1cF6BrhM6sI=;
        b=qevbqtVf0CJnEFrD/UB3TnO+Da7VzJ0wevcrIUlp/SzUkzK7Xm5L+VlBY+zIA0N6ko
         jJHeICA4xW+BNhkPCah4P9bT+7IS1G6jsLEyPkHcmNq6TxI5PTQA+VBebZ4suiRorKyw
         VQG5HNzEpUOQQuZLQ25syRRBxG10OUFrWQknK5V4efOuyHmK/qCi6+x+MZECB3BoQR2+
         qIL5dd1UUejbbJaYS3xUJyB/tLtIf5OH1cizz9S+1z69jfw8yEr7QWrNkrOe3uxBO6xg
         8QLESPcM/4vCE5m0pFsaIo3EEdacvsaXs3bqOfvQW5B2AzMBWeM/Jk0ZSvwmxZ3IUPyK
         Wyvg==
X-Forwarded-Encrypted: i=1; AJvYcCXe7Qn5yXzpQt15JpWzrv00tvOipZ/ytxq4iQFF/QeL0ABaQUqAUGYD0eo5wnYaQwTaRhe4OKwZn1DkJqiKAANnKC8LjhTPU2iB6Nx2
X-Gm-Message-State: AOJu0YwjSKpudlGNHsBf4yein3C4LT/bDlYe82FKseH7EjTTz+wMd+XB
	Xivbd9iCaIXFehpJBQzqLCdEYwZgJqL3Ag4q5YyLOUqZDTqnISo0m7wMlDfi+yo=
X-Google-Smtp-Source: AGHT+IG2bIy86vwiqfSU9GGrcx0KTTzCGWnAuIiXF26lYQRM7jgWytH2FgVjnrjwz0GNvh2Qrdq8UQ==
X-Received: by 2002:a17:906:7fca:b0:a5c:e43a:2bd5 with SMTP id a640c23a62f3a-a5ce43a2fb9mr1375382266b.59.1716300230207;
        Tue, 21 May 2024 07:03:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b1771bsm1603365066b.215.2024.05.21.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:03:49 -0700 (PDT)
Date: Tue, 21 May 2024 16:03:48 +0200
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
Subject: Re: [PATCH printk v5 29/30] rcu: Mark emergency sections in rcu
 stalls
Message-ID: <ZkypxKBSPPGIo9Se@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-30-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:38, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> rcu stall information are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
>
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -612,6 +616,7 @@ static void synchronize_rcu_expedited_wait(void)
>  			}
>  			pr_cont("\n");
>  		}
> +		nbcon_cpu_emergency_flush();

It would make more sense to do the flush inside the cycle after each
dump_cpu_task(). Something like:

		rcu_for_each_leaf_node(rnp) {
			for_each_leaf_node_possible_cpu(rnp, cpu) {
				mask = leaf_node_cpu_bit(rnp, cpu);
				if (!(READ_ONCE(rnp->expmask) & mask))
					continue;
				preempt_disable(); // For smp_processor_id() in dump_cpu_task().
				dump_cpu_task(cpu);
				preempt_enable();
+				nbcon_cpu_emergency_flush();
			}
			rcu_exp_print_detail_task_stall_rnp(rnp);
		}


Or maybe, it is limited onto to few CPUs by rcu_for_each_leaf_node(rnp)?


>  		rcu_for_each_leaf_node(rnp) {
>  			for_each_leaf_node_possible_cpu(rnp, cpu) {
>  				mask = leaf_node_cpu_bit(rnp, cpu);

Otherwise, it looks good to me.

Best Regards,
Petr


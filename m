Return-Path: <linux-kernel+bounces-185021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589A8CAF80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EED1F2344E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA27EEF3;
	Tue, 21 May 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JuT9GUdo"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEB76049
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298692; cv=none; b=GNUEhnd9q0etv2XebRq8WGlGdEELW8z8spThNurM0jzPYFG88fFDCMUHOCsPLQZR/LIOe4y4WepJc+uJZ2aFClhZ67ZvA8OdcXg5PB1TnliI4Z64m4ezOYZ2VD5wO9NdbPin4nTuUausBnp01T0ZIZ+/oKHv/QzsihEvTTHb7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298692; c=relaxed/simple;
	bh=S34SJ7Bd8LIpyJ4/UWxDiTUejUShKh/90d2TtdFW98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4jWK7SDybf+0PUTrH5VuCuW3HTDbuvAlrHu97gj9uou7tB3/2oUKGJAXFxBlfR2nNW9R+xeCTVykoxxlmy8ryVVG5VhoWnPjHQjhPrS2GQe2QEW46lXGHuHTljkFARGYl751JfFuDJ4z4ptvyLwZTt/XIADsIE+E4MbaLc6XyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JuT9GUdo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a352bbd9so1222301066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716298688; x=1716903488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y49Q4qY2fy/uWwXL+DzS3vrvGSxSUsK+tnip8ncg540=;
        b=JuT9GUdojMxOdqGPa/RE5//E+TKJBxQNyZYbuYP9J0x2u5PKHviSQOUOUEULp//p39
         G6AVLebMQ65csBUPHQuDuaiHNiiTf4HY8TI4JWXVwEfjb2bv646fA4royAGr9rbeyNW1
         Wt2PCd+ieBqqMkEmitPgsJZzvn1APLvCLTduyzQ+aqQ/zcOsV9laYyszzv74ofirw0c8
         Jt4BbUo9vxmPR8a6+34+//4xblCtklepitNpbSoY5SV6fdTzg1iaOEy4Iu1aiVPSwxoa
         zH071G9DCnuw5JDxP+n1A36iq0JUgmnONSP66glzLYvsEHznEVCt43Six1fQyKp2/rrd
         t0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716298688; x=1716903488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y49Q4qY2fy/uWwXL+DzS3vrvGSxSUsK+tnip8ncg540=;
        b=dByzPU3JQqB50tyJMWAY8i16UHCNBivNAY/FWsasQsGFp0kRqD3foQK7/Q20qgsQPc
         57ZUR3YdqVJEjiiLpM8OIu35e/PtQPs8LPJxCpQiebss//vhEphn/tkUsZ5IXES2PHUf
         Yfm8pWaOvED09qxwZq5dNfxUl/xl/lo+Xv0jQDv2emiamR6wJ9SpPmKHZL0vYHzV6Stx
         3ThcaOmLoQBj2O4S5m6Dr1BncMPsMMdoVk6JbKzsSpvjVdaBA2u5Csjb+q1RvuydCUNe
         C/CnWorL98F6MkaTMPlErc6Ij1SCq5TiekCLY5sSBfchubefExIUS3pq3Fm10wDpK0yq
         sEug==
X-Forwarded-Encrypted: i=1; AJvYcCULyXUNX3L3/P/fQHYN85pvHP14S+UmIg8LU2RXMBhEUf5XhLnR1onhfeqgCl6PUWc+Xi/2WfYRHbsVYosMJTbTGfRw9vWeABL0+fj/
X-Gm-Message-State: AOJu0Yx36PY4lLobWqNma4QrcqZoy5erra3McFq8e/U+k3V6fVBUgF2Q
	PM4ra5BhQF10C4aSngYrRwHyMoEPsnacY9w567ZW8UrfDYwlNZeMDvOTfnLMGko=
X-Google-Smtp-Source: AGHT+IHF73/vPB1nmmWB3xwF3LriQyS6DB2ZdG1cjm8uOOXB6wmU71H3vGVxFfoG1gVXyzu9D/hOtw==
X-Received: by 2002:a17:906:1d58:b0:a59:ad76:b371 with SMTP id a640c23a62f3a-a5d5c82618amr812197866b.26.1716298687844;
        Tue, 21 May 2024 06:38:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17754sm1600480766b.192.2024.05.21.06.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 06:38:06 -0700 (PDT)
Date: Tue, 21 May 2024 15:38:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 26/30] printk: nbcon: Implement emergency
 sections
Message-ID: <ZkyjvcAg8HnYEUdt@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-27-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502213839.376636-27-john.ogness@linutronix.de>

On Thu 2024-05-02 23:44:35, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In emergency situations (something has gone wrong but the
> system continues to operate), usually important information
> (such as a backtrace) is generated via printk(). Each
> individual printk record has little meaning. It is the
> collection of printk messages that is most often needed by
> developers and users.
> 
> In order to help ensure that the collection of printk messages
> in an emergency situation are all stored to the ringbuffer as
> quickly as possible, disable console output for that CPU while
> it is in the emergency situation. The consoles need to be
> flushed when exiting the emergency situation.
> 
> Add per-CPU emergency nesting tracking because an emergency
> can arise while in an emergency situation.
> 
> Add functions to mark the beginning and end of emergency
> sections where the urgent messages are generated.
> 
> Do not print if the current CPU is in an emergency state.
> 
> When exiting all emergency nesting, flush nbcon consoles
> directly using their atomic callback. Legacy consoles are
> triggered for flushing via irq_work because it is not known
> if the context was safe for a trylock on the console lock.
> 
> Note that the emergency state is not system-wide. While one CPU
> is in an emergency state, another CPU may continue to print
> console messages.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1199,6 +1228,93 @@ void nbcon_atomic_flush_unsafe(void)
>  	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
>  }
>  
> +/**
> + * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
> + *				messages for that CPU are only stored
> + *
> + * Upon exiting the emergency section, all stored messages are flushed.
> + *
> + * Context:	Any context. Disables preemption.
> + *
> + * When within an emergency section, no printing occurs on that CPU. This
> + * is to allow all emergency messages to be dumped into the ringbuffer before
> + * flushing the ringbuffer. The actual printing occurs when exiting the
> + * outermost emergency section.
> + */
> +void nbcon_cpu_emergency_enter(void)
> +{
> +	unsigned int *cpu_emergency_nesting;
> +
> +	preempt_disable();
> +
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +	(*cpu_emergency_nesting)++;
> +}
> +
> +/**
> + * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
> + *				stored messages
> + *
> + * Flushing only occurs when exiting all nesting for the CPU.
> + *
> + * Context:	Any context. Enables preemption.
> + */
> +void nbcon_cpu_emergency_exit(void)
> +{
> +	unsigned int *cpu_emergency_nesting;
> +	bool do_trigger_flush = false;
> +
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +
> +	/*
> +	 * Flush the messages before enabling preemtion to see them ASAP.
> +	 *
> +	 * Reduce the risk of potential softlockup by using the
> +	 * flush_pending() variant which ignores messages added later. It is
> +	 * called before decrementing the counter so that the printing context
> +	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
> +	 */
> +	if (*cpu_emergency_nesting == 1) {
> +		nbcon_atomic_flush_pending();
> +		do_trigger_flush = true;
> +	}

The commit message says:

  "Legacy consoles are triggered for flushing via irq_work because
   it is not known if the context was safe for a trylock on the
   console lock."

I do not feel completely comfortable with this. If printk() knows
when it is safe to call console_trylock() then we should know as
well.

IMHO, we could just call the below implemented nbcon_cpu_emergency_flush() here.

> +
> +	(*cpu_emergency_nesting)--;
> +
> +	if (WARN_ON_ONCE(*cpu_emergency_nesting < 0))
> +		*cpu_emergency_nesting = 0;
> +
> +	preempt_enable();
> +
> +	if (do_trigger_flush)
> +		printk_trigger_flush();
> +}
> +
> +/**
> + * nbcon_cpu_emergency_flush - Explicitly flush consoles while
> + *				within emergency context
> + *
> + * Both nbcon and legacy consoles are flushed.
> + *
> + * It should be used only when there are too many messages printed
> + * in emergency context, for example, printing backtraces of all
> + * CPUs or processes. It is typically needed when the watchdogs
> + * need to be touched as well.
> + */
> +void nbcon_cpu_emergency_flush(void)
> +{
> +	/* The explicit flush is needed only in the emergency context. */
> +	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
> +		return;
> +
> +	nbcon_atomic_flush_pending();
> +
> +	if (printing_via_unlock && !in_nmi()) {
> +		if (console_trylock())
> +			console_unlock();
> +	}

Hmm, we should also check whether we are in printk_safe context.
We could implement:

bool is_printk_deferred(void)
{
	/*
	 * The per-CPU variable @printk_context can be read safely in any
	 * context. The CPU migration always disabled when set.
	 */
	return this_cpu_read(printk_context) || in_nmi();
}

How does that sound?

Best Regards,
Petr


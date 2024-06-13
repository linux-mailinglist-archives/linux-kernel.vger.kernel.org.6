Return-Path: <linux-kernel+bounces-213306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E59907392
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04EA1F24E00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BE142623;
	Thu, 13 Jun 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YyTH+GtW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA059143895
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284947; cv=none; b=j0eAPu5eiaMYHtGauCzRdF4C2M9GNXcmZZeOOzsF7zN7Y4dA6c05xL+F81D68J/ZWkKR7lNoRtbBtFSOs7mjrHfov+0u/qybh72wFJMv+GMhL+E2oM85Vl1M9P41DvQgmasOb4vVeoWPcEm1okwXdJaTCLcmda7EyKOxeSgOsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284947; c=relaxed/simple;
	bh=tAchQjBXxmWTCNVTHhOk8jETutDNsjZKzQWp2WEW2Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2YC6PscK+m74IKVbLgo4529gO4Hn6O41k8P4x/M5C5uxcVODYimzMCMJn7WoFkBheACFJQ7EZR+TvEkN5Wfum0Mecp98L3AoChhcaOts6aqiQqK/ZNUWNs4iDHf736ZLkGgId2Cmf6gNbEh4XjUloQUpOElohCPmwDd5hT47W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YyTH+GtW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so123648966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718284943; x=1718889743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ss/QRlvU8QImNly7J4nF6wMhKGNuQpxJB6yfLL804Y=;
        b=YyTH+GtWu0uWshZUmHo4SXRsJTpz5onSjOzxHX/S8X3jIGQwq80ng/wMiXurP4iDIq
         ng4qJuiAXA1TN0ScyK5TcRUyitPpIqJLmC+qvjKLNaY97HT9IBORP1YXnZg2KpyR5MDJ
         JBdL2A5C1kqDylmV6+6wjxeijK72hiM1XJkO5iJW1ya0J6tskx9TXGI/kgz94jpGQvPh
         x/xRefYft4YlK152Y+1AwI4f9P5wxhmY6cpCPIRaKZxOv9RHTQloCu2sX8JNjU13v+NA
         4ZQg1V6amxvREiZwtTFdjbv+r1wZcLAufwg+lwlTBdVHQYfkFMfP5motYvCpWbo632Dz
         nrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284943; x=1718889743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ss/QRlvU8QImNly7J4nF6wMhKGNuQpxJB6yfLL804Y=;
        b=MAzhiO7GDhtSOCuRAsoW2vukEvtYRFmV2vU7B7B665vbfQkeMPfLlP63Z+j/M3PadX
         esmQgm62P/gN3sS7th69dpXgR7evCpGiRemcQ8NtqDNuh8JaPwfzCaU0yB9bxGOtk6ap
         Y54QwVIlhYAnahbFc69vBCbPpogPvIg674NOI7QqtUtbKQ7RbIUy++UaAQ/6yOC0teH4
         LoKz5ylG8CiHE69v318IOyroH+j8RgymjDKih8QjdzZOfCeXhm0QbN8bTGja4w2F8KU6
         Pw8d7NKmatzkuBbc9pfrwEMCcX+Ce5DssrHfrJ6cBmYzpLSddT4A8nE3yzr5MMDmrFRa
         XtIA==
X-Forwarded-Encrypted: i=1; AJvYcCVz+w6FhdFHX+EOX79o92VxiyiPtvnsIOLzFstvUawP3WqJ8DpRar7d+7IuPpOtWhOfSWsKC36WSuJc70v9y0bdGPJJaivhqv/cBReH
X-Gm-Message-State: AOJu0Yw2iro+TWXznfokIzGVFTSMDY3/nqcJG4GGMYSQ+0nE9Oc8K6zv
	WlAEz1qBv6gwmgqL5VJU+WNbiQd6c2FNRe5jLf751msZO9iI1cmF6J3PozLlLWg=
X-Google-Smtp-Source: AGHT+IHf30/cGx9GqTIif1t7sZffZ8CWNzHIx96f2XJfOpJbydLHhGID8eZxTM6JzA4TIUSoj90yhw==
X-Received: by 2002:a17:907:7da4:b0:a6f:501c:5da8 with SMTP id a640c23a62f3a-a6f501c62d0mr279820266b.22.1718284943057;
        Thu, 13 Jun 2024 06:22:23 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41684sm71954266b.153.2024.06.13.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:22:22 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:22:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/18] printk: nbcon: Add context to
 console_is_usable()
Message-ID: <ZmryjZaYbwUcVrut@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-7-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-7-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:41, John Ogness wrote:
> The nbcon consoles have two callbacks to be used for different
> contexts. In order to determine if an nbcon console is usable,
> console_is_usable() needs to know if it is a context that will
> use the write_atomic() callback or the write_thread() callback.
> 
> Add an extra parameter @use_atomic to specify this.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/internal.h | 16 ++++++++++------
>  kernel/printk/nbcon.c    |  8 ++++----
>  kernel/printk/printk.c   |  6 ++++--
>  3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 38680c6b2b39..243d3d3bc889 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -100,7 +100,7 @@ void nbcon_kthread_create(struct console *con);
>   * which can also play a role in deciding if @con can be used to print
>   * records.
>   */
> -static inline bool console_is_usable(struct console *con, short flags)
> +static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
>  {
>  	if (!(flags & CON_ENABLED))
>  		return false;
> @@ -109,10 +109,13 @@ static inline bool console_is_usable(struct console *con, short flags)
>  		return false;
>  
>  	if (flags & CON_NBCON) {
> -		if (!con->write_atomic)
> -			return false;
> -		if (!con->write_thread)
> -			return false;
> +		if (use_atomic) {
> +			if (!con->write_atomic)
> +				return false;
> +		} else {
> +			if (!con->write_thread)
> +				return false;
> +		}
>  	} else {
>  		if (!con->write)
>  			return false;
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4018,8 +4018,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  			 * that they make forward progress, so only increment
>  			 * @diff for usable consoles.
>  			 */
> -			if (!console_is_usable(c, flags))
> +			if (!console_is_usable(c, flags, true) &&
> +			    !console_is_usable(c, flags, false)) {
>  				continue;
> +			}
>  
>  			if (flags & CON_NBCON) {
>  				printk_seq = nbcon_seq_read(c);

I wonder if it is worth it. Do we seriously want to support nbcon
without con->write_kthread() or con->write_atomic() callbacks?

For example, I see in kernel/printk/printk.c:

void register_console(struct console *newcon)
{
	bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;


We would need to extend this check if we wanted to allow nbcon
consoles without con->nbcon_atomic()...

Best Regards,
Petr


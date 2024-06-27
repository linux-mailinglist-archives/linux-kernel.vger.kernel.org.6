Return-Path: <linux-kernel+bounces-232047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2636D91A21F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E1F1C21401
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0021386D1;
	Thu, 27 Jun 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZX+pH7ad"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2A1386A7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478974; cv=none; b=PGJFhXddlFzPv60JtQCCQ89sKx/8O2gmJVZ6SE+Ljo5zlL6FTlnnUvWuOrLweL5JH1IQ2+JBzUXgxkH9ioUu78GOFPCVlg6rYN4fZdx8afszs10GsWEdg03U/5jYf9lh3HzvLSzmX4kOqG4SZcwmmx/witg6UUAliPBGwEMm4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478974; c=relaxed/simple;
	bh=/HuA9sIM45rfx+JNeCBr0HYCr6cegkyYM2SAT2mdjuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy4CbU7/Ypm2UqF2savRJOCrQJIVVYN510eFs1s+HHxNvDGsrhjyxfIwi7BxZQxmYg+FzOz7eDHioqZlubGI1wKne+UlSSJv8KD9AIzP7hCcGj2VdNI23cZjnXJl06ZzYrTNH0lZjYSRqXgaR+JJsYQWv9LCnNSljkbcaVK0Q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZX+pH7ad; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so1961135a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719478970; x=1720083770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVJHHFxsFGNC+CpTuC7eFD4WHZBpUTVWHAScPtS50r4=;
        b=ZX+pH7ad1vFBrJ05WRqXbaTO5//O5eDXZzZHoOwP8MCntjw5t8VsVYmi66L6kqfkV5
         PtJzxvR8N3x9RTQpQal/ezQTDMgbf/JRRDez3dcWyKGCXjTE10mbIZcXSKaWU16p8OpQ
         w/v5ZPg0pVzKPJqRUBpW9WlfN779oc0OoTDoqYv8Ca956e6Su9HK/jKyJPR6RQgHgd1Z
         DwxbZMVuwwZKwNH2V3F4h88UOB3TT4b0WgdUEZcJCmSgAxOw9TibOR4EgSp2phNUIQKN
         1BWhYsDHgnNQX33HqYS3BxFMq8b93QzgpgRdoBQjImoY6XeHUt/gfC/8lM8+NIO31LZf
         ad8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719478970; x=1720083770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVJHHFxsFGNC+CpTuC7eFD4WHZBpUTVWHAScPtS50r4=;
        b=Cke9QYVWsrKEG18MmWUSJG94PtYoC7y9XyHTOZhv4DGA9YZxXwurn4ORoJzsAuhiI1
         hnm0RMJHJX5xBCKs9ZJSmrROIKXEUHsIpks7O8Pq08gflCsUyWqnhKiVSF477aXWM5hZ
         7hOf9WWl/APYyjXv1wkXTBukiTqKnNHY/EWoknzHmqIKsmTCX+LoFCA4QWwhVliWDBSH
         a5BSN/n8de5eEvVd3Bgu8eI8H/E9dQBm/doRsAGeIgNjn8xpW4FkRmxCEY49WjRD2a+c
         tqtPMlpzZ5j3VV8vRMHERLTrg7gCbQhyig34daQrKi0xoISuvebnC3TZULEyub2CF9ac
         +jpA==
X-Forwarded-Encrypted: i=1; AJvYcCXVbDvp6332uxqb59D/Nxr3PHK1bdx7wp9S4gOgf2TOXcn02Sn2SuA2X0/qIOx2eEgIAGOsWry1IwO3x9w2mghpDtypy/fPDCNu9W5z
X-Gm-Message-State: AOJu0YyJfBP9UfLycL78SYyJVfZ0rcDy8XwbXIh1DdBRJaP/U7FDo2Th
	tTA5bFZQy953K6jCkwsgBpCecBVXhwZFpmMYN0ZJ53scdG3zsInbMSyA2zDKjZ4=
X-Google-Smtp-Source: AGHT+IHT2KA6PAkiA91MD5h1tmv6NnAKlUvPGpZdZnXekYQ9mnXMlsa4UP45mJuWwiuuVg88RoreOA==
X-Received: by 2002:a50:a6d2:0:b0:57c:614c:56e7 with SMTP id 4fb4d7f45d1cf-5847c19a927mr1651331a12.18.1719478969031;
        Thu, 27 Jun 2024 02:02:49 -0700 (PDT)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d0c9e36fsm602358a12.8.2024.06.27.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 02:02:48 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:02:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: mm_update_next_owner: move for_each_thread()
 into try_to_set_owner()
Message-ID: <Zn0qt4KY8S4E65IM@tiehlicka>
References: <20240626152835.GA17910@redhat.com>
 <20240626152930.GA17936@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626152930.GA17936@redhat.com>

On Wed 26-06-24 17:29:30, Oleg Nesterov wrote:
> mm_update_next_owner() checks the children / real_parent->children to
> avoid the "everything else" loop in the likely case, but this won't work
> if a child/sibling has a zombie leader with ->mm == NULL.
> 
> Move the for_each_thread() logic into try_to_set_owner(), if nothing else
> this makes the children/siblings/everything searches more consistent.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/exit.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index a1ef5f23d5be..cc56edc1103e 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -440,7 +440,7 @@ static void coredump_task_exit(struct task_struct *tsk)
>  
>  #ifdef CONFIG_MEMCG
>  /* drops tasklist_lock if succeeds */
> -static bool try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
> +static bool __try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
>  {
>  	bool ret = false;
>  
> @@ -456,12 +456,28 @@ static bool try_to_set_owner(struct task_struct *tsk, struct mm_struct *mm)
>  	return ret;
>  }
>  
> +static bool try_to_set_owner(struct task_struct *g, struct mm_struct *mm)
> +{
> +	struct task_struct *t;
> +
> +	for_each_thread(g, t) {
> +		struct mm_struct *t_mm = READ_ONCE(t->mm);
> +		if (t_mm == mm) {
> +			if (__try_to_set_owner(t, mm))
> +				return true;
> +		} else if (t_mm)
> +			break;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * A task is exiting.   If it owned this mm, find a new owner for the mm.
>   */
>  void mm_update_next_owner(struct mm_struct *mm)
>  {
> -	struct task_struct *c, *g, *p = current;
> +	struct task_struct *g, *p = current;
>  
>  	/*
>  	 * If the exiting or execing task is not the owner, it's
> @@ -483,19 +499,17 @@ void mm_update_next_owner(struct mm_struct *mm)
>  	/*
>  	 * Search in the children
>  	 */
> -	list_for_each_entry(c, &p->children, sibling) {
> -		if (c->mm == mm && try_to_set_owner(c, mm))
> +	list_for_each_entry(g, &p->children, sibling) {
> +		if (try_to_set_owner(g, mm))
>  			goto ret;
>  	}
> -
>  	/*
>  	 * Search in the siblings
>  	 */
> -	list_for_each_entry(c, &p->real_parent->children, sibling) {
> -		if (c->mm == mm && try_to_set_owner(c, mm))
> +	list_for_each_entry(g, &p->real_parent->children, sibling) {
> +		if (try_to_set_owner(g, mm))
>  			goto ret;
>  	}
> -
>  	/*
>  	 * Search through everything else, we should not get here often.
>  	 */
> @@ -504,14 +518,8 @@ void mm_update_next_owner(struct mm_struct *mm)
>  			break;
>  		if (g->flags & PF_KTHREAD)
>  			continue;
> -		for_each_thread(g, c) {
> -			struct mm_struct *c_mm = READ_ONCE(c->mm);
> -			if (c_mm == mm) {
> -				if (try_to_set_owner(c, mm))
> -					goto ret;
> -			} else if (c_mm)
> -				break;
> -		}
> +		if (try_to_set_owner(g, mm))
> +			goto ret;
>  	}
>  	read_unlock(&tasklist_lock);
>  	/*
> -- 
> 2.25.1.362.g51ebf55

-- 
Michal Hocko
SUSE Labs


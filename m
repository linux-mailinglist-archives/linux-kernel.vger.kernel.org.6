Return-Path: <linux-kernel+bounces-247289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B058592CDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15F31C22160
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1E16DEA5;
	Wed, 10 Jul 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch0N2TPT"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41217BB18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601798; cv=none; b=O4d8W70aQWqrAPHTevUr6EbguBOfWCMlVzC9aNHPiSiyScd0Vyl+wvdPArZJO+luY0Jf0QBEh4SolO77gnoMsTDYe+6thgTX6neHBcpr//q7R/jGBln92Ali9Yqgx5XsYi0GyvjojTSShDIuLEuOKPOxwsoDN6SKiYIwfcYkUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601798; c=relaxed/simple;
	bh=9/rX9rvb1Z1XmLlY4faa9AJZN3iaOMzGyDvAwevHP7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soq5jK1emGTil3V2YsGxGsN3pHX7TYTlIn7OlQ0kJM4+2svSp4FCvXmYFRwKpY/KSXEURHRbWNVikQgTDkDl6T35MV1FlGA/7ipCFELE5CrkHKNyf7gfcWZBGCx+NCAKrP3+Fd2FLLCTWu4Z9K7NYKRwLZ5r4HQOKJL+/07q7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch0N2TPT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so89096366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720601795; x=1721206595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYny+C18uFNOCEmpysA9wjgrbs4B3jH8zjB4KcPnhHg=;
        b=Ch0N2TPT6TG1/CJSiozEAtNXbp91DOQ6nTB6NAGq4oLc8ZXLCZ/lONQ9o6Gp/IwdIE
         hF7j5VjKvXwSRGXXniwSXFIRn0LDx1FaP8pY2IjGtdEbKL3q0nteZktUk4kJKwxvEuRm
         x5krJBOvYbqFvhoHqKVjNJYwzxV0PrA9+TPkB8hLl0C302EkuC0fFwWqYScrCa0P5juN
         pWuC61JMa6+iGgVg74Febrf68sFhZkyCXJrp7oBI2FIOpVou7s42Hx9FTMjxYvkkKNO8
         kN3vO9+XLOHwpS4r1IbnpiuaXC+OBfvpzUAVWTriwK44VJtfSh3c6ON0q5csbqqkdN9x
         jaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601795; x=1721206595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYny+C18uFNOCEmpysA9wjgrbs4B3jH8zjB4KcPnhHg=;
        b=ABF4VbOb7+YBceyUAG/+oUjmA2dSt95AG1LIbzxgQHP3qiqX5WlZ3xt9KGUhxsyoAN
         u4Y0OVaIYnXvyylHmVdTUAMglvh2bQH6MQRh1NEk0BzgnRGXPmbZHvJXASmrH5e/dsGx
         iD8ZpF4ZRWCv2UTETadwbsOAuHnRlcWKnwDV6CGqAZzltTI9ZBu6iMrdbobRvASZJujW
         4K66f++dk2vLxPWadRV9nUTEe+Wnbp8MPFTj3ev3E7KCUgbaN1U9U5DoAF29lni8mpD0
         2s6vSsF+ImCOw1zAtVRp6fHQM41rAu2WIy6IWD433Rv78s/A7WBDfxTdM2Q4xNHvr4CO
         57Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUL8Io7lcl5iCl5HL01ZeIExq3b0qqpgN0AEa0rV1r3p+R2kuIpYgtBK+z83hKB1RB1Dht1tIf3OPKosYflqTGQVXyJdTQDtx+M+FE9
X-Gm-Message-State: AOJu0YxjwGXGL0VetlcKnUFWk1Q+sN2mHzImEvJk8EqEDF0v9T2TEfRC
	fNXGlaiphDEEHg+3aOwJaUk7sF+0QWjyuPgkSZLiDaIJ6I/Xk0c=
X-Google-Smtp-Source: AGHT+IGmX2ULoy6m40kNtxUUURHBIPSq4gSHfjtVoP3q/J5L5bBlGUSOQr0a4+lbCg17dpPonoLOlw==
X-Received: by 2002:a17:906:2451:b0:a77:dba6:346 with SMTP id a640c23a62f3a-a780d28c43fmr293066566b.32.1720601794538;
        Wed, 10 Jul 2024 01:56:34 -0700 (PDT)
Received: from localhost ([151.47.106.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a872e0dsm141051066b.215.2024.07.10.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:56:34 -0700 (PDT)
Date: Wed, 10 Jul 2024 10:56:31 +0200
From: Andrea Righi <righi.andrea@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com
Subject: Re: [PATCH 2/6] sched_ext: Open-code task_linked_on_dsq()
Message-ID: <Zo5Mv4aIe2wDSHyJ@gpd>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-3-tj@kernel.org>

On Tue, Jul 09, 2024 at 11:21:08AM -1000, Tejun Heo wrote:
> task_linked_on_dsq() exists as a helper becauase it used to test both the

small nit: becauase -> because.

> rbtree and list nodes. It now only tests the list node and the list node
> will soon be used for something else too. The helper doesn't improve
> anything materially and the naming will become confusing. Open-code the list
> node testing and remove task_linked_on_dsq()
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> ---
>  kernel/sched/ext.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f16d72d72635..52340ac8038f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1572,18 +1572,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  	list_del_init(&p->scx.dsq_list.node);
>  }
>  
> -static bool task_linked_on_dsq(struct task_struct *p)
> -{
> -	return !list_empty(&p->scx.dsq_list.node);
> -}
> -
>  static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
>  {
>  	struct scx_dispatch_q *dsq = p->scx.dsq;
>  	bool is_local = dsq == &rq->scx.local_dsq;
>  
>  	if (!dsq) {
> -		WARN_ON_ONCE(task_linked_on_dsq(p));
> +		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
>  		/*
>  		 * When dispatching directly from the BPF scheduler to a local
>  		 * DSQ, the task isn't associated with any DSQ but
> @@ -1604,7 +1599,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
>  	*/
>  	if (p->scx.holding_cpu < 0) {
>  		/* @p must still be on @dsq, dequeue */
> -		WARN_ON_ONCE(!task_linked_on_dsq(p));
> +		WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
>  		task_unlink_from_dsq(p, dsq);
>  		dsq_mod_nr(dsq, -1);
>  	} else {
> @@ -1614,7 +1609,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
>  		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
>  		 * the race.
>  		 */
> -		WARN_ON_ONCE(task_linked_on_dsq(p));
> +		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
>  		p->scx.holding_cpu = -1;
>  	}
>  	p->scx.dsq = NULL;
> -- 
> 2.45.2


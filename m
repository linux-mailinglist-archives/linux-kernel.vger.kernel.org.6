Return-Path: <linux-kernel+bounces-241931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CC292817A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5863B1F23A54
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5113AA3E;
	Fri,  5 Jul 2024 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SkzykjS9"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA527452
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720158175; cv=none; b=KyziBt8AHvfbT+jtHGcIlZogUSoPNWHEEBBf+BddTDh/m22z3KDayxye9E8yXjI/pNzBK6VIg5TwlUT/74pb3iEpB+XQ4oamBHRzHRW6K0iBf4Cxfd+d1M40O9iFZlQUnko1zC/i19ijQctHHICBT2/oidCPXNboXdgt0+vDbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720158175; c=relaxed/simple;
	bh=D2CaOKLjDicObH/UYL/bOaq/31sdiPp3nDqbdUbrhik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YaTmrH4gzomwVFo1mPHi9oWNCLpQbL+VEBBeG1lKYMTqyhh6C5q8mOK/C1NiBgEdA0fFwpEji/tTj8PPmfWXtHG28tLLeCN+UMZX0+2WSDqSqkRgeIr2WstKhpm2ne91E0tqb92YiQ4n5vRNvzmJ/VmWG4wN/7c99aU988ixCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SkzykjS9; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WU9Xk
	pHQSFZFyURpC0fKV0A+o6oFRCwaYuNVIHRBkfQ=; b=SkzykjS9QQ+tUqFKRnmHT
	jcag7IPlKb9/H6Ku8JyFCqHGBHpMN6GJmc256hCWy9to0HGMmp6fPAQ80o5uyqud
	tcg5UPkfRdGNbrVFtjSd7mML7B1s5vEoPr9RjdjxxkHG9ICdbuc2Tm6ljB/DIV0I
	X5zbbdRHO8ra9XUQhZCEnI=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wDn71iMh4dm9rOsBg--.2278S2;
	Fri, 05 Jul 2024 13:41:33 +0800 (CST)
From: Peilin He <peilinhe2020@163.com>
To: peterz@infradead.org
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	jiang.kun2@zte.com.cn,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	liu.chun2@zte.com.cn,
	mgorman@suse.de,
	mingo@redhat.com,
	rostedt@goodmis.org,
	tu.qiang35@zte.com.cn,
	vincent.guittot@linaro.org,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: Re: [PATCH linux-next v2] sched/core: Add WARN() to check overflow in migrate_disable()
Date: Fri,  5 Jul 2024 05:41:32 +0000
Message-Id: <20240705054132.108523-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704134716.GU11386@noisy.programming.kicks-ass.net>
References: <20240704134716.GU11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn71iMh4dm9rOsBg--.2278S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDJw4UtF4rZry7Gw45Jrb_yoW8XFW3pr
	Z3t34xGFZrXF42y3W5AFWUGFs5u3ykK3ySganrurW0yFZ8JrsYvwnYgFn5WFnaqryDKw1S
	vFy7t3W7Ar4vvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK1v-UUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbBchETsWWXwCRmHwAAsu

> How about we do something like this?
>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7a5ea8fc8abb..06a559532ed6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2237,6 +2237,12 @@ void migrate_disable(void)
>  
>      if (p->migration_disabled) {
>          p->migration_disabled++;
> +#ifdef CONFIG_DEBUG_PREEMPT
> +        /*
> +         * Warn about overflow half-way through the range.
> +         */
> +        WARN_ON_ONCE((s16)p->migration_disabled < 0);
> +#endif
>          return;
>      }

Agreed, converting p->migration_disabled to a signed number 
will detect overflow occurrences earlier than our current method.

> @@ -2254,14 +2260,20 @@ void migrate_enable(void)
>          .flags     = SCA_MIGRATE_ENABLE,
>      };
>  
> +#ifdef CONFIG_DEBUG_PREEMPT
> +    /*
> +     * Check both overflow from migrate_disable() and superfluous
> +     * migrate_enable().
> +     */
> +    if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
> +        return;
> +#endif
> +
>      if (p->migration_disabled > 1) {
>          p->migration_disabled--;
>          return;
>      }
>  
> -    if (WARN_ON_ONCE(!p->migration_disabled))
> -        return;
> -
>      /*
>       * Ensure stop_task runs either before or after this, and that
>       * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().

Agreed, similarly checking for overflow in p->migration_disabled 
within migrate_enable is fine, but placing WARN_ON_ONCE inside 
the CONFIG_DEBUG_PREEMPT macro may cause return logic deviations. 
It is recommended to support WARN_ON_ONCE as a standard feature.
The fix will be reflected in version v3.



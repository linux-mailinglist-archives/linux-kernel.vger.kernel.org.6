Return-Path: <linux-kernel+bounces-527510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D02A40C24
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B67188A31D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9E204590;
	Sat, 22 Feb 2025 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="WbiGCYE9"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD478F2F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740267399; cv=none; b=q68Flql+0yNMBZeCQKPNe8Dv+qmOfAeZuIkyp3ifM/45j7I/hMe0T/4SGFiLfbMLc78pedJJpQDHWVQgHxKNy77A3y+7/C5vaWa460VoRnKpJH8CtF8XfjCDA5hGeme8reiy3N5Jn611nqxbCCayLf3PxIZ+Sv75h1VYcVsD/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740267399; c=relaxed/simple;
	bh=W77SzvNr8H94Le/8syWHtp6x1tP/j8+S2D0g+SvSY34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLl0ttce1P1fIYoS/7LymbKtZm0gYiyVu+wyXQ+qYM0YIzNxJT0o0TNA8AwY2db+n8RjOA93juLvpmoFnYJXSAIT2v5fk93xXfLoKg0JtyeTnr40NxJJuePpYSbECEl58iIg898C8jaDB6nQKYIsjDSS/DxBpPv6RPTnh5vSPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=WbiGCYE9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbda4349e9so472267566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740267395; x=1740872195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAoIPctK3fqHVAiWghtoRIf/lTgRwx6zOokplaufCs0=;
        b=WbiGCYE9d+PS7J9ytGMU3nffnXz+nh+/DeMQEel3tYddZVCTunPzYewVxjneGAPxAs
         rrsdbFect/Qy00OSb8F5uyTQgkGMV35PYSxbgc6bqyL25IpsfcFbN47Zp2KcYCnTZOTx
         3vFbsgys2mXLxiy+daDH+suC6E+FK/L25P5m5zBg9+NQ4CcT9JWJNvRKz1zr37WBmo4d
         YFUJ6vEhnraTGEHxpYew/q4ExE6S/ju+2vdsZhfL89COQtvAIPj1SDVYiAinmwp5WEeT
         7a8HYzm5qCVrXrvlffjQMJLkdlYqtZLT5ynDfN7GzSAlWmxfiNh9Q1KsjeVA7VHczC1R
         pS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740267395; x=1740872195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAoIPctK3fqHVAiWghtoRIf/lTgRwx6zOokplaufCs0=;
        b=pUW+W2XS7cug9DncBN2kSkNNG4QqShUzoR6OUoOhhxOCFnswYWTbcejoqdOm5r1oTt
         LuUxFlAFwdzBL7951M6+fCwGds3nFkmw2IvIyoImZPoCdLt8X32wvDECOR+FK6kY1QJP
         JyPZ1J86IStt47EV3UnZmetwdIIcuIjX2Sq30Nw3YDFTzEDRdC/54KnHXv5xNyn1oh7O
         oKL32nxTyp2MzXHs96VX3nJCA/LQjsJpmk0kZ56xgPOU+lrw4GutIhJxjEoL/ctKF36g
         s01ixtLjHRo5XI8LUE6apylfROx7lPadRSJNoEFey06/IScBWAG+iJWIv3s1IhlMdHlC
         JOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKxu5TC3OA0yrppM9f6aJknsfwHyYJ94Ke9+ymzbU2nWB8add7NNUo5y6c2yvJNIpN1VdcMd7FAGNvbUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP40xJrAaZ5vqMyPG+hIWLwcUX/mb00b5i6QO5EghxzsiTekd1
	JbydoKJFG0tOI8kDMsVcEflGhuwfdUl9dUvk1lqukpUY3hiERe4k6YFNYEWJWJ8=
X-Gm-Gg: ASbGnct2eNr8YzzJDGnJAQSpKKWjTfREyFEkZdNHeIPFBGsPiesuI3iK4uhmCeKMkni
	a1xvy+vLTrWmRGaXpOCbRRd5VlNATYkHJ6hx60BJNZvD7DP313ekzdovjWc5xKjClhQbnTdRIBM
	p4wI8NzXRTf7Bj7TRngr3o/8asaPeGPoelNRUxNyuCHaxfvR1KfU/vXjhdiobxA/WoXzf11jiFP
	TzzepZ90pILb3lhMfKA3Kpz2xzAdV0USHUxKT/sycyZID3UPRo2Y+TJAoyhrX17OkVYNaWV7PNy
	4l0sC90NXbLAKrlCDNYU
X-Google-Smtp-Source: AGHT+IHJTaLwjzt/tiwaKac4ucEvj/k85eCD9iv3ov8InRawXZEDewkDilxI++U5Ru1O3FUU+cAW9Q==
X-Received: by 2002:a17:907:7754:b0:ab7:e811:de86 with SMTP id a640c23a62f3a-abc0d9ca365mr628075866b.13.1740267394918;
        Sat, 22 Feb 2025 15:36:34 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9a65bea0sm1252192366b.46.2025.02.22.15.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 15:36:34 -0800 (PST)
Date: Sat, 22 Feb 2025 23:36:27 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
Message-ID: <20250222233627.3yx55ks5lnq3elby@airbuntu>
References: <20250213091554.2593-1-xuewen.yan@unisoc.com>
 <20250213091554.2593-2-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213091554.2593-2-xuewen.yan@unisoc.com>

On 02/13/25 17:15, Xuewen Yan wrote:
> Because the static_branch_enable() would get the cpus_read_lock(),
> and sometimes users may frequently set the uclamp value of tasks,
> and the uclamp_validate() would call the static_branch_enable()
> frequently, so add the uclamp_is_used() check to prevent calling
> the cpus_read_lock() frequently.

FWIW original patch was doing such check but it was taken out after review
comments.

Is something like below completely broken instead? I think uclamp usage isn't
unique but haven't really audited the code to see if there are similar users.

I think it is a valid pattern to allow and the expectation was there shouldn't
be side effect of calling this repeatedly.

Good catch by the way.

--->8---

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8..17583c98c447 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -214,6 +214,13 @@ EXPORT_SYMBOL_GPL(static_key_enable_cpuslocked);

 void static_key_enable(struct static_key *key)
 {
+       STATIC_KEY_CHECK_USE(key);
+
+       if (atomic_read(&key->enabled) > 0) {
+               WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
+               return;
+       }
+
        cpus_read_lock();
        static_key_enable_cpuslocked(key);
        cpus_read_unlock();
@@ -239,6 +246,13 @@ EXPORT_SYMBOL_GPL(static_key_disable_cpuslocked);

 void static_key_disable(struct static_key *key)
 {
+       STATIC_KEY_CHECK_USE(key);
+
+       if (atomic_read(&key->enabled) > 0) {
+               WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
+               return;
+       }
+
        cpus_read_lock();
        static_key_disable_cpuslocked(key);
        cpus_read_unlock();

--->8---

> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/syscalls.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 456d339be98f..d718fddadb03 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -368,7 +368,8 @@ static int uclamp_validate(struct task_struct *p,
>  	 * blocking operation which obviously cannot be done while holding
>  	 * scheduler locks.
>  	 */
> -	static_branch_enable(&sched_uclamp_used);
> +	if (!uclamp_is_used())
> +		static_branch_enable(&sched_uclamp_used);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 


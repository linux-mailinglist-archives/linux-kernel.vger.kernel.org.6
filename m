Return-Path: <linux-kernel+bounces-530273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F605A4313D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1B6189666F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB020E001;
	Mon, 24 Feb 2025 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ZGzbrsE/"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED01D7E54
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440720; cv=none; b=maeYDtGbHj1py1EPkKfuxcmhR6h16aOSxDj6V+i8nKbk29fIZnr09ekdnaLEIzKdpetDT9SmcHOodUvvm3Oe45elgyOZ5Htf/UvIWK8gcT4nGP0lbjgbeLE1ZiGLTkHoevbGy9+ecL4tRjJRAdgNefXZdYEW9zqqaY07BuXp75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440720; c=relaxed/simple;
	bh=xAegAxFq0GvlausBFv15EEAKthHBVKAncgo8H+gNRAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEcRJ0wiCWK/mWKSshp0xQQNErc5EF1MgYxOg2/yPvvKhKujXQecHN8i7+pq8JJ7KGzjAhZt1VDEGf7/fv9Fxwb0OqhBn7pMeZmLtCHWT41/42oH9CNtbSTwFyjtVT5LMwTmVgQhqyBnaEKmkm7bPYgwnKJcIjNwi+YkGIqkYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ZGzbrsE/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab78e6edb99so699707366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740440716; x=1741045516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHuXcLl5FbxCQGXP1zcjSvqriDX/ctvCCTeJqhG2C+k=;
        b=ZGzbrsE/0WvhMOSyjBExuEb5WIrJGzWAlhDlaoDsCet+zUMlmuA5tmpAAx9q/HHQNC
         g5YUrLnXzyoBUi3Pb9uFrz2wpnaeT839o3KejewwIwxishp7FpFy4NBKpCSEPGg5gdB3
         Y8qwk9GGH8flwHNlbyhDLWuV9AVKufK+F0hGbiFAXGRmLYT1uC8/hiwUszZaJDowPnO6
         9xK3OjicLZIVI9OQ+KBcjFvCyd6rbSWPCz/lXRTID88u9r80QH0bz1+r7mXczzG8u49S
         OGX+Uu9TqGGDLTX5zxh69pE/8LQKi1EcJXNIh4UZXUvK93zYMwBi1CMBU3Yyb4UHN7Vs
         9wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740440716; x=1741045516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHuXcLl5FbxCQGXP1zcjSvqriDX/ctvCCTeJqhG2C+k=;
        b=HiDlnD0UySadh6Cq+B7tu4Yh1QmZHlllfRTl7wOZfbtND091QVzAKSEjEzSFhpsxbl
         w1tPOSRzB4m3uQMtWxyNXKXL/BRO5sdd2jBFS4rY7Nw4gcL1ulelCidkqYTdNEB85SyO
         vA5UVNzMYrShFmblmlfRppCeB5n8HTV/WiUp66MNBIEL/TY7g5Fkf8ULJ/1axf0KPCeR
         paP3gzGqP7lrYcjqti8WvkvEXUydTyaMs8ez51IntjfZCWauBF/9+rLH1wIGixrN8dAG
         hmNXNFiYIfsjmWbAR+giatgyLjwlDgl1e/aZecJlJ213YbWIckovlDW+XCqVuKXW7YVV
         352A==
X-Forwarded-Encrypted: i=1; AJvYcCWfSGHIMgN8CFhFOxv4Ymbwcdxeb83vKLBpPZC1yKd0zp1N6rX4Bxly/xbPzYCwLqu1JkcS3IowVWALJy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPqTSOTH8OEknQ2t28JCuKec07ViTlYJUG3flhtpFgDOsbVJr
	8HjNrcrJKhZTqwvT6ct4devQhVSU95ma2DJU51WnCCoeoFmyVcIB64ia/6pKPpw=
X-Gm-Gg: ASbGncs7UPWyN4XmJLGSKYyXowIgVrymSOPe6luRKnDptiimw2heYOrIpxOk132Zpu9
	AQlY1tYdrPCas4AJSeULPLmKy/yyjYUcrNfaBOzSc/znQOWYy4/z4VVRqWhfS/LDUwbRjNZUD6Y
	EEZvC4iw8JdFLBDkUzHpJ7vrgp4OT5tPARPkxSXnNlDeDm3/M+eGD/IXYlecABUSXE84CQ1PsE9
	YscrU1imzSOQ2RmDQ+4NX2yqvVkRgZPWspkqpIqueZKssb+sXOMosZDD1hE1qaLyLWaGh6xvSpo
	k4rxF8wU6TNBs5avf0g8
X-Google-Smtp-Source: AGHT+IEbGqH3QeJirDQ9icsZHCnzR3dgZi3dZjvoipNqs8tR3XIPOHIqFfWnsmMtSIIR62RT//KmMQ==
X-Received: by 2002:a17:907:2d08:b0:ab7:def3:ca1d with SMTP id a640c23a62f3a-abc09e44f67mr1688674166b.49.1740440716416;
        Mon, 24 Feb 2025 15:45:16 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2053ebbsm39405466b.139.2025.02.24.15.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:45:16 -0800 (PST)
Date: Mon, 24 Feb 2025 23:45:11 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, christian.loehle@arm.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hongyan.xia2@arm.com,
	ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
Message-ID: <20250224234511.godsizj7kuv7zrtl@airbuntu>
References: <20250220055950.4405-1-xuewen.yan@unisoc.com>
 <20250220055950.4405-2-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220055950.4405-2-xuewen.yan@unisoc.com>

On 02/20/25 13:59, Xuewen Yan wrote:
> Because the static_branch_enable() would get the cpus_read_lock(),
> and sometimes users may frequently set the uclamp value of tasks,
> and this operation would call the static_branch_enable()
> frequently, so add the uclamp_is_used() check to prevent calling
> the cpus_read_lock() frequently.
> And to make the code more concise, add a helper function to encapsulate
> this and use it everywhere we enable sched_uclamp_used.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> ---

[...]

> +/*
> + * Enabling static branches would get the cpus_read_lock(),
> + * check uclamp_is_used before enabling it. There is no race
> + * issue because we never disable this static key once enabled.
> + */
> +static inline void sched_uclamp_enable(void)
> +{
> +	if (!uclamp_is_used())
> +		static_branch_enable(&sched_uclamp_used);
> +}
> +

As I indicated in [1] I think the pattern of repeatedly enable is actually sane
and what we probably should be doing is modify the static_key_enable() logic to
do the early bail out logic outside of the lock. I had this code this way FWIW
initially and Peter asked for it to be called unconditionally instead.

I think repeated calls to static_key_enable/disable() should be made cheap and
I don't see a side effect of _replicating_ the early bail out logic outside of
the lock so that if we have already enabled/disabled we just return immediately
without any side effect (holding the lock in this case). I agree the hotplug
lock is ugly and if we can avoid touching it when we don't really need to that
would be better.

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

[1] https://lore.kernel.org/all/20250222233627.3yx55ks5lnq3elby@airbuntu/


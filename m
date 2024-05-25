Return-Path: <linux-kernel+bounces-189410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFC8CEF94
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F38B2817FB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32FA5FBB9;
	Sat, 25 May 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PzB2Qpdb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446865A109
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649139; cv=none; b=dfz1llRQRowXnqCZf0YrBfJAx0oNkbadIZUHEx+CBUvjD71DU9Gl5qWjfxjdOOKJvYuJ55+mOfMnfReRaacd6/LKPA9pFXKFRWAGfxQjEVfgFuNuB9gss0lZ7XTKmvWHpT2s2g3w9Tye2lHbaK6aLbO+XDMQG41eI+CjfItNGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649139; c=relaxed/simple;
	bh=ctVivX1+W8q8tZAHLWU5NkBdoFQr7AVs+kpkVYw/Sks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxkqv0WNsHVMX26reQbse7Xt5xkkvJ6H9HkbrsgrPrDDhik9aW2HqgctsRON8cA1f5wC7fB7my0rgBH/HxPvMW3GJRB6p/Fb3KnmNSLxEVwlnBBDspU620SYYAs+2EzvIOI/M3ghWYNNth4XrB9E4tdMbZDhdnv+1UZQL0D7RqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PzB2Qpdb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f33d84eaefso21356085ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716649136; x=1717253936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHPLiXIsNVv4WuCaS7ekbfM/TDyHyeP6QTh2jB8T2ME=;
        b=PzB2QpdbpXrjVI/2JJ3DKRcOBW57Uv768YQpjJCsWeu7BFbco0Gb324apd7IT2bIhL
         IfFwbKBvuil0A95nf0VPkms8zTcK9JwCnROqBZtykFRHbNef6qejOw0THrXf4zP38UmJ
         zzWoUvOY3W+HLqfNGo3CmxbOvZTtvTh2f2nTnyJ4nf51sWcIiiT10n9kFg1yDMCY6fnq
         FBx3Hx59FF1ol3xTuYg8Z2K1fEszEXCZ6X1E6PJ0QsdI+EuYOzJtRze+mY5ym0jZrE7v
         b+GX1kS0G5pSOVbgDE54aeTdLu3IghBeCW/0qHl8etP9IbSup5EcHEI9aAuBPs/3DwDu
         /WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716649136; x=1717253936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHPLiXIsNVv4WuCaS7ekbfM/TDyHyeP6QTh2jB8T2ME=;
        b=w1DrTO2f8a9CyahNunVF5vGtEg9kZmw+24Oc29ANOwsHQxHPqM+VWO4TwzLbFVdjcv
         afTElpVrk+j94HTMrPVVQDixhiG25Bcecj/tLbHlRolLknYnPJjluLIPXZYvQUzXLKQG
         Thsmsr72PsG4s6zh5eJnPzw1cmYb1kSZfg5cAObGetru9QZQCUaymQw7CgnNeLJ6vgXs
         RjPP5XbVdjd3yqTNxZlUzJImS2BSwfMQhlepQZx6Wu3gW4cbQPtQul7IuE/TYuSl5bDD
         fmSGgTbGhW1lAbAy321iBQSL+xz5+tl5fZyVtSMiYcGUDvVe5On6wpPHXlwhHb1D+9Pj
         NFqw==
X-Gm-Message-State: AOJu0Yz/rsQ/tGH0vv+8IYFgoYJgS1EPHUMZ8OcMiVmqI5EXoJWoGyek
	cvBicpcHVKjMFXuSO+jXJeM1Z2LRUMaD/V3N0vpZaO0aB7/9qcY/OCe7fT5H0rg=
X-Google-Smtp-Source: AGHT+IE03GMYuk9QPTabQ7daTxznFXxYjLRuev4Y2EV4xRnc0qFc+uwYRzpHC2RHLd7qjKUqZYKgHA==
X-Received: by 2002:a17:903:32cb:b0:1f3:52fe:4497 with SMTP id d9443c01a7336-1f4487438d7mr86026535ad.32.1716649136320;
        Sat, 25 May 2024 07:58:56 -0700 (PDT)
Received: from [10.254.221.56] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a9659sm31193515ad.228.2024.05.25.07.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 07:58:55 -0700 (PDT)
Message-ID: <e6f2e188-5354-4e2a-814c-e8781507fef1@bytedance.com>
Date: Sat, 25 May 2024 22:58:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux kernel bug] KASAN: slab-use-after-free Read in
 pressure_write
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, tj@kernel.org,
 syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
References: <CAEkJfYMMobwnoULvM8SyfGtbuaWzqfvZ_5BGjj0APv+=1rtkbA@mail.gmail.com>
 <q7lfvwrjrs3smyoyt5pyduv5c7hmmgv2mgo6ns3agbjaxawoso@24dbbmumc7ou>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <q7lfvwrjrs3smyoyt5pyduv5c7hmmgv2mgo6ns3agbjaxawoso@24dbbmumc7ou>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/5/25 00:03, Michal Koutný wrote:
> On Fri, May 17, 2024 at 03:14:23PM GMT, Sam Sun <samsun1006219@gmail.com> wrote:
>> ...
>> We analyzed the root cause of this problem. It happens when
>> concurrently accessing
>> "/sys/fs/cgroup/sys-fs-fuse-connections.mount/irq.pressure" and
>> "/sys/fs/cgroup/sys-fs-fuse-connections.mount/cgroup.pressure". If we
>> echo 0 to cgroup.pressure, kernel will invoke cgroup_pressure_write(),
>> and call kernfs_show(). It will set kn->flags to KERNFS_HIDDEN and
>> call kernfs_drain(), in which it frees kernfs_open_file *of. On the
>> other side, when accessing irq.pressure, kernel calls
>> pressure_write(), which will access of->priv. So that it triggers a
>> use-after-free.
> 
> Thanks for the nice breakdown.
> 
> What would you tell to something like below (not tested).

Thanks for the detailed report analysis and this fix patch.

I can still reproduce the UAF problem with this patch by running:

terminal 1: while true; do echo "some 150000 1000000" > cpu.pressure; done
terminal 2: while true; do echo 1 > cgroup.pressure; echo 0 > cgroup.pressure; done

Because we still access kernfs_open_file in pressure_write() before cgroup_mutex taken.

It seems like a problem with kernfs_drain()? I think it should make sure no active users
of kernfs_open_file when it returns, right? Will take a look again.

Thanks.

> 
> Regards,
> Michal
> 
> -- >8 --
> From f159b20051a921bcf990a4488ca6d49382b61a01 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
> Date: Fri, 24 May 2024 16:50:24 +0200
> Subject: [PATCH] cgroup: Pin appropriate resources when creating PSI pressure
>  trigger
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Wrongly synchronized access to kernfs_open_file was detected by
> syzkaller when there is a race between trigger creation and disabling of
> pressure measurements for a cgroup (echo 0 >cgroup.pressure).
> 
> Use cgroup_mutex to synchronize whole duration of pressure_write() to
> prevent working with a free'd kernfs_open_file by excluding concurrent
> cgroup_pressure_write() (uses cgroup_mutex already).
> 
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Fixes: 34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface")
> Reported-by: Yue Sun <samsun1006219@gmail.com>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  kernel/cgroup/cgroup.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e32b6972c478..e16ebd0c4977 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3777,31 +3777,30 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
>  	struct psi_trigger *new;
>  	struct cgroup *cgrp;
>  	struct psi_group *psi;
> +	ssize_t ret = nbytes;
>  
>  	cgrp = cgroup_kn_lock_live(of->kn, false);
>  	if (!cgrp)
>  		return -ENODEV;
>  
> -	cgroup_get(cgrp);
> -	cgroup_kn_unlock(of->kn);
> -
>  	/* Allow only one trigger per file descriptor */
>  	if (ctx->psi.trigger) {
> -		cgroup_put(cgrp);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;
>  	}
>  
>  	psi = cgroup_psi(cgrp);
>  	new = psi_trigger_create(psi, buf, res, of->file, of);
>  	if (IS_ERR(new)) {
> -		cgroup_put(cgrp);
> -		return PTR_ERR(new);
> +		ret = PTR_ERR(new);
> +		goto out;
>  	}
>  
>  	smp_store_release(&ctx->psi.trigger, new);
> -	cgroup_put(cgrp);
>  
> -	return nbytes;
> +out:
> +	cgroup_kn_unlock(of->kn);
> +	return ret;
>  }
>  
>  static ssize_t cgroup_io_pressure_write(struct kernfs_open_file *of,


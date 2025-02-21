Return-Path: <linux-kernel+bounces-525264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E4A3ED4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80616702473
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDBE1FECDD;
	Fri, 21 Feb 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="X+cZ+HOa"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B71FBCAF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122548; cv=none; b=sSdVau32tJqz/SjBNFwom2vXZ37l5AkN1ojZlMrAFwz9jOO7Z+abmixK1AM2IajX0EwlGlGErrsnzfVbrQNkIHVfgWFDzVxAGVe/xFUUezMXkz/RQbrPU8ApZcbDfuPKF96YfSRnizb5OMw+9YuH/PGToxWjjNcVECS2j/PEuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122548; c=relaxed/simple;
	bh=4galSgFsGYnT0uNc+01/qw+khY3O4Ie+lbzxyIfHweU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9ZB6kMwddDc+bvFtJNjH4aMJ683e22bRlA6kK4jThNd+IVpqVn4wE721TZtiowwkNFo9KvMn3JTHC6rcDoHlJ73YphZ9P/AEb4nfX/482Rn58fJh2+MLT4IRSMeUmZF2VRB2dM9jDSYLkm5q/av6f1Vkc+4JwlKF1UygKhaNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=X+cZ+HOa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so3702923a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1740122546; x=1740727346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRn7UMgJJ9CtP4bx+5Tz5wQQz9tVQhHMiwxX40kg0Xg=;
        b=X+cZ+HOa+Z7Ex+HP/2LKnwrdyMkpC79e3ZZvxZ59jJHUDy1afmBaQ1c3aP3pkEvVW7
         rWbhY06jomj1+rdP1EhyGSKwNOf5BKvxkiL/AmeH28a3yr8F4FaJySHWmiEbCaTVqHvw
         GkookkdobfrnonhIdEOrhQ7ZEsZLx/yxiASPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740122546; x=1740727346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRn7UMgJJ9CtP4bx+5Tz5wQQz9tVQhHMiwxX40kg0Xg=;
        b=qWYb5pWUfD9v0ZYz1n0hpox7TyKeBvyFBON5zZAQzeORu4DRgBXD5ECPVdlYK6djFO
         UutwIqhpQKyw7hol8vn7zHPRjSCZ9IBjIVcc54eD5e5Ya+ni2ZFKBpQ0o085OILFmiPJ
         LKIgUCa1BlvE9z+bY5z55GLESGf9GQyuJuiiE14EPSaS22Tvdng2YVNVJ0CpkLWcarQu
         6Sfi0cUbfjNzKPWd16DWetdcn3Mii3EiLPg4O/XttODj4Zpd9Aa7X+WJuTcAXYL7C1if
         BHOSFS7wfWwCo0ynMCcYs6tjq2ZyCujywqbxTiO/18CRLllFfBSKGPEhSD+2b2eHGEY1
         4QqA==
X-Forwarded-Encrypted: i=1; AJvYcCWARkwEup9VOidltCllpDrTNxAy1s9QVWkEgCvNFl/mCbn2R7vURFhEKrPQZo20RocmbpndQfEmbMhj0/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvAgplxSHBGPz6Vcz2x7yrD1Gfi4yAxpeklKlRxuInlW6DHGhV
	9/WhPu6xBRKl0zTy0gf2jrUm9JqaXBqcmcRTUFFLLDLOHYsWscVEgbWWmq9nW7Y=
X-Gm-Gg: ASbGnctI6ZLU13PywtWOU86tZOhLs0Lzjp9Zr3YGTdD5Eql1cqzps0fnQ7iYk/DaPgw
	uKPssOBJgRL/rpTQFfy+EC32ZdTByZtovCr7uu3PC/l190NUZ0C5vi8/PFa62ntW0Yizeltr95u
	DfK4fxz1whvLo+s+0vMZea1K9/HuNIlE0GBxRL1szB4gNapXMvAVfyDDGz8LSjP4uOxgqJVlqsX
	nBxRBR/ugmbbatsc0y01w8j6YjyWvDwo0RyedYAURfieWoamRYvIeZxzWRu4kE7rEOUpJsTAG1U
	0lhzZKgynJ9VqOwrEzM5JttPg9wX7+mvrjJlR67F5zQM4C6G
X-Google-Smtp-Source: AGHT+IHh2Jn2AbD/Xc3leYv4f4sD8+CODyddXbAeGCIOTPj+/WjLB0AGCue5w5SMMye8xoI4pyZTrQ==
X-Received: by 2002:a05:6a00:810:b0:730:74f8:25c1 with SMTP id d2e1a72fcca58-73426d82a0emr2893395b3a.15.1740122545961;
        Thu, 20 Feb 2025 23:22:25 -0800 (PST)
Received: from localhost.localdomain ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73413894baesm2848276b3a.153.2025.02.20.23.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 23:22:24 -0800 (PST)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: chunjie.zhu@cloud.com
Cc: agruenba@redhat.com,
	andreas.gruenbacher@gmail.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] fix gfs2 umount timeout bug
Date: Fri, 21 Feb 2025 07:21:13 +0000
Message-Id: <20250221072114.69344-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219040854.46062-1-chunjie.zhu@cloud.com>
References: <20250219040854.46062-1-chunjie.zhu@cloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The time ordered events,

IO app -> do_xmote -> gdlm_lock -> gfs2_glock_complete (ret is CANCEL) ->
__gfs2_glock_queue_work

kworker A -> glock_work_func -> finish_xmote -> gfs2_holder_wake ->
-> retry do_xmote (set GLF_LOCK flag) -> gdlm_lock (DLM does not invoke
GFS2 callbacks) -> run_queue (do nothing as glock has GLF_LOCK flag)

glock refcount is 1

umount -> clear_glock (refcount +1) -> glock_work_func -> run_queue (do
nothing as glock has GLF_LOCK flag) -> refcount -1

glock refcount is 1, still in memory

> 
> INFO: task umount:75342 blocked for more than 483 seconds.
>       Not tainted 6.6.22+0 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:umount          state:D stack:0     pid:75342 ppid:75335  flags:0x00004002
> Call Trace:
>  <TASK>
>  __schedule+0x3a0/0x1330
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? srso_alias_return_thunk+0x5/0x7f
>  schedule+0x53/0xc0
>  schedule_timeout+0x76/0xf0
>  ? __pfx_process_timeout+0x10/0x10
>  gfs2_gl_hash_clear+0x135/0x140 [gfs2]
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  gfs2_put_super+0x175/0x220 [gfs2]
>  generic_shutdown_super+0x7e/0x170
>  kill_block_super+0x16/0x40
>  deactivate_locked_super+0x2f/0xa0
>  cleanup_mnt+0xbd/0x150
>  task_work_run+0x60/0xa0
>  exit_to_user_mode_prepare+0x117/0x120
>  syscall_exit_to_user_mode+0x22/0x40
>  ? srso_alias_return_thunk+0x5/0x7f
>  do_syscall_64+0x67/0x80
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? syscall_exit_to_user_mode+0x27/0x40
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? do_syscall_64+0x67/0x80
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? syscall_exit_to_user_mode+0x27/0x40
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? do_syscall_64+0x67/0x80
>  ? syscall_exit_to_user_mode+0x27/0x40
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? do_syscall_64+0x67/0x80
>  ? do_syscall_64+0x67/0x80
>  ? do_syscall_64+0x67/0x80
>  ? exc_page_fault+0x72/0x130
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x7fb0823ebeab
> RSP: 002b:00007ffcd0d45b68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007fb081257000 RCX: 00007fb0823ebeab
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fb081219980
> RBP: 00007fb081257118 R08: 0000000000000073 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fb081219980 R14: 0000000000000000 R15: 00007fb081257000
>  </TASK>
> 
> > 
> > > Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
> > > ---
> > >  fs/gfs2/glock.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > > index 4a280be229a6..bf2445f0afa9 100644
> > > --- a/fs/gfs2/glock.c
> > > +++ b/fs/gfs2/glock.c
> > > @@ -2120,6 +2120,23 @@ static void thaw_glock(struct gfs2_glock *gl)
> > >         gfs2_glock_queue_work(gl, 0);
> > >  }
> > >
> > > +/**
> > > + * IOPEN glock might be a zombie glock instance due to lock contention
> > > + * between nodes in the cluster during fs umount, then it causes umount
> > > + * timeout
> > > + */
> > > +
> > > +static int is_zombie_glock(struct gfs2_glock *gl)
> > > +{
> > > +       if (test_bit(GLF_LOCK, &gl->gl_flags) &&
> > > +               test_bit(GLF_DEMOTE, &gl->gl_flags) &&
> > > +               test_bit(GLF_BLOCKING, &gl->gl_flags) &&
> > > +               (gl->gl_name.ln_type == LM_TYPE_IOPEN) &&
> > > +               list_empty(&gl->gl_holders))
> > > +               return 1;
> > > +       return 0;
> > > +}
> > > +
> > >  /**
> > >   * clear_glock - look at a glock and see if we can free it from glock cache
> > >   * @gl: the glock to look at
> > > @@ -2132,7 +2149,8 @@ static void clear_glock(struct gfs2_glock *gl)
> > >
> > >         spin_lock(&gl->gl_lockref.lock);
> > >         if (!__lockref_is_dead(&gl->gl_lockref)) {
> > > -               gl->gl_lockref.count++;
> > > +               if (!is_zombie_glock(gl))
> > > +                       gl->gl_lockref.count++;
> > >                 if (gl->gl_state != LM_ST_UNLOCKED)
> > >                         handle_callback(gl, LM_ST_UNLOCKED, 0, false);
> > >                 __gfs2_glock_queue_work(gl, 0);
> > > --
> > > 2.34.1
> > >
> > >
> > 
> 


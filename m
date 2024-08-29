Return-Path: <linux-kernel+bounces-306449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69182963F28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25930282519
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A5A18F2D8;
	Thu, 29 Aug 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWdSdLbi"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24C18E777
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921551; cv=none; b=gH92yO68bc/iJ9SlQ4pndtIqrzv12wMU1ztrafKm3P7yo7ONM8OVJahjS7SKGsW6OCxGiIVQz8/HI2s7Q0ONYQnICeR4TEaVqs4KR40Ic0h0nB3DL+IbHPRFc4qDpa0DKYc9VL2V8oGOugl5EG1ePrPDqijdebdlLhN8zrzZCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921551; c=relaxed/simple;
	bh=KkNlhVv3Q/VfiwEJlxV+ZPpZwEyj8cXQeIJIzMYuGLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=std3W24p6QzG08iSrsTT1iOlEZYO1K5iuUMNupV6I/GckN/oGjzTS5oUVndXVBY253766BTMtFRFKhxBbee5dfojNbDFjx+zS8JK7eq9dosHv9eaaR9Y27mpzFqk3UAoQoTid6+3NodIhA7NEEOdJzSUrgWS2Jov+y+ISLVPX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWdSdLbi; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6b99988b6ceso5097917b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724921549; x=1725526349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7/1ZV+TTP/H+35MntJnEwdMvctEZwmsC3otfByUruA=;
        b=eWdSdLbidwC6vAH19BPxypTqp+RdolH1y4Y/qyd7ulgo9cVGfjD2rl2HhAzBFTXWi4
         7gUSQN8IemBO07GSE2oqBQpFtnZuc+QC8Ls4duySxwlC8e79gg8SdYa4amEJrBuB76Jv
         E3kwZw8yR/spRYCydXUiOYhlidWUyjSrDuKqqh7nil9YpWjMoNcUnpsXP/bLkvBzY7X7
         9fKnXZgOqfrwStqnNW2GPNW28N1fmz81ajlsih8oan+5vjReuBPZ4T1gfPu3xeEt0TLn
         btjAxvh++YLcPqPWIiprgr5bIR17sExXFhj6Dl2eq/UbtpeWoTbCxAimN8WviVRuYnaB
         sbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921549; x=1725526349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7/1ZV+TTP/H+35MntJnEwdMvctEZwmsC3otfByUruA=;
        b=gecfmR55EgkMAK9NCvwcxyAnJLtr5bx54i0jjP9PSX76y5zN2mh6mMqJPuvlS0NApE
         9F2EFei2NjaUYZLu+rgWxPF84ujGG5/Zmk+GFHWO89y19aPF+YM5GQIGj3SYEylerKHR
         lbo5YpDmpHGecxg3b+3nwmQJJ41xh67KS1atpEn/+RE+luaiJ4eFr3WDxWVFVIZtMmn4
         Wv5b4oq7B+gvO0HiqarUOcjcrIuSb5I2awBAHAiKM2YOoXVgc46opJDBR8mk2vlrYgCu
         LRz+oYA8KuWtIEQ0sYW//HQlLqK5+IJAWf/RAvrNgaCRNYTPOL+4FaRvHgOQrbxmy/IH
         TSFw==
X-Forwarded-Encrypted: i=1; AJvYcCVTSHF8hxq1zX7J1aKOIKrOPrGm28qMlWiI02pFOsKU4FLn1WDbtEbj140aHKrjV2U1ffvADHvFtR5fsWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bQu5fkwcVcoZO4Ik0OoM1m4mTi2DR0jfu7RFjL7kXg0xPWV7
	BGM2o84f2Y9EIvOaZlRPs4JfNq/6yj5PNRbSCRCXCeaVQ7AG+SAsKr2ZdGGrsQ+//6tLtJQTuWd
	OA3FjOKRUjDbI3ccjHPKg1bl9XQY=
X-Google-Smtp-Source: AGHT+IH0rKH2Y7H7yqRscVf6oQj23ElkeMPK1xGa9VBXeDUx6I5zG63Q6e+gLa9EB5HfYeW3E0+Cr/w4HQpxB1sR6/g=
X-Received: by 2002:a05:6902:e12:b0:e17:be1c:ab1f with SMTP id
 3f1490d57ef6-e1a5aca0c87mr2316857276.27.1724921548682; Thu, 29 Aug 2024
 01:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJqJ8ih+pamx2o1tvd+w-G+THb_wSvOPP=5RqHt82x96N=yKRQ@mail.gmail.com>
In-Reply-To: <CAJqJ8ih+pamx2o1tvd+w-G+THb_wSvOPP=5RqHt82x96N=yKRQ@mail.gmail.com>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 29 Aug 2024 16:52:18 +0800
Message-ID: <CAJqJ8ii0kJQbXUrtuZteFDd2JUCwJMY-9ysMdoCL_tbsu+6EnA@mail.gmail.com>
Subject: Re: [PATCH] mm/mglru: wake up flushers when legacy cgroups run out of
 clean caches
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Alexander Motin <mav@ixsystems.com>, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I apologize for the half-dozen duplicate messages.  I was having a
difficult time configuring git to send email and didn't realize the
messages were actually getting delivered.

Ed

jingxiang zeng <jingxiangzeng.cas@gmail.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=
=8829=E6=97=A5=E5=91=A8=E5=9B=9B 16:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering
> OOM when encountering many dirty pages during reclamation on MGLRU.
>
> This leads to premature OOM if there are too many dirty pages in cgroup:
> Killed
>
> dd invoked oom-killer: gfp_mask=3D0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRI=
TE),
> order=3D0, oom_score_adj=3D0
>
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5f/0x80
>   dump_stack+0x14/0x20
>   dump_header+0x46/0x1b0
>   oom_kill_process+0x104/0x220
>   out_of_memory+0x112/0x5a0
>   mem_cgroup_out_of_memory+0x13b/0x150
>   try_charge_memcg+0x44f/0x5c0
>   charge_memcg+0x34/0x50
>   __mem_cgroup_charge+0x31/0x90
>   filemap_add_folio+0x4b/0xf0
>   __filemap_get_folio+0x1a4/0x5b0
>   ? srso_return_thunk+0x5/0x5f
>   ? __block_commit_write+0x82/0xb0
>   ext4_da_write_begin+0xe5/0x270
>   generic_perform_write+0x134/0x2b0
>   ext4_buffered_write_iter+0x57/0xd0
>   ext4_file_write_iter+0x76/0x7d0
>   ? selinux_file_permission+0x119/0x150
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   vfs_write+0x30c/0x440
>   ksys_write+0x65/0xe0
>   __x64_sys_write+0x1e/0x30
>   x64_sys_call+0x11c2/0x1d50
>   do_syscall_64+0x47/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>  memory: usage 308224kB, limit 308224kB, failcnt 2589
>  swap: usage 0kB, limit 9007199254740988kB, failcnt 0
>
>   ...
>   file_dirty 303247360
>   file_writeback 0
>   ...
>
> oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3Dtest,
> mems_allowed=3D0,oom_memcg=3D/test,task_memcg=3D/test,task=3Ddd,pid=3D440=
4,uid=3D0
> Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
> anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
> oom_score_adj:0
>
> Wake up flushers when legacy cgroups run out of clean caches.
>
> Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: kasong <kasong@tencent.com>


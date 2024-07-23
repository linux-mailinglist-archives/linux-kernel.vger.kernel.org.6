Return-Path: <linux-kernel+bounces-259593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6081939914
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6CC1F228A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4875013C66A;
	Tue, 23 Jul 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Oa1mp4Ba"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB82367
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721711266; cv=none; b=H9xSfGSm64vAYH6DpM73vEWZlVcuiACYkenr2wVtmOMIoQNsNayHC7H9NwvAb0CcZCSj1flOPIccXwWBJdQL64hezHlGlp1/6O++4EWD5YE44+Vpa8xCYeVGWXtkHGqzaPr01hJ92GMQRTrtAABcj1fkfUZfZzumFDmxVX+XD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721711266; c=relaxed/simple;
	bh=ScUsUPQLyvuI9fmzUnN9Iat2cSjsGjts8bu7FZwud/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3IWpetYBELY46w9FufHoNblH6UZVw57OpQRJe054mvfOT3rMnVKijPegkW12KzxLHVD0aHm5+LxRKhqqdcxjjU4LH0ntH76a6Q4FevoFOrPpvdp/uVc8tbroiIr9EKSy0Ma5I0G50v2frVNmlWCn8kSbj5JHgjd8UmNNWG43yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Oa1mp4Ba; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ef95ec938so3007674e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721711262; x=1722316062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsnSC07zfIXon19YhC/42Be/Z1ql1w+JDYlQwMaAxqs=;
        b=Oa1mp4BaIAe4Du8dwrhDeUQaPr3Q8wE7W5Cbcv+GAqXhEf73+ovVrvp4+V30c7e4js
         Y3SWQPigTj79qn258JOUJv+cc2p0gqZ8hLtH6gMoNG3t+CkFlX+sSYQ7MiSS48tVy7GX
         lSW9A0ijJpMJVqHg2rDH2jLDKJDz5A5TwvdOQyTWsnYxZ+s/j+dEpF5kr/DGBXHjKBLx
         CgKWcrr8xMTc4lXxie13ZEVMakNZ5nDCHOqgIshMAmPKQOVokzHS46IsJKSJRoUYyEzm
         Oi3dIIJr0NWdA6Od3YWESbx8N0yk06PFWTNxfVJ3sj0GttyiBpOHm92fFNQGUklirIV6
         9Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721711262; x=1722316062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsnSC07zfIXon19YhC/42Be/Z1ql1w+JDYlQwMaAxqs=;
        b=bsvZusbYxBpqlIGoiM8xRp63wdrOergEiWET7dOc9jxn7gpQmLyaIYpPoUVuybakm/
         Wkw6Nkpu4cKkqQNFPYsRmIuCSyBN/uKa4KwXwIu4g3RjzpY4SVdcoAKcOuNaZgr+pbVJ
         96q1zHmc9OE4Ao3Rihc3H/FXaVe5kXvZ/L8d9jft8k8sLNfm8BJrLWs8YDf5p+cJmv1W
         JHS+tdbBou2a6fDe2vFyE/kp17AVGG3jpoRVruVb0jZ1VLh5OJ+sLsWHtVg0num/Ble6
         UN0PudSxRXvf/ZqwCPe+QuwjI5KRnRwwRT226uwF8feUiK5ue8QK+vpPunGRKvzIU9W9
         ilxg==
X-Forwarded-Encrypted: i=1; AJvYcCVC/ubz9DzarIRbStCMyOpNrfxzyhKWapCR4RCSzGaDMn/TxSJpf5iWXN3UvVU7uOwoQzgc7oXTCYE5AbomLDKssNL1D6HpRMyasHre
X-Gm-Message-State: AOJu0Yz1Ku4J6SYSkxV3tlGpz+x3ouAZ9qDkXeR7B4OxviHUS/IfGUgI
	UY3Cg4kPOxq0GRPaMV9wIS7NJPXg0txbHUEYISqZgXiDoDK/3wIqjUDNEsqZyiwACMsyJc3oyo4
	hU75AeNVLBp8cMTbv5F3GyvTzop1M4IEuQEC0oXv3skl2dGa0wqc=
X-Google-Smtp-Source: AGHT+IEDLM/hvVYGjh4KirEmCVgBGo17a2GPijRWstrrLWkCq0JOfdCb7BsajWqphfo72SH4chhZDajYtLUxYCsCVqg=
X-Received: by 2002:a05:6512:3e1e:b0:52c:c9bb:2ba4 with SMTP id
 2adb3069b0e04-52fc406f0b4mr1249711e87.46.1721711261978; Mon, 22 Jul 2024
 22:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722123320.2382992-1-hezhongkun.hzk@bytedance.com> <871q3kg4r1.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q3kg4r1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 23 Jul 2024 13:07:31 +0800
Message-ID: <CACSyD1OAj6W7FkSPwE3iY7UsJmH=d3TtvwQN0mtezKbznnaLUQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/numa_balancing: Fix the memory
 thrashing problem in the single-threaded process
To: "Huang, Ying" <ying.huang@intel.com>
Cc: peterz@infradead.org, mgorman@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 11:39=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Zhongkun He <hezhongkun.hzk@bytedance.com> writes:
>
> > I found a problem in my test machine that the memory of a process is
> > repeatedly migrated between two nodes and does not stop.
> >
> > 1.Test step and the machines.
> > ------------
> > VM machine: 4 numa nodes and 10GB per node.
> >
> > stress --vm 1 --vm-bytes 12g --vm-keep
> >
> > The info of numa stat:
> > while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
> > anon N0=3D98304 N1=3D0 N2=3D10250747904 N3=3D2634334208
> > anon N0=3D98304 N1=3D0 N2=3D10250747904 N3=3D2634334208
> > anon N0=3D98304 N1=3D0 N2=3D9937256448 N3=3D2947825664
> > anon N0=3D98304 N1=3D0 N2=3D8863514624 N3=3D4021567488
> > anon N0=3D98304 N1=3D0 N2=3D7789772800 N3=3D5095309312
> > anon N0=3D98304 N1=3D0 N2=3D6716030976 N3=3D6169051136
> > anon N0=3D98304 N1=3D0 N2=3D5642289152 N3=3D7242792960
> > anon N0=3D98304 N1=3D0 N2=3D5105442816 N3=3D7779639296
> > anon N0=3D98304 N1=3D0 N2=3D5105442816 N3=3D7779639296
> > anon N0=3D98304 N1=3D0 N2=3D4837007360 N3=3D8048074752
> > anon N0=3D98304 N1=3D0 N2=3D3763265536 N3=3D9121816576
> > anon N0=3D98304 N1=3D0 N2=3D2689523712 N3=3D10195558400
> > anon N0=3D98304 N1=3D0 N2=3D2515148800 N3=3D10369933312
> > anon N0=3D98304 N1=3D0 N2=3D2515148800 N3=3D10369933312
> > anon N0=3D98304 N1=3D0 N2=3D2515148800 N3=3D10369933312
> > anon N0=3D98304 N1=3D0 N2=3D3320455168 N3=3D9564626944
> > anon N0=3D98304 N1=3D0 N2=3D4394196992 N3=3D8490885120
> > anon N0=3D98304 N1=3D0 N2=3D5105442816 N3=3D7779639296
> > anon N0=3D98304 N1=3D0 N2=3D6174195712 N3=3D6710886400
> > anon N0=3D98304 N1=3D0 N2=3D7247937536 N3=3D5637144576
> > anon N0=3D98304 N1=3D0 N2=3D8321679360 N3=3D4563402752
> > anon N0=3D98304 N1=3D0 N2=3D9395421184 N3=3D3489660928
> > anon N0=3D98304 N1=3D0 N2=3D10247872512 N3=3D2637209600
> > anon N0=3D98304 N1=3D0 N2=3D10247872512 N3=3D2637209600
> >
> > 2. Root cause:
> > Since commit 3e32158767b0 ("mm/mprotect.c: don't touch single threaded
> > PTEs which are on the right node")the PTE of local pages will not be
> > changed in change_pte_range() for single-threaded process, so no
> > page_faults information will be generated in do_numa_page(). If a
> > single-threaded process has memory on another node, it will
> > unconditionally migrate all of it's local memory to that node,
> > even if the remote node has only one page.
> >
> > So, let's fix it. The memory of single-threaded process should follow
> > the cpu, not the numa faults info in order to avoid memory thrashing.
>
> Show the test results (numa stats) of the fixed kernel?
>

After a long time of testing, there is no memory thrashing
from the beginning.

while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0

I will add it to the commit in the next version.

> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > ---
> >  kernel/sched/fair.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 24dda708b699..d7cbbda568fb 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -2898,6 +2898,12 @@ static void task_numa_placement(struct task_stru=
ct *p)
> >               numa_group_count_active_nodes(ng);
> >               spin_unlock_irq(group_lock);
> >               max_nid =3D preferred_group_nid(p, max_nid);
> > +     } else if (atomic_read(&p->mm->mm_users) =3D=3D 1) {
> > +             /*
> > +              * The memory of a single-threaded process should
> > +              * follow the CPU in order to avoid memory thrashing.
> > +              */
> > +             max_nid =3D numa_node_id();
> >       }
> >
> >       if (max_faults) {
>
> The change looks reasonable for me, Thanks!
>
> Acked-by: "Huang, Ying" <ying.huang@intel.com>
>

Thanks.

> --
> Best Regards,
> Huang, Ying


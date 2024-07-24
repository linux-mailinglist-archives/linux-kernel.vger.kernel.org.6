Return-Path: <linux-kernel+bounces-260618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87693ABAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 05:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA041C228A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89E210FB;
	Wed, 24 Jul 2024 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fj++Nknd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DE4A00
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 03:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721793345; cv=none; b=VOjXzFK54x2wFQ1/19n8J4Qp3DDi9/gFd17oDMl5wbhyCzeQI08ksz+i79pc9CFH9s7jM1DbiBPa0D6MYs+RnFcCAR33aZs7SRX3oDDZF0Fhfhu7pSeOttXY65hwS25IkOLW0JBAKDFReLNAcLaTZg7X3UYJOcqAmn+X796qxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721793345; c=relaxed/simple;
	bh=4ksOoVaVe7rHculIIbRt5BA4iHzgyvC/kckkbHrLc+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHQ+co7hWnaNEwJArsq8JVaET7o+Ik0zMv7Ri5/HJDyDv5lmcOxJ+FJGXfP9MuDw2UHd0D6amPGvvJmAbhquzaJycxQ3xBtMqF8/ZlFrQZs/SS20DRS+AuCZpj/6m8GBN77LVC4+AKlKFVQLC2xAh+GBusu8nVHXmdNxXp00pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fj++Nknd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f04c29588so4066285e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721793342; x=1722398142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjW83MMgMNmNykm863/7zI9UniCx1U6HkyFOsE4xJeo=;
        b=Fj++NkndRtOgIICPBwEv3/IliN0PDBdO6IPrOQqyP2SnC3VltrA374BGxUVLthNhEe
         djfwuVdroInlu8uu/2XdVwKYpetGYt8Dv+yzmXzAM/P652tj5HvRiEj3DK9w5X2bgP+U
         WFkoBX1Y2ST3rxBad1gaI6MmfU/mHZ6TOJdXRD1NYVNqrKIvhFuLGTo6SV4ZVE1wHw35
         /AhQlJVCS2UgpmsBgd0Eqk96kfMqWRjmou3jrILTjuvzsbas70goH707SUOlwCoqaoRm
         RD3z9CdN7JLNv88KcLcvRYoh7ShN5dNqpImjn9AyJrgsIuUl9HIhwT6vByPZfY9Qd6QW
         uALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721793342; x=1722398142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjW83MMgMNmNykm863/7zI9UniCx1U6HkyFOsE4xJeo=;
        b=OwNlFJNqKapA5lq4r0KxUoFPZ0VKYe90dOnnePoJ+QRmcezyZry9RRxRy31xGMKAtI
         u53bSCy5JnXEGDnHn2Kv7uRKmEY0Cv1obU5QrYhMl2764fBZSxWv2CXvOK03rtYvxui4
         7HINzr8xUrhBd21klHSdIcSBp7Pnop41NSRaM030yvFILYETQowBGujHeePujoAOchNr
         UoNLFwpoDaIK3hyguK/kNixCzTxaBIxX9cgaqxc1zHtu+BCBxZvmBa1YSLyZtqIxGJSu
         wjcpuB3gcNmVQAdLwBqBonMUD2h6+Y7lbP97qw+uhzCLTfeEGs3HdeawEMxB7hCsxumB
         b/JA==
X-Forwarded-Encrypted: i=1; AJvYcCUfBAwP+QjMoZH46jkxyvtDRSO51LqunGnzxXSN5QrEfdJlIvr1jZyEH6V4KqG/U/w9ibq8Ig0MTnKjvaHwqAnv6mIoAb4hf+YyY3L+
X-Gm-Message-State: AOJu0YzOXZDkLYHTCsbMXe+zvRLaqUGnJ80F79dkftkhqWVT/Qt4gBSv
	5nopHyT2LpNJQB2wEivFErawrm+tH1M17lyeFlvrdKyYhsv+qMMUAoQNU+L6euLwAIi7ojWEaUu
	+oRDfwzbJorGPKsVw2ZT56CZPTvnGpwQ7Qk4niw==
X-Google-Smtp-Source: AGHT+IHEK8eWMDuG+P/puyBvh9nmKaBaWxBzZXX48bttB4uMjDGsoqa8ttv7WAuSIeFE+8u7Y1gl68i9+8i4nyAlx+Y=
X-Received: by 2002:ac2:4e05:0:b0:52e:f463:977d with SMTP id
 2adb3069b0e04-52efb79830emr7565710e87.20.1721793341889; Tue, 23 Jul 2024
 20:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com> <e3a75483-d3f7-4963-9332-4893d22463ad@bytedance.com>
In-Reply-To: <e3a75483-d3f7-4963-9332-4893d22463ad@bytedance.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 24 Jul 2024 11:55:30 +0800
Message-ID: <CACSyD1M_nqrOZh3CDqydaasX3_9JdsqDFQTqOZ+q-xkvNMY1Kg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/numa_balancing: Fix the memory thrashing problem in
 the single-threaded process
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: peterz@infradead.org, mgorman@suse.de, ying.huang@intel.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:39=E2=80=AFPM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Hi Zhongkun,
>
> On 7/23/24 1:32 PM, Zhongkun He Wrote:
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
>
> I am curious what was the exact reason made the worker migrated
> to N3? And later...

The maximum capacity of each node is 10 GB=EF=BC=8C but it requires 12GB,
so there's always 2G on other nodes. With the patch below we only
have page_faults in other nodes, not local. so we will migrate pages
to other nodes because p->numa_preferred_nid is always the other node.

>
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
>
> .. why it was moved back to N2?

The private page_faults on N2 are larger than that on N3.

>
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
>
> IIUC the remote pages will be moved to the node where the worker
> is running since local (private) PTEs are not set to protnone and
> won't be faulted on.
>

Yes.

> >
> > So, let's fix it. The memory of single-threaded process should follow
> > the cpu, not the numa faults info in order to avoid memory thrashing.
>
> Don't forget the 'Fixes' tag for bugfix patches :)

OK, thanks.

>
> >
> > ...>
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
> Since you don't want to respect the faults info, can we simply
> skip task placement?

This is a good suggestion. It would be even better if there were some
feedback from others.


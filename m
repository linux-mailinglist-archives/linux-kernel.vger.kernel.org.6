Return-Path: <linux-kernel+bounces-259673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67C939B44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E5F282021
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6413D248;
	Tue, 23 Jul 2024 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VXk5M26l"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB3130AC8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718038; cv=none; b=dkqv1bFSifgwMsLUmit5WTrtVZgc0iFXqz1zPKcl29HKRyky8RoqyTjV1vK+CU/tZG3ZaLVhSiwaGi8d0dEyeUs9RZe6/YoTnPgQzs+mHurTbSSrZSUjctBtmOYdoZ3OOIWBOMiq+sw8WrrowCL5/v6PRFahoXKJvlKu0oKwHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718038; c=relaxed/simple;
	bh=uLyMpoD36pYfh6Xekyli909yW7W8YSdCKFH4Xf1kIHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRtp8CWKoqqX1YRSldSHW4Vr3FEdSzBgxUftZqpHEd+lBOpG9YZdksYwwJNjORSJDXh3zJk2WPgvuiW88ZDpcljKlMpAdRA4ikjlRYAZ5GfqFWItgcuGi5zNIxMbpQxBhe2msL1+HvgjLw6VilieK/hLG30YQW44XtwAXI/DYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VXk5M26l; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso46132811fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721718034; x=1722322834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIJXylkwylAN7xSwKIRIAh2rHN1HRJEdfi0vWvEfVxQ=;
        b=VXk5M26lqFJjqnYVM6z4nhRI1aMfGOuo66q5oIfVlVwddnuBOp2mMcaeshs5vBvojX
         vKQx/ca3rHaWCHQ4zLhZRhXTORlj5K1FaFDYJTpXctGr34y/+NyqXVFjN0r1k0mEvMyV
         fpT63klDf/ICBXev+02w+TpkDSxsc3fghbBdhDPyUzMCn8T07kED1t/XgVQYx8RoznUx
         Lg8Hk25T7btrVMmQSfLz0iD9t/rB5eKrc+UtXIkOKZ2ZXszSbkoyCLtxwxcnF6i3TidS
         uw4iuqOizqA3+ndO35g5AKBju331whdXl3xWkp4xWXaN+EqKIECnevtaFaMDHoNr+YCy
         kc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721718034; x=1722322834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIJXylkwylAN7xSwKIRIAh2rHN1HRJEdfi0vWvEfVxQ=;
        b=i+K+tidMTKyqQ6Ww7mWLx9XHk1OTkUkIT9VahbHN2BKIBsh7NegS++TQe1BffQ47Es
         00Xx1Ym4XOi6bQpCFizR8+G6PJnRkDU5hLAhxuz5BQBMZ/nXLg+ebf9I0aOWn/f1OQK1
         LOAJXk2CcH6WF7NXk09I2kGBdZ8pl+Pz9kAxJDY6RkLGxfPMSAbc264qfWdX5YkwIdfs
         0NZFLCQstLb7Q4hxY1aI7cljkAF715NbfGojSusMTVPjXKqr0sgh753jqDnU+t/HF/k5
         Rh44yaGh47SKlHtXe/MhYAouVjEcAzciEmdGbErBdt77+R61SQiSocKyT8qLioiHhaaH
         ZlZg==
X-Forwarded-Encrypted: i=1; AJvYcCVd4SA/iu+ORUN5pRXS+F6S02WlqwnQlsnQGQyIzrF97hmYJ1cdhpaPGZgqraXSYMaAs1c0MUAeD67cp/uZrpbKsvmmpRpHVyYWDngX
X-Gm-Message-State: AOJu0Yw9LBPSCYySeVkzqnQBzY0SIcA/Cq4FoNvZt7AQG2KRv3X4lVZO
	b+cZNKjYbCnWWdpR4Qc2Q5be93AunndCqtXvtXkdLgLr+PDxiXQqrESYW12dQckiZGoLgFD+Uwb
	vsYX5qI7NlqZEDyJAe3J3Fqk7O6jUocsHP/8mgQ==
X-Google-Smtp-Source: AGHT+IG+GPWIOXgEAUmzqbdNseDLyBBswW0QMmqJxplQIZtkC+9KhmYVFci+9G56qnsnCEq1mvyVXPNXwvF1y9NOssA=
X-Received: by 2002:a2e:30a:0:b0:2ef:2e9b:c705 with SMTP id
 38308e7fff4ca-2f02103069cmr3307791fa.7.1721718033311; Tue, 23 Jul 2024
 00:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com> <ea121294-eeaf-42b1-bc1c-186f4ea7be1d@arm.com>
In-Reply-To: <ea121294-eeaf-42b1-bc1c-186f4ea7be1d@arm.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 23 Jul 2024 15:00:22 +0800
Message-ID: <CACSyD1MOe+vvz+PR+-L6kR0LbwVWGVKy=T-SvWtXpE0r0shqFQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] mm/numa_balancing: Fix the memory
 thrashing problem in the single-threaded process
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: peterz@infradead.org, mgorman@suse.de, ying.huang@intel.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 2:16=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 7/23/24 11:02, Zhongkun He wrote:
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
> >
> > After a long time of testing, there is no memory thrashing
> > from the beginning.
> >
> > while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> > anon N0=3D2548117504 N1=3D10336903168 N2=3D139264 N3=3D0
> >
> > V1:
> > -- Add the test results (numa stats) from Ying's feedback
> >
> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > Acked-by: "Huang, Ying" <ying.huang@intel.com>
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
> This in fact makes sense for a single threaded process but just
> wondering could there be any other unwanted side effects ?

Hi Anshuman,

This fix only works on a single threaded process because of the statement
'atomic_read(&p->mm->mm_users) =3D=3D 1',  so I don't think there's any oth=
er
effects.


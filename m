Return-Path: <linux-kernel+bounces-416170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D29D4136
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88F6281B80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3951B85CF;
	Wed, 20 Nov 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obHVI5SC"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14912BF02
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124039; cv=none; b=nQlzVloz6VGEFFPttFzHuqjaxTd1oZoX34Pm8pbwE4MgcGda8iGpq91mwxZgE8RNpxWRKpOFibYv+o4CVYKY1jpf3SUM4d7RIqvWqmmVSIU17pK2yvaZ0ttnY1bW6t7KCRHfqAQVW8xgBbh8tLYxH8fQA6+vItMl+dsQYY6vh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124039; c=relaxed/simple;
	bh=Qpu/AFEa2uG9HdS1pBVJ6cUxEzFgxChSm6OIAK9vj0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnmgltBpLqUqMRqGbJPaF76sXuomrUmIx5LJyy4eGXP5fZn1Xo+gMBb8LQR0m7rNjaLz6apQ6AvSYdpa9Hd7fbT6CuxVhESaKw+gnEdbnwjmzuO5bB+3r85bRDckIvVGFRJPRkc/ky0IuPt7tVkpk4jDSOjmi/cVFfKX1TLesFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obHVI5SC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6eebae6f013so17008707b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732124036; x=1732728836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYCCxRwoo4/e9pvHHukibz0lUEYL/K5Rpqldo2LsKi0=;
        b=obHVI5SC7ryDI3ZPz/Lt1cMnmqG1LNQ1B39f1RAePE4ygf1p8k76SIv2MQe3G5bY77
         vwZTERRU592Rt/qpSDFw0+GD/nvAc5TWGbN9Vwv6KQmyB70SYqhxGyRjJ3uqihyhsCX4
         /e69eLbgEGx2FBIX8D4uDBWuFrBQ1Sdwu/IwBydDNV1C0nRoMlcO8OTnBmrcUPvtEKS+
         a/Acmeh7QV3orGYhTO1ySwVo47Pchsc7+T/7McZD5JW//ry0YfMpiqraa1QyRk476SFe
         Avbzkk0VN3wxBsYSgEikCHlUED/MUyncXLk6OIRB/HOAb4inj8qsWpU6wlkIw62ZihF4
         h12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732124036; x=1732728836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYCCxRwoo4/e9pvHHukibz0lUEYL/K5Rpqldo2LsKi0=;
        b=jP3ah6hEGegEh+YtJPZ5xWt6TVuX8H+qWJjy2iBcrRsYpCUDlW58WTXRwUbT5qeEpu
         fo4B/D+Phg6K5IGEGo91Cm+9c0VVrp5H9vMErYeaFSuI8nHXfiTdzHDqCnFml6tQ2W3g
         VL8WiU8GuCBVgBVCzWEsA5zuWYUMxuHV0rMjmYD6TgA7PGhIy4vJBflO+yac5Sv+ZWD4
         wMef0Qb3XT0J7QWBnc4cVV+Iwd9WmDfgAnJlxwryav0rWfTHHD1xByTIv4zWEwZRwhmF
         PgHp8GzD+gJ5VXs1aH/3oIjUKbj9owyhYfKRzTWM3OKzL1wzalm4F0394YllTCGqXYCY
         MLsg==
X-Forwarded-Encrypted: i=1; AJvYcCVFY06mHY1TAFWuywetn4OfeBxf9n7+4YDwghtD/JYfMQtlB2mb4dEFCnOiG0aUGTm7gAm7vmn5Nq6lYm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSLhSQK6rO3h/rD/2pgqpAkhjkOE1F+NPxCaNnZY3icZGxgW3
	T9QCcVwO6hZlGQNpIDjYs6qBBWf4uw2NMg27W7iFgsV0DKd/Gbz4oL/145AbxH2VL7yijfym3xa
	n/71p4I1cF7/Qvsi7l3X9i52dRYmqtYbIpgSx7Q3H2o01vj/oyw==
X-Google-Smtp-Source: AGHT+IHXzlZzV1HDFKFSLMAjhmGRty1hJSXHMpkrUSLDMTXo54lPb8SEMTegLCJ8chntFke9JfMyqGqm2lxUKSFEZ3Y=
X-Received: by 2002:a05:690c:4911:b0:6ea:5da9:34cc with SMTP id
 00721157ae682-6eebd141ed6mr33197707b3.7.1732124034964; Wed, 20 Nov 2024
 09:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh> <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com> <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
 <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com> <CA+CK2bC-jNxUgp9JB=H9GsMu1FrxyqXxCe_v1G-43A1-eed0VA@mail.gmail.com>
In-Reply-To: <CA+CK2bC-jNxUgp9JB=H9GsMu1FrxyqXxCe_v1G-43A1-eed0VA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 20 Nov 2024 09:33:18 -0800
Message-ID: <CAJD7tkaYuJpxijOp6se+mWHO6djaz_7KaoXjf=Rdo6nJubwB2w@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:14=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Tue, Nov 19, 2024 at 2:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Nov 19, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 1:23=E2=80=AFPM Roman Gushchin <roman.gushchi=
n@linux.dev> wrote:
> > > >
> > > > On Tue, Nov 19, 2024 at 10:08:36AM -0500, Pasha Tatashin wrote:
> > > > > On Mon, Nov 18, 2024 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > > > > > > Additionally, using crash/drgn is not feasible for us at this=
 time, it
> > > > > > > requires keeping external tools on our hosts, also it require=
s
> > > > > > > approval and a security review for each script before deploym=
ent in
> > > > > > > our fleet.
> > > > > >
> > > > > > So it's ok to add a totally insecure kernel feature to your fle=
et
> > > > > > instead?  You might want to reconsider that policy decision :)
> > > > >
> > > > > Hi Greg,
> > > > >
> > > > > While some risk is inherent, we believe the potential for abuse h=
ere
> > > > > is limited, especially given the existing  CAP_SYS_ADMIN requirem=
ent.
> > > > > But, even with root access compromised, this tool presents a smal=
ler
> > > > > attack surface than alternatives like crash/drgn. It exposes less
> > > > > sensitive information, unlike crash/drgn, which could potentially
> > > > > allow reading all of kernel memory.
> > > >
> > > > The problem here is with using dmesg for output. No security-sensit=
ive
> > > > information should go there. Even exposing raw kernel pointers is n=
ot
> > > > considered safe.
> > >
> > > I am OK in writing the output to a debugfs file in the next version,
> > > the only concern I have is that implies that dump_page() would need t=
o
> > > be basically duplicated, as it now outputs everything via printk's.
> >
> > Perhaps you can refactor the code in dump_page() to use a seq_buf,
> > then have dump_page() printk that seq_buf using seq_buf_do_printk(),
> > and have page detective output that seq_buf to the debugfs file?
>
> Good idea, I will look into modifying it this way.
>
> > We do something very similar with memory_stat_format(). We use the
>
> void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> {
>         /* Use static buffer, for the caller is holding oom_lock. */
>         static char buf[PAGE_SIZE];
>         ....
>         seq_buf_init(&s, buf, sizeof(buf));
>         memory_stat_format(memcg, &s);
>         seq_buf_do_printk(&s, KERN_INFO);
> }
>
> This is a callosal stack allocation, given that our fleet only has 8K
> stacks. :-)

That's a static allocation though :)


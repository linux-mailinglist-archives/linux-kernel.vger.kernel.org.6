Return-Path: <linux-kernel+bounces-267903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC19941A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871391F247E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B0183CDB;
	Tue, 30 Jul 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8JcOzyM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2C1A6169
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357733; cv=none; b=LjM2jhYjlQnT/cKj2+Pmp+DDEp8HxdTvbtNRby7nR2jh3Kheghu+fR2zKMdNjz/mNTotPwShnrspy1dFg2SggOkJ4Zgzp/jSasiVXV+gQetkRkGinSlRBQcwOYcO/3a4bv82L4Cq55ZgT0ZbDI8gyl/39kkUNhg+qbNXaU2W7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357733; c=relaxed/simple;
	bh=LWnBVeaK6cpQldY2lowiH5cSzD8nM2ADehaCH8+xghg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaoCpeRJhezXpBS/Ek/f280h/BwiuqzmfTBosl5cV6/HeuKkxyqx8icjyRhbqYc7hWD4vMuextJICfZeiJP8Vqie6ngVtnqfLwP2brBFK7xqE4zaxZ+DvD2v/XYBxPLsHiYBA5dFR5f+8A1Yw7Wl1XJX77kVH/HDGeKgkpCySOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8JcOzyM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd530a4eso7513488e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722357730; x=1722962530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xPM0aMJJv5fPv90OOd8ioocukIL23WeQ7CLJAnS2lW8=;
        b=j8JcOzyMc6wc4qHGlTHN48om0RuUOd/upnUDyj5c6lEDBvDaUiPgG59mJuRJREXPtb
         kFC6kMT1tXZ2n1jmDTCwzXh2bye8P7EzP7xGGHYZebBxzKB9TUDiWqZT0qANeLdISbDF
         INuFsldAFP5qBjq292/TUxXz/H0gyiX3np2c138WjhNCYNkAPl2ZOItsDrR4ZgGtnnbP
         gp6D9Sli8iRSLGSFEOEWLCO0v54D2K5bU3jYi2hLXyaQVhLfkWpFNgIR4iYkGnsrIweo
         ld8gze/XQ/GWAaKQLVOAwcAiZ1f4hIuzzHcUh9lkDjOweCxllkmT9um68sKRJajvw/Iw
         nFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357730; x=1722962530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPM0aMJJv5fPv90OOd8ioocukIL23WeQ7CLJAnS2lW8=;
        b=j63btAl+vFZhmPpokXz/TQZcOGiQ/y5G9rVVLTR482mDcoN7Z486OV4vISqaknqcb/
         q4hD/TVEHfCfg8FBaZg6nX/39Foe4q0VV0jBY/qdgxyK1WXUX5VdfrazXNbj7anOB7Yp
         ob7EbLThx3JmQDA/bZLCVF6AjxVDTlkAYeD5vjhbov+x/yxdO5brtAlYYiSWh/1L9D3S
         7VSC4UAVHVvqOGkUcL7FrtuTYGYdDOvCYgSljWawAtrs5GCabFdkW4yS9873RR5Zrmbl
         Q3JomJY85W9ovfJm4LO5fpIQtrF2wP980V1aGkKlDZV5iNb2q1oU2fzmX5mV1zyCvhjJ
         q2kA==
X-Forwarded-Encrypted: i=1; AJvYcCXkBkjq2A0snxlPxypVxKj+8Dm4mWWP3ULj7cBM6PRCFDx3JXXJYnBtHJhT0Fj4H523WOrdmNEu58UlIgacu5HGO03jDn2OFF1WhWJE
X-Gm-Message-State: AOJu0YwE3NWRjOtaWsNv8F+awX29+rnsfvHai2hgdopxQILM8q0RtVat
	6+zlkXVkTSBEj3Ou9+TtsZIU3kMkTupnHKkTVPAEMzJjR4pnTc9J
X-Google-Smtp-Source: AGHT+IF/jr9bYuURe1Nq0+SHPOrvajknC/lPYU8z6eVyf6oJs098kdQ2WdeeUeuo0rhRY1wCJexCiA==
X-Received: by 2002:a05:6512:1cf:b0:52e:9ab9:da14 with SMTP id 2adb3069b0e04-5309b280728mr7253046e87.31.1722357729826;
        Tue, 30 Jul 2024 09:42:09 -0700 (PDT)
Received: from pc636 (host-90-235-1-92.mobileonline.telia.com. [90.235.1.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c19579sm1939593e87.182.2024.07.30.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:42:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 30 Jul 2024 18:42:06 +0200
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, ahuang12@lenovo.com,
	akpm@linux-foundation.org, andreyknvl@gmail.com, bhe@redhat.com,
	dvyukov@google.com, glider@google.com, hch@infradead.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, sunjw10@lenovo.com,
	vincenzo.frascino@arm.com
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of
 KASAN shadow virtual address into one operation
Message-ID: <ZqkX3mYBPuUf0Gi5@pc636>
References: <Zqd9AsI5tWH7AukU@pc636>
 <20240730093630.5603-1-ahuang12@lenovo.com>
 <ZqjQp8NrTYM_ORN1@pc636>
 <CAHKZfL3c2Y91yP6X5+GUDCsN6QAa9L46czzJh+iQ6LhGJcAeqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHKZfL3c2Y91yP6X5+GUDCsN6QAa9L46czzJh+iQ6LhGJcAeqw@mail.gmail.com>

On Wed, Jul 31, 2024 at 12:27:27AM +0800, Huang Adrian wrote:
> On Tue, Jul 30, 2024 at 7:38 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > On Mon, Jul 29, 2024 at 7:29 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > It would be really good if Adrian could run the "compiling workload" on
> > > > his big system and post the statistics here.
> > > >
> > > > For example:
> > > >   a) v6.11-rc1 + KASAN.
> > > >   b) v6.11-rc1 + KASAN + patch.
> > >
> > > Sure, please see the statistics below.
> > >
> > > Test Result (based on 6.11-rc1)
> > > ===============================
> > >
> > > 1. Profile purge_vmap_node()
> > >
> > >    A. Command: trace-cmd record -p function_graph -l purge_vmap_node make -j $(nproc)
> > >
> > >    B. Average execution time of purge_vmap_node():
> > >
> > >       no patch (us)           patched (us)    saved
> > >       -------------           ------------    -----
> > >                147885.02                3692.51        97%
> > >
> > >    C. Total execution time of purge_vmap_node():
> > >
> > >       no patch (us)           patched (us)    saved
> > >       -------------           ------------    -----
> > >         194173036               5114138        97%
> > >
> > >    [ftrace log] Without patch: https://gist.github.com/AdrianHuang/a5bec861f67434e1024bbf43cea85959
> > >    [ftrace log] With patch: https://gist.github.com/AdrianHuang/a200215955ee377288377425dbaa04e3
> > >
> > > 2. Use `time` utility to measure execution time
> > >
> > >    A. Command: make clean && time make -j $(nproc)
> > >
> > >    B. The following result is the average kernel execution time of five-time
> > >       measurements. ('sys' field of `time` output):
> > >
> > >       no patch (seconds)      patched (seconds)       saved
> > >       ------------------      ----------------        -----
> > >           36932.904              31403.478             15%
> > >
> > >    [`time` log] Without patch: https://gist.github.com/AdrianHuang/987b20fd0bd2bb616b3524aa6ee43112
> > >    [`time` log] With patch: https://gist.github.com/AdrianHuang/da2ea4e6aa0b4dcc207b4e40b202f694
> > >
> > I meant another statistics. As noted here https://lore.kernel.org/linux-mm/ZogS_04dP5LlRlXN@pc636/T/#m5d57f11d9f69aef5313f4efbe25415b3bae4c818
> > i came to conclusion that below place and lock:
> >
> > <snip>
> > static void exit_notify(struct task_struct *tsk, int group_dead)
> > {
> >         bool autoreap;
> >         struct task_struct *p, *n;
> >         LIST_HEAD(dead);
> >
> >         write_lock_irq(&tasklist_lock);
> > ...
> > <snip>
> >
> > keeps IRQs disabled, so it means that the purge_vmap_node() does the progress
> > but it can be slow.
> >
> > CPU_1:
> > disables IRQs
> > trying to grab the tasklist_lock
> >
> > CPU_2:
> > Sends an IPI to CPU_1
> > waits until the specified callback is executed on CPU_1
> >
> > Since CPU_1 has disabled IRQs, serving an IPI and completion of callback
> > takes time until CPU_1 enables IRQs back.
> >
> > Could you please post lock statistics for kernel compiling use case?
> > KASAN + patch is enough, IMO. This just to double check whether a
> > tasklist_lock is a problem or not.
> 
> Sorry for the misunderstanding.
> 
> Two experiments are shown as follows. I saw you think KASAN + patch is
> enough. But, in case you need another one. ;-)
> 
> a) v6.11-rc1 + KASAN
> 
> The result is different from yours, so I ran two tests (make sure the
> soft lockup warning was triggered).
> 
> Test #1: waittime-max = 5.4ms
> <snip>
> ...
> class name    con-bounces    contentions   waittime-min   waittime-max
> waittime-total   waittime-avg    acq-bounces   acquisitions
> holdtime-min   holdtime-max holdtime-total   holdtime-avg
> ...
> tasklist_lock-W:        118762         120090           0.44
> 5443.22    24807413.37         206.57         429757         569051
>        2.27        3222.00    69914505.87         122.86
> tasklist_lock-R:        108262         108300           0.41
> 5381.34    23613372.10         218.04         489132         541541
>        0.20        5543.40    10095470.68          18.64
>     ---------------
>     tasklist_lock          44594          [<0000000099d3ea35>]
> exit_notify+0x82/0x900
>     tasklist_lock          32041          [<0000000058f753d8>]
> release_task+0x104/0x3f0
>     tasklist_lock          99240          [<000000008524ff80>]
> __do_wait+0xd8/0x710
>     tasklist_lock          43435          [<00000000f6e82dcf>]
> copy_process+0x2a46/0x50f0
>     ---------------
>     tasklist_lock          98334          [<0000000099d3ea35>]
> exit_notify+0x82/0x900
>     tasklist_lock          82649          [<0000000058f753d8>]
> release_task+0x104/0x3f0
>     tasklist_lock              2          [<00000000da5a7972>]
> mm_update_next_owner+0xc0/0x430
>     tasklist_lock          26708          [<00000000f6e82dcf>]
> copy_process+0x2a46/0x50f0
> ...
> <snip>
> 
> Test #2:waittime-max = 5.7ms
> <snip>
> ...
> class name    con-bounces    contentions   waittime-min   waittime-max
> waittime-total   waittime-avg    acq-bounces   acquisitions
> holdtime-min   holdtime-max holdtime-total   holdtime-avg
> ...
> tasklist_lock-W:        121742         123167           0.43
> 5713.02    25252257.61         205.02         432111         569762
>        2.25        3083.08    70711022.74         124.11
> tasklist_lock-R:        111479         111523           0.39
> 5050.50    24557264.88         220.20         491404         542221
>        0.20        5611.81    10007782.09          18.46
>     ---------------
>     tasklist_lock         102317          [<000000008524ff80>]
> __do_wait+0xd8/0x710
>     tasklist_lock          44606          [<00000000f6e82dcf>]
> copy_process+0x2a46/0x50f0
>     tasklist_lock          45584          [<0000000099d3ea35>]
> exit_notify+0x82/0x900
>     tasklist_lock          32969          [<0000000058f753d8>]
> release_task+0x104/0x3f0
>     ---------------
>     tasklist_lock         100498          [<0000000099d3ea35>]
> exit_notify+0x82/0x900
>     tasklist_lock          27401          [<00000000f6e82dcf>]
> copy_process+0x2a46/0x50f0
>     tasklist_lock          85473          [<0000000058f753d8>]
> release_task+0x104/0x3f0
>     tasklist_lock            650          [<000000004d0b9f6b>]
> tty_open_proc_set_tty+0x23/0x210
> ...
> <snip>
> 
> 
> b) v6.11-rc1 + KASAN + patch: waittime-max = 5.7ms
> <snip>
> ...
> class name    con-bounces    contentions   waittime-min   waittime-max
> waittime-total   waittime-avg    acq-bounces   acquisitions
> holdtime-min   holdtime-max holdtime-total   holdtime-avg
> ...
> tasklist_lock-W:        108876         110087           0.33
> 5688.64    18622460.43         169.16         426740         568715
>        1.94        2930.76    62560515.48         110.00
> tasklist_lock-R:         99864          99909           0.43
> 5868.69    17849478.20         178.66         487654         541328
>        0.20        5709.98     9207504.90          17.01
>     ---------------
>     tasklist_lock          91655          [<00000000a622e532>]
> __do_wait+0xd8/0x710
>     tasklist_lock          41100          [<00000000ccf53925>]
> exit_notify+0x82/0x900
>     tasklist_lock           8254          [<00000000093ccded>]
> tty_open_proc_set_tty+0x23/0x210
>     tasklist_lock          39542          [<00000000a0e6bf4d>]
> copy_process+0x2a46/0x50f0
>     ---------------
>     tasklist_lock          90525          [<00000000ccf53925>]
> exit_notify+0x82/0x900
>     tasklist_lock          76934          [<00000000cb7ca00c>]
> release_task+0x104/0x3f0
>     tasklist_lock          23723          [<00000000a0e6bf4d>]
> copy_process+0x2a46/0x50f0
>     tasklist_lock          18223          [<00000000a622e532>]
> __do_wait+0xd8/0x710
> ...
> <snip>
>
Thank you for posting this! So tasklist_lock is not a problem.
I assume you have a full output of lock_stat. Could you please
paste it for v6.11-rc1 + KASAN?

Thank you!

--
Uladzislau Rezki


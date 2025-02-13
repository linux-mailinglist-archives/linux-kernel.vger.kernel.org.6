Return-Path: <linux-kernel+bounces-514052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FABA351BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C3C7A461F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A742753F5;
	Thu, 13 Feb 2025 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAcVy8K+"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25F2753F1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487561; cv=none; b=JS1/0HJjGZlN83OHNRv7NCq0kCQJ4cLlU5Ntjoq4vF7szXOrz/o2AEZSPlyzWc40/hlOsPQwBb0vXJ4dAyOkBrqw9LGS5MxrKiHxDpMwzQ+d0sSMZTVIPQGCj0m/B5Xq5TwefrcWNzGau/7PEZnovNrfMsf1AlPAZ52Q2bjQcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487561; c=relaxed/simple;
	bh=IYWc6MsnXJtGhjkFgmYtXuRtBlusO6zPvFX85df7cNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITZbnNL0lbaWyzEQXMknBe3xt3raFcgpzx3E3Y44fm5OPBotQkVX+Pr8QQ4myQBFZ0ssLv8v7NorOeJxGwA6uTMg3lVwpdh3T/PwvPwZb39ipkwRqeCdGHKIGNRX9v6zeQ11cn2G8CtQoNkgj8uJ6Y0nUiEoRpbMmzr18BzUhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAcVy8K+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4718aea0718so116681cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739487559; x=1740092359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDIANBVumajBd13du95VEVdci2R7G4b/MflfuioNn1c=;
        b=dAcVy8K+IZuib1CRGgTStxnFrH+taQI22CXcLYgTOUbhu9wcrfF8U7Kr5kNDuRLJJr
         qRoBBu5WZrSGFYS1ABDSiFpTZEbH/rjcfuh7GEgUPMgYS5ISEdakvINigcX7NTNAJckW
         YCJ1x0eG0Hi5N4rT42LmL+r/P/q0BZopUdIIHo4w7xtzzL3bKWjz/arIMmZtZ2FHCW1d
         wh5PAvxfqp7f41praYvhjO7WogTFktVprW17UeiDkfoWcmkfg0LhBKa0fWuXyF6iJKho
         6ECez0nnXPR2olH6Uu+1EPRP+RnR9CtX3W7WCJfLwb/cpyOfptR+um5HcS7g0yYnn7D7
         yuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487559; x=1740092359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDIANBVumajBd13du95VEVdci2R7G4b/MflfuioNn1c=;
        b=DLFDUPnWI4x+OktNV56niY0D2V0PcTqDeYY453BqSrLCkqpUweeON3r+kEoFWj+A4f
         oK1jBJvYSu5QuC7TZJbmKIpPsH0oeGHQOCC7nZDJNzk9ajn64G1eMnrWHD0OC0ejxG/A
         VSY9HprSxqG2fkrbA/GzyEDCd11rqHyXXuTVLVC9IEmk/9aYlhqGmLNesHUYm+9/04hn
         3YvMf0S1UJbYMlvck8mw9SM1NX0doI2h2sBgh6amD7S7ZGoHdHBVO/kcoJLyHtc908KK
         xDUFazLL8B0s+nUi4gbwSM1jgl9l1TQBL7aVaU1cgcd/QiGhGBid6r31CzxxauPsJLVr
         +1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV/aCI+PaKR0nQMQ8INMDMGV5PNqmFdng+nLPs+hunTceBBMvg8aJjDNlvOhrsJz2KewJ8H9IP06PyDZW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Of6NrwEbsiIx7fdf9spGUk7fiF1Hea8eDbT4WuY9pmuCe4Ts
	fG3IPsAX3zogbVpjVYe7Ew+F6r8DbOLFlwrCamoAut4bR4KdNYQfOTS3y5U1pcy/rSkXLu6aB0S
	bpEnX4ic9SsouFaNCi6bbjIM5ub8xoVoI7mbH
X-Gm-Gg: ASbGncuTylChyztZa4YKixQdVykpXvUYWT+srT/lIsFe1h3rIV+EaQzBYJM5Ma6DTke
	/IGmKgozBf6vRtIlQB6QiXsom0fMR+2BkRJklzCaydU1EqG+SVKHqXWKV3CZWPlB6/T8fYTzRCZ
	DqybNFdyRRsl0cCj3a5v9hSGELl7Y=
X-Google-Smtp-Source: AGHT+IH1CnRV5ltlIFYCD8r2z+kCU2AjYaHwGfhq6KhIQ8OE5guM8kGIum9PY0Ww3eZxM7IkjMsYobe9TP0B8I4TUWk=
X-Received: by 2002:a05:622a:3d0:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-471ce95ecd4mr1005091cf.26.1739487558542; Thu, 13 Feb 2025
 14:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111042604.3230628-1-surenb@google.com> <20250111042604.3230628-13-surenb@google.com>
 <20250115105056.GY5388@noisy.programming.kicks-ass.net> <CAJuCfpEU-D_G3N1aduOprR0YmV+jP+4un78XMs4Qj41_V+_6Ug@mail.gmail.com>
In-Reply-To: <CAJuCfpEU-D_G3N1aduOprR0YmV+jP+4un78XMs4Qj41_V+_6Ug@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 13 Feb 2025 14:59:07 -0800
X-Gm-Features: AWEUYZmlg1kcVkmWqjyI70BvcBxyYcl4HVx6CnlwWZWv5s51alYwg7U7bzMVrGY
Message-ID: <CAJuCfpG+WkmjriuEZH2_=YKgqrVLXfO19b4SMf_tQ=N25ntbww@mail.gmail.com>
Subject: Re: [PATCH v9 12/17] mm: move lesser used vma_area_struct members
 into the last cacheline
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:39=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 15, 2025 at 2:51=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Fri, Jan 10, 2025 at 08:25:59PM -0800, Suren Baghdasaryan wrote:
> > > Move several vma_area_struct members which are rarely or never used
> > > during page fault handling into the last cacheline to better pack
> > > vm_area_struct. As a result vm_area_struct will fit into 3 as opposed
> > > to 4 cachelines. New typical vm_area_struct layout:
> > >
> > > struct vm_area_struct {
> > >     union {
> > >         struct {
> > >             long unsigned int vm_start;              /*     0     8 *=
/
> > >             long unsigned int vm_end;                /*     8     8 *=
/
> > >         };                                           /*     0    16 *=
/
> > >         freeptr_t          vm_freeptr;               /*     0     8 *=
/
> > >     };                                               /*     0    16 *=
/
> > >     struct mm_struct *         vm_mm;                /*    16     8 *=
/
> > >     pgprot_t                   vm_page_prot;         /*    24     8 *=
/
> > >     union {
> > >         const vm_flags_t   vm_flags;                 /*    32     8 *=
/
> > >         vm_flags_t         __vm_flags;               /*    32     8 *=
/
> > >     };                                               /*    32     8 *=
/
> > >     unsigned int               vm_lock_seq;          /*    40     4 *=
/
> >
> > Does it not make sense to move this seq field near the refcnt?
>
> In an earlier version, when vm_lock was not a refcount yet, I tried
> that and moving vm_lock_seq introduced regression in the pft test. We
> have that early vm_lock_seq check in the beginning of vma_start_read()
> and if it fails we bail out early without locking. I think that might
> be the reason why keeping vm_lock_seq in the first cacheling is
> beneficial. But I'll try moving it again now that we have vm_refcnt
> instead of the lock and see if pft still shows any regression.

I confirmed that moving vm_lock_seq next to vm_refcnt regresses
pagefault performance:

Hmean     faults/cpu-1    508634.6876 (   0.00%)   508548.5498 *  -0.02%*
Hmean     faults/cpu-4    474767.2684 (   0.00%)   475620.7653 *   0.18%*
Hmean     faults/cpu-7    451356.6844 (   0.00%)   446738.2381 *  -1.02%*
Hmean     faults/cpu-12   360114.9092 (   0.00%)   337121.8189 *  -6.38%*
Hmean     faults/cpu-21   227567.8237 (   0.00%)   205277.2029 *  -9.80%*
Hmean     faults/cpu-30   163383.6765 (   0.00%)   152765.1451 *  -6.50%*
Hmean     faults/cpu-48   118048.2568 (   0.00%)   109959.2027 *  -6.85%*
Hmean     faults/cpu-56   103189.6761 (   0.00%)    92989.3749 *  -9.89%*
Hmean     faults/sec-1    508228.4512 (   0.00%)   508129.1963 *  -0.02%*
Hmean     faults/sec-4   1854868.9033 (   0.00%)  1862443.6146 *   0.41%*
Hmean     faults/sec-7   3088881.6158 (   0.00%)  3050403.1664 *  -1.25%*
Hmean     faults/sec-12  4222540.9948 (   0.00%)  3951163.9557 *  -6.43%*
Hmean     faults/sec-21  4555777.5386 (   0.00%)  4130470.6021 *  -9.34%*
Hmean     faults/sec-30  4336721.3467 (   0.00%)  4150477.5095 *  -4.29%*
Hmean     faults/sec-48  5163921.7465 (   0.00%)  4857286.2166 *  -5.94%*
Hmean     faults/sec-56  5413622.8890 (   0.00%)  4936484.0021 *  -8.81%*

So, I kept it unchanged in v10
(https://lore.kernel.org/all/20250213224655.1680278-14-surenb@google.com/)

>
> >
> > >     /* XXX 4 bytes hole, try to pack */
> > >
> > >     struct list_head           anon_vma_chain;       /*    48    16 *=
/
> > >     /* --- cacheline 1 boundary (64 bytes) --- */
> > >     struct anon_vma *          anon_vma;             /*    64     8 *=
/
> > >     const struct vm_operations_struct  * vm_ops;     /*    72     8 *=
/
> > >     long unsigned int          vm_pgoff;             /*    80     8 *=
/
> > >     struct file *              vm_file;              /*    88     8 *=
/
> > >     void *                     vm_private_data;      /*    96     8 *=
/
> > >     atomic_long_t              swap_readahead_info;  /*   104     8 *=
/
> > >     struct mempolicy *         vm_policy;            /*   112     8 *=
/
> > >     struct vma_numab_state *   numab_state;          /*   120     8 *=
/
> > >     /* --- cacheline 2 boundary (128 bytes) --- */
> > >     refcount_t          vm_refcnt (__aligned__(64)); /*   128     4 *=
/
> > >
> > >     /* XXX 4 bytes hole, try to pack */
> > >
> > >     struct {
> > >         struct rb_node     rb (__aligned__(8));      /*   136    24 *=
/
> > >         long unsigned int  rb_subtree_last;          /*   160     8 *=
/
> > >     } __attribute__((__aligned__(8))) shared;        /*   136    32 *=
/
> > >     struct anon_vma_name *     anon_name;            /*   168     8 *=
/
> > >     struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     8 *=
/
> > >
> > >     /* size: 192, cachelines: 3, members: 18 */
> > >     /* sum members: 176, holes: 2, sum holes: 8 */
> > >     /* padding: 8 */
> > >     /* forced alignments: 2, forced holes: 1, sum forced holes: 4 */
> > > } __attribute__((__aligned__(64)));
> >
> >


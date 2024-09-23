Return-Path: <linux-kernel+bounces-335724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299D197E9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462901C21696
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E09198827;
	Mon, 23 Sep 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJI6LBbw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD3194A54
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086592; cv=none; b=rDQeOT/eLQ9ryxOCq5i04Y2nQi5lm84VRnsfsIiIlcietHEIj8pmJSbUHnHbzcxIdVtHGqDhiarIlLF2PgPZcKsaoeoYqQiDQ6dzj0eE1J4S1DKUtXYPlj5gJ9TStY+Mf5YL/G+wv8EQXIOfU1U/wb83G2to5liDd4B2pPyWLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086592; c=relaxed/simple;
	bh=s+e2I81/u1djzKANWX+BHKnVKSk7mf2smUP6ixSsLZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwYXmb3XaHQGfUnSBSZgc3mUlqmklVTAtTQi+cwD/ToQL3zGQR/QJaIvTa11keAsy/U0VWYfeip2a/WiLQzZoK8Tk3FqqlinQzIowDYkZZW83N0Q27GBNfzMMPnCZpGuMCVJtNXXdqwryzO7Rpg+1ok3MM0UK9uFI8PuhbeqUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJI6LBbw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d3e662791so291037366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727086588; x=1727691388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3e+4tzy78SD0uTGInfbmqrqn1zNjwwAT0I86sCzn14=;
        b=ZJI6LBbwt2WsJVW+PMMAlbedeCMfvhEZ5Gd5VmxNPVV00nKYikjX3SFjNVCG6WQeZM
         KBmnGkWLPw35Pbnw/nnJWWGz1XVRAVlc0Vw1KfMX9dD1790gzWwYtcwoP9XouK9HafbD
         tcqDlEhnxae4TAXP4QfYuJyxomoOT4yGd69InBmHzTbrylyS/xPvdOiTFFX/CuPnJ9au
         bo9rXQV9T2TeKVdxDQ0OApfXVvPwlgl5QRZwGkFug9x2T5KDZN30Js+TfxL2DPyq/sKW
         CBzagZ2+F966XoFs1cHyqznpmfJBX0BVQcFflrAdZz/fZHRW1q4PXW2Hlidz+q0va26t
         emCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727086588; x=1727691388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3e+4tzy78SD0uTGInfbmqrqn1zNjwwAT0I86sCzn14=;
        b=vta7TV/dTOV2DlXdK7dzdxMOrPZKIefKJbEuoCA6t3EIV9X/Af5NE/ttMNrNo5C7q6
         WCbYjNtpLDElOQQq8zk3Z3nYOladW0yFRy4f696jCGMyzehEHDtou8z3vIwimlhLx1Ot
         /5UUgH30NTj5E5QWqKveycRWvIhAKzvoaucpnjmVAZIejGMDVruBWYMb+YeRD7e10QyL
         f5ABjywv1nGXtXA0Pxqjo5Lj0upSg3c99DRhzDAgBlKTstqLLfeJpjGFX8wN7pz77cDp
         xQV2mIRThiCwhjXJtog88vEBDXKgIi87TT9KCM62siMEgwJDC82yPAVPZEGsfG9JBLfM
         o5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVORR6g6FbDaoOiM5Pd7oj5XcC51XNVLKzzhk74KM7afK6TgMRUPStyCaJYLmRTvQuQYX1yYRbsSHU6izQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmikjwY3cCZhm47DTSuq7RdQxKw0B+LoEKgrF0bsWTeA8TLaB6
	Q9RAiM2/kpZnXMZUGnXrdsvm4fxwMxf+7PQ8n+3NSiKS8m5sAywPkmJlpiCP1nHo6P/2kZa3V5D
	fGn2eBmLzqbeutIKiFuYqyxObCYORAZfMXeQ3kP0hHcWqpeJf1aZz
X-Google-Smtp-Source: AGHT+IE/qAmJKSsYjmvCIHgJn7RfIoWZCtJ9IuS9SWi9uecUmHEmRL78Z96iZ101d55iTEU2O+UavIBQPdwIpftuEGI=
X-Received: by 2002:a05:6402:90b:b0:5c4:8b7:d93d with SMTP id
 4fb4d7f45d1cf-5c464a42b12mr18761649a12.18.1727086588119; Mon, 23 Sep 2024
 03:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EC5AC714C75A855E+20240923091535.77865-1-yushengjin@uniontech.com>
 <CANn89i+4wbef3k6at_Kf+8MBmU4HhE9nxMRvROR_OxsZptffjA@mail.gmail.com> <80515DEDE931DC2A+7fa48c7a-2955-4afb-821f-a0108a72009f@uniontech.com>
In-Reply-To: <80515DEDE931DC2A+7fa48c7a-2955-4afb-821f-a0108a72009f@uniontech.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 12:16:14 +0200
Message-ID: <CANn89iJCBRCM3aHDy-7gxWu_+agXC9M1R=hwFuh2G9RSLu_6bg@mail.gmail.com>
Subject: Re: [PATCH] net/bridge: Optimizing read-write locks in ebtables.c
To: yushengjin <yushengjin@uniontech.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com, 
	razor@blackwall.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:06=E2=80=AFPM yushengjin <yushengjin@uniontech.c=
om> wrote:
>
>
> =E5=9C=A8 23/9/2024 =E4=B8=8B=E5=8D=885:29, Eric Dumazet =E5=86=99=E9=81=
=93:
> > On Mon, Sep 23, 2024 at 11:16=E2=80=AFAM yushengjin <yushengjin@unionte=
ch.com> wrote:
> >> When conducting WRK testing, the CPU usage rate of the testing machine=
 was
> >> 100%. forwarding through a bridge, if the network load is too high, it=
 may
> >> cause abnormal load on the ebt_do_table of the kernel ebtable module, =
leading
> >> to excessive soft interrupts and sometimes even directly causing CPU s=
oft
> >> deadlocks.
> >>
> >> After analysis, it was found that the code of ebtables had not been op=
timized
> >> for a long time, and the read-write locks inside still existed. Howeve=
r, other
> >> arp/ip/ip6 tables had already been optimized a lot, and performance bo=
ttlenecks
> >> in read-write locks had been discovered a long time ago.
> >>
> >> Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam=
/
> >>
> >> So I referred to arp/ip/ip6 modification methods to optimize the read-=
write
> >> lock in ebtables.c.
> >>
> >> test method:
> >> 1) Test machine creates bridge :
> >> ``` bash
> >> brctl addbr br-a
> >> brctl addbr br-b
> >> brctl addif br-a enp1s0f0 enp1s0f1
> >> brctl addif br-b enp130s0f0 enp130s0f1
> >> ifconfig br-a up
> >> ifconfig br-b up
> >> ```
> >> 2) Testing with another machine:
> >> ``` bash
> >> ulimit -n 2048
> >> ./wrk -t48 -c2000 -d6000 -R10000 -s request.lua http://4.4.4.2:80/4k.h=
tml &
> >> ./wrk -t48 -c2000 -d6000 -R10000 -s request.lua http://5.5.5.2:80/4k.h=
tml &
> >> ```
> >>
> >> Signed-off-by: yushengjin <yushengjin@uniontech.com>
> >> ---
> >>   include/linux/netfilter_bridge/ebtables.h |  47 +++++++-
> >>   net/bridge/netfilter/ebtables.c           | 132 ++++++++++++++++----=
--
> >>   2 files changed, 145 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/include/linux/netfilter_bridge/ebtables.h b/include/linux=
/netfilter_bridge/ebtables.h
> >> index fd533552a062..dd52dea20fb8 100644
> >> --- a/include/linux/netfilter_bridge/ebtables.h
> >> +++ b/include/linux/netfilter_bridge/ebtables.h
> >> @@ -93,7 +93,6 @@ struct ebt_table {
> >>          char name[EBT_TABLE_MAXNAMELEN];
> >>          struct ebt_replace_kernel *table;
> >>          unsigned int valid_hooks;
> >> -       rwlock_t lock;
> >>          /* the data used by the kernel */
> >>          struct ebt_table_info *private;
> >>          struct nf_hook_ops *ops;
> >> @@ -124,4 +123,50 @@ static inline bool ebt_invalid_target(int target)
> >>
> >>   int ebt_register_template(const struct ebt_table *t, int(*table_init=
)(struct net *net));
> >>   void ebt_unregister_template(const struct ebt_table *t);
> >> +
> >> +/**
> >> + * ebt_recseq - recursive seqcount for netfilter use
> >> + *
> >> + * Packet processing changes the seqcount only if no recursion happen=
ed
> >> + * get_counters() can use read_seqcount_begin()/read_seqcount_retry()=
,
> >> + * because we use the normal seqcount convention :
> >> + * Low order bit set to 1 if a writer is active.
> >> + */
> >> +DECLARE_PER_CPU(seqcount_t, ebt_recseq);
> >> +
> >> +/**
> >> + * ebt_write_recseq_begin - start of a write section
> >> + *
> >> + * Begin packet processing : all readers must wait the end
> >> + * 1) Must be called with preemption disabled
> >> + * 2) softirqs must be disabled too (or we should use this_cpu_add())
> >> + * Returns :
> >> + *  1 if no recursion on this cpu
> >> + *  0 if recursion detected
> >> + */
> >> +static inline unsigned int ebt_write_recseq_begin(void)
> >> +{
> >> +       unsigned int addend;
> >> +
> >> +       addend =3D (__this_cpu_read(ebt_recseq.sequence) + 1) & 1;
> >> +
> >> +       __this_cpu_add(ebt_recseq.sequence, addend);
> >> +       smp_mb();
> >> +
> >> +       return addend;
> >> +}
> >> +
> >> +/**
> >> + * ebt_write_recseq_end - end of a write section
> >> + * @addend: return value from previous ebt_write_recseq_begin()
> >> + *
> >> + * End packet processing : all readers can proceed
> >> + * 1) Must be called with preemption disabled
> >> + * 2) softirqs must be disabled too (or we should use this_cpu_add())
> >> + */
> >> +static inline void ebt_write_recseq_end(unsigned int addend)
> >> +{
> >> +       smp_wmb();
> >> +       __this_cpu_add(ebt_recseq.sequence, addend);
> >> +}
> > Why not reusing xt_recseq, xt_write_recseq_begin(), xt_write_recseq_end=
(),
> > instead of copy/pasting them ?
> >
> > This was added in
> >
> > commit 7f5c6d4f665bb57a19a34ce1fb16cc708c04f219    netfilter: get rid
> > of atomic ops in fast path
> They used different seqcounts, I'm worried it might have an impact.
> >
> > If this is an include mess, just move them in a separate include file.
>
> Can i copy  ebt_write_recseq_begin(), ebt_write_recseq_endend to
> include/linux/netfilter/x_tables.h ?
>
> Or add a parameter in xt_write_recseq_begin() , xt_write_recseq_end()  to
> clarify whether it is xt_recseq or ebt_recseq.

I think you can reuse xt_recseq, xt_write_recseq_begin(),
xt_write_recseq_end() directly.

We use xt_recseq from three different users already.

If you think you need a separate variable, please elaborate.

We prefer to reuse code, obviously.


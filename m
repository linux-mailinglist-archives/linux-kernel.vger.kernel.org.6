Return-Path: <linux-kernel+bounces-354358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499D993C7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49341F24A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067271863E;
	Tue,  8 Oct 2024 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wACdIh89"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB814287
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352188; cv=none; b=iVVTiFaM47PEQoQSWPSJ/1TWsshSotyP1iM6lEBVkC6dtfWcBputx3Nyb2vQAkPlLd4ryvqjcuduA1ZwzYM6HQYScBjdp4O+PmY1ZpQtE1U4JeHuZARM1EpgkrHrek1v1xNeULHywKhV3AhO6UJOhdZON8W4IqD88I2gs1Rp21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352188; c=relaxed/simple;
	bh=2kyYN2da9Ff5aYW9mTRH3k6w8NQuTi5mxudPSHgTci0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raiyFmfEcSRfTteWWf/4JaWW0upiEf9jSRtPznO8An+rdZHRS1xvuvMbNsLmx9CSGCsdsnzDdmqwyNfzrn9wZyroT1YAj5Hm4n0B6imrYZgeKBG/rHsBf98GVs32/ywhKV8FZ+dTJ01qULnFeDSLH8n5H0b+U2EaXhvIRC68r+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wACdIh89; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4581cec6079so156281cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728352185; x=1728956985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F57M3cASSDc9ogKrJwj+KVMp5A3GRf8CiQ61EpkNzYM=;
        b=wACdIh89DYAocmMffnaGBp5CSxCi7asuK7RVadCJau7UEpvVzOApo4MyKBeljihF8m
         QvqlVlxXBoRFekpwttVRSh4ukwppl69Suj9xyL8xPnjnXZeukn+P5JA6BKVoFmptbVS5
         k4VOD0u0BdwQ15hGPZmOz+7aQFjdcTEE5i5XMQxyD3kz5JMrXiRYG/K/hsCS/IivfmIB
         Oa3pZroTz2JC21zyvundklTAAk6FZPjH4//ZNp5ObVj37khEepEag9gBFvms7NNZ8OK0
         APuX1OFwYXmHUGjnovQzPDZQoxx4cPpkV83/eT4l5UpMRv5Vx5AlFZ+zACveGohdUjrJ
         MGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728352185; x=1728956985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F57M3cASSDc9ogKrJwj+KVMp5A3GRf8CiQ61EpkNzYM=;
        b=I2R5Rb6qqKSkL2ANwFA0uhIYX8shXUTHMArbMu10c6Ji0bFWjNZpF107czRnej0dn/
         eivQMtGnhTTTiR/nJYC89JxK5T9CMRff1CFohirIrpnuzTM8MVz2NEjaWA+TlOwDfIxG
         09g30jt++Z4l4OA1ZlaxyEYNjcVLvA8wBVUJ7LV/0iphDQjDJKks0KCwcAz3RQJZFAmV
         zq6seykFoa/j8UBqPlzgJ+M1oJw9NcFPE69uw0vLR5ZbsU9ujBSYcEdKBlJ3EO3bo721
         2Fi8OeDM/A+ka9cQjz6EPvrIdYcIopHULYIpIKsR3J1HmsmYSLjxkpNjFSujMP/GdLEA
         QVHw==
X-Forwarded-Encrypted: i=1; AJvYcCX9BUnJEyY2/RqH9bHa+px7nNdWsbJtGWkeTMkD/ePnZ1zdBZpBjoHf/ZUKS0ENtm6M7iD8LvY8JcMz6Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wtt+cuoSj0DQ5UMCiNr8kfY0h4LoN+26Iyii9sqtLCsI9+gu
	+EiK7+fE2HsMyxxA5fYcKAO3GfHrV01rvS4MIiTduCggbTWTIOIk/FfgPGsJasUxAnTNxkY8W0d
	UA4/JTcP1nvgy/eF311fcsnc4fd1iG7lOcYhP
X-Google-Smtp-Source: AGHT+IHwo08FfOq6O3t2rBR3qoDY9wRZElhnMBl5M85uajhb2/wzcuDSASXwBXGXRz/Od3RP2VLvl1vaUaTA9Fcg4CA=
X-Received: by 2002:a05:622a:5796:b0:458:14dd:108b with SMTP id
 d75a77b69052e-45ec7e1f64fmr1004971cf.13.1728352185331; Mon, 07 Oct 2024
 18:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007205236.11847-1-fw@strlen.de> <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
In-Reply-To: <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Oct 2024 18:49:32 -0700
Message-ID: <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, 
	Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 6:15=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wrote:
>
> > Ben Greear reports following splat:
> >  ------------[ cut here ]------------
> >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn=
 has 256 allocated at module unload
> >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unl=
oad+0x22b/0x3f0
> >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msd=
os fat
> > ...
> >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2=
020
> >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
> >   codetag_unload_module+0x19b/0x2a0
> >   ? codetag_load_module+0x80/0x80
> >
> > nf_nat module exit calls kfree_rcu on those addresses, but the free
> > operation is likely still pending by the time alloc_tag checks for leak=
s.
> >
> > Wait for outstanding kfree_rcu operations to complete before checking
> > resolves this warning.
> >
> > Reproducer:
> > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> > grep nf_nat /proc/allocinfo # will list 4 allocations
> > rmmod nft_chain_nat
> > rmmod nf_nat                # will WARN.
> >
> > ...
> >
> > --- a/lib/codetag.c
> > +++ b/lib/codetag.c
> > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
> >       if (!mod)
> >               return true;
> >
> > +     kvfree_rcu_barrier();
> > +
> >       mutex_lock(&codetag_lock);
> >       list_for_each_entry(cttype, &codetag_types, link) {
> >               struct codetag_module *found =3D NULL;
>
> It's always hard to determine why a thing like this is present, so a
> comment is helpful:
>
> --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending-kfr=
ee_rcu-calls-fix
> +++ a/lib/codetag.c
> @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
>         if (!mod)
>                 return true;
>
> +       /* await any module's kfree_rcu() operations to complete */
>         kvfree_rcu_barrier();
>
>         mutex_lock(&codetag_lock);
> _
>
> But I do wonder whether this is in the correct place.
>
> Waiting for a module's ->exit() function's kfree_rcu()s to complete
> should properly be done by the core module handling code?

I don't think core module code cares about kfree_rcu()s being complete
before the module is unloaded.
Allocation tagging OTOH cares because it is about to destroy tags
which will be accessed when kfree() actually happens, therefore a
strict ordering is important.

>
> free_module() does a full-on synchronize_rcu() prior to freeing the
> module memory itself and I think codetag_unload_module() could be
> called after that?

I think we could move codetag_unload_module() after synchronize_rcu()
inside free_module() but according to the reply in
https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
synchronize_rcu() does not help. I'm not quite sure why...
Note that once I'm done upstreaming
https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com/,
this change will not be needed and I'm planning to remove this call,
however this change is useful for backporting. It should be sent to
stable@vger.kernel.org # v6.10+


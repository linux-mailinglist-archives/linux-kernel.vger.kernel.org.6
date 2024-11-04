Return-Path: <linux-kernel+bounces-395615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA739BC093
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421221C22040
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9791FCF78;
	Mon,  4 Nov 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFtM6yb7"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400881FCC6D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757893; cv=none; b=RjnwZQTw8arU/F2b0A+4T3ZO1Uk2eTAbg4pk1ptX3FXgP1W7RJWh2XTYshkaru+7zA59W5RUylV4Y4D6pCGuLC1cv3Muon+uh4GM1O71LwUc3SfUIdB892oRDyDbM/xpvMRHWYyaxH3HaqHfj87yjy1L3aQro8VUwetoGOqPGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757893; c=relaxed/simple;
	bh=j71TcGeaDO5X0uMRUP0MLrRPmTi3MmdQEyXOiGX99tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew3bDvC5onuaZqixm5Qqqoxx3nyv+U2QaqrOBVLs3znE2CRX2a591Lk1gnIi4pekBowPYM3CWOSq6zR6FXLxxEaLHDJ0ovET6E4kooJnP5o1UZAuu2EVhMwJcATC7Klg1pzV7V9dpRu2t4RaVjJWXC03z1PsqmwcuFxebjxsxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFtM6yb7; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-851d2a36e6dso3454550241.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730757890; x=1731362690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cc0tCbkyMIi3MpKCwFn2JsVOi2X3ZT24UpFB4EpKLs=;
        b=AFtM6yb76GkJ0TKPtV84eqtVMuZiNpGP4GIDavVlV/g103mn5VcpVzD0BpEh93juHx
         Vgxb+0C6kMGrUu2G9e920n0l7cVcCFElt/bcUyJnb8gQZfJboLZJqn1lIYtndPRtLrMP
         c4nVnrjOqNWYFXeFCpDSiUhKaayF6Ydd0dgIHcJnfLOQ+v+zF5egHqdLYxFjW5oKzq8S
         yO+01Q348ZeHpCupjHDs000f7GwQ48z1ZaPtQPQvIGs+olpIMZjr80OefO8a5HvR6zkg
         bXq9TwfZ2GOQ0013KBnglAtNvusuqZ7MwpOEeZGOS8c/uj/SLOKmtm2dSfcXB88zviVC
         zoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757890; x=1731362690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cc0tCbkyMIi3MpKCwFn2JsVOi2X3ZT24UpFB4EpKLs=;
        b=nZb6Y5w6I2dcKkz6acBGOg3aHOXN8yBQxd85jYe86i6elJ8jWSelAUBPzg3rMYdlUU
         Qglit+jZQFatZZsuVuiK5ct/U7/mu8i1OlvHwBiChk+Zkub4vsN9fLQB9JpfD/6nWll4
         I5hWKTD/lncLU7jV6m8pNeLlCYIptdkaG2+/Q4wPyj+hLe4Vfq0iC1prutrhsDW6ubXF
         U9NiS0/dlywobuU1XWeVy9MN6BnscVBYFxmFphCST3TrnqQorpUw1QIsiFSLVlt6KM0s
         UCGgzbdIxBjnzA+Yz3Lkbp9WKH05C3It9wltGx5DuERscXuh6caQfV5+vOCG/YTgHX3P
         4H+w==
X-Forwarded-Encrypted: i=1; AJvYcCWFnfswoHtnIWPCtDrm93evP8tvpR9BVPe9BQIlMPAk0+8ohupIbTLLaj/Fng/mY06h2Jx4JdOvE0XBqfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PpQR/kNSqhfa87t/jNLOS/xQbOq/Z97GTJgnvdhJFOwhLe31
	a5Om78TXBYmlnDqnFQbuZCNolNtKT+3SNabZSRvjQKXKn0EQMO6/8HC9dgLaK1yaaU/WjhsTFJC
	k+OFCUkhjluSwzuhTvWMnRumGkBikt7vAZlW9
X-Google-Smtp-Source: AGHT+IHFoZwB9UJQ/W7UPJWTT6Mwf1OXIt2PanaSLVRWyM98+DOHGoOSiH002T//dMssG37gkEwNVD1jyiUDrfB47Us=
X-Received: by 2002:a67:eada:0:b0:4a3:c32a:dfbf with SMTP id
 ada2fe7eead31-4a961b8080dmr9219748137.9.1730757889902; Mon, 04 Nov 2024
 14:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
 <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
 <ZykEtcHrQRq-KrBC@google.com> <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
In-Reply-To: <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 4 Nov 2024 15:04:13 -0700
Message-ID: <CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 2:38=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon, 4 Nov 2024 10:30:29 -0700 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> > > On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt@l=
inux.dev> wrote:
> > > >
> > > > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > > > While updating the generation of the folios, MGLRU requires that =
the
> > > > > folio's memcg association remains stable. With the charge migrati=
on
> > > > > deprecated, there is no need for MGLRU to acquire locks to keep t=
he
> > > > > folio and memcg association stable.
> > > > >
> > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > >
> > > > Andrew, can you please apply the following fix to this patch after =
your
> > > > unused fixup?
> > >
> > > Thanks!
> >
> > syzbot caught the following:
> >
> >   WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x=
250 mm/vmscan.c:3140
> >   ...
> >
> > Andrew, can you please fix this in place?
>
> OK, but...
>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio, =
int gen)
> >       unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
> >
> >       VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
> > -     VM_WARN_ON_ONCE(!rcu_read_lock_held());
> >
> >       do {
> >               /* lru_gen_del_folio() has isolated this page? */
>
> it would be good to know why this assertion is considered incorrect?

The assertion was caused by the patch in this thread. It used to
assert that a folio must be protected from charge migration. Charge
migration is removed by this series, and as part of the effort, this
patch removes the RCU lock.

> And a link to the sysbot report?

https://syzkaller.appspot.com/bug?extid=3D24f45b8beab9788e467e


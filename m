Return-Path: <linux-kernel+bounces-424651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DF79DB788
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A0B2830FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1119CC1F;
	Thu, 28 Nov 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3yHmpf2z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD819ADA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796838; cv=none; b=SrXyoEJO1Or9EtBDem1666wyU1rtQLVp8ReipAxPaIo2ztskkH6r4GDxWf59M3SigX3gxrJ/u2WVnMwzS7JzDMvQtkFD2rLERRkqSBu+rmnpY4oCyE6mzH8KYa1bquPzn7FyXpvJ9Zb16SqdcZ8XwUYJDozi5af3ZusTiqj7hjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796838; c=relaxed/simple;
	bh=6XDxPEty34eTGMSNtMJUSsKWzjr3QkiT/ZY1/OxWTew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBkhoB5gopaox7fQH6vQkkhPoiI9PnNvnrf1/BASEIJlj1G5nTHFOQdArRJAn+B52kfg3ZnDhB5y7xmo71I+lR34Y8Ky5v/IeiZnpPebB7OUvfMzEQAreFFkmr9U5bCU4in+qq5iGLGsS3Js7wqj0y6Shgl2X8ZzbACgvDcix4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3yHmpf2z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a752140eso6619395e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732796835; x=1733401635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kARs3OMR7SZwBtW0TWcyLkFWqc6w0sy3+x2iKM9UqcY=;
        b=3yHmpf2zqpiF+3ZU53B47pyKB9nvk+d4ekgQeHvyS5EOvY8znz8JC6RIZ7PgSoJurH
         JUEntzlWwg9/fKKk7WRNdo+f6MT4kE9ghVcpmUslMkYe/ea6waxUiJufdJws66pg3hD+
         dv5b79kz9iYSqRfImaLIRynHckdJLiNa7y4QKoGIS/BoNARfDSMwyK+JzkJuO4UglTyv
         l8adfPgm6QVauRaYFwtt7ORSqVBtEK+Q6EJgi0nCpyhe11Dt6wY452tSV9DBVFKYg7jt
         j2EO9UYFgOx1q7RONnsaA6ZAbn7g52IrGS7OdqyFzlZnK3gto+tCH9/BVGH1v+1UUY07
         ePKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796835; x=1733401635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kARs3OMR7SZwBtW0TWcyLkFWqc6w0sy3+x2iKM9UqcY=;
        b=MlNEHpihrniAg9Ro3bgHuipVGzHkYPUi7sDxvLH6Pn99jfKsWouL48jgIxdJhMpdxL
         cz0J9L2FTPhbB0EJbTn36mnxcOZmilFEJzpLC9ScmhPtrt7JF14yuMZYfNcG1rqx7xaa
         tFajqdCMs+v+21fxHVylwYAnVOw07tGEvzwGvKD70IlUDkQjr5reHdZEeXJoljhVVbuj
         UEDXUUIggeRyyEKqvR/NgXUZ2ly2CI5sVbataVWWo3IWhbiBk77lPRlB03D3nc6iA3Kp
         ri0Sr5vwn/uE7/JnES8cDCOkQXRwaOt6LIpmCi+Tf9WWl/Bpf/yrAV2YX0OJOzqOqhdl
         wPWA==
X-Forwarded-Encrypted: i=1; AJvYcCVGN+6Eb51FO/8peaU8MjM2IdJOnjhbtpjg3WgTiM1rGc/MbmDmps9J1rSHvYLc3ncPmCa2N9hUVLX4gLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqV8jMEaVt/GEoEYaczDG1pSIaIcJsfuKCfmyYu2GGWhmgPrIJ
	e/m/mBV5O67tjHjtdf9kV7sUnY8Vvu6drd6eu4FgX7NgbyN7Uwxl7nZXBumPY5GTZB5QnE7l/ps
	Leyn7kIUHNkQzSIS0TK9MrYKyfLaietdR4MkB
X-Gm-Gg: ASbGncvhrZqQVysCRnWLFTLnlbJKH8P9RAERQY96VNy4oYNgT1/F/XGpTMpg7CZYEp/
	Ew9t4qQxHuJJ6xtKaq5NJpDMMcb6HkBzjus94+R6KDJwWviiBB4PFH/vJpypM
X-Google-Smtp-Source: AGHT+IEkERCIeGBJ8BGltoa6+wRnWijLPp8bL9sP35PNF9jXvEWnjvqtbJxvc4qLxkfCVrgrzjnipQiAdSGpxRUopa4=
X-Received: by 2002:a05:600c:1988:b0:434:a239:d2fe with SMTP id
 5b1f17b1804b1-434a9df7dadmr50709745e9.28.1732796834639; Thu, 28 Nov 2024
 04:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLghFWi=xbTgaG7oFNJo_7B7zoMRLCzeJLXd_U5ODVGaAUA@mail.gmail.com>
 <Z0eXrllVhRI9Ag5b@dread.disaster.area>
In-Reply-To: <Z0eXrllVhRI9Ag5b@dread.disaster.area>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 28 Nov 2024 13:27:03 +0100
Message-ID: <CAH5fLggKrb4LZk6JL5A0jJODA1zJs+94AU5NMmyV9ksraigF7A@mail.gmail.com>
Subject: Re: [QUESTION] What memcg lifetime is required by list_lru_add?
To: Dave Chinner <david@fromorbit.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 11:05=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Wed, Nov 27, 2024 at 10:04:51PM +0100, Alice Ryhl wrote:
> > Dear SHRINKER and MEMCG experts,
> >
> > When using list_lru_add() and list_lru_del(), it seems to be required
> > that you pass the same value of nid and memcg to both calls, since
> > list_lru_del() might otherwise try to delete it from the wrong list /
> > delete it while holding the wrong spinlock. I'm trying to understand
> > the implications of this requirement on the lifetime of the memcg.
> >
> > Now, looking at list_lru_add_obj() I noticed that it uses rcu locking
> > to keep the memcg object alive for the duration of list_lru_add().
> > That rcu locking is used here seems to imply that without it, the
> > memcg could be deallocated during the list_lru_add() call, which is of
> > course bad. But rcu is not enough on its own to keep the memcg alive
> > all the way until the list_lru_del_obj() call, so how does it ensure
> > that the memcg stays valid for that long?
>
> We don't care if the memcg goes away whilst there are objects on the
> LRU. memcg destruction will reparent the objects to a different
> memcg via memcg_reparent_list_lrus() before the memcg is torn down.
> New objects should not be added to the memcg LRUs once the memcg
> teardown process starts, so there should never be add vs reparent
> races during teardown.
>
> Hence all the list_lru_add_obj() function needs to do is ensure that
> the locking/lifecycle rules for the memcg object that
> mem_cgroup_from_slab_obj() returns are obeyed.
>
> > And if there is a mechanism
> > to keep the memcg alive for the entire duration between add and del,
>
> It's enforced by the -complex- state machine used to tear down
> control groups.
>
> tl;dr: If the memcg gets torn down, it will reparent the objects on
> the LRU to it's parent memcg during the teardown process.
>
> This reparenting happens in the cgroup ->css_offline() method, which
> only happens after the cgroup reference count goes to zero and is
> waited on via:
>
> kill_css
>   percpu_ref_kill_and_confirm(css_killed_ref_fn)
>     <wait>
>     css_killed_ref_fn
>       offline_css
>         mem_cgroup_css_offline
>           memcg_offline_kmem
>             {
>             .....
>             memcg_reparent_objcgs(memcg, parent);
>
>         /*
>          * After we have finished memcg_reparent_objcgs(), all list_lrus
>          * corresponding to this cgroup are guaranteed to remain empty.
>          * The ordering is imposed by list_lru_node->lock taken by
>          * memcg_reparent_list_lrus().
>          */
>             memcg_reparent_list_lrus(memcg, parent)
>             }
>
> Then the cgroup teardown control code then schedules the freeing
> of the memcg container via a RCU work callback when the reference
> count is globally visible as killed and the reference count has gone
> to zero.
>
> Hence the cgroup infrastructure requires RCU protection for the
> duration of unreferenced cgroup object accesses. This allows for
> subsystems to perform operations on the cgroup object without
> needing to holding cgroup references for every access. The complex,
> multi-stage teardown process allows for cgroup objects to release
> objects that it tracks hence avoiding the need for every object the
> cgroup tracks to hold a reference count on the cgroup.
>
> See the comment above css_free_rwork_fn() for more details about the
> teardown process:
>
> /*
>  * css destruction is four-stage process.
>  *
>  * 1. Destruction starts.  Killing of the percpu_ref is initiated.
>  *    Implemented in kill_css().
>  *
>  * 2. When the percpu_ref is confirmed to be visible as killed on all CPU=
s
>  *    and thus css_tryget_online() is guaranteed to fail, the css can be
>  *    offlined by invoking offline_css().  After offlining, the base ref =
is
>  *    put.  Implemented in css_killed_work_fn().
>  *
>  * 3. When the percpu_ref reaches zero, the only possible remaining
>  *    accessors are inside RCU read sections.  css_release() schedules th=
e
>  *    RCU callback.
>  *
>  * 4. After the grace period, the css can be freed.  Implemented in
>  *    css_free_rwork_fn().
>  *
>  * It is actually hairier because both step 2 and 4 require process conte=
xt
>  * and thus involve punting to css->destroy_work adding two additional
>  * steps to the already complex sequence.
>  */

Thanks a lot Dave, this clears it up for me.

I sent a patch containing some additional docs for list_lru:
https://lore.kernel.org/all/20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@=
google.com/

Alice


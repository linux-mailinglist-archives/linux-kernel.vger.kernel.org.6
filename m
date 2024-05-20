Return-Path: <linux-kernel+bounces-183333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3838C97C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789051C213BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFF8C06;
	Mon, 20 May 2024 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnHVHQoJ"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76112746E
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171318; cv=none; b=ML2A8m94+OrGyMqI4vTqeS21PL/iMaFRd7yEpl4w+kqg/B9ern3+2ZVfACGVfFzJE1fox6YMm1QwHoyiCQyhBqzeTS54ZgimHn+H1y9iKV5kz4uE79wj0hcGSvOgeruldeWmAd78yZI/+QhV3g9iE3ZNnaICPCs+rPVTgrrNnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171318; c=relaxed/simple;
	bh=hfl3RvqgJG+zg4U+kQ1Rt5dKBhsRFBGmr+jlHrL1oGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNt+vxM0KVB/fccTSH6Tu5b7ZJ7VQPbO4YC8kumBwWRi0/eF0Ywb+KSrGBFe/bXQrbCqxEXay65kLiDOSwEjon7+Ep5iw0oRbWI3mH3MGIHqeODsTeW0GOCEAKS5BB5FxSHOL7Sz1/o12x2qTBcO59DpXCDdm+QJne0JrXjZ64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnHVHQoJ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-481398a7381so298507137.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 19:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716171315; x=1716776115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItY3dJ6r9GRDoSvMq3ooAXzy/Y3jWDpnBdowlwHmSnc=;
        b=RnHVHQoJ5Trm5IL2inf4+ryjMYIGGlctSy2QUL+q0JFabdiHXf4H14WCMY/2TPlCTz
         HiNxXk8TTyFA5BLWvIOl61F5zcXo7EuN9Mz10hmePwoWLJq+9PYaMq2cPQo7qP9jJaTv
         iLHkMT2Kw93RK922Ej0NPeY3Hshjzno8phEuHFiYrE4CgTJ2JmucXO65kLAfxOLjZgtO
         QknUJVU3WXBy5t38XxBiAPP2jZz2HxFJTlefIYeMHoLeZ5Qnvy278/eGh/D9MtzKKCVM
         6Kfs9K/bwqIwH4UWrpyL71rr2YaKBg5u0Xar/sWINuhtXM/71tH4LLCJmRZ0pVo8q8Jz
         lWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716171315; x=1716776115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItY3dJ6r9GRDoSvMq3ooAXzy/Y3jWDpnBdowlwHmSnc=;
        b=jUPMtk5meuzxXRg7v16i3hrXjAlxqvCvrkA6N/UHV007IFpIKNtYq3Iqr0+8hK7N8X
         frXNBeZgXdzkRvEC+kP6m527qWqSpl64AcV/bgyElRX9t5CNVaMLtfZb/IgV2Gy+LgIt
         cWVjxpKACkjdNyfICzK0yYZ5leeWnErQ+Ey5N7PTBzpW63iZNdv4KLfFHQQ97i7s1Kwg
         uFKfdPKP5Qtj1jStw24AsXL80LSO6P/XEsR0CSqQuSDmL2eVUVlAmVKpaMHGYr6Mfs2d
         R0Ncq6ehkGUgWPIGBUv6ygMPIuUvq6zbxsL0T81vcI0lxrekoq7lfg/xa4KY62OARrht
         b0cA==
X-Forwarded-Encrypted: i=1; AJvYcCUsBPV+xgTaZ5QL2QAY1W8uYqFi6Mh/HxsglIgmCAuZ2uRR8Ex2qDnTI3r2/qNTg4caQ9Y5PS2DipTM5+A9ojpFMXNT9HhWiCwfIuhy
X-Gm-Message-State: AOJu0YwWUgMdVffMzM/Gb9HwNpy6W1MbeFcpKvs2R2LVNhzsOG9el1id
	V54gXIGRG2Y6Nt1FF5S6q//EOtFhNse0QTZssjry9BBfS7dV+OK3hnplG7UIHE5Hq/YA5CFMFRl
	+2qqRUaPocRA6cqCBbrqqtdV+/eg9k6d9qWk=
X-Google-Smtp-Source: AGHT+IHLIiOr6c/yXHrwB0GZnzQC+NRw3mkL9lwRS6pyms1Fy2BtK39c6kFtX63WC4ag0icy6HIRNhmQLnROLyrLeAk=
X-Received: by 2002:a05:6102:418d:b0:47b:ca6a:c5d9 with SMTP id
 ada2fe7eead31-48077e8122amr22895009137.28.1716171313827; Sun, 19 May 2024
 19:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com> <jllnyxah2czkca4bpbaqshksdjqk7lapgviee6gyajlqx3pcon@qwrf5ooxzrim>
In-Reply-To: <jllnyxah2czkca4bpbaqshksdjqk7lapgviee6gyajlqx3pcon@qwrf5ooxzrim>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 20 May 2024 10:14:36 +0800
Message-ID: <CALOAHbBOzzAv2yHxFACfb_HDHDruoR+3xR7AUGPmZF2m9fvRtw@mail.gmail.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put
 under config option
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	gthelen@google.com, rientjes@google.com, Chris Li <chrisl@kernel.org>, 
	Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 3:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, May 16, 2024 at 11:35:57AM +0800, Yafang Shao wrote:
> > On Thu, May 9, 2024 at 2:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
dev> wrote:
> > >
> >
> [...]
> > Hi Shakeel,
> >
> > Hopefully I'm not too late.  We are currently using memcg v1.
> >
> > One specific feature we rely on in v1 is skmem accounting. In v1, we
> > account for TCP memory usage without charging it to memcg v1, which is
> > useful for monitoring the TCP memory usage generated by tasks running
> > in a container. However, in memcg v2, monitoring TCP memory requires
> > charging it to the container, which can easily cause OOM issues. It
> > would be better if we could monitor skmem usage without charging it in
> > the memcg v2, allowing us to account for it without the risk of
> > triggering OOM conditions.
> >
>
> Hi Yafang,
>
> No worries. From what I understand, you are not really using skmem
> charging of v1 but just the network memory usage stats and you are
> worried that charging network memory to cgroup memory may cause OOMs. Is
> that correct?

Correct.

> Have you tried charging network memory to cgroup memory
> before and saw OOMs? If yes then I would really like to see OOM reports.

No, we don't enable the charging for TCP memory in memcg v1 and we
don't have a plan to add support for it currently.

>
> I have two examples where the v2's skmem charging is working fine in
> production namely Google and Meta. Google is still on v1 but for skmem
> charging, they have moved to v2 semantics. Actually I have another
> report from Cloudflare [0] where the tcp throttling mechanism for v2's
> tcp memory accounting is too much conservative for their production
> traffic.
>
> Anyways this just means that we need a more flexible way to provide
> and enforce semantics for tcp memory pressure with a decent default
> behavior. I will followup on this separately.
>
> [0] https://lore.kernel.org/lkml/CABWYdi0G7cyNFbndM-ELTDAR3x4Ngm0AehEp5aP=
0tfNkXUE+Uw@mail.gmail.com/

Thanks for your explanation.

--=20
Regards
Yafang


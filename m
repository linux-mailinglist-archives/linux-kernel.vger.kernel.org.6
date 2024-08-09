Return-Path: <linux-kernel+bounces-281095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D310294D304
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95494281988
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF82C198830;
	Fri,  9 Aug 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8M5uOVb"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3819306F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216364; cv=none; b=ThN0vEbZvXmrrZruumMXv6Ox7Hq8i+z8sFABngrwGpnl0sg2sE0AP6qjzFMqdOEtFhvWPEE2Rtm0dhmy3fNL7zv9ilGUChaHP+8yeRaICBOYoc/xGOzSwq3dLgeMw69yFjbhSOYSfkQ2CI8xYqIHQK6Dkhkk8nEQWjGgrrsLGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216364; c=relaxed/simple;
	bh=NLUhkN4T1k329vjYkXWhULqBvElnYZGqs0JqvibKTLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg3eSb0k7h/ZcE6P6w5zPZxsDLNIoOnj7FoOSIYo4h/4ostPS44D2OA+V9jiKehzislGjU6a6ksm3xbS43cVBCWtprmEJS+8ljy0uR2HngY8XoPVJLLaxgOf+uU4Jp05w43O/IxKzzK+A8V0gd4zAUTaZGl8lFzPEd38Qc97ONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8M5uOVb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so12896a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723216361; x=1723821161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLUhkN4T1k329vjYkXWhULqBvElnYZGqs0JqvibKTLs=;
        b=w8M5uOVbCjjqD3J+fUEFM8z6AMM2+sklqa/1vAQI1BedM8lzLFOogiTEQJd5gBbnRX
         XV5ESh5KCrjDk5an28TKJ6g3yhC2j6gAoWb1S+hbALgjmHLDmNvWJBjI5Xp3rm94p8sx
         nI6CAUk9UM2BRp3mOYpS66CtAtG4IiJsjJ0PmwtDRVj+VvA+XjoYz96MZbbSnnNxU8su
         JSrogLtTu24CTbD6zpVuz5AvRxZ9o34uwe9XX+mzJSkJQAxJCRnDkf+mhEQSi7DD5Yf6
         kIseiiWD8W2JVJp0dhiK/1kSWWl8E72LG0mgAd2nZN+yPoPMP/LUTPaCwy6Yijn5mmDB
         XMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216361; x=1723821161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLUhkN4T1k329vjYkXWhULqBvElnYZGqs0JqvibKTLs=;
        b=r9kfW1oRwNZraUOoT6LYnmfnD9VFxjujQ2iLBqMAGLLNrrYdHB7CGJgZ5B2uT8GEBy
         A/S7revJxvGR6mT4uezcC8wGNWuewxeCDCitDZKpFqpfeVyCwVHH19mTC8P7Kcqnk1tS
         Fccrvnqp1Y6Vw38UV3tSxlnsBJEO419uxl1ZyVzK3hbn86UIpKc3Wnb5gXSmxmhK6WO+
         3sE2PU9a+S7EyQ+T2CyLMcdVDEHd2xnRGyH1LuJECUzGGqXP7j/8NDWi7kS12oy0PxTb
         syfWHkbs9U+XN8Y9ZZ7WfAes/PyOZ+d05wK4kJfNHCBM/66m3I/jlsWiAc4zQwkfKCrv
         TVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZLMBYi1ECGcrdIQdVEWfMiwrTgJsQJCLpXh399P1GFPVR8g3WPy1tSfLrVRu5vW7JQ1WNEggfBfaNhcgfmlWKCo8ZEooW4zHeJr7c
X-Gm-Message-State: AOJu0YzqKqPxxTP3HFTbmcHxKriiQamyAsXSbvBc9CkrQESiPpE4/LJc
	+G6mBFdLHgR4s2ro9rO2my1HaCKEx6z1l4UttBZrpqqHcvnMlu8/KzfqqC+Tc4Rex+iV5a7x3w9
	v8h3Rn4a2I9SdxbHs3ytEcX3blneCIcFhlNYR
X-Google-Smtp-Source: AGHT+IH2FdbCTQHk6jRUPXYOzJt1FnyqBbnUEuJ7oJ/IN4Lv/62UZaUBVO4VE5lIl+MJ4LjXUxvP6r+/WBZVxeyJtjw=
X-Received: by 2002:a05:6402:5216:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5bc4b3fd7b2mr149224a12.3.1723216360417; Fri, 09 Aug 2024
 08:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <54d62d5a-16e3-4ea9-83c6-8801ee99855e@suse.cz>
In-Reply-To: <54d62d5a-16e3-4ea9-83c6-8801ee99855e@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 17:12:02 +0200
Message-ID: <CAG48ez3Y7NbEGV0JzGvWjQtBwjrO3BNTEZZLNc3_T09zvp8T-g@mail.gmail.com>
Subject: Re: [-next conflict imminent] Re: [PATCH v2 0/7] mm, slub: handle
 pending kfree_rcu() in kmem_cache_destroy()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:02=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
> On 8/7/24 12:31, Vlastimil Babka wrote:
> > Also in git:
> > https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v2r2
>
> I've added this to slab/for-next, there will be some conflicts and here's=
 my
> resulting git show or the merge commit I tried over today's next.
>
> It might look a bit different with tomorrow's next as mm will have v7 of =
the
> conflicting series from Jann:
>
> https://lore.kernel.org/all/1ca6275f-a2fc-4bad-81dc-6257d4f8d750@suse.cz/
>
> (also I did resolve it in the way I suggested to move Jann's block before
> taking slab_mutex() but unless that happens in mm-unstable it would proba=
bly be more
> correct to keep where he did)

Regarding my conflicting patch: Do you want me to send a v8 of that
one now to move things around in my patch as you suggested? Or should
we do that in the slab tree after the conflict has been resolved in
Linus' tree, or something like that?
I'm not sure which way of doing this would minimize work for maintainers...


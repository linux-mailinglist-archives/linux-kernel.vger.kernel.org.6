Return-Path: <linux-kernel+bounces-278446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049A94B056
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED35A2828BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348F14431B;
	Wed,  7 Aug 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUGdu04a"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1413D61A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057945; cv=none; b=MfMm2hH8heKA6WnF+JQ+Awe5TRIQUIbTECo5ndODlDIDivS5d1fdGUidjCo5zOpjyOJi1Lyqj7lcbi61JJ5/4DvIKXKtYBbJzPGiMr/56QZXDgmSnQZs8Nz3808RhUtKnTbxDRBnNkbWEAnca+KoJs8aq05uW54m4sHwtThbqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057945; c=relaxed/simple;
	bh=28n02H8HW6Pc0TYGRccGNja9FnX9bJU9zhIIi0Xar9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMvwAL+O7l+AcTDwnZb6Ia60pDO8VBke1tmTEzsALVEG2tOSKAN5cGYBg9nSW2a15aR3qoiG/fxpCocf2/tEcZE+qu432ib4xL8qh9kUgll/fye2P09d/kneTYSw53xgw2e6kTj16oeLV6d7b36LWm5uguFGcAM+yxPRYANqCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUGdu04a; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so101a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723057942; x=1723662742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdol11eQXlFr/aoPc6yojOHFiXqRC3vd03C+IkTOtL8=;
        b=BUGdu04a+gmh1uhdQczCf0DPvUhdsMbLSSyFz9mJHawwcJ7Dj2/pIPbq71WfrqqcVs
         kjlhHSB5X4ayuF1mUQDNHIRIBQ+cpRfE0aaZOKRJC8DcceFQl/2kJ+RjpZGJWBptsm7z
         5Q/NRpOYiZivFJDEP2GbnXwKnxzP8QeY/ZqqVD2d2SQxcA0XwrDfiR5YVNYQuJhQyEVC
         2//Re3X0RgYvmEfJp6ocWfZDQLYchWE/toQJ7nrFU/oWwDiuKwF5liUSdxO98VcOiGHy
         skhfQ6BEQo2+cfS945EC/TU0S+Y2l8FdN6h9sUPrRykuU4DHUg0dTM7rWrktpJBq4O3x
         VW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057942; x=1723662742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kdol11eQXlFr/aoPc6yojOHFiXqRC3vd03C+IkTOtL8=;
        b=Tm8NE4brmJUvrmMObgTCH9U6elPuPznN/VlLwHZELlpoX0QjUcUNmwCV8VRIIGTJ4L
         A6/1pesLe/ScOEDAZ1TdsXVKsxxi0NZGHHddQPxsRvyFshQk5KIq5Vbt0QKq0foPvXDN
         DzxbzhE7GTqMSsfc+g0ZWgPjxXzyjeKsXemCqkoOdc49N78ayOyfnHhef/nyFbrPh/FG
         CtYrdRGZneWDtAJcmwj9r9RYI/4lmhS5OgvoW8JsOjL/bFotRfNnZXp20nd7DmXV2UlC
         p3NwMBWi6d8RcF5bUjCmPejfOAOrYIrm6U+uOljsQqWaATIeU9ezjXm2XKTPX8r1PA96
         unIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEQyAd7/K2KCfGqeEvYgEHCacOCLIvX3Aj2uRGpgXlAHK2EsK/O/4r8Bb8TvS75uzrx8/VrRv0/LG27l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYnWWueHKInf+ZRLRdr3vmMI8lL1jlZNYMVZ10JcqSjRLQ8/No
	q1BQ/0o3DSzlf5VDxGeRaN+noeJrLdpSCqwauURah0xi+KY3wF9HBcITILQqOfwt5Et5o/s/QCR
	hwXrIYiE4itYNL8ZhrYMBzhQVWJKpy/10C1BK
X-Google-Smtp-Source: AGHT+IHI8ozKeg1eUwXF/L2a3aplYWabRcP3x7xsW03VY8Q8ShqjXFas8Okvtx+YM8/IB+Tu8ohgH4Vx4DcsOmmjnU4=
X-Received: by 2002:a05:6402:2686:b0:5b4:df4a:48bb with SMTP id
 4fb4d7f45d1cf-5bbafe5dd90mr36209a12.0.1723057941805; Wed, 07 Aug 2024
 12:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-2-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-2-ea79102f428c@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 21:11:45 +0200
Message-ID: <CAG48ez1nuA5bwDUWpwOoMdVqdjhgSKMc+mtFwuH6pbbz51CA_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mm, slab: unlink slabinfo, sysfs and debugfs immediately
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
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

On Wed, Aug 7, 2024 at 12:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> kmem_cache_destroy() includes removing the associated sysfs and debugfs
> directories, and the cache from the list of caches that appears in
> /proc/slabinfo. Currently this might not happen immediately when:
>
> - the cache is SLAB_TYPESAFE_BY_RCU and the cleanup is delayed,
>   including the directores removal
> - __kmem_cache_shutdown() fails due to outstanding objects - the
>   directories remain indefinitely
>
> When a cache is recreated with the same name, such as due to module
> unload followed by a load, the directories will fail to be recreated for
> the new instance of the cache due to the old directories being present.
> The cache will also appear twice in /proc/slabinfo.
>
> While we want to convert the SLAB_TYPESAFE_BY_RCU cleanup to be
> synchronous again, the second point remains. So let's fix this first and
> have the directories and slabinfo removed immediately in
> kmem_cache_destroy() and regardless of __kmem_cache_shutdown() success.
>
> This should not make debugging harder if __kmem_cache_shutdown() fails,
> because a detailed report of outstanding objects is printed into dmesg
> already due to the failure.

Reading this sentence made be curious what __kmem_cache_shutdown()
actually does - and I think technically, it prints a report of only
the outstanding objects *on the first NUMA node with outstanding
objects*? __kmem_cache_shutdown() bails immediately after seeing one
node with outstanding objects.

That's not really relevant to this series though, just a random observation=
.

> Also simplify kmem_cache_release() sysfs handling by using
> __is_defined(SLAB_SUPPORTS_SYSFS).
>
> Note the resulting code in kmem_cache_destroy() is a bit ugly but will
> be further simplified - this is in order to make small bisectable steps.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>


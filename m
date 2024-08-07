Return-Path: <linux-kernel+bounces-278445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB594B053
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D478F1C2141B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD8143759;
	Wed,  7 Aug 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iI/SKBmj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02313D61A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057940; cv=none; b=XiAsWN6M/THFaNKFA0bg4L9wB/xXkTdeY02gZ5QLtwjE5RoH5wBjetve9hc0IiOA3lcK8ef63oc1CrbQ9XSC/UpmgpRjPOkL2FgyVu4ERjAsv2gJpZOxGOyF4OXRUwqO3qwAlllZU4KLxPw0CjdK3LSP6VPN7l0x+066uEXd36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057940; c=relaxed/simple;
	bh=2X2h9LiJJRq0WAJU7n+3LeTpaoc6WL6ZoTN7c5aELvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfvN6vTrrb9YtALhRm3vF4tCBPOYyfS2dz/NDc0Pz/gk8VwF5Z27KUgdY9pVNcJM4Y6p3f7Dqe9Ccn/a2qO6KAK0F94o2xI9nYpZ60oz/kX9ZC6GZME/Rwe5oKCTyvEGvVxg2GfziElRfMV9JYBpSg6eIF9LE4H2STKEZv/5OF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iI/SKBmj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so88a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723057937; x=1723662737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X2h9LiJJRq0WAJU7n+3LeTpaoc6WL6ZoTN7c5aELvE=;
        b=iI/SKBmjbgrCKCOydEl8isayp22/7/WXRT3ecZu+rJoWBkwXG9AwV51xWWm/Ow27WN
         RkvgiHR0cWtu4zjwOHO6pGPzBOTR8VxtZSET/6USI8T8aUv90Gi9feBX7h0yr/b36hsI
         TUBNaG0GO9ochb8rG0JG7gMG6M8pNX5WjsAtS90M0UMLRKwYMovejzYDW37B/UcFwczb
         +sfwjUosNOHf7LwWCBONpHODSnit8/UUQIagBSPTi/wrSBu/aTF0qbR2zN3LK5in4OEN
         3pUbxMyVfnlZYer2MmeDG5jsrVSN9TVgY7mcyBBTAxeXWjYVDIcQNLDfbJD54bbKgEjF
         Nd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057937; x=1723662737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X2h9LiJJRq0WAJU7n+3LeTpaoc6WL6ZoTN7c5aELvE=;
        b=m6/hhhygMFRB9TgGIkLMM+oMXcCbJ7RY6O3AGG9MRaW67E3DJj3/CArz+cyo+jhEJN
         DbuRACf2fruszkbM09+8HT27qPXb1grhqzn4b7CBffMUSiabjSPE3edqVoFqhxd9dn+c
         5nyoVMb5L0J08N1OFrmRNLb3FXLtYA7rASyGc7I6/disHuO8D86364gYySDjxBfCG/7w
         sVhlgH0/LnmjFE8v8p15s4qyw21vShWaqrnfml5NWE7JwJ2nhGLoZ/miTCm+Hou9hnwl
         OK60qoS5Cn2bSHHe3+wtnEVoyr9Q57iqronLHRKheFEq901VhKHYsXiNfnduKn+VjI2B
         4NQw==
X-Forwarded-Encrypted: i=1; AJvYcCUA2uvOlFy+g3R+s9RskolyDyQoCrCRamF2PtkYSICtmKjOYS9SAXjSS5Cw+pVxOOsMmmR+EbFKIzbLkzwOtBt0T6t67/SERMO8mUUs
X-Gm-Message-State: AOJu0YyRvVBiNwKfv8Z+r2983u2RkVUh6KJzbRynsSA5sv1kyJJUL0mW
	LszWbsEe5qyee9UTY6MQspSqqzKvqxb+BynGihhxAkPtLYAq/0u9OaFaW+IHtYyiikowHeohGNX
	XxEc9wf6hIv+qC+t2lcUx6+oCtgXx45pHZTqU
X-Google-Smtp-Source: AGHT+IGl+QLY/JeOk9uLTXZpix+8pBmxBKzxAVmZdPD/JP2FYHZQYL2R8eq4pkZGbizVR/lDwOnfM0bZq0HQLVUJLes=
X-Received: by 2002:a05:6402:2791:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5bbb002ac3dmr19257a12.3.1723057935560; Wed, 07 Aug 2024
 12:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-1-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-1-ea79102f428c@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 21:11:39 +0200
Message-ID: <CAG48ez1zR6+FxGFTT5=AmzLkwVSWfBDXsSOPs3pWW96ncZz+bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mm, slab: dissolve shutdown_cache() into its caller
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
> There's only one caller of shutdown_cache() so move the code into it.
> Preparatory patch for further changes, no functional change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>


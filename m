Return-Path: <linux-kernel+bounces-210513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 711AA9044C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09E81F2152D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB3153509;
	Tue, 11 Jun 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyW7TdfS"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4B1534E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134325; cv=none; b=RHPpW0+TuKbX6g25rFb2sr0YgHHkEbRoEjjAiUeLlFsRYAstzp933AmjuVYqYzdittFV5sadypFQ7SNjySUEVQBq2AXdrr14i5v/UGUmqxSKrUbYSg5hLpUf27+UTj2XkZpFO/Is3Y94acUuF1M3QbFGlBHh5MKwXH9pCbaC13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134325; c=relaxed/simple;
	bh=HNJGGDKiUXV0UHNc7j8h4Hn1xFEM6rnp5iYnkzwQc14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5XC43codKM2o1EniaKnm1OZRuEt3Gh7Vu3FWOeq+PhykGSSn8KHtxx3Va8uB1vmyGO8MNJO/CVnz0HwVAbCA1g+tM18gimPLi6wqXLWS7ZEyAutwoGf9c9Tyj8QG57dXafYZL4LPlpafDw3RTlKO/FVQy1XXAnowfwZeXK9FSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyW7TdfS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6ef8e62935so193002466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718134322; x=1718739122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6NHyMlh1XjpM0rUHf3UC9mWBmlaeBrABi+eYS7la6Y=;
        b=YyW7TdfS5cir1jHzpNj9h3ybNsWffLEXgivHxv4gKMWOCm6fUYJo6PqdeqspMg+tu7
         vQ1M7xtYwytGrJl4ILFmtOclIbOGBxLyhT3TOhWTWn6CfIetq7NvrKeL6p25+2XzBBjE
         MSmBDM4CYulFPVbRf73MoapLQYKFmIA7tVhWGHOu4HVfq83bqlBLb5mMTwi5SEVgFVoZ
         l0sz48ZcSYRePtAc5Acq4Vk7c00ASZyUSDM865skb6g3t+HOpQhuM+ptD30rCrUGliZA
         DMGuilnYHMyt92aVgBk7M372sDAa/9ht2/fhYm9CMt3PyRYG3LDQiZIPDjzZgbHo16IW
         9M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718134322; x=1718739122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6NHyMlh1XjpM0rUHf3UC9mWBmlaeBrABi+eYS7la6Y=;
        b=RURnpoJL2qyELODIBPdhWFDoAlZq82dxhuJhO2Vpj+XWZ4QTdoVqN4GuoZSygEnsh5
         kaCFcUx8xcHiNuEsrgy04a7+YS9EL5ckoAx505X22eYsjIeqAH6hDFPtXaJXNHRhdLb3
         Ma+ZBqHTh6T8RFNraWXz4BiXRiuUoTKvYPlb3MHpoUwH9jULn7pAfHJl3hQBQD8K3SN2
         xlFWtrm4IQ5dsSNP6GUnTwEwrr7H1+KTy+x3/An4GsZooN2uwbgfTrnfO9SO/Lf+yrV2
         q7Wr5PiMk7HcpHDWWlh46hSic6larWX+kKjQk/5suJ5MmZZ7Ch8m3tXMc149DyZBcMDb
         FX5w==
X-Forwarded-Encrypted: i=1; AJvYcCUKHrEXc4+lPcpjFs3JjkrFOLl9Ot8ttCwZnvdNDKc9WUIpWLf9Omu6JRw+0ehuv8bxYJQ3/eKXCQVKMxt735RJrhUJMJj09WYw36MM
X-Gm-Message-State: AOJu0YyLveRW9G/YI6TvBkxxFf8HST6qHyTGc1EHEi27mCZafFnXnsNK
	hVeqcN5a0NlNi22UDfFHkbqw+qPQ57pUwprnbfNuGnEUO1KosKEEA3OqGcoegc2iL7K9xczCD5e
	s5D9jqQKjelEKP/YzPBuWfvDEPJ2sxuoC6+l/
X-Google-Smtp-Source: AGHT+IExfj4luHZ81TErnishCsFt0Gz8tNLLIOMBYI36AT2E/MwqrUGy8quklbIqIexFlV0Wz3Fp9vvk4zfubgQF6a0=
X-Received: by 2002:a17:907:9448:b0:a6f:1e23:c4af with SMTP id
 a640c23a62f3a-a6f1e23c744mr639377866b.62.1718134321446; Tue, 11 Jun 2024
 12:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com> <htpurelstaqpswf5nkhtttm3vtbvga7qazs2estwzf2srmg65x@banbo2c5ewzw>
In-Reply-To: <htpurelstaqpswf5nkhtttm3vtbvga7qazs2estwzf2srmg65x@banbo2c5ewzw>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 12:31:23 -0700
Message-ID: <CAJD7tkZF8_Xhf-EAdUjWMRd9n=1cUeVV+7w+mJ9qM0Unf6Phbg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add swappiness argument to memory.reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>, Yu Zhao <yuzhao@google.com>
Cc: Yue Zhao <findns94@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Dan Schatzberg <schatzberg.dan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:25=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> Hi folks,
>
> This series has been in the mm-unstable for several months. Are there
> any remaining concerns here otherwise can we please put this in the
> mm-stable branch to be merged in the next Linux release?

+Yu Zhao

I don't think Yu Zhao was correctly CC'd on this :)

>
> On Wed, Jan 03, 2024 at 08:48:35AM GMT, Dan Schatzberg wrote:
> > Changes since V5:
> >   * Made the scan_control behavior limited to proactive reclaim explici=
tly
> >   * created sc_swappiness helper to reduce chance of mis-use
> >
> > Changes since V4:
> >   * Fixed some initialization bugs by reverting back to a pointer for s=
wappiness
> >   * Added some more caveats to the behavior of swappiness in documentat=
ion
> >
> > Changes since V3:
> >   * Added #define for MIN_SWAPPINESS and MAX_SWAPPINESS
> >   * Added explicit calls to mem_cgroup_swappiness
> >
> > Changes since V2:
> >   * No functional change
> >   * Used int consistently rather than a pointer
> >
> > Changes since V1:
> >   * Added documentation
> >
> > This patch proposes augmenting the memory.reclaim interface with a
> > swappiness=3D<val> argument that overrides the swappiness value for tha=
t instance
> > of proactive reclaim.
> >
> > Userspace proactive reclaimers use the memory.reclaim interface to trig=
ger
> > reclaim. The memory.reclaim interface does not allow for any way to eff=
ect the
> > balance of file vs anon during proactive reclaim. The only approach is =
to adjust
> > the vm.swappiness setting. However, there are a few reasons we look to =
control
> > the balance of file vs anon during proactive reclaim, separately from r=
eactive
> > reclaim:
> >
> > * Swapout should be limited to manage SSD write endurance. In near-OOM
> >   situations we are fine with lots of swap-out to avoid OOMs. As these =
are
> >   typically rare events, they have relatively little impact on write en=
durance.
> >   However, proactive reclaim runs continuously and so its impact on SSD=
 write
> >   endurance is more significant. Therefore it is desireable to control =
swap-out
> >   for proactive reclaim separately from reactive reclaim
> >
> > * Some userspace OOM killers like systemd-oomd[1] support OOM killing o=
n swap
> >   exhaustion. This makes sense if the swap exhaustion is triggered due =
to
> >   reactive reclaim but less so if it is triggered due to proactive recl=
aim (e.g.
> >   one could see OOMs when free memory is ample but anon is just particu=
larly
> >   cold). Therefore, it's desireable to have proactive reclaim reduce or=
 stop
> >   swap-out before the threshold at which OOM killing occurs.
> >
> > In the case of Meta's Senpai proactive reclaimer, we adjust vm.swappine=
ss before
> > writes to memory.reclaim[2]. This has been in production for nearly two=
 years
> > and has addressed our needs to control proactive vs reactive reclaim be=
havior
> > but is still not ideal for a number of reasons:
> >
> > * vm.swappiness is a global setting, adjusting it can race/interfere wi=
th other
> >   system administration that wishes to control vm.swappiness. In our ca=
se, we
> >   need to disable Senpai before adjusting vm.swappiness.
> >
> > * vm.swappiness is stateful - so a crash or restart of Senpai can leave=
 a
> >   misconfigured setting. This requires some additional management to re=
cord the
> >   "desired" setting and ensure Senpai always adjusts to it.
> >
> > With this patch, we avoid these downsides of adjusting vm.swappiness gl=
obally.
> >
> > Previously, this exact interface addition was proposed by Yosry[3]. In =
response,
> > Roman proposed instead an interface to specify precise file/anon/slab r=
eclaim
> > amounts[4]. More recently Huan also proposed this as well[5] and others
> > similarly questioned if this was the proper interface.
> >
> > Previous proposals sought to use this to allow proactive reclaimers to
> > effectively perform a custom reclaim algorithm by issuing proactive rec=
laim with
> > different settings to control file vs anon reclaim (e.g. to only reclai=
m anon
> > from some applications). Responses argued that adjusting swappiness is =
a poor
> > interface for custom reclaim.
> >
> > In contrast, I argue in favor of a swappiness setting not as a way to i=
mplement
> > custom reclaim algorithms but rather to bias the balance of anon vs fil=
e due to
> > differences of proactive vs reactive reclaim. In this context, swappine=
ss is the
> > existing interface for controlling this balance and this patch simply a=
llows for
> > it to be configured differently for proactive vs reactive reclaim.
> >
> > Specifying explicit amounts of anon vs file pages to reclaim feels inap=
propriate
> > for this prupose. Proactive reclaimers are un-aware of the relative age=
 of file
> > vs anon for a cgroup which makes it difficult to manage proactive recla=
im of
> > different memory pools. A proactive reclaimer would need some amount of=
 anon
> > reclaim attempts separate from the amount of file reclaim attempts whic=
h seems
> > brittle given that it's difficult to observe the impact.
> >
> > [1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd=
.service.html
> > [2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins=
/Senpai.cpp#L585-L598
> > [3]https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmN=
dbk51yKSNgD7aGdg@mail.gmail.com/
> > [4]https://lore.kernel.org/linux-mm/YoPHtHXzpK51F%2F1Z@carbon/
> > [5]https://lore.kernel.org/lkml/20231108065818.19932-1-link@vivo.com/
> >
> > Dan Schatzberg (2):
> >   mm: add defines for min/max swappiness
> >   mm: add swapiness=3D arg to memory.reclaim
> >
> >  Documentation/admin-guide/cgroup-v2.rst | 18 +++++---
> >  include/linux/swap.h                    |  5 ++-
> >  mm/memcontrol.c                         | 58 ++++++++++++++++++++-----
> >  mm/vmscan.c                             | 39 ++++++++++++-----
> >  4 files changed, 90 insertions(+), 30 deletions(-)
> >
> > --
> > 2.39.3
> >


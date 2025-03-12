Return-Path: <linux-kernel+bounces-558319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCAA5E452
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB6B17B524
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787425744E;
	Wed, 12 Mar 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H84PZIOY"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954EB1CF96
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807466; cv=none; b=BHRXX+CbjNdM6jeU3yf1JF8WEizxilS1GpnEpG+cyKuwfq8/6rEZT7uLXJqo5qbKN0xyBKhqPrVpnAGby0hwvYcQmhhA2dISBJXxkWKBuTJonbY1xPCCtQCGTD/EXe8JmA4RYh0wqGGfpDDn88m4YUigir09FZIFHK8YwjZGs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807466; c=relaxed/simple;
	bh=ecx/mALSmVD3DKmAP7pAnfHpiGaII93VAa1nLItOJZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tnc8JLfAG4TtSaCXZK+7tduxq1rvCS4PnlewxNDMrvDa+ePy/C4k+3/ozvmXN+FDEecNkhFSPLp+5nyxyv1OVAEr0iYZ6DxxY1uHYdbFnEndQcctQI62K5rwC87GcltgS9tEuiL7NeYp2RhxLwuUULFicy4L//CxRNCKYZ42vL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H84PZIOY; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47666573242so2061cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741807463; x=1742412263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecx/mALSmVD3DKmAP7pAnfHpiGaII93VAa1nLItOJZU=;
        b=H84PZIOYBpR/38okdFGp4sD/Z/w4crMrfFciVhJE3Je55PuN0Rgn3Zd6yZm53hqlth
         ykKw2wK37ItAZExpqEK2V+BaFHa31Z/h/tcu0jgKn9+wiZ+ZCCC9xCo+khuUbv8SFJME
         fzdG0xcsfpSyPFooIidJTmh9a5ewflHCaJmWA2EottV+twSk89wU7jnNo8QDJJ5p+Uya
         Wg/XuxPKDnCyfIMCLnKgh9EVZU8+ADIMVuGtQhoFvOyLjedvP3u1mKOtrgV1zOhN+POp
         ZXv6HSPSULmTJYRZMMbQ/XMDITM3FgXpQzRP+h/zzTpvwMhRxRO+SH6ZvplWbf3XMVYW
         D4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807463; x=1742412263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecx/mALSmVD3DKmAP7pAnfHpiGaII93VAa1nLItOJZU=;
        b=UKKKuPBg0ttaFiXakHQZ96ZEcyPYK5ELn/rH1M94zlN6pm21xdjCJzUpVm6gJQYKlN
         Gl28nRUytmfviyu+TnqGji3ZW6V5/9KYX6VAd0cd74kMImFuFeEs6cEK95Sd8W8222jz
         q51ZB6YbxX7UG7Lk88sNwyiOu4OMjVsBkZz8dWKrGBpFfHxGepYpomPR5qj4mVX1/6W0
         /VxSNIanKKNtwSVPqk3qxBCqLCsbaK972ki+XZC3C5GhRMsIXfSqYzpVWEFreFOkUcoY
         65J+NbrCQcr8zoxi4h7CeJ7lyCqXzo3rsa3D+REPMiTuTccV1OLXWGqK+vaUqc5GkKB4
         KM0A==
X-Forwarded-Encrypted: i=1; AJvYcCX6oKTS1cn2/XuHZH1/fED7ZqAnS/1envQbqCcrHb9XFudP3bE0OXtnVTJoKa76EazVXjrmZAxW/qzzz64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTroC5Tk0ghIt+Vn1qP3dHt52QwB3h4fnfxhKDQRe3rothjP8q
	Wp053pusSUSGuxgAJgOMJyjCT46s0zF/bTFdhe8s6DrGIfHE5rAlEYslHkh0QFpLUs4yil4/EBQ
	1tzWs+O9R3t4FIHblukCq0o4wxj7AC9smNzocbN+hoBtGL73PVTHMh+F79w==
X-Gm-Gg: ASbGnct4gALZbfPEY9aFxdYb2+hL1d9Wu++yG2gj6opeGX9j5XZ7SuOBBNMbaVhrXIn
	EZPy/dPoEs0F83m1kyrTIVoSJBZBMje5k0en+jjpG4fZvoqlb/FHwDwD8Xoth6jveh9/MfcbQt1
	/JtbfwmQVf9/Bx5O4Okz1v8kMdYVk=
X-Google-Smtp-Source: AGHT+IFi/q9MFA3vtQeN5S+4jf9qTPaP1gNHs88A725CYYOt3oXTiJuZVjsnhi0G1yHpHdPQ9lXwcZ7WVHFI2v8Bva8=
X-Received: by 2002:a05:622a:1898:b0:474:b32b:8387 with SMTP id
 d75a77b69052e-476b924b409mr308821cf.4.1741807463259; Wed, 12 Mar 2025
 12:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
 <20250310074044.3656-3-wuyun.abel@bytedance.com> <CABk29Ns9wq+mB5mAfu72gi3RZkNdwzXmkZSq3FQpKkTEH23dgw@mail.gmail.com>
 <2c8c4cdb-e9b7-40f3-aa83-d82676641162@bytedance.com>
In-Reply-To: <2c8c4cdb-e9b7-40f3-aa83-d82676641162@bytedance.com>
From: Josh Don <joshdon@google.com>
Date: Wed, 12 Mar 2025 12:24:11 -0700
X-Gm-Features: AQ5f1Jr9n7TR6Ts3EAz5r0r6TLvUUFtBJsR-Pz3KBukznmMG62b9WL7nfJy9Yu4
Message-ID: <CABk29Ntuzux+AYEhuDO0EPKEupAEsQ+=OwfSi8VrtUmUXZbHEQ@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 2/2] sched/fair: Do not specialcase SCHED_IDLE
 cpus in select slowpath
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:43=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
[snip]
> False positives are possible, but the possibility can be reduced by
> optimizing blooming setup.

An interesting approach, thanks for sharing. Not that it matters
(given that we're not pursuing this now), but just to call out that
this has poor scaling with large cgroup hierarchies and updates to
cgroup idle state, so in an actual implementation it would be ideal to
do the updates asynchronously from sched_group_set_idle (ie. via a
kworker).

We could also greatly simplify this down if we assume certain
contrived setups, for example if we assume we primarily care about
sched_idle cpu preemption against only root-level sched_idle cgroups
(as everything inside a root-level sched_idle cgroup is trivially
preemptible by a task from another hierarchy). But obviously your
cgroup setup doesn't fall under this category, so it is not very
useful.

> I chose the simplest way for now to workaround the issue we encountered,
> while I am still trying to do something to get rid of sched_idle_cpu().
> Thoughts?

That sounds reasonable to me.

Reviewed-by: Josh Don <joshdon@google.com>


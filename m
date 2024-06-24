Return-Path: <linux-kernel+bounces-227990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB16915976
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C01C210AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09081A0B18;
	Mon, 24 Jun 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6HgShUi"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3D1A08DD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266476; cv=none; b=KUxG21xmQbCvAIYFxGBa3WwmXkMZGwrNfV5H9eCoCXxd6Ve0vUvXUB6Mu3ttsOWpbaMd05tc6oebE5dLUEDfJ3qmefT/P+SWSdsix2x2hNxEM7ILrzCTuLqhI3PT+N//Q2b2fbxkSq3f1xHsQRboMHCVW7UzatQW1X1/s/5KFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266476; c=relaxed/simple;
	bh=Cedoh9kwS2x3muS2xE7G+dr6lA4JTIOOAY37VPCJM44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pzwb4dPx9nBe5c+xxVpLx7QOY7oiHmR0/KONwUVkhnseHyKbNk9DndA7URsOAX+mINtGb6qITnVOAA7A/PZtMgaHOLKuaiRKvsL9S0hweSWL4G0VwCHyKoDSgoTuJfbLFcgHRmFF32Uy0Q+8ux4PyNOXNNB4OjQtKs5Y9GEdPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6HgShUi; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c20f814d0cso272448eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719266474; x=1719871274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw7MOMKXjuvTBW5Fb0DPZK7hr6TUBg6gf25Mlt5UQm0=;
        b=e6HgShUiEgEQxtSgbfXQseRYqXH8hiYcttX67FTMQhjqsfLvo5UIuo/3AuxmoG/41n
         hfNhtdOWDZZbV4APeR6L0I0BiJKmYo21r03zzMRTnGleW/U6q0QXovDic499uTcpPmTi
         pS32anJ9qKZxAwaAjTK+cd60sA5MOfsuJLH1w05NzbpSS08q+bVmqC+PxjKBYN3NE0CU
         4YgcWxSHPfO/xg6min8tSD6yo4DwD4wg50dSQ9FuXcf04OZRD2BN5we462CujV2FqMV1
         gfPittDGeuiy4CQN5EeJFw1IgXkbFmLkj22brtjEtMIHWobPvbsF7U5Fs3iRXRhVAri1
         iUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266474; x=1719871274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw7MOMKXjuvTBW5Fb0DPZK7hr6TUBg6gf25Mlt5UQm0=;
        b=F0mkFDSqFnxjSmVppgvLlTOuUH5UwQrlzZm4xzoMDEXX1yOhL3sMbf5zuY2RGGxrR4
         heYARTiD3cPSrOGOCitCek0Wp0VmOeqgoV2BMLfi9cEngO+TMhDpJxnxi/4g1jk8suXQ
         UDr6t4HiQOtoMHRa2Bd2msQYattnOcY9cNX9pP2HOC89uHzqkfvmGLwimbGC2zwVBWdL
         FUacqAKEUjmfhkH9yMJOktqVrZkAX3+I3QTCch8lHVLWohvqypf9oaV5w/0xO7aTaUQp
         wVG37gBNdpixEkxGZaajgh/w63UqkM1/Rrh1R99xyFy6M85mGQgo3LeC2npk2CuiKv0/
         uFuA==
X-Forwarded-Encrypted: i=1; AJvYcCXpa2TBqM5XMcPn5Cv35hAx7fDNQe8yWcmhpjxa0ivHKsyD8m0G5opRzYfZoSi9rH9EKqVe0vSKoDoZEDyADCLZg3CDJBAEyl/T7nPq
X-Gm-Message-State: AOJu0Yyr0/csrotieqzuE2kWzQsqCS0Yh6RgC8lzSqIKqJXeNXdu1uwW
	DuoMWFI4+h+PAj/Uv1/GwKMtkmXjdOXeHlC/w3CUbOrPRUhpxxjH6oloT9kA57yCUAuTOKEoFrb
	vcH5QrXJJG4lHjquOfWqqItHBt1ShAcl7aD4l
X-Google-Smtp-Source: AGHT+IFseBLL+dDi4e4qkiKuQ0dqQDnZRl+TT6zxomA87Pc+8TKWbKHAG0tHRegXChGBzohq++KJQjkxk5F1D4i5yQc=
X-Received: by 2002:a05:6871:609:b0:25a:50b3:514f with SMTP id
 586e51a60fabf-25d32cae21fmr750979fac.25.1719266473627; Mon, 24 Jun 2024
 15:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <ZnSEeO8MHIQRJyt1@slm.duckdns.org> <87r0cqo9p0.ffs@tglx>
 <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com> <878qywyt1c.ffs@tglx>
 <612c8f18-21e5-452d-8e9f-583f224d8e54@meta.com> <Znm22Sgt-rIU_sp5@slm.duckdns.org>
In-Reply-To: <Znm22Sgt-rIU_sp5@slm.duckdns.org>
From: Peter Oskolkov <posk@google.com>
Date: Mon, 24 Jun 2024 15:01:01 -0700
Message-ID: <CAPNVh5dSMOfb1LEM_Djo8YyhpMd7GE_CakN2mj9NiUBoiCdWjA@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Tejun Heo <tj@kernel.org>
Cc: Chris Mason <clm@meta.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:11=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
[...]
> > >     - How is this supposed to work with different applications requir=
ing
> > >       different sched_ext schedulers?
[...]
> Long term, the tentative plan is to support a hierarchy of schedulers whe=
re
> the intermediate schedulers are responsible for granting CPUs to leaf
> schedulers which are responsible for scheduling tasks. Barret Rhoden has =
a
> framework called flux on top of ghost which already implements this albei=
t
> with compile time composition. Nothing is set in stone yet but it's likel=
y
> that I'll follow what Barret is doing in many parts.
>
> Taking a step back, because sched_ext currently supports a single
> system-wide scheduler, many of the techniques that the current crop of
> schedulers are playing with are pretty generic, at least to a class of
> problems - e.g. gaming.

[...]

> So, the summary is that there are plans to support a tree of schedulers b=
ut
> we're currently mostly focusing on more generic single scheduler
> experiments.

[...]

Yes, as I've just mentioned in another message in this thread, we plan
to explore building UMCG-like per-process scheduling infra on top of
sched_ext once it is merged into the mainline kernel. This is not a
promise to actually do that (build such an infra); but rather a claim
that we believe it is possible to do that and that we plan to look
into the technical details once sched_ext is merged.


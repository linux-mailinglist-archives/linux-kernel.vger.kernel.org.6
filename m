Return-Path: <linux-kernel+bounces-229805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2491746F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5689B287F69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B788117F4E8;
	Tue, 25 Jun 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntt/ncd9"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140514A61A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719356390; cv=none; b=bOmhcIvNdreArJ88aDPOoy3J7idE0daSN0IwVaRrDto+gYGmUN61e157pnBI80ORgBEE/y6JtwTGOYoFsfyRMPM+LFDsQufn9T78vwl7KOYgd2csJ+hHwgHJiSVQmK4LVhM4qyQwuayg2RwRkGMtNbnJatLWETAATfmhqGgrRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719356390; c=relaxed/simple;
	bh=4nufzVyDas6rqXanqk2DFPV+HJQhWvNDqqsfFSssBLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu4Qisf3u7WilHQK5jC3zSuYsXpBQD5GWQd0314xtWpG1nCxwBci2KrKEfYboeZEg846nt77bDd4K/2r5g9b68/tblBFF9Cp341sISrBbl9WyIOP+s92gZv2dodbAfquzInaOdnRo7nO02hkMFdawRUSjzE4vZjARhkhiVDWqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntt/ncd9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a724b9b34b0so356593466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719356387; x=1719961187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nufzVyDas6rqXanqk2DFPV+HJQhWvNDqqsfFSssBLc=;
        b=Ntt/ncd9KledG0mncvVF1FMqlcDTX8GHg7ohIYXQGxgIYguBZvpQVq90qYC2qPXJs8
         XzXZF5IdAjlEMPAI3EUPyc5pIPShvqcftbNnLP6KglErMYhT6QXPVmyCcutLyHHqKmvh
         YD/TnAji1PnAKBV0TYj3OMK/QKYNWZXHRYlBAbtoYUGw00pgwC/awGZaNgQI9gUgDC2g
         4jWrj/jqKIpF5RnG+OJ21mInZykPrInMPbKcv3mjE2a/T0CfXLCBbgvpyIbDlq6m116N
         yS0mXLajOp+Jp8K9AW5CHLqfC88mLAenRnJn7X1nOJUgyx81C7VmIGOAeX96kkpvmxtg
         3j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719356387; x=1719961187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nufzVyDas6rqXanqk2DFPV+HJQhWvNDqqsfFSssBLc=;
        b=RMkGdEwTRmOBj8x1wOYa5Ig0s8zu2lQVJtS9wO2EmkWBksZUb5fIjZpkYP1nKLDlBJ
         JrmC3g/BpObLcYlbN00Hv0Ft0Cw+ci1wJQPazki/MhV1jYRyI0Lo+ueUOQrB53JWG8Cg
         21t27WMANtNKJW/oHlSYVsFfeHodrXJ+97pmYe8HR7GgIb6YybnzewE2VlwjfJpMAEmi
         Ze1AcJtiN/3gKSi2YfX+W9eCGNmuqhITkgkoRJk0Qru0JUB2Bx5yISh+ncekUQBEnhYw
         qdJQaziMVjxqYMGYu5pe5g4hFHUZDy2+X9PZSwAdFig9ifwc2LT6+q1ErHTr5hQdgBWk
         kxXA==
X-Forwarded-Encrypted: i=1; AJvYcCUrdQdGmXX+ipv9954potehYXpotHyKPeWPeUY8BeknYWGdPWqBp/Q9DN3VU+ziQbFLWHDyXM2kUWTXaDyX3fcjUpyKrEcx5HuQkHZ+
X-Gm-Message-State: AOJu0Yy1o0kO/gb4WrEIHiLPRwoLt+uVP6U9YVpZEWbGfwOmTuqwU0+e
	Sif+G/yhOqaPcrUahUelA6qih+zYLhNHQBu32CGDnvpEtOK/3D4n3ow45dMEu+Oz7b3EbeYBO5i
	c7LqAqHq7NQocUdieGMytypCiyoZDh1sy+fRv
X-Google-Smtp-Source: AGHT+IH/dDKhmlHal0QbDpSAnlMkS3U3pY+fmF7rZOA5u540GMB1xG2BZwZsKTdBAW+WPZDRIGqL8k4sWqeHNFO8TvI=
X-Received: by 2002:a17:907:c786:b0:a6f:48b2:aac5 with SMTP id
 a640c23a62f3a-a7245b6dbe0mr547974966b.15.1719356386530; Tue, 25 Jun 2024
 15:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org> <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
 <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
 <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
 <CAJD7tkYqF0pmnw+PqmzPGh7NLeM2KfCwKLMhkFw3sxBOZ3biAA@mail.gmail.com> <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com>
In-Reply-To: <a1e847a6-749b-87e8-221f-f9beb6c2ab59@linux.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 15:59:09 -0700
Message-ID: <CAJD7tkbq-dyhmgBOC0+=FeJ19D-fRpE_pz44cH7fCvtHgr45uQ@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:35=E2=80=AFPM Christoph Lameter (Ampere) <cl@linu=
x.com> wrote:
>
> On Tue, 25 Jun 2024, Yosry Ahmed wrote:
>
> >> In my reply above, I am not arguing to go back to the older
> >> stats_flush_ongoing situation. Rather I am discussing what should be t=
he
> >> best eventual solution. From the vmstats infra, we can learn that
> >> frequent async flushes along with no sync flush, users are fine with t=
he
> >> 'non-determinism'. Of course cgroup stats are different from vmstats
> >> i.e. are hierarchical but I think we can try out this approach and see
> >> if this works or not.
> >
> > If we do not do sync flushing, then the same problem that happened
> > with stats_flush_ongoing could occur again, right? Userspace could
> > read the stats after an event, and get a snapshot of the system before
> > that event.
> >
> > Perhaps this is fine for vmstats if it has always been like that (I
> > have no idea), or if no users make assumptions about this. But for
> > cgroup stats, we have use cases that rely on this behavior.
>
> vmstat updates are triggered initially as needed by the shepherd task and
> there is no requirement that this is triggered simultaenously. We
> could actually randomize the intervals in vmstat_update() a bit if this
> will help.

The problem is that for cgroup stats, the behavior has been that a
userspace read will trigger a flush (i.e. propagating updates). We
have use cases that depend on this. If we switch to the vmstat model
where updates are triggered independently from user reads, it
constitutes a behavioral change.


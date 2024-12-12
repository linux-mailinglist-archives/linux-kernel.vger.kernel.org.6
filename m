Return-Path: <linux-kernel+bounces-443979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E49EFE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0467116B453
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332791CEAAC;
	Thu, 12 Dec 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIDvSdYW"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462F19995A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039705; cv=none; b=oyCddosWRhEiElQC0U/qlEYpZGN5umbBTZkoZM8+dfUkDJQyRoel0dCPEjSuL/Rp09HNQas5BD9YucrwC9StaqoAPUnpL5mK8o4Tq0ZUwwdu+Z1XQxw+6Ndqaa/7Pev6GQdgEbVPrOSwNT/24+iFiENoPvPaw+shWjZqDi7tGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039705; c=relaxed/simple;
	bh=LE9OFiqu8JETZcBBVbs3BGj1PQAvXWnvYreow3dhXuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckWjqjQxULCeoj0c/RmJC0MlhSJNhbVS3IzfOFFomO9He3TRWb+gXrWJ88tBZPQr8f/0Fm9efbt9SsqkcgXkJRaKpB+kVzXitIBpeUt5j86X8jNy9HUN/H+wMHrAnaq2Nb6QaE8sHzn6xcNkWc7POQxitCfDUVrNrHbnle9clhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIDvSdYW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8edad9932so8506856d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734039703; x=1734644503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NndNSRUhbnWB5FGgPp/6wuTx8RdsrYqkoIBIFndV9tQ=;
        b=KIDvSdYWQMXSV5zuzujOqwPO0jXoJRwPQzagSXjHq03RY7TovW+cQP2GYdvnoW4niG
         zZ8xjHHz+07SfcodvLtwrg8P5cOjPtYfPjAAWSweR4i7OT18bXzE+wWZMtDW+T4YPN3P
         MOQhBfTm8GrFQV8xBjvt0TncNxar5N2h8Skkhi8TxmApw91WYktbiIHrtcFf99D6TDVR
         0T8YMPJvjqfU9molaRSMRb0aL/LDX3WCQaZY1zbeH0vQjJDD4wm2syec0Uc/qxf6N8Nz
         x/Y01fKMdUtMn1XY3tAGIvVNsMclWuK7K8sGNmB9gEez8do0FMo8jEzbO6UdPVP2xugX
         QeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039703; x=1734644503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NndNSRUhbnWB5FGgPp/6wuTx8RdsrYqkoIBIFndV9tQ=;
        b=SEHZxTP+qsu+haWCC85u4V+gS4ffOJtoDs0MYBcLJguKUwjnw7gkVWn0lD3LVIt/W+
         Us7qcaW/+uHyH69yCJyS8MQapPp7a5G8fpqhnO4fcwftw3ao6D3ICabV7QwnQavZFdK/
         XYvrcqYH2OpQJqBf890pWYoDJ+ucTjfHHj4h5YYkNNrCUB02okEDgC0H9LnrQS2UJv4l
         XhLM1Ear/kLBP//cL783Lcyp7RNnW0dZRRleXftNLzzpc7tjAdQnI/saFq3fNgb5drp8
         ns67YxvNDoH1VEj2ruydGK+kRY/Ys5uJx9kJpGSPbZ3pHDwNHpDD9pZF7vG1vOMNpT8d
         Yg5w==
X-Forwarded-Encrypted: i=1; AJvYcCXwnswn68TNvMOl3fPiSusMMwH9j4ybaVdE2pOWrI4Zm+9pYhU1/O+MbcrYSBF+keLsM1qMaamDhVRVcPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCMG+I67pSNANvGa932XCjj+vuhqsp4eHcQUfHbiP5/3f59kX
	tos5yP5Op7tvFFqXHxtDhm5/8UagBFFFRjOJn1C+iIA6wKXYs5rBNU9JAExk48wvFzz5tLYqjsJ
	TS77VFGdUnsqSmdPeK/QXGBQ1/pdHBRhTv9DW
X-Gm-Gg: ASbGncsYhyOdFdTzAQQQV182HXG7FXcnw/so4hzdUmeh/Hk1zDY9jTyiFdK8dqZqmx5
	QxmSKHsHWHBurLNyNmREJteXTiBcx23t6s+k=
X-Google-Smtp-Source: AGHT+IEiN0OqoDo2mRZ6+j4V/MCj+UFVGvVBvwOOn5R3E0vFpV1L+QCjP2VAtummDoAgR/xmNi0aDKjZs9bA7K2Lcgs=
X-Received: by 2002:a05:6214:29e8:b0:6d8:a027:9077 with SMTP id
 6a1803df08f44-6dc8ca3da18mr2385996d6.5.1734039702507; Thu, 12 Dec 2024
 13:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212115754.38f798b3@fangorn> <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org> <pr5llphyxbbvv3fgn63crohd7y3vsxdif2emst2ac2p3qvkeg6@ny7d43mgmp3k>
In-Reply-To: <pr5llphyxbbvv3fgn63crohd7y3vsxdif2emst2ac2p3qvkeg6@ny7d43mgmp3k>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Dec 2024 13:41:06 -0800
X-Gm-Features: AbW1kvYrG3xeIYEdjZ61h5ymWOc_3UboGjPg4dvUyfO_e07qePepWjfMDNNQN3s
Message-ID: <CAJD7tkYMwrLTvcORnXVjQ4s+UMSTZD5jddv78awOPw_DqYFufA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>, 
	Balbir Singh <balbirs@nvidia.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:35=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Dec 12, 2024 at 01:30:12PM -0500, Johannes Weiner wrote:
> > On Thu, Dec 12, 2024 at 09:06:25AM -0800, Yosry Ahmed wrote:
> > > On Thu, Dec 12, 2024 at 8:58=E2=80=AFAM Rik van Riel <riel@surriel.co=
m> wrote:
> > > >
> > > > A task already in exit can get stuck trying to allocate pages, if i=
ts
> > > > cgroup is at the memory.max limit, the cgroup is using zswap, but
> > > > zswap writeback is enabled, and the remaining memory in the cgroup =
is
> > > > not compressible.
> > > >
> > > > This seems like an unlikely confluence of events, but it can happen
> > > > quite easily if a cgroup is OOM killed due to exceeding its memory.=
max
> > > > limit, and all the tasks in the cgroup are trying to exit simultane=
ously.
> > > >
> > > > When this happens, it can sometimes take hours for tasks to exit,
> > > > as they are all trying to squeeze things into zswap to bring the gr=
oup's
> > > > memory consumption below memory.max.
> > > >
> > > > Allowing these exiting programs to push some memory from their own
> > > > cgroup into swap allows them to quickly bring the cgroup's memory
> > > > consumption below memory.max, and exit in seconds rather than hours=
.
> > > >
> > > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > >
> > > Thanks for sending a v2.
> > >
> > > I still think maybe this needs to be fixed on the memcg side, at leas=
t
> > > by not making exiting tasks try really hard to reclaim memory to the
> > > point where this becomes a problem. IIUC there could be other reasons
> > > why reclaim may take too long, but maybe not as pathological as this
> > > case to be fair. I will let the memcg maintainers chime in for this.
> > >
> > > If there's a fundamental reason why this cannot be fixed on the memcg
> > > side, I don't object to this change.
> > >
> > > Nhat, any objections on your end? I think your fleet workloads were
> > > the first users of this interface. Does this break their expectations=
?
> >
> > Yes, I don't think we can do this, unfortunately :( There can be a
> > variety of reasons for why a user might want to prohibit disk swap for
> > a certain cgroup, and we can't assume it's okay to make exceptions.
> >
> > There might also not *be* any disk swap to overflow into after Nhat's
> > virtual swap patches. Presumably zram would still have the issue too.
>
> Very good points.
>
> >
> > So I'm also inclined to think this needs a reclaim/memcg-side fix. We
> > have a somewhat tumultous history of policy in that space:
> >
> > commit 7775face207922ea62a4e96b9cd45abfdc7b9840
> > Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date:   Tue Mar 5 15:46:47 2019 -0800
> >
> >     memcg: killed threads should not invoke memcg OOM killer
> >
> > allowed dying tasks to simply force all charges and move on. This
> > turned out to be too aggressive; there were instances of exiting,
> > uncontained memcg tasks causing global OOMs. This lead to that:
> >
> > commit a4ebf1b6ca1e011289677239a2a361fde4a88076
> > Author: Vasily Averin <vasily.averin@linux.dev>
> > Date:   Fri Nov 5 13:38:09 2021 -0700
> >
> >     memcg: prohibit unconditional exceeding the limit of dying tasks
> >
> > which reverted the bypass rather thoroughly. Now NO dying tasks, *not
> > even OOM victims*, can force charges. I am not sure this is correct,
> > either:
> >
> > If we return -ENOMEM to an OOM victim in a fault, the fault handler
> > will re-trigger OOM, which will find the existing OOM victim and do
> > nothing, then restart the fault. This is a memory deadlock. The page
> > allocator gives OOM victims access to reserves for that reason.
> >
> > Actually, it looks even worse. For some reason we're not triggering
> > OOM from dying tasks:
> >
> >         ret =3D task_is_dying() || out_of_memory(&oc);
> >
> > Even though dying tasks are in no way privileged or allowed to exit
> > expediently. Why shouldn't they trigger the OOM killer like anybody
> > else trying to allocate memory?
>
> This is a very good point and actually out_of_memory() will mark the
> dying process as oom victim and put it in the oom reaper's list which
> should help further in such situation.
>
> >
> > As it stands, it seems we have dying tasks getting trapped in an
> > endless fault->reclaim cycle; with no access to the OOM killer and no
> > access to reserves. Presumably this is what's going on here?
> >
> > I think we want something like this:
>
> The following patch looks good to me. Let's test this out (hopefully Rik
> will be able to find a live impacted machine) and move forward with this
> fix.

I agree with this too. As Shakeel mentioned, this seemed like a
stopgap and not an actual fix for the underlying problem. Johannes
further outlined how the stopgap can be problematic.

Let's try to fix this on the memcg/reclaim/OOM side, and properly
treat dying tasks instead of forcing them into potentially super slow
reclaim paths. Hopefully Johannes's patch fixes this.


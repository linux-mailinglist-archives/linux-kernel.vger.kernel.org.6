Return-Path: <linux-kernel+bounces-224741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028C8912645
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2291283B98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB856156881;
	Fri, 21 Jun 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGQFxs/2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01C155C9E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974868; cv=none; b=EzCc9tvYyvYOr4s//EGdIvHlUEoMkrXRDywOFENCg5axP0t0QJqgNIqirdgFRz/WYhque/VMY4CKxi1hLmq1RnyoXIbN5+kti9+G5yl4ZA7nSr5pI/O4HgxeCXaPNeAobm0AU80fLSSdrZVu8HtAsrh2T1cYL/eTDejfpLmfhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974868; c=relaxed/simple;
	bh=aDqGvExmYtMSxO7iSiX/nUW384UGlds4zZEf32ZoW0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhYRMCi+mYRACE9WvxZwxNfDk7VjjVNPGFcKYpIqeJDymxPqjmmlnDyC1oeGGp4swcOZfaMwzWFKKfNbeaxu6fih/u7HpVVRMaXG5bhfjqKko6JkcoDKH219e9PUzDeiJhm6aTZBrLF56soU0TyQXyfvcUKxbnSPsRy6/lDP6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XGQFxs/2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c327a0d4c9so2204757a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718974865; x=1719579665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDqGvExmYtMSxO7iSiX/nUW384UGlds4zZEf32ZoW0Q=;
        b=XGQFxs/2KAz+a9VlQUeUztAh+NW4xXcks3Vnv/C/ihgQeuWy/4pul3svA+iwxyoh7S
         QvolSAmnW/DJpiYiWs6EXBvVpS13b9FXFIy5xK2e5PqIssuLdB5fBHA9ufAiWPNtL02i
         2nOSaasAdCrP3NWrp4JuRypknPAe98q5/Pm+O9cWwmUU6HXdeHGSdoJdVl1TzrEXvVmn
         d8iKBYnA21MbdrAvYyUWKDEiBGmzvXUvspfazum9jkUg4ySTgKEXnKKZBwhAcPNg5gNQ
         3LVmQcRPE+un7C2h/W66vjwdiM6v/zu17gcDqTvkfVal8a40q5oCkNgELR8erK7rmfR1
         1vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974865; x=1719579665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDqGvExmYtMSxO7iSiX/nUW384UGlds4zZEf32ZoW0Q=;
        b=FVrf8AN4gbYLTzL1f4A1MD6SGFF30FMzOxCHjv/XnqJVDuRiJEfviIvKhnl5qRURsR
         pJPylzNoUoAiXLWD8rXbqb8+t9Rqvfzna6rnHcad92hnU/W9VUl9r3wzWspwgzQkc0uj
         vN6NIk3bH6NJc3GtjoGFqi6Tb5u4C6yii2pYY1vEZKotbqBctP0zLoOLAWvjfpxa4JBA
         1tnM7vUUXkwVtOQoaSYx2Ucqu+yhQt7ky4kMI+VdamkGfqCkgl+MKzaTd4pBQtCJwxOz
         SdgWWkSQqoOUhd7Nf7tKr0F5FFSTHH/9gXmcjDhe2IwF++XgJDyrFLl7UyLOcqnxMxQX
         inEA==
X-Forwarded-Encrypted: i=1; AJvYcCXh6inzSwhpnbhrTWboUDDQJDAnbYOqLTSySu2+btx6mtvM0QHYoF5sJbkKbkZnyEpRNUcUTZnP/MB8WcPLNSF86J7QPYQdCFTVJXXO
X-Gm-Message-State: AOJu0YxpplshxiZie/JAUhGLYosiTj2Fm7NyGc24ARDVbU2psrjkZMnF
	9aQbLlonnOsBBrCWW8DSn+lJYExfuxfMQsCFsZ+0KMYPp++Z47cygpkE1j+mulw4NYPQEqiQZEk
	myNHaNxso7zcr4+mfrcdO9xRuRJi5A/cbm57bsw==
X-Google-Smtp-Source: AGHT+IHwMjTEVT2Q7sVPGQs+tQNyLBiCXWBK6taeXrvTEw2qWPGxf76IcvjxMVp9vATGVGjILkjQOi5EW8G1p08ioyY=
X-Received: by 2002:a17:90a:f281:b0:2c4:f32c:6b with SMTP id
 98e67ed59e1d1-2c7b3ba85abmr12567835a91.19.1718974865168; Fri, 21 Jun 2024
 06:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu> <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu> <20240618145851.je4a7cu4ltrt3qxa@airbuntu>
 <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com> <8bfa0628-bd74-47c3-ba3c-4724acbfd717@arm.com>
In-Reply-To: <8bfa0628-bd74-47c3-ba3c-4724acbfd717@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Jun 2024 15:00:53 +0200
Message-ID: <CAKfTPtAQvQv0WfRD5siqJKLBbY-kKu8jcrNvr_bBf0Bc4n-tqQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Qais Yousef <qyousef@layalina.io>, 
	Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	vincent.donnefort@arm.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2024 at 12:41, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>
> On 19/06/2024 04:46, Xuewen Yan wrote:
> > On Tue, Jun 18, 2024 at 10:58=E2=80=AFPM Qais Yousef <qyousef@layalina.=
io> wrote:
> >>
> >> On 06/17/24 12:03, Qais Yousef wrote:
>
> [...]
>
> > Sorry for the late reply...
> > In our own tree, we removed the check for rd overutil in feec(), so
> > the above case often occurs.
>
> How to you schedule hackbench on this thing then? Via EAS or do you just
> exclude this kind of workload?

Don't know the details for Xuewen but that's also what I'm doing as
part of the rework I'm doing on EAS. As I said in at OSPM, I'm also
calling feec() every time even when overutilized. feec() return -1
when it can't find a suitable cpu and we then fallback to default
performance path

>
> > And now it seems that on the mainline, uclamp_max is the only way to
> > override this.
>
> [...]
>


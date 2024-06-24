Return-Path: <linux-kernel+bounces-226579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1191408F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430D72814C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36465442C;
	Mon, 24 Jun 2024 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbnbJtok"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA18C13
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196567; cv=none; b=puH9E3g/B04WVefvG9BhzHHYthP4aMKqOxZ+5mMmJ0V9ROx24gu4HH677MzZpLemZFOnj49z96oZSaWWO+5YP4dbwLunRsb8hlqCI/L8h5LwJj7OlX5bTLSSqOTQSc2yX8rkq4zp01/ywsi0F+IHH6TsqrsoEBOadTEElGeyF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196567; c=relaxed/simple;
	bh=w4z2DkVE9rN8j2iDDGgkpYfV/3GBnwpjFV40h/w/7WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ0/gEzyAdp2R7HrCO2zI+x98bkBKwjABo4KAwEShJm2xvFCTtokjOrFb6secZGWkKIua+DCPnTQsxuy5dMJSIOrplp++FxcHfuo7Snx+iOs5nVXyNWm4m6JoQ+UD8E1VBa1jQdY0iNOy5FAYP7ZWlPfoIPwKmogWKpjbF5eEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbnbJtok; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c1acd482e4so2073852eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719196565; x=1719801365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4z2DkVE9rN8j2iDDGgkpYfV/3GBnwpjFV40h/w/7WA=;
        b=EbnbJtokkmt6NIAgxh5aqODUaEJjLQ3p5WhITtiMEXffgqcvRg5VQwdzhbar1XT4Ta
         zm0wDIypLeO6a67xCSTPOWEsbR/EzOxv8cux+lWtE6mcvBjtKVzr11jaJe6IXP8K+RmO
         vktbnH4GFxMhTMENzwLb4uY7qZ8xuEyo1lSTXCdQnSb563v5XyczLvIrksbRjZlJNCug
         h7u9G5njEGPJ/e7R/BmmCgwrHAB9xWwTHkLQm5SmnzENXyYatzo9Il02vkzUwFkxCmN2
         50yAtJqYn7m167gl50+uG0g3JF7Cj1bdkZBKtdd2HbApvz/Awi9qZjUHbbrJBdj4ZXN/
         MQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719196565; x=1719801365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4z2DkVE9rN8j2iDDGgkpYfV/3GBnwpjFV40h/w/7WA=;
        b=QZgNrl90qb//M7E9CNjgYBPbtjjmiomVuRZPPpWPoTLQYN4/HXfgP9BpMeHAIsmMFQ
         KHAYpmkHtotbACFgHVfKDsI8deBQ4Ztov2+LVzA13KIVcVTN6fXN0hNxBSYxSBzRS9ML
         iriF5V/TVZHw1O6P+mhSg/GKp1ayBCEpolcbZtS7yR6lIm0mn8twlVnjnPDgwQnayF1O
         g28Y7PAqeoteGFktOZ8NPFC1du3XNJWwmOzEvksJz+47yq3OfQmv4gnEk6aEWJFGscXM
         D5uf/WJL5OiEOEhoVCXMoGpBoFgNT+VT+L2tkpXqWZByxJAbmwx7D29gcwDBRPM/VLKz
         +zzg==
X-Forwarded-Encrypted: i=1; AJvYcCV0x99BtcXl6p+Ju/PXwuzo4vwzGKfOiC+OTXUAF+zVr/MjX/56ycHrf7cGx5bEPWbm3gOmp+OmG0yJWJdqHHczJipjOX+T87pdLpyJ
X-Gm-Message-State: AOJu0YxZNk5rPD4lzaddY9wPSQLUTwwckeKxI8Uu80QY8iY/oNt5ofyv
	4MPGRcSnTAeiSI5ThZkIGDk0N0wkXalor0loe/CYqsvS1KRa2wyDFCKfiv46iZg/OvNZtmpYSwL
	2ffGMXxH600Naqy6KrRUDwwrO5DQ=
X-Google-Smtp-Source: AGHT+IFbekmw1KcqX4ThCOQ1I3O4B7vdyrY7bvygonS+2+TcDdUafXVOL/b6h7JaYNovApjEBxGClQi5XeqrDvBFJ90=
X-Received: by 2002:a05:6870:3a2b:b0:25c:c661:431b with SMTP id
 586e51a60fabf-25d06bd774amr2734225fac.17.1719196565044; Sun, 23 Jun 2024
 19:36:05 -0700 (PDT)
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
 <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com>
 <8bfa0628-bd74-47c3-ba3c-4724acbfd717@arm.com> <CAKfTPtAQvQv0WfRD5siqJKLBbY-kKu8jcrNvr_bBf0Bc4n-tqQ@mail.gmail.com>
In-Reply-To: <CAKfTPtAQvQv0WfRD5siqJKLBbY-kKu8jcrNvr_bBf0Bc4n-tqQ@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 24 Jun 2024 10:35:53 +0800
Message-ID: <CAB8ipk-E_LPmhHuYSXQuagdnitmtnobSG55kz5mZ_b-yF0XFUw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Qais Yousef <qyousef@layalina.io>, 
	Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	vincent.donnefort@arm.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:01=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 21 Jun 2024 at 12:41, Dietmar Eggemann <dietmar.eggemann@arm.com>=
 wrote:
> >
> > On 19/06/2024 04:46, Xuewen Yan wrote:
> > > On Tue, Jun 18, 2024 at 10:58=E2=80=AFPM Qais Yousef <qyousef@layalin=
a.io> wrote:
> > >>
> > >> On 06/17/24 12:03, Qais Yousef wrote:
> >
> > [...]
> >
> > > Sorry for the late reply...
> > > In our own tree, we removed the check for rd overutil in feec(), so
> > > the above case often occurs.
> >
> > How to you schedule hackbench on this thing then? Via EAS or do you jus=
t
> > exclude this kind of workload?
>
> Don't know the details for Xuewen but that's also what I'm doing as
> part of the rework I'm doing on EAS. As I said in at OSPM, I'm also
> calling feec() every time even when overutilized. feec() return -1
> when it can't find a suitable cpu and we then fallback to default
> performance path
>
Aha, we do the same, We use eas on Android, and there is often only
one or two tasks in the overutil state, but we don't want this
scenario to affect the placement of other small tasks.
Only when all CPUs are in the overutil state, feec will return -1, and
then fallback to default performance path.

BR
---
xuewen


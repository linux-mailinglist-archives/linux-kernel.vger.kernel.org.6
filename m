Return-Path: <linux-kernel+bounces-379507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C99ADF79
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA589B21674
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3741B0F19;
	Thu, 24 Oct 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELwgo6wx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BE16133C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759766; cv=none; b=m1IBk4BY2mFrZ+SRjW4ooO0UdyFv9XxVefaubwyIg5i/F4N8G80JV2/jTbRwVzK/9iARpLGzUuL8+MjqvTHiTeP7ypjCHnNkBkLQ4kXihFie34FUd7Z28nE6Gq/LD+9zyBGOrw8enjZAIh5oBZQCzO98pwbE6/HTrFIqC8ym7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759766; c=relaxed/simple;
	bh=zJiBA6Np68Vftgygtex4miWVOO5TJg9Fl8OkHbBiY58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv2z7+LtNM/BRgoP41Gp04JMM1PFBz5W3kWrgpGHPaltsF18lfNWZQ6RxQDvMXObqZyjeHIk+1qx6ANLDe9Klq9ZYUAvgk3N3MqvytbQwItrfM2xep0uiUe1K8ozAKIfdkubFXpKs/BZwGwJxk+XKBzLpCKBW2T+s5pW0SMHbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELwgo6wx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f6e1f756so729921e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729759762; x=1730364562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuM8bCSeFkAdLSk99j/aKolBQPa9Ke/95wfPnP0XcD8=;
        b=ELwgo6wxhCPq7YjacHm8gwTgNG8RS7FTeP0572WFcqwwPt6h5tQ78Mi0gqNnGRMd7h
         XP3tvzGvmK6p5hIHU8pd4dzR1MJS7gS6lR5ajCvVC3+FPi2XeyTw6qwAPN4A1siGrVqA
         7ea+XFnJtAVI3it8VceCou5fGtQyvfPNerdMHgdMGOM3MRpgW50mGRJEoO3sfjyTV6CN
         YboT/op2vo51l1ojOv+W1oTK0X+auEys2j5UCF6jWE8jX8Pl1mIp4n1rm8yhXoozy1wB
         WQKMcLcNCfVmlF+RlhtXbhFbGZdKEJJ1KCtJs9VTx8KHfv2YZ6O1AAKyGfpE1uf/XfJl
         K15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729759762; x=1730364562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuM8bCSeFkAdLSk99j/aKolBQPa9Ke/95wfPnP0XcD8=;
        b=uuxbW2UjsLf6+UwIy31qU6T23ksXkD0nFFv8RUUY0HEKqTLn0PMkUXQvPJjXEgl7j/
         1Fy8K3tUBq1Vh/K9Gpd/17WwTJynw7hryPdp5c66W/78R9sw8S1HM9nO8Den203pzBCP
         UAu6kyG9hHnCm6tQHyQrrW66952cpdUcstdnHxdSddY6D1C4mU8RdLnsbIOaY0pQRNGV
         dpbleaAqiBTBRspD2fZXFfLwIwlK0JQ1R/RgWhX+ivweWlJnr4rvDgRGHfaT0PLW+MIk
         61TpFXBXtSFk55E2uI2SN/RBHblPsfF/8xP2J2FAH2olyqh5HmBfiuHLSED4dHAEQWwv
         Lhyw==
X-Forwarded-Encrypted: i=1; AJvYcCXqAO5uoI77jDOefXhY9lnoAG4XXSth9Wmz9MlAw1YKpPb6MEPU271olejBiMFKFnO1yAWh7JuzYRhpTaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznu7OxNK8RpxuXNPQFBkHuKqgBqTRkD02z1kSKvowpEZRo9LaV
	MGsGWNlgLKp9p+6YaVVQ8gjgwUcYQL8Zxh98rUzeHc+qlBM7WQ1rtZZHIO4jHcb0Y395ckPP6PD
	mH3+KQ++HIKpnWE/ca9vJW7mA7C8=
X-Google-Smtp-Source: AGHT+IHqefTcaivDmQ9oHDeTqHREwoeXheT6QRnbFD5ge6DuQtPHJS3tx3adLZOkBDFO+ARAJJuMHI3n6wGZYrnU3jI=
X-Received: by 2002:a05:6512:3e17:b0:539:f26f:d280 with SMTP id
 2adb3069b0e04-53b23dcc1cdmr774100e87.5.1729759761988; Thu, 24 Oct 2024
 01:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022114736.83285-1-ioworker0@gmail.com> <20241023190515.a80c77fe3fa895910d554888@linux-foundation.org>
 <CAK1f24mGk4pCqf37zXaZbqbTOzLVBqRNnGmf4wEUA9MGYFGoig@mail.gmail.com> <20241023212815.240844bdf83e4dc17b66b88c@linux-foundation.org>
In-Reply-To: <20241023212815.240844bdf83e4dc17b66b88c@linux-foundation.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 24 Oct 2024 16:48:45 +0800
Message-ID: <CAK1f24njxUdAc8GibSfrut78jQ4mH8Bno_=m8Pm8E49APnrhyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hung_task: add detect count for hung tasks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cunhuang@tencent.com, leonylgao@tencent.com, j.granados@samsung.com, 
	jsiddle@redhat.com, kent.overstreet@linux.dev, 21cnbao@gmail.com, 
	ryan.roberts@arm.com, david@redhat.com, ziy@nvidia.com, 
	libang.li@antgroup.com, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:28=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 24 Oct 2024 11:28:01 +0800 Lance Yang <ioworker0@gmail.com> wrote=
:
>
> > Hi Andrew,
> >
> > Thanks a lot for paying attention!
> >
> > On Thu, Oct 24, 2024 at 10:05=E2=80=AFAM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 22 Oct 2024 19:47:34 +0800 Lance Yang <ioworker0@gmail.com> w=
rote:
> > >
> > > > Hi all,
> > > >
> > > > This patchset adds a counter, hung_task_detect_count, to track the =
number of
> > > > times hung tasks are detected. This counter provides a straightforw=
ard way
> > > > to monitor hung task events without manually checking dmesg logs.
> > > >
> > > > With this counter in place, system issues can be spotted quickly, a=
llowing
> > > > admins to step in promptly before system load spikes occur, even if=
 the
> > > > hung_task_warnings value has been decreased to 0 well before.
> > > >
> > > > Recently, we encountered a situation where warnings about hung task=
s were
> > > > buried in dmesg logs during load spikes. Introducing this counter c=
ould
> > > > have helped us detect such issues earlier and improve our analysis =
efficiency.
> > > >
> > >
> > > Isn't the answer to this problem "write a better parser"?  I mean,
> >
> > Yeah, I certainly agree that having a good parser is important, and I'm
> > working on that as well ;)
> >
> > > we're providing userspace with information which is already available=
.
> >
> > IHMO, there are two reasons why this counter remains valuable:
> >
> > 1) It allows us to easily detect hung tasks in time before load spikes =
occur,
> > using simple and common monitoring tools like Prometheus.
>
> But the new sysctl_hung_task_detect_count counter gets incremented a
> microsecond before the printk comes out.  I don't understand the
> difference.
>
> > 2) It ensures that we remain aware of hung tasks even when the
> > hung_task_warnings value has already been decreased to 0 well before.
>
> That makes sense, I guess.  But fleshing this out with a real
> operational scenario would help persuade reviewers of the benefit of
> this change.
>
> So please describe the utility with full details - sell it to us!

Thanks, the suggestion is very helpful!

IHMO, hung tasks are a critical metric. Currently, we detect them by
periodically parsing dmesg. However, this method isn't as user-friendly
as using a counter.

Sometimes, a short-lived issue with the NIC or hard drive can quickly
decrease the hung_task_warnings to zero. Without warnings, we must
directly access the node to ensure that there are no more hung tasks
and that the system has recovered. After all, load alone cannot provide
a clear picture.

Once this counter is in place, in a high-density deployment pattern, we pla=
n
to set hung_task_timeout_secs to a lower number to improve stability, even
though this might result in false positives. And then we can set a time-bas=
ed
threshold: if hung tasks last beyond this duration, we will automatically
migrate containers to other nodes. Based on past experience, this approach
could help avoid many production disruptions.

Moreover, just like other important events such as OOM that already have
counters, having a dedicated counter for hung tasks makes sense ;)

Thanks,
Lance


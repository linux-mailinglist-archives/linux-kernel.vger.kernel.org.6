Return-Path: <linux-kernel+bounces-379134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99779ADA71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90A11C21384
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70A165F01;
	Thu, 24 Oct 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFu5RO0L"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CC16087B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729740522; cv=none; b=DKW2CZQ1xsg+eOlgWWwAKxQ7g6eHVKTSWcjZwsY+PKfl3xZhH9xx0LO2j7uRDOLejGpqbHezPvw4n46RVtNEIlYmceCNGeD544NT8fd1fHTxNdZpXil5UBi+UV3lxaf85svF23o9Usl6SnJmfi0cfRpoT175HfPFKjpccROew3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729740522; c=relaxed/simple;
	bh=s6Wqh6ig3GW9JmmwQsGERMIClZLFHkkIh9MgzaUEWnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhyuMZvhbmhPnbi3App4a4IYgQUznBApiGpZ2c2aF7edDEIKdD+AGSf8dYHSEcc8bcnWBCHgBXl7kPTMnpvTaQDXV9FdkMKcvBI+ZF/1eM+3N9wa27ojulbASKiaI4Fu8URRxDeXkYdosYa5Xbx8EkPDeetMfjhmjoTCcWRbaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFu5RO0L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso541831a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729740518; x=1730345318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un2VLODaIM3gpoEyTkOWWCAX4WQM40kMawARGDkWOxk=;
        b=WFu5RO0LMfHwA+cNhzrNkvi7QunhlahsziLypq3uc/Gng+xSQ+q+N8OM1c2GdWbcPL
         JM3Mib/+0XUaP8jTP7wrIRqGwlY55oNDBtqa4EHajDa3IPsAxgUEScICKiemp6Qw3UWf
         aygF03bhYh2sl5QP+Y7BAYLvfdP/NdZFHn0V+wWBmFyTLP9T0Zg28tFq4UBNZ5am6FhI
         9/rjcGAaKqDWhPxzFtCvwMOCvp+hra7Ck2lIpVNLq/Hv57FcbvTrpHNWu5Xi63iNaJDj
         adFZTUVdgRuD7UnUtH0/ofniX+QIlZRidM+1Kh4jh1kF075QacSq4vvEb8diZhvhx0jV
         TecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729740518; x=1730345318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un2VLODaIM3gpoEyTkOWWCAX4WQM40kMawARGDkWOxk=;
        b=XMupX5fSTvGe9/ZcWyQI++SjR/NPgkG6qfPUwF7RT1eqKFu3SF2zwC+jD9oaZGb+mr
         EhMDO5XLOCDzWo2NCsuE4zxysoZfFZRcxMkhB+xRHKdNhRJ4JmLZwLw9RWhtQOjEOyuB
         wsRg9dLNcF9dv4hI5idhjHMtN0PTDO2AhEjpBhJs/tyvMQDRyoykDLkH3gonDF36OxUg
         ZGTEvU5dwnQWCGTYPwcC23vuX19anObdrGF6nTTj+0wPszayPHc65bEU3VhQ/9Ek1BPg
         iQQ/aouoBY1b9INRDXZ9VYCtM03f3z64nhpbDMKJBEO/hUqNXIwKy4wQ8FBJfk17U7GK
         VWew==
X-Forwarded-Encrypted: i=1; AJvYcCWwiCpDHoaolJT/5FeCfHpVfrL/LDuu0IXRFNMlsILGqV6oezI800tkENmT9vcpPwix/IVIMBYYB5XlusU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0drUaFuel9cnjGpjiCR6VuZUnzI43wevEP/1TAtTVWyx7dpvI
	CRy1xalgSq5+WVCTEUFr9oo1zQ3QMBLDxgmVr0da4po33AmQZc5Cj3fjFyMG2qnlcpyOKzVYk2U
	ZnzdlF8TXE9nrh4gV1YcQIuc2zKg=
X-Google-Smtp-Source: AGHT+IF/fOrTtdpuif/P34flYq1CD1Pj6GgfXZSHY2zOJsitJU3I8Medv9lWBstqnoUR/90eL1OkWGG4bQHAuNt3rjY=
X-Received: by 2002:a05:6402:2745:b0:5cb:6841:ec8a with SMTP id
 4fb4d7f45d1cf-5cb8acee2a1mr4549755a12.19.1729740517751; Wed, 23 Oct 2024
 20:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022114736.83285-1-ioworker0@gmail.com> <20241023190515.a80c77fe3fa895910d554888@linux-foundation.org>
In-Reply-To: <20241023190515.a80c77fe3fa895910d554888@linux-foundation.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 24 Oct 2024 11:28:01 +0800
Message-ID: <CAK1f24mGk4pCqf37zXaZbqbTOzLVBqRNnGmf4wEUA9MGYFGoig@mail.gmail.com>
Subject: Re: [PATCH 0/2] hung_task: add detect count for hung tasks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cunhuang@tencent.com, leonylgao@tencent.com, j.granados@samsung.com, 
	jsiddle@redhat.com, kent.overstreet@linux.dev, 21cnbao@gmail.com, 
	ryan.roberts@arm.com, david@redhat.com, ziy@nvidia.com, 
	libang.li@antgroup.com, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks a lot for paying attention!

On Thu, Oct 24, 2024 at 10:05=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 22 Oct 2024 19:47:34 +0800 Lance Yang <ioworker0@gmail.com> wrote=
:
>
> > Hi all,
> >
> > This patchset adds a counter, hung_task_detect_count, to track the numb=
er of
> > times hung tasks are detected. This counter provides a straightforward =
way
> > to monitor hung task events without manually checking dmesg logs.
> >
> > With this counter in place, system issues can be spotted quickly, allow=
ing
> > admins to step in promptly before system load spikes occur, even if the
> > hung_task_warnings value has been decreased to 0 well before.
> >
> > Recently, we encountered a situation where warnings about hung tasks we=
re
> > buried in dmesg logs during load spikes. Introducing this counter could
> > have helped us detect such issues earlier and improve our analysis effi=
ciency.
> >
>
> Isn't the answer to this problem "write a better parser"?  I mean,

Yeah, I certainly agree that having a good parser is important, and I'm
working on that as well ;)

> we're providing userspace with information which is already available.

IHMO, there are two reasons why this counter remains valuable:

1) It allows us to easily detect hung tasks in time before load spikes occu=
r,
using simple and common monitoring tools like Prometheus.

2) It ensures that we remain aware of hung tasks even when the
hung_task_warnings value has already been decreased to 0 well before.

Thanks again for your time!
Lance

>


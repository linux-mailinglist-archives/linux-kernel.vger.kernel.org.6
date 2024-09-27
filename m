Return-Path: <linux-kernel+bounces-341393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A16987F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1891C20C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74DF17C98C;
	Fri, 27 Sep 2024 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFPpTqoM"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592B28EF
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422116; cv=none; b=C1TKpdz1jAbZwqxA6a9rgM7Nyhf2CLkBkzFhQZhOIg9YLIxb3h4HyJWojelZ/zwtvB4prVO83O7N4DHnFJsMB9mWY6GrbVY/+Qc1yhrWjenvOndXTAmRYYjdJ3GsGljiK2txDd5eBCIMmE7OUpRW738TN9II6y7/iTL++F44WA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422116; c=relaxed/simple;
	bh=uoJ3Ph451WRu4/35p1hS+4je1NRBdhgvP4Y7yp3yAGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH6UpOp4NYX24K1c4+sIJCVpxK33LDiM2doQbZypYwoBJ8JAkl7LPU+HEoSZ0koMVrZ5m51UArbQHSc6uEHwedEvg52LYgVz5/ZAN4EPePsEyR+d/oVxK38OG21gCtbrbPbyu4MQFLGR4xNvJRC1Nwj/H4Rjk5vnWIyHs6+R0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFPpTqoM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-535dc4ec181so1979463e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727422112; x=1728026912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoJ3Ph451WRu4/35p1hS+4je1NRBdhgvP4Y7yp3yAGY=;
        b=ZFPpTqoMgTMQQzsL4jHG/ZKmeD0f83JuWU7ztW3Yjs2svYCxPtOBh32sUweo/qGXDI
         P6GjZuVSqSuqZRejhPTTQf/AsS7bo9gQ3aEa67vxDKUhcncVwO0JfvY5sd9scB30MlHt
         X5AoSeZprNB5fQoBV43Zkdfjcr9msi6WtdwFGXyjR3pJMIGLea2sPJYq6cB5PnxkMDTd
         gOAvGX4Z+6lIeHvRTUyntZG1R13npaM1OHetb5kFi+hH3rm7eAwaZQTXaFxNerNKvB5M
         GSEaogZgN7pd6gGMhduqBE8veqW/h8zudDpdXVKbDeZQ4FRWeZlcjE/csleM1l/vcI99
         jG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422112; x=1728026912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoJ3Ph451WRu4/35p1hS+4je1NRBdhgvP4Y7yp3yAGY=;
        b=Opp0twpuGjBbnZUZS4N3fethakXpeRXh+XUXGFNdzOcuPKhCx0bCMlEMqEO3Aynl42
         pFJsVbzTBIj5eKnv3f3corzgN6hyRtp1HsnGFJ4C4GZfxusLLr31bPltMvfg6vIChje7
         4Rsyt9YF/XYc/+d2XkJZSYs+vjMcN5Z1wjqNFy20IZIlpXMFSLbdWdLYP2ISolKcpqxv
         Os7zimaWs7CkiAvtZQvp0kuGqEcaoVYLzT8n1BjYp8KKZ3md+Bszs50VI9egpqn1Gt0W
         GUbdIrovsCgC/AhTsA5znkA1lOVGYOsZCDrn46lwaxIomFuUqkPF0v+Cn+zI1NCItUTA
         1ITw==
X-Forwarded-Encrypted: i=1; AJvYcCWASGjpc8Q4q/k+TngOO1cyE0lJf1lsdBcvopWhSMs9xJ7MLC9BJgLcZ7shwH9HF2/NvEbI5LBOuB9AqOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyALG8hcoltfiEjGZVHc4nPUKge0cevekc6niElc4fKYYYv1HAM
	xPCNJTRQNUJq3oxTS9h+NxE76lZzrpANJ15XpT4oGSS1ku8y2ss6pmbbpsiBriClCCuj74/y7SA
	07gmu7IczgvRnE7N0yUmioTFzlg==
X-Google-Smtp-Source: AGHT+IHmtyWEtUHfsKHq9g99tzdBj9RE/tE8KQz7cGobSq9bRFg4XWFxuuR2spfaHirGoTu/774OipIK2eJEqFPls4g=
X-Received: by 2002:a05:6512:118e:b0:536:a4d8:916d with SMTP id
 2adb3069b0e04-5389fc4d0d6mr1144642e87.34.1727422112023; Fri, 27 Sep 2024
 00:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
 <CAB=+i9TJcnFhwef+efw8yBynZ28M2tWiYvuYS0aVoD4yt_+0Zw@mail.gmail.com> <cb3b4858-00a8-459f-a195-7f9092f0da8e@suse.cz>
In-Reply-To: <cb3b4858-00a8-459f-a195-7f9092f0da8e@suse.cz>
From: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Date: Fri, 27 Sep 2024 15:28:20 +0800
Message-ID: <CA+kNDJKDFvA6bamTZ8tHTR+NRaV7NbK8sEQREyhwEOsTnroJjw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce panic function when slub leaks
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fangzheng Zhang <fangzheng.zhang@unisoc.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com, 
	Yuming Han <yuming.han@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:30=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/25/24 15:18, Hyeonggon Yoo wrote:
> > On Wed, Sep 25, 2024 at 12:23=E2=80=AFPM Fangzheng Zhang
> > <fangzheng.zhang@unisoc.com> wrote:
> >>
> >> Hi all,
> >
> > Hi Fangzheng,
> >
> >> A method to detect slub leaks by monitoring its usage in real time
> >> on the page allocation path of the slub. When the slub occupancy
> >> exceeds the user-set value, it is considered that the slub is leaking
> >> at this time
> >
> > I'm not sure why this should be a kernel feature. Why not write a user
> > script that parses
> > MemTotal: and Slab: part of /proc/meminfo file and generates a log
> > entry or an alarm?
>
> Yes very much agreed. It seems rather arbitrary. Why slab, why not any ot=
her
> kernel-specific counter in /proc/meminfo? Why include NR_SLAB_RECLAIMABLE=
_B
> when that's used by caches with shrinkers?

Ok, this is because the current consideration is to specifically
track the memory usage of the slab module.
In the stability test, ie, monkey test,
the anr or reboot problem occurs, there is a high probability
that the slab occupancy is high when it comes to memory analysis.
In addition to directly monitoring leaks in the allocation path, it is
also convenient to record the allocation stack information
when an exception occurs.

> A userspace solution should be straightforward and universal - easily
> configurable for different scenarios.
>
> >> and a panic operation will be triggered immediately.
> >
> > I don't think it would be a good idea to panic unnecessarily.
> > IMO it is not proper to panic when the kernel can still run.
>
> Yes these days it's practically impossible to add a BUG_ON() for more
> serious conditions than this.
>
> Please don't post new versions addressing specific implementation details
> until this fundamental issue is addressed.
>
> Thanks,
> Vlastimil
>
> > Any thoughts?
> >
> > Thanks,
> > Hyeonggon
>


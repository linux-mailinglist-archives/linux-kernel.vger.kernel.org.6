Return-Path: <linux-kernel+bounces-255445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D39340C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05575B21C05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195A1822DD;
	Wed, 17 Jul 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="eNKUtrpZ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC21822C9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235039; cv=none; b=K6YBYGL1qM+I1XvHj8tHjAmjTl8Iwdn8c8ziKaPYt28Y9esUKTpknrJgOIikP4C9bmtVZhLSYboQOGlXF4CGzKK24HAtNDU/4QSZWjZ6SSF4dW8mGzD6nPJ9dB+Cbp+6CoZNfUkhU2NATFUoTdGafhZZBU3l4CIEV/Ium4wGn6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235039; c=relaxed/simple;
	bh=GRwsvdaZVXEcKOPI7Y0OJEITVG+ZtOtBwrLMsy/wr9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6k8BtQ3Z4v8yG5pPBDDxHPbOosLnaPBGnMjoWwKAjFJkm3svMYQ4VP2MKQcssZ+lkOV9yITM8tEgLL4Lm3OE2cc+qxTaR8jsgwDhZj2QqJ4p92oUfdu5Adm55Pl+7UTd5/tMuzHZMPnjQb6I+SVR7rOoTbdAkzvI/OUpAzyGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=eNKUtrpZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-449f23df593so38395671cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721235036; x=1721839836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRwsvdaZVXEcKOPI7Y0OJEITVG+ZtOtBwrLMsy/wr9Y=;
        b=eNKUtrpZofNuOpCtbTAjHggJKwPG6lOcJlgcufCCJQzKWMaZZMhAQWIPOZKgXAWyC2
         P6qmyEbXorOVlGUxruZ2dE7kaNiO2HYHbTs/JHfwKukEi3yz03gDJ+eOXBeiKVxztlSq
         ggAkvIxSB1m+fMbQ5B/vePPvFyurvZLJvSx4kWWvUOoJWKOP5WIULz11DBlAZAFcp3Fr
         SIpXaa9X7/hb3GPglE76suhAvET1+gl2dhfhu/QZVShDLKRGJ2NHc79ZFYnepvtnKNPJ
         VobLrasxs6bohl56Y0e7zoDmTC3tZhwMyJGvlg8YS/FXSjNtFWiNt3xTPdYCJ5ipF0us
         l/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235036; x=1721839836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRwsvdaZVXEcKOPI7Y0OJEITVG+ZtOtBwrLMsy/wr9Y=;
        b=rRWUNB8TiwusJ+5xaIbpIGMqQEjovITj4G7TQSfM3Nq0BoOUY1rROZlNfrn1TaL3e/
         dcyRSUwuMMOh3hLRJbIMhTR7Dr1t6wb2BbxmohJBpn8gyKfEVR2pakOujwwFVxHBDQeK
         L8I77ycMS/8bn3VDWdoF0aVniycuOG+xS0nIKka6ZwK+9mO4jjKz7WEeGyT28BYH+vLL
         fULQnk45j5Dj7N8MNYqyotxiriFtVXhj4cZ4EXxxIdJEpvC07EtfXvuhLvwZGJtriM1Q
         1Gsqpj4fuSI+2P2IIZ1vRLHBUL/ovg+buLeqvSjsp76MDaSysZ/BSuUPZkln4PQaFPyY
         03sg==
X-Forwarded-Encrypted: i=1; AJvYcCXnke4fwSOgroqrz2BNaV5KdIWq2PfhnTz9hXXStHBzry/JcMOxgQgPmvDnNA4qe8xWF5igbvs/kDSH+UMVTjuNZcC5QGog4GQXEvIJ
X-Gm-Message-State: AOJu0Yw21e6hnUTT/FlYxGxts3EvKDs+knrlClJ/AFWvrwzHOE4radvm
	jW3wpk6+B0gYS0mvURH13SwCIfbrcg7+Lgb93HrPJrT5UWL8Oyb/WBcepapUd0vFIP7AU6bzFNx
	17GW/6heGqtnYW18BQMnJWsXkkSZLY9d7p/VPGA==
X-Google-Smtp-Source: AGHT+IFxQYPCDcrmSsyEadwMoGGdL1siJDY+QJ39nyNeIqqsU+jt5WPPcMEoRxymnj/mknxyDZShtnwVgxiWZDNF+7c=
X-Received: by 2002:ac8:58cd:0:b0:447:df1a:d973 with SMTP id
 d75a77b69052e-44f865f56c7mr30031041cf.38.1721235036627; Wed, 17 Jul 2024
 09:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530170259.852088-1-pasha.tatashin@soleen.com>
 <cq7537bswpnbsmeiw3rh4ffrgqky4iufsaurukpk2flxts6jcu@6ctttkclvf3f>
 <CA+CK2bCuiDAv05Xu6OuKB=gqJ5NM20F_uUyJV8E=XH=r47ik=Q@mail.gmail.com>
 <i66bzhgnbql7bvuteqttpijml3ze3nngxapv32k7paqv25c5th@wd37oaastkvz> <usfcwyq76np42s5b2rpzgjrvvtdpwakaum7ayy4zumaa73ke3u@txbukb2464bl>
In-Reply-To: <usfcwyq76np42s5b2rpzgjrvvtdpwakaum7ayy4zumaa73ke3u@txbukb2464bl>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Jul 2024 12:50:00 -0400
Message-ID: <CA+CK2bBm4COW+jZifyjFEyJNcW1cAXWYzCpuO81jL3YziKxfRw@mail.gmail.com>
Subject: Re: [PATCH v3] vmstat: Kernel stack usage histogram
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, vbabka@suse.cz, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:50=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
>
> Hi Pasha, I think you might have missed the questions I had below. Your
> response would really be appreciated.

Hi Shakeel,

Sorry for the delayed reply. I was distracted by unrelated tasks and
did not make any progress on this project. To answer your questions:

>
> On Fri, May 31, 2024 at 03:42:34PM GMT, Shakeel Butt wrote:
> > On Thu, May 30, 2024 at 08:14:17PM GMT, Pasha Tatashin wrote:
> > > Hi Shakeel,
> > >
> > > > Couple of questions:
> > > >
> > > > 1. In future with your on-demand kstack allocation feature, will th=
ese
> > > > metrics still be useful? (I think so but I want to know your take)
> > >
> > > It depends on how on-demand allocation is implemented. On hardware
> > > that supports faults on kernel stacks,
> >
> > Which hardware supports faults on kernel stacks and which do not?

From my understanding, both ARM64 architecture is capable and also
Intel FRED is capable of handling kernel faults within the kernel
itself, other variants of x86-64 are not.

However, my immediate goal is to provide a generic way to increase
kernel thread memory on demand, specifically when needed. If certain
architectures are capable of in-kernel fault handling, they could
potentially leverage my framework to further enhance their dynamic
stack fault handling support.

> >
> > > we will have other metrics that
> > > show the total number of pages allocated for stacks.
> >
> > Don't we already have a metric for that i.e. KernelStack in meminfo
> > which is in kB unit?

If we had true dynamic kernel stack support, then the metric in
meminfo would be enough to estimate the average stack size, it would
still not show the histogram of how large stacks get.

> >
> > One more question: Is there any concern in making
> > CONFIG_DEBUG_STACK_USAGE not a debug feature i.e. enable in default
> > kernels instead of just debug kernels?

We enabled it in Google ProdKernel. There is some overhead when
threads are exiting, because we are looking for the first non-zero
byte, but that is minimal. We haven't observed any performance impact
on our fleet.

Pasha


Return-Path: <linux-kernel+bounces-569013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF57A69D69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148673AAF50
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E81C3C1D;
	Thu, 20 Mar 2025 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0OUcfQj"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D575364BA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742432814; cv=none; b=m1nAAow6/Dv3YOAM6nH+VXQUm4kYJ3L6a/EoOdgrf6cRnaN+Uq6vHh96t3ZiphP2nG+PGiElbGM9qSoVXt31MdAPzAe3CQ5rbGvxiHod9M1MxlAKvsu/zf5oEOHHNsHw3P9NdH6u21jySqUVi74ENPa5UL/Umo5o2x8ymiZcS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742432814; c=relaxed/simple;
	bh=7JYKDXqcMjmmbby7HW7oqoB53lPZnHUBH0My4mzE0NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ahjkg7ACMf9o51SFIwq3X4EApJtpsJc8jpsQPno12ax/NvY3LJgq1fhsLDDzDXfgQD1X0RXqiGIcb+vUuOZQmkLpLvG0ixBpf+NutYk2JM4THGVNI88QtkrvukLFsptVv4MnKguFthjoNK9GKHLaB7H1w+AOgMp27eOHoX4HBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0OUcfQj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47681dba807so69841cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742432812; x=1743037612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JYKDXqcMjmmbby7HW7oqoB53lPZnHUBH0My4mzE0NM=;
        b=A0OUcfQjDPnDl4GIPFSigy/AdQ6/29TQDImlSA3vGWav1pDmttuywvEqHa41E+L98O
         RNgaHulcerxBbIVgx5/yqTrLPhBmUpvLPFn1INYG7ix0j9KC97JI1gvptf7dS1VD08Pw
         yPlKEIhjidYOPKeHf5mmRcDnPvq3HEV/dLpz9CWWpmtui4W9rRD4qml31VkNOPoJvAMf
         BGCUmlGAQ4qGRt7u7hn/4wfacYoFfsJI8qqOiEA/K/GWLr57ZtNuZKywnw+pfCNUepWI
         k6cQr7gPK8RGxfNEkZ4J00vDDOKk/84ZYIbQ19/i/0k9GwB8IZPiqYZTRWL+ZfxNaZ/Z
         juDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742432812; x=1743037612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JYKDXqcMjmmbby7HW7oqoB53lPZnHUBH0My4mzE0NM=;
        b=wppJDpU3IkBmf+QIJuW0nHnYTHnYwTbWAGQ/SMijxutahaSWqL0pw6M8p4LaxrI2Oo
         zkhaJRC2yu6axkG7kRaVvFGliSPZn5XNoCqZzxBnKcNUNlb4X+KyHveZWRSX+Rod1/Xp
         1PI9i85IVybY0JX2SNL6ZUjxe6Pybry0QdL+uGhcWAz+ILZwrAJkMmqCSJU/DJR2+kAy
         ur6cKmWaZ6mjMXsulpgx0IAf1RIc2++22NOxks7Ong8drXSaVrjLqGrFWXOKV5pNGjfL
         dirBRPjUdh4DvGFOb0VCGzAz1MPX2fQjn4pPOV1sUZjaDKhPS9NkRDrNAWrgMB9D/v3N
         vDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX87kcQhpM8n8FUp3PN0YRKASXpRteGx2Kp40IYE4uWgcdIDVRXqvXZFzCGR8+q+KFX9CXKxhOPJw2yTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOWnyXEUCiLNTz5bqvhbhgXokixTQTPL3oXI0ddwNfJ/OTr9I
	PGEIGvCTZhLsJAZEE6JyTlGZ1uFOS3s8woS3wPAVTND2J6gCGSmo6PpFULBUyw2/RTJETINB7dU
	F3eOxEFQFQK+pLu54gQSmw7TcWc4FGBAH4R5D
X-Gm-Gg: ASbGncupODRTve/ec6l3b2OvKxXPQjQtBfjfRuz7hLXeyA7Ypp9snBKxRb5sZv00zE6
	PkfeGgIgDl2vw69rupXEkgkfn1g6nNrad1NPNUSTnEfYK32WhBrseKIzMyjUoDSHqM7820dbyWZ
	5zOtScDtd9gF51bVp8Gxq7KUumSTQBX1bkXfTqx1u8eR4QS9UQpQAGhw==
X-Google-Smtp-Source: AGHT+IHIFC27Tk88Yi3YUGNZ+k8FKhRjCX/JtoA3qeNIsqcz98TsyFMxX7OmB6lwatepNjm6g4SKE8rpEapaduydeyo=
X-Received: by 2002:a05:622a:2b43:b0:46c:7cf2:d7b2 with SMTP id
 d75a77b69052e-4771162a1b7mr2073731cf.18.1742432811909; Wed, 19 Mar 2025
 18:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com> <20250319134257.GA1428417@bytedance>
In-Reply-To: <20250319134257.GA1428417@bytedance>
From: Josh Don <joshdon@google.com>
Date: Wed, 19 Mar 2025 18:06:39 -0700
X-Gm-Features: AQ5f1Jo0AelVf46M3Uv3ZN0LlsyqlPkTeUawbJFwips3q1mOL8lHZqHPY4GtHm4
Message-ID: <CABk29Nv0Rh4L7h+XEjWwcMixSqtaCBh9U-Ajm4eKaYwvsRsjLw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based throttle
To: Aaron Lu <ziqianlu@bytedance.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Xi Wang <xii@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 6:43=E2=80=AFAM Aaron Lu <ziqianlu@bytedance.com> w=
rote:
[snip]
> > track of the number of threads within a cgroup hierarchy currently in
> > kernel mode (similar to h_nr_runnable), and thus simplify down the
> > throttling code here.
>
> My initial feeling is the implementation looks pretty complex. If it can
> be simplified somehow, that would be great.

Xi (attached to this message) spoke about this at LPC last year; Xi
can you describe your approach in a little bit more concrete detail?

Best,
Josh


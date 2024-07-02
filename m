Return-Path: <linux-kernel+bounces-237506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6BA9239F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC695B20DFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709641534EB;
	Tue,  2 Jul 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi1z9qn9"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05943152782
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912479; cv=none; b=fWy2a9vucpc2F/sG2711OsiWeklBvZjxsPxwnK4Sg0JLX6pt7dryLghUgK3lzTfsiu+fDLDAJeJzaP5ir9A8lizYArVQ1PsYtHWejv81It0DqCcwhjeJrB0groPBDQOqAlt24UHB/EW5I99YCrk70I+GjnqdH0Ei/py1PyRn1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912479; c=relaxed/simple;
	bh=ZeQuxXK7KAGjoVlKgP92Wn3eMsD4hK+v+4X6SF5SyVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGJTszf8NZGqA5ogffH+ulWFIb3iFK6ZMBw+SV3/8nUBiD1j1LEzuMa4GEwlBbXXYiAoR/v/WetzhVfIgHIiLw1vauC6gSppJyV2/yQ4lxH+n3LBMeX7agcMX2WwECl2u20q/uRkkNLc0d+wm0ub6E+fjumjhvtwU6Sv90/xkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi1z9qn9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee7885aa5fso3053261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719912476; x=1720517276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW5NUpvADTD8UVO2vLBBZH7ScJjLCuiOXUWaKXBk80A=;
        b=Hi1z9qn99AiQf9f2AtiMbMv2exY4eDu/UHVgtUankR4K59kqQsNRX9qRwqSFj/asNK
         VZ7A5KHvRLYqRhUxPATgmnZyKVdeaBkBVj4kFGkrkBOrob5xRRm6xzzvzPO+H570f8cs
         Vp6gsMdjkMufN5o2iPf99CwPaOum8WE7PdYnHGDDRLTF8CWJE62ptR4dR0nADQS2Lemq
         uMmwWcqxldvevLMQhab0XHaEPPUSihtiqzqIEanVw2mDu4vLq8KRLCLwuzwnvgVLdheE
         oOUST2u5UklTrqGQy4wxc2zk+NNiYQPHFTwBndnAsd3/OSkwFrBBHHJ5944KlFaNRboH
         iKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912476; x=1720517276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nW5NUpvADTD8UVO2vLBBZH7ScJjLCuiOXUWaKXBk80A=;
        b=pqzs3TR57dairjpr9gmwz1cnn4QeBs6oE5vkK+cpcZWJRFw+aXYD1HCN1WlmDjBRLd
         UHxdGxbh+yfQX8nWUp+iJGdy86jEzF64GyXzYeukNKsbggOdKFwMezJoByrX8zldaWw/
         L2rHR8B7xA6HARwkRcYolnhR9Y+ZzaHBeIdcm9b7qHcboYh8EnJEZjbOJp2HY3Chohng
         sAMO/U2JjDA/hb2QuLVLWtjYt3C9AHbb5f72LfHP+xnT+/T5jRxPViDbnwwoVHXG2ceV
         Wqw0ygc1xfjiMCCILOSaAe38e2Wy3x1SJ9owX0aZMAW+vcZKkFq0EhLVhMO4JKQLP50N
         YFaw==
X-Forwarded-Encrypted: i=1; AJvYcCUoDNlXLmA58qOLHII1xtcZCwhbY+uaI3s0OSby4veBl7EsK6mYEZgAkLEC7CJh5mJjA5bhuVnA2ZN7CRLdxVxuZ8eyY1Nji4rEECoX
X-Gm-Message-State: AOJu0YxM/HozKX6s6CQUo6kpSxgIZ7Ldi/5LpE/hDL9gjQbMIpBHzDr0
	2dNaK62DcLO3KK+lcVx9ryyvCwXUg401x03Jli6PmISfcyiMbctTJJFHZwR6Uv2XDkgNztBcM6F
	/x1vjCO5sPxSc+J+3h1qVJAjCewU=
X-Google-Smtp-Source: AGHT+IHEO5OiCIH3xFHQ38s2EbEo+++BlCllu0Kc3PP0e/MXs8XptBFZ09d7RoqPv7WEmY7LcHd5XEhDXnGeTqpA7JE=
X-Received: by 2002:a2e:a912:0:b0:2ee:4e67:85ec with SMTP id
 38308e7fff4ca-2ee5e337908mr73043911fa.5.1719912475717; Tue, 02 Jul 2024
 02:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701075138.1144575-1-yi.sun@unisoc.com> <20240701075138.1144575-2-yi.sun@unisoc.com>
 <ZoLoJ-uBo9qyAlMg@slm.duckdns.org> <ycmaxfuqpnj3vnmseikx7m7jkzsp2t2qtlncgub44xhxohs6du@hucdavhpcvpi>
In-Reply-To: <ycmaxfuqpnj3vnmseikx7m7jkzsp2t2qtlncgub44xhxohs6du@hucdavhpcvpi>
From: yi sun <sunyibuaa@gmail.com>
Date: Tue, 2 Jul 2024 17:27:19 +0800
Message-ID: <CALpufv3bAsMey1DFb8HPbp8gPZWBU-6rrhvRWwVQsxXhPXOvdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] workqueue: new struct io_work
To: Kent Overstreet <kent.overstreet@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: Yi Sun <yi.sun@unisoc.com>, jiangshanlai@gmail.com, jaegeuk@kernel.org, 
	chao@kernel.org, ebiggers@google.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com, 
	yunlongxing23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, adding the io priority attribute to work will bring huge benefits in t=
he
following scenarios:
The system has huge IO pressure (these IOs may all be low-priority IOs),
and a work (we hope to complete quickly) is also doing IO. If this work
does not set IO priority, it will be blocked because it is difficult to get=
 IO
resources. And if this work sets a high IO priority and passes the IO prior=
ity
to kworker, then this work will be completed quickly (as we expect).

On Tue, Jul 2, 2024 at 11:53=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Jul 01, 2024 at 07:32:23AM GMT, Tejun Heo wrote:
> > Hello,
> >
> > On Mon, Jul 01, 2024 at 03:51:37PM +0800, Yi Sun wrote:
> > > +/*
> > > + * If a work may do disk IO, it is recommended to use struct io_work
> > > + * instead of struct work_struct.
> > > + */
> > > +struct io_work {
> > > +   struct work_struct work;
> > > +
> > > +   /* If the work does submit_bio, io priority may be needed. */
> > > +   unsigned short ioprio;
> > > +   /* Record kworker's original io priority. */
> > > +   unsigned short ori_ioprio;
> > > +   /* Whether the work has set io priority? */
> > > +   long ioprio_flag;
> > > +};
> >
> > There are fundamental limitations to this approach in terms of
> > prioritization. If you tag each work items with priority and then send =
them
> > to the same workqueue, there's nothing preventing a low priority issuer=
 from
> > flooding the workqueue and causing a priority inversion. ie. To solve t=
his
> > properly, you need per-issuer-class workqueue so that the concurrency l=
imit
> > is not shared across different priorities.
> >
> > Now, this limited implementation, while incomplete and easy to defeat, =
may
> > still be useful. After all, ioprio itself, I think, is flawed in the sa=
me
> > way. If f2fs wants to implement this internally, that's okay, I suppose=
, but
> > as a generic mechanism, I don't think this makes a lot of sense.
>
> And I wonder if the reason for submitting from a workqueue isn't also
> priority inversion?
>
> I haven't looked at the f2fs code, but that comes up in bcachefs; we
> have IOs that we submit from worqueue context because they're submitted
> in contexts where we _really_ cannot block - they're metadata IOs, and
> thus also high priority IOs. But if the queue is already full with lower
> priority IOs...
>
> perhaps what we need is a bio flag to say "do not block in the
> submission path, queue is allowed to exceed normal limits for this (high
> priority) IO"


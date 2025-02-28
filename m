Return-Path: <linux-kernel+bounces-537682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5EA48F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA132188B8AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105416F265;
	Fri, 28 Feb 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIZZBGA3"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F1276D37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712746; cv=none; b=u/3RT8RYuDt13yNtw3/w7p1LrTIVdbxZPRjNfcuSRBpFdSznncvBvdnoAIQsqTUMIZ3fHRkasiWJO+vx/8f9dm4frl72mzkBSl4HgUWYu3QWms4HnU0BzxLhLYjioV304x1QGPTuXT19le4twh65dNy8jua8U3fji4f4eySnp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712746; c=relaxed/simple;
	bh=oHiP6w0QQ9FksGOaRgiGtH9ZCmyyvOFlVqxe0pWOLv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9G83zJkhHEcrFgCEh2wKnnCw9vFApB1XJwUccYVEeEg89oT0znU9vYh7J9oVamuhmgTEKNFDLpK2h5XJVtmAgFlwzaGoPvZObN6y4a6HRJRxke93hI0lGb6hdIObnyGHF5oxi23RCRA1n34i9bW6NMdjXHY0QoW/m/HFWLCTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIZZBGA3; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ab78e6edb99so219916466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740712742; x=1741317542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alMolJo1IbLw+Y8FyeF/iRCvp4wSJg0MaBDm/ylmAEc=;
        b=KIZZBGA3SqMoOZ4/OPU/2X8FKFmz8QvIPZMrpJU9WPTWDmiAUxHjUZQ7TDXMsg6DnK
         Qp+HMhtgn318R85QGce/HgST8+AiAbj6BjtLmWmnhZSN+o8LwzN3gImE0IFFY3eQfvTG
         GbmaQVc7S9DMouefzqosH1d26PBHmZGTVafJVEb0lIDpBIZxKNQIi4y8qAqFj9l/xUUV
         g0qUWCGKZKvJOaWbx8ABppEHdL9sdlGK5XciAMctGFHcutJjxrCEMwTJJfbEtmA3xvwu
         fqH4uhBR8Qkq9bh8STahSLoz2ZzxkAdyhJEJtEk8YNjrXaSoajdanIzWF9DaafU1N2RT
         Bafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740712742; x=1741317542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alMolJo1IbLw+Y8FyeF/iRCvp4wSJg0MaBDm/ylmAEc=;
        b=TEF0G1bn/aNi/qSv1ptJFck8pGV2JSwf+SO9kFcdvyKzJV675eTVZHqcZzkCWfSLlP
         6a7ZbBA/5vK6YOQp+G9FMfLce2D0qRSlYY1BQ83s6qy/YWPMsaLjqax+O8e8uyUnKTiN
         Pv9WTfjiLvx2zYhL/5vOXL3Wf5/g/ckeH5gMExBVrtvQGtndc4r2J2cHHEt2C4ZHzCwd
         aWxDrPXDgBCoo4No7DP56T5s7zL9V1iRx9Hpl8trTKmOKfxjZPH7pOQnYUiW9+jOzMov
         i8Bsa7JruQ+PP2OyJ7xv9a/TkERNBnwbsgpuwAmVQbgObIoEWPloPZNZxbJDVBZNHuHQ
         Mvug==
X-Forwarded-Encrypted: i=1; AJvYcCWd6dRdncHTcP1bHBLftSUapHkcierggxpfvgUhNsmjepf8nXxNBl81UfZI+LVzRMVeMXIXinJAGGwo7u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvmp0Ec231BklMrivbItnd0WwqXKx5O9kntjLHPAX3BAHg9zlt
	s+Im1YosTc401jPzSxSqV6o2VnB1sAjwMcahrs8S0o8IxmdFd3S01tZsktRB8bYmOfajCpApc9X
	K+H2Qta+KVrnICJYMqiG2/X7o5w4=
X-Gm-Gg: ASbGncvip0NgffSxzDxpTwy7HnTomBPXOq5iHBYb0HVhrITJLG/G9A3TRdhsKgULstP
	w/vTWE2oGnA0tHLbZ4O0Zn78esIbCSEO6sU9BtJpAo+fOof/4uGTUjpwpTB7FDVg52VOia7ARx0
	dRQ2TiFVK6
X-Google-Smtp-Source: AGHT+IF32DYwYd+KQ1r9I+hSjp16/4dKqpqG+SxyzqRUdiGVXHsnWcpQdAPzSGomID7DCFLQFF/2rvukWRQ6W2jl4N8=
X-Received: by 2002:a17:907:7e93:b0:abe:f84d:3fa with SMTP id
 a640c23a62f3a-abf265a2aeemr162289566b.38.1740712741963; Thu, 27 Feb 2025
 19:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hxDdATNfb=R5J1as3pqA1RsP8c8LubC4QxojK5cJS9Q9w@mail.gmail.com>
 <20250227155431.2534325-1-joshua.hahnjy@gmail.com> <20250227161934.GA115948@cmpxchg.org>
In-Reply-To: <20250227161934.GA115948@cmpxchg.org>
From: ying chen <yc1082463@gmail.com>
Date: Fri, 28 Feb 2025 11:18:50 +0800
X-Gm-Features: AQ5f1Joh0aVbw7xiYVJ0kWKptPeL2p-x3jXiRWW-DQKziIHJqYrQ9XLsJvcdjV4
Message-ID: <CAN2Y7hxi9VUi=6Yc25hOPkuDyY9Hv++++8L45aVhLmRMXh9+mw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: when the swappiness is set to 0, memory
 swapping should be prohibited during the global reclaim process
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it. Thank you very much.

On Fri, Feb 28, 2025 at 12:19=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> Hello,
>
> On Thu, Feb 27, 2025 at 07:54:27AM -0800, Joshua Hahn wrote:
> > On Thu, 27 Feb 2025 22:34:51 +0800 ying chen <yc1082463@gmail.com> wrot=
e:
>
> > Previously, when the system is under a lot of memory pressure and is
> > facing OOMs, global reclaim can create space for the system and prevent
> > going out of memory by swapping, even when swappiness is 0. If this pat=
ch
> > removes that check, it would mean that global reclaim can no longer
> > "bypass" the swappiness =3D=3D 0 condition.
> >
> > I am also CCing Johannes, who is the original author of this section [1=
],
> > who clarified in the patch that swappiness =3D=3D 0 has different meani=
ngs for
> > global reclaim and memory cgroup reclaim.
>
> Yes. It's been the behavior for decades that swappiness is merely a
> preference, and that the VM *will* swap to avert OOM. You would break
> users making this change.
>
> If you want to hard-exempt cgroups, set memory.swap.max=3D0.
>
> [ Yes, it's inconsistent. But it's really cgroup_reclaim() that is the
>   oddball in this. Also for historical reasons... ]
>
> > > when the vm.swappiness is set to 0, global reclaim should also refrai=
n
> > > from memory swapping, just like these cgroups.
> > >
> > > Signed-off-by: yc1082463 <yc1082463@gmail.com>
>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>


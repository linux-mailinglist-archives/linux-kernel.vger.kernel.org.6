Return-Path: <linux-kernel+bounces-404406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2719C436B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDAB20E93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007771A76BB;
	Mon, 11 Nov 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WnB4BXFf"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAA1A256B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345469; cv=none; b=N+gGI6jpDn5gfQzx0AJeoyDHAnDK6ikVC76fhvWFKQSXOcbxytrFAEYXYH3ZDe7NzoCqjwhODd5Mw4ksxSjR9Ky5xYQ90PSVBG/mG6omYsZbjHghOL0xWnAiOaMMwW64pCiuBPWXaR7V/6YJXzKv2W0xm6ImTXhRLC+3Q84hd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345469; c=relaxed/simple;
	bh=XN4ROa+I7YpObw+DbqJY2keAge2wVJXtmQid2d+H/bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3ZD+fKjnOkINUsT5QMLrGrttZf+PS0x4s9DfFJG9pt+ztC2c2UeI7taQf5EEdZQVCdrBZ0O+b0nMKqAbBlX3u3fiJQwx2iktd88rbwve3eOdC7kipyDw1HEc6yspX/eFinKLt0GTzEwreiCnWumbRl8/bz34sSU9U9VzmJ0F8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=WnB4BXFf; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e29218d34f8so3372711276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731345466; x=1731950266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN4ROa+I7YpObw+DbqJY2keAge2wVJXtmQid2d+H/bI=;
        b=WnB4BXFfFImqqtWNjHM5if9Fyb1F8Pp7zbjrnhYH1q1W7aJj8yw2GNmUvB63eAk3HU
         9yKnSVXXfrGNGUj3o61Do86Kqot5laWBb1dOILt17/SrHWutlxe+hQRk2KmzftrJwjaL
         7aX2pIes2wQvFIPdRROkhuHuEwLM9fqXmjfhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345466; x=1731950266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN4ROa+I7YpObw+DbqJY2keAge2wVJXtmQid2d+H/bI=;
        b=Ni6geNT0L/sRfTMKYgUYYR1b/bAOljLt0lcpr98XCJsLTpcRw9uOk0kb5FVqtizuX4
         tAhfag89QU2z1qppYC15MQo0tLSy1A616nbSyKA3AafmPshMlTAwcri9DfepgAsURqln
         0lD5we8BKIUT4WoRe3NQWaNyc2c/HMneoIzid8Bq9PVlatmj53JVJyatjXeNRa6bbrK3
         EAlQAA+uApRhtN2newBas7YfR67Y6zmKT7xwRUb+QP1Hl30Sv2tJDu6DIrxQzr4qBWsB
         FY3AaAsS6E870pnfBIo/zaeclHVSDmzq+LYzoaTCh1Err4Q+iVkSjo8Dhxy3Wua7dUME
         aG4A==
X-Gm-Message-State: AOJu0Yy3ovKrjiMUhBgnrjaS42RoLX74XGFl1Ris92UpAca5y3k4iABl
	AUwm8v8WGFBemxSFvnJ31cVVTqvUKEI3C4d1jJD+4MLaftQBXBEFlfY10J4msj++Skxq5VTf8tG
	CWJgVD/JmSbKH/XR32BhT7n+1+ceDoWLxPCFbyA==
X-Google-Smtp-Source: AGHT+IG4kwWv1hSzVKWmfSXwts2GGIBTK7gsKoAXj70rm1qGJhHrsvXlFhce44oOqE4VSwrr8qa1EmOfUQGT3DQ0VlU=
X-Received: by 2002:a05:6902:18c4:b0:e2b:d72f:c184 with SMTP id
 3f1490d57ef6-e337fd9d30amr11201354276.4.1731345466541; Mon, 11 Nov 2024
 09:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-3-joel@joelfernandes.org> <a491e879-364c-4b57-aa69-28608d8af4f0@arm.com>
 <CAEXW_YTxgpEzA4Vo5+pX=iNYG=xioN=J+bh9YLdSFEc4bEXhLA@mail.gmail.com> <d1be99d6-0ce5-473f-9416-d33d61effee8@arm.com>
In-Reply-To: <d1be99d6-0ce5-473f-9416-d33d61effee8@arm.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 11 Nov 2024 12:17:35 -0500
Message-ID: <CAEXW_YT=Nefz95s=ed+q7wGi00WjpNbBYN61iSH9RvFCKXS7Tw@mail.gmail.com>
Subject: Re: [RFC 2/3] tick-sched: Keep tick on if hrtimer is due imminently
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:55=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/11/24 15:56, Joel Fernandes wrote:
> > On Mon, Nov 11, 2024 at 7:38=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/8/24 17:48, Joel Fernandes (Google) wrote:
> >>> In highres mode, the kernel only considers timer wheel events when
> >>> considering whether to keep the tick on (via get_next_interrupt()).
> >>>
> >>> This seems odd because it consider several other reasons to keep the
> >>> tick on. Further, turning off the tick does not help because once idl=
e
> >>> exit happens due to that imminent hrtimer interrupt, the tick hrtimer
> >>> interrupt is requeued. That means more hrtimer rbtree operations for =
not
> >>> much benefit.
> >>>
> >>> Ideally we should not have to do anything because the cpuidle governo=
r
> >>> should not try to the stop the tick because it knows about this
> >>> situation, but apparently it still does try to stop the tick.
> >>
> >> Any details on this? Which governor?
> >
> > I noticed this in Qemu (virtualized hardware). Actually I need to
> > update the commit message. I think it is not because of the governor
> > but because of lack of guest cpuidle support.
>
> Ah indeed, then it makes sense.
> FYI Anna-Maria proposed something like below a year ago:
> https://lore.kernel.org/lkml/20231215130501.24542-1-anna-maria@linutronix=
.de/
> I have no strong opinion on it either way.

Thanks for the pointer, it is great to know this was discussed. One
thing I am not fully sure about that patch is, if we can just drop
tick-stoppage like that. I share Pierre's concern [1]. Maybe a better
approach is to do some rudimentary checks for imminent events when
there is no driver/device loaded and only then stop the tick. I will
try to explore such an approach and see if I can come up with
something.

thanks,

 - Joel

[1]
https://lore.kernel.org/lkml/06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com/


Return-Path: <linux-kernel+bounces-540049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAAEA4ACEC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD31895E70
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C81E47AD;
	Sat,  1 Mar 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YcfZPEW6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07F1ADC9B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847897; cv=none; b=JM4SSOgfiHi554F+SFICZ0jfEhqCumzdDKbHeV4h6GBfRsgUMH2lWtrK3i9869ME1Pm/Q4ECPRTqNdTCmIPTOWviivE1tRDt9PTRJvC1thRkxbVtsA2v6dN8cxV4mdunrwtR4xQLO5s5Fe7ArUKx/+naMnoz43DiTZh12baLNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847897; c=relaxed/simple;
	bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+iVBSwpzd0sD7/M2+voIOhUmGM0+iNt9IWBMrDWR0a3vvh4KPhQiFqKQmyCLX0eu6apWum59syib5DyZamBxakvMzS+LNYbA/wNXEO4OztJR7K+ka0kSbo60hHR7s+f1OBUtIb35VAUtikHxaxGV61dsQg8xXwKfwcQn8tgOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YcfZPEW6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf57138cfaso89617666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740847894; x=1741452694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
        b=YcfZPEW6weDNQbjKvzwErtZMKs1YJdLNenLjjAlFx/RYkbM1Cj/W/l15R6cLm+rMxS
         0UXKGhQ1Bj/5/DHhfJDT5T7cXayxx6zTvW9F+SAlUsBidsR2lSkappTEjDlJgDW2YYGZ
         8BKl/gcoXKWVFLproDue8uEWGyHa3zKxkmubeb0NeZ0eJxsEghG7kAqFZI+0Uf+Ma5BC
         O0jn8JIrofG0sfQIihuWOhO8qcMquSeu26RhQQUJCo0O55IM5q4zfLwTP2yfLtoMneu0
         MkZLHINKwC2keVsTTcWJZ8v6ADcb8B4wYn6sIBtsFVgP0o7a0TrqgkC99C8vG7sX2BYY
         Pt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740847894; x=1741452694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9y1XIaCS4/WCdSoAgaT9vij7r3yu0+o9mPq0TfXXQY=;
        b=iJtW50jhukRnhqAwDwQNuUzgGI41VnYizXC4G38PaA2ATYy6li71tY+2saHe4qFU6V
         5S/Rj3Wj63+Llm6LbOFPygIE01l1jxwEChxGBTPnQKmmBifX/9zuIy+qUx2cdnOgCq+l
         LoDBZI/UQ9ESOwWI5yu1MluSSsgM2cRD75YNuMSHWoT2rZPiN5GSuSGSHn2nUS3nH5YC
         kQOZmglVA7QPaJSEHGoN++ndwwvRw518t0IQmAfJo/uiC3l2rF2+Q2/Zad1mloF2U23/
         OILRr+++ia9X9QLLsbgZlKiVHjqeZEU31US5QCcLfyhowXZ8y0KDfbgb43wiKbnhyYrO
         Lq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrgX20usuTjD0iARoL2ygRU+usHENBEbbiKht+ypS4fMsiBXVYCtTjWnOHFHiS179E+pSpu6r9cRQVakw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOoxmqPJww7zMErD/m1vbFqIa7rMyemsFH6iM2T25S9NsMSom
	PM3Vl1M5I4iRJ5qYLWFVZouxYeeMDjIHUxBmxodEVYr6j6idI6Svh/8oCLkxmZqJ4A8GBcPBGD0
	pClTPjITpvRIfyYTzSYJLYiAG++4UrmaXhWRHU6NeCfSBcQ5hk+g=
X-Gm-Gg: ASbGnctvEpBwOn9iDalIdlWzClwa/TKIS54qj2vFgc97co8tl5j6RZlQBnSumtv1N90
	0WKd9T8BC8qjfz7mpvba8Jm9h9462M3mhgE7OOmODrZIBmETobDT/N4TDtK3mGO6abIRCMqMdrI
	TfBipbc3DfvSkbymuc0tfzd0ef3LCEcppv7m4Cfg04caZ8BocmyUw9XO0=
X-Google-Smtp-Source: AGHT+IFYXvc121y6bi2508QH8dUTqeSWY5NhZJZqG4nMfOIOhL1fYaF1K2onpqRPcyP27mIyLfm41qyBG2MUuYbO9F0=
X-Received: by 2002:a17:907:9494:b0:abf:5d3e:7ca5 with SMTP id
 a640c23a62f3a-abf5d3e800amr254015566b.3.1740847893706; Sat, 01 Mar 2025
 08:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
 <2025022051-rockband-hydroxide-7471@gregkh> <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
 <Z8MW86zYK3VEPcHF@eldamar.lan>
In-Reply-To: <Z8MW86zYK3VEPcHF@eldamar.lan>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Sat, 1 Mar 2025 17:51:22 +0100
X-Gm-Features: AQ5f1Jq9sC4S5xjkMHqwwE2FS3xuXaRrtGAbEBdSC6KdiEIvXgpvhHXpBM86jWw
Message-ID: <CAKPOu+_WAM3RQJnHsKfEh5sG5tBuCPt1EWtoUFVC2ma=ORjHkg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Howells <dhowells@redhat.com>, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 3:17=E2=80=AFPM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
> Do I see it correctly that this will be 6.12.y and 6.13.y specific
> backports since the code in mainline changed substantially with
> e2d46f2ec332 ("netfs: Change the read result collector to only use one
> work item") and so your change does not apply there anymore?

Correct.

> I'm asking since we got a bug report in Debian which seems to idicate
> it might have the same root cause as you report, and it is at
> https://bugs.debian.org/1098698 .

This indeed looks similar.

Note that this is one of four netfs crash fixes I posted recently.
Two other fixes have been released with 6.13.4 already:
https://lore.kernel.org/netfs/20250211093432.3524035-1-max.kellermann@ionos=
.com/
https://lore.kernel.org/netfs/20250210223144.3481766-1-max.kellermann@ionos=
.com/
The fourth bug (that got no reviews so far) is here (this one affects
master as well):
https://lore.kernel.org/netfs/20250228123602.2140459-1-max.kellermann@ionos=
.com/

Max


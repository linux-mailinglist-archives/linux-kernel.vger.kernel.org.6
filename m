Return-Path: <linux-kernel+bounces-221352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40F90F255
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA70B1C21C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF21494BD;
	Wed, 19 Jun 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj+Ghtkv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142941802E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811478; cv=none; b=FBWGnW9vqQM5D/iQdPFJWnn69s8EliitONK2CphAUa4FsbkptuiOHY8/AZiWd/LNtVQvkinvI3k8UZVeE1kCtwUq3a/OmQ34TgaHDff+lVZE4Qkfh+jp9H2KumTWSiiuZDST16/cabMhLDYgjK6qyd2qG8GHMkEHorWqksu5sP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811478; c=relaxed/simple;
	bh=mJhoGN4q6uyxria5Rpm5NZ2gDNhkG12K9b6rSColdEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwqkFAq7rrWYcxuRBgsaZ6L6hqysLK/Wt6frgS2hNnq36iifMpTjr0MEsM/5lSTw2VP+WR0MaI0Ge29PIj4WTdawe75o7XGoKk0R4turN/+JOHu3XXi3y5oXp9MDcgAGJVT58H3E9uTnv0r4Slxse6Kia6jiNcu84kP/anG5Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj+Ghtkv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d0eca877cso1150405a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718811475; x=1719416275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpBmZ3ib4xI7+SnubC1rq/jcP2mXeb9MXah8Iw53YHI=;
        b=Yj+GhtkvdJjizrQ0SXH+OgYDCabxnJ4udd9f4qwIVj0gGi2y2R5ciWz1xvPrn10lXT
         5pROx1hLfSDMrkO4+7LhvJjYhxjSbzydaLCrDJAw7DrGyEuvDZ/l3cuXKbQgol1/7wXa
         7l0WDPTdTAWC+e6VDNByhgdlpFcSejYwUxpOrxdHHQP6DRfgf2pEVNqFte9kFzCio3Hi
         sn8ia4HCD2KxjvEn2jDiR00p/OpExzGm5sPJSJ1js2v5xNvvhzMVL4uSAk9bWPVpQppd
         8s04M9eA++pVJlVp3n3KEmhy8PM4DA+jNiy8IV9IH7IqKm4ovgTpjTvC2bFhjNDCt/TH
         REgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811475; x=1719416275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpBmZ3ib4xI7+SnubC1rq/jcP2mXeb9MXah8Iw53YHI=;
        b=qVuuLFX+cBTQgqxPYJTTrRhMy/MygunCUycW0LLNh3uYnqMtIYuH1r7UI+B230LIGs
         aDP5Uj5OkD45qPLVwLPpwQnzmQVLH7vm5ASNM6Td/xVfkksaBWHv87EkFdqcsOosk+hw
         lOtlo/QnK5VpoMR48JfltWfXyPRNe+zWejgzua4CTNrsM8OaHNdgUbx4WUZh3/LhL7Ab
         GRKbm2OY9VU3jh+ew0iL/NTIO2QpNWbrFtWk7y4IwFY/lqwhc2qxRGunG4bcj/OgnV5P
         msRKUyDgOLDc8vFewpaRIKoqtt2xPa+ween+4koJ4ysvI6JsSGlmhlRxE9pLjDiqP5ow
         AnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZOw9ABhy4bt5CVF3C382CLCFKgdCQyPCkTMs4hVHR6j3QjzMGp6i82ktQ98a+3sW92g+ogDM6WPLDHK1EfLwLnLSTfww/WR4xvI5n
X-Gm-Message-State: AOJu0Yxvn3S3OBFposwWIE9FesuEM11oudXpCZ/0GmkSxsRSV0tTp2Uj
	+XvbM5EAqR1r3aHEKrNzgUNmY1I8xOsguH7hEjjTMu42aDcJRGrm7LHmG9ZKy+QAB0ItxxxRyH/
	fhgR8U+G+Du6Z+ZXorO7CzK+5oww=
X-Google-Smtp-Source: AGHT+IE0loaN0axTBDRLmzig04cOZXee4WarvcqGqZjF4nQ6GQ8v7otsT0YAWBCuN5/c+dE0PPHGZct/sGaadcz/Ps0=
X-Received: by 2002:a17:907:7293:b0:a6f:6f4a:b25c with SMTP id
 a640c23a62f3a-a6fab60a2acmr237107666b.14.1718811474952; Wed, 19 Jun 2024
 08:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
 <20240614040133.24967-3-jason-jh.lin@mediatek.com> <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com> <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com>
In-Reply-To: <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 19 Jun 2024 10:38:15 -0500
Message-ID: <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:18=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 18/06/24 17:59, Jassi Brar ha scritto:
.....

> For example, when static content is displayed on screen, the CMDQ mailbox=
 never
> gets shut down, but no communication happens for a relatively long time; =
the
> overhead of actually shutting down the mailbox and setting it back up wou=
ld be
> increasing latency in an unacceptable manner.
>
Hmm...  in your driver,  startup() is _empty_   and  shutdown() is all
under a spin-lock with irqs disabled, so that too shouldn't be
expensive. Right?
Then what causes unacceptable latencies?

> This is why I opted for autosuspend - it's only bringing down certain clo=
cks for
> the CMDQ HW, adding up a bit of power saving to the mix which, for some u=
se cases
> such as mobile devices with relatively small batteries, is definitely imp=
ortant.
>
> I'll also briefly (and only briefly) mention that 120Hz displays are alre=
ady a
> common thing and in this case the gap between TX and ACK is ~8.33ms inste=
ad, let
> alone that displays with a framerate of more than 120Hz also do exist eve=
n though
> they're less common.
>
I don't know how even busier channels help your point.

> All of the above describes a few of the reasons why autosuspend is a good=
 choice
> here, instead of a shutdown->startup flow.
> And again - I can place some bets that PM would also be applicable to SoC=
s from
> other vendors as well, with most probably different benefits (but still w=
ith some
> power related benefits!) compared to MediaTek.
>
Sure, if some platform _actually_ has a high channel
startup()/shutdown() cost, it may need finer PM control. And I have a
way for that, but even with that I am sure someone from MTK will
realize they didn't need that.

Thanks.


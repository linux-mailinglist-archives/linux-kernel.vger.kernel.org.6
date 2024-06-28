Return-Path: <linux-kernel+bounces-233330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3851A91B588
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68C71F223FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A171F951;
	Fri, 28 Jun 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW5cGCxb"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819817583
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546021; cv=none; b=flAIfZ0dJwe2ETGdfe9laUdgkCL6t5CsW2BL5bpWnNQXJGIVKS3uLIWraHY9GjMdtj/bT5b3rf1NTTfF6RPl8eswFb708f4Iwo1el4ThGf//3ArZtXLt65aJEsOK673Qo5ssXXi6JDAqPxeS9pdsuZEL6emfVkiY8NZFwV9wmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546021; c=relaxed/simple;
	bh=GenQpBNyMA0AYju4nRnS2e5xNG75gyrxio66tWTcCwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3v1IOvBadBxTottihELxylhqxgA79fgO7vqcZFI3AmZmGo7ULVCm3y0rFwVuVQfG0/z9ArMRB9nPm47Oy7BCBBrEZ/+4PCd1NiEajmX7MhL5062VZUiFiQhAFtIvxo9gLLhlt8T/s73f0AZMQjDUqaQim25ZtLyD5okmp44kUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW5cGCxb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d4ee2aaabso129472a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719546018; x=1720150818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS9xqoZMcwoei5o8ahNVSTlTxVXDSb1SnPAKATTACBA=;
        b=UW5cGCxbClRmamlebVvt3LF4Vdtrs1/oTbZGAcv/iPza8jjZhtF+gZERWzB1DwkWOh
         +AYk8bYeVYAyI5rpRTU8/KZybN+mAt65blECnUpkqNys2LKC781I+a3rwaXyQbNil9qd
         kA8XMRFUcc0uoVDux3E72vzlT353Z+MIM8zyHl3RQJnyjTLODutSMHpU3Amu83AWeWNH
         jYSbDD0r1ZaGNF2b8vLiGfCnFbMJTHD4hXXA502iTtohwVInaNx8yVz6FbdyfHBwqqJS
         csQfba3bs3JxJ38L/ufdelRPBkH69KQ29h0wemi75J7UvO2Q2zH/9a79qI30hOFZCN04
         uXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719546018; x=1720150818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS9xqoZMcwoei5o8ahNVSTlTxVXDSb1SnPAKATTACBA=;
        b=sCFjj86Qw9n8ZgVuW9EoZtK4dXTyeW+Ou+LgEMm1tGBprmnuO1zXOEPPq/nC/GMbge
         K4EaZzLvAR+SUDTUr/2QGMjEqPbzuRI1TeU0LQBFCwzyel5jCHzgs9QrPuW88hntYUw5
         uZ7YbRJtGGY7nLeJeIbtLpSymYGgcQ2+1sca4jJCZEIlHx0m/O0zI+IrC+nvSTmqsGwh
         cMv7JTFgFunbzN4yuX8jibtpz5y9f3QM7nlkoc947OIKr7oMolu3+wzs5kFt2s7eemSB
         2eHRN23xEDhzCBZW5cLoTGYmbKudCldOEt69Zi1Pn19SPUJVBypQ/tL/UibQvdAZyLB0
         JF1A==
X-Gm-Message-State: AOJu0YxSFn8yNdxn3ETPnCueCDikKW9MvZlTkEXdOdU44SWIfvTa1f9j
	NCj5Ey0o+27qdNCVsVPDD0sN9NpDQYFORs8+wm/bXJ9qK3+aqWoDAuwzJhqX2Kn/cpCwv+T3LXV
	ph9qqzsWokMwwK5cX8UbJDH9++H9o7JgI
X-Google-Smtp-Source: AGHT+IEd4MYYyTGYgkdpW1lBusF7xMCqtMtDwYx3Q7a/fEbXrt6+jDUrcup32wPvlQ319IyI0k41m3aS8JS63hLYlkY=
X-Received: by 2002:a17:906:2a5b:b0:a6f:1785:d18 with SMTP id
 a640c23a62f3a-a7245cf2ee7mr928568166b.44.1719546017566; Thu, 27 Jun 2024
 20:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
 <20240614040133.24967-3-jason-jh.lin@mediatek.com> <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
 <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com> <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
 <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
 <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
 <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com> <CABb+yY3eXvJRUq7MOqB8QZ9N4aiuogaUCTfP7MerKdNbAbLkvw@mail.gmail.com>
 <895af04e45d286c38d01f48b29ad41598b7dadb7.camel@mediatek.com>
 <CABb+yY1EZOsKUR7WUX0Ni0Ukbqz0+yRHswiu07tNXtY1A1gNUQ@mail.gmail.com> <d6f0e7072ec0e89e573e5720fb2b9c621eb9154c.camel@mediatek.com>
In-Reply-To: <d6f0e7072ec0e89e573e5720fb2b9c621eb9154c.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 27 Jun 2024 22:40:06 -0500
Message-ID: <CABb+yY0+fFw7Bg578DFEdrigVFgf4-v3qo2JVruEa3ExtvRsMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 4:32=E2=80=AFAM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
> >
> > The idea is that
> > 1) If the gap between transfers on a busy channel is ~10ms or
> > more.  And ..
> > 2) The silence on the mailbox channel is multiple of 100ms. And ...
>
> The mailbox channel would not be always busy and the gap is not
> consistent as well.
> For example, display driver calls mbox_send_message() every ~16ms while
> UI is updating in 60fps.
> If UI dose not update, display driver won't call mbox_send_message(),
> so user may not has the gap and the silence like this.
>
From your logs, send_diff only increases from 16ms if the UI is not
updating. Which makes it more prudent to release the channel.

The user needs the channel for mbox_send_message, while actual power
saving comes from cmdq_runtime_suspend/resume.
So for your target usage pattern, trace mbox_send_message() ,
cmdq_runtime_resume() and cmdq_runtime_suspend() and compare the
timestamped logs with and without this patchset.

> > 3) startup() and shutdown() are empty (as in your driver)
> >   ... then you could afford to release/suspend and resume/request
> > during the silence period because the _api_ cost of request/release
> > should not even be 1ms. Your stack may be designed to make doing that
> > difficult but numbers wise it should work.
>
> Yes, that's true, but I think we can not achieve the goal during the
> suspend/resume stage.
>
> Currently, we use the pm_runtime_get_sync() and
> pm_runtime_auto_suspend() to achieve this.
> So I think adding the PM function hook in mailbox driver is much better
> for users driver and also more flexible for the controller driver.
>
> Please correct me if there is something I misunderstood :)
>
I have a gut feeling the logs above will make it clear :)

Cheers!


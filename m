Return-Path: <linux-kernel+bounces-251721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249A9308D8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 09:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EF7B211E3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E017BBA;
	Sun, 14 Jul 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLqehJ7Q"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7851134C6;
	Sun, 14 Jul 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720941133; cv=none; b=hX8XTg5kHN8ezRaPGoYzFDY5h6emqz0LBSJ/H1Q8NeuSx+4GZgOFBqs+HWLWrX1Jd/mXuZzisDLkYCpwcoO3R82zY/5YCLlT6tMprtkMP5oSm6+cIWop0kKi8NSKAlaTh9QZKkUGdF/3/K5cEbYi3RuvuOISBUMyuZQI5C/v+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720941133; c=relaxed/simple;
	bh=lFSie2i7sjpFsA5Rr/G39xQcQML22E6TVNyJ7SgAY1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWAA9E/D1T3cFkrv5viedJyP5CkA2Reuz0hJsw4jbFXFAPLut0r3sgRSlhqF7Z7Li4bhM/O5ldAUCVvr/cTDJjro7vneK+Puo1aZliGrBdnF0U42FAaBDG2ty+ULQnpUixafyyDBBJDU3VfhZ5A/eUyzRqrk3SbpbEhmSus5pgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLqehJ7Q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9c55febcso4280633e87.2;
        Sun, 14 Jul 2024 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720941130; x=1721545930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFSie2i7sjpFsA5Rr/G39xQcQML22E6TVNyJ7SgAY1c=;
        b=nLqehJ7QgI1LT1ngU7Bw6DQK3P6ugG/GnloAcutqODzuI+u4/IzXlKIF1wwROSkVZU
         tF7FntTHw2AO+1uddjVzsgnwJIOeFRb6sg3XrEWwKO4vYZFcUZbTPF7HckB5NCiOYVbR
         O/s8QuBoCDuMMMDj6oRHyhvkYqOT+gZI17V3KMtIhd+PNKZttlxN7UXArYrG4xaFMaw/
         KuOl/wiVuibH1+CVSNsLKPU7UDu2646otRTIn2/WsN171Ffjzv7e5DTljt4OW7okr2jA
         YwlfC3Hs8bLgUhZl+i/jriX31K5GwuZmptdKVbKuABBotSPgThmW6OZ0Q0mAGR9omTFk
         SrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720941130; x=1721545930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFSie2i7sjpFsA5Rr/G39xQcQML22E6TVNyJ7SgAY1c=;
        b=nuEWcxvtFIjfTCYImU8kNdZzXqEZtWTqTcB+QHhdqa6LVCQx3rx/O3mPLnvdcbHKet
         YQF5TNoIS38K8Fut1zS54Cl2CK4tprmSm51EMVohQ1ogIH87IKM1XbWc0nnoE8l+WUku
         6WZ3bvXAFnoC7GVjzccYqDmotAFd7FqnZ8WEvSeRtvJwmIZfSZLrFuISzAKPYXYvfZTO
         PfXLtugfXKiu082eRUK+y2a1xhY/X4Ix70YKn2kafyR69GFPjXdRwDgTGGCWpB56r7SG
         YF6AFOVC4c2c0di8LT7nKtxJgHsmPUOXnGLu/jn1wNd8og275C9TgjPPBi2aUn4I3g6F
         Rrsg==
X-Forwarded-Encrypted: i=1; AJvYcCWkQ+jMnPbA/KA7EnaT1K82HTI+ZHDds508/1fQsJgDV7HKhmPfPsLIa6ux4v1y8vCXiiX5DQre7mxz5MPq22RtOW6wjYJo+OgNbLrqalwCsgTlgjgrMx+0s7+TyP+JnhDk03Z4zjRA0g==
X-Gm-Message-State: AOJu0YxxI4xGg5Dbk+MvPD96+LcH7PTErfZ8xB/qitUOnE6gTkKkYGtU
	0d64prqzRvjb4xmhwZz1B3odXNGlE6f1Kijc2fGa7Cok7rtl8FPG1MrdQ1WZjCE6w0v/rxOkMt5
	y2IKmN1Pphw3q/U8Ixt4M4qsyGpk=
X-Google-Smtp-Source: AGHT+IFEo559tIWaynh0P0z994mlLiLsIV3oCE1GH/oEj3En9LzmZCbT5rpgbnSo2wWU2k37H9y+uG/VWcq2H7QCT8g=
X-Received: by 2002:a05:6512:3985:b0:52c:cc46:d59 with SMTP id
 2adb3069b0e04-52eb9999d90mr12150508e87.18.1720941129573; Sun, 14 Jul 2024
 00:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705093503.215787-1-kanakshilledar@gmail.com>
 <20240705093503.215787-2-kanakshilledar@gmail.com> <CAGLn_=tT08KUX0J+WURq=EXKDPj=--Wg3qmCjnzGxNeMcz3NOg@mail.gmail.com>
 <20240712-denote-disprove-ce271b70c78c@spud> <ZpFUWJ9ujDyeGORh@x1>
In-Reply-To: <ZpFUWJ9ujDyeGORh@x1>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Sun, 14 Jul 2024 12:41:58 +0530
Message-ID: <CAGLn_=tg_V+ZL2NM9i0MjxG+qAdQeJVhvChFL44Nm3pLRV9hCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] riscv: dts: thead: add basic spi node
To: Drew Fustini <drew@pdp7.com>
Cc: Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thanks for the updates on this patch.

Cheers,
Kanak Shilledar

On Fri, Jul 12, 2024 at 9:35=E2=80=AFPM Drew Fustini <drew@pdp7.com> wrote:
>
> On Fri, Jul 12, 2024 at 02:48:46PM +0100, Conor Dooley wrote:
> > On Fri, Jul 12, 2024 at 02:11:18PM +0530, Kanak Shilledar wrote:
> > > Hi,
> > > Any updates on this patch?
> >
> > It's too late for 6.11, it'll have to wait until 6.12. If Drew has his
> > tree set up already, he can at least queue it.
> >
> > Cheers,
> > Conor.
>
> Yes, I'm in the process of setting up the appropriate branches in my
> tree [1] and then I can send an applied to for-next email. The plan is
> that I will send PR to Arnd starting with the 6.12 merge window.
>
> Thanks,
> Drew
>
> [1] https://github.com/pdp7/linux


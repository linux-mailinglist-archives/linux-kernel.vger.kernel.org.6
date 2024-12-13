Return-Path: <linux-kernel+bounces-444288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726B89F042A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1AA161FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A011885A1;
	Fri, 13 Dec 2024 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgHLwlSp"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80921822E5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734067629; cv=none; b=GUP352yjfm03tJv8MSNS+Ljx4eF6XROwnRo+CBkHBSQqkbDUa+YAOIGHqk3FKNnu9G8st+TN7SQSA2sAQCElenWYBZVQCHMU8yn/14B+70lYZCxiWCOiF/cDK5tu6x5wfdczyztg3i1mEK7foxfAFZOaY2Zpgn8mekeKRtPiJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734067629; c=relaxed/simple;
	bh=Sdf13U4qdk1cMSPMh/hmbpEG7cuPIH7P2wBu29YqNYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMvh/5CW/wcv6FwPYAvNG3G9ILnvMZdliahrAX1m4UJlPABtC1Vm4ONOdME4q9olmqc2Zvj9MuHFDVUdDaR6hbwdVDGmD5+TMuedrANsgY+MsS+khpMpjkeoCE7wUU98zLcZhhnGjNwI/mwyAUgrW2ClDfFte2IRYYjo4qnbZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FgHLwlSp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df6322ea7so1891691e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734067626; x=1734672426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgQ1AfOgEV/WtM/A3+uz4rEIqiFfux5uHfmCT0tsGtI=;
        b=FgHLwlSp/kysqN0ivzcXMSIr0RdaGObx2c7a72F9DZAi4iJL2TfVoADtDal/cE+xnu
         cCMtnO2Hyl6oo2vAxqB714ToJ6bCA9fxCG+sbcjuCPAnBjHWXh62LqmmWGdbojqw/omz
         qyp5DwKjCQJnV3m7a4hEdbk99hI6FDwEpdC5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734067626; x=1734672426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgQ1AfOgEV/WtM/A3+uz4rEIqiFfux5uHfmCT0tsGtI=;
        b=CMSHBlRbehDEd3QBNXu8Uh4WYegRnajPPde5kPf0F45x3uEbuNzWZapIHh1Ke+8rlM
         HtfzdO/CTwLU2b9iLFNARm6XGiRTpjvApKzlgQs+rGGfYKrCNTXP12lXjcipLMMglYLd
         f6COh47P9O8WlXQQ//47K91noZ8YoxGGwkBbZK/eioJcw3shCSkbFnQVOImDy93WBHef
         HHtzqCK0+glR4ZdWjGtFcpiLWOrQ2F51aiULX5pneECyoN5anH+URR1FlBv4rqb0pK60
         Gm6+HqC2YmodVRCOoNurBuThJvu9+lgYaGtxQ6bs72hhb6b+43+m+TnrWQLKY5TKg/8y
         rhKg==
X-Forwarded-Encrypted: i=1; AJvYcCXXwaSDczM/lsm5AQ75B/AP7FnKiR6ha3WxnI+0If+kAvogUyMVQZaJkofJGGLXu9jcFh8dzLvjcrn7nPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zYWCeFELHG+TGXj1boQffYgfzwezQ9TBjv8g6CPhRiiE5ZUX
	v6VhMTTtFkSu3njIbUyQ9dgtaagHI6+s2Kq62N7FUkuHENAz0h/StgEGw2/LqeCGn1Ibb3pxBYW
	2SLO6YmE5zOPD5eKnNHF7P5f/X8IcK3YmT//p
X-Gm-Gg: ASbGncuBWPNWqePs1x+u89v/5Q85PDlXNErR8CnJaWnSk8oOT4pjoyCFscuOtFrzUEx
	yyWvsR4vgSo+p3wZMAuSCqIpBzZ64RiPPGHb2iiXUbRWSbEWlcuOa5zOwreqGPx8=
X-Google-Smtp-Source: AGHT+IGhA9h/qMEh3kQO//+RlkgxCOjtkEXubWQ5cyZXn60MBtkXvqcni0KnjZPJqjy4n1nnTxAQnsTV3Ek/V6fc5uA=
X-Received: by 2002:a05:6512:104f:b0:540:3581:5047 with SMTP id
 2adb3069b0e04-54099b69aefmr240381e87.48.1734067626143; Thu, 12 Dec 2024
 21:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025075630.3917458-1-wenst@chromium.org> <173381930438.18469.15845444123528821647.b4-ty@collabora.com>
In-Reply-To: <173381930438.18469.15845444123528821647.b4-ty@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 13 Dec 2024 13:26:55 +0800
Message-ID: <CAGXv+5HY4s+0Yn35BezRWLKPnYkURhgg59eSVED1_6Z3QyQHiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8183: Disable DPI display
 output by default
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:28=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On Fri, 25 Oct 2024 15:56:27 +0800, Chen-Yu Tsai wrote:
> > This reverts commit 377548f05bd0905db52a1d50e5b328b9b4eb049d.
> >
> > Most SoC dtsi files have the display output interfaces disabled by
> > default, and only enabled on boards that utilize them. The MT8183
> > has it backwards: the display outputs are left enabled by default,
> > and only disabled at the board level.
> >
> > [...]
>
> Applied to v6.13-next/dts64, thanks!
>
> [1/2] arm64: dts: mediatek: mt8183: Disable DPI display output by default
>       commit: 93a680af46436780fd64f4e856a4cfa8b393be6e
> [2/2] arm64: dts: mediatek: mt8183: Disable DSI display output by default
>       commit: 26f6e91fa29a58fdc76b47f94f8f6027944a490c

Thanks! It seems you haven't updated the for-next branch, so it isn't
appearing in linux-next yet.

ChenYu


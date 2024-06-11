Return-Path: <linux-kernel+bounces-209440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E462B9034B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A556282DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB117333E;
	Tue, 11 Jun 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WT6hV4V4"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5817332E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092970; cv=none; b=kJKDTOcvecdC39mzbExlCugC119chBErQaDmYFT+AZTNFf9x4AYYJXXbMu2dmwkv47efVA6jnHfxpe+xdr7KE4GMWC/RRRSLFgw1SI+1wJKzgrMKb/O7NVLGfNBkWHqC9KJmv3TGs0MSpZpfiLFVbpc7WxhxKJMf3VUItaF5Sec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092970; c=relaxed/simple;
	bh=lWc2nHEexhFavmycz68aTW7hPDVLvdwoBeRsopX57cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRyaWce4ydBwiln81eM8ny3icFJUIxy7JQ5cV48CwMpvyuL8Ax+XoN9UIpILxjA9BiVU3Y8Q91mewpVkba/9P//F379AXjMq7mkmAObBllQNzQe/ymza2Y8hWbVHnjrm2P7iOCGch9XlS2j5an+o52XsTFjx4qplpXDqoxk+jsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WT6hV4V4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso3457627a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718092966; x=1718697766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=or+4NmGXTUe0vxNapTWhccRz5KiVpXdBi26BBe10Eio=;
        b=WT6hV4V4eU/eN5Ojvf/6oEJZDqauU/2JherUv0UvOVwTYK8EHj6xPiNPhHZmspQLCQ
         Ab7mCdt673TPnFTgJ0aNgEDznq3+FGGTXrvb/qshfuTtnm6Ji1C6sDi2L+UXUxztzOtQ
         5mF0+v8jiUqSseEKTXDL+xGy8MeZ0FgDJTMD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092966; x=1718697766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or+4NmGXTUe0vxNapTWhccRz5KiVpXdBi26BBe10Eio=;
        b=PMBNEeg2PyeFsWCXdWPx4d13QSD193FsyJNTmDP/uGiOsu8wuG6bDOOOL0OeN3Bumn
         pFuVW6y+SjtMpO9mOG+sSL7N3tREtllZskYxyqvQNVewrfTMqotDd5V//3ApU+oMCG0t
         iF9xqiLSJB6qzOLjCoayk4cGcg/N/Zg++z5+mOXKU4SCITECwnhQmWXEPGJ88WQ/MHsq
         uJ5FAWuQ7SmQVcSyiHQe6gc1XaZa1bDlB4+TydcgSPjBfvHhwvsXKMgATcyKvu7ULQdN
         7QXRiT2s3B6eHCFMBifzDmp330SWWpk7YfHTrPETNHXCWNkb2UZEKYRyHGyrYN5IK7jX
         k/lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVriscpv4nlaKpa6GL/XeD/gsCb2Rcx4a2ZBrsSOUbg6ge4KGmOdb0+2vABPE2OZv3UgH326A/wLpfHAhkNTV4LMVtQecMDH5PZ+9ct
X-Gm-Message-State: AOJu0Yzll5+g8Ltwj3/ZEV/aDoiYPId5DeIgNdgNrqCVwE+hf9VlOhjg
	JqbM3UtIFb8Kk5Bd51lXdraG/1t2Z1q/MP/p6hHkjpQRwI6EaRvpsglr3PLqs8gEG5JpO+Q/V2c
	=
X-Google-Smtp-Source: AGHT+IEEtuS0VnnPOHS2PSzkpfMpk0ES12PwyQs4sfNhrzOtEpDA1ALjEk2v3aRjN7lfZYgTGhkY+A==
X-Received: by 2002:a17:907:9720:b0:a6f:10bb:967a with SMTP id a640c23a62f3a-a6f10bb975cmr497406166b.37.1718092966225;
        Tue, 11 Jun 2024 01:02:46 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef9100096sm480212166b.97.2024.06.11.01.02.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 01:02:45 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so347358866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:02:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhQNwNq2Y3wJWwdosGIMIj0drYCSMFA2sPGdkddsnCELJ7aO7GvbdRm7M54UxKO/HEs0XZyt/dhKMD+qzTiOZOdM2RFVd2LyEy+0eB
X-Received: by 2002:a17:906:39ca:b0:a6f:309d:ec23 with SMTP id
 a640c23a62f3a-a6f309df3f9mr177781666b.72.1718092965211; Tue, 11 Jun 2024
 01:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-da7219-v1-1-ac3343f3ae6a@chromium.org> <171762153256.557520.12011428649748199502.b4-ty@kernel.org>
In-Reply-To: <171762153256.557520.12011428649748199502.b4-ty@kernel.org>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 11 Jun 2024 16:02:08 +0800
X-Gmail-Original-Message-ID: <CAHc4DNJ3q=a8Wts_q12=R34eMbMq+d4PSEFe7YR+DDs=C_Og9g@mail.gmail.com>
Message-ID: <CAHc4DNJ3q=a8Wts_q12=R34eMbMq+d4PSEFe7YR+DDs=C_Og9g@mail.gmail.com>
Subject: Re: [PATCH RFT] ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol
 name collision
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alper Nebi Yasak <alpernebiyasak@gmail.com>, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:05=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Fri, 31 May 2024 08:37:54 +0000, Hsin-Te Yuan wrote:
> > Since "Headphone Switch" kcontrol name has already been used by da7219,
> > rename the control name from "Headphone" to "Headphones" to prevent the
> > colision. Also, this change makes kcontrol name align with the one in
> > mt8186-mt6366-da7219-max98357.c.
> >
> >
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next
>
> Thanks!
>
> [1/1] ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol name collision
>       commit: 97d8613679eb53bd0c07d0fbd3d8471e46ba46c1
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>

Hi Mark,

I accidentally added a Change-Id field in the commit message. Can you
help remove it before sending it to Linus?

Thanks,
Hsin-Te


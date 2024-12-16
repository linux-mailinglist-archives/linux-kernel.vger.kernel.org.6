Return-Path: <linux-kernel+bounces-447151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D399E9F2E00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8787E188503E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86690202C53;
	Mon, 16 Dec 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3U1x8XV"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88D154C0F;
	Mon, 16 Dec 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344142; cv=none; b=pX2axiz2EPCyl0vhqyMbvOUDbXLO7BQmOAouS8cE8KhwNRtXSAnQ+sMkPrwgsAUA9k9bgieaK3VkSyHhpyiCRjjMZ/mzqZt/p0sPCL77OMSEyUPi2xU3Pi/hwfcTm9q/dJlrx6X6uZ82ANq87oZAkJ1muRfUuA1xG7RYgubhK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344142; c=relaxed/simple;
	bh=xDbLjJvKCeb9w6zeqGxdCDY6pPJ/+d+WDXblufp1D9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHr9BD0NFET1vo4jKKqAbhlIw46355XcBvXWTWTMb7ZFzhpu0V4TiGqkRzf39U4e3pXiJ51+Kw81OgKOAiixXo57UbVy5+p9Q2GczIGosMqNlLZ/RZn8oy+dEmwGobD2tvjvl5ojol4lmPFMbFuddA4fpZqeehelRZ1NLa9rsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3U1x8XV; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ab29214f45so12933355ab.0;
        Mon, 16 Dec 2024 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344139; x=1734948939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUtnQtUZwTDruP2/ftJuflMnIurpQDKKM4/x/z67+mc=;
        b=B3U1x8XVf7ox1VHkUzYeluhXCZ0udhPdv2TDOh+5H78mLUfC3M8mvHc5nSP/f4xtZK
         NEPtihh0+ngj9+snAYl5xauo8lSCsZayBl3I5GsjXsyBt8SAUle9nYS6A6kPXI28X//Z
         OM7fUpI5GEcyBBUV9s2HHoJblrKsWHKvw4DWMYMgHES0/7JPx0ZXUuAVolMA+lZ4pDCF
         ijPfvaBNvLGWFDdzVPckeQmb+bG0onqmzg97rt2qMdjN23D1nyuNh4pJwtCQLLGKSWV4
         2yqKOgnMcrKw2u3rm6j2bkPd/bdp/jJEBKHdsnVttfB9SAzbV78ZUDKDfsypXcw0zXlD
         r5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344139; x=1734948939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUtnQtUZwTDruP2/ftJuflMnIurpQDKKM4/x/z67+mc=;
        b=rM2dU0SNnkUyyFEvdo32Qq9eVdCWPWlLgLwjtMA4D7w0fN1B0MxHG7jjSBEz2iSmKY
         mdC7tZ0N3gE4q5s7phuk/lZOoJrbsuzjDT0hFXnesvg5kWxETUB2mNG6ZZGyiaXdeDBX
         t7va6l4zsnU+/LCYwu9/aoY3UfFFzewWDK6RKbDxZjC293lA8DkMwfHL/gvm6VictgiQ
         QmGUTAfnQYt2RXZyzniRImrjwvCm3nPyKJiQKI3ioE6aWXXeC5pPT1G9+gvKH6e6PD7Y
         laYLVMzRP5mGm+ehS4QHurLZ9A4bR049V53lZxwTv2o97xTckrMsjgKCBPCvBk7ZiY+l
         aKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY+sWn07PmNSIE9oyKcEpD94el59GCRrs4tRbOoPJfmg1EgtW52nXcCBE7LuctGhJJ9sjYFl3K7ayfomY=@vger.kernel.org, AJvYcCXeQvqq8r49IjMackVmiwrYQysYQBTnasqoVkaEK+s/zaNFSti/80lQqeuPV3m9pR8jG5Joqfs+3d4NnpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU0wVVCPZohpEQQj+MqMf1qSxy2IhN9wPAmlsxcLFjAjU8PiW
	r0/thwoE4vwuUy4R0wKJ08dBghtDDKB2ClGPQnV9WHxX0LTedyL9dqWlVicV6eyAvdoowFl9SRv
	BZN7XZexHETvsldKAutjKoAn4bn73WDSU
X-Gm-Gg: ASbGncsg4cM9pKnU2yqi68Nz/mEtAL6/uQhTFr4lirR0HpztIEjZIRyxyMopVJZbxow
	yynJuHBWriBGGidzkqsX9pt3aXHac66c+EOg/pg==
X-Google-Smtp-Source: AGHT+IEDJlno2zY3GQ7X1FzMPtkLhe2fgj6CaJPAPr//OtvSCJ+c6KaFvIK0GSAdVOnKhhCCVhgEu4BF+U1EqDmITWQ=
X-Received: by 2002:a05:6e02:2188:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3aff4615df0mr122004105ab.5.1734344139576; Mon, 16 Dec 2024
 02:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216093410.377112-1-arnd@kernel.org>
In-Reply-To: <20241216093410.377112-1-arnd@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 16 Dec 2024 18:15:26 +0800
Message-ID: <CAA+D8APYY=_UJptL16LRL5WZ8p723DK9=Yk0xaFfmeZrPDOXug@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: compress_offload: import DMA_BUF namespace
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	=?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Yu Jiaoliang <yujiaoliang@vivo.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:34=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The compression offload code cannot be in a loadable module unless it
> imports that namespace:
>
> ERROR: modpost: module snd-compress uses symbol dma_buf_get from namespac=
e DMA_BUF, but does not import it.
> ERROR: modpost: module snd-compress uses symbol dma_buf_put from namespac=
e DMA_BUF, but does not import it.
> ERROR: modpost: module snd-compress uses symbol dma_buf_fd from namespace=
 DMA_BUF, but does not import it.
>
> Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation m=
ode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>  sound/core/compress_offload.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.=
c
> index 86ed2fbee0c8..ec2485c00e49 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -1247,6 +1247,7 @@ void snd_compr_task_finished(struct snd_compr_strea=
m *stream,
>  }
>  EXPORT_SYMBOL_GPL(snd_compr_task_finished);
>
> +MODULE_IMPORT_NS("DMA_BUF");
>  #endif /* CONFIG_SND_COMPRESS_ACCEL */
>
>  static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned l=
ong arg)
> --
> 2.39.5
>
>


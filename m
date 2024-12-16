Return-Path: <linux-kernel+bounces-446831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287A9F29B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33101646ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149ED1C5498;
	Mon, 16 Dec 2024 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPdMIh3V"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFF157469;
	Mon, 16 Dec 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328152; cv=none; b=KWpkcdSa+zuwjU+Dg8e3w/vlG4NLt06jTgMNfbhUxUUzukJHjHKmL++ubr/YBus+Ez9Zm1/O7aBjZHXvr6zlTYPKz9bUduh/pT4SQd03F5MaHz8biNDlecmtfuoi6lfY2QCE2K8CJK4HqSQkZTpHWB5HWHZ4BGbrJ6Ox9qUX2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328152; c=relaxed/simple;
	bh=+7SWnvRblHwS5TQWVaHUdfqFrX68xW4BJLU83twOZlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecXAyZne4AohXSt+/qAWYcORFjOvq9yqUQNKvBNQ8F7fVxa0yFubsx/9zjTWordTH22MU8LP4OiHcGfVA2oHUWlkZ1I3yRSnZoRt9ZYrtJ403TE43p1SBABhaQoeokxArTRhnzY4Iot5TaNx+DqZUPE3FlEgaJAPUpmvtNnVWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPdMIh3V; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7d7db4d89so9977915ab.1;
        Sun, 15 Dec 2024 21:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734328150; x=1734932950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3WCqawu51nGJtomHm2SdIwBLPezFP5ayk84KicveD0=;
        b=JPdMIh3VKbH5HTX09b0GGTxCVl3wm2Q+XtIQlR+nOI/zrAcLJxAO39dPRVV7v2npzN
         rZ3cX4Z+Eem5q4QRwvquCzJb+T5SYykcK6g5oDkiPKSLqscLxfuGC5v/RxXg4XUBA3HA
         56j92pcV7B8saKZ/bxWtvUTND0mfiWZv+PGFeDf/poxRifjfd4bdvm24AYzmfusxrUDk
         rJAl3P8VDN1/h5Qw894yvug90cSJRvhyKdq1ypMBVS+5EyH0rqhHTN+nwPsnNXt5H4RR
         jbhoFLVE2DHdFdYymZRz4tF7b4Gq9Hb1brsZGcEkA23mTrWiZ/Yo8+xpbr6+4vcJz4TF
         Xwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734328150; x=1734932950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3WCqawu51nGJtomHm2SdIwBLPezFP5ayk84KicveD0=;
        b=nYKtC4J62zDPShbbglJslgjzRnbFPzb0tC8Kig6HjvA1FGTmkXL49E8JihOwN4Nut7
         cI0bP6PkyBeNicAzLM2yWLMbBhYBIymxAd4w0k9VKoX7aV3iWHhLT4q5t3bSkDU9MTTX
         FCfe177R0BTj6oJ+Kj6aIFe4OXHEdkx2tPLf+D6ZMa9J2EuuVTUED9sn9zbyCxzoVHpK
         AIgwuCASicWRgG61zZXTND2N1uelxDxU12nQDiuQgmJAiBccAwm1C7af03I/FkpNjl56
         UttUUatuae540P4gRp03JfSRTT4m22uuGvr0MpW09/b3iK6ZVhZ0248bYYm0vID15me8
         Jcfw==
X-Forwarded-Encrypted: i=1; AJvYcCVo0HtsaOcgXAZ5AK50TDMXeqWOvp7njEz/iFizZAr6OSR6a1bJYcPfj3zHAwnLhkCOmAFW3ED1+ECHHyI=@vger.kernel.org, AJvYcCWjivOazkS5uIeKD8w9827tDK1W9pKhZz23aCfQjthqH/h6PSv4RLhS4gyGk2y+rw6b2ZE16zPTed6isAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3ZJrF+F9Ez8fP+tC/zMmJrfUkOEwpM5X1Z41TY/3bQEjwr4x
	wk2+94EnBmp0ABDecs9Unf6nU+ZvQixfjIXU2wlbBpbOYFkK6XqplGp0fo7Px01HOdCXs/3COli
	mwmbYCo8KTqDL263s0XnMl1Ux98Q=
X-Gm-Gg: ASbGncs1yYuhqoqtAhqyHapB59XzH6ViaJqRAOQXy45meqxHiRYqV7oXRnHZgElRSU4
	09Q0cruUAS6IQSG2aGX7z6l2YMwhh9utj4tCqHA==
X-Google-Smtp-Source: AGHT+IFKdtm9Pk+1kLL8OCl2wd0nePq6kT1ViT+ZuzegrIP2U2gpQXMypljyuBaDo9Zc5NJGMWH1FusdlBlf6PGfjnM=
X-Received: by 2002:a92:c249:0:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3aff800f116mr103020195ab.18.1734328149917; Sun, 15 Dec 2024
 21:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216021136.3763127-1-shengjiu.wang@nxp.com>
In-Reply-To: <20241216021136.3763127-1-shengjiu.wang@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 16 Dec 2024 13:48:56 +0800
Message-ID: <CAA+D8AOWPRU1gGco2CoTmPtosd1eS4qGnOdg=BEd=_HGQKUZuA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: compress_offload: import namespace DMA_BUF
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, 
	lgirdwood@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 10:12=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
>
> Fix below warning:
> WARNING: modpost: module snd-compress uses symbol dma_buf_put from namesp=
ace DMA_BUF, but does not import it.
> WARNING: modpost: module snd-compress uses symbol dma_buf_fd from namespa=
ce DMA_BUF, but does not import it.
> WARNING: modpost: module snd-compress uses symbol dma_buf_get from namesp=
ace DMA_BUF, but does not import it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412150026.EMUdbO09-lkp@i=
ntel.com/
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

missed fixes tag, let me send v2.

Best Regards
Shengjiu Wang

> ---
>  sound/core/compress_offload.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.=
c
> index 86ed2fbee0c8..6f2d389abd04 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -993,6 +993,8 @@ static int snd_compr_partial_drain(struct snd_compr_s=
tream *stream)
>
>  #if IS_ENABLED(CONFIG_SND_COMPRESS_ACCEL)
>
> +MODULE_IMPORT_NS("DMA_BUF");
> +
>  static struct snd_compr_task_runtime *
>  snd_compr_find_task(struct snd_compr_stream *stream, __u64 seqno)
>  {
> --
> 2.37.1
>
>


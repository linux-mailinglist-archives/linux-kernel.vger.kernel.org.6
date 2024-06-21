Return-Path: <linux-kernel+bounces-223808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502F911867
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF918282849
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6884039;
	Fri, 21 Jun 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoaOcr7E"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA6625;
	Fri, 21 Jun 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936492; cv=none; b=XBQefIPZFdkUzKikjee5d2kTxv/E419El3pTpUbTAl4f3uwLTgSWYye3H0qwZpsgZAXxX3HfMGTtnsG7ra+GLpkNheZ5iSYaqvqimcib2RWz1ULWxwX3xYiHf4Q0iTJ6hJXMUME62CfIzsxByM+x533pX9y2dBBdzVHnWoOxL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936492; c=relaxed/simple;
	bh=K6TXBBkcuGG3+1AOnlgP+3FCiMsThHscvB97VY8MFhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAS3vgHjReLayi8cxwGoIlZ96U6RthgIPbDYv6VCbqQA0bPD7UijaAmzsoiGj9PpeKlfdss0zMD62bg7pTHbi1L5RpDENyWk3aTDacJHu7xAD1658jido0NYq9gttqQFh64Osf5c4KexhBUkwqpCE1orBWJnHtZgIFH2aY645zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoaOcr7E; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3760121ad45so6070585ab.0;
        Thu, 20 Jun 2024 19:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718936490; x=1719541290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSk8h7hKbIPqaEw4OuvVmqhytgxXbEHflO4uc1Iybpk=;
        b=NoaOcr7EPP8o9lGXVD2F2bK2+h5P2+wACC+6Pdx7qo2mLoHAOZIf+fGyKGBThRIzLu
         cjOLLjIBSS2UklxoNT6GQfq2aeCHo16sauOqdlb8ou8S2XFeyqhIoaSmBp3MT67Z+wLj
         kYGL+k3ocDNxG/3hZYE0l1/iHvgpST1Is6h/4DETI+hcl4qNfoOIzmof2xgf/0UwCUXJ
         npYm20u37BgMsaNr3Xxz74tP8eJljFvYx5OCBbaR8Vi+np+3KkujjWOS6jIRSq0wLGNt
         +Sd9bphlTkZPygKdYgHlkySZZU1NfYRpN6TvMQzoxm9lrG3I9rHQJEZFnTVbcf+I5ZCo
         y74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718936490; x=1719541290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSk8h7hKbIPqaEw4OuvVmqhytgxXbEHflO4uc1Iybpk=;
        b=IAkteGMtZPjr51d20OW0W+xYls9jk28BrAEanPHN6x7RpJAb2gPIO6wa1crWBm3uWH
         Db+zG6oZ9juhdl1Ji0QBLeqNEvUFo3u+uVL9n3GibQ3rzquEtXCqhtiyEasuYt7I5mq9
         qLRnfB8U5YDQnamBPvUbkyr+izqWsTVze09qqBXdoHEb22ESgaf9XeWEOTrkkQFIaNQh
         KEQZ86+E4LYOZGUqGzGN20iYuN7N5V4g4U6GzYcZzLSFEc4eDTzOWchJ93ADtJgQnA4o
         +Hl2J2x/n+kI9GBQOMCNzEetijUvqD6700VYoQTj4xlc1MVN88s6kFkiuxvz8vTfBwfi
         xuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIOrdeXRxD7HK7E+wGWPNJ+umRJmilDK+P9lUDlKC+9Fi6C0iqv7jHO7w5FZ6ZsWPOL1VK0cblNnSk/br0pgQvOApL0GFsDj+1tbuJecupCDBxQPXoPiI7tMjBkD6l69DHYZdpygTmv+k=
X-Gm-Message-State: AOJu0Yz6fe7Fp/QzdEfrtvJFhNgjBsOGJ0cpkorHfAP/oHzx2Or+dztK
	pkt4YTlDVdBNQkY20XjA9pwl2025qsDr0jS1x6+n7PNbSHisWycOcFDIDuDcuK2+pXAnlGPfmxW
	7n7/VZIDM6D2YihRcMF5BfyrpQH0=
X-Google-Smtp-Source: AGHT+IGmfVNJDop2DudLdwqs9uZVTjlcrH2ShhifeWXIuD43SSv94NurFFxYTdFRVLVT3Fyp2S1okJmsNyfPB0Oapa0=
X-Received: by 2002:a92:c269:0:b0:374:abf8:4f65 with SMTP id
 e9e14a558f8ab-3761d74e1d1mr72390415ab.32.1718936490164; Thu, 20 Jun 2024
 19:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718851218-27803-1-git-send-email-shengjiu.wang@nxp.com> <87frt82gj7.wl-tiwai@suse.de>
In-Reply-To: <87frt82gj7.wl-tiwai@suse.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 21 Jun 2024 10:21:19 +0800
Message-ID: <CAA+D8APZ8-3NFceuQeTnEL-K4reUGGfrgyG63jyjydFA6o_4MA@mail.gmail.com>
Subject: Re: [RESEND PATCH] ALSA: dmaengine_pcm: terminate dmaengine before synchronize
To: Takashi Iwai <tiwai@suse.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lars@metafoo.de, perex@perex.cz, tiwai@suse.com, 
	broonie@kernel.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:56=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 20 Jun 2024 04:40:18 +0200,
> Shengjiu Wang wrote:
> >
> > When dmaengine supports pause function, in suspend state,
> > dmaengine_pause() is called instead of dmaengine_terminate_async(),
> >
> > In end of playback stream, the runtime->state will go to
> > SNDRV_PCM_STATE_DRAINING, if system suspend & resume happen
> > at this time, application will not resume playback stream, the
> > stream will be closed directly, the dmaengine_terminate_async()
> > will not be called before the dmaengine_synchronize(), which
> > violates the call sequence for dmaengine_synchronize().
>
> Hmm, I can't follow this state change.
> Do you mean that:
> - snd_pcm_drain() is performed for a playback stream
> - while draining operation, the system goes to suspend
> - the system resumes (but the application doesn't call resume yet)
> - The stream is closed (without calling resume)
> ??

yes. this is the case.

>
> If so, it's rather an inconsistent PCM state in the core side, and can
> be fixed by a simple call like below:
>
> -- 8< --
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -2700,6 +2700,7 @@ void snd_pcm_release_substream(struct snd_pcm_subst=
ream *substream)
>         if (substream->ref_count > 0)
>                 return;
>
> +       snd_pcm_resume(substream);
>         snd_pcm_drop(substream);
>         if (substream->hw_opened) {
>                 if (substream->runtime->state !=3D SNDRV_PCM_STATE_OPEN)
> -- 8< --
>
> This will be no-op for the PCM device without SNDRV_PCM_INFO_RESUME.
>
> But, this may need more rework, too; admittedly it imposes the
> unnecessary resume of the stream although it shall be stopped and
> closed immediately after that.  We may have some optimization in
> addition.

The suspended_state is not cleared that the resume may be called again
at the end of stream.

Will you push the code?

Best regards
Shengjiu Wang

>
>
> thanks,
>
> Takashi


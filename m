Return-Path: <linux-kernel+bounces-279146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FE94B98F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7331F21B58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359A146A87;
	Thu,  8 Aug 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIbSMyXI"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F12575F;
	Thu,  8 Aug 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108687; cv=none; b=MGnxBbNpugtZbcHeJFrVbSE34AqALsSPBpxeWefUSha1pQJ6FVWGa5Pc+yoO3X9kMFin4rP2DoMAuJ362aedNvfcqHSNglR0rSgKcp5LMdPhzI78bAI0WHkjyzMtJRTwcp8U68Hq0NARbpgLj/98IbhiJ7NuQCNL3nGQlAb/i8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108687; c=relaxed/simple;
	bh=Dn37q0zxK+IzrlVlGi41Gx+dbyz8wiLjnCD5TZ2BVHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kc8jWWPSYIopwQK3Yyl4vbTPisn/EaDpDsuJAgTmPwJGXtYx6nR9ytdqOyjjyZDOTNgr8LPCQO4CKSVu9i0uvomBMcBWlLtontZhcu//BtPm9Vaje7yz+qJE5KZVBp2uWfM50wRV5euXuSuTm3AkYBYXjeoeniHMi9HWi8HSRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIbSMyXI; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f921c40a0so26262839f.0;
        Thu, 08 Aug 2024 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723108685; x=1723713485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REVFtsd7kP8SZQgw0r+/fGQwfeWNPXAh6Qw7M45oeOc=;
        b=jIbSMyXIGU5RvPhZKuzSFpibEPXM8QtwsJ1zUTPmCSNBR7dCNrBYWhRgMt0DC6b9R6
         SmFzjcSXN+Ll2ooAW1/zm1lYdrzRxxWfMLfJuJ8mG2sRkt1qm/b+BxaDVlNad953lnkL
         GpQKtVuMkSl0/ejZR93DvOaFW56kp/y5Uv6zxDHbouohZR90B6hkyu5Q6JwL25jyWXhv
         N9R+/g16O4X2sgyFKHXjurwDZcZlLQVzRzrUG9wd0Pu/GbGmtOk69JRIhSpKQ+BzYe9r
         JHuaPhXlu0vNx2GCkd0P5YJ4FoiI9AQ3n5rADIbSEqLLssNYsh4L9j2C1/egtVqiKnbH
         w9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723108685; x=1723713485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REVFtsd7kP8SZQgw0r+/fGQwfeWNPXAh6Qw7M45oeOc=;
        b=nqNY+lUzf0rCQCt0142JSvkbZlanYvyjCLTh7hPHDM/3QLMjvNqoaM65rVhXEa2k2g
         We7w7xFtBk/OcamrekvHeDy80QZT1GxzDMmmB9ooQuCJq4RpDtpEyUUILfwtKBs9Fzr7
         mxaXh1b2vfxdLZkF8Jj9HsWW+xv9AOvFh5qeYpfoV/9/YvUxSpMHeUKmkcjCdvanoEwT
         ZcTnA2cxjMJAOy7VETj9xogKhmiRrg8sMp+twhNBVUZQ9/cxev88oPDUrxhsrWLlyuPh
         LYTPAmInqoUnbwe97M4hrSowJ3iV5Pv1/CS/OdDmnOCkrf+Np/Lfj3QDFH0uaGWYWJo3
         ey/g==
X-Forwarded-Encrypted: i=1; AJvYcCUxAI5+ZrPhErVnMcRjOb2eUgs14qGXUzOg5Bs2MnDPJeIt1AMa2k0lNAWWSsaZ7WYq4Nb+5DqM04AfiFbL2io8O/5L439dD1AYqfBgd+1y5W+JS+9IGJLivsL/TcdQwZ80XvwX4MUx3Ag=
X-Gm-Message-State: AOJu0Yz6GNsgnZBIlX5hdkAPoEDvI+Pg/GZbERMGNbLt8HlV7Q3ck8XC
	FDJj69LtQ8JkWUCKT9nLPlhTb6KLZMQo7z3ayv3yJ+5YPm1xEC7e9rIqtF3radFFMWEyCNHvcTf
	CYehf+ooUwtB/UczMs3R0edUhBL8=
X-Google-Smtp-Source: AGHT+IEjn7a01cBmdtTZmS2Jngj4iwhQXD0sAvy+xjfVRnfVk+u+mV1GNclk46ZWlpryZJLGRifYGzNADxyjfJHrItA=
X-Received: by 2002:a05:6e02:154c:b0:397:2918:6f52 with SMTP id
 e9e14a558f8ab-39b5ed4a0e4mr12415825ab.25.1723108684958; Thu, 08 Aug 2024
 02:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com> <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
In-Reply-To: <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 8 Aug 2024 17:17:53 +0800
Message-ID: <CAA+D8AN9JXJr-BZf8aY7d4rB6M60pXS_DG=qv=P6=2r1A18ATA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:25=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 8/6/24 12:26, Shengjiu Wang wrote:
> > Add Sample Rate Converter(SRC) codec support, define the output
> > format and rate for SRC.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  include/uapi/sound/compress_offload.h | 2 ++
> >  include/uapi/sound/compress_params.h  | 9 ++++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound=
/compress_offload.h
> > index 98772b0cbcb7..8b2b72f94e26 100644
> > --- a/include/uapi/sound/compress_offload.h
> > +++ b/include/uapi/sound/compress_offload.h
> > @@ -112,10 +112,12 @@ struct snd_compr_codec_caps {
> >   * end of the track
> >   * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the encode=
r at the
> >   * beginning of the track
> > + * @SNDRV_COMPRESS_SRC_RATIO_MOD: Resampling Ratio Modifier for sample=
 rate converter
> >   */
> >  enum sndrv_compress_encoder {
> >       SNDRV_COMPRESS_ENCODER_PADDING =3D 1,
> >       SNDRV_COMPRESS_ENCODER_DELAY =3D 2,
> > +     SNDRV_COMPRESS_SRC_RATIO_MOD =3D 3,
> >  };
>
> this sounds wrong to me. The sample rate converter is not an "encoder",
> and the properties for padding/delay are totally specific to an encoder
> function.

There is only decoder and encoder definition for compress,  I know
it is difficult to add SRC to encoder or decoder classification,
SRC is a Post Processing.  I hope you can have a recommandation.

Thanks.

Best regards
Shengjiu Wang

>
> The other point is that I am not sure how standard this ratio_mod
> parameter is. This could be totally specific to a specific
> implementation, and another ASRC might have different parameters.
>
> >
> >  /**
> > diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/=
compress_params.h
> > index ddc77322d571..0843773ea6b4 100644
> > --- a/include/uapi/sound/compress_params.h
> > +++ b/include/uapi/sound/compress_params.h
> > @@ -43,7 +43,8 @@
> >  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
> >  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
> >  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
> > -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
> > +#define SND_AUDIOCODEC_SRC                   ((__u32) 0x00000011)
> > +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_SRC
>
> I am not sure this is wise to change such definitions?
> >
> >  /*
> >   * Profile and modes are listed with bit masks. This allows for a
> > @@ -324,6 +325,11 @@ struct snd_dec_ape {
> >       __u32 seek_table_present;
> >  } __attribute__((packed, aligned(4)));
> >
> > +struct snd_dec_src {
> > +     __u32 format_out;
> > +     __u32 rate_out;
> > +} __attribute__((packed, aligned(4)));
>
> Again I am not sure how standard those parameters are, and even if they
> were if their representation is reusable.
>
> And the compressed API has a good split between encoders and decoders, I
> am not sure how an SRC can be classified as either.
>
> >  union snd_codec_options {
> >       struct snd_enc_wma wma;
> >       struct snd_enc_vorbis vorbis;
> > @@ -334,6 +340,7 @@ union snd_codec_options {
> >       struct snd_dec_wma wma_d;
> >       struct snd_dec_alac alac_d;
> >       struct snd_dec_ape ape_d;
> > +     struct snd_dec_src src;
> >  } __attribute__((packed, aligned(4)));
> >
> >  /** struct snd_codec_desc - description of codec capabilities
>


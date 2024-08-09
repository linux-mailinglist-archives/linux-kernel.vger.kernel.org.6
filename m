Return-Path: <linux-kernel+bounces-280738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5D94CE61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DECBB20E56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F819148D;
	Fri,  9 Aug 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdGNbkRa"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5831EADA;
	Fri,  9 Aug 2024 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198486; cv=none; b=kGx3K3ffqbTxX0fOrUJzbzg7QJYxzRckdlBxWBsz4Yd+UiyHMyYgis/EKoEINgoAe6Sehg+a6lOKCxg1islC+VkFMQdKLRVoHNc6SUor9Ax1Q1IDPyTXvIOz429NIkM90qLrGrMRDm4b6fefaJ0RDOCV8h3QB2UEPyEYtoPtSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198486; c=relaxed/simple;
	bh=NUmuGYnW1zobD4I8ByFfdLUrvlZrQZRt1EAvdJj9LVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFwmobN8+9bsrxUy0dHaO3dyBwzIFP8UdvlCFR4UCWBM2ctkQFp2BkVwq6rMXWdfvNwtmlmr+zaZk2LlUeEAv6dSGGfcz8aIPrz2N1ujHkVAvpSMeQb2cQ/AismyzXvtC4fK8QdT2n7rxCfCW9No6EjZW3pMYkN9128uc8vIOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdGNbkRa; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f8f0197abso92386239f.2;
        Fri, 09 Aug 2024 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723198484; x=1723803284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfsf46z9wf1GW1rvhufmjrriglyClBeG24vWvW2wbYg=;
        b=cdGNbkRaqD3wzRyGig1AslJjNXLEdQtTnQ6c9AyuQ/ednLHHH5UQzfAIDkC8TMqa9G
         iVT5JxcYeT+Ok9HvVKImuK3EVYHdb5/aU+8OhTcDVkVmlj6xlhvgSh4hyAwhlFfRMhRM
         hHeoSdxFzLryVxv8zDTUxuZPmmXyyXjAQqhVwBrkNXzpJAYNtzxde8PdlXNgp2xQGUkV
         LjuWtXBqFXEmz01oZp5oRsrZ7jJgoHE+nsgIRV0Ly8rGUAjvU9+N6fDxpHKboLfsESPp
         qBu87peFMmtAHe7/FK2/i8eA+sRwsxkpjoAHJZf6Jl+iuaUM8Z/v6d1P4uSCeo4r1Gyh
         +fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723198484; x=1723803284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfsf46z9wf1GW1rvhufmjrriglyClBeG24vWvW2wbYg=;
        b=DEOzrmDUDqWATTbBCpBmjJIjFOxYjKL/Q56AGmWqDFr3Kwa9eQ/6jERowIHzxHU6I3
         /otNty0fCWCqks8y/pqeMnWD4cLCH/ZGgWmEnLNdacD67ifgyYDXxk2lU+RlrOPxECaR
         adjiQn+Tq6HUFFjoMSXWx77M5J21CrBdAsEHf/0fJ6AXT1Y4e+D6jx92FICzzGT/N0p7
         vJJzJFRdVtJ2OxkuFmFnyF8ZWk+MBcmTnU8vvGfZAqN0yFiUTLTNeQ7DPHwBc0H4Ur77
         o6Gu6X26zAvY3BxIyJM6dt9mNF2Zr1P6duwW8iqKFy59LOsPcpPpkcgSiAnLXYFYGXCC
         qxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWAdZnX5pRkLEBuSVVRl6p7A7RQyvUY8JmaGHCI5hxrzxhy+8zUzKQ34hXaYt50oQyRWcUSRCgPAUxw4siQrctwmqHU5GLxJN2n5ml3EzWd4X8H8h4RRnPy6njZt8ixkOJXAkBf5VWr1s=
X-Gm-Message-State: AOJu0Yzq+tIrO57J6auwd/XG4TYGTG66iuo9Mw46c+df6OiQH6YcQi6+
	LD5kG/CIruIjwWGnlvzarJnD95HEVTg1VGfWM2cZvJ+/hcgO+pNh3vlY1uQ0hUTdSSOtwaBuhAu
	dbgON3Udp/ytw18jWX7TCbVbG4aY=
X-Google-Smtp-Source: AGHT+IFFfg/JrZPkYtkwOZLbKVpyn11ErpaZHgtBuGGv7zwTVNOInIB98snU98XMHtncdjjRq9qFib8e3L29raeRvWE=
X-Received: by 2002:a05:6e02:156d:b0:375:c394:568b with SMTP id
 e9e14a558f8ab-39b7a472925mr11954185ab.21.1723198483575; Fri, 09 Aug 2024
 03:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com> <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
 <CAA+D8AN9JXJr-BZf8aY7d4rB6M60pXS_DG=qv=P6=2r1A18ATA@mail.gmail.com>
 <ffa85004-8d86-4168-b278-afd24d79f9d8@linux.intel.com> <116041ee-7139-4b77-89be-3a68f699c01b@perex.cz>
 <930bb152-860a-4ec5-9ef0-1c96f554f365@linux.intel.com> <c9039808-cd04-452d-9f6c-f91811088456@perex.cz>
 <ed1192e0-00e7-4739-a687-c96dc2d62898@linux.intel.com>
In-Reply-To: <ed1192e0-00e7-4739-a687-c96dc2d62898@linux.intel.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 9 Aug 2024 18:14:32 +0800
Message-ID: <CAA+D8AMOh=G7W5-dYw_=Xx-s0PqEu2suKYorscoWku86Rn-=+A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, 
	tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:25=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >>>> Then there's the issue of parameters, we chose to only add parameter=
s
> >>>> for standard encoders/decoders. Post-processing is highly specific a=
nd
> >>>> the parameter definitions varies from one implementation to another =
-
> >>>> and usually parameters are handled in an opaque way with binary
> >>>> controls. This is best handled with a UUID that needs to be known on=
ly
> >>>> to applications and low-level firmware/hardware, the kernel code sho=
uld
> >>>> not have to be modified for each and every processing and to add new
> >>>> parameters. It just does not scale and it's unmaintainable.
> >>>>
> >>>> At the very least if you really want to use this compress API,
> >>>> extend it
> >>>> to use a non-descript "UUID-defined" type and an opaque set of
> >>>> parameters with this UUID passed in a header.
> >>>
> >>> We don't need to use UUID-defined scheme for simple (A)SRC
> >>> implementation. As I noted, the specific runtime controls may use
> >>> existing ALSA control API.
> >>
> >> "Simple (A)SRC" is an oxymoron. There are multiple ways to define the
> >> performance, and how the drift estimator is handled. There's nothing
> >> simple if you look under the hood. The SOF implementation has for
> >> example those parameters:
> >>
> >> uint32_t source_rate;           /**< Define fixed source rate or */
> >>                 /**< use 0 to indicate need to get */
> >>                 /**< the rate from stream */
> >> uint32_t sink_rate;             /**< Define fixed sink rate or */
> >>                 /**< use 0 to indicate need to get */
> >>                 /**< the rate from stream */
> >> uint32_t asynchronous_mode;     /**< synchronous 0, asynchronous 1 */
> >>                 /**< When 1 the ASRC tracks and */
> >>                 /**< compensates for drift. */
> >> uint32_t operation_mode;        /**< push 0, pull 1, In push mode the =
*/
> >>                 /**< ASRC consumes a defined number */
> >>                 /**< of frames at input, with varying */
> >>                 /**< number of frames at output. */
> >>                 /**< In pull mode the ASRC outputs */
> >>                 /**< a defined number of frames while */
> >>                 /**< number of input frames varies. */
> >>
> >> They are clearly different from what is suggested above with a 'ratio-
> >> mod'.
> >
> > I don't think so. The proposed (A)SRC for compress-accel is just one
> > case for the above configs where the input is known and output is
> > controlled by the requested rate. The I/O mechanism is abstracted enoug=
h
> > in this case and the driver/hardware/firmware must follow it.
>
> ASRC is usually added when the nominal rates are known but the clock
> sources differ and the drift needs to be estimated at run-time and the
> coefficients or interpolation modified dynamically
>
> If the ratio is known exactly and there's no clock drift, then it's a
> different problem where the filter coefficients are constant.
>
> >> Same if you have a 'simple EQ'. there are dozens of ways to implement
> >> the functionality with FIR, IIR or a combination of the two, and
> >> multiple bands.
> >>
> >> The point is that you have to think upfront about a generic way to pas=
s
> >> parameters. We didn't have to do it for encoders/decoders because we
> >> only catered to well-documented standard solutions only. By choosing t=
o
> >> support PCM processing, a new can of worms is now open.
> >>
> >> I repeat: please do not make the mistake of listing all processing wit=
h
> >> an enum and a new structure for parameters every time someone needs a
> >> specific transform in their pipeline. We made that mistake with SOF an=
d
> >> had to backtrack rather quickly. The only way to scale is an identifie=
r
> >> that is NOT included in the kernel code but is known to higher and
> >> lower-levels only.
> >
> > There are two ways - black box (UUID - as you suggested) - or well
> > defined purpose (abstraction). For your example 'simple EQ', the
> > parameters should be the band (frequency range) volume values. It's
> > abstract and the real filters (resp. implementation) used behind may
> > depend on the hardware/driver capabilities.
>
> Indeed there is a possibility that the parameters are high-level, but
> that would require firmware or hardware to be able to generate actual
> coefficients from those parameters. That usually requires some advanced
> math which isn't necessarily obvious to implement with fixed-point hardwa=
re.
>
> > From my view, the really special cases may be handled as black box, but
> > others like (A)SRC should follow some well-defined abstraction IMHO to
> > not force user space to handle all special cases.
>
> I am not against the high-level abstractions, e.g. along the lines of
> what Android defined:
> https://developer.android.com/reference/android/media/audiofx/AudioEffect
>
> That's not sufficient however, we also need to make sure there's an
> ability to provide pre-computed coefficients in an opaque manner for
> processing that doesn't fit in the well-defined cases. In practice there
> are very few 3rd party IP that fits in well-defined cases, everyone has
> secret-sauce parameters and options.

Appreciate the discussion.

Let me explain the reason for the change:

Why I use the metadata ioctl is because the ALSA controls are binding
to the sound card.  What I want is the controls can be bound to
snd_compr_stream, because the ASRC compress sound card can
support multi instances ( the ASRC can support multi conversion in
parallel).   The ALSA controls can't be used for this case,  the only
choice in current compress API is metadata ioctl. And metadata
ioctl can be called many times which can meet the ratio modifier
requirement (ratio may be drift on the fly)

And compress API uses codec as the unit for capability query and
parameter setting,  So I think need to define "SND_AUDIOCODEC_SRC'
and 'struct snd_dec_src',  for the 'snd_dec_src' just defined output
format and output rate, channels definition just reuse the snd_codec.ch_in.

I understand your concern, but there seems no better option.
If you have, please guide me. Thanks.

Best regards
Shengjiu Wang


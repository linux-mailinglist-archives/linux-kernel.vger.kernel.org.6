Return-Path: <linux-kernel+bounces-285764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFF95124F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BA1286B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CEC38385;
	Wed, 14 Aug 2024 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5SIRpUH"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B01381BE;
	Wed, 14 Aug 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602170; cv=none; b=nqQFMxxbResZj61VtvVb6e4LV7osaYBGkZBbu2BAFnY4dEE0C1Afc0HQ2Hy8UFep9cmqoCqa21q3jsYJ0rZs8H+xGX/hlhe8NQp7rOytrpwkhfJDrWCz9HAledzvKaaJv495qAtUSH+BAfbaenzLF2XTot9GKLtMPGX3Yu7GqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602170; c=relaxed/simple;
	bh=oEPhdZKTVMMMYtu4Nx5jQ4/hJEvXTQ1pwlI8w6rCBJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnQNbI+8QL32GqANHEemqXlN8bSwcbsxueHDifKTIZBgfgMQx3RjVjIVOsloVBdqv6Vnk8teAdybgAJXbyUpICz/5wQZtaSbhbwVCMHHUElqPv50TNwmlEXAkPsAl0XiKYSBFCE+MdTW3h4Tg/lfyeEuZCHKcV8aWuk4X8j/3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5SIRpUH; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39b3e127748so26587705ab.0;
        Tue, 13 Aug 2024 19:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723602167; x=1724206967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89JHmaWrb++n3w64WkT++R6JNihPGry7EvRTcS8lWyw=;
        b=J5SIRpUHWJGbTZB7VKHyVrgnitAcGR+Q7eCSQezToo6jhJihPlUFBCi1hHVExtlFMb
         5PSQWcVZwKjOhUFJwQm0qrJMDAssJawYH+QjrS5LZqmlbLiWbKe/QrhdjVKR7gs1h/hO
         OaQKfUbPTgy1xlhQgXHw+8xpjRmGYCsroTWqHnXmn/qgnmoWefBm0naBgXv9nE1I86n7
         LA3apzadqYMCOhEdOJwhtpvqoviW9jmmOodKo+QzZIhtLnGB+q3i18tU4bQ4VAlGH63o
         O4EOdTalI3luEI/e6HgVv9RbxHOyKwF0O+7HuwOSZZpDHuRxWdiajG0oTEcwlQbIFbDa
         kPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723602167; x=1724206967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89JHmaWrb++n3w64WkT++R6JNihPGry7EvRTcS8lWyw=;
        b=sglCqvAyKbWJOwWt4UWGaHKdA+giTbrWEaf2oWY/9dCmmaoVivtP1yxXsd+64JgfKb
         zH0i+EVQylIwiuZxP7hnbMdM+U9l9xNcx11aYevTLci8s7rV8d1MnSlq7XxFmkiiN+3g
         c3/GnhrEno+hWknzUjcRpB8UPJ36k/LFp9dVuqv8+yyM2AtwYvgwFpD2tAICkCF9Pg4p
         lsYzqi3r/nFfqoCJzPGZOe3/ctGmM97QeW7ABeOJL4rZwrIQreCe7j6s1eUXlJc9GbDq
         6LpPUK6IzORqg2W+WFGEbtddjXa4nxsSJ1ut7xZbUjcmk7pf/1goRxNxw9PQw0IbcPAc
         rK9w==
X-Forwarded-Encrypted: i=1; AJvYcCWt4iKNxn8XKwMDFQ+QMcF9ocMYXJZPT+oJozYucit5vh/YFc0xL5/1xfWvO7qkFivV9BqDfHxFSD0dfuG1QBf/SvAIu5Zzx6F9k9izHjzUq9AUCLNmZUa38qJ0On8ce6ORUKK4aQ2i9Fc=
X-Gm-Message-State: AOJu0Yywi0GFMfg/adCb1RX9+X73zLTzVbRr8mZ9G4aRAO5fRhKjdIoQ
	/L63ETE3o9UION8MoHUB/DwyjRqL7417TcAWnN2z3gZW7HCuGsZuipAIwkfYMeBcaBFoEozV7sw
	/qDjj+z38VlgKSulMMUC1n6WfXXM=
X-Google-Smtp-Source: AGHT+IFPVUkZK6h4SS7dzEMo826uVZIEi+fljxMmUw43807CP8vAA2UHQF5gxQfwfaTavdVKDSVhT479wlqQfJ6aRnI=
X-Received: by 2002:a05:6e02:1d9d:b0:397:c5da:dc02 with SMTP id
 e9e14a558f8ab-39d12484a08mr20645625ab.4.1723602167332; Tue, 13 Aug 2024
 19:22:47 -0700 (PDT)
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
 <ed1192e0-00e7-4739-a687-c96dc2d62898@linux.intel.com> <CAA+D8AMOh=G7W5-dYw_=Xx-s0PqEu2suKYorscoWku86Rn-=+A@mail.gmail.com>
 <542d47c5-7ce3-4c17-8c0a-3a2b2a9e6c6a@linux.intel.com> <c3b8f7b8-fc5e-4285-bee8-7edd448a405d@perex.cz>
 <CAA+D8ANg7C7vuxU44mAG8EnmcZjB_te5N_=4M4v_-Q9ZyPZ49g@mail.gmail.com>
 <2be4303e-58e1-4ad7-92cf-f06fa6fa0f08@perex.cz> <7dc039db-ecce-4650-8eb7-96d0cfde09a2@linux.intel.com>
In-Reply-To: <7dc039db-ecce-4650-8eb7-96d0cfde09a2@linux.intel.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 14 Aug 2024 10:22:35 +0800
Message-ID: <CAA+D8AMv=tHV3b-Rfo9Pjqs0bX5SVschD=WD06qxjJOk5zQmiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, 
	tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:44=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 8/12/24 15:31, Jaroslav Kysela wrote:
> > On 12. 08. 24 12:24, Shengjiu Wang wrote:
> >> On Fri, Aug 9, 2024 at 10:01=E2=80=AFPM Jaroslav Kysela <perex@perex.c=
z> wrote:
> >>>
> >>> On 09. 08. 24 14:52, Pierre-Louis Bossart wrote:
> >>>
> >>>>> And metadata
> >>>>> ioctl can be called many times which can meet the ratio modifier
> >>>>> requirement (ratio may be drift on the fly)
> >>>>
> >>>> Interesting, that's yet another way of handling the drift with
> >>>> userspace
> >>>> modifying the ratio dynamically. That's different to what I've seen
> >>>> before.
> >>>
> >>> Note that the "timing" is managed by the user space with this scheme.
> >>>
> >>>>> And compress API uses codec as the unit for capability query and
> >>>>> parameter setting,  So I think need to define "SND_AUDIOCODEC_SRC'
> >>>>> and 'struct snd_dec_src',  for the 'snd_dec_src' just defined outpu=
t
> >>>>> format and output rate, channels definition just reuse the
> >>>>> snd_codec.ch_in.
> >>>>
> >>>> The capability query is an interesting point as well, it's not clear
> >>>> how
> >>>> to expose to userspace what this specific implementation can do, whi=
le
> >>>> at the same time *requiring* userpace to update the ratio dynamicall=
y.
> >>>> For something like this to work, userspace needs to have pre-existin=
g
> >>>> information on how the SRC works.
> >>>
> >>> Yes, it's about abstraction. The user space wants to push data, read
> >>> data back
> >>> converted to the target rate and eventually modify the drift using a
> >>> control
> >>> managing clocks using own way. We can eventually assume, that if this
> >>> control
> >>> does not exist, the drift cannot be controlled. Also, nice thing is
> >>> that the
> >>> control has min and max values (range), so driver can specify the
> >>> drift range,
> >>> too.
> >>>
> >>> And again, look to "PCM Rate Shift 100000" control implementation in
> >>> sound/drivers/aloop.c. It would be nice to have the base offset for t=
he
> >>> shift/drift/pitch value standardized.
> >>
> >> Thanks.
> >>
> >> But the ASRC driver I implemented is different, I just register one so=
und
> >> card, one device/subdevice.  but the ASRC hardware support 4 instances
> >> together, so user can open the card device 4 times to create 4 instanc=
es
> >> then the controls can only bind with compress streams.
> >
> > It's just a reason to add the subdevice code for the compress offload
> > layer like we have in other APIs for overall consistency. I'll try to
> > work on this.
>
> I thought this was supported already? I remember there was a request to
> enable more than one compressed stream for enhanced cross-fade support
> with different formats? That isn't supported with the single-device +
> PARTIAL_DRAIN method.
>
> Vinod?
>
> >> I think I can remove the 'SNDRV_COMPRESS_SRC_RATIO_MOD',
> >
> > Yes.
> >
> >> Only define a private type for driver,  which means only the ASRC driv=
er
> >> and its user application know the type.
> >
> > The control API should be used for this IMHO.
>
> Agree, this would be a 'clean' split where the compress API is used for
> the data parts and the control parts used otherwise to alter the ratio
> or whatever else is needed.
>
> >> For the change in 'include/uapi/sound/compress_params.h",  should I
> >> keep them,  is there any other suggestion for them?
>
> You can add the SRC type but if you use a control for the parameters you
> don't need to add anything for the encoder options, do you?
>

Yes, to go further, I think we can use SND_AUDIOCODEC_PCM, then
the SRC type will be dropped.

But my understanding of the control means the .set_metadata() API, right?
As I said, the output rate, output format, and ratio modifier are applied t=
o
the instances of ASRC,  which is the snd_compr_stream in driver.
so only the .set_metadata() API can be used for these purposes.

Best regards
Shengjiu Wang


Return-Path: <linux-kernel+bounces-282929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB394EABA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81AE1C20DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477916EBFE;
	Mon, 12 Aug 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="addhs0DY"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916F33C7;
	Mon, 12 Aug 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458266; cv=none; b=AfM9p51zo34u1hQFY0NH4nIZ7tpQIVAXjB21Ku7YOIB2bBicw543+xFgoEFOONC5nYmIa6YvnLHgn1JFer95K+MeFoUNlfrAJgRmEkm0vgCjZKMMSi6hsT47rKEsgELfl18evTD3x6VlapT2SXEE3VVGik7a0ktZNNxxEL4AFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458266; c=relaxed/simple;
	bh=53diBSJIt3VJL8ICb+KbhOnHfQVqCPJkKKJXnKOXMfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdfTzOuEi5GvCXUg98qDDJJRiUzB0XyWfX/jfk3JRzkOPBcCyN94zaIPSPe93foWJO3j7VkTKtm2kEUs2u1Lfz3mz0LdhRqUawt8l03zxjfetpCzpBb8TsH6LtttG555vIpCRRj4ypCKpleCbkn8pBAPOpCJS4i7ogYXPvg8BJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=addhs0DY; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39b38295008so12773875ab.2;
        Mon, 12 Aug 2024 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723458263; x=1724063063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPC3vtsqYn5XJUeqo67iJn2rVnzxW9E5GvxuWYZUQ5I=;
        b=addhs0DYABvI6ux0k698eLxtJiUZyZrjMDS2KDQp1q4BVfRJwK89ydinbjf1EwnBAI
         VDwNLhxZWUxUWqLjoEeLIugl4yjuHPqSQjgLu+DpzRPaDYSb/+FRxbpLWml3V7r9pStI
         ABT/j/gG1pv40wWUB2H2IvZX4BY0A6Ds3qOFeLKs4vOB+KVJJ2R2o3zzPTJ1uSGj7nJs
         V0TrCnkRs7QXWKANadDjH2dAZyi3eGfwGmWzevz7Pfu2unggcaWmMRs+l+YXqjoeqPPt
         3JNK/aN1o80cEEMwnTMcM11GOkPpkiuN7YdOLrVJ55TMXHaIb5IJzTQquInDvEO0H/z0
         XlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723458263; x=1724063063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPC3vtsqYn5XJUeqo67iJn2rVnzxW9E5GvxuWYZUQ5I=;
        b=D60z2C1bKynPE3a13ZcVtlNJi/3JPUIp2SrSejJwbnG/3ft10d5duJFiVUru7Ioc4A
         GGSGGvD2kOPGWCqIP9//4PDO02cP2LC7qeGQQOoMv9AWqBRKRecM/cWJr+7L6YT5WCNN
         k78WhwygrU+qESM93P0V1KXG8fY5kACGJGg7n5CY5ZYOSayJR8Itp5PGAYihzCAQwXEf
         X5ROLh8nzQf24cDcpEm1hj+c7kXafoWPKgD33jSgXVE4/XdYaSXcp/OTxCclq5piuOBB
         +3EJyxrqhDxr4T/UYCL39Hiam9uJiYLOHH+mohXEiGG9PVI8J044U0IwiQsMHqLX8NGJ
         Q7mg==
X-Forwarded-Encrypted: i=1; AJvYcCUzCtfPg0lF3TUbUNV7OM+S2ZSzGlXkGmUQEB3+OIqQr9BeJbIuWUq6jqzf048jXIZmxJMu2LBgoOl0RZJJhy77ohHSCAb+RYPEG2S98dWEwXnUUKRA7D3O47LrigpWdwMzX+Oq4D4WJt0=
X-Gm-Message-State: AOJu0YyJAAo6YPnEncJ/tQXjlvwmPe8YZpHgf9XZbcYDlyfvNNB5K3AX
	qJQ53Ar5VwOwIvA4LwnbzC7ILoXgCJIVySlDAirSayyY/mQE9F6xFfGyEAFcDO4/8L7qM5HoKSo
	NMK/IkFcrmgY8RAzFODy768ZlBjQ=
X-Google-Smtp-Source: AGHT+IHdQ3RNrczHyEp+b16RjNhnMCOeSegrx7nTq50uxdHKAwi7ql6H7scu59mGUC+Dyrjh2BuMJ/sg9salc/H/EqI=
X-Received: by 2002:a05:6e02:1a04:b0:397:2dcd:80e5 with SMTP id
 e9e14a558f8ab-39b7a463914mr85661235ab.27.1723458263144; Mon, 12 Aug 2024
 03:24:23 -0700 (PDT)
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
In-Reply-To: <c3b8f7b8-fc5e-4285-bee8-7edd448a405d@perex.cz>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 12 Aug 2024 18:24:11 +0800
Message-ID: <CAA+D8ANg7C7vuxU44mAG8EnmcZjB_te5N_=4M4v_-Q9ZyPZ49g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec support
To: Jaroslav Kysela <perex@perex.cz>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:01=E2=80=AFPM Jaroslav Kysela <perex@perex.cz> wr=
ote:
>
> On 09. 08. 24 14:52, Pierre-Louis Bossart wrote:
>
> >> And metadata
> >> ioctl can be called many times which can meet the ratio modifier
> >> requirement (ratio may be drift on the fly)
> >
> > Interesting, that's yet another way of handling the drift with userspac=
e
> > modifying the ratio dynamically. That's different to what I've seen bef=
ore.
>
> Note that the "timing" is managed by the user space with this scheme.
>
> >> And compress API uses codec as the unit for capability query and
> >> parameter setting,  So I think need to define "SND_AUDIOCODEC_SRC'
> >> and 'struct snd_dec_src',  for the 'snd_dec_src' just defined output
> >> format and output rate, channels definition just reuse the snd_codec.c=
h_in.
> >
> > The capability query is an interesting point as well, it's not clear ho=
w
> > to expose to userspace what this specific implementation can do, while
> > at the same time *requiring* userpace to update the ratio dynamically.
> > For something like this to work, userspace needs to have pre-existing
> > information on how the SRC works.
>
> Yes, it's about abstraction. The user space wants to push data, read data=
 back
> converted to the target rate and eventually modify the drift using a cont=
rol
> managing clocks using own way. We can eventually assume, that if this con=
trol
> does not exist, the drift cannot be controlled. Also, nice thing is that =
the
> control has min and max values (range), so driver can specify the drift r=
ange,
> too.
>
> And again, look to "PCM Rate Shift 100000" control implementation in
> sound/drivers/aloop.c. It would be nice to have the base offset for the
> shift/drift/pitch value standardized.

Thanks.

But the ASRC driver I implemented is different, I just register one sound
card, one device/subdevice.  but the ASRC hardware support 4 instances
together, so user can open the card device 4 times to create 4 instances
then the controls can only bind with compress streams.

I think I can remove the 'SNDRV_COMPRESS_SRC_RATIO_MOD',
Only define a private type for driver,  which means only the ASRC driver
and its user application know the type.

For the change in 'include/uapi/sound/compress_params.h",  should I
keep them,  is there any other suggestion for them?

Best regards
Shengjiu Wang

>
>                                         Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>


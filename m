Return-Path: <linux-kernel+bounces-433963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8E9E5F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD5E164486
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B91BC07E;
	Thu,  5 Dec 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw0N8LZP"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4041B4132;
	Thu,  5 Dec 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430875; cv=none; b=LhRp0UWBhiqbCCQGHF3mVlB7NqWBSbUqICXn+BqAfOpGVwb3m3EHpL5c0iC2yK/kFV+PotL8ZCxgfL+dXt/BC5gefQJW6am8FQsPQ0sEpbRLPZ9IsvibD8XMLa+XKl4HlufdfM1ZoFRu5uwfB6tAWxac+RvlEuuo0HJvqDfzRZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430875; c=relaxed/simple;
	bh=qHmdxDkDuOc3mCnHUk3VmogjHhN5fR6jfhnpuGwZLxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgVnCW/kBahlsgUhNSlHYAPlF4qXG197lAuKJYyqyXFZAbwVKiLL9uX5QpIGe6nuWeF6AqD6whcjPICuPZmMPF+JoAIDHJkmlfartjSr9dYBaWQh6Juw7uMFXbNXbKuO7kANNpE6TqpD3pi4hMHb770/tIQPGkLvEN6jyTTVCEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw0N8LZP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3001e7d41c5so11611121fa.2;
        Thu, 05 Dec 2024 12:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733430872; x=1734035672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zNLU7JiIVNYN6uzDSL8W4rwX388F4bKFTYcYLsJhf4=;
        b=cw0N8LZPWS+HTES/oaLZc2MBoHLoSZ+eTuN2/H3Te6UnUm0xDPFkTPYkPnbVQCWLA2
         dSVcm8Ml2Ov7kuygXdnd7ljFmEpTDuxjzmIkjan7vwwiqGZMiKjmyIGfNra0U/T5lq0J
         xbkHH6sP2l+4I1V6eBep5SF+8cQzdUCg5Ml7v8xfl9O+vaD0TCQRl1sZGZ9aUC6lH8Qx
         NJ5svO8+Ddh/bNaAVR/ZrAvTn0ANptkjyI2ztxI+k46KV3TVD50Y2+D2Hsu60XFU4EQM
         JgGonrXuQdZ150xpxSbusoRLNNMWqFJi9O9fYtG5f9W5fkAGtgEU9V3TZL+Od2v2RdQF
         cQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733430872; x=1734035672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zNLU7JiIVNYN6uzDSL8W4rwX388F4bKFTYcYLsJhf4=;
        b=kFx6AY5BA13pe/44fmSsZBTzycf0K1VU3RE7A2AlRiWA/ANxOUd1HcVgBdUwGUJgUN
         Xsjw0cEkopHa9krm/UHf0+MeUDV4t0GSchgLrgK3yLs4YvBzurgW7zUFzScpThX7P2Ii
         v0VGRUm1wfyZr0cszw7HvXghsK1HNltUkbVQky3Ks9W5EtO+SHbKUh7XAyDHrOfep1m8
         EDmuUafwwd3LRWNARE8TiaXZn/S/YSCQkHk+I3GXzvn5Hpvgb1VsM4ZHipDiOpTHyWVi
         gVWxQ+1iJGBufbj6NZJIbNjlNh5FN71OrpyJSAf1/VwnRAEvc4Jni/vjO5E90psKmHWE
         7rsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMKhKd68go7G6ZSsnBsXcjxMFYK8jT8I2t9B93sF5eGk++zG3x6Rf6RCwK0E/L7e8Sk2JT3Xk9R++vZN0S@vger.kernel.org, AJvYcCVevX06tmd6k7ZuFpqPjf8hifDkRljVPANRXqO9JpsyBofYQZESXzKELzBu+g9mcQpvTigTLbTjzSy/xVA=@vger.kernel.org, AJvYcCWkZwlVhgIF1ZyQFRMwvCHFOL6eQuxqS3z5+wXu7S3PcBcjwpqlqfqLrPd6XgKCXf71De/V6bVzKKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPehbU0JLGBw7I9WEKVXcVUEY6t0HpXQ6FhMHbxjMopxtiHyIa
	zbTU4PbJyrqPBVGwDq3SzKtilIKMD+vR4heArGpvS+KmIY8B+gHlQuZBhPmd8RSXMsL1ynxe83b
	y6eONDkGB6r6Q9vN7NyHSIRRSqB0=
X-Gm-Gg: ASbGnctWrc+gkI2y3aCbT3rGByrkmYKJUBjPgiP7ihP0BQzT1lp5oWekkNzcd4BxuBv
	0i6A3zpWybr4+vOZDnu6fF2vT4uDFIi0=
X-Google-Smtp-Source: AGHT+IE6KBGSHgRCf57RQld1orRjeJgN8cXYps+CS26t9iRFvJmDHrVCNJ9GOp16QayIrIHwJvkzqjUHOY5ZvGOxeHA=
X-Received: by 2002:a2e:a5cb:0:b0:300:24f9:5a25 with SMTP id
 38308e7fff4ca-3002f933d0bmr957061fa.19.1733430871904; Thu, 05 Dec 2024
 12:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031211411.58726-1-yesanishhere@gmail.com>
 <ZyQ5OJM8k1rGog2R@archie.me> <CABCoZhCapQBCj=UJ78XWtzier5m34zX+bwSo4bPxEVkOdZSxRA@mail.gmail.com>
 <ZzKnMLe-L7bOe9Tw@archie.me> <CABCoZhC5w-uUgmsqb_m2t98NF5oftuoDTThvthoRK8m97bM+MA@mail.gmail.com>
In-Reply-To: <CABCoZhC5w-uUgmsqb_m2t98NF5oftuoDTThvthoRK8m97bM+MA@mail.gmail.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 5 Dec 2024 12:34:20 -0800
Message-ID: <CABCoZhCfdJWG-Apvm32sRzHrYh3YDT03SAONeNCiwXm_gtVqrw@mail.gmail.com>
Subject: Re: [PATCH V4] Docs/sound: Update codec-to-codec documentation
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-doc@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Charles,

Wondering if the latest version works for you?

On Mon, Nov 11, 2024 at 5:17=E2=80=AFPM anish kumar <yesanishhere@gmail.com=
> wrote:
>
> On Mon, Nov 11, 2024 at 4:54=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > On Sun, Nov 10, 2024 at 01:30:12PM -0800, anish kumar wrote:
> > > On Thu, Oct 31, 2024 at 7:13=E2=80=AFPM Bagas Sanjaya <bagasdotme@gma=
il.com> wrote:
> > > >
> > > > On Thu, Oct 31, 2024 at 02:14:11PM -0700, anish kumar wrote:
> > > > > Updated documentation to provide more details
> > > > > for codec-to-codec connection especially around
> > > > > the scenarios and DAPM core details for C2C
> > > > > creation.
> > > > "Describe in more detail codec-to-codec connection, especially on
> > > > use cases and DAPM core details for C2C creation."
> > >
> > > Sorry, I like the way it is written.
> >
> > What do you mean?
> >
> > > > > +An ALSA-based audio system typically involves playback and captu=
re
> > > > > +functionality, where users may require audio file playback throu=
gh
> > > > > +speakers or recording from microphones. However, certain systems
> > > > > +necessitate audio data routing directly between components, such=
 as FM
> > > > > +radio to speakers, without CPU involvement. For such scenarios, =
ASoC(
> > > > > +ALSA system on chip) provides a mechanism known as codec-to-code=
c (C2C)
> > > > "For such scenarios, ASoC (ALSA system on chip) ..."
> > > > > +connections, leveraging the Dynamic Audio Power Management (DAPM=
)
> > > > > +framework to facilitate direct data transfers between codecs.
> > > > > <snipped>...
> > > > > +To better understand the configuration inspired by the setup fou=
nd in
> > > > > +``sound/soc/samsung/speyside.c``, here are several key points:
> > > > > +
> > > > > +1. The presence of ``c2c_params`` informs the DAPM core that the=
 DAI link
> > > > > +   represents a C2C connection.
> > > > > +
> > > > > +2. ``c2c_params`` can be an array, and ``num_c2c_params`` define=
s the size
> > > > > +   of this array.
> > > > > +
> > > > > +3. If ``num_c2c_params`` is 1:
> > > > > +
> > > > > +   - The C2C DAI is configured with the provided ``snd_soc_pcm_s=
tream``
> > > > > +     parameters.
> > > > > +
> > > > > +4. If ``num_c2c_params`` is greater than 1:
> > > > > +
> > > > > +   - A kcontrol is created, allowing the user to select the inde=
x of the
> > > > > +     ``c2c_params`` array to be used.
> > > >
> > > > I guess #3 and #4 can be combined, i.e. "If ``num_c2c_params`` is 1=
, ...;
> > > > otherwise if ``num_c2c_params`` is greater than 1, ...".
> > >
> > > I like it this way.
> >
> > Sorry again but what do you mean? Keep it as-is?
>
> Yes it is more developer friendly.
> >
> > Confused...
> >
> > --
> > An old man doll... just what I always wanted! - Clara


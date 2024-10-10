Return-Path: <linux-kernel+bounces-359699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8C998F37
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9378A1C215D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED919D078;
	Thu, 10 Oct 2024 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="U6gpFk+m"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4D19D898
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583332; cv=none; b=KFi7Wf+LVuV8l9DvhV8jStZc3v8LIK/55+GEqW+jTmEMqZUJf0XO5NeAWE5QhFUh6mrG97wfk6PtqR8LLhpW3MFJPNgUhQvfG9EOB6lZOY0JUwMFCnvrqLFwb/Wox8JH9w+6+/Oa/tsZe7zht3KpHo9l01adoGuyvr0LAuHyUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583332; c=relaxed/simple;
	bh=74uNZwP9yPkuwSjOQnzZHxaG6HAtQJ20wqo37W7tTv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAql4CoQcA0X31gansUxcsXjZRCo4tUb8NTyT7RVFciGOTet1HoPwEZp3g9jLzGEStcajgpoixSIWGY6bV1c4g9HnKbIvWCxKzS13fwpi78Pv+WtXmRZN/flsw0Jep0heH1DJ4JnyF+AFOwhem1TA0ptaWK5pwFXmmzhTx0var8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=U6gpFk+m; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99415adecaso64662666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728583329; x=1729188129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjsDzstTYFGDD7Ix+X5kO1Gib1XyR99VIvH0hkAEl4Q=;
        b=U6gpFk+mLDa9BXBR+jckOSgSnkzJApvHeMYOyijwXBvNB5G66LqRdw8kTDAYtTgBtV
         +mdSl/O0NpMcCtWhDKzTdUymFucI+NHCn/UoKiDhHq9KXUVXI4/XlzA3QMUFR4t4HFqn
         ecL3aCQOM+dfIht9+XH/gAX+qlj6C39Ev+YpzP6+7jWThGPNW8yiiAJxzKKdrSUs1VCr
         zew7oDzVHMGnXp2X8BZlSfKNC44NiOel0YJd7bbgIvP/1geIg3XhOKIJURUhw3YwWjVZ
         aohoEnn4u6NcakLp3KlT+Ijb5w8bUfH1D6DrCTgJWV0aYhFsfHh37oYbPG3zFvxLoW2N
         90Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583329; x=1729188129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjsDzstTYFGDD7Ix+X5kO1Gib1XyR99VIvH0hkAEl4Q=;
        b=QSzbLxqaMxyDW+v8snPVkLhne785YSP8GLLdkPEeLSCJeo0+f6uMgLXAzNy3dwjwDp
         E/OR/he+oDrrekXUrqZICNN9/NhQpJOTVRUgWp5LgOuTRkMw2rOekOhl8Hm0Qta6NcFN
         AtwwRv72opaWpAPjSCCR+nFbPBTEz0cymmjhZvoRH0Tj8TlVrmfYU/FVboTfzbIJsBr0
         SKII50nG95hw8Q9vM2ie4k3Bul3flbtz5qik0EFF0UUxhTB9iy4sjgRg5oMLvpy00VFf
         40jiw3ScjTP6YueOKmIdIqV+7olN4Oafy2wIF/l2Bkr16VIagDkfUhrWN6IA0eg7qa2k
         gIOg==
X-Forwarded-Encrypted: i=1; AJvYcCWP60kcyjlS8mByV7FgO2v3xRn62mYPyKShnnPbZwcblNOfLpYABv+yk4hSZUUv0BTHBGn9FWF+hnuRbgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQeXW8DXIcns+qvjYx1zU+HlrumEr58c3q3ARGPKHTtIIYBJp
	d4Ko2fiaSMXowr2DOE5+Vvfx+d7vBX/MZN+KKyBvaUH61wUEcTE/5AJJP3/lFxKAPd3tZZAXu42
	7A1+/tZD0/6TR8XBHBqyOL9/k0wiBszGVV8h1Xg==
X-Google-Smtp-Source: AGHT+IEPdggCCFNvXE/idTLBBpLlat+htfqfEsx6mlEFEupC0RZgBZSnvkfye6OVd7fobOMWdhcYoRrgtuG6RGsrNwQ=
X-Received: by 2002:a17:907:6d24:b0:a99:5b1f:99b3 with SMTP id
 a640c23a62f3a-a99a13b0f2amr381112966b.24.1728583329160; Thu, 10 Oct 2024
 11:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008234422.5274-1-everestkc@everestkc.com.np> <e44527e8-b7c6-4712-97a6-d54f02ad2dc9@linuxfoundation.org>
In-Reply-To: <e44527e8-b7c6-4712-97a6-d54f02ad2dc9@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Thu, 10 Oct 2024 12:01:57 -0600
Message-ID: <CAEO-vhF0C2voBfQNOPYqTUhrH8tFNtE3dPV6aaODrVS17Znxog@mail.gmail.com>
Subject: Re: [PATCH-next V2] ASoC: rt721-sdca: Clean logically deadcode in rt721-sdca.c
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 9:08=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/8/24 17:44, Everest K.C. wrote:
> > As the same condition was checked in inner and outer if
> > statements. The code never reaches the inner else statement.
> >
> > This issue was reported by Coverity Scan with CID =3D 1600271.
> >
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> > V1 -> V2: - Updated the patch prefix to PATCH-next
> >         - Added how the issue was discovered
> >
> >   sound/soc/codecs/rt721-sdca.c | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdc=
a.c
> > index 36056cb7a3ca..4fd26e490610 100644
> > --- a/sound/soc/codecs/rt721-sdca.c
> > +++ b/sound/soc/codecs/rt721-sdca.c
> > @@ -611,13 +611,9 @@ static int rt721_sdca_dmic_set_gain_get(struct snd=
_kcontrol *kcontrol,
> >
> >               if (!adc_vol_flag) /* boost gain */
> >                       ctl =3D regvalue / boost_step;
> > -             else { /* ADC gain */
> > -                     if (adc_vol_flag)
> > -                             ctl =3D p->max - (((vol_max - regvalue) &=
 0xffff) / interval_offset);
> > -                     else
> > -                             ctl =3D p->max - (((0 - regvalue) & 0xfff=
f) / interval_offset);
> > -             }
> > -
> > +             else /* ADC gain */
> > +                     ctl =3D p->max - (((vol_max - regvalue) & 0xffff)=
 / interval_offset);
> > +
> >               ucontrol->value.integer.value[i] =3D ctl;
> >       }
> >
>
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> As mentioned in my review for v1 of this patch, the exact same problem
> exists in sound/soc/codecs/rt722-sdca.c as well, in case you want to send
> patch to fix that one.
I just sent the patch for it as well. Thank you for pointing it out.
> thanks,
> -- Shuah
Thanks,
Everest K.C.


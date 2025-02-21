Return-Path: <linux-kernel+bounces-525150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D51A3EB89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA09A3B58C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856E1F9F70;
	Fri, 21 Feb 2025 03:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jv0O6I6w"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41AB1F4262
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740110147; cv=none; b=ipIf3ZjwGJTjKLCJ99RZEksjUTtNOiETcd+Dj0PskDRQMWSDqpcvGZoPC/yUHarHd54vvAaLbit/O50BifjbYoVDBDC2FnrriGHaUNJaUM8UUbLsiNFMNuggj3dDGQczNYYv9cPJubkea03sAxYHlCK5db94MtugjxNi/vvi2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740110147; c=relaxed/simple;
	bh=iG5MA668VIkZx6yw4F2E1Ql8r5D0wiJ2sdzgkM+jrnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+4mEGeFgFz6rYjc5+9FhWZFJcXQQF84cJAd5VGVYxCKlA9YiO7jwl6wU6sbVOmx7yBFnWBh+BnAFm9sBKWZiYIXyfSB3RKJZa2abVGD+LBdSy2vrtIn3R4LnHBxxH36laaKKVbGEq3s5prsSUG8efuirfvEt3TNmMdAeMWATwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jv0O6I6w; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso257606266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740110144; x=1740714944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fw0vw5qDfG2Y5RQUA0J555gJarSraMWbJS4+ci/UW8k=;
        b=jv0O6I6wv0+jO8HD56/QFcWOgD7HIMCWdR8DpFM4W7HM6DgeEKIi8p1ZsjNJTAUQyH
         wCHe7TwoimRY0GRk6weHX4nwolsEdi4ghSqx7VKGLQg6TIbDu8l7zgxMnbqTpkYAPxmd
         D83FKZZFvu7DwbQLbM5cNvgK/TBczCu2/Kl+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740110144; x=1740714944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw0vw5qDfG2Y5RQUA0J555gJarSraMWbJS4+ci/UW8k=;
        b=g1MSZJ87IipCcLZqpehIIRugv357jRyRCiRdEiN3VmB/Nya8Y0cMR+CRSU6TzfsW4N
         PEeB/ssE1bewJxUvChPiZLkZ/AhXIHVGky7QHHMN+bdT9VZBRVAZCMA53E7sibeR0MxH
         lxs5u5bSj8xdPGTl8S8QSkN+rPx7/72l1t0RpwZ8FG3+PMoh2Zols6udKvt2RUCE5VMV
         4Yc/c0BIF2/yJTlw9qVTBmcxgm14n2cIhw7LhicmOZzIK6UMzEAuakkZsXLG6mOTgBKS
         3jEQldf2ESVpV7eCyXuEtH4InDW7d82rM4Y6NP//Y1whqIUkcbFHV54eZ3esv2XsHrIx
         RoMw==
X-Forwarded-Encrypted: i=1; AJvYcCVFkoF5E7f5jE/OwUTMw1GHYdiK+JRyEFmoLqu8oI/pYgAkleNaXyZCiSeUK8FmiXOCaxko/cx7M5EyMx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkHgBYaaOxNxvDXlThVuG6cd+CsCXGZM/zIrbB4lxhXu3+Ahv
	aGzaowag1BoV/bs4qoYI8BiTKLg3SDRCHyHuxpv5aMy7v4zTFmEC4ThOJPkrJS6wM12FqJdRD5w
	=
X-Gm-Gg: ASbGncsfRs8jBNma98CPJl+VrDEy3/NirL0bybKesv8yO2m/jRHvHDs2X9yF2gf6zmK
	K0notySBo/7+NoxNPkCY9wasXC35RAwP+6af36P7M07fwu3lPxatHKFlbKxd+3gDDgTr3Okkdo+
	YQwiQLekFTtS5IqYlMui04Lq8/rGjk1uEr66n01mQKDxNNTi0o57aypENjOtuluWYzfyNKjoNtD
	k9xtrNbS8cW7PvI2WdE3j0fnwLpDF2pauKK+egBDlkyGHcSSkEaSud6rJhGUdOvu0HFKfC7FvKh
	Pa2NqpTRtKVOJ+Dr5wpbIUs/68hdZ+bX4w9rsQcFBlut4ihVHgDU8yR2el5R6Q==
X-Google-Smtp-Source: AGHT+IFH+rzaVCeB6sbAGgU+8zBMAxBh3WcjSmPBsVCejXSTHeTj1pxXoOH+ztlGx48EFIU+p4ZhZg==
X-Received: by 2002:a17:907:970c:b0:abb:eec3:394c with SMTP id a640c23a62f3a-abc0d97e77amr107301066b.5.1740110143582;
        Thu, 20 Feb 2025 19:55:43 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5a4f4cb4sm1491257266b.118.2025.02.20.19.55.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 19:55:41 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e08001cff4so3518a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:55:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJTevlyy/cxk27cNdey2b5wswznC42xMJWcZUa6OiKvB7r7P+/5rc/UeiQ7QXtViVhnhQZq2GI33pWkNU=@vger.kernel.org
X-Received: by 2002:aa7:d5cb:0:b0:5e0:815d:4e0a with SMTP id
 4fb4d7f45d1cf-5e0b871d417mr35634a12.5.1740110140496; Thu, 20 Feb 2025
 19:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-venus_oob_2-v4-0-522da0b68b22@quicinc.com>
 <20250207-venus_oob_2-v4-4-522da0b68b22@quicinc.com> <e794c047-ab0e-4589-a1d2-0f73b813eacc@xs4all.nl>
 <b1721d46-ffbf-e21c-ce18-e96e3e8ee35f@quicinc.com>
In-Reply-To: <b1721d46-ffbf-e21c-ce18-e96e3e8ee35f@quicinc.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 21 Feb 2025 12:55:23 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ABR8BwG_9JVPzzp+HZv6O=B9r-ipjKQHku7DdTGASetQ@mail.gmail.com>
X-Gm-Features: AWEUYZmeIjhMEJHyZ3B3-kUW6g12qVNZHewpqyjHWwiKCgJTNAXvvTwbb0Hd1Ik
Message-ID: <CAAFQd5ABR8BwG_9JVPzzp+HZv6O=B9r-ipjKQHku7DdTGASetQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] media: venus: hfi: add a check to handle OOB in
 sfr region
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hans.verkuil@cisco.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 12:56=E2=80=AFAM Vikash Garodia
<quic_vgarodia@quicinc.com> wrote:
>
>
> On 2/20/2025 8:53 PM, Hans Verkuil wrote:
> > On 2/7/25 09:24, Vikash Garodia wrote:
> >> sfr->buf_size is in shared memory and can be modified by malicious use=
r.
> >> OOB write is possible when the size is made higher than actual sfr dat=
a
> >> buffer. Cap the size to allocated size for such cases.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
> >> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> >> ---
> >>  drivers/media/platform/qcom/venus/hfi_venus.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/m=
edia/platform/qcom/venus/hfi_venus.c
> >> index 6b615270c5dae470c6fad408c9b5bc037883e56e..c3113420d266e61fcab446=
88580288d7408b50f4 100644
> >> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> >> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> >> @@ -1041,18 +1041,23 @@ static void venus_sfr_print(struct venus_hfi_d=
evice *hdev)
> >>  {
> >>      struct device *dev =3D hdev->core->dev;
> >>      struct hfi_sfr *sfr =3D hdev->sfr.kva;
> >> +    u32 size;
> >>      void *p;
> >>
> >>      if (!sfr)
> >>              return;
> >>
> >> -    p =3D memchr(sfr->data, '\0', sfr->buf_size);
> >> +    size =3D sfr->buf_size;
> >
> > If this is ever 0...
> >
> >> +    if (size > ALIGNED_SFR_SIZE)
> >> +            size =3D ALIGNED_SFR_SIZE;
> >> +
> >> +    p =3D memchr(sfr->data, '\0', size);
> >>      /*
> >>       * SFR isn't guaranteed to be NULL terminated since SYS_ERROR ind=
icates
> >>       * that Venus is in the process of crashing.
> >>       */
> >>      if (!p)
> >> -            sfr->data[sfr->buf_size - 1] =3D '\0';
> >> +            sfr->data[size - 1] =3D '\0';
> >
> > ...then this will overwrite memory. It probably can't be 0, but a check=
 or perhaps
> > just a comment might be good. It looks a bit scary.
> Thats correct, it would not be 0 as its a prefixed one [1]. I can put up =
a
> comment here.

Couldn't a bug (or vulnerability) in the firmware actually still cause
it to write 0 there?

>
> [1]
> https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/media/platform/=
qcom/venus/hfi_venus.c#L836
> >
> > Regards,
> >
> >       Hans
> >
> >>
> >>      dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
> >>  }
> >>
> Regards,
> Vikash


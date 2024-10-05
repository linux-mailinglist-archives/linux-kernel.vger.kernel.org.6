Return-Path: <linux-kernel+bounces-351705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B6999150A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7214C1C21B91
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52866F305;
	Sat,  5 Oct 2024 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3kdLA8S"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A772F2A
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728111967; cv=none; b=Nvfe19zjsAaW3OhvhIAnvuAtC0RVeSHxV3TwW6iDAfRcgZlYySLalW1fMcbizwQ0vlB0EwkKUCe4brPfsvKC3kV1mEoiqSOQzlrQ64uXkKKW0kXo7IXpadAgsDbKg+eV032HrUGz/aXYpze5UJGAprNZr1nzcAyQ1T7Gg59PHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728111967; c=relaxed/simple;
	bh=TbBPJxNYC7c7r3/uFly3QFfMP4cPVP/OcDyvphfAfdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNxA2fcKg8pCQi0Ecz1tTmLrkHgZ1sbZFmd2N+74rUSfyghC4mjDZrbVcZPhGXPvWkw8SW+dIRoDpNdbojAug1FpvcWeSzMkNM6lMZczbkGOxhoD3kSXAseooiNKhuaCdcNAwYF46tciHPUFbpchW/6r/7CzjIJ2epMicr1YFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3kdLA8S; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539973829e7so2841743e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728111963; x=1728716763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYVrMrQSJwfYKCjPdcCYgt+chvzT8Uf5ftZ8FQgUQlc=;
        b=N3kdLA8SNoSq/D1bMxeWjsTBIVasurVYTwG5MuiVtoAIusooPJ6659xIVivWa9aprn
         0E4mJVKfQJ+mIia7I1S/durzmlgXGQJlwJSoT4y6EZRU+wwbqXnUOoWZ/FdeMXVVtE0Z
         YmEIlE1ccYvPqtrG2BR1HPngJJJXBM8+4iw0pXRng7V8ikBkZXxTeiqxYaoFhmlWfspb
         CpRRdu8pFmUi8/MKAjylLVxNgeZTQg0tj0qg13mB9WanPh1MVYwlGDy6RzAcLUBPptrO
         IyEqtMvR0AJwI0IFRbB71tIbD/hAuKTEKNoiSAW8G1I6K6+GkHTIHaWl6La8j76xem8Y
         Zi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728111963; x=1728716763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYVrMrQSJwfYKCjPdcCYgt+chvzT8Uf5ftZ8FQgUQlc=;
        b=lfsZlLmH7uGPcsPkSW0E+g6I1BGpgs+hqcjEBsgoHpOi5ebBMsm7LW8ZVVOTz+DTy2
         RtnETdxcPuCBQnlBTpH6E0kCrW1BFJYcircBywvLYPucl61RAl4gK2xf093S8+oODr3Q
         F/X2wYYSGR/Z9plACcYFkupunIdu31F4zwwtfTQ0JXuaqN0hTfoIu3NfLeofiJBisw6p
         6SgsIx9ea8GzfNz3wJhQdV2cgkYo4bldjOSWdoOAJ/izUpJT6DwlPi7x1fWAGIn6Brjw
         mdAt/kOBR6XMhbKmWjR5SzAAAtqVc2EBVGcYDGlrgdX6k/zZAHc9riZXzJhfzmILNRN2
         MgMw==
X-Forwarded-Encrypted: i=1; AJvYcCWhGouLTfnj2hGWcKECvxAVHee6DemI7o+tAw+68tKuKBv1X7NrZQuCrG3rwUiwk6nd/2zD5qdmCGBs0us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzFI5RnCOsXzlBLbhd2PnAWtHpfanQq4m03/bZc707rMZ7GLdD
	52dclKAItHSdd5ZCxJf+5UQVbGZqlxGR8p7ycoMc1gV+akRh3Aybuh+4u6sBCCUi+4kCeZzptqe
	1k/U71/xcOBao02ceFWbcp8XaSSqPCDD2sko=
X-Google-Smtp-Source: AGHT+IF/SPb5q9d7Mi42mGpfn9y/A5HUxHESegg0s2/uE/R/lfVJVIWc3Bz0N41WkD4BgjxASggZkzFCnV8S5bjvk8g=
X-Received: by 2002:a05:6512:1090:b0:539:896e:46c9 with SMTP id
 2adb3069b0e04-539ab9e4b44mr3143607e87.45.1728111963147; Sat, 05 Oct 2024
 00:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004081618.27599-1-advaitdhamorikar@gmail.com>
 <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com> <CADnq5_OKww1YZ1R_OytEMLcNVwdq=-ckc2gqQ+WMyOv6AZ9kqg@mail.gmail.com>
 <007679b9-b7b6-4385-9a2e-2be392cb5f58@amd.com>
In-Reply-To: <007679b9-b7b6-4385-9a2e-2be392cb5f58@amd.com>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Sat, 5 Oct 2024 12:35:51 +0530
Message-ID: <CAJ7bepLv3Z9RwuxoBS3SfkMjeBkN1LRTjLEjT8Lv4Jdu-CXb6Q@mail.gmail.com>
Subject: Re: [PATCH-next] Fix unintentional integer overflow
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, leo.liu@amd.com, sathishkumar.sundararaju@amd.com, 
	saleemkhan.jamadar@amd.com, Veerabadhran.Gopalakrishnan@amd.com, 
	sonny.jiang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com, 
	"Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sathish,

> Please collate the changes together with Lijo's suggestion as well,
> "1ULL <<" instead of typecast, there are 3 occurrences of the error in
> f0b19b84d391.

I could only observe two instances of this error in f0b19b84d391 at:
'mask =3D (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1=
;`
and `mask |=3D 1 << ((i * adev->jpeg.num_jpeg_rings) + j);`

There are a few instances where we can use 1U instead of int as
harvest_config uses unsigned int
(adev->jpeg.harvest_config & (1 << i)
However I think they should be fixed in a separate patch?

Thanks and regards,
Advait

On Sat, 5 Oct 2024 at 09:05, Sundararaju, Sathishkumar <sasundar@amd.com> w=
rote:
>
>
>
> On 10/4/2024 11:30 PM, Alex Deucher wrote:
> > On Fri, Oct 4, 2024 at 5:15=E2=80=AFAM Sundararaju, Sathishkumar
> > <sasundar@amd.com> wrote:
> >>
> >> All occurrences of this error fix should have been together in a singl=
e patch both in _get and _set callbacks corresponding to f0b19b84d391, plea=
se avoid separate patch for each occurrence.
> >>
> >> Sorry Alex, I missed to note this yesterday.
> > I've dropped the patch.  Please pick it up once it's fixed up appropria=
tely.
> Thanks Alex.
>
> Hi Advait,
> Please collate the changes together with Lijo's suggestion as well,
> "1ULL <<" instead of typecast, there are 3 occurrences of the error in
> f0b19b84d391.
>
> Regards,
> Sathish
> >
> > Thanks,
> >
> > Alex
> >
> >>
> >> Regards,
> >> Sathish
> >>
> >>
> >> On 10/4/2024 1:46 PM, Advait Dhamorikar wrote:
> >>
> >> Fix shift-count-overflow when creating mask.
> >> The expression's value may not be what the
> >> programmer intended, because the expression is
> >> evaluated using a narrower integer type.
> >>
> >> Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
> >> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_jpeg.c
> >> index 95e2796919fc..7df402c45f40 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> >> @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void=
 *data, u64 *val)
> >>    for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> >>    ring =3D &adev->jpeg.inst[i].ring_dec[j];
> >>    if (ring->sched.ready)
> >> - mask |=3D 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
> >> + mask |=3D (u64)1 << ((i * adev->jpeg.num_jpeg_rings) + j);
> >>    }
> >>    }
> >>    *val =3D mask;
>


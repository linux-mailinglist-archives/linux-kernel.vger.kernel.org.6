Return-Path: <linux-kernel+bounces-334528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB797D85B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2661C23140
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707B1BF37;
	Fri, 20 Sep 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUAAjSLS"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0962566
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849875; cv=none; b=qd96NVtDSMbKziiRzYfbNUHDv3BAhSUf0mfVyu/b3irT1uzC15nQnuP28BbsoV3l17KW0YtU94dfNfrloT2NlC56Rs8+CpySdGVbS+kYeIApFbi+I8PfhAUI8fIdLtQ0/Sy4CCpz1ett4M9Il4xRKbJSbK4d8w3iy91mdyfRw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849875; c=relaxed/simple;
	bh=TyP++zDgXZYtc1xE2scoPkGOcbpTXvIn5yunvMviT1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElpJVPUwaMJSDsanlClJJfGFkJmKpe/hBblnp5HFLItOfFAjPSODyDswq1AEB8JjwkXlRm1dyuI8bH/TTMvYWqBDR5us3ZtMiORWpT9gcx75LYgvmJZrVLcmd09M5mqHtQhl3/A9wyvvBgcbnzRexhST9qR4LscjWhL4dF8SBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUAAjSLS; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-710d2cf2955so1362749a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726849873; x=1727454673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kFNgjU2lRuthexlytRySW/QoHblcc+yb5R2qeY2kiQ=;
        b=EUAAjSLSoRzq0q0HFr/sK1zOdtfcCEUhR94P8gZ4cQsPddlZ0YB+RRqk3BJZYDwo28
         SRLRwRjlv2bDSVQm2uY3igdUL23wwq3MMypPptEJod/FA/oPc0y3qDFuzovpK117m3W2
         x0qzqBbajFplmOHGoH5HKOaRL20u8RQJbJvLsI/9lQUdVmRo6jbjFc6ccfQ+8xFxd+ne
         6+JlRDw05G1wpkrHhY3JSC78pAohn4qWBt4uF1ZWVELWyDSa/iaQEm5v3U8L0P7G/B6s
         DTRTDEKODXc7dvkHruxJf/PjBCneaUTVdFspGG1/mUzri1J/B69NwlsT4A2MK6TnfRVG
         Ijvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726849873; x=1727454673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kFNgjU2lRuthexlytRySW/QoHblcc+yb5R2qeY2kiQ=;
        b=lzzgfS+rSc6gMAMsrywH8xECvPZpzngZc7i5LfUFWkivv9Lk1SrXQHgburhF3m2Dwb
         rdEkXIMu6czy6vomR+08THUBGD3QTcl+LZy3IiTeV8mUjBVO8Va8lsSB0Wqnc9Ks+mO9
         08oyBY5w4j4uQEWY1sPPGIFU1uuIeCqtOGt1JfjzzKixrld459AMChSSrmFt3qQ2q4U9
         ugptbOmPcxer6sWXOhRl04sR/UQR3dPHa2raD3C77mrT+FpnJSHNvQkILNYfV4OIEZK4
         blskC7bMGs3sgvXVtn32m/EHBc+WhtWxxs66/AK6a+K562poAVVFuYxDTICxQcd5CDTD
         hDyg==
X-Forwarded-Encrypted: i=1; AJvYcCVneDgxfkOIdS1vzBurqjPpl9FnU2IJMthSHw+wePWqtrep4yCoGY3mVGOD+ufPZn7EdpRf7lluR7CrZzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XDYTE5RC2hM2IEHJ1ovpbURk1JXxtKU0PR0tXQFXKl0yCrS5
	BQmoQ7Wx4Vc3KAsXIepwiH6zLHyNT1gw3KH8lDYphO+Mmx2+iYAd2+KGkfr8y/USHlKGm0kZj1u
	s0eTAKT2aCVhmhsaslDxMFxpHm+I=
X-Google-Smtp-Source: AGHT+IG6kSExes68WvrmTD2Klk+8Mr4krZ64XIuYYOLEOyvVWgd+wL1Sl4mG/cbKjJ2o12LP4IyHlsUuR8XI/I/z6Eg=
X-Received: by 2002:a05:6830:25d6:b0:710:fa02:94b0 with SMTP id
 46e09a7af769-713933e16a2mr1944810a34.0.1726849872894; Fri, 20 Sep 2024
 09:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920090959.30755-1-kdipendra88@gmail.com> <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
In-Reply-To: <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Fri, 20 Sep 2024 22:16:01 +0545
Message-ID: <CAEKBCKMg0c5AW7YggDMR+Kg7OGq3dXApLK-=RTR71H0KHO73+g@mail.gmail.com>
Subject: Re: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer
 deference in amdkfd_fence_get_timeline_name
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Sept 2024 at 16:01, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 20.09.24 um 11:09 schrieb Dipendra Khadka:
> > '''
> > drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null poi=
nter dereference: fence [nullPointer]
> >   return fence->timeline_name;
> >          ^
> > '''
> >
> > The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
> > or f->ops !=3D &amdkfd_fence_ops.Hence, check has been added .
> > If fence is null , then null is returned.
>
> Well NAK, completely nonsense. Calling the function with a NULL fence is
> illegal.

Thanks for enlightening me .

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> > index 1ef758ac5076..2313babcc944 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> > @@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name(s=
truct dma_fence *f)
> >   {
> >       struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);
> >
> > +     if (!fence)
> > +             return NULL;
> > +
> >       return fence->timeline_name;
> >   }
> >
>

Regards,
Dipendra Khadka


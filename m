Return-Path: <linux-kernel+bounces-548539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F8CA5463C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A4C18958CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92320967B;
	Thu,  6 Mar 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0jRplbF"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291719CCFC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253154; cv=none; b=m9AzMZfWEXIgAKWRi/lAtPbqHjcfVpdfL9u+AD7fv36X2M3Hw1PvH5rJ4Yb2f9LFltisr3SbyVavYAMy2zMaaJ1Uz0so3EdhNWc8LhguAuRmX4ewkQbK4BEvjyPEu14vmpf8sO1AN1zv3yOm7qxQk/7ut80rCzhgcdtVzqtChSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253154; c=relaxed/simple;
	bh=G9gyjsCHGbIHu8gdDnvmvC617ahQlBt3bluHdEuwtwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBcOJkbi2U0nzxBlOaOw1ZFK2s5F3EjyLSed5cpmkBwXlfHoeWc3pI3kY2VbNOJFfD9yZFCPzhQ51DGNRxiW5OfZG+EVbeeZTySB9XrAgUNTIcWIOytolxx2QWOmnNe8ktdNGwvWXVjfUzQEmOV5/7/LpXOT8m2uHZGFDASOaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0jRplbF; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f67f825468so149657b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741253152; x=1741857952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAXYiA/MHOAdQMXh+C0jw5Ofxnxlrhaorm6TX8gdw8c=;
        b=J0jRplbFL7RSfSXb/v8sFuq2IPjX3aa082CcdZw0350y3zAIuoq5XkiFemwsvXfGEW
         ysA3GeXcq0qUm3Ynhn0vV7ECKhHyzPeR3BdZ/BcLYOepifmrPnQ36Ms6iup6pfT/a31B
         IUx42aSxbwGeR8WpVs/ViS5wz50IGCxXr7JwCZCRnWIMKG1lO0t+k6WhIxYZgQG40bLe
         ME8E36twUaE8B06GnY/2g3kr8wLsQfxCeH4gvQwVVoYTsCfjidHbTFs8Usb3KJfNHt4M
         HVq2eEWJZCOmFEycFWObfrKwn9XVU9sM1NLMYaEQ/OO0GhFZdgky0Y7RQfHewrd/Gyex
         ZccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253152; x=1741857952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAXYiA/MHOAdQMXh+C0jw5Ofxnxlrhaorm6TX8gdw8c=;
        b=SJiSz66MgENqO3Nw1LO5ONsCt3a1hmRaprPxcNV/adKim1o3ISglByqmue2Eomgn+9
         k2IZSzTSa4TC8mQON7dHLN4qrySFjHPSYbsXlQQRN2ElsQkiZA9Fx4MCQ5Bgpl0r8biG
         n9EtSKmMDrhg5LCicKKap6lbc+kjheXc6vxpWU9v3MPikH6OMySpJ7B3CByeWkTL+5vd
         AratdqPIlSpcuR8/12GXHKmisuUG4Y4eAjJ1KdF8vAPh9afInpzlwXDdc/Dy675K81cB
         E8yGXoDh4lG5ogaGXZ6TPqMysEjktP8gCePkHirG+VFnyyqaTwlqeg3UYbChxQwEoZV+
         KJYA==
X-Forwarded-Encrypted: i=1; AJvYcCU+kFN0jArnbd5Wwu8D6fikdpRIfdoxpAwAifdPm7q+BkpAyo0KGQQcUsA5/7k+lNANYpIh8f7ELGsCVZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAekGSo0AMysLVXgeiQ9ec4FkpGqbnEWE4WdZDOkU/KmrhROr
	r4xrOxfz6eD3ufCCLTeIQMczMNTdKGbgXSvmdJDBiWJ5MMoEMPdnOf6iaAJ+gaYhjhQ5z+pCWru
	DGBuoTXYqNHmzTmyxwADDy0Xd11k=
X-Gm-Gg: ASbGncslMkCezVNeo26fMDhPBR336Bq1Zg32Pkdgjhierdvp9LcoqOAl/xQmC0aCJli
	J18qs3cyvZ/NTgIBmLpsNlsp8NysRX5Wg5anQHEDZNOwbP8VXZ0xJAi+asVfEaAIZu052RG4UF8
	nFzdZPeEuwaN35uHqq1bYSXdPU
X-Google-Smtp-Source: AGHT+IE+MrhlxDA97sRbtzv0SinGLTbWQPhTRvM4OzDVVIZo23dvkiNaf+0XUCosZsqKFyerKq91Qoa7XWsl1LHUYfk=
X-Received: by 2002:a05:6808:f12:b0:3f3:ff78:e5e4 with SMTP id
 5614622812f47-3f6831f210dmr3120103b6e.38.1741253152337; Thu, 06 Mar 2025
 01:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201011434.453879-1-linux@treblig.org>
In-Reply-To: <20250201011434.453879-1-linux@treblig.org>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Thu, 6 Mar 2025 10:25:41 +0100
X-Gm-Features: AQ5f1Jrlft8qiL2kDUOEuJjZM9OIv8RXYZ3aWpqOMf8V_TmACTpv9Oxf_0_ImSQ
Message-ID: <CAMeQTsa8enkergRai6ixmE-ivTQgWazoTJ9stMWSgzobexphJw@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Remove unused mrst_helper_funcs
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 2:14=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The mrst_helper_funcs const was added in 2013 by
> commit ac6113ebb70d ("drm/gma500/mrst: Add SDVO clock calculation")
> and commented as 'Not used yet'.
>
> It's not been used since, so remove it.

You talk about mrst_helper_funcs but the patch removes
mrst_clock_funcs. I assume this is not intentional.

-Patrik

>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/gma500/oaktrail_crtc.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma=
500/oaktrail_crtc.c
> index de8ccfe9890f..ea9b41af0867 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -658,10 +658,3 @@ const struct drm_crtc_helper_funcs oaktrail_helper_f=
uncs =3D {
>         .prepare =3D gma_crtc_prepare,
>         .commit =3D gma_crtc_commit,
>  };
> -
> -/* Not used yet */
> -const struct gma_clock_funcs mrst_clock_funcs =3D {
> -       .clock =3D mrst_lvds_clock,
> -       .limit =3D mrst_limit,
> -       .pll_is_valid =3D gma_pll_is_valid,
> -};
> --
> 2.48.1
>


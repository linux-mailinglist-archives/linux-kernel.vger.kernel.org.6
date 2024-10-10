Return-Path: <linux-kernel+bounces-358333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81389997D49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE171F24D42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF471A3BDE;
	Thu, 10 Oct 2024 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="YWW+H6xU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFD3D6B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542070; cv=none; b=ee3KgkyTY1vcX6wYi/5c09X7PxLMOBMfR9j6uI0RzqoWMpqmrwvHFgRTG+c+crCVe3uMoY9jzTuCoTMQXjqUlZq8axVThlcLKWvCnfKFYuL5V4JxTvbPf7H8HW8HvtxKlsBeTesvxgENnuTTBleyRBRkWINn056N4nAqczkfjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542070; c=relaxed/simple;
	bh=n/KuTEfj55Z44mJgo3UkAHO6y9JAvXHdzzaiDTWIq0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7qiU3Ejd/fAKkpNpQMzct+44AkOyt45RukD/kEqMeCYytpjdMb1nq7DjPAUKhL4WYyYBQHxwlhvpBhuNZynIKScgMY/amjN8HCVw/FfigwtRsgyUUBRSis5mGX26k2chLZG8qI7VzFesPdiW5l+sp3j6eYIS9I/yEXzHAoV0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=YWW+H6xU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c924667851so628796a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1728542065; x=1729146865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNbQgNGz4ln13V+1AJHezmBRqD3GeJjDxhy0+sxFIyA=;
        b=YWW+H6xUZVgJuaP9y7bkdIGhDV7SxJpwLLbMcg3tT8br5MPhijqwPSJDAIkm8yFMTM
         zy64lgeAJ5K2uKAePT3Dplmo6Pc/rUDRnKn7tz7M1O/ke1xim1zbfMQSLIEt0jlqumoc
         xqlNDqEYlWtwmGdCvxIl7Tz3972Wk94o5eYh3i1hWukPNm12+QItFAT75Xny76TwU4dk
         Wv29Plk41SAHQ6uWBwxtPUa7x1Zp74c54HYXerVezZvyxXv+zVgrKBUlalXMwPwmRSnv
         ANCzXxNMK8H9mB4ETTVrfq9geH3ypZgxFOJRquPk/jSVF78QS26iqrvWMiogt8m+lZD1
         PUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728542065; x=1729146865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNbQgNGz4ln13V+1AJHezmBRqD3GeJjDxhy0+sxFIyA=;
        b=uumPmHtFwhdiCu1XXn2C0tv4lX8xzOQilwcKfjTD8JCPglLoka6kJQHlmuSg08ajOw
         2I4UH4/905BgaxT0eUPPRTGANAS4Lc66hABfjbc330l7ALXxKJD3S3r3X59sJuDqKCGa
         e4s08WqVxjXpkGdMA1YOEi+saY9MjuMrTNaH8b+wRfh3Im3J3nlilXFu7ApNqw8fAqFN
         PXGAmNhgJusd1XBJcWwrLn3gAlPkthYR4AWKydtpxagLihH/e8BE1LJ00UKv87Taiavf
         ZA/3jH3c/RnAeUlfhzbAgL/KG5yFxMCDCxGjUYd8EKHaEh8MTc2SpgsWvl+BSjGGZkQw
         u4fw==
X-Forwarded-Encrypted: i=1; AJvYcCWYB+bC5bfIQUOYCu1QKIQ5kPfucaxbi4Zfd9YWuruecUXnFKASfwrWJruCeBox3AwgNFuDuw9mVwTkMjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzeyz5On73ej1tKTTVcmnGO4sR/omlQm/YIRydonRhPOYKvZfy
	bJjO9iHV8AIbicZZRM7xrDJEGTGJqxmF6nn9RXIG84v8GeZsgP6fuF9Yes39KUeYy5FYwNICdHy
	b/1nfG7o44KZ8BmGDALd3yf8Ww8XTHA67bOyOAl3EU9yWNlZg3/GE9kTV
X-Google-Smtp-Source: AGHT+IEFirfdNC1tkJJSNx+yCF2buHjstu4V7B995CFeHueDWDw1iSohi1NTD6YhOveJe2g1G3rj+p3QJlhlIWL6tk0=
X-Received: by 2002:a17:907:6d11:b0:a99:4136:895f with SMTP id
 a640c23a62f3a-a999e8cd43bmr218826866b.41.1728542064655; Wed, 09 Oct 2024
 23:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009213922.37962-1-everestkc@everestkc.com.np> <c2a9c4ad-ce50-42ab-8dac-65914e188cac@stanley.mountain>
In-Reply-To: <c2a9c4ad-ce50-42ab-8dac-65914e188cac@stanley.mountain>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Thu, 10 Oct 2024 00:34:13 -0600
Message-ID: <CAEO-vhG01xvKvJ_e5Rbkn6WRQho8gauLBQw9Wd_VQj2Lyw8fyg@mail.gmail.com>
Subject: Re: [PATCH V2] drm/xe/guc: Fix dereference before Null check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	skhan@linuxfoundation.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:28=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Wed, Oct 09, 2024 at 03:39:20PM -0600, Everest K.C. wrote:
> > The pointer list->list is derefrenced before the Null check.
> > Fix this by moving the Null check outside the for loop, so that
> > the check is performed before the derefrencing.
> >
>
> Please, mention the effect on runtime if it's not totally obvious.  In th=
is case,
> someone reading the commit message would think that it leads to a NULL
> dereference but actually the pointer can't be NULL as I explained so ther=
e is
> no effect on run time.  Say something like:
> "The list->list pointer cannot be NULL so this has no effect on runtime. =
 It's
> just a correctness issue."
>
> Change Null to NULL so people don't think it's Java.  ;)  Also dereferenc=
ing
> has a typo.  s/derefrencing/dereferencing/.
>
>
> > This issue was reported by Coverity Scan.
> > https://scan7.scan.coverity.com/#/project-view/51525/11354
> > ?selectedIssue=3D1600335
>
> Don't line break URLs like this.  Just go over the 72-74 character limit.
>
> >
> > Fixes: a18c696fa5cb ("drm/xe/guc: Fix dereference before Null check")
> >
>
> Remove the blank line after Fixes.
>
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
>
> Otherwise, it looks good.
Will incorporate your feedback and will send a V3.
Thank you for taking time to review it.
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> regards,
> dan carpenter
>
Thanks,
Everest K.C.


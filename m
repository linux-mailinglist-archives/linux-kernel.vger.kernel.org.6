Return-Path: <linux-kernel+bounces-262599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB4793C935
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9393A1F21831
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52336BFCA;
	Thu, 25 Jul 2024 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvpoBXu6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507B1CD32
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937297; cv=none; b=ew8ZzABN2IWhdWHRX7aSi7rGHr+n8b/M1Gf/a5j8XmpC67msSgnSnamtw24yNrwEumlTHHbz/40lh1BL6LTH8rqtBtqIuy12Uv/3Mu42vyjz13CysdBfoNdfZ2loXHX0b/xDEI7kq4VdbNfn4/wtZAT1QBYFA9UTU2lbiF7WFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937297; c=relaxed/simple;
	bh=i22y9vddhr0t0nQH4v8iBs3EFXZyHGLI4XhcmFo1aO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwLC26L+RC+pdr2cpNzw19GSxgGUQIQRGvwK9vK0872sNHyB6jzAeIw0sH0/YJlDoLjcyzeP62sO6ccobjBjH596FNYpgmJbbC+y6wwey0Q8G2XZjDjwB1tol1wA1uYGoCU7qewkarQrFzmhpNUw5tgqmTQLqSj3eH4zLVRoIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvpoBXu6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc60c3ead4so10571345ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721937294; x=1722542094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ2/3q/bfgdLQ2SKF+xPcpuZtJ5O3OCCf8lNzI6xqq0=;
        b=IvpoBXu6fPh8AXjoWWRJlwYgH5eoshPmpFe5DwlzoPrEFpTN9rpfhbzP378/CkclUS
         pu7yyeTZ1aYth0FC3lMz0dEy+rFnXLTFQCHQJBwjtMRPW9LZf7DYq7RWcZgFvXXDnRnJ
         juoGUtHpvWU34uMwPbYGEnOy3VVvMBFWH5Q8ur2Onmeg4+xvZzLgSJhsMHkmMzX6lXe0
         mHb00brblgmz6wPrQBauZq7pYViPVJEX8LyS3QkL3YbQ8DyK7TWoczWHvqelJy9MxVrl
         PuEPY23vt67SmYiWXiIHyWzN+8bTBz0TT0i8mREfUMj7Bia7Nc3w7K3GCewq8LAspe0Y
         k28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937294; x=1722542094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJ2/3q/bfgdLQ2SKF+xPcpuZtJ5O3OCCf8lNzI6xqq0=;
        b=j1t0LYdFNd4f6gXInPXXGh7RLvK0Ayegn0LP+QA0UbBja+a3c0Ndm5R5MQwyKfPGEO
         7xAg/9BzW2objYuaRN6j7SQvfChL+KZiByby6pEktcw+ZvJ2HHg8IHJIYU+7y9sF7mAl
         OUU6bX3yY52118OWVa73jpbrbGq1T6DNSsmhwA5sWMQuJFNevDfYT1ycl3c8IkNL1X5d
         TuHaWw03ncxRKlyoDKmhL/sEM1roxMUbnqF46dQiI85/0JpjEdmClbMCJqOVkkmbzbM1
         /RivSY0jRkxr4LLIzQn+H0h20XPXNv+dTpKOriIFUVBauB2wMCMxeKi903+a4UPXav7M
         PSzw==
X-Forwarded-Encrypted: i=1; AJvYcCXyhpepfqyQK1fv7MYzZIocD+qJ6YDy2MS7ODDgXtjSWymrrs2BTfUbOIIbPuRtPyyxfZ0bXkm3ib6X9V0HAvEmF0e/wvbKVMcuEi9G
X-Gm-Message-State: AOJu0YyOamloW3duv4nlex8eF01r2isIv/sy9pS6UfcfoljjoB0jpISu
	iw14XeynbEYeq4hwmplmGfMVUjf1V8XYYqMxGS3Xoq7rCFW/Gdg4vKCCzlV0cuivwawQ85vtiKu
	XyCJY6AvG766nhYvmHwWEGa/gLb4=
X-Google-Smtp-Source: AGHT+IGlHXz1aSbMBuuCXDUVMJbNQOTZlhgtwLY66bzlvs53OORi8u2Ewst7irO4S9i2tcQNqCkaFe1Pdt6xXP0DHFA=
X-Received: by 2002:a17:902:c945:b0:1fc:4bdc:d413 with SMTP id
 d9443c01a7336-1fed3af1d80mr43778135ad.60.1721937294112; Thu, 25 Jul 2024
 12:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724175423.18075-1-abhishektamboli9@gmail.com> <qyoun6sfdpdxxzwystaimsiw3o33jwvoqxm3kpawczju2b3dl5@ytjpgyabbzet>
In-Reply-To: <qyoun6sfdpdxxzwystaimsiw3o33jwvoqxm3kpawczju2b3dl5@ytjpgyabbzet>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 15:54:42 -0400
Message-ID: <CADnq5_MHtyUENJGk=f+i-3ODJpGiZc1QFpQuvAh=uaFc9x9-9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix documentation warning for mpc.h
To: "Ricardo B. Marliere" <rbmarliere@gmail.com>
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>, airlied@gmail.com, daniel@ffwll.ch, 
	harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	marcelomspessoto@gmail.com, aurabindo.pillai@amd.com, adnelson@amd.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is already fixed in:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/6e169c7e0f842c48c7bf683=
fb789dbf5a8b1dfd8

Alex

On Wed, Jul 24, 2024 at 3:55=E2=80=AFPM Ricardo B. Marliere
<rbmarliere@gmail.com> wrote:
>
> On 24 Jul 24 23:24, Abhishek Tamboli wrote:
> > Fix documentation compile warning by adding description
> > for program_3dlut_size function.
> >
> > Remove the following warning:
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1043: warning: Function p=
arameter or struct member 'program_3dlut_size' not described in 'mpc_funcs'
> >
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/=
drm/amd/display/dc/inc/hw/mpc.h
> > index 40a9b3471208..615c69d966e7 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > @@ -1039,7 +1039,21 @@ struct mpc_funcs {
> >       */
> >       void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID i=
d, const enum MCM_LUT_XABLE xable,
> >                       bool lut_bank_a, int mpcc_id);
> > -     void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int=
 mpcc_id);
> > +     /**
> > +      * @program_3dlut_size:
> > +      *
> > +      * Program 3D LUT size.
> > +      *
> > +      * Parameters:
> > +      * - [in/out] mpc - MPC context.
> > +      * - [in] is_17x17x17 - Boolean Flag.
> > +      * - [in] mpcc_id - MPCC physical instance.
> > +      *
> > +      * Return:
> > +      *
> > +      * void
> > +      */
>
> Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>
>
>
> > +      void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, in=
t mpcc_id);
> >  };
> >
> >  #endif
> > --
> > 2.34.1
> >


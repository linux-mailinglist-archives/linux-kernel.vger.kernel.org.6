Return-Path: <linux-kernel+bounces-257528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F5937B68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62F11F2249D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3891465A0;
	Fri, 19 Jul 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KXK+ztqd"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CD146596
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408381; cv=none; b=vBewlA72/MTL4LDtGh8/6klDOksHi/YDY1md29jQVml1zJonzCCSGF6uoYxpLHD3D8eC9cDIvUJ+3QqTgcWZ70wE4ObksI1amiv+6FvoSGKxDfyfZ3NWU6q7PyzAu5OI6XJTuT5bo+gc0IyAoO1M3ZNGkx9fnaNKwtFOpuYHwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408381; c=relaxed/simple;
	bh=mNij9BWdWuGcrQHVif28kluwUpobJruqp79+yQUhfZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeSptcNS4t7aaWBN2fBwBdvuLtJOwF0p+7OpQA3Jahv5O8MF+bgL/shOXsTng9GY7laSqsKkkaT/SlhRZ1Rz7BmLwGT1j6ln9zbVddcJZI7p9f9/jfC96cI4xcbY4GrbWJmMVoTtapRTZ1r+oKd2TdqHLTKp11mPJZ1kQjEu4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KXK+ztqd; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so12735616d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721408376; x=1722013176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNij9BWdWuGcrQHVif28kluwUpobJruqp79+yQUhfZQ=;
        b=KXK+ztqd4Du8/ViacPB+1qRMFXYf7vBo5dfrPpMZBmihaIxpEr3ZimKXqAiwkOHi/y
         /O3LpiarmRSshRW6kPPZz6qyJiaQa2GJH6mIp1NtnWgDIEkPSZ36GipfIOHkdLZxnYpJ
         lQeycPusH79YMavJJcyrThKHJtAvqhl3vWJU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721408376; x=1722013176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNij9BWdWuGcrQHVif28kluwUpobJruqp79+yQUhfZQ=;
        b=mLs1WSdMOzYLQR5tpNrPYeqLODFiVYsgjjiQiJCoRqxIKGhYa6TMn/kO4hAhteO0YV
         0WRKXCsTVGbvAQD03s7H1IIHl87aCONkFCUwzAbFkjS0L9KTDk5LFbYuzNsmDbcCGgGT
         4SFMX+uI/4R5Zz9dGeiFexnHhu30qUO05cKr4Uw9I+yGjHGkOIfomf3ks50cQZIjIKuD
         egbuANvwM1Gm3oZosqKwePxxBn+sAiKelkXjG/sM1ytoyVVE1PMZXHzjjFsKtCZfo+9n
         QN3/zEq5uQS1k/m6SsUjRi3EBT6Siw+0QPzVjAlbqaV161/lP0i/rmHw58OQEid9QQ9w
         uNFA==
X-Forwarded-Encrypted: i=1; AJvYcCWjhsaqFclsZDzqfr2U9Qbansb6cptoraiMasHTIt61WOet3wpouMAR02NqIH6l0tf5+opgFoJwjV5EfJbvVWMh0Sje3ya0vzgFbuxe
X-Gm-Message-State: AOJu0YzZtckNmwzzKb7738ZlY8+n5AVB+gkuhgGTonzWOQh0jpwAqkef
	aEduWpKsy0WgHUr/+rKJ+TUsSiyn1eastwZRD/1LO2BQQeJwF7KhoIJV8qkl0MrUhET5iT1aGZA
	=
X-Google-Smtp-Source: AGHT+IG0SgyuWwpOMTm3fbZOKJn2aH2wjsgPuuEYAnn8UbyYqKq0tTciruRLELcLlRvIt+p8iwgbiA==
X-Received: by 2002:a05:6214:488:b0:6b5:a8b9:e8ab with SMTP id 6a1803df08f44-6b78e2d5199mr104820866d6.49.1721408376385;
        Fri, 19 Jul 2024 09:59:36 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac9cbf7esm9501616d6.78.2024.07.19.09.59.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 09:59:35 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447f8aa87bfso423041cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:59:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcTtA/j+gg0PUkXYryX3ll92MpCT8DdGINyyjQSvYv67tyuiEHAXm/WiZwrWgMjFxxpnUDnYgn+VwzZjtop9bY62M2bP7FUzfTITj7
X-Received: by 2002:a05:622a:4c8c:b0:444:ccc5:f4c0 with SMTP id
 d75a77b69052e-44f9c8061a9mr3439471cf.15.1721408374666; Fri, 19 Jul 2024
 09:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716133117.483514-1-tejasvipin76@gmail.com>
 <p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzcpv2qh@vssvpfci3lwn>
 <a05b4e6e-272a-43be-8202-2b81049a41a4@gmail.com> <CAA8EJpoRd3ooMnH8Z38yNH0M-L_CUd+H4WoYydd2AEmpXGeU8Q@mail.gmail.com>
In-Reply-To: <CAA8EJpoRd3ooMnH8Z38yNH0M-L_CUd+H4WoYydd2AEmpXGeU8Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 19 Jul 2024 09:59:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDpEfTjTQbO-fZKKwgHCMUmCrb+FBr=3DMzVfs3on9XQ@mail.gmail.com>
Message-ID: <CAD=FV=XDpEfTjTQbO-fZKKwgHCMUmCrb+FBr=3DMzVfs3on9XQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi-dsi: Introduce macros to create mipi_dsi_*_multi functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 17, 2024 at 3:07=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > > However it might be better to go other way arround.
> > > Do we want for all the drivers to migrate to _multi()-kind of API? If
> > > so, what about renaming the multi and non-multi functions accordingly
> > > and making the old API a wrapper around the multi() function?
> > >
> >
> > I think this would be good. For the wrapper to make a multi() function
> > non-multi, what do you think about a macro that would just pass a
> > default dsi_ctx to the multi() func and return on error? In this case
> > it would also be good to let the code fill inline instead of generating
> > a whole new function imo.
> >
> > So in this scenario all the mipi dsi functions would be multi functions=
,
> > and a function could be called non-multi like MACRO_NAME(func) at the
> > call site.
>
> Sounds good to me. I'd suggest to wait for a day or two for further
> feedback / comments from other developers.

I don't totally hate the idea of going full-multi and just having
macros to wrap anyone who hasn't converted, but I'd be curious how
much driver bloat this will cause for drivers that aren't converted.
Would the compiler do a good job optimizing here? Maybe we don't care
if we just want everyone to switch over? If nothing else, it might
make sense to at least keep both versions for the very generic
functions (mipi_dsi_generic_write_multi and
mipi_dsi_dcs_write_buffer_multi)

...oh, but wait. We probably have the non-multi versions wrap the
_multi ones. One of the things about the _multi functions is that they
are also "chatty" and print errors. They're designed for the use case
of a pile of init code where any error is fatal and needs to be
printed. I suspect that somewhere along the way someone will want to
be able to call these functions and not have them print errors...

Maybe going with Dmitry's suggested syntax is the best option here?
Depending on how others feel, we could potentially even get rid of the
special error message and just stringify the function name for the
error message?

-Doug


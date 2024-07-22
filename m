Return-Path: <linux-kernel+bounces-259226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F79392E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CDD1C217C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD116F0F9;
	Mon, 22 Jul 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lfcle7Sh"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4316EC11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667573; cv=none; b=eTAjdKM/LVmqkhqyGnneoBfVWhjcsS77ZIkYksJjmqraqzm6aQCPMj/9Bljn50wiuVuwWgP+5ogSBXWszZ4f4wspZfZxOVEunEReVG7pt1/rsIa9/i6VaOqxCiANp21+Y45FGkQO7yT9D8ref5LR9BbDCFbbEu/LhZjZd3kwJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667573; c=relaxed/simple;
	bh=6Z5Ir7rhiBPr3RRCCNoLO7VsrsAMZfPkRGLwL8wNXLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvD93n5RjBdNcvzj+ko4TvENwAmTJxT2Gnu9PS5XLz96ZeYQtwd6JS792dd7fqunr6dXU8I+j6+ylo818Jcf7oOgmSkOK/D/6wj9PS1Z6br7I3qLP/ulSj14JmpFl57dLoXCQY7ozK7Ciip8cIiPIX0H+I9qtamVv1kxAxKv9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lfcle7Sh; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49299323d71so563360137.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721667568; x=1722272368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z5Ir7rhiBPr3RRCCNoLO7VsrsAMZfPkRGLwL8wNXLI=;
        b=lfcle7ShmRhCpUR6bgEyknYCnRDZCk/PQeLcPXhUCGoKnBSILVVZ9A8GeHYFc1k4k6
         Hv3/HCaFIoOJ9fLrXVxyLsQf9+hQfrk1VNe5OyIc6PguvfMhPjSlelbOJx4HdriD7A8x
         PogyGMTSfR8zpbMSqi8brfpVgEnrwUzeL2Bdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721667568; x=1722272368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z5Ir7rhiBPr3RRCCNoLO7VsrsAMZfPkRGLwL8wNXLI=;
        b=INkXbK4K77VPItYViCg25MShFdnzLFDDgWEJhIneMmhwwQ1kMnhcoi58CqBiNmn1+I
         1ZfeXSM1XjpGi+/tUYZcWZB5DvQ8ZOoRP/T+AbgBEsp4DcfEd2K02pPI1N4D6qzhk0v8
         ZfOU3RRyGXN97YkAKDr+9cOeuMyVfMhFqUQXUoI39KGBgDFSLoEOuWHGG/74KB38b9SM
         vsVLGgAmPj9cIGM5KR22lniN6X7pxX0oyqkVrqU60YhbO6g2vkbdxFtjN1MAuWXB1x2M
         2P5Jw7RymKjKcjhQVxe1kavuuW/mOXFLOynweSuo92Yy4ZgHzL9ViIgDltEQXeYI/v8H
         1C+g==
X-Forwarded-Encrypted: i=1; AJvYcCWn6oVbcCXrRrRXOfbq5S0upqU8hRcMFM+DRmp4WUMAdVqipLJb/1LuFyQshVWkeA8VqdbifAhutBI8Nh3ZZGn8tPX8lmBfQRo0z6Z5
X-Gm-Message-State: AOJu0Yzf1vMpFe3IOnPgQ4+TKg0sdYWgSK+cxX8deEbhZYIwvlbYjSdD
	hfeLTGrTnzMU66D2Tj7SsfteBONcPDFJV+wn4dTQy1f6aSGowbuiHS1gFxBaTkQQa6Xj3ABw8ag
	=
X-Google-Smtp-Source: AGHT+IHd8uZMVVqVrXXett/XDIhJDIVkHiubbr1GOJhM2Wo5/0aZ2chtQMxmbnYo2VkoQB2+Zf0hzw==
X-Received: by 2002:a05:6102:33c3:b0:48f:ebb7:3919 with SMTP id ada2fe7eead31-493b06d6f6fmr644943137.7.1721667568591;
        Mon, 22 Jul 2024 09:59:28 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbda21sm376445585a.36.2024.07.22.09.59.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 09:59:27 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44e534a1fbeso768041cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:59:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEVI1Zz0U6cnxvE8mpUl5cLd6izofTV9M7RAUVVOXTfsi1KvWxZVH+gLP5x9FsYI9o4Lcat8ivxUqQ53Ed9gZVMnAhMweNeU31h32r
X-Received: by 2002:ac8:5e4e:0:b0:447:d81a:9320 with SMTP id
 d75a77b69052e-44fa7da9b77mr4941551cf.20.1721667567117; Mon, 22 Jul 2024
 09:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716133117.483514-1-tejasvipin76@gmail.com>
 <p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzcpv2qh@vssvpfci3lwn>
 <a05b4e6e-272a-43be-8202-2b81049a41a4@gmail.com> <CAA8EJpoRd3ooMnH8Z38yNH0M-L_CUd+H4WoYydd2AEmpXGeU8Q@mail.gmail.com>
 <CAD=FV=XDpEfTjTQbO-fZKKwgHCMUmCrb+FBr=3DMzVfs3on9XQ@mail.gmail.com> <758b3f44-5c8f-46b5-8f02-103601eae278@gmail.com>
In-Reply-To: <758b3f44-5c8f-46b5-8f02-103601eae278@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2024 09:58:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WiRfyteOKwhDm6-bP1yrRWqggDqqPr5=Exw6x9zzPYFg@mail.gmail.com>
Message-ID: <CAD=FV=WiRfyteOKwhDm6-bP1yrRWqggDqqPr5=Exw6x9zzPYFg@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi-dsi: Introduce macros to create mipi_dsi_*_multi functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 19, 2024 at 10:19=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> On 7/19/24 10:29 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Jul 17, 2024 at 3:07=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >>>> However it might be better to go other way arround.
> >>>> Do we want for all the drivers to migrate to _multi()-kind of API? I=
f
> >>>> so, what about renaming the multi and non-multi functions accordingl=
y
> >>>> and making the old API a wrapper around the multi() function?
> >>>>
> >>>
> >>> I think this would be good. For the wrapper to make a multi() functio=
n
> >>> non-multi, what do you think about a macro that would just pass a
> >>> default dsi_ctx to the multi() func and return on error? In this case
> >>> it would also be good to let the code fill inline instead of generati=
ng
> >>> a whole new function imo.
> >>>
> >>> So in this scenario all the mipi dsi functions would be multi functio=
ns,
> >>> and a function could be called non-multi like MACRO_NAME(func) at the
> >>> call site.
> >>
> >> Sounds good to me. I'd suggest to wait for a day or two for further
> >> feedback / comments from other developers.
> >
> > I don't totally hate the idea of going full-multi and just having
> > macros to wrap anyone who hasn't converted, but I'd be curious how
> > much driver bloat this will cause for drivers that aren't converted.
> > Would the compiler do a good job optimizing here? Maybe we don't care
> > if we just want everyone to switch over? If nothing else, it might
> > make sense to at least keep both versions for the very generic
> > functions (mipi_dsi_generic_write_multi and
> > mipi_dsi_dcs_write_buffer_multi)
> >
> > ...oh, but wait. We probably have the non-multi versions wrap the
> > _multi ones. One of the things about the _multi functions is that they
> > are also "chatty" and print errors. They're designed for the use case
> > of a pile of init code where any error is fatal and needs to be
> > printed. I suspect that somewhere along the way someone will want to
> > be able to call these functions and not have them print errors...
> >
>
> I think what would be interesting is if we had "chatty" member as a
> part of mipi_dsi_multi_context as a check for if dev_err should run.
> That way, we could make any function not chatty. If we did this, is
> there any reason for a driver to not switch over to using the multi
> functions?

I'd be OK with that. My preference would be that "chatty" would be the
zero-initialized value just to make that slightly more efficient and
preserve existing behavior. So I guess the member would be something
like "quiet" and when 0 (false) it wouldn't be quiet.


> > Maybe going with Dmitry's suggested syntax is the best option here?
> > Depending on how others feel, we could potentially even get rid of the
> > special error message and just stringify the function name for the
> > error message?
> >
> The problem with any macro solution that defines new multi functions is
> that it creates a lot of bloat. Defining the function through macros
> might be smaller than defining them manually, but there are still twice
> as many function declarations as there would be if we went all multi.
> The generated code is still just as big as if we manually defined
> everything. I think a macro that defines functions should be more of a
> last resort if we don't have any other options.

Ah, somehow I was thinking that Dmitry's solution was conflated with
switching back to a macro. I haven't prototyped it, but I thought
Dmitry's primary complaint was that the syntax for declaring the
"_multi" function was a bit dodgy and I'd expect that using a macro
would solve that.

In any case, I'm good with keeping away from macros / bloating things.

-Doug


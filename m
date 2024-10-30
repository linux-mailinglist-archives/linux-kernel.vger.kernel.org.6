Return-Path: <linux-kernel+bounces-389319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A909B6B54
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6771F21885
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069F199E9D;
	Wed, 30 Oct 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ldmCdFys"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BE1BD9D9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310637; cv=none; b=akIvNv5aVMKrggbWtdBhmrUlEaBgFGHSOEJFB38kU2YxE5Ntd5WYfI5710kFp0GJx5/EUz+cBPB/4y4XLgc6+roGlb9H2ZePtX8Z0XB1OLjPbhIUmFhzoD15G1s8VdzDLgvypU94Rv8eCLG0lHfKRap+kI9bvzTiQs5xvElc0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310637; c=relaxed/simple;
	bh=4H6B1quzDZP3bn3/pVmog4+PlbPtHG+BAM9Z2MVujDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOqJbCTY+S7q9em0nDy/Zw/nS8kGWi06F1DZLhUH6OxMXrNy5l14I0a6ueOIqTSjnaDiXNVVHwiLs3p8YFZqmbPniAl/y9uYtqQYQSK1otQ/HaQZHw5IwjIg9R6GoiH8YtlT3R3n9cV+sFN9OhvD68R8cG77nw8u/1N8WAymt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ldmCdFys; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e13375d3so117890e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730310632; x=1730915432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eViS5GExJs7/C8t7zeY7Kx13rGb7WxwrhKFvKq8t8Io=;
        b=ldmCdFysPamc5Xgo3Smn/x3d+hNhB8Wwx9XKFD5nD1rDa3Kl5akmtMDD7n+bYX9K9n
         W+pTpjVs/UoxrP+oRp42KhX3VatkCDUujAXZfzUIyk9bb7sZvSYP8rvbiqLsk9TZXHyS
         XV/mb6bL0eYHAXCVVMR6t2H4jUuslYklRWFzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730310632; x=1730915432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eViS5GExJs7/C8t7zeY7Kx13rGb7WxwrhKFvKq8t8Io=;
        b=oNOKXi1TgocVXWAmpv2bvhVYSt2pWxbR0iDC6B9tqW1Y4jwZwAdz1IG5I1hRFMDLiJ
         I9rBJOetdE5eUdM0dhHYexbU7AodNGbBMzoyup1jGDi2RoUV3/P4A1pzC9J5Gz6bL+0U
         KxtOEDJW1cEwxEHmeSzkOimotH1CJPNKDbdCxL59NmKOl2kZK0wdz7ehUNFG1/jITxQk
         nx4x96G/+zeBkTNsriByFCbF57WoY37+x2Vd0z5ZT883KvrfEEHwA7ZEvSHHVChG1Asj
         aRcyizkGNsLj8Y/vR7evxvVTIvyxVQXsLPvUcVxAgnQ3p0H/H4N5bosjnGRy6mpn0Cto
         0VRA==
X-Forwarded-Encrypted: i=1; AJvYcCUXC4jxc2MF8L4yPmDXES7/qD6BPcsO/m0Cw/MLaoWKC1QvIcGlv6NJ4r3cTswNk5XRIklH+MWIFVM+f/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxeQ0tgRqBY82xk/LIeQnvtkzRvr1h97oXYYXUuaEPkBTO539
	MkSKtiIc+mWpJIecDofSDjr9y2cT6Lc1uSeJ4x6rOs7ns2bxrI6fso5tXBl/bcz0sM8NyDdQhN1
	Mqg==
X-Google-Smtp-Source: AGHT+IFEl7iaja393A1d4YQ2mhet+yJHDXYIenAVTglibUFfYl+KvhSWtAOfOv+aYZ1oNhmJCf6+TA==
X-Received: by 2002:a05:6512:3f1d:b0:53a:423:6eac with SMTP id 2adb3069b0e04-53c79c9705fmr291349e87.0.1730310632155;
        Wed, 30 Oct 2024 10:50:32 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bb818ffadsm304185e87.50.2024.10.30.10.50.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 10:50:30 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so367251fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:50:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvj8hzW2IcCiC+RsPqRT7rC4UdgplwrmFzdCG6YwTAuEYP0HSjr6ZIU2f1nCINWIYg48w/QUpJz7O+QkM=@vger.kernel.org
X-Received: by 2002:a05:651c:50c:b0:2fb:58d1:d9a3 with SMTP id
 38308e7fff4ca-2fdec5f8336mr2759001fa.18.1730310629695; Wed, 30 Oct 2024
 10:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026035928.183454-1-tejasvipin76@gmail.com>
 <CAD=FV=Vps5vWD72O_kYhuKudduYed41+tZrVRB6x+FiaZrm-EA@mail.gmail.com> <c389ea3e-70cb-46c5-8cf1-878a99f771ec@gmail.com>
In-Reply-To: <c389ea3e-70cb-46c5-8cf1-878a99f771ec@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Oct 2024 10:50:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WmPmroitmYL3a4pdw8ai2LiQpJ6=zYh0kUdqcp6463Rw@mail.gmail.com>
Message-ID: <CAD=FV=WmPmroitmYL3a4pdw8ai2LiQpJ6=zYh0kUdqcp6463Rw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: leadtek-ltk050h3146w: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 30, 2024 at 12:24=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> On 10/29/24 12:24 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Oct 25, 2024 at 9:00=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail=
.com> wrote:
> >>
> >> @@ -418,79 +398,42 @@ static const struct ltk050h3146w_desc ltk050h314=
6w_data =3D {
> >>                 MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
> >>  };
> >>
> >> -static int ltk050h3146w_a2_select_page(struct ltk050h3146w *ctx, int =
page)
> >> +static void ltk050h3146w_a2_select_page(struct mipi_dsi_multi_context=
 *dsi_ctx, int page)
> >>  {
> >> -       struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> >> -       u8 d[3] =3D { 0x98, 0x81, page };
> >> +       u8 d[4] =3D { 0xff, 0x98, 0x81, page };
> >>
> >> -       return mipi_dsi_dcs_write(dsi, 0xff, d, ARRAY_SIZE(d));
> >> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, d, ARRAY_SIZE(d));
> >
> > FWIW: the above might be slightly better as:
> >
> > mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x98, 0x81, page);
> >
> > That would make it more documenting that the 0xff is the "cmd", has
> > fewer lines of code, and also gets the array marked as "static const"
> > which might make the compiler slightly more efficient. ;-)
> >
> > Not really a huge deal, though.
> >
>
> I did try this initially, but got an error because of page not being a
> compile time constant. Not sure how I should handle this.

Ha, that makes sense! It can't be "static const" because that means
that there's one storage location that's never changing and that's
just not true. I tried to see if there was some way to make the
mipi_dsi_dcs_write_seq_multi() smarter and have it detect if
everything is constant but I couldn't find any way to do that. The
__builtin_constant_p() trick doesn't seem to work with more than one
number.

So I think what you have is fine then. If this becomes common I guess
we can make an alternative version of mipi_dsi_dcs_write_seq_multi()
that just uses "const" instead of "static const".

I'll plan to apply your patch next week unless someone beats me to it.

-Doug


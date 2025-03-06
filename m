Return-Path: <linux-kernel+bounces-549334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110AA55163
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E66188353F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78B24EA87;
	Thu,  6 Mar 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frVSO7Is"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7037213E64
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278512; cv=none; b=Yqtfsm6J6vTTp6Ydf1R7RrhzynSwd8Aj2UZRwscQts+S7HblufVYw9mJDSnatH3BHK1VLE7SigBBmaxJlEPWESvYTg784PEQ3E9rrxXT5tN4kjYCq0ZVVnVLD6hRfZ0d5nLhG1tPt0eIvSphf4xO7r8SkL8kVndWSb1wIRiCEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278512; c=relaxed/simple;
	bh=u401eKdfAsjVPwVjKoY3JEKzFhztqUsvAALPu64QJMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0o6C6WKbUFZDds/ucekIasDlhf5ifUimcfEaA1kFPvKjFHk3R7F4hHVB87m/FaA+FISG5OMPBeP3qqRsxXhehKxjYzMo7lrYHQUSj/q18WA5ywQtAcXK1z/B6X/9fg0x+g4frYm3g6k9GkFHuC2i4C8DTnICPC/eSk0S03z2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=frVSO7Is; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so722675276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741278510; x=1741883310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u401eKdfAsjVPwVjKoY3JEKzFhztqUsvAALPu64QJMg=;
        b=frVSO7Is2kIgv0IpZWTcuJdCaQZhIuNbjxUbr99EzHVPo9DRpFF2D5G/WXwmn7iAM6
         ByPqtqLnT1mpMWyRiQR9ym8m0R/PeFk2vSewnGPlexd45F/Iysu+AnG3ns1rvADYwiWl
         QPi+COYny0WZeiV63XXoFa7q2oca0IqgrfAptl9ciV4l30/dYgjKwuTTBbgRNm5ty/HL
         lmhZwlOnAKoerCmG0NPzeu5UhYkKtNjWWgOtPr6hBimwdxFgZHfHSUdjz9Lnem1JROob
         AvDCRABtMTESWcDf3zntQfkvTTTVXBWJZBGbSOot2zg9uOWaa/6u7nJIDcBrVuv8+OmY
         Z46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278510; x=1741883310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u401eKdfAsjVPwVjKoY3JEKzFhztqUsvAALPu64QJMg=;
        b=J0xfkWcP7CoumosVqUh+oVQ2FnVmp+aYSupNiVHb3Zlhn0zTYtmrNP8fo9T4cWERrG
         ux8/i1JtsQQ6j09TnqB23KJbGhYubMaAo4G0Jhndlk3XuX6TTAlq4c9dDxsqzBGxy7rl
         aUNczj889pqhnqiZhsCtKWOSGMn9NVDgU/pH3Q0BHCjGVwWjHYRm45P2lcFrywwM1zpw
         D8eaDFhstDNeV8SQG09xzO5vcgqSjqQhdxBBLFigWD6+/TF1HQ+F9cZ7uUmjNlmPKA9v
         BF2bBXXhKsRQsChBrv9YDx2NFPCsHAHzib7x0LGhSl3CmBLuoShW1cTko+oECmpRfM0L
         4a4A==
X-Forwarded-Encrypted: i=1; AJvYcCX9i1FyLpOqwpV+PeEONVrgHzUAU9Sc3ygOJjwphvo/m/PQYY9uI4LCya2k4IxgwHo19B7D8HLH3V3w0Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjMNmcPxUXl3meZGJqSHDb9R3RA9Nuco98kgJ2ypsFQu7ImnH
	c0ZLzyS+gkgw+9JYORvS+UoF6FBdx/3X9RjXOFru4OwtfDIH7x3C7DR3VwtPevrMmJpLHurMt2d
	EexZKKCRoihhQLJsFoJdov7qXc0V1qX9Cz2zaZQ==
X-Gm-Gg: ASbGncusrGgW2EO3yXbrY9VPHaT4ePrmMZbuVfSfxjjmRWqH0N6Sz0Qq0az65FyRYIg
	miTFvI+dfX/bDuwXDVVpCQmK2/9UGwEx0PCzLfz652zvMFLZ0wMdRgJHJDQW3pqdyr+iA2pbHR1
	tqV1oUVsnxlYJUXq8MHoAbL7io4IN6OdxkBu/9SgyeEzD+Ad5zddZzUIQ6
X-Google-Smtp-Source: AGHT+IFWX8cMwz1Cinq5ViWvbdeKGSudz4sYjepsj7zpuVhC2/gnGasZpctcONcxuPwKJpNSiunXCog2EiU/l1jDLV4=
X-Received: by 2002:a05:6902:72e:b0:e61:1b41:1765 with SMTP id
 3f1490d57ef6-e611e1af5e5mr11126896276.17.1741278509724; Thu, 06 Mar 2025
 08:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
 <20250306-clever-lime-tanuki-e2fc43@houat> <CAN9Xe3SDyC47HWww1eH63aZOiM-WF9BGxztM3yh9bf6ORuY7VA@mail.gmail.com>
In-Reply-To: <CAN9Xe3SDyC47HWww1eH63aZOiM-WF9BGxztM3yh9bf6ORuY7VA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 6 Mar 2025 17:28:17 +0100
X-Gm-Features: AQ5f1JrGCXtLbfdfJxbvkwabPWzjGFyxIosg6el8QHcriEDkbtpQ9dR5dwW-KkA
Message-ID: <CAA8EJpqBy22eWZjccT5_UM2PQGjiG4ZEfrb6S_1tP1w962rd8w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Tejas Vipin <tejasvipin76@gmail.com>, 
	Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 17:10, Anusha Srivatsa <asrivats@redhat.com> wrote:
>
>
>
> On Thu, Mar 6, 2025 at 4:31=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>>
>> Hi Anusha,
>>
>> On Wed, Mar 05, 2025 at 07:01:41PM -0500, Anusha Srivatsa wrote:
>> > Move away from using deprecated API and use _multi
>> > variants if available. Use mipi_dsi_msleep()
>> > and mipi_dsi_usleep_range() instead of msleep()
>> > and usleep_range() respectively.
>> >
>> > Used Coccinelle to find the multiple occurences.
>> > SmPl patch:
>> > @rule@
>> > identifier dsi_var;
>> > identifier r;
>> > identifier func;
>> > type t;
>> > position p;
>> > expression dsi_device;
>> > expression list es;
>> > @@
>> > t func(...) {
>> > ...
>> > struct mipi_dsi_device *dsi_var =3D dsi_device;
>> > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
>> > <+...
>> > (
>> > -mipi_dsi_dcs_write_seq(dsi_var,es)@p;
>> > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
>> > |
>> > -mipi_dsi_generic_write_seq(dsi_var,es)@p;
>> > +mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
>> > |
>> > -mipi_dsi_generic_write(dsi_var,es)@p;
>> > +mipi_dsi_generic_write_multi(&dsi_ctx,es);
>> > |
>> > -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
>> > +mipi_dsi_dcs_nop_multi(&dsi_ctx);
>> > |
>> > ....rest of API
>> > ..
>> > )
>> > -if(r < 0) {
>> > -...
>> > -}
>> > ...+>
>>
>> The point of sending a single patch was to review the coccinelle script,
>> so you must put the entire script you used here.
>>
>
> I was actually thinking of sending patches per driver this time around si=
nce Tejas also seems to be looking into similar parts....Thoughts?

Have you discussed it with Tejas? What is his next target?

>> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>
>> That hasn't been my email address for 6 years :)
>>
> My bad. Will change this.



--=20
With best wishes
Dmitry


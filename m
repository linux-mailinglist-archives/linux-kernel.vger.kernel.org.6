Return-Path: <linux-kernel+bounces-574043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3257DA6DFEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E47188DBAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8D263C6A;
	Mon, 24 Mar 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CsDiiExK"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD4261390
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834236; cv=none; b=iCyeyyGj1XPEmO08DQgEJQd3/1A/FBZaRK5Jvs+I53RqxbOqcgL5A+V2JJterr+pLPzj2AOlHvf1CdyA3yVDar7D7UzRS0xfTBHhM4R+by8Aqoz6P03+zcic7oR3PeQCgdRt9mNV8/QqMSsN+NbTtwgqODFIcK8Lss1hxY22Bns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834236; c=relaxed/simple;
	bh=Y+4yAGgYQGKj/qkjS5hr6PuM1UYULojI6XEd2pZcjAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAoaQIcaTcDPr63ZUyMjgVry+wndY3IQuOBh1HJoQtWhEkDWQcvPRyr+KlAThj9aQDWvcVbrxfXWL0hfKTaAAhPAc15j8i12UbbMhqVg0GyT2A98atcTihdt59znuVaDU4cT0XKKcABSjbxu911EYllj0emIF+6te0/a0Qbs+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CsDiiExK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfed67e08so52821351fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742834231; x=1743439031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDN1DigddMVH2DZcXLwHcLv3wl4mw8L1y1VFkP+R480=;
        b=CsDiiExKWkSlZeMN2sxBwe8mjcrJ7BlOfOCEAVXg6rcC9Fm/L4Q42aZy8/tn7dRbnf
         sBzSH1wNpIm2DHE2GsInnw6suBif5/xTVFZKG9u5C7ZVWVStmUw15M+VLV8Ftz2pHKSx
         UpwJg6yB7ZfZohJJ5Bvcr2RwtKUM+gvEI7aEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834231; x=1743439031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDN1DigddMVH2DZcXLwHcLv3wl4mw8L1y1VFkP+R480=;
        b=kI5qqz/UYaTDESu8KtpIptT4HuY4bAnjLLqIpyQD6iwDBt932EORO3BCyrOMKxhTJF
         c+c54aU2okVpF+F/zlCbrXIuqfBYjnOjVV/2996nx0lUOs8AaCrKuCPsZSi+dlG0214u
         qKYr+oD+yEgjx6OB2TRVp4CcNpfyzquYUqaJytvLwEE77meAcfXwNC0m2AJN/ALISDN/
         tJJ0p6sbpPWqoJavo8mXLB6LsH2r3jwskHOrQihI9K6D7EwANED6SSW7HzYmCUrPP2t+
         LQUKlbEZzVZLt6LcIY+kFrTf3TwdMMkr7G7wZRtSNJr74C8KkvEDsaj4+HKOGGfkwUpB
         wCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyG4MKGEzXX147D+ijoC/IQgAWignbRZnwqGmsvHZ41/ZmbldKOnF+wjN9sXRBiBr6i5nCis2BvUE/Xeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5ej/gM1RgTVzPQD2O1nwbPyNwAIajnY+QM2fH5URjGCjh1fB
	osNVXKEk3UxDQeKKGVGx43IOt6xDIaEc9vMmJqX8LOzHfSo585MzPw3QLykpi009z04kkvYW+70
	Gog==
X-Gm-Gg: ASbGnctnu4SpzHd8LqDaPcbdd6tcHHNHau8m6zccKA62Wh3N1ziiVveVNwin10/hjVD
	s1WKEieoenDEaBufZV7KLxTc0pC3LwbJbmNzxXLYTvnoLH3x5igBsZ4f06Hiy9AZrHsxY7aLb4/
	Ce7RYlra7J5nH0oHduAtyZghOCkNWp8mhxtrDelxL5FepjmfgFIMeOvBOzamg3Zy774GhfJ2JWP
	ynk+EI68BICZn5PL9fMS4Jqu9H17WrfgxAhF/QhGIhVgVzI8Dft/aDrZDnlRKp6pdh77W8YXoaS
	JfIxNOu8UmkpbKHSasRJbKWRb6lsrEfCr7TrS2mJxSvq5pY74OBAwyI1WwObNQ0A6AmpUpAo1Vn
	UFGD7Xz7f
X-Google-Smtp-Source: AGHT+IHhXU/ipE/ihkY71SJK0o0GXq8uZE+oXgmnJeRMVw29O64lwBubrMo7293HBc65yh18F2v7ag==
X-Received: by 2002:a05:6512:3da1:b0:545:353:4d46 with SMTP id 2adb3069b0e04-54ad6490503mr3913215e87.25.1742834230876;
        Mon, 24 Mar 2025 09:37:10 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6508163sm1183548e87.181.2025.03.24.09.37.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:37:07 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499bd3084aso4170154e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:37:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKlT4ptPFNyh7uu070+vI0ccpZRrAc33MMXtX80n86q5MnplFlJYEotGkc2M37+m4BNVrPAhiD+w+NIjA=@vger.kernel.org
X-Received: by 2002:a05:6512:3d11:b0:549:8cc8:efed with SMTP id
 2adb3069b0e04-54ad650a07dmr5306442e87.48.1742834226392; Mon, 24 Mar 2025
 09:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319183106.12613-1-tejasvipin76@gmail.com> <CAD=FV=WZxF4CGSAAqSvs8XnLEvkXNEEv87V3ffE_uBfj-qWN=A@mail.gmail.com>
In-Reply-To: <CAD=FV=WZxF4CGSAAqSvs8XnLEvkXNEEv87V3ffE_uBfj-qWN=A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Mar 2025 09:36:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VWj03LmA-LfSDSkrg0m53AuYPg8YQLK0m_BKT6xBEBEQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrW47wJ32hbO7SbwG8ki058S8keXJviwMHqGv6pjeXdowOMFlpfudBmNlc
Message-ID: <CAD=FV=VWj03LmA-LfSDSkrg0m53AuYPg8YQLK0m_BKT6xBEBEQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: samsung-s6d7aa0: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	aweber.kernel@gmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	asrivats@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 19, 2025 at 1:05=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Mar 19, 2025 at 11:31=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.=
com> wrote:
> >
> > Changes the samsung-s6d7aa0 panel to use multi style functions for
> > improved error handling.
> >
> > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > ---
> > Changes in v2:
> >     - Remove unnecessary early return in s6d7aa0_lock
> >     - Remove redundant GPIO reset setting in s6d7aa0_on.
> >
> > Link to v1: https://lore.kernel.org/all/20250316045024.672167-1-tejasvi=
pin76@gmail.com/
> > ---
> >  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 222 +++++-------------
> >  1 file changed, 65 insertions(+), 157 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

When I applied I got a few whitespace errors that checkpatch yelled
about. I fixed them for you while applying. Pushed to drm-misc-next:

[1/1] drm/panel: samsung-s6d7aa0: transition to mipi_dsi wrapped functions
      commit: 837f9b917c47b4d35f0ee571a736de2895e2dd54


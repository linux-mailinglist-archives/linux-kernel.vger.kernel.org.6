Return-Path: <linux-kernel+bounces-283895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5406C94FA12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876F61C22370
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BD199380;
	Mon, 12 Aug 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Shen5vIr"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072831304B0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503529; cv=none; b=PJ/ZKVuNmbGaoDdrqt+M2O1j//YGQH5m1DVvOAlkmxbPy3SW52eHTuBx5ZRt/c+bBioB9zXLQwflKkgev3sdySxGRkvw7uy6TvgvaWWwAx2gxayv+soElmlK1aeIVI8GbP/vpH1G0VU/lpc1p7807szmnHRK+n6CcijSbVnFc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503529; c=relaxed/simple;
	bh=IyxatquVspbX1S9P70pna64OeZtOYsRbNdPzyYiI8sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUWIDoIS+W7czcbuWTJGg9Z6JzHe1Sx74gMAFkNBrUiLgDGPbysxANgRkDXD/YmT5jG+PPejyDdqoxSVlMl7x6yKI2173KBh49Ri9uP5f2g4IkMe1p23n5KiVheWZlw4QDr2Mw7LQKwOtcAgqOwFn+u7kKzc6paf8PE9T4+UxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Shen5vIr; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-827113c1fb4so1477542241.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723503525; x=1724108325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouT6IM1apr/KINsfRJHwaPDCoQ8lOSBwOo+X7EgUsGs=;
        b=Shen5vIruiK3Eq5awBDcfmY6KMlBO1YiYpDMCz6TT/01OER8MMrs8BIHhYmoZCWsMr
         /au+N1HL7wfOqXFZ/hSwC8/2mI4ins+DymroK2KN+HxmyQQf4fq1+U3hrAgTDY6iJg3N
         Oj5UHWaALQCIwI0NHIZndpbe49g0r/mOY95kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503525; x=1724108325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouT6IM1apr/KINsfRJHwaPDCoQ8lOSBwOo+X7EgUsGs=;
        b=UCjNmahsGO5BTOTGy5KMHu+TLUPLdc6xAvA+KC7D9AZo7ximDP7+C2KYQVgMHurTpg
         Hl79Eyqwj0Z3Znzno1aCz8tbHHEctMTHIx/eoONh8YhL4eKIFKZdqGsGbBDIUMMTb2Lo
         CnLYHXNOkj04O0+KOF5RLyskwni6qMp7VYz4qPt/Hel3LnLq9ZD8laUYog8HTSCprlKr
         6AJiFH7503vU6cJoI44eKo4xhvRoVmrK7j8TUNKcPcjDcnPKZhpPl0f/FnMPG3p2/Onm
         mCxldbLGpzdStZzVPlTzZVKDhCf83HD7pjz3vrji4pKeIZ+xF5+0o9P35KLkjP14jB3z
         Xnlg==
X-Forwarded-Encrypted: i=1; AJvYcCVqNDl9hCUBTKF+dm9NGjBXZGNSyfwdwOAnbn8Cnq0t/WB0JFLpFvxvoVE+QKIChucoD6IVYGDZdLgFA4h6E9kEChkS67GDLBxlJC2s
X-Gm-Message-State: AOJu0YxxJVCZqpAWE4ZqFRXEzp8w30vVrEmavHK3LEvoSOdK60tJ7LKI
	OHtxVRrYwzw6mmIy/8whe7BrfA0B1j5/zHbbvOhhb/PFvkctLU4HsXszQVthwNUzVyINRgfX7Do
	=
X-Google-Smtp-Source: AGHT+IHuDkqUM1S/BSZlSslcGhkBVmuh+XQqHsyiFLGGzeY3pqR2qFmFtLprVVgYELVfIB3uXdVoYg==
X-Received: by 2002:a05:6122:46a8:b0:4f5:261a:bdc4 with SMTP id 71dfb90a1353d-4fabeeb0b4dmr2520193e0c.2.1723503525423;
        Mon, 12 Aug 2024 15:58:45 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f91f4f145bsm771389e0c.48.2024.08.12.15.58.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 15:58:44 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f50d8ce6e0so1781809e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:58:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtiFOZi00qIq2+LK1vyIvqCyrT20H9vwiH9DdnXSASkw05dQZ2rcgo4VCIxjjCLNZ8F0nXOrbhbJPf85XXhiYKpHCYRc21dESleToR
X-Received: by 2002:a05:6122:3c42:b0:4f5:2aa9:a447 with SMTP id
 71dfb90a1353d-4fabf07cd9cmr2352201e0c.11.1723503523748; Mon, 12 Aug 2024
 15:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810045404.188146-1-tejasvipin76@gmail.com>
In-Reply-To: <20240810045404.188146-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 12 Aug 2024 15:58:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VzzQG3_dHSU2gCdena4aL-PgraMKYkBo1DzKLkV=7c4Q@mail.gmail.com>
Message-ID: <CAD=FV=VzzQG3_dHSU2gCdena4aL-PgraMKYkBo1DzKLkV=7c4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] add more multi functions for streamlined error handling
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 9, 2024 at 9:55=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> This patch adds mipi_dsi_dcs_set_tear_scanline_multi to the list of multi
> functions and uses it with other multi functions in the jdi-fhd-r63452
> panel.
>
> Tejas Vipin (2):
>   drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
>   drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions
>
>  drivers/gpu/drm/drm_mipi_dsi.c               |  31 +++++
>  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 125 ++++++-------------
>  include/drm/drm_mipi_dsi.h                   |   2 +
>  3 files changed, 72 insertions(+), 86 deletions(-)

Not worth spinning just for this, but a few comments:

1. For the cover letter, it's better if you can make the subject more
different than the subject of your previous patch series. Comparing
this and the previous series you sent out side-by-side:

[PATCH 0/2] add more multi functions for streamlined error handling
[PATCH v3 0/2] add more multi functions to streamline error handling

Maybe this patch's cover letter should have a subject more like:

drm/mipi-dsi: convert jdi-fhd-r63452 to mipi_dsi "multi", adding more "mult=
i"

...or something like that.

2. In your cover letter you should note that this series only applies
cleanly if you apply it atop your previous series. You should point to
it w/ lore links based on the Message-Id, like:

https://lore.kernel.org/r/20240806135949.468636-1-tejasvipin76@gmail.com


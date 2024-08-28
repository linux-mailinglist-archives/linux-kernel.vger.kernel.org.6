Return-Path: <linux-kernel+bounces-305592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912539630EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD527285F84
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EAD1ABEA9;
	Wed, 28 Aug 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzKj1wDd"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936211AAE02
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873210; cv=none; b=lB35cBbDgHVuVI75xCxOSa7t0sLGxD1SqR8Pm5FT7cD365vn29uCRHSiewePmisDmagbBj7LUr5jNG9BJzse0AApTAwDfwheq3KkGmyF78jF9e5T4Q6TZK5tc8EwwuJU80e0+M67Aqfx6nYY09D+HfpnX4ZHF6O0ad2mDK5sy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873210; c=relaxed/simple;
	bh=JsrETUs86iMn+eky+26yKzZ0SBtpZ9u06T27ryFFZR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0H3I7aCbUSHiaFg68gzRQ92Fvvza/RCdV+Rd6gl7MEYtiuRNJYMHddsPwH0VkP1ckFqniDdgsVJyRLiypysRuZfq7Skm4mmuhyCHTqgs3ij+yiQu2gfcPCJaKQvS+ziSio7M9HIoNiGFEaH8u9Kkk7SklqbSFLP9B2eR8TyQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PzKj1wDd; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-842f1dd60deso2264203241.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724873205; x=1725478005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9b3TLjbnTz825v2LNHY3zO60OAKAYUhKNLWtiBOuhI=;
        b=PzKj1wDdol3QGj55xCl9/LxH8FtIqBHavYUxoIrabnDppOI4qU0GF/EgqJPq9lXm+3
         hL0JDxdaa6/Bu7dFR9a+IqvSLIvWsdf8jjlYu2csJtU/q0KvFiXRvtZYzzAFAcW7cf50
         D7vYsjGxPAzIcD5lDUQMO8K/AEAo0k4/SJHFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873205; x=1725478005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9b3TLjbnTz825v2LNHY3zO60OAKAYUhKNLWtiBOuhI=;
        b=bZ9/9OPVRXseYkL2xLq0TBta4WkvoXaGAuKPKXsV0vXJ7jkuXCmZLQUKNC85YtOkWD
         c+XinIwNOb69sXW6ani5BPkvKSBryv5ekWh0SqVJNnT3uMBkemyTHxzdjmCTE8rB4dkc
         rAvtd4K88BVeKgp36D7wD5jZaGXcgWDn3Lg9mXymH8OWa30kqKAMxBUdfAqArv3nX5He
         TP0fpNnPSkuNyih7jodlJ/hCR5/YsAHJkvLu2mYtWSAbC+ocqPTG7QGFlMFNZYRrRESu
         v/PgFSyY/L+Jz1WAHoe2JKiTn/R4S7k/h0cMBsUALXdSWHCpalDES4incCGH4lPOJIWW
         mMCg==
X-Forwarded-Encrypted: i=1; AJvYcCUKfK6HW5FJMB1bcdZeIzsEPYSMtVjjtqCAljEOzbZTG1czr4/vjz65he/SfILokRxjSyjU4vynYX42K/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fx/Lram5dyUa8WWHaYMkmJGmUPimrjk2YdPf0P7Tq60Q45ds
	z3sJ1er1R9uVG7P9R3pPyn+5Yr3gopaAUTt40NdSHpJobDLrOamigpJUFrdyn9klS3F3u1PDsKk
	=
X-Google-Smtp-Source: AGHT+IG5xAbCjiGDVxvb76RSYlNGqHcsyXdA9NP9UdXrXoKNWsJFLVw3MgfFvsQCj0yNZ6Q9pBYVwg==
X-Received: by 2002:a05:6102:41ac:b0:498:e406:b25e with SMTP id ada2fe7eead31-49a5af327d8mr944001137.22.1724873205411;
        Wed, 28 Aug 2024 12:26:45 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844d60be0c9sm1486853241.28.2024.08.28.12.26.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 12:26:44 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4fe97b060e2so1767492e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:26:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYbOzLOW5pa+3bo7YieTQgC66E8ty6Y6TsltbcOFSM7dPWF3lAHpsfuIb8Yvx639lINn0ncGQOeoGhcr8=@vger.kernel.org
X-Received: by 2002:a05:6122:319a:b0:4ef:65b6:f3b5 with SMTP id
 71dfb90a1353d-4fff17072b6mr448863e0c.10.1724873203775; Wed, 28 Aug 2024
 12:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828182210.565861-1-tejasvipin76@gmail.com>
In-Reply-To: <20240828182210.565861-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Aug 2024 12:26:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V71VzJk81YALO4ufohL0a4EQuqZVXavbpM=bqHgsf0sw@mail.gmail.com>
Message-ID: <CAD=FV=V71VzJk81YALO4ufohL0a4EQuqZVXavbpM=bqHgsf0sw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: novatek-nt35950: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 28, 2024 at 11:26=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> Changes the novatek-nt35950 panel to use multi style functions for
> improved error handling.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Style changes
>     - Fixed changes in logic
>
> v1: https://lore.kernel.org/all/20240824084422.202946-1-tejasvipin76@gmai=
l.com/
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt35950.c | 211 ++++++------------
>  1 file changed, 66 insertions(+), 145 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Neil: Let me know if you want to land this or you want me to land it. Thank=
s!

-Doug


Return-Path: <linux-kernel+bounces-515870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47479A36A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A39E3B01B3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6955478F4B;
	Sat, 15 Feb 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DeCIRD7E"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178407080E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580160; cv=none; b=o2WQqgxai/2zMvPbAZaLZZw/ub0aARn8CY9+8XWUZDbS4QHUfGuNKVBXGe22zdG8bzPGHHHR3AwTnhQ6OQlgvLlmNaKEZx4wwR++1Owo/m0xu/0mMaYRG97wfvlMqgskK/EpwZYqJKup//40/YzmxAujpwDddAtUaVdFZxzurUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580160; c=relaxed/simple;
	bh=ZVu8+VefJZHMcjD4YYJyHLSOAOenrSokQl6lPKDqWFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTWZdyJIdIG9TL2djCyQae6gHzvC/W4M5SbjmIqn4FGqUytVqwdHBhDA7Iwuuc7rlxqZnqlBCdmzf2NiN3mPqiG9f02aC+CdgvhuUIIZ+DZeZBOClz4UNGEmNWzYA9Qb/FORcKY241Q2ZlYFUHv0v5yt3HSDssQexz3Zqu/AEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DeCIRD7E; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54529e15643so1096632e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739580153; x=1740184953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knE8v9zYVGyQDQfSdvTMBCc1TTHDqVX+HxXJrV1G9rs=;
        b=DeCIRD7E0/W6ymgtE8RkNgEHob2wsA02x6dG1AbAeVz2jwaueEHQhMKDgNXTuV/nVL
         JmQbw2qdNE4yc/fLq70Nx2msis8PDx2W8dy7H51JyUle9DITqyqYjsrdxVCBrkBjEjXP
         cpEj28e5X2bLKC312jJ2fSBIxN8G2WDSTEvLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580153; x=1740184953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knE8v9zYVGyQDQfSdvTMBCc1TTHDqVX+HxXJrV1G9rs=;
        b=nVdHT8iPnIIW0TFn/8acM4Zw9HJRLzBr0QNK94ZE/9aUZ4r0cEmVA/+LGlSTEdbQrM
         FE9ubN84pJTwa5Q2vhMczj4bB5sNj2G+HUV5uJlonfe3ar33W9AW1EH2TFJctFCEqkHV
         +CVyK1U9dsaLtCeOIHlPxDHmeQYwws4JUgXRzx2nZjyGD0Z9nwKzCnFpaztPq/LHNO0P
         2rWX1RCL66JCHj8hvRb49COxDkI7Aq+QuutUoSvHE2WcnoQ7DcbtN2ZGkLK1uL43EiwS
         wqEyo/5STzBxmJfcboYjZuR6lB5wSMD4xCeA3KJmD/KwRpFwRgowh50CfFDl93O15zgv
         2Rrw==
X-Forwarded-Encrypted: i=1; AJvYcCW7YihDc+UkAq9HIHsUgZVJiVngvnkF/vVWVHUYgRK41YLJLKvORiWs0p9qFov7Ea4V6O+gnL9JRrUCMmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gNHREh/qgl62c/aQSyZyxqQYLzXHVZhszK819+9Q3ZXXaw2/
	VO4nxOl4mZNQCk+jqzCV514FOnI0D5xoRk+5/8/r2aywYcxbD1NEiuV799mcGSA9pR+WN0LBtfb
	O4GYj
X-Gm-Gg: ASbGncs11atiLl3h1btQCA0sI4a/DFyH14QZqCnAi+NcHzz0Bv0WbsMKuvvzEwtjuW8
	VX5Y/7jR1uhr2E+pBs2aX0waXtOScMRTBkW6+7lhv1ODS1pcSgzE9Y7E05CWBtt7u3/68J/5Mkb
	UgnXIyEfepJ0eMpDBxY3A+KHCJwt6bNI6AnqDRn9fNhC5Zt1UNRG2k5tsGteTwN118LHqRhRZwD
	NKdi1ANBEHMx5/S9ZUJw9BkZ0SjhN/lHAcsygBYteUqMqNYXWanLhpixiUEMSbmjgZMRUnf7CvX
	AAR50g11bsSg7Hj9zI5XtzLI0W6x4FHzUBMLT8+q4umUHlTokwiSMVoNgRU=
X-Google-Smtp-Source: AGHT+IFQg1wcmwo+iJ7EFFquIFRBSXQMmzmCjSr4mgmiY6+83j0RI+3TWiEptU0VEL78BLtwfQl0/g==
X-Received: by 2002:a05:6512:1193:b0:542:2139:636a with SMTP id 2adb3069b0e04-5453031820bmr328979e87.7.1739580153449;
        Fri, 14 Feb 2025 16:42:33 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105f28sm705563e87.118.2025.02.14.16.42.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 16:42:32 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-307c13298eeso26119021fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:42:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd8jxB4g/+4AInKLb6IpcPdruqT2ooVqMIlI9NdRM7voOOOilOdOuvKyHK3T19QwDP47kxfuASFsp8ISc=@vger.kernel.org
X-Received: by 2002:a2e:910e:0:b0:309:28c9:54c3 with SMTP id
 38308e7fff4ca-30928c955aamr2870491fa.12.1739580150226; Fri, 14 Feb 2025
 16:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214172958.81258-1-tejasvipin76@gmail.com> <20250214172958.81258-3-tejasvipin76@gmail.com>
In-Reply-To: <20250214172958.81258-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 16:42:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U22kToVeyCBy_TV5hNKuMZv-QBUg0WTyXsMSu=bHLd3g@mail.gmail.com>
X-Gm-Features: AWEUYZl9RMNhOlvjGnk24tr1lRpcTUKmNyE4ytjlZLYxfkgep28FyUJ3Tv8BSeI
Message-ID: <CAD=FV=U22kToVeyCBy_TV5hNKuMZv-QBUg0WTyXsMSu=bHLd3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: sony-td4353-jdi: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 14, 2025 at 9:30=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Change the sony-td4353-jdi panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 107 ++++--------------
>  1 file changed, 23 insertions(+), 84 deletions(-)

Nice diffstat and so much boilerplate error code removed. :-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Note that I'm on vacation next week and it might take me a while to
dig out of email when I get back. More than happy if someone else
wants to land if the bisectability problems I talk about in patch #1
are resolved. Otherwise I'll get back to this eventually.


-Doug


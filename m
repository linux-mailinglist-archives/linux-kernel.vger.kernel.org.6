Return-Path: <linux-kernel+bounces-529860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C53A42BED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5090317AFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFAD26561F;
	Mon, 24 Feb 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bnHXeaZ7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65446144304
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422846; cv=none; b=H+d3YNGNXcA0gyuWlW/oFE/7K3mf0ndP7EoK3q4aI7TPmg/V61860CA2dBqtYMSHgXXGFpr1XXFPxaLR0l9JI9Wz4Ii+ks3S/QIoxnt2/yrL7FygNt8PrROzdttCrm1pusjYrVEm3R2ErYXOFIEGbfsjpL16JPDeEucrym8a6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422846; c=relaxed/simple;
	bh=UCTg3g/tkcfH1gJmx3kVcTsAp9a72p1V4y77QyBKanE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFkT+XCfyy8XtgaZUldyMh+8YurtUbycwZBwpbjKdGaUpgdD7dbBWZ54I8PWHlwRXSs2tuJZZhhvlQxiOcZRhz6a8fQ1SG6Ph4W8k2ooOIcHUUVrFkZYhIBNC4aajmnA3Y7+h2JDhvaInip8vgGrzD/gpRWJKWxOZO0RwHnJRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bnHXeaZ7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb86beea8cso853160266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740422842; x=1741027642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCTg3g/tkcfH1gJmx3kVcTsAp9a72p1V4y77QyBKanE=;
        b=bnHXeaZ7kI16nsBIF5WRZhsH90r55j+usE5vLddDWF8WxG9mChn8Px3JEfXX2DhZlD
         ZzFFNhLNAI1CA+acJNx23ptyUQ3QeG9uwq1UdKgRkkh5EnupdqT3dedEGgSSCCLd2+Gv
         ws29JbL0emHY3DaBbKZAsc+4C789B33E/GnYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422842; x=1741027642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCTg3g/tkcfH1gJmx3kVcTsAp9a72p1V4y77QyBKanE=;
        b=BKYMxfntXb135bR0YcCq9iEzQBtySQx3Ag9nD0mc+L5o9fPGT8RBb3zGNEdB+B1YP1
         66vFXwPuCq/N33bJK79FR8fkbekJPmnstCuedwNShCEuggUXoqWP7SBfYBm3Hg4K8PTt
         AZCcIE6Au+xsHR2MhQvGlzZm8Lj3jnNlcZpfL1orzD+YlPeR+tP61AA1rqFuLzDKmjqF
         o0TBV3aWkLwMjp1tTF/uWYp1kwMoxu6gNi7FspIZbWmkNnZMB6dlCldFzyK3DgKmZIr3
         DfkhvqeTavw/ioc0RH5Sc8LCPCcvpixHt5I0mrDSTScXEHp1MsCRB8gwpDoaUddHBK3W
         fCCw==
X-Forwarded-Encrypted: i=1; AJvYcCWmpg6q/ilkDVpfcYA8kxFwalEm7hdy9OFuD/71e1y/D5BX1zq1FXsvMtWPv6F0lH6rkhy0T/S4yRHA0Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcx2OSILCcZH6gL7UqW5IH2AhY3OhOWwMoBoeFT2L3eamTxKIQ
	FYumpzFLblMQigITFqfVgMokUQyKtcZOvVCmDHdLGNzsJBrVBJzLOeOaTMoOC9v3+l/QLjCdjQe
	W7lJz
X-Gm-Gg: ASbGncvXXOiaIzYFlOWOWh+eH4d6JYQYoi3wG/RVfJiusnYBeCStiFYNXvJl8OLbd8x
	x7HmFQQKtP9hoHMsTdA0/GwCSJuY8mbP360XpNG7H6uhW7+8MFCTXa2FQwy0Ni8R5rmtrubnWjw
	7CNQbDK8oItRDZdjWqYqYyTbwvWT1zkk4GL5jGMcYrTlUfQnZO5Ex8cpeyNe6C49Ty9/doegwo8
	rsjArjdQkqGdwjOw0MbFtVIHmmIZe60zp4Bah71sBiC8vyabESjbU1+bB57IExJAYk2ofrtEIHv
	LcZtDfYW/oDdlfMN+D9iObseKMhf07MRns/SgnznT4fbuQ0z/ZFq8SGlwVjWsrkkjw==
X-Google-Smtp-Source: AGHT+IFeSPZ689wVhtcXe00p5F++W0l1TBncM4TnGeyKWll5H3Ov/hwNsw+iStSd6iswQ8x6exccfA==
X-Received: by 2002:a17:906:7956:b0:ab2:b84b:2dab with SMTP id a640c23a62f3a-abc09ab8f13mr1386346566b.30.1740422841597;
        Mon, 24 Feb 2025 10:47:21 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054fecsm3944466b.150.2025.02.24.10.47.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:47:21 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso5851154a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:47:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZcN4FA+CCp6B5F9PstdCqHNDHSl2CIOPZzXqbIJ0jrc1jJ9FaWwnt00gFIOsNXs6yn/2nqXq+hFlhUZA=@vger.kernel.org
X-Received: by 2002:a05:6512:e99:b0:545:c51:4a0f with SMTP id
 2adb3069b0e04-54838edd8e6mr6201702e87.4.1740422441508; Mon, 24 Feb 2025
 10:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
 <CAD=FV=Vyx8vAeRohw3W11Tuv26_-zi-GV__G2cXFxF+e76MJkw@mail.gmail.com> <20250218-fabulous-agile-corgi-9a5ee0@houat>
In-Reply-To: <20250218-fabulous-agile-corgi-9a5ee0@houat>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 10:40:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UPY-VGr0qWnHcmdJpVGo-xqJyT81FxqJVp3qcrhcii2A@mail.gmail.com>
X-Gm-Features: AWEUYZn5kJ7jvupKGMyzFLJ3TnjjiDiS2fSx64zjhWAkyHi1oX6mHN7o3rYIme8
Message-ID: <CAD=FV=UPY-VGr0qWnHcmdJpVGo-xqJyT81FxqJVp3qcrhcii2A@mail.gmail.com>
Subject: Re: [PATCH 00/20] drm/panel: Move to using mipi_dsi_*_multi()
 variants when available
To: Maxime Ripard <mripard@kernel.org>
Cc: Anusha Srivatsa <asrivats@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>, 
	Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, Jianhua Lu <lujianhua000@gmail.com>, 
	Robert Chiras <robert.chiras@nxp.com>, Artur Weber <aweber.kernel@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 18, 2025 at 1:55=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> > I also questioned whether this really made sense to try to do with a
> > Coccinelle script and I still don't think so. It looks like Dmitry has
> > already reviewed the first few of your patches and has repeated my
> > advice. If you want to help with the effort of addressing this TODO
> > item then that's great, but I'll stop reviewing (and start silently
> > deleting) any future submissions of yours that say that they're done
> > entirely with a Coccinelle script unless you address this point and
> > convince me that your Coccinelle script is really smart enough to
> > handle all the corner cases. I'll also assert that you should review
> > Tejas's submissions to see how these conversions are expected to go.
>
> I couldn't find that in your first answer though. What corner cases do
> you have in mind, and why do you think coccinelle can't handle them?

My gut says that it is a difficult problem to make this kind of change
purely with Coccinelle. That's not to say I couldn't be convinced if
someone gave some good evidence showing some amazing patches generated
by a Cocinelle script. To show this, I would expect someone to
understand what Tejas has been doing and then compare that to what the
script can produce. In theory, you could even run the script on an old
version of panels (before Tejas's fixes) and compare what the script
does. If you can make the results nearly the same then that's amazing.


> Also, why do you think ignoring a contributor after a second mistake is
> a reasonable reaction?

Just to be clear, I said that "unless you address this point and
convince me...". My problem was that I brought up the questions of the
suitability of Cocinelle for this problem in response to v1. Then I
saw v2 posted without any reply to my concerns and with the same types
of problems. I was simply saying that if a v3 was posted in the same
vein then I would ignore it. I'm more than happy to have a
conversation, but if I start getting new versions that ignore previous
feedback and no response saying why feedback was ignored then I will
start ignoring new versions. That feels pretty reasonable to me.


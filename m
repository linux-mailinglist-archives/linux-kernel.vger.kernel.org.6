Return-Path: <linux-kernel+bounces-220358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F890E02B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0C21C22EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6671849F5;
	Tue, 18 Jun 2024 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xdd7ddzc"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376013D625
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754584; cv=none; b=rE/Z/BLrUsz9HEFQaj1fS8nG5hlpTX3hUvgwVyJj0nK3W3I1UN+ZlGLbqm/aLULNY3YHPQUsCAvbFC07biy9EY8ngxX6hckXAncxB3U9nZzMBhMSJOzWFfE9DPtG0ieWdxCnoVYPC48M0QxL6Zu3eF7YIEziZry4kkwquMb5ygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754584; c=relaxed/simple;
	bh=1shUkAaX3hg07WagI4y+xlOIw7P/MVYlVX9TG3q3vrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgGvqZUS2E0PkMwROp0YMIOcUXecm/8/IpeGh9OJKPYl29AQZBHWQsCfNSSrss2fyWiwe45WUR9j7V/1kyHKbBLOnRh12wnkyzI1QoR1ZNIJf1v1PkkVcnYac7zkKPsfzAEFLcfDMAFqaO5zgynLceplOjGty32nI6aZCLSu63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xdd7ddzc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79bb8dc530cso2083885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718754580; x=1719359380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEd8QmB1691hBRAZvofFeg0dEh0DbqURELeqCZwHCv4=;
        b=Xdd7ddzcnYezg1aOHoWnW4fb6RhyWv4Jkatckr7SlFHR1uoA6+3zkGNz/2dEF7+k0v
         waLibOU9saaNmvhQw8Ndu2MuCCEGl5zDvJtMqiXoWuX2M/8w2OU5Pu7SQBbfAO19+aH6
         6BdGWAZYeCYuAlxXlLG0FyUd+OSLNa3Xe+IvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754580; x=1719359380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEd8QmB1691hBRAZvofFeg0dEh0DbqURELeqCZwHCv4=;
        b=iJbYWcA7Ael+7W55+SYwP6RQv3Xuu2gAabo6n2aPtV3kmAPqLnrrnz/9rj2q8XNeib
         fbn4lkxb2K+1kkS0/Rzz5LbJhVsRRR/012hP7qjs1gCZUX/gjOjCNV8pz7rpeMveQi7C
         5BSqpAW2dGO99NJOsFxCyCZ2EXhSjblTb8xiwzz2k6Iqw+/udkr/fvo4FYw6rr7vvNCU
         3QWQPnYrAQm/asjK8lRr1t9QOKwcf6ytYBCbC8hYTXDDhSE1vnImmXj/+HyRBNR6xNU9
         7RyCQVzSS1m9mk5aPxwHyRh0JFKVSicQnbAJe33bpw383ULbYktJPE/HMhrKKbdCW9v2
         9hkA==
X-Forwarded-Encrypted: i=1; AJvYcCVhkutKv0ncoIebf1BtCo0cSawMixTpHiCiPBxFQGiv0LLAE0rDox4qWZ9QvW0TapGWdN8USFaRJiNUbD0sUAtBiqWzQl6oQLLl0paI
X-Gm-Message-State: AOJu0YyVrk6rq7dSYRXTTZi81uh/HZPRQFpo1Z4tsVPbc5ybrsfh3xWA
	JiUvIAwVTvKyHXUyZv3TMOaGCwoHqPzK0yq8HWLN9qkTnmMe96EyAWoNyuTIhkH7Nd3tqxf8nKQ
	=
X-Google-Smtp-Source: AGHT+IFC5U3IylYWzd89rvO59dWzsKfhcH5HTVG6WJN3CCGITn5UCOPwiWsPGRFJQCfDDQYoBJbYOA==
X-Received: by 2002:a05:620a:2903:b0:795:49eb:c2ec with SMTP id af79cd13be357-79bb3654a63mr224789385a.38.1718754579716;
        Tue, 18 Jun 2024 16:49:39 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798ab6b25besm558760985a.71.2024.06.18.16.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:49:38 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-443586c2091so205911cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:49:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1EWSPscC++Lr2KKvm3JCaCf/S6M8hph3BpUoL/760lEThm0SZALTK2P9iypOAmydZOm5S3GFhU8QX7ThLSwMSnqOEMk3AJdhmf23Q
X-Received: by 2002:a05:622a:144c:b0:444:9e8d:d82a with SMTP id
 d75a77b69052e-444aa3b5877mr664281cf.3.1718754577989; Tue, 18 Jun 2024
 16:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local> <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
 <Zmm6i6iQOdP613w3@phenom.ffwll.local> <CAD=FV=WBVfBZrgGay=XY2Usq3FA3m9i6y0cU4=b=w7qO6gRBFQ@mail.gmail.com>
 <ZnBFgDO37xhMfvzV@phenom.ffwll.local>
In-Reply-To: <ZnBFgDO37xhMfvzV@phenom.ffwll.local>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 16:49:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UindNjK4rWMvsMybgp_bPULbNz2A-u8x60MD4scrnHSQ@mail.gmail.com>
Message-ID: <CAD=FV=UindNjK4rWMvsMybgp_bPULbNz2A-u8x60MD4scrnHSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 7:17=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> > That all being said, I'm also totally OK with any of the following:
> >
> > 1. Dropping my patch and just accepting that we will have warnings
> > printed out for all DRM drivers that do things correctly and have no
> > warnings for broken DRM drivers.
>
> Can't we just flip the warnings around? Like make the hacky cleanup
> conditional on the panel not yet being disabled/cleaned up, and complain
> in that case only. With that:
> - drivers which call shutdown shouldn't get a warning anymore, and also
>   not a surplus call to drm_panel_disable/unprepare
> - drivers which are broken still get the cleanup calls
> - downside: we can't enforce this, because it's not yet enforced through
>   device_link ordering

I feel like something is getting lost in the discussion here. I'm just
not sure where to put the hacky cleanup without either having a list
like I have or fixing the device link problem so that the DRM device
shutdown gets called before the panel. Specifically, right now I think
it's possible for the panel's shutdown() callback to happen before the
DRM Device's shutdown(). Thus, we have:

1. Panel shutdown() checks and says "it's not shutdown yet so do my
hacky cleanup."
2. DRM device shutdown() gets called and tries to cleanup again.

...and thus in step #1 we can't detect a broken DRM device. What am I missi=
ng?


> > 2. Someone else posting / landing a patch to remove the hacky "disable
> > / unprepare" for panel-simple and panel-edp and asserting that they
> > don't care if they break any DRM drivers that are still broken. I
> > don't want to be involved in authoring or landing this patch, but I
> > won't scream loudly if others want to do it.
> >
> > 3. Someone else taking over trying to solve this problem.
> >
> > ...mostly this work is janitorial and I'm trying to help move the DRM
> > framework forward and get rid of cruft, so if it's going to cause too
> > much conflict I'm fine just stepping back.
>
> My issue is that you're trading an ugly warning that hurts maintenance
> with an explicit list of working drivers, which also hurts maintenance.
> Does seem like forward progress to me, just pushing the issue around.

IMO it at least moves things forward. If we make the warning obvious
enough then I think we could assert that, within a few kernel
versions, everyone who hit the warning would have addressed it. Once
that happens we can fully get rid of the ugly list and just make the
assumption that things are good. That feels like a clear path to me...

-Doug


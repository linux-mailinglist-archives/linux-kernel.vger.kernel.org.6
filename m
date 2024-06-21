Return-Path: <linux-kernel+bounces-225298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A83912ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B939A1F21937
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D95D1C6AF;
	Fri, 21 Jun 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IzAppRSZ"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719417BB1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002831; cv=none; b=Hig0llbDYKrfWjZPCD6pmkAnIHBnNuRFKb7V7MH68qWi1OZSq0uxmdMsAOB/eCgbVtF+QCFk6JliiC4IpGlapCw/xBnKFzG75H/dIDfW2oLLP2MkvDGJYeKLVCPUK5bMzzOCCBE3zhQYv86/Eg2vexw06jWR1uNxIvE+ywFK0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002831; c=relaxed/simple;
	bh=HRE+U2dgfJBzfQ6M8EvZDTIQ+wtvm4IcQYuk3+o/GOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIGtoOI9Qdur3cS5dmf4KRIClmLJlmgfKKTpUt40xLQC2px6vWwUCJxrTldmB5Pw/wOUc/gXBiebjqL1tj9ZpG7hL5S1dQvi8k6vDmWIMy7wnnWhnwOpGexMrK1naJpxRAdKOYQaSsgzj7tal/cw1onhi+8fTlsxI43eH/hZ6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IzAppRSZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2563792276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719002829; x=1719607629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vvcq6KNwg3xO4omyLiVP0kO5WMfy03mczyeSqWYQtY=;
        b=IzAppRSZCxQQd0LyMdTPMSVlR6QGhL1rKPG2JCf5B1hHxoKK4s8GuKah/WNuxuMNIB
         Zwjb+NIG/Hv22zJmuIY5AiSPr7MdwzsZoBt/Vocz49GLv5sgWA8Has3uhBA0rTvdx8+v
         y8HjmPtePInbC+r11xD7le/gZJ/ai3a3NdSuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002829; x=1719607629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vvcq6KNwg3xO4omyLiVP0kO5WMfy03mczyeSqWYQtY=;
        b=Vg6Qd5AmieeQbPKwlHdTTbmLKiXMWL/RTt+8WbZ1LFekmugPKw9V/JBP2HPNH6TKPv
         7prWMAGkiCxKN8AHPOxBeH6h7a6xFq+MS0CtjKxe/kRP5nX8enic73Esu58shcVGKGe6
         aZPqn+TXFOzw+WmHE17H/Kama8HcSuowKza+53+aWXucml8ODHz/q6N6P0LWBd0jRGxU
         I/FzyWZj2fG7sGRdcNerEC3lgl0xmkiBnBHyDy4ZntaIXco5axhLKeS4e56lSxUbg/Mb
         ylk3HF1qI5nxdE3aRXardEaWpVE7v6fC54LDEzgoJFbTjbqKFvlZB9aiZGddZkjIcM3u
         fo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqXaiblUJ2tnMMODIbi/VJomSjmfcv/H3NCzGSg7laLbmTMU/+jU606oMdIDHT3MX2BV9JM3Udjq7sWfOKTOLlq+HVOm5icY8tI7iN
X-Gm-Message-State: AOJu0YzIpY59KS2p0IEo6ddNWJZKxQne4W9k/F47FWj/6ci3vDJUmvvZ
	vpE6kDl4bvkG7Ie56fvW4Si4Q98fg9nRNKCwsd4ftn+skh5Fx0lE5cbJ03Zlu/xlZInKjpYE23c
	=
X-Google-Smtp-Source: AGHT+IEoomztpFh7m8IiWHpChsE6n22bjAn04yNrP0pk3CsQsw84InMo5JI/zdgTx2v3pu0SJ25eig==
X-Received: by 2002:a25:acc6:0:b0:dfe:73d8:4593 with SMTP id 3f1490d57ef6-e02be20b8ebmr10551775276.48.1719002829007;
        Fri, 21 Jun 2024 13:47:09 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed4882fsm12008886d6.52.2024.06.21.13.47.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 13:47:08 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44056f72257so536361cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:47:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXE3MG4vJ4UvfDeoalyxeE7IGCpETo1XI9dEQjukAwOkKv9CWQxFKjWIuhXQSHtvRwluM08NhnAOXZXssBzZ1Ez7EIlVejh4ZixxuxZ
X-Received: by 2002:a05:622a:38e:b0:441:565e:8d31 with SMTP id
 d75a77b69052e-444ce32b611mr440721cf.19.1719002828083; Fri, 21 Jun 2024
 13:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621134427.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
In-Reply-To: <20240621134427.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 21 Jun 2024 13:46:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VwebY8F3XjeVt6kvKwB7QZ8Khn5oJJoDThuemiGx9y+g@mail.gmail.com>
Message-ID: <CAD=FV=VwebY8F3XjeVt6kvKwB7QZ8Khn5oJJoDThuemiGx9y+g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 1:45=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> At shutdown if you've got a _properly_ coded DRM modeset driver then
> you'll get these two warnings at shutdown time:
>
>   Skipping disable of already disabled panel
>   Skipping unprepare of already unprepared panel
>
> These warnings are ugly and sound concerning, but they're actually a
> sign of a properly working system. That's not great.
>
> We're not ready to get rid of the calls to drm_panel_disable() and
> drm_panel_unprepare() because we're not 100% convinced that all DRM
> modeset drivers are properly calling drm_atomic_helper_shutdown() or
> drm_helper_force_disable_all() at the right times. However, having the
> warning show up for correctly working systems is bad.
>
> As a bit of a workaround, add some "if" tests to try to avoid the
> warning on correctly working systems. Also add some comments and
> update the TODO items in the hopes that future developers won't be too
> confused by what's going on here.
>
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch came out of discussion on dri-devel on 2024-06-21
> [1]. NOTE: I have put all changes into one patch since it didn't seem
> to add anything to break up the updating of the TODO or the comments
> in the core into separate patches since the patch is all about one
> topic and all code is expected to land in the same tree.
>
> Previous versions:
> v0: https://lore.kernel.org/r/20240604172305.v3.24.Ieb287c2c3ee3f6d3b0d5f=
49b29f746b93621749c@changeid/
> v1: https://lore.kernel.org/r/20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b2=
9f746b93621749c@changeid
>
> [1] https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&d=
ate=3D2024-06-21
>
>  Documentation/gpu/todo.rst           | 35 +++++++++++++---------------
>  drivers/gpu/drm/drm_panel.c          | 18 ++++++++++++++
>  drivers/gpu/drm/panel/panel-edp.c    | 26 ++++++++++++++-------
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++-------
>  4 files changed, 68 insertions(+), 37 deletions(-)

Ugh! I realized right after I hit "send" that I forgot to mark this as
V2 and give it version history. Sorry! :( Please consider this to be
v2. It's basically totally different than v1 based on today's IRC
discussion, which should be linked above.

If I need to send a new version I will send it as v3.

-Doug


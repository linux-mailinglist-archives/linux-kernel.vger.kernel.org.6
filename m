Return-Path: <linux-kernel+bounces-290841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B4955961
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DBE1F21C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDBC14F115;
	Sat, 17 Aug 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b="Gq0sTClW"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A227F7CA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723922636; cv=none; b=b1iiy4k2UZtbQZ8W4rAMCNvIfn6rqw+NYa7mCIepulJD/fH0jpCvPWVGkt/PTTKVr7gF7n+qkvLnhTwmf9pbgXv9/H79lnbg41pcHULoNSWa33wp25Dg2AjpiAvzY9uXx67MgCpjqmLFnPgqQ3FKm8Dd6nU7CXixyU0jBSSg7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723922636; c=relaxed/simple;
	bh=kFD57C+My3h1ivHtEWfkdI35wsZUfgnSclHTKh6Ywfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLtRIgL4Zk0DNGGpT4zJ7PHqNswOoY3jm/UieK6kRDpbeeCnreMoAQdyfMqcuyFsJbqnRIkW2fXjhGOCt3fHk4NfEnvewkWLRI5y7qshMfOawzcUvYA6LcFqh0kSzIaJn2clvaSWNawNh/clt/R3XjESS6JhgSz7piVDstvX4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net; spf=none smtp.mailfrom=howett.net; dkim=pass (2048-bit key) header.d=howett.net header.i=@howett.net header.b=Gq0sTClW; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howett.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=howett.net
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0e76380433so3148253276.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett.net; s=google; t=1723922634; x=1724527434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FyQINhQPCirsSYgI/BHpwpUDCbcDb6H8eZzj5rbq+c=;
        b=Gq0sTClWDDUk2W1mC7BhgPM0HDY6PQhl0ygBYHbczYI5yJ+cCVRC0JkCcn7jnYVZfI
         My0iikm2LJmjW3qW25u8JOu1NHfeMCtINYIFM59yuCFYAo497rwh1xEg5gOnLhYz1/gi
         dzaMTi0YxLV213ugNbnKA76l/MtacAzepGvQZJtDweTQfV+kuWvPAK3NrKRS5QuDkcs2
         8l3mbjmQs4cxHkSAsowdCJp/Lg3Gyl+wBROFCpqm4LuP3JwLUgCxloQoGXkm++aJMAcO
         aBcsNaxD9g4QIAZkb+s41wxKYFU38KePipgED5tTLo2LsQQCv9/+i8RlMiBfGWGTcIKp
         nJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723922634; x=1724527434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FyQINhQPCirsSYgI/BHpwpUDCbcDb6H8eZzj5rbq+c=;
        b=SWpYKrDFyhII0nJjvuFa9GTt+V1OJH6q6/rjvNFVHx7dW5oQDUbuSxWYuQLT6hGVM4
         RzpFR43/b39nVWUK2GX5ieDot/eUZapJIkYxUUuAXzL18SpBbz+1BK/+mnLTOnVC4iGk
         2cojpJZaU3qVa7roeHzTXgkZmJ49VI6f+6fkN/vm7Dz+vo1NnJL+7ZFQqlU66rWvyeDz
         p5rgNiDDVUfeYaXsXd1DTN6/xTcbYj7wGdCDfGXR5OdiO2oKW6Ciuoyh6l5PnMB7gBiO
         sfmtczeJ1njqITJ9Yi8ch02SvkRTmk+FhFfFGvrmhQGw3nXPEKCq83dOFrMAQNEi26dC
         oHeA==
X-Forwarded-Encrypted: i=1; AJvYcCWhc6ajMKd8UehPeGquyM6AYgg7GQ2UkY2QwEsDUFwTbS3YqV3O1iplgSo6GbanrpZOcQnkKu8PMmdHXYyRH+33C2p8VVB/93FvRtOY
X-Gm-Message-State: AOJu0YzXnKdvclYcuwKUceyz3ba6LEBfyrpleKDnlKHWfs7jDY2UU8Uf
	72JQbQk2QagA5n4LHsR/bdfgE5ETtSg7So+MYLNd+F3YcHk8Grc3O3Rr397bTvkvlKYyZgN7vKV
	WyAqN+4SysppAG/LbpL0+A+vcPbYarE9TviI0
X-Google-Smtp-Source: AGHT+IFxnlIgkFr84OeRJ8oiSVn8hoiYx79ww1a+q4oEMCPZ69AuUTfuG22NDtP+s0OqXkOHpjtpMUfOEzFvswWtKQE=
X-Received: by 2002:a05:6902:a08:b0:e13:83fd:cf01 with SMTP id
 3f1490d57ef6-e1383fdda45mr5567723276.49.1723922633924; Sat, 17 Aug 2024
 12:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-drm-add-additional-framework-laptop-displays-to-panel-backlight-quirks-v1-1-cfdd5dbbffc8@howett.net>
In-Reply-To: <20240817-drm-add-additional-framework-laptop-displays-to-panel-backlight-quirks-v1-1-cfdd5dbbffc8@howett.net>
From: Dustin Howett <dustin@howett.net>
Date: Sat, 17 Aug 2024 14:23:42 -0500
Message-ID: <CA+BfgNK9PEspi8=M2YDC4Kc43+JcEo2iej4Q2K7O2r9X1=X=OA@mail.gmail.com>
Subject: Re: [PATCH] drm: panel-backlight-quirks: Add Framework 13 glossy and
 2.8k panels
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
	Hans de Goede <hdegoede@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 1:59=E2=80=AFPM Dustin L. Howett <dustin@howett.net=
> wrote:
>
> This patch depends on
> 20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net
>
> I have tested these panels on the Framework Laptop 13 AMD with firmware
> revision 3.05 (latest at time of submission).

I apologize for the noise. I built this against Thomas' earlier patch
version and obviously did inadequate testing when he submitted v4.

I will follow up with a new revision after a little while.

>
> +               .quirk.pwm_min_brightness =3D 0,
                   ^^^^^^
This is clearly incorrect for the updated quirks infrastructure.

Dustin


Return-Path: <linux-kernel+bounces-548838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00EA549D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07029188588D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ED520CCC8;
	Thu,  6 Mar 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz0Th+Tx"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC020E32F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261234; cv=none; b=pcob4OTLnI5qcdALTmGSnOm3Fwe7HWDVjBnPoScA0oLdz42ydrziBB0z0sfeYb4pf903R298pRjK4mHOVICnng3m0A5lWoDT3ruDBdzM60TogZQNNNEmJ5R4BjPweld9+dcpYFcHJKH48t6wrWG/9+hUB3N9naiPPTffwJy7mkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261234; c=relaxed/simple;
	bh=5YMI/OzjR5RsRnri6W5HTmkHVVQUR2Welo2/x4kSA5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIG5785nmiclGVhN8ywFLlIxGjhEsAy6tos/DpJQ2P2Z0BOZ/uvihRpPz0kNObzV5E00gk+aP7ZIqH0/DIEjAccI0wfAC0sWOzPcclk6RLDCKqu7v+1dw0s45yXjMWAgsWXLuOeiSSSrpQG3ClpmlUj8tCTOlSWkIwjvFJ0odSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz0Th+Tx; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f422d6e3b0so159091b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741261232; x=1741866032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gOXYzq9nqcs8aHgZt+3uZFVTQyVn9buEBCz2wyHWs4=;
        b=Nz0Th+TxZ75IN3nomHaGBBv+2qpc1tZJ+6x4xRt1iR9V/PVZiqcIJJ7mPtitdJuZ/r
         Db2/rIR9mP22fE8Km3KBv6BpM+4FzCuZ9Bp+eeYaD/hav5E3c/CMgQoEMqCpCdFVEQGE
         mDStbkwQBO9wDSJhqyuxcqWa3Tq2TnFEd/AlcX4GIvGSDmUcW/Uw948uI9bazKI7JSTS
         1OatJ+EgephgxI5ruA/p0cHtEu22O8YhIYTa0UdwkQcH/l05LXvmNG9Vso5UBuQq1uSA
         Kq+pAy78H1C8hVQqc1FIZra9Rlmnb5itOz6GHQ/AkZd1qubw0s9cTcZm9VtH78P22xZL
         OdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741261232; x=1741866032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gOXYzq9nqcs8aHgZt+3uZFVTQyVn9buEBCz2wyHWs4=;
        b=E4DbEQaSOShvWX0jbalmwmB8a6xPPQwe4LR6jThGFTaruiqzsA7XKM6NBNK5sWSTBW
         22Fi0NVjXpnTMbVUs3106XPgTOQdYDo8OJi3eJN4lKAoA7aT6Fdg/fkz92BWqljOjqKK
         qjwUII/X01vHtyM3p+YIcRfGAUL/zpqqXql/p4lRnwDwAclrbhSMEHsk1F4xyzv32iTF
         H0ZXNMcIwErDrAlI0gIxMc8MDRbHlal/VrWuIUQazXE31qfjdiX+ABg2itd54dK0MmdH
         Kw7CfRl/7uwrqtZ46cK9VRD3scnHKkxzBx1KSHb7T4YykHa9VimWbibxQ7VuZ4qebUu6
         Lb4w==
X-Forwarded-Encrypted: i=1; AJvYcCXPDOA18guDYP0TqML4lk5HFZavI+LQmfUR/HQlq/2UTQsfy+er0RUQYwQgto6CniCtZTkYk4uc6OnZS9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPAOVOSg/ZPPImW5H5l+5dwlhVUYBNdB3FPQ7YsKqKY2qLRbJ
	klIUxmhO+sMXJ7yPHd5cfKY4bEquMDJ01Ywl6EVv2h8ZKj5ZM89Ee55U/0pNU9xPf7YfWz2tIW+
	51dHHlCCD9G6/t5utH/4edecjZBA=
X-Gm-Gg: ASbGncsTJZIx7zjF1dlhV5MSgNqsDdOtBmJDYsZhtiGubsDcibi/ZgXtyqU9PfvD/9z
	6ozW41i6E5xGOK2TUZSuzlEMIbgEm8cyxNu6RAInQWPhUXtnlU62BskLxVGDaiYHNe579XceTS1
	wxss1cxu6cmhfyP+AG4Fy5aFDJ
X-Google-Smtp-Source: AGHT+IEBHIhyO9+1uVVsz6t3TEe1SqOAcPgdQVGj4AVDvCzuJWAhsMw6GjuELn/dnLHLmMgNkrhRhzGAWIhQai37hts=
X-Received: by 2002:a05:6808:2e9a:b0:3f6:7832:77f1 with SMTP id
 5614622812f47-3f6831efa80mr3740715b6e.33.1741261232222; Thu, 06 Mar 2025
 03:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306112046.17144-1-i.abramov@mt-integration.ru>
In-Reply-To: <20250306112046.17144-1-i.abramov@mt-integration.ru>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Thu, 6 Mar 2025 12:40:20 +0100
X-Gm-Features: AQ5f1Jo-Q_unUYceAIgdIls3n-1TkFDSFuK08TpYbXPzRE5wm2xyWkPcAOXeLSI
Message-ID: <CAMeQTsZJp7AGYtcanGwJObFw=7U897biXvPs4xm-igCFN_6G8w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alan Cox <alan@linux.intel.com>, Dave Airlie <airlied@redhat.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:21=E2=80=AFPM Ivan Abramov
<i.abramov@mt-integration.ru> wrote:
>
> Since pci_get_domain_bus_and_slot() can return NULL, add NULL check for
> pci_gfx_root in the mid_get_vbt_data().
>
> This change is similar to the checks implemented in mid_get_fuse_settings=
()
> and mid_get_pci_revID(), which were introduced by commit 0cecdd818cd7
> ("gma500: Final enables for Oaktrail") as "additional minor
> bulletproofing".
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: f910b411053f ("gma500: Add the glue to the various BIOS and firmwa=
re interfaces")
> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>

Thanks for the patch
Applied to drm-misc-fixes

> ---
> v2: Update Fixes tag as per Patrik Jakobsson's observation.
>
>  drivers/gpu/drm/gma500/mid_bios.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/m=
id_bios.c
> index 7e76790c6a81..cba97d7db131 100644
> --- a/drivers/gpu/drm/gma500/mid_bios.c
> +++ b/drivers/gpu/drm/gma500/mid_bios.c
> @@ -279,6 +279,11 @@ static void mid_get_vbt_data(struct drm_psb_private =
*dev_priv)
>                                             0, PCI_DEVFN(2, 0));
>         int ret =3D -1;
>
> +       if (pci_gfx_root =3D=3D NULL) {
> +               WARN_ON(1);
> +               return;
> +       }
> +
>         /* Get the address of the platform config vbt */
>         pci_read_config_dword(pci_gfx_root, 0xFC, &addr);
>         pci_dev_put(pci_gfx_root);
> --
> 2.48.1
>


Return-Path: <linux-kernel+bounces-548625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D8A54734
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49C31636C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C071F4289;
	Thu,  6 Mar 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyzg6XLw"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3381EA7C5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255348; cv=none; b=X29hAK4UyuDqrXVQOrpQTkJB31i2v5EL3YZpn+sLaKMyUm40LH/9C8/BsJ0+ieVewB+13qg1MHI/ZUi+Pn1mZM35Ua/UhDYQ5uOqvwYIn4b0mimxpAdu+xGTygZSmitxF/RNQnBZesOfyebEgja9zFIlTsuOKo7V4rlpj8LP5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255348; c=relaxed/simple;
	bh=WBfnqS0S8f7OQxDKflJus4EO1fZci6/u+wznmscyMl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOhXftdlE3yyBE2DcKJ9co9V5WPPgENoiQsGUtkUKuW5uyKyXbm8+be2jmBvwzN/oMpGWePHfDq/0yz5VnhUMlg3jOEltidaj42tPR9OV2+6y5Y8ePNr2LVPYnak6691pkYTMj5JDo/WE2gWIRI7SOW6C2yM6VNchLJrMCT5tU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyzg6XLw; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f6740963b4so298262b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741255346; x=1741860146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjlyJFGbEZ5AGo1PtX3zO+4PQA4fvsT0t5eYe3h3Qgw=;
        b=Xyzg6XLwfxfpOknT75j7HhvbSxeLZQh2Qm1rdk8LZ2zAa8tDsnllmeUuM/diLl/78s
         16SHQQ0WyFIPPdMhMSxhnadYDqIhKWf/8I/3PdhgZfBOGwaisEPFZUYAg+hxhWajlkwB
         7miqZvkI9eYrjBPACC3sKhcVjMfhtMHnJZw36utg90OOFeBhMbvsoAWh14SMROX8lSlE
         RiyZOMgAOh77iJQU4hgpFojfbtKWuiff5fiGojz39rXWCd/vKhrN/3HLAchhrra6GgN5
         eNT2vHCZhWm5OGaD/HQOEhwfkgaUcbBrft0iiqPa1NeZjo40WzuM0o2uzzWKLdJ3/RPL
         NvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255346; x=1741860146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjlyJFGbEZ5AGo1PtX3zO+4PQA4fvsT0t5eYe3h3Qgw=;
        b=nQuGq+LqTfZqC8xLp4VStr5VCXmIgsx3+oybEO5jMF7DTx8AlSL61bZDl+qcqpAdur
         kL1/gAiCJsv2NJ/DX+zbwY6R/DjMF0wNpF2bLHfQ6wnMfy69nYs43jLIK41d9I4KH47Y
         Hfdnqx98wTxYYKOBXT0gxC15wSXoKtxXoXPr4DR7xDGEFwQdNgXwSww62pO6NQGVRTuq
         vM5pVIPCbZXzbcaA+c8jeaijO4zy2Iggz+Kl6OekucTezNXRFZG0KHIDH0/n1ZxNK7ZB
         t8yqmPquHTaYfOWTnIdziNfKs4K/yFjct4jwmlEwWZaDgIQYsvU3ferVGqARsM1mYkMO
         XbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu33Ccevh1zcLS17wjDWhjyWwo0N9YUv8FTs+Jw38hzQhiTFNgr9YqaeL17ZXElt04bL4EpkICZ/xu640=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTV6cBwtlRzzqHkCNxl1fxFUYzZgRO5Y94OnqSpJPNZubSmZ+
	IRbpjq+hYuB6sAxPDF2qSdNdnweAfJt5pc1dR24zkeBmB425Fa8Ba36Q/WRoNOfZ6ZiQTwbH3D1
	CR+k6pf2ICpPbuql+lOpThc7XxbY=
X-Gm-Gg: ASbGncv+N+4PgAPaWHDZmYKnb7wzRyjRuhI96Hien5m51QFk94pq2hkBcq8zA6gCS1Y
	IDNP7VUSHEzzgg6Pp/tuBefROSEY4r0hixWoLPylXHRcYoj0buOkMFbxW3WBMKNCPqq0K9OHZYT
	N6MJGrTESbbF2zdl0+dHm88Lgl
X-Google-Smtp-Source: AGHT+IGktwl8RHqxyYhUIgJi6CiDGuwav2mr9f9ZxPvSiuh2DPm3TXfAG1Nj1w++8u4AXmmRlftDeAZPpvCYOXbu9zY=
X-Received: by 2002:a05:6808:3a0b:b0:3f4:9e6:fd6 with SMTP id
 5614622812f47-3f68316d410mr4124510b6e.23.1741255346176; Thu, 06 Mar 2025
 02:02:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305112038.43852-1-i.abramov@mt-integration.ru>
In-Reply-To: <20250305112038.43852-1-i.abramov@mt-integration.ru>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Thu, 6 Mar 2025 11:02:14 +0100
X-Gm-Features: AQ5f1JrBT3mLoOQn49e3Z1XJM2wsj6BZo-pbHKXZ26bJSLKWAVr7Xp_R-lJsWXA
Message-ID: <CAMeQTsYVnBFiirGLKfG+pDt0Aagr0sjanPafKCygUou0s+iB=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:20=E2=80=AFPM Ivan Abramov
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
> Fixes: ba99d8348864 ("drm/gma500: Deprecate pci_get_bus_and_slot()")

Patch looks good but pci_get_bus_and_slot() also returned a struct
pci_dev so the issue was present before ba99d8348864.
The correct fixes tag should be:
Fixes: f910b411053f ("gma500: Add the glue to the various BIOS and
firmware interfaces")

-Patrik

>
> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
> ---
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


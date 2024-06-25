Return-Path: <linux-kernel+bounces-229564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87B9170F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DB9B241DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FD17C7CB;
	Tue, 25 Jun 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Auj+CpkS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D9143882
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342679; cv=none; b=N8zf+OWYaf5m6Ki/LRIaLapnOYMlvevGuX1/XnAU6lsN993bJ+hrh1SOag24u9yqTv+XCwvA9h7OzRcsaxZHjekpz4l9corJIxLfXCm90MjuLIp5SVHhDgqG9sZpHEmLpbXNblr6R5CeFXqtzIqTvYEpq5XnuYdgO9ZyD4FEtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342679; c=relaxed/simple;
	bh=QI2ST9zJnwwGQAo+/g0fq3WqKLv1e+CPcuPVWLbvMA8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K7xyNCCezqZflp/g/3xvlA53LBt/ZQGaWgjXNz9IWnODO/TYkkPGA+Qgq6GuvGfzqIilLkaHPVQClFoCs+cW+pj5C7o2NqqZyfQLwC4oh4Paw0cZi3TNCMWyR0innxO4JM4Xi4eW0F8BImPY3YX/qdGa+81OwEHVNsQpub5hEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Auj+CpkS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719342677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifx89QbqNTvqNTqVFeOnhXLP0jmM+ngsCZbnU659x1A=;
	b=Auj+CpkSJ049uMcdnVvUkYr9juYvveJvkP0bDF75Au51KGj/ZG6SNmUXeJkbE23ScBbwvb
	Ez2fl2+naJAFjfpxGTCdpu+DvlMM3pE8ZgNm1dfW/jobP264+UOEapj5LicSKrM57kByCj
	NRzB1UTTgZ6lE8X4vqL4nB+D0QM7/u8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-_lGK996NMny3S0E_SEv-fw-1; Tue, 25 Jun 2024 15:11:15 -0400
X-MC-Unique: _lGK996NMny3S0E_SEv-fw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b571da319dso13661506d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719342675; x=1719947475;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifx89QbqNTvqNTqVFeOnhXLP0jmM+ngsCZbnU659x1A=;
        b=VHUozkBhqV+6iU4vLdFgbJf6pQ0F4sHaslLeXZCQG5fCnzqqJjesXjXqRmOTL6bupW
         gmPboY4+rqCDvhQw33xLZC567DlYjqw244eSTc/MWWTCjyVUEoAnYtFB82QIkfq7vKyB
         xVooG/7c39i8kGj+mV/XKtBopYAEIuS9337NW6VusDTlYg8K1KzmeqB0MZBX8I0ARu7Y
         91dvn7qi7ie83cgfnPHzJiUYMl66CxaNo49CQqToCC0ehh5dwVAPgSoXnMOdncIH6VKl
         hUkFDBIWPm/equKTe2kleHJJ91q3gzddXDyToTloY1KXQjdWdTtZ9FVjmIzmxNLI2qn7
         qHEw==
X-Forwarded-Encrypted: i=1; AJvYcCXA9YrlAQ8/PBWRJ3eV0MxRsNMSpUWX2AAseiODIrprSxGv8sCTe64fAbAygbjQkHrdjqmVU/hcnRmNAREAkoGY2Z+T5uyXg0lYO8yW
X-Gm-Message-State: AOJu0Yywq3Hjv6eCJfoXzJxsOhOsHAH/vZ6Z5ncWAXM8WTabrcOgsKR6
	eXlWySZWrjrGXj8OuHWQfG1AJKbcUOlHuEoo41x+4l8kbmexiez2Suf2YSwnDoMZ55hJM2AtkwL
	GkhvSWOS3+545pLNwxU67C2MnbIvMLqa4RWB1ZcfgBokMZxb4NZXj4NDTHChcaQ==
X-Received: by 2002:a0c:ac4c:0:b0:6b5:101d:201 with SMTP id 6a1803df08f44-6b53bbd2640mr88923766d6.39.1719342674602;
        Tue, 25 Jun 2024 12:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6Jt3WC0d7hZup1taiuXs6wrI0vbXesfenzHXw1GMzzA+zIlNjhXPp/ZyUSjSvtzxHI6BjjQ==
X-Received: by 2002:a0c:ac4c:0:b0:6b5:101d:201 with SMTP id 6a1803df08f44-6b53bbd2640mr88923626d6.39.1719342674299;
        Tue, 25 Jun 2024 12:11:14 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef54a9bsm47185826d6.112.2024.06.25.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:11:13 -0700 (PDT)
Message-ID: <2020b1333c0f0be49648b81ebc4b55f3abe0a2cd.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/dispnv04: fix null pointer dereference in
 nv17_tv_get_ld_modes
From: Lyude Paul <lyude@redhat.com>
To: Ma Ke <make24@iscas.ac.cn>, kherbst@redhat.com, dakr@redhat.com, 
	airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 25 Jun 2024 15:11:12 -0400
In-Reply-To: <20240625081828.2620794-1-make24@iscas.ac.cn>
References: <20240625081828.2620794-1-make24@iscas.ac.cn>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2024-06-25 at 16:18 +0800, Ma Ke wrote:
> In nv17_tv_get_ld_modes(), the return value of drm_mode_duplicate()
> is
> assigned to mode, which will lead to a possible NULL pointer
> dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 670c9739e5e1..4a08e61f3336 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -209,6 +209,8 @@ static int nv17_tv_get_ld_modes(struct
> drm_encoder *encoder,
> =C2=A0		struct drm_display_mode *mode;
> =C2=A0
> =C2=A0		mode =3D drm_mode_duplicate(encoder->dev, tv_mode);
> +		if (!mode)
> +			continue;
> =C2=A0
> =C2=A0		mode->clock =3D tv_norm->tv_enc_mode.vrefresh *
> =C2=A0			mode->htotal / 1000 *

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat



Return-Path: <linux-kernel+bounces-173478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E08C00DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14DB1F272C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF09126F32;
	Wed,  8 May 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt+Fb309"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D838128368
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181730; cv=none; b=m0MQio+oYhvjH8iebKxJyqUoI/TWSSYOF0XHvZW0+NleGtwRug6T2/wcNzc90pIjFXzCkIC15vnmgaFSYaxAbbQ915feh33P7+JmAlw4OFcnba+zRIl1OiaWM0PFZ0udcwLIrpUSyTwIUNaufons0Lr9qsfoZRnpbylX/COQl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181730; c=relaxed/simple;
	bh=IeU+ikK/RaXL2dTlSwtTJbI5IL9t+dI2CSxMLaAcXE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzzmEohggOSw1yuFAYhklBzY37j04fLYOP3BhcCw/dMbHtmRfJhUkSbE653BiZbSLAP7tfb5EGQh7cqAH06bh3pIq64WOzmJX1kjT9OQtb1psKlezFHKhllOiZUN9kTu7f50PxRxclwzqMxK5SwPi1VbLabWMyO+4LnxjQoo0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt+Fb309; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0025EC4AF07
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181730;
	bh=IeU+ikK/RaXL2dTlSwtTJbI5IL9t+dI2CSxMLaAcXE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jt+Fb309/iI+lpQjUMK6HO4Ndl7xFjRKVgchaOtSqTsGOvF7Ry9F98HYxH524m3J1
	 XvBbvMtl/6CUHpOiNzlxF4vrJU6WdBOILET8vEQwGw3haop/uzs/He5whVG3+bynHb
	 HEARFz5P7bKLm2NdLhrH1ykfSRAGoVLJyLkgUn6xGJ+iH9t4lpfkroqEyY88IPqKbv
	 BZElBYzzpXhsFJ57mRGfng7fcIKD+LmRKbku14KIhRuhI8Nb9Wv/4G9/gPu4l4TOiS
	 Rmg4PWsKsPXHEwkgnKUPmxGqdbS3P29PocfxFuvujKf5ZomLoF3N/DTSqcnAYCQa+g
	 +af0885bslg5A==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5afb498d9faso1883550eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:22:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyF83QH4aNlicqstwzW82TJb5avS7gjliCKOPT+4c8LqjkatDtQnqhcfOoQS41gg0VJ/mh5wXfu8FGyq/NtcWjRJl6M261iY4HXO2f
X-Gm-Message-State: AOJu0Yw9P9RJZJsoAj/G6KEskb6nvwzoZIfSEcUZUbX4+UYH53wp7ALe
	8wi10bHpkr1+EgBB4Z0lSl7L9WUHpKT/N2+OhfC9hw/5RfptZq2ag/YVJ6lL/S51m5utiQmZKmZ
	hCAJtUi4K02aTao2vSFzhu7GfYRc=
X-Google-Smtp-Source: AGHT+IGjHQEBzb2A3WtWhJ9cAaHhTvD8SsmC4FBLoWmoQo8odbmOSyDXd3MvOug2Dy3zswo3tsF+kJr5h3reyQ1MRZs=
X-Received: by 2002:a4a:8c6b:0:b0:5af:a5d8:c445 with SMTP id
 006d021491bc7-5b24ca90b69mr3095826eaf.0.1715181729390; Wed, 08 May 2024
 08:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424181245.41141-1-tony.luck@intel.com> <20240424181532.42178-1-tony.luck@intel.com>
In-Reply-To: <20240424181532.42178-1-tony.luck@intel.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 9 May 2024 00:21:32 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0vVrrJTeUTvAK0NrWUqiVB7yqzmpYj4PvZn4w10mGSOw@mail.gmail.com>
Message-ID: <CAGTfZH0vVrrJTeUTvAK0NrWUqiVB7yqzmpYj4PvZn4w10mGSOw@mail.gmail.com>
Subject: Re: [PATCH v4 53/71] extcon: axp288: Switch to new Intel CPU model defines
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, 
	Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:29=E2=80=AFAM Tony Luck <tony.luck@intel.com> wro=
te:
>
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/extcon/extcon-axp288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp28=
8.c
> index a703a8315634..d3bcbe839c09 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -108,7 +108,7 @@ struct axp288_extcon_info {
>  };
>
>  static const struct x86_cpu_id cherry_trail_cpu_ids[] =3D {
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        NULL),
> +       X86_MATCH_VFM(INTEL_ATOM_AIRMONT,       NULL),
>         {}
>  };
>
> --
> 2.44.0
>
>

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics


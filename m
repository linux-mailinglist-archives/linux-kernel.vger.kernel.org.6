Return-Path: <linux-kernel+bounces-277894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36D94A7D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB21F22349
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960041E6723;
	Wed,  7 Aug 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lYIHgvXD"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6241C4638
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034345; cv=none; b=YcouH0T63V1n47Dh1jkjykwcceKUMreulj09XgrkLFaV6zmU9m1p08C9f48sqvCUK8ja0RuYzhCIgbIWYdodZ2sfVHa13PBLGqIko514KhIEdbZAAq4NbAP7+2gla0N+lYZn6KDJ1mNFYpn5RFtetLco6Ljzqbs5VoMuvtLg7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034345; c=relaxed/simple;
	bh=Mw6wKc2ti6LY5idHC/sVr+2dbNzF+B634uVPlEp2LKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlDj8O24e5aBZMlt/PevdAr3TEtMnhRhEduQ+LOLkAzik4p9U+ct/zjblALe1BNNr8sRgPI2Ytc/aaSwnK6O9PpyoYeKJz48Dq9FKTCUIpoTNvgNyysnz5e+R2Fpu/oZ4Vek2TcX4oN7efL1s8PBEd0CWpqkhRQ5bp7CYI3jMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lYIHgvXD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso1895595a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723034342; x=1723639142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnUFp98oxeUnctnSDs6TX1a8Wvygl0TqIj4jMlE8iGk=;
        b=lYIHgvXDRgOquolVGTVoQjBv4o29CzUrksbsJPFOF/B6nKhk/iKbBTdqjaBauIjg2e
         cKxlUXHQI7jN+/SUjGFJidOeUtU+a/Lrm595Y9v03c/qmZe3ebYUzVacPQiNsspAvgn+
         /Oskp1K6d9sZQDKS6kLsahgpyCpMTlkqWyXFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034342; x=1723639142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnUFp98oxeUnctnSDs6TX1a8Wvygl0TqIj4jMlE8iGk=;
        b=Uup+XJ3wSgIo9/46vS1M7S91hTOtlf292MkNC8MP2anQbE62j8cHoc4KOQcUfzRL/v
         Zq4f22QpPiF5xGXLFknh2PN1lH7+LZr+96qiO6fxT66scF8SSjXwo2f/+KtLFNub+Wrb
         tHHg1Qhn9HttA5nS7ALwJYCOX4ybRTAF+fNS4FcG2+7ZRao61NXBInLPEwjLBYs/epRd
         5ZPAONOOe0vqqGAMGpbRoE1OW0kXbqStWsSL2KAavH3Z/9WVL2E3leCZ4si6l+xHIIaK
         gyy0F76XH+kK6+lAoAb4RsreUhhPxHofRMppkxheWOlmrYgkALJpSQDPIOUzLOfBaxjR
         z63A==
X-Forwarded-Encrypted: i=1; AJvYcCWzSNcrqygialL0uzxuinErQLp18D/JraVxNrlOHCRta3Nvx3KSCFH9CMjSGpQ9dkyk6IW503P2UM1FjSketL5DG7tSb6xrmDvGQsr7
X-Gm-Message-State: AOJu0Yw/fvAQx4J2+BPnZ1V7AYCPyWZyV390HX5Dwr9qDhKqgfPvRStO
	hGNeGrdww7XM6JR2mJu2Q7F0SI6mwod0ThHbM8P/K/KsjUuyXUVxpq3eqsTHBu6pzn7JF/SFUA/
	fCRqQTPF3/w4KDtKiV+yK2y1mX4z+hy02qp32fg==
X-Google-Smtp-Source: AGHT+IHFwDCBsgcnW5WchVhEPgcMtyfiG3UZcQkJplOkeEuntHKc8WivmqlczosZUlA4ogqE5T7gtqDWLirva45IL8c=
X-Received: by 2002:a17:906:7303:b0:a7a:b4bd:d0eb with SMTP id
 a640c23a62f3a-a7dc4e8764cmr1344622766b.24.1723034342168; Wed, 07 Aug 2024
 05:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624185345.11113-1-michael@amarulasolutions.com>
In-Reply-To: <20240624185345.11113-1-michael@amarulasolutions.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 7 Aug 2024 14:38:51 +0200
Message-ID: <CAOf5uwkhThmTEuhYAxAgLqg86PEHJ49wWp67RahVhio=O2OfQw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/panel: synaptics-r63353: Fix regulator unbalance
To: neil.armstrong@linaro.org, Doug Anderson <dianders@chromium.org>
Cc: quic_jesszhan@quicinc.com, sam@ravnborg.org, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug

+cc Doug

I have seen that you have done some re-working and investigation on
drm stack, do you have some
suggestion on this case?

On Mon, Jun 24, 2024 at 8:53=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The shutdown function can be called when the display is already
> unprepared. For example during reboot this trigger a kernel
> backlog. Calling the drm_panel_unprepare, allow us to avoid
> to trigger the kernel warning
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>
> It's not obviovus if shutdown can be dropped or this problem depends
> on the display stack as it is implmented. More feedback is required
> here
>
> ---
>  drivers/gpu/drm/panel/panel-synaptics-r63353.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu=
/drm/panel/panel-synaptics-r63353.c
> index 169c629746c7..17349825543f 100644
> --- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> +++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> @@ -325,7 +325,7 @@ static void r63353_panel_shutdown(struct mipi_dsi_dev=
ice *dsi)
>  {
>         struct r63353_panel *rpanel =3D mipi_dsi_get_drvdata(dsi);
>
> -       r63353_panel_unprepare(&rpanel->base);
> +       drm_panel_unprepare(&rpanel->base);
>  }
>
>  static const struct r63353_desc sharp_ls068b3sx02_data =3D {
> --
> 2.43.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com


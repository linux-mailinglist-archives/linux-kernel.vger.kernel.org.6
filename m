Return-Path: <linux-kernel+bounces-434109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EDD9E61BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8092716415B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3280CECF;
	Fri,  6 Dec 2024 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srGA819H"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30310E6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443705; cv=none; b=gXXaYUfVROm5+c5zLki/icPEZBd/xuAUkgWUtAn+U0ACuPleOdKj8rymFixBF/lYaAeUqe7Yc5HIz/6kNBolmm1gskitQ14UK2aR3QkLvEqgntzht7GwekfxuTtp6SjZvLeRCHagfkEMn3HgxP0EVZCLwbAndL4Wqz4oME2FkYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443705; c=relaxed/simple;
	bh=wFPdTgfOGWkAoy97xgGZ2d/4NUke3YVxo76cMUT9rOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mibl0KK4ENX92k8Vl8qVSQ+50vEXtFsw7dMKPtFl4piTQWoh1dO1zLmAWAWQ0VF3FFG1t38e5f1pj0rlQ/xkv1GLnMPR4IcTU3XdRvgOCS5zmOogpJsYL8IwNCmaMegWBB1rvnZi6TzdZVCwI8FbePcE9lIVNbmatj0s/H5OrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srGA819H; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df1d1b6e8so1457507e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443702; x=1734048502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyWqX2zoZLFRt3ry2g2R9lR3izotXfaeTSy8KYkYq3A=;
        b=srGA819HN7daNwFw0P3ts+YefkxcY825IpcrPQj7GRZZh7WXCvO0DAvp1w0mtDqv9y
         cNJCfSrSp55zxhmmIvgewpSkurpRQCB70TCi+a2LSHNpd8/uame75Kc1qDkOh4rIBLsf
         iLAALvllWUUF7/jW16+452IrjnGfB5AeepkIeGHACMNrjoS+3Sh53u1SDE6tuHuUgZHT
         MEZHT0OupOIqwDQacjqo0GoeSS5wbxplxiCNNrNPRLqFeKRmYk1v6W2qZBqTPdVbgTL6
         svcncYbb+0Wdylmj/XZKhZ9rNWRdNT9JonHztaUvKx385GoKJe5jXdjXc2aTMPUMcXJx
         BvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443702; x=1734048502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyWqX2zoZLFRt3ry2g2R9lR3izotXfaeTSy8KYkYq3A=;
        b=TAEbnb83VsxDTZO/tlv1iUm587U3ryWL5tAOvJuZEqkJauEUdJcC8XsaVuHroF+qUi
         XDV38WFkg/+oJYPr/vCUA8Oxt3IEQ06T1JFz/YuBJfKU0/W3sszYAYGLVPG6Jwjy76Qp
         2BNUTzlN8kot3DGihBAGftPwIXClI7P2YzAGIhyTJ1sGx+9RkdSNJVRVbSMFMPAvd3i+
         luhRHoeJk2q4/9nfP8fSNGFOUnkWjdpBjR1biYzSo7ALwJi1Z1188cty4DBq3fx9Ko4X
         jDpJpVhiJZ6zemkQgUkGz108d5KjzlA/7zxmSpA+RogLQcdY5cajO5xcqFq9m1IuPWOD
         8nwg==
X-Gm-Message-State: AOJu0Yy32Enz6aBTZzobSONboKzuK/DINNbJsMYBupnJqaiy5pyi9iNb
	uS6vOUGPCnsN5OegG2QLmpHh5wyKqoXPiFhB05l67cQ/jXKh5TzfhpwtFjY1hz5hJC6oMZ/XQt8
	/CsCqeWS/mkGIqpUbAQzhQLldU9xJsUNaZ/JG
X-Gm-Gg: ASbGncuiqkz4GxThaB1NUbdVYl33DKlP1OfRHTp7OOF37NHjTHa0xkS1paIATsEq4+6
	0VtvQnPvVAdYwHEAfEL7EnckCLJAoxg==
X-Google-Smtp-Source: AGHT+IEl7P8g4C6biT8pMmR7TEmB0gJQnY7JWx1axpsFaCZBcd/5qdwTwlQeic62GJWu2sWz95sDRQrA+1CjugfgIXQ=
X-Received: by 2002:a05:6512:3993:b0:53d:ed68:3cfa with SMTP id
 2adb3069b0e04-53e2c504c30mr241237e87.55.1733443701768; Thu, 05 Dec 2024
 16:08:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221726.2247988-1-sashal@kernel.org> <20241204221726.2247988-8-sashal@kernel.org>
 <CAGETcx8bhzGZKge4qfpNR8FaTWqbo0-5J9c7whc3pn-RECJs3Q@mail.gmail.com>
In-Reply-To: <CAGETcx8bhzGZKge4qfpNR8FaTWqbo0-5J9c7whc3pn-RECJs3Q@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:07:45 -0800
Message-ID: <CAGETcx-6yHV5xr1j7krY8LShCF5JATX0NSwjeRUL9+3TLCMq9w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 08/15] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, elder@kernel.org, ricardo@marliere.net, 
	sumit.garg@linaro.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:06=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
> >
> > From: Saravana Kannan <saravanak@google.com>
> >
> > [ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]
> >
> > fwnode needs to be set for a device for fw_devlink to be able to
> > track/enforce its dependencies correctly. Without this, you'll see erro=
r
> > messages like this when the supplier has probed and tries to make sure
> > all its fwnode consumers are linked to it using device links:
> >
> > mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) w=
ith backlight-lcd0
> >
> > Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca459=
8@notapiano/
> > Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> > Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@goog=
le.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> As mentioned in the original cover letter:
>
> PSA: Do not pull any of these patches into stable kernels. fw_devlink
> had a lot of changes that landed in the last year. It's hard to ensure
> cherry-picks have picked up all the dependencies correctly. If any of
> these really need to get cherry-picked into stable kernels, cc me and
> wait for my explicit Ack.
>
> Is there a pressing need for this in 4.19?

I copy pasted this into several replies. In all those cases I meant
the kernel version mentioned in the subject.

-Saravana

>
> -Saravana
>
> > ---
> >  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm=
/display/drm_dp_aux_bus.c
> > index d810529ebfb6e..ec7eac6b595f7 100644
> > --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> > +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> > @@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
> >         aux_ep->dev.parent =3D aux->dev;
> >         aux_ep->dev.bus =3D &dp_aux_bus_type;
> >         aux_ep->dev.type =3D &dp_aux_device_type_type;
> > -       aux_ep->dev.of_node =3D of_node_get(np);
> > +       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np))=
);
> >         dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
> >
> >         ret =3D device_register(&aux_ep->dev);
> > --
> > 2.43.0
> >


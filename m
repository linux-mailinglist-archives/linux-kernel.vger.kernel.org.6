Return-Path: <linux-kernel+bounces-568078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBDA68DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F096D4240D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1F2561D0;
	Wed, 19 Mar 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTqYopc7"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112833985
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391123; cv=none; b=QxngQj1KnJTuooDT2KhbZPQ3rszgQA6uikX5I4msIp3HKVFtKoXuSmLOJASG0V7vNo7RJugW7GIHgHBbm5WT8RKvFzbeOIK1cM86gs7yYbFKXpmLV/LmrxXpQUH1hM362bWwvRmRNhBSn8PrVxsjTRUVsXpiVxBYvte4ElWp1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391123; c=relaxed/simple;
	bh=tYLY5I7sy2ghLhGzyztCalSEQmcUStJVayjcVJGngVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dx0u77viW9O7+F2bseVufPFUCrQizvmL8RvvZQTcEtKT0gV1UPxWuGV+Rtt8kkkhD+tQUT5SjiQWfN10VNn49Y5mTh17D3+jsFYzd0X9yjCYja0YTy1fRmJsVIMH3CWwKkG6c6jFtuo4w86qvluZnh/bvxwfp1H9uTsuYQYTfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTqYopc7; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86e48652bd4so27022241.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742391120; x=1742995920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGkpKqMgjBiSjviBn3MT7rNUCwz3YjW35rqjdwx/eQE=;
        b=KTqYopc7vZVfZ4xqBS5ScZt7wwwfPfqKZl1RFaDNEaQNcEezumdPO5ChH025k6cY55
         z0g2LVqink44F+ryuNhsVJLQDL70DH0Jwa8MaqXXgqKodWb0ylqMlYm3/dk5U1CoQbUf
         AZuISiml9uVNF6e5OJvIGHm4oQxEknS842pVwOcB/zz4D3BunhzqVF7EqgUbmqg5D9Iw
         GoCV61/uuGAxFtIhL918eSl2UnjVLjdtwOwcwW0EYcjW321EhVfZNbWWiTOrk+OJdvku
         YdMo1MHunNsMamqVisHgx26qwcsyceMLr1oMG5R9u2SZZ7hfyIu2OSd8caYzaplRLQCr
         nRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391120; x=1742995920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGkpKqMgjBiSjviBn3MT7rNUCwz3YjW35rqjdwx/eQE=;
        b=aiLODdKENI+MI6lroHfHTf6bb18y7M5VN0u2biv2r5VvXnhOVR3VsoCACf11sp7N5B
         VGdXCnedqdNMrxUR+sM+zQqVyTgfmtcWjpJVCSBQ4jgtEfOsvaAxEUaQBXDvtuqpNiIT
         QKthym4DlonXjbyPgkRmwMHxX084ioLGRz6hm9HWw+qTKlcNiK8WXFLHMX8gtE1qmbUK
         alfZ0V/vTRIl6mRUB/ojiVuap8esJ+9pNKRMoA9YrjNZx//X9jZYt3WfNMITzHd+st39
         I25pn0TbfKab3cnUevcJ2fSE3uYfNAIt2MelMxKrQ2t1NJuFsGgqqC1l6x0wk/7XlnSg
         tSBw==
X-Forwarded-Encrypted: i=1; AJvYcCVKQ9rFEiAjSt8hPxZpjdL8VF3okfOE8DNKtrLpby7EcphBbbr3YVdXm3EkmYSykGJEq0JGAlMHi/KVaOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/+CwWUBjR9+gcwxHMwgdXIcmmBNz+RNWeIRQyaFZ2f2bn99C
	HcNTfNy+RGhtK9irvZltyk7U9Jiv5uS59A0P/nKEh97aO6QlhiLIqq/wycBHiQJLapKg5ElZsDz
	2LkI7dalsCIFLEoU39hKcvtCXTq4=
X-Gm-Gg: ASbGncv6mqWaFby4HSfLTRHBHP/9eT/hyg3mEdaB4qr/yxN4v97jevH14Aygt+2SJRE
	a1PHL3zoOmOFPIBK3PELJaSeEThM2kGchvfx2iUnHomTvet2rQ3uQpaLauSpv/if/GYSNEP52Ce
	cxD20VIq9uC68y6o4MO8D2seD5jA==
X-Google-Smtp-Source: AGHT+IHgUH9cFzpBtBK9ey2+JGlYXkvPasHk/a/LBDDDziZJcfeOxGGk9HskojAVImQ7LiHzpzC9kHrE+Wtl3zLwucw=
X-Received: by 2002:a05:6102:512c:b0:4bb:dba6:99d3 with SMTP id
 ada2fe7eead31-4c4ef4d27cemr361182137.8.1742391119808; Wed, 19 Mar 2025
 06:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-19-jirislaby@kernel.org>
In-Reply-To: <20250319092951.37667-19-jirislaby@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 09:31:44 -0400
X-Gm-Features: AQ5f1JpyJz7Ugj_Qtpizh3Phb0sD4bkNclDSrU4JuLu-9pUF1cvpfLaSOGRYtu4
Message-ID: <CADnq5_P93d5TTPA36JB_RSGE8uRwoQQ5to7Wp9STD6xJrrMqdg@mail.gmail.com>
Subject: Re: [PATCH v2 18/57] irqdomain: gpu: Switch to irq_domain_create_linear()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:44=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> irq_domain_add_linear() is going away as being obsolete now. Switch to
> the preferred irq_domain_create_linear(). That differs in the first
> parameter: It takes more generic struct fwnode_handle instead of struct
> device_node. Therefore, of_fwnode_handle() is added around the
> parameter.
>
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 ++--
>  drivers/gpu/drm/msm/msm_mdss.c          | 2 +-
>  drivers/gpu/ipu-v3/ipu-common.c         | 4 ++--

I would suggest splitting this by driver.

Alex


>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 19ce4da285e8..38e7043016e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -725,8 +725,8 @@ static const struct irq_domain_ops amdgpu_hw_irqdomai=
n_ops =3D {
>   */
>  int amdgpu_irq_add_domain(struct amdgpu_device *adev)
>  {
> -       adev->irq.domain =3D irq_domain_add_linear(NULL, AMDGPU_MAX_IRQ_S=
RC_ID,
> -                                                &amdgpu_hw_irqdomain_ops=
, adev);
> +       adev->irq.domain =3D irq_domain_create_linear(NULL, AMDGPU_MAX_IR=
Q_SRC_ID,
> +                                                   &amdgpu_hw_irqdomain_=
ops, adev);
>         if (!adev->irq.domain) {
>                 DRM_ERROR("GPU irq add domain failed\n");
>                 return -ENODEV;
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mds=
s.c
> index dcb49fd30402..9d006ee88a8a 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -150,7 +150,7 @@ static int _msm_mdss_irq_domain_add(struct msm_mdss *=
msm_mdss)
>
>         dev =3D msm_mdss->dev;
>
> -       domain =3D irq_domain_add_linear(dev->of_node, 32,
> +       domain =3D irq_domain_create_linear(of_fwnode_handle(dev->of_node=
), 32,
>                         &msm_mdss_irqdomain_ops, msm_mdss);
>         if (!domain) {
>                 dev_err(dev, "failed to add irq_domain\n");
> diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-com=
mon.c
> index fa77e4e64f12..223e6d563a6b 100644
> --- a/drivers/gpu/ipu-v3/ipu-common.c
> +++ b/drivers/gpu/ipu-v3/ipu-common.c
> @@ -1169,8 +1169,8 @@ static int ipu_irq_init(struct ipu_soc *ipu)
>         };
>         int ret, i;
>
> -       ipu->domain =3D irq_domain_add_linear(ipu->dev->of_node, IPU_NUM_=
IRQS,
> -                                           &irq_generic_chip_ops, ipu);
> +       ipu->domain =3D irq_domain_create_linear(of_fwnode_handle(ipu->de=
v->of_node), IPU_NUM_IRQS,
> +                                              &irq_generic_chip_ops, ipu=
);
>         if (!ipu->domain) {
>                 dev_err(ipu->dev, "failed to add irq domain\n");
>                 return -ENODEV;
> --
> 2.49.0
>


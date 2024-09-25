Return-Path: <linux-kernel+bounces-339652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF3F986874
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9081C2228E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF484156F23;
	Wed, 25 Sep 2024 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUiCO5hO"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4E155C82
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300704; cv=none; b=qed+Rbt+23PFGMIgkUbr6etIhdc9Y1aOCvx98J8u88830yiv6rtE5dwDWxhgjiSa+UjlJYyInDEnhpk3EvExaOrqSNYq8nNUUogfJixuIZI0XSmKZBnQZMMbIbvZXwqddIM3MV6YLK9nZpxA+SszeCwlwZhQzeLXhvgGOlnznEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300704; c=relaxed/simple;
	bh=vacp2gesrGeLUYzUJSPa0DOfsXZ7AOv0ZiZYzfu0r10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSLVOU8MArU+9oD1kOOPGpfF4ldUZ/iZfzoEVO5sautgvMtSb0V2cmt5+BTt/CFoKuuYiSWAXHoxgEJ8TMuPH2+eZwzVE//lAEFm2JibaavobDye/IM/ZS9w86UBlDpMZw3e/e2wiRxJoZTkA+DRmjjHEn5QbRbsBqikoBBGEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HUiCO5hO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ddceaaa9f4so3344757b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727300702; x=1727905502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubPBBQVOHIfvcTIrZ3BiWyzlJHwV7im5oru7kaK9elc=;
        b=HUiCO5hOYtSXDRNfg/Q/FricbgoRLdf0q38upPsyR0qWwwhP0u5BHmL21flt9M+WG9
         o6AuDl1l+qwUgC1F1KPyJ4J7VSZSjCtR5wIQKGK/HRiNqJduX6Wu32+RrLngd/Zkm5Ry
         aa0mC4BbWioQM5sNVZVEFRFVsk6IiQzQRWc8wNf9aGJwdkAO+oWPTO2jytR8Np9ryTnM
         6l4s5+Xkl0K8lD6UDE3WSu3zPVxZvAimhcI7PtYiXFBTv2NmTs2imini0HupvzTTfBUH
         iR4ARB1RCNNkhwR3olV/Sgcm/teeHJvnXFyevtrj2Eucn27rsUXPfK/Fk3dZ2OUWhuUC
         EGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300702; x=1727905502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubPBBQVOHIfvcTIrZ3BiWyzlJHwV7im5oru7kaK9elc=;
        b=bHXZ86wOBzqgyjG6XaNxy6lgyGNlFljdRHmEO/T3mugWE9lF+o6BLU5HNPWtl1nqkj
         t6vkxRUfC8oZZqME/o6WFIz+SHJKnx2pV+cmyzeS629oPkygOxveuj2gnfirFlRkyH0j
         Q47lTpDe7GEMhMbFM1EOQyr5N232M4yS4bYJAR6+KpG2Kj7HrUrUR4RbuR7HqO8gZPN9
         wqSa5lA7h/byA9EzKVo+gsQ/KGmN3B5OVfQfS5AIMTPxBo/zX2u9xlxU9YRP5cQatPQb
         MYHzaozU+Ng3w/OnN2KWJ6/RAGMfYIxpnDzqKAAwWHUrPl+ZmqcGLvpgsg73WBlj/a+a
         EkPA==
X-Forwarded-Encrypted: i=1; AJvYcCWoLz4LlY0ud/KAScbECnxhws95ebJ1T/mPts2UtPk9WIorknkYOpl2DbVo7DA+IlJQ+ICwqLHFisuTh88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrszJo64n0Gu9R1KAktg95jArgkYOjIgQOTAfiM8GCEM0SWAy
	wR8KhUNZYY/NxxX3Yj9mk0O56HCAgKu+j3rDAXxSpDa6IkUQcLE38NVZk2ALdmbjHQLSXCRwBzF
	wj0XvBmioMiXF2QMz2Y8AZRO+pwMd9LSIFNYh8w==
X-Google-Smtp-Source: AGHT+IE/SrMUOY+KWSLW5zk97MvQ22eIeIEKxGTbZauRUyitZ1JC/rqr8e4DxLrrb/cew8JOD5gC1mS8SchEsDjXfIM=
X-Received: by 2002:a05:690c:89:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-6e21da002camr36163757b3.32.1727300701758; Wed, 25 Sep 2024
 14:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-dpu-msm8953-msm8996-v1-0-a31c77248db7@mainlining.org>
 <zeek3j7skstysho5bduxn23xipz3fpqsfwggue66dlyozhepnn@4wnnd7q6xf22> <e69b07677ff786e35a5904cf1a455851@mainlining.org>
In-Reply-To: <e69b07677ff786e35a5904cf1a455851@mainlining.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 25 Sep 2024 23:44:50 +0200
Message-ID: <CAA8EJpoDYs2v=1=c9+APq-H+mm-xifCy5WHBgziQYROu-kKE5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add MSM8996/MSM8953 dpu catalog
To: barnabas.czeman@mainlining.org
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Sept 2024 at 23:28, <barnabas.czeman@mainlining.org> wrote:
>
> On 2024-08-01 21:25, Dmitry Baryshkov wrote:
> > On Fri, Jun 28, 2024 at 04:39:38PM GMT, Barnab=C3=A1s Cz=C3=A9m=C3=A1n =
wrote:
> >> This patch series add dpu support for MSM8996/MSM8953 devices.
> >>
> >> Note, by default these platforms are still handled by the MDP5 driver
> >> unless the `msm.prefer_mdp5=3Dfalse' parameter is provided.
> >
> > Could you please provide a summary of features actually tested with the
> > DPU driver? Have you tested YUV output? Have you tested RGB planes?
> > Which LMs have you tested?
>
> How can i check specific feature?
> I have set echo 0x32 > /sys/module/drm/parameters/debug
> DRIVER+ATOMIC+VERBOSE ATOMIC log is pretty verbose and big this way.
> For lm i have found this kind of message in log: [ 1027.577132]
> [drm:_dpu_crtc_blend_setup [msm]] lm 0, op_mode 0x2, ctl 0

I think the easiest way to test other LMs is by temporarily commenting
out LM_0 / LM_1 in the lms array.

> >
> >> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlin=
ing.org>
> >> ---
> >> Dmitry Baryshkov (1):
> >>       drm/msm/dpu: add support for MSM8953
> >>
> >> Konrad Dybcio (1):
> >>       drm/msm/dpu: Add MSM8996 support
> >>
> >>  .../drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h   | 218
> >> +++++++++++++
> >>  .../drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h    | 348
> >> +++++++++++++++++++++
> >>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 106 +++++++
> >>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
> >>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +
> >>  drivers/gpu/drm/msm/msm_drv.c                      |   2 +
> >>  6 files changed, 678 insertions(+)
> >> ---
> >> base-commit: df9574a57d02b265322e77fb8628d4d33641dda9
> >> change-id: 20240528-dpu-msm8953-msm8996-5d0fb7e387b8
> >>
> >> Best regards,
> >> --
> >> Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org>
> >>



--=20
With best wishes
Dmitry


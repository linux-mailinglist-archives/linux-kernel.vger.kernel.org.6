Return-Path: <linux-kernel+bounces-211878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19C905841
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF7D28C9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD033180A8A;
	Wed, 12 Jun 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVfDJhjR"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCD20315
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208929; cv=none; b=sMlaag1DDB+GN5Do7cI9JioHJl2386sz2dsatRRGB2G1JORT9fQA7nNtnMdfSmz1ANpNn+Vvr8KReJUjN1vS8tdsneQe0GR2JRcGe0+QWPD8MJSg7WPNLnTg9y4zXXrR5oWTcfv55SfCRaFRvcEnojaLAmprK4xhWSCXzcLVS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208929; c=relaxed/simple;
	bh=5cmFbegrmXFBHS4WW8ziIwGksQiKssUPXoQUtXM6F24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tH87rrBqrZ85WCjez1c8qYfHIDktJ/RykscIIxHTYs3Nm3UGNFTqKZFeuGjjHTnPlfgIrENtCf/S0K/Lc2m6vP/yJeoigKuytpibWTpKTQNLxYk/myZzZtZRHbh+PE6wjTJjiGh7cpF3gyvJX0BmsASUsD7i7uIfoX2z/xWk+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TVfDJhjR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-63036fa87dbso154017b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208927; x=1718813727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cmFbegrmXFBHS4WW8ziIwGksQiKssUPXoQUtXM6F24=;
        b=TVfDJhjRFIG31EjhityqLqrplLVj2w0OrUk6DLEMCxcCj77BrZRwjC/NU0/k7A+B22
         2NH8mZCr2uC6Plx0W3R4axFfvJPAzYEKUSmZOo2n00SELZ3eU1z47vcGV6a3vA/V1mXz
         00Y6ZlnaMffhVyJ3NvOCS3XxJDjNToY3c8gpRPL66kIa2ZH1GLLZKiNt/rAYDSfBiKo6
         wumjOQ4qa9lR4FXyJ6d41iAmwfAnjgMdGAz4Lq4EsCyAAY3rE1bRnv0rcQlt01Ir9aE/
         Xv5TWhgAEEg/HywnDvhRfSq2RmJLSiuzWga8lqOy4se8/D8ZrW7naiSHQXD7VUfxDZ9E
         Ae2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208927; x=1718813727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cmFbegrmXFBHS4WW8ziIwGksQiKssUPXoQUtXM6F24=;
        b=FR3CfjWa6HyGd/sKh/H5wgoRAaL5ralrRvsiW8Wuw/8tCH51RlqYjhgzbQfaxN1X59
         3bfjlxVkDqTo8qCY2r16Lm5cuYPQlboKS1njetolP2ocNkPrRJxRSJ+6odjpSOgEWxxK
         YwcBjqnihL2R+1oj6ub3+KNaPEkbSqQ7wAo5fqIMtFJKJTVoPGiewOf1M0AfYyKB/l9m
         cSNXA4ZWm7aTKb+kiBDSFztoadX2PjzxPOJGfhVwTG6+R8L0PqKg5AuyN/dWrBiq59+g
         pFK8D1uiyG5pvyGmgLWH8rIyzlPOZFIoebOy8HWSh4V41O0Rz5QOjo0aR6QCFv8RwxuJ
         BgUg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5ZlFoCZRpDUHSvr1SUzqxRx7kJJoiclUqaPY8hESlNvAF78rnChff992KQHNDHHztI2rQo1uZct/AALdZp9czJh3doJabgsQF4AA
X-Gm-Message-State: AOJu0YyYrjdrhiU5nxkwn6XBeW1bpdDe6cUnnLARp4lsZkivsSkrbY7z
	hDdv+e0xNPshcxq0ESIU3yuxBkX6IkKYV6AnxXT/ou7Bx4PYKVKAtcHrOitSaZzeUAVbCfROtVt
	JLXE71UDp0HR/7Qv+wYLMzKXEQzF/4WUc/tp7zg==
X-Google-Smtp-Source: AGHT+IEyUjk336q5wze0GKQr7UwMqrUsrkoBVG2K5Qz2pv15hllZ/Fn+1uT5B958G0aEQ/a+dPl8Ea9AwDS4xrJVWhE=
X-Received: by 2002:a81:4806:0:b0:61b:f6f:eab with SMTP id 00721157ae682-630bc30a68cmr838027b3.2.1718208926557;
 Wed, 12 Jun 2024 09:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-fd-hdmi-hpd-v2-13-c30bdb7c5c7e@linaro.org>
 <deaa2a50-9e16-4f23-8c13-34947ba4e4e0@web.de> <CAA8EJppn_mVzmd==-bs8je8VjXrNrWu0hNXWAGuP+TP3DARReg@mail.gmail.com>
 <1cb42d85-2eb6-4544-b4ea-8a75416cd287@web.de>
In-Reply-To: <1cb42d85-2eb6-4544-b4ea-8a75416cd287@web.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 12 Jun 2024 19:15:15 +0300
Message-ID: <CAA8EJppXQ4sMsm+VXnJdjYa1g_U8_LKwRL_u86DsF6Up4rnaqg@mail.gmail.com>
Subject: Re: [v2 13/14] drm/msm/hdmi: ensure that HDMI is one if HPD is requested
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, LKML <linux-kernel@vger.kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 at 17:32, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> >> Would you become interested to apply a statement like =E2=80=9Cguard(m=
utex)(&hdmi->state_mutex);=E2=80=9D?
> >> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/mutex.=
h#L196
> >
> > I am not.
>
> Under which circumstances will development interests grow for scope-based=
 resource management?
> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/cleanup.h=
#L124

I consider guard() and free() to be counterintuitive, harder to follow
and semantically troublesome.

--=20
With best wishes
Dmitry


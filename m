Return-Path: <linux-kernel+bounces-569831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E079A6A80F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7DC8A535A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763E221F12;
	Thu, 20 Mar 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nphV6ENY"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2B222560
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479822; cv=none; b=pi/hZo3XZKXGqBKnQrrw368NLYKFA9guurIOUICts2zcFvU2/NkfPQ4rKPKM06y7qtAJ5tdVqIKvNVY69PlM+OOD6AM4pgEytr0ORX69lL0rXohrVZ64ObUH5KPOxu/lm7qCXUan+TVWWNiXIqCbIZU0YlCELzuoeJ8xDPHeNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479822; c=relaxed/simple;
	bh=s9l2NK29FWKMvXALTznvduzAySe6UJPpHquolLsiQd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1/YTV6W4Me7gPZiUirnP1YuWu3wPSHVQ53jVBDaFw3y5aRfHBl/tefpjR+MmC+/GqUXc0C2x1HUA2Bh3Ftn0oizA9EgUboYYK3cH9JdBfZG7gJ5wKuUMavzB1e2P7ym0zeINogB4RyONOnSz6dJIBFUrjl8cQN3XyTNxAqu06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nphV6ENY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5497590ffbbso969903e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742479816; x=1743084616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9l2NK29FWKMvXALTznvduzAySe6UJPpHquolLsiQd4=;
        b=nphV6ENYrgnbfy+lHeH8BVyXmRW6o5ivi+8Y/e1vSZSlsS4gkO4nuRWZUQuem/Nsc6
         dFCaO9KK09i+dbvPBFzM5rLExfEJKjSmrWG4diCLrMFZeuzZ4EGHeFx3UaXTdScFF6BE
         sh4XzRhLurz6ouuDO6CgVxubO7RCz8XGunLQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479816; x=1743084616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9l2NK29FWKMvXALTznvduzAySe6UJPpHquolLsiQd4=;
        b=jPcvST3T4s+nODEFcCj8JsDa7WEqldIOUG828TwNAtzrVr3Aw6Wzl3SO+1C7SvcgI6
         QH0h7a0JtSIBA+ymRF7HDuEmp8k5qk4pzgxTCJ+meSNR/702pMtbfkS23CeKPUo2NOPS
         FBdJumP+W5pY9CJ8epkuGgnouR0B7NzTpjwmPGh1gw2kO8MgD5p5tGcSl0npq8jrGQYi
         J/sLkXQFMb+pX/1hDoSHcv5ycJixqCABIM74cqUv4h4y2Tu2LO7IzlNKCVWWBfQcTYO0
         39TcuTyr3oX/2xfGr1TkonzuoM5rQWoSTMnDVut+q3YLn2LyCWKtPPZ+qwtOIo5+X0Uk
         MtOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBNyCe/rO/W1p2tZrAqTW1D7sVPPV7zDcs6UGMvcUaF87cy/S+iemU55Nu3ukToC2cRh74J9NC8xkd0SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIg8csi+ljDOyTscFuTW8MFsKXMq/Bmvgqzip8B0JVMmt0vfJ
	Kk86EsGOnchnL76qac8ZVN/rYqe+ZOmiokdiRbSXv5u1NSSOXOfBgu1yEsWEhwt+s2vnMZB1miV
	EZw==
X-Gm-Gg: ASbGncuLNqH34nV74dh7/HB9U8WlqOWmKvB9K4bftLDr1ixK3vy7DT/kM/c7EfC0ozR
	/k/CttZFRYQmKI4OnmIxOMkvCtdvRW8gy4Oi6MHikifbxJCmolfxYSYZty+p1F6XG8enjxwxlbp
	FT1Nj4cqexUtnZn4X7lxN4s3PFKq3skxc92C8V/ZXiePWaupBtmHTd3+MenI3GMg1krpJoSvGG9
	1acHoHJd4ziaujQvqADxqmC8v8Fmtkx4thtgw4Ofm8sUCJTRw3pkBlYc4oMXndTh9J45Cl3xb5O
	cFAT4W/bVXmWvN+5FYGRjf8qL+Q2gv09j/hqtYY6NFECQ+dZ3GChryLXaeFgJFB55wR78ETLfYB
	TpXyb4GYl
X-Google-Smtp-Source: AGHT+IHrdH9csnks2ze05K8vLCoLsBIHOg/dHroXkILZG+xYlcwB0Z7S6C/ntlcSL6QUtb6DT1WJwg==
X-Received: by 2002:a05:6512:2351:b0:545:2d4d:36d1 with SMTP id 2adb3069b0e04-54ad062b410mr1241659e87.20.1742479815642;
        Thu, 20 Mar 2025 07:10:15 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba885982sm2234235e87.192.2025.03.20.07.10.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 07:10:14 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54298ec925bso1391917e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:10:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5JtRgqV5l5AESz/9743qrdOxAsN24/qW53TmKYVXAVKaLbUgdwQmUPbpXuA4wyP+HAwRbH+PjmgwRvvo=@vger.kernel.org
X-Received: by 2002:a05:6512:1312:b0:549:4f0e:8e28 with SMTP id
 2adb3069b0e04-54ad062b20dmr1419150e87.15.1742479811664; Thu, 20 Mar 2025
 07:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-wip-obbardc-qcom-t14s-oled-panel-v1-1-05bc4bdcd82a@linaro.org>
 <zgzivcjcygbi272q3dmkff767cb45uoffwtx37ij23pi2g5ubi@j5bxjdbgqaqz>
In-Reply-To: <zgzivcjcygbi272q3dmkff767cb45uoffwtx37ij23pi2g5ubi@j5bxjdbgqaqz>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Mar 2025 07:10:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xn2cEKQ+Uj5Okemo4_RJ-1uJ_SQ5X5TycJs5bYdNpcBQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqCwIwBUwu1Y1sQAJLBekmg4FIUOmSSxOrj8jLfvkFWDtf9gs7NC20D47E
Message-ID: <CAD=FV=Xn2cEKQ+Uj5Okemo4_RJ-1uJ_SQ5X5TycJs5bYdNpcBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel used by T14s Gen6 Snapdragon (OLED)
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Christopher Obbard <christopher.obbard@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 20, 2025 at 6:47=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Mar 20, 2025 at 12:47:09PM +0000, Christopher Obbard wrote:
> > The Lenovo Thinkpad T14s Gen6 Snapdragon OLED model has a Samsung
> > panel. The kernel currently prints a warning due to not having the
> > correct timings.
> >
> > This panel appears to work with the default conservative timings,
> > so add the OLED panel to the list of supported panels with default
> > timings.
>
> Are you sure that this panel can be handled by panel-edp.c correctly and
> it doesn't require a workaround implemented in
> panel-samsung-atna33xc20.c?

Yeah, I'd agree with Dmitry here. To the last person who wanted to add
a Samsung OLED panel, I replied [1]

It's much more likely that this should use the
`panel-samsung-atna33xc20.c` driver, which gets the timings more
correct for Samsung OLED panels (there's an extra GPIO it needs to
manage). To use that driver, you'll actually just need to need to add
a new compatible and use the existing one as a fallback. See recent
changes to:

Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml

[1] https://lore.kernel.org/r/CAD=3DFV=3DX+WnSKZTFhzdXEFfpKCEqfPDc77h7oG=3D=
ZU6Nqq6XHOmA@mail.gmail.com


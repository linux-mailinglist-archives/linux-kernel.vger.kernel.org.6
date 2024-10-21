Return-Path: <linux-kernel+bounces-374633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7949A6DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794021C21052
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665A1F9410;
	Mon, 21 Oct 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="lHr5zkK6"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912A1F8EFC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523627; cv=none; b=mMoQ0T48/MXmcumf/MKnAdzgdLKYH91a9usuPpq0YA3Ka8M9ptkPdJg6eihfUl2RPQEHeRcPBpHE1cOTI9zY/4bt4qXBcU30jbCY8WnCi7NePCBxOVeEV/BJgM1242HFOQKCe22ChXgrO/7OFycBUQ+Qot1lQwSMMJoZ/1O4N2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523627; c=relaxed/simple;
	bh=N6JodVTDxgJRvW8Z4glRLSF0rvxjh9HrccAUx4YttWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvTibVy65ai3fnV9i3jFosOlto4+3iTGtE5jhXoM75qbmqSFu8kQXnqquG/DgN+7Fw9CWp4QjdT9p4LpfcPOAQt4bz4Poj6Jc2WazkfcNT3IyhvqziDfygbg1qfZ1WtWV7X2qf9U3CeieaI56ZqPOunQDc4g0foG404y04FvEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=lHr5zkK6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e59dadebso5828597e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1729523622; x=1730128422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwppW5KGzHko9Zrh6awJ4uJN4mUN1akho9LTmYz6AB0=;
        b=lHr5zkK6s6gVMXR1AJxIVeffzJz99pwH7y2kXzMhnarB/k9a3wgdm/vtAg6H/sHYL9
         IKUn1k8H6sqKKVBJ8yaSI0RC4VX0fLK1bzuPAjBMFPf8S9ZiXF9I2gGlbJTmqoSdCi0E
         /4AnJoSfLVgqrFZEuJFqAACtvsSn1eJHIichL/7nhlOozIIG6XttGI/iBpNcAd4AXxr/
         CP0Uw5PBFymK60fKrbr5W1XuyLSyizobAbPr3YuC6gNMmXIgNmPRfJ8jnxx/Rojt7Gh1
         Bz9/xs9AuwzDtcep0QfqGutHT4/w+JNQESlVVSjJJfruy53h0m3r4VEDVIJCgnRCklvO
         GJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523622; x=1730128422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwppW5KGzHko9Zrh6awJ4uJN4mUN1akho9LTmYz6AB0=;
        b=nLltWHPBZGbr1T5B2DB74MqvSLtNFvwcx93L2wbIsEv51HpIL3tUZEQqE/iJ0qw2o3
         NJG/GhOTopFl0qQVwQB40Ny42aEZbPpeCsGxxoGakssxSPKaMwA089hTe4vgQUndxDlJ
         L4MdLK1+IuUwBKFBD7Cey9Gd0yZct84jv/4TUEtAeDdvIFgLtwkDrapJ7eUo2eoqJecu
         WsqWH0CCpv3Y5toQr6tMZb29fVeJVAyof1W7bv73ODvpD7XQDo04NbN+BuyG7bq/t57m
         92s9uZbIcjJobG7qrIrahE+EquAXuHfuoEKy1VM8mOu55JTK0ZX1vRW3uRx/V5ueF3X+
         A3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVKdPUOiWk21ksD9E//2T/E4reTnL5gUXPTnLcRB2vfu2eshmg9rYx6EWvdVf/wAi4C5/b74EXS1FkF0rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LLLfWgRpkaxPxwwev6Xq+pTgnM1Ua33rAKBPJwu1xs6DqkzR
	TAcbXZ//nO8xOYGORiSUI2jMfkPTBzUTYFpTOPs/5qhdxGUfWUiG/T/B1BtGHGlj6Y4D71IxtzM
	CXFAnbGCm5mLVXhfVoqqIvgdGV8j267dae+WI
X-Google-Smtp-Source: AGHT+IFg6sLaPCI4+zu29tq4MBdGk5PGlOsywwq2DfZr8M/tfhZqy+/Jp4NatrckxdCornEORL50z19tm6KxCScHtbQ=
X-Received: by 2002:a05:6512:31ca:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-53a152199e7mr5802225e87.24.1729523620475; Mon, 21 Oct 2024
 08:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com> <20241021-tidss-irq-fix-v1-5-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-5-82ddaec94e4a@ideasonboard.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Oct 2024 11:13:29 -0400
Message-ID: <CADL8D3Z=4dx5B4YdA_TD-900tnTm+Ev_ar+6CbaQ7iV04p9B0Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/tidss: Clear the interrupt status for interrupts
 being disabled
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:08=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> The driver does not touch the irqstatus register when it is disabling
> interrupts.  This might cause an interrupt to trigger for an interrupt
> that was just disabled.
>
> To fix the issue, clear the irqstatus registers right after disabling
> the interrupts.
>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> Reported-by: Jonathan Cormier <jcormier@criticallink.com>
> Closes: https://e2e.ti.com/support/processors-group/processors/f/processo=
rs-forum/1394222/am625-issue-about-tidss-rcu_preempt-self-detected-stall-on=
-cpu/5424479#5424479
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> [Tomi: mostly rewrote the patch]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Thanks for the updates. They look pretty similar to the changes I
proposed and thus look good to me.
Reviewed-by: Jonathan Cormier <jcormier@criticallink.com>
Tested an equivalent patch for several weeks.
Tested-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 99a1138f3e69..515f82e8a0a5 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c



--=20
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211


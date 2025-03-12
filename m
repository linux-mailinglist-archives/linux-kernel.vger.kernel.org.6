Return-Path: <linux-kernel+bounces-558602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4018A5E87B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB33BC4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35A1D79B6;
	Wed, 12 Mar 2025 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZ9RTSQm"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA81EE7BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822534; cv=none; b=AuePPaLyOQZ7gexZFpCylfC4G2IqXeMsgTOqldttpChX2e8m39J9M1mSXWMyKq3wCAjFOp4nvLsZv1S8R1WbhEBfLcab9mmbFvOSQv4tgAnFOnm3KI3GvzcAnayWwm2mAmcKUotU1BQFFtJLFj+vVmT4l/EygZBLShurhEbb5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822534; c=relaxed/simple;
	bh=8r6O9wvu7EU3rj6z4hH7ur3ViykPCapUPGXcVwWMHwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKhqgpQEh/XhWy5OZz/lV9rAmz2QUar/JD7RvgcLRPMBTvdJ6UfB7BPLEhYAF6jgvFcDSUxRzzV0F7SOvZaFfBW+yaQ5H30rrv3yJsRHPLCBOB9KpNEQVzLOpw4zYq+MmaoEF5QQV/hhCgfcLK4xfCTclWqalOVxLRcDb8ZJD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FZ9RTSQm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30b83290b7bso4134641fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741822529; x=1742427329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jas8knot96toCrbIGWSDIcYpL+AdR9dGKrMNFDxG4LI=;
        b=FZ9RTSQmXymqj2BT8brn2AQqAirLgRREob8nXz4VxXzVBOXhPJTUqkudLySg3a4CQj
         TyvXO7ezKEin+B28Dto28M6vjLA2lAdLLQMmhcb9wrbf7YnEDWlwfyBwP/GI8rvdA6lv
         qs85kJLR074ukLZpdhLYABRNYo6sV0k32b1NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741822529; x=1742427329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jas8knot96toCrbIGWSDIcYpL+AdR9dGKrMNFDxG4LI=;
        b=iZyppKA3gkylCv2T2F4z39hFHjxpOEWGaSgz1jDFByhMwRnUhjsC46LOaVGcYpEk3d
         qhnbxjG9K6gFBICRfuY/htjSScgXE9Kjo0buvVKnrbKjdsK6UnGZGYoJcL97SrF8RJKL
         +SDd5/jZmbvcBoWyuiXjd66M2ch2yby3gQnytmjzIysDB2zpnhPEMAYpguDFO7E6vgyY
         q+IAKA8ZZPgY+rdzj9L/vpXEcdF2hPaiTg0wg03+5EWcWwmb6er1NzcuIikmGbVfeQgf
         HMD9U5kncVhIusV3iOGkPl8VeaTvANXOj7Mzxtm2/WhaHLghBK0wqEEIN2U5Zjy3PFiu
         8vZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM6s3ucbjdIjo1ZnJtvH0MWxePC7h3EOJy2LHj9EdKFaGz0QkAFRjvzSGTcfJIPNEPqQFyvuCvlweQcts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LOpfMfEg19mxGDCJPH0dtuaZON5VLSUOoN4rsn7Y2K0YghhI
	32uBQOVrzxeaSsNUX5uUDzkVkZVBOgMkMAVeI4DZTV7xxotl3QLoL+wt1kF9LsmdvI/uwpISfUh
	9hw==
X-Gm-Gg: ASbGncsQVkl7+T4T+NswsF5NabrZ79EcmuUahI2KQQ7GZwd5KRW4rpKzpxwSfzMBpxn
	NKCjQpU8l7It4iVOEJXco1Y8+ip+xaq1S7l17WtNSYUyyv2ulH+hcUGP7qkkiNbQeOUcHGvfJ6o
	0GOIwUQdZbvKY38+PxE9Iyx/jdrTa0sDITwxjXxW23IvhnZwzAHBHyb8HLL+OqtEusT4cGsSabr
	TSxIZuElQSarwGH3wpQndZNPW5PtUWv6ooWAt66Fjyqx2LjJr1hx0r2mmKtSDgsbBqm331pbNjw
	ZqpF+3Qnf7N+9o/GqOK/ho9XdqkpRvmSVm0nvWxNveAM9strFKJlfovl8z/aeKZSNfOgoMT+bft
	lqJPicKPVXyYKenjrtcU=
X-Google-Smtp-Source: AGHT+IE9ju9qYSVe+zZShDBak3dOUPjt3vMhdwOC1JoI7U9ctyfdaEtEtZb799WIa4ImQlVr7fAV8g==
X-Received: by 2002:a2e:bc27:0:b0:30b:b987:b6a7 with SMTP id 38308e7fff4ca-30bf43b9339mr84857371fa.0.1741822529327;
        Wed, 12 Mar 2025 16:35:29 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f116b14sm56221fa.59.2025.03.12.16.35.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 16:35:25 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54998f865b8so339933e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:35:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBTDavG+EyI+8yws8fNRZsurFO0iBj+Brgv5+S6YIkcBcZStto5yFEablPb8lTCiM9nHTH9rByKOscJwk=@vger.kernel.org
X-Received: by 2002:a19:641c:0:b0:549:916b:e665 with SMTP id
 2adb3069b0e04-549916be6d9mr5425219e87.1.1741822523482; Wed, 12 Mar 2025
 16:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312090132.1624445-1-nichen@iscas.ac.cn>
In-Reply-To: <20250312090132.1624445-1-nichen@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 16:35:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9eOSWxuR02WenYxD-rTLdTAxpdo9b2fjbpU=hA4nP4g@mail.gmail.com>
X-Gm-Features: AQ5f1JqpW1Y2ec186etHxO7OaCmaGkbtJ2Rci2hirhhSerJiADteqbCBM3klWQY
Message-ID: <CAD=FV=X9eOSWxuR02WenYxD-rTLdTAxpdo9b2fjbpU=hA4nP4g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Remove redundant 'flush_workqueue()' calls
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, yuanhsinte@chromium.org, 
	jani.nikula@intel.com, xji@analogixsemi.com, robh@kernel.org, 
	sui.jingfeng@linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 12, 2025 at 2:02=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
>
> Remove the redundant 'flush_workqueue()' calls.
>
> This was generated with coccinelle:
>
> @@
> expression E;
> @@
> - flush_workqueue(E);
>   destroy_workqueue(E);
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


Return-Path: <linux-kernel+bounces-530364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E1A43287
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B6A3B08FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7F3CF58;
	Tue, 25 Feb 2025 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WCYNPwZ/"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96409101F2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447687; cv=none; b=JHl3EbDyur80Vs0PqsSxuWzXqh3lrGT7T3djn+SiD/gfQjS9Zz88uk5iJD+DCJ1BL0ju53t4CsuVtuNWuFxfsd/c8IRZ6NFV06uY4bG3bpjM8CX7Uf/TqDXwyPAutYraCfl+3kns0nuqGMR2ClRpQiTyavxRTPO0i58QhgMcMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447687; c=relaxed/simple;
	bh=71ALkwh4lV1GOQf6XwUxLBOPX9rYbG8qB4YRKiZ0PHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRoIrYDoVvCa7QYGuo4a8Z95c26c+RQguaz6X8wST0iYqGm48OgyDPef3cPPKmvfoDigRunRql7zKF9ry1xPndiLXWM2yDiJmScRMStXmLG3bNkjqn+2B7geJLtoM/MdtYGUptBSMZFHo4TVlxXzFcjMeNoXVmZMzF8WTzTmKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WCYNPwZ/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30737db1ab1so39601191fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740447680; x=1741052480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BIxNZpAxXmgtUZVoY5Vf5YilI6JIk11YmgayAzmSTM=;
        b=WCYNPwZ/7qsfA3V8/04o6EoXlckdJzIwn/iwy7hpVK+gfXYM2PsfbF6OHltPX3eQb9
         w7jCfXg53Z2/fixK4CYLKCvF2iGduY54Q74w/Y05R5FMK7wZITSS6yg1LxMi2A9qOjrp
         bXH0v3rHvhKCGtxv95WfTuLpu0Y0QugDp176M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740447680; x=1741052480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BIxNZpAxXmgtUZVoY5Vf5YilI6JIk11YmgayAzmSTM=;
        b=cZsVKSKJWyFOzT2rdxs370gQHztZszj+aqbP5fzp8Yqsji3UW5hEtwIagT1hy7XXVX
         R+ZAbPw2C/7p9RXIUF1rsBiMjEfZ2Lr3wsb1voa716+hf8c/STOplaoQFSkYwRk/74HW
         VKeoGlmp4jHSS0TtQCuiet8oi486GzkP7wwWSem2ZeMH6CCh+atzlGWxatTX8i7fHwfb
         1QFlYQke3sRiMOjtooFlCM8jhAxuswFJEwr+aPo8BUK9RD7eAVs0jIWxefhCeSnIWKTd
         vkJy8ftdoS6vjbzoyr7Rt22+auw02GvT4VmdJLEGZDpT+Y1RP261CNnl00xrjdZV8D/m
         lQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFdBpYHJ8oX3L0xg0OWhRBkgiGMoRSOKNPhZPTmiswMzo/7+gJPTo1tyZqPaqz6uXcSAKv+H95rtSx5HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7sb+huUBhZXREfinQP+vzM34RvK4j4MbXS844LTz72Jm+Za1Y
	n5E+R791z/HWDY1w+AJlK3bjBaUr2MKR+/tNXIe06fJUYSlkR+PXvHqfhICkKXEadeWAsXr+sTk
	6Cg==
X-Gm-Gg: ASbGncvCXJeutdZLYhVtUU3B17g/kgxFBnI4ezNABZwxWYLreCW05xlsxPF4Y4hLUeb
	obILFmG62L9K0kxmZukuQM9nqRhRqjAOhYpHomt1c2daYL8w6cwLQZWagybFjmX0QbSnueKEjWi
	d6AGo0OGvx61uUW6KBK5Lchmgl3VVwDuZX6iVoIGe1HdeEz9oeVs7dV2BKpN1XO1qdrLnWP1SGO
	Z7S/FPscQJX997mlK+Vkc3jYf0xC80J1rJ60rrg8xwKum3sS7FxuDV8c0YZs1G981evQqU7NFJZ
	BGXPnmM9TArrZx6ZtPTghwTMFyzEVauHNzLohbry4neeIcASpa03oGwHlYPQAUD6eA==
X-Google-Smtp-Source: AGHT+IG39TlapO8S+qbM6rol7/jrKfB96kerijW1p3MkueJqOtiQqfgmmfAmEHNHxIbp3CJJIAiSnA==
X-Received: by 2002:a05:651c:1051:b0:30a:453d:a02b with SMTP id 38308e7fff4ca-30a5b21cf0emr45983291fa.32.1740447679789;
        Mon, 24 Feb 2025 17:41:19 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a818164e2sm895501fa.0.2025.02.24.17.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 17:41:13 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-548430564d9so2711118e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:41:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXR8NG+EufbZw1tAS5jHV8R2zz4EcojrboiQvl3cQwRsbvFg43OG6bH43SB91UDTTqu1n1ebUL9Ca6nPbk=@vger.kernel.org
X-Received: by 2002:a05:6512:10c6:b0:540:1f7d:8bce with SMTP id
 2adb3069b0e04-54839268617mr4611865e87.38.1740447670508; Mon, 24 Feb 2025
 17:41:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081325.96724-1-damon.ding@rock-chips.com> <20250224081325.96724-6-damon.ding@rock-chips.com>
In-Reply-To: <20250224081325.96724-6-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 17:40:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uu+EvZzuFmCvq5qJ=FeBjmLTtfGT4Aq6QBSoH=Sen8PA@mail.gmail.com>
X-Gm-Features: AWEUYZkhmeaAQLOMDj5xS_yarIgfu2NVlCE358kcuOa-b55Ak-RhS879p-uOQpk
Message-ID: <CAD=FV=Uu+EvZzuFmCvq5qJ=FeBjmLTtfGT4Aq6QBSoH=Sen8PA@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] drm/bridge: analogix_dp: Remove CONFIG_PM
 related check in analogix_dp_bind()/analogix_dp_unbind()
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	dmitry.baryshkov@linaro.org, sebastian.reichel@collabora.com, 
	cristian.ciocaltea@collabora.com, boris.brezillon@collabora.com, 
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 24, 2025 at 12:14=E2=80=AFAM Damon Ding <damon.ding@rock-chips.=
com> wrote:
>
> Remove the check related to CONFIG_PM in order to make the code more
> concise, as the CONFIG_PM should be a required option for many drivers.
>
> In addition, it is preferable to use devm_pm_runtime_enable() instead of
> manually invoking pm_runtime_enable() followed by pm_runtime_disable().
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 30 ++++---------------
>  1 file changed, 6 insertions(+), 24 deletions(-)

If someone really has a reason to run this driver without CONFIG_PM
then happy to hear about it. Until then, I'd say this is fine and
matches what most drivers assume.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>


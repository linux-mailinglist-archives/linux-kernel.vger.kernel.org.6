Return-Path: <linux-kernel+bounces-442225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C19ED98F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2972C164C90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E101F0E50;
	Wed, 11 Dec 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P2Sol11E"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359091A841F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955780; cv=none; b=aqbhy84Oh67kEz+uZ2iwcXr40z2lcH4hMUyI7uRyFdTycaVDeK7gNd2lVixC4tPjuSq3zAOsg+ueSbPo8PG8FmpoHEYAMVUXc7yEf7yiUNl6kGtptvntX8VwXQrJCC5WJ/Aog/I0beCA72/tTIQ4Q9iCc+OG+Qpx+3JrkrVQhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955780; c=relaxed/simple;
	bh=MJDBBPfSDpJWtJb9BzIGgtoPQLKoUXO+S1ieKhazaPs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ciqi2rbY/Ek4dxkQXiMQBbLn1PvNdGTy1ZjKpzvyNAL8di0UMwcZyiw/L+RcNTOD+pwYI1LoRJ1dE1AF7QsBeT9vTMOCiSYTfyqPGoQdZYvYyFsnPOFbqKeZTijiikoInP19ewVWla6/i7CHGm8IPS/8+AXmq3oVk5mRPuArszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P2Sol11E; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d918f066c1so19471926d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733955778; x=1734560578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJDBBPfSDpJWtJb9BzIGgtoPQLKoUXO+S1ieKhazaPs=;
        b=P2Sol11EiF+BRUH5l630TlPhZpoR9HSMW80yPpBQawS/wbma2PheYJoOxH8VWGJhws
         8CBK9FGtQGoOcq+d9duGrNfOG5zWaQPiJAyS6wWFS72wEIt0Jncvjz1aHszqY+c10qY/
         Jw7QLYQXcxhmRze9ypwUoQ34C2DV5T693TFrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955778; x=1734560578;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJDBBPfSDpJWtJb9BzIGgtoPQLKoUXO+S1ieKhazaPs=;
        b=EoexU0XvjcWvJxTU8OtWgMcLyN83OUdwW6G86kvH/g7K1WrUUAYfTbW2uTjaLwJeBh
         Zp5Q4ckGElSe4wpWe9pyQXfcEUvlrZHvu8dmD6y5Sw1H5RzWvutMYhgBB4mM1Zghz+by
         w43MI7Crcc6+idhfW5g0PTEkfavhbBGJH6duH+48PcEpdCOxihzFbNj6HkMo9mV36gPR
         SwemQ47jY1XgvYEL+HDKwSXVwnzLJwtDbo9LHCTcS8XjXDmDIHmAIReIYRzn0cj1g+aK
         yYTRrblgoCkYdRbtuwJXfXKnyftDo63f3V+yrvp6RKHiryiUl4KBSCziDremku68hWkZ
         JJeg==
X-Forwarded-Encrypted: i=1; AJvYcCXcSJ5FbIe1ObLS/yqPk4a3VeDItUYyQs4I9CXFs58z4HvM8WriZZxrw1OTioemxtJInxFar9DmybNWZy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylz3NanlUlBQfplEqRmsBi4/SbV//3XWaPFYKk4kxmQPLXkQef
	s4wRdlUY+rY09YunyNhWwr/gWyoRqlB0Rnxrj7ZuNstBXW5JMSuxsgJ3zV0iJr6BmJJgQD5g8Oa
	F4qZyERW5UuH6rBk2is/Sb6PXxF7BcQS3sqKV
X-Gm-Gg: ASbGnctQai05dvUXCM0EYFNg2BvAjcd1TttWqh858sVHq3IcXbvI9Kxe/+UlRi5JWlE
	jRb+/VTT4igOwDBNQ/d6k20bgunwA5xJPhG9vClQe+tEiHqXidl72edefQS11jbs=
X-Google-Smtp-Source: AGHT+IGzWdM0tmUIo9hkCU9nyE01NRmj3O1QuD2Ba95w/TbRxxu4YMhY0/0gBbnPplq8JU4pMlDSW05l9pl+kUE9bGI=
X-Received: by 2002:ad4:5ccb:0:b0:6d8:8a60:ef2c with SMTP id
 6a1803df08f44-6dae38e69a4mr17111236d6.2.1733955778063; Wed, 11 Dec 2024
 14:22:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:22:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-7-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-7-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:22:57 -0800
Message-ID: <CAE-0n50_NvLiWmfNnQJJKLn=BYA82vmPgy+6Vdpe8x+u6fwn1w@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] drm/msm/dp: move/inline ctrl register functions
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:37)
> Move CTRL-related functions to dp_ctrl.c, inlining one line wrappers
> during this process. The enable/disable functions have been split to the
> enable/disable or enter/exit pairs. The IRQ and HPD related functions
> are left in dp_catalog.c, pending later cleanup.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


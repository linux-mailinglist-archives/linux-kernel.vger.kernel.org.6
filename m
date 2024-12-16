Return-Path: <linux-kernel+bounces-447941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAACC9F38FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4C018909B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36257206F2B;
	Mon, 16 Dec 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RFIkBecB"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A807206F0F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373769; cv=none; b=GKq9mGADOUy/TBux3pfrRDx8b3e66R0vXJsdtyBKyjZF/X/4d96BMCNzWt8zUC365PeB7CHCWLOGyjZ94tAUqX4kKPzQ8ArowewWvImJgYm++uqooGhsO5BzABJwPD8J4naUZvToXrzxrVbbwcKny/LRfhChD27j3SNY6T+wPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373769; c=relaxed/simple;
	bh=GR1waToDgrCuopV4sJNgGblNy716dPbxfdvbcwPcWso=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFxHyZHwYtTyboUyNjQuSAVukXdH3pC+0Urgmk0oX+4WfvITS85xcOuv5AYnbVSKQTXHBnnLAmCSZ/jLblHIJjqTxqic8AHtwqyXe8tjkye7B+O+MnehN8IxK17crdg8+epf/TXtCKlJY3WJcEtRRaiKmf5cE00SMjY0VP5kspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RFIkBecB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef66a7ac14so51406437b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734373766; x=1734978566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GR1waToDgrCuopV4sJNgGblNy716dPbxfdvbcwPcWso=;
        b=RFIkBecBjNqjeoYxVmXSrDHc09wE6avr6cSxLhvDMzz7i9eKzBgYZStqGHW/uPzrlM
         2gAd1SunVIgCUarHTox6+LoHde3rv9rnWk8pG3nTGYlAqAL1dJQCi/Adao/PSmKqe0oV
         OBoqUgWvhXrMSiTZFtoNqDIfhveIiuZ2LLmCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373766; x=1734978566;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR1waToDgrCuopV4sJNgGblNy716dPbxfdvbcwPcWso=;
        b=K9h4BAie/Zi9TbZiENL3aBROIa08Yob6sYBuedFqAvJ0ekNkjaI5EygQMuKMCHSPwp
         WJJJl3RK9aVUnY+LOzryIlJJqmx0fDgsv7Ru0yAqE3LOCz6voCjHKPESFkmYxpXJlYQl
         BgyL8eak7CPtNpSUH/EYNHhf45YoKhZkFlkqm+PAXpH1C1WkyxB6P/0xJVRlcDNKeZ/m
         FsgCtW4Bo0r9Z4jT/SzIknOGo7EcLjrpwzJnR25qDDFLJ52FK+KA4RfbOy4w+4JwZ6f+
         LgrkN3Wtw/WHz3RNsHtOkphkl78DVfYFzzgY3/gz+52q9qOm9iAsPGIO/Em4wmryE6jF
         N8rw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0GLTSyyMy7I0E1FfVmoaeTO+41FoqknPu61fvNu7SDY01kUeR/tqFXJPCg82FS8MUn+6TtKsqgYFQ38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7c6G7VyWYkBClyukDxEQax1F8VlFj2g6QIzA6/u+mdhRz/WUg
	CTgrovzai2oWqhtXKf6Y6J7ZXf2J6TZPTUeqRoXIvb0kyM5JDnkRaAxispllBfmsi+CpCla24XK
	+KhzyTE8KKO/kzeoyBjR5z6FSPF+4MFa6kcyH
X-Gm-Gg: ASbGncsiq5/McbLUI3TSNt5zW3zfzVT28+0LDnvlcPGoIuoOkBIjt7OBaChruSYSufh
	aghsb86zaRz8U1UvHP7yhx/fFWsnPtvRXjXuTSwzpodVjMJrklJgJNrbL9Ot804mn3w==
X-Google-Smtp-Source: AGHT+IH1rrCqzyUmv/+ovkxDTTujqBxDtcReQhBBlksOzIUEXVcbUlAtrkHnUp3TKKoOBpjZ9dyQODPY9A4b8x3dvxM=
X-Received: by 2002:a05:690c:48c9:b0:664:74cd:5548 with SMTP id
 00721157ae682-6f2bb9a5b62mr5055197b3.1.1734373766242; Mon, 16 Dec 2024
 10:29:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 10:29:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-6-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org> <20241216-fd-dp-audio-fixup-v4-6-f8d1961cf22f@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 16 Dec 2024 10:29:25 -0800
Message-ID: <CAE-0n527-TKS2Y=SsmALOKrx_QrzT4=j_dTyNgk9A_RDQzVcWg@mail.gmail.com>
Subject: Re: [PATCH v4 06/16] drm/msm/dp: split MMSS_DP_DSC_DTO register write
 to a separate function
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-15 14:44:11)
> It's the dp_panel's duty to clear the MMSS_DP_DSC_DTO register. Once DP
> driver gets DSC support, it will handle that register in other places
> too. Split a call to write 0x0 to that register to a separate function.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor


Return-Path: <linux-kernel+bounces-442287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFCD9EDA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF3416790F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DD1F2392;
	Wed, 11 Dec 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d6S9nbdo"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACA1F2399
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956544; cv=none; b=IoFjtEgRPXQLk92hgYuPgQRg16pOp4Znk8tCYbW5abQJbpA6Vdok9ExtgU+m1e2g4c2hZsetltjknXHqnU75QOWN05EtAloEABFx+28EWuR3CD+y65xwSOvZTpG2wDW3TOvvnhspdY3Mrxh/Uc/9604y8dim1ym4RgqeBg7lXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956544; c=relaxed/simple;
	bh=WkXMEqZ/gF/xnWJ/mhzzg/miOHHNVWajJShRngxnHGY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4loyrKCjVD5kImzhzG94Eo6YuZmV8/RAfi5ieVngCPi5lwiYfYXAS5vcRPJ2AIF7rZ1fl1MBVGL2IcY2JVPgltvePZVsa6OGgmc5p2xJ8LgFQ+o+2NQOIRXPqnVnQESpYUmLT3W4/CBsaqHI7bcibaiBEQiA2cEF4tQHdPPEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d6S9nbdo; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46677ef6910so65298111cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733956542; x=1734561342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkXMEqZ/gF/xnWJ/mhzzg/miOHHNVWajJShRngxnHGY=;
        b=d6S9nbdoiEdi9fVG8d87uCvOSqbWjEz+a+2B76mwiV0Lu0YQfK0QZESqU2O4Is3unQ
         Uhw8EMdhwQfex8Hbooa/zGMsqJ7aakt+UTGuvFeipo2uNpQ9ncWtp1DC05MHiiW+Ww7W
         lngHBg8DqPcxtTz9wkaHoVeP3x7fV5XR8w20U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956542; x=1734561342;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkXMEqZ/gF/xnWJ/mhzzg/miOHHNVWajJShRngxnHGY=;
        b=DpK2B2eRErF+tXGS6A8s1qYcRAQTwPYkjCx2Jn9KOmlNvsjJFHi6ts73EzGBhWnKfL
         P+BXa+iqFd5Hs1gMBb4qvchjN4vQGzsZKTC11mtNweh5A3GrSEB9ME+DOBJsHwoYM6bN
         JE6PmRM4yuS/qP7aF/4ewqu9OcyfP3b6EtYowEA1M+yvrFxRSAIMQzyr1WsOEHq1PNjn
         CDlT0/EtkYqMdkg+/rRl7Frq42cQsM85vEItMSKljqnUc2fGdpslP2OElLPeLDPMwuT0
         m07TtXNjVQiMPAi/5oUbn2vjjiqfL5zAqlGfPs5mKUDoQh7zapHMgYGJUKWpO0nG2cb1
         QD8g==
X-Forwarded-Encrypted: i=1; AJvYcCU+xlpK+S6w4p4y4WXbdFZ+68jFp1Y69bu4GNyJPEhCgJnr4X8zGDJEpcHTGQnVqM1JvnKZ9NywCrWbGUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigjH/iib33GN/XLqHA5Lw0ACOq4Zjdx5uh5IP0mpXVWzmrkKy
	x8VtVwYGhFbSpgVfxgHJMC9iSzJ4QRwQfax63Acqy+1ds+ZQn1bqVPSc/i3p2WaHvN0nRDgtNuJ
	wnQQHriaqzmUxcdczavIPIFciidAcu7qW9Uc/iM/4xw0Yps0=
X-Gm-Gg: ASbGncuHyKNRg01kumKI66hmp4CGZ3CMNNAlEKRp33vPI7Qvk/S/9d4IumlhUcKngtb
	3WbVxmHSxGg9J0xwHopeGStfJSi4wIpB8WfTBhscIrVsYyr0FMMhudjd6idre1rxTAA==
X-Google-Smtp-Source: AGHT+IG9f7BHz8iDa6A37ISXD8md+OMJZHRpC/Cm+CFql7zV4E9ytytJpMb018vR23ZL3eujA5g0+FW3B1/RL8ezpns=
X-Received: by 2002:ac8:5e54:0:b0:467:43c1:f0ea with SMTP id
 d75a77b69052e-467961786bbmr14756091cf.16.1733956541804; Wed, 11 Dec 2024
 14:35:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:35:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-11-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-11-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:35:41 -0800
Message-ID: <CAE-0n52kSzNeFazUpL0e1C-tTZHv7nzOCYinYCX72pKk-E9_XQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] drm/msm/dp: move/inline audio related functions
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:41)
> Move audio-related functions to dp_audio.c, following up the cleanup
> done by the rest of the submodules. Inline functions with simple
> register access patterns.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


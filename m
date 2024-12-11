Return-Path: <linux-kernel+bounces-442245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56919ED9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754A916632B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1523195;
	Wed, 11 Dec 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N7wxCJg9"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBC172767
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956320; cv=none; b=UwO3QQdRJ9J+kgDqI4IyGE2t00iUcgR7YecfaRF/mE4tBW2GLPRMKDMPgqMYpxtnOJgBNpiAO5nIYPVD5tzMVNuvWUdPMOcNXoZA4+DPT+uSuTPnpjlYAA5Pt3fpb9jnSL7hFWad2oe3eB/uQr0ZT0K+7gCUJtLGgvDnM8NVAXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956320; c=relaxed/simple;
	bh=NHbSAVasy0M5518vl1c8RnaP4kK4Vq9FshCC3WUmEd8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS8kkLacsGUatyrwah/JF4zK5EYnbX5YICD798KFxkfblW6fxlDW/2Y8EylFi6SbR0867lnI61JEV05nnq+xTCu3jgeDmEXyxBc+djzQugWrsvRKVahguQsSeiM1Xt8LDaGc7XJZUKf8rqUhR/FUlawnLnFnmolOK9hei/b5xAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N7wxCJg9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4676f1a43dfso11414321cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733956317; x=1734561117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHbSAVasy0M5518vl1c8RnaP4kK4Vq9FshCC3WUmEd8=;
        b=N7wxCJg9A3sKkUOw68tbcdKVX+7OYPjOyxZj8DsBs20SA2HBFwFh3+ZXKmw9vNBfLa
         sWGyGzbIidavutlAOM++iTZLCPUW7Fd1mqzRylt1ulVq4JqqEgjOwskZKeE4UgmtRLtE
         Hd2+vVE7UIvQbtuTmZ8butYrRq6IcobIU/YF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956317; x=1734561117;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHbSAVasy0M5518vl1c8RnaP4kK4Vq9FshCC3WUmEd8=;
        b=fPjntccjMGGKz8tHD6JaHlmwGC/Gn61CfuM6cDAYxXUXn4WsbNLD/LqRg2qHlRE8q3
         MjJzpuph+BPoQMJQuY87xTIqclCR7NSY5vVNtZFonCRNMYPEeX9b4dMRfMbPFdgWtowi
         CaCXAXfxrzP1vhCDMIDR50lc5lgB2mnHN/FMQcCRMJG2wf0iXx+E9luxKKPjUhijizJv
         Y2kdjLajtOoXHrgC6U5ML87yH5ebfbHB92uWOJW70dHXDn0LXyIKuJbqu5bqBJbl1l4l
         Yhb2+AF6wbx//oayEdW0NMoSo4EDqbpUQ9PkkxGi/3nWGH/UxPa3/BDdSUbF2boBuDBo
         xGyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCCNj7lz9xwiYM85Sol2J5xubhQuG1t9kot2yD27+CFJ6SOsDX5fqzfZ5iYxnbWm2I1tMVy4U6tCt1HlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8texnDMqerAxRFijzRnn5M2pPoFxi6J+pOhEOsjX3dPY9Q0h
	hTKsn0Ca7ibh+XHqDRpVVa/N3bzBTWlvUl96CSHzAyO4yBbWvUkhWKQjT9+CuHJXufD19S/pmpv
	GzpTtP/uBXDvE/vzWX94TvyYi7Un142IeRFOF
X-Gm-Gg: ASbGncv6taFhmvynKLAy+tQa1xfo1AtRBKDYC3qO404HQLynk6hCY2l5aAb7czpmtzx
	hV8eIBR5PufmTaNs49/VVNOBa2AgnFdC3FS7WE/+qj3L3Lklhy0QT6dRm7HOlHSA=
X-Google-Smtp-Source: AGHT+IH0phbrtePElXJxDxj9HI12gSYY0Q06etMElvaeqdDYhA8EkdDjpS2cR8ruv8dvm22YKh6KLSLREA129gVkVUA=
X-Received: by 2002:ac8:7d95:0:b0:466:93b9:8356 with SMTP id
 d75a77b69052e-467968a1451mr15126531cf.22.1733956317709; Wed, 11 Dec 2024
 14:31:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:31:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-10-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-10-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:31:57 -0800
Message-ID: <CAE-0n50T1yJEhx+NbcoNbEZ6Q8Bx7asOHHx=bOY_uKNaQ-y8xQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] drm/msm/dp: drop obsolete audio headers access
 through catalog
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:40)
> Drop obsolete functions to access audio packet headers. The dp_audio.c
> now writes them using msm_dp_write_link() directly.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


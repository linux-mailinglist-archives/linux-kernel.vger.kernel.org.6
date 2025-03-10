Return-Path: <linux-kernel+bounces-553717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6F3A58E10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F163AC5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F3223333;
	Mon, 10 Mar 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="ZXtYA+4A"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79C14A09E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595027; cv=none; b=pv5FgNKflQ8pY0Ces14pZ1gbO83W0+kxQ0ULFNyAW7aHGM+aV7JvKiG+k/Ra5Vr22G6Re17h0TItefS3xY4GA1kGRG9dwYjCdTW7bsu6UGTf7FhuxqACASKf3Ky8JPUaT5YxZhlBLjTJ36mlyvZV9lMpIG5e/SHds9OVM5kumWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595027; c=relaxed/simple;
	bh=Ivx/6EEyCTtnvCErNeMLytYw3JO2KfbbSfvqVn7RN1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVKOZPSMcNiXZjgibUb5W7KmpuxyNAg3m5oLEttqKAZjqGJKfOatUApyNAg95bfBBxAEQlJTczob/IkGXQBBiSndRvOWxXTng2dWZVVLfEJZMsu2x8YB0SsF/xwaMo3hTnhS9qPm/bNGjJVoUKXcc92cRcdX6GdHG7bn9kWqF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=ZXtYA+4A; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-474faf23fbeso49671461cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1741595023; x=1742199823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivx/6EEyCTtnvCErNeMLytYw3JO2KfbbSfvqVn7RN1A=;
        b=ZXtYA+4AITxBSkj1mqYzXxt7za0Mug9GjtCVLUc0Sp+hITuCASF7dyFnbXS85vUwXm
         BmIPN0FIsb7WVPJhQiis91Dh77+pcFvi9eV9KpApIjTEhlImpJlKgwIbb0Lk/+uAW2fM
         NjKr0DWynLnvl/PF9p+Hju/dXOPeC3QyxqkRHCy6f9ib1yn5Zzgs4zbPvEh5QnqYBV49
         FmCCOm7Uty+hmbzawvG4TrJP8OFvr3mdGXF//c8wjGRRUIJcK6A1YafnhrF+2ScNuuiC
         u7vPgNi6IaOriRqf2IHXp7zS88Kd4HbOu5KDmzU1A1oVttRXC7fxr4bTzx7kxrDVLm5T
         AM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595023; x=1742199823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ivx/6EEyCTtnvCErNeMLytYw3JO2KfbbSfvqVn7RN1A=;
        b=Pikk0ef25MfXSmJWwdPh6Op9WFr5/LKBG3yePrgI9W93gVd2SZXIMcAyO/QZy/AZut
         4kf+65CLjKDLR7wDsaWC8kHJet2OPit/weVzwwfV7WvuhF8K9KsWAAnSn5u1/4pe1/LW
         gJWptoPd1kKETMcgV/+J6OKXiEOEG9oT7OIOK6Uh2ih9pYd/lVR2aTHmr0PVekHuF1pJ
         t4v5mRQsKwdsfs9WmXhaj5li+c6uSL0sY4SS+hyzDTQuxwdBA+/K5WgiS4uJ7BY2BvZB
         0Ass+8bL2Rid+qZFiRXs7qDkHTTqQJMBad9SI0VWFGvzUYVgVZMQD3meB7nIinvSyWkx
         a23A==
X-Forwarded-Encrypted: i=1; AJvYcCX3Cb8VJxgS6i6vrwux1zU6zdSZfZGAdzoJB1J8GfBCnm2C2cqAB6mNuUPPw5qyZrw7e10JuRDE8QEkyww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzktg/0noT1Ufgx5MxLnykP4mgMKqJsmNVsrmAhaKV8jx86nB/g
	ON2aW1aZ+PlydjnmSxUZ10RF6EastyvTSdmbcLWgmVgADwr1aa9wwHOLCoWu+T79Ob2pQZVUeji
	Vs9YaBRsaI2bUq/dc++6ifTYvPzSzsfE3kWld/A==
X-Gm-Gg: ASbGnctkN6lfjZ65MPmfRxZflLmfdHgnwFQCM75kBjo8k1oTSjkUrHpRM2wyTDQg45h
	xzIHJN13mMpMfrhU7RZVuR6Rq9Ju5g5pD4ujeVuVdGEG8HRmGpRLEbnvRWGGhU8B7WNaDKtRLXl
	6QJGQKqM7F8QPL2tCMg9YW9Av+sUQ=
X-Google-Smtp-Source: AGHT+IHX/ie+SCwilG9VkCigXT7dVOX7s13SM5HyamqcMyXKzLgr5BlSUTLW598RuV9I7TxHm+K7rOgy8bC/hIiXpus=
X-Received: by 2002:a05:6214:da9:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6e90060411amr182729926d6.17.1741595022743; Mon, 10 Mar 2025
 01:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217053719.442644-1-vignesh.raman@collabora.com>
In-Reply-To: <20250217053719.442644-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 10 Mar 2025 08:23:31 +0000
X-Gm-Features: AQ5f1JppnRfUR_zOw553KNwUL6uzyjdZezy5exd4nob7qrMJgxJe74M-TX4Aplg
Message-ID: <CAPj87rNUMDMUtrfV=8c_+T5VQ0FykjpR5JW5dgO4grYXpabSdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/ci: enable lockdep detection
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	jani.nikula@linux.intel.com, dmitry.baryshkov@linaro.org, mripard@kernel.org, 
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Mon, 17 Feb 2025 at 05:37, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> This patch series enables lockdep detection in drm-ci. Any lockdep
> failures will be shown as warnings in the pipeline. This series
> also enables CONFIG_DEBUG_WW_MUTEX_SLOWPATH for mutex slowpath
> debugging and refactors software-driver stage jobs.
>
> Test run with this series,
> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1366054

Series is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Please merge at will.

Cheers,
Daniel


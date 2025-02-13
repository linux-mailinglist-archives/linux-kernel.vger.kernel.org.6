Return-Path: <linux-kernel+bounces-514045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14158A351B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8793E3ABD70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A4B2753EC;
	Thu, 13 Feb 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNxSeQF5"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA02753E1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487354; cv=none; b=fBKtveWKUqeZyXUc/Cs5AK4mTkyNkIYCR9VFN+QOR5QNIFzkv5ddUe949A56PujjlDzutbllx6XveuBRT5g8n8wJIe5ATOyH3zg54LdEmFRGHR1p+Wbri+dDvH9H3crMqDj4f8JrGadS5Qxvbi2LdL8eQtk+g5a3a+QkPGECaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487354; c=relaxed/simple;
	bh=Bxbqa1Wy7l8zj6Afw29li9k8KxGALKptWx40P2MMqps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaS0+eK1Jm+jTiweAorrjkzcTgeIgPatb/zelEeJ/SwjjZ0Y97TC9VoVLqedxEIlp7FLYlMctfLeezI/ZR2Bog/Mx3vngUYyeOnlJvLTbOYM7voF7lyp+k1XFjV0QjQY9mOUHm0+ZVh7nn37tzfylh3+pmHVOtAV0jKCtkR1rrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNxSeQF5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30615661f98so15784111fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739487350; x=1740092150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/24JPm7Fd6JZXHQpZIKrpL+icINzVWbUkAHKK0IjNBo=;
        b=pNxSeQF5rYlNiLxxHSeT0J/8/NZysKph6eXPSCltlF8s21zu0dNGvFAzaHKHn99Wz8
         zBk7BBQ04rIo9dW+z1SzdT4eTVCF42VZB0wyys2aDup4YBUTkPH2gKwUb6qSBcfXQ9Ii
         Dhm9JCl/RFISyMloLQ0/1/mswOTJxT03N3Xgf3aAtt1FAYzQUqhKwjutfS+INaVu0uSa
         w2dYPl+XRTDM1VtfH5+VOoJujg2ytG/3DZudOB91IwjyjrgaM36+28YnRjSLRk4URJpt
         mgoQhJUfjRBJn03RG4ey6n5Jna0W1wYum/uMh6pxN77XLZ/q9xMs0SKwcZjRaQoyzi5c
         8WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487350; x=1740092150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/24JPm7Fd6JZXHQpZIKrpL+icINzVWbUkAHKK0IjNBo=;
        b=oBzlVIV1zaWOPrMCy9LTtb1uU00fo8yIwwdHHEUrTbF/dtFgG/GawT4cW2ZIHsvVn2
         6OmS6yUpSFgeoXV70lkJjKADVJPOvVlJxN0up4AJqai6Wep51XrbPUu354hSdmM9tkG0
         n6he+aiCRIyJc3DUSFh2pRl3XfknuCBIG0XaodR0amBlZ/VmJd5bj24fvjG60IWF9hlC
         rnKCG4uDR2AdB6vBxwIZqvPk72X9AGLePA9L3dZAv760HXBtCDgSWpCbJJ8bl081rs0R
         0nY3On6FQ3+hPr1clcRo2+X4mYGrKB4PKIXnu8tPl8HjgvlO1ZscB/CBM+y40ReSEID6
         Dpew==
X-Forwarded-Encrypted: i=1; AJvYcCW4Iz18ELqFri7IDC8rhHXQZdvvKCV+xj2sjLbGPaol/Qsg/fpEon1WwEzdp3qGOdv03y2/RRMZACMyztY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzQYugryNRKQh0RgSXpnpijN7GpNW+woRZh+hZQDN9fRI8JFEm
	YQmihV3UTDQsduHDYQ2dyb6XU1xhdRNU2vV3RHWklg8KA4eKdpDRch6VU36+R/8=
X-Gm-Gg: ASbGnctjtnQA2Qzzrs4H/PE3PPqfAX5t2CCa47WJVbqSeJBRk+lqJOcjqNIbguYlwAy
	TG5brvotpawGlZufbVVbzKfze/qZ8Rx8GIIMIyq3RIuXwZT0pzifWOY1kZ4IGItcvSzRPTWu2bI
	2n4E94ZlritWORvqoInMlPLYiNEVryaukpk0HpRMzRbfHSUd6cdRzgGPgQLl/iQPUFraSNsXejK
	Gxekx6DUOGz1yy/fTvKaDh0oBRe4DSVmWjIQ5/JHkiJOPtFAaiTixriQWe841f3l/FPSBq5vf0r
	1g5I9iwQHc3W4Bvn/aUTPTJ1K9p5Be5HatgKopwnUdbJG5vNDxRs4Mwfg+M=
X-Google-Smtp-Source: AGHT+IEZ1626++5xMDHpo0WMOzC0N7lgwh+1qvbo5fUuwYvi+B3DfqXZdqPho8NHik66LI3m5T0N+w==
X-Received: by 2002:a2e:be20:0:b0:308:f6cf:362e with SMTP id 38308e7fff4ca-3090dc65edfmr18377611fa.4.1739487350464;
        Thu, 13 Feb 2025 14:55:50 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091011d566sm3377011fa.46.2025.02.13.14.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:55:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	Simon Ser <contact@emersion.fr>,
	joshua@froggi.es,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Daniel Stone <daniel@fooishbar.org>,
	ville.syrjala@linux.intel.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	Christopher Snowhill <chris@kode54.net>
Subject: Re: [PATCH v12 0/2] drm/atomic: Ease async flip restrictions
Date: Fri, 14 Feb 2025 00:55:45 +0200
Message-ID: <173948734065.719858.7405160715916126757.b4-ty@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250127-tonyk-async_flip-v12-0-0f7f8a8610d3@igalia.com>
References: <20250127-tonyk-async_flip-v12-0-0f7f8a8610d3@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 27 Jan 2025 16:59:38 -0300, André Almeida wrote:
> The goal of this work is to find a nice way to allow amdgpu to perform
> async page flips in the overlay plane as well, not only on the primary
> one. Currently, when using the atomic uAPI, this is the only type of
> plane allowed to do async flips, and every driver accepts it.
> 
> This patchset re-uses the per-plane function atomic_async_check() to
> this purpose, so drivers can allow different plane types. There's a
> `bool flip` parameter so the atomic_async_check() can do different
> decisions if it's a complete page flip or a plane update.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] drm/atomic: Let drivers decide which planes to async flip
      commit: fd40a63c63a182aeea1089a343e2f729de7e514d
[2/2] drm/amdgpu: Enable async flip on overlay planes
      commit: 41129e236f14c6c54145c722da06f6793e9fd13d

Best regards,
-- 
With best wishes
Dmitry



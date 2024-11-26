Return-Path: <linux-kernel+bounces-422584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5C49D9B82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D28286772
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59D1D8E1E;
	Tue, 26 Nov 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9P5IhGf"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E311D89ED;
	Tue, 26 Nov 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638863; cv=none; b=ZWl9Xzs0vbRHahP9bl3iXQ2nHau+v36GAjPFWSYxXXxZmY4Wbjd2l9hIW71df5n7zf66J0v7gOhgYDePI8oUu1SlhMurkEpC44Y20J/FfY+NOucjm38jwEgp3D9PXmH8qpsmMi7DVAQK3FZgpa3Fkzf+olO6oBPZG8bpEkq3LLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638863; c=relaxed/simple;
	bh=81kUDK2FfLp/WGQa7o8TpKjDjzqNKseVMcIR/5Kc37Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0Hi5GO6+JudbHVRPQTFJLhJSpKruSpm0ZQBbDmeviGrCT8gEoVKSfH387OlEkSTQx5B7chtkpxaCyYWH1W4qAk8EuoVCvFERMRmkOL+kBRsfRCzEcJkk2un7VFCdudq5r29vfDwv+74CZNSZe8DUHxiHb1Yso5X/qQKuT0hJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9P5IhGf; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e38939a89bfso5347954276.3;
        Tue, 26 Nov 2024 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732638861; x=1733243661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=81kUDK2FfLp/WGQa7o8TpKjDjzqNKseVMcIR/5Kc37Q=;
        b=O9P5IhGfCQT7z0e3U66NUd40XwkRjEu4Wh9JoEoyNKofJ5yul+qqMdH1xuuqOLphwe
         Lc0RZPUl8WfpdEw874juzMkDfzQ1UllQCnEdE7x7ZgvOtYRZPlDcRNS6wER2PZqMBbKj
         i0g4wYgk9fOhoWuvJYFGfiWh2BimGTplMiFOaqUvZ44gfbiI8m66lam2kMRxpBXFhXs5
         Y5BlK5/9YHNsceVSfJ8iaocHk3rZm/3K/k/02O+9syuk9APZHlQS/KL2EFM8iiJ1RyO6
         8P/hK0ObPIqwmck84sOfQ6mQKar2FKX394mKbWTM0rMmg/y90GlykybTTvX9Xa4CidtV
         McJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638861; x=1733243661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81kUDK2FfLp/WGQa7o8TpKjDjzqNKseVMcIR/5Kc37Q=;
        b=mH1+OUtDOP24RNVG1dP/C7cWaIkUsn6QjKr4pltTKYbmyNH3pb83WMJmekhRoo/6Fe
         lKh7NwnmGCwv2lqdOx7GvrgP1BnWCrTAoPOvO+k4eOlmKfpxsWmv6hV2KgTH9u710Nyl
         XKuakt8tJEJXRMj/KQhmjY8Lt+25UVRO8+fSQS7pi5IIfYh81+Z1v2UKJ9FIun9OuJez
         I2U4qqpwDzxh+h5z2FnSN+HILxmwCziw7FKhTPt5BhsDVQi0pieTsqox8qdrEll+a5rx
         gz0gj4NFKVcute0ZzJ+B07wBdNVXMsqq8/ugPA3xhxLah6p1+trKxu4i+ZaGh6ZrokUV
         TPKg==
X-Forwarded-Encrypted: i=1; AJvYcCUNMRu93Oe/0KkwdPI6/k7rv8lBLxgluq5Rd+uGabrHNrszg6icDmyejyK7cnhVMxIpuR0XedDdOyER@vger.kernel.org, AJvYcCXb9TLqxCimjpHLBxnJtW+8peryD5nt07LthI2looFMArh/w2a+sAZb7BUBbAbq3TlnVLihdWLBcOnnbddN@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjtdu7uy+RQ6Plmb6nEq0pCEAGOfCe/AZQjTDU0Boica1BgKR
	+0uoh6zCafhK0r1sT4379MS7csKeFKipinD7CIIfY/lKQKZfiE4t/rwCQOnWOh5DWudLMbx3y8f
	Fy1ii3r2w63/81D0OZu38vTtcqgs=
X-Gm-Gg: ASbGncvjt/NdWLmflQJSEXQGLynyf9RJmAhnlDDf2frXdge3koW7bEJ0kp6nZwhmocp
	lWWpTuGJRyf263Sd0q+skOpK9JA/ADx7T
X-Google-Smtp-Source: AGHT+IH0rBw+xuH2VbnRPCa0ythGe+vmqwLZcKnDRV9jeUgWhfvMABxWAASqLF5EJD3NVkEYkOzdFIsrWd4Mu4/XXZw=
X-Received: by 2002:a05:6902:703:b0:e2b:d4c8:c5e9 with SMTP id
 3f1490d57ef6-e38f8ad708dmr15164230276.11.1732638860727; Tue, 26 Nov 2024
 08:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com> <20241124-adpdrm-v1-3-3191d8e6e49a@gmail.com>
 <f2181c71-db23-4d94-9afb-cb8f2fc46bea@kernel.org> <3a6fb7fd-eb3d-428b-a37c-f04d81e7fbd0@gmail.com>
 <e647e8c7-6df9-44f5-abcc-34db74b8e266@kernel.org>
In-Reply-To: <e647e8c7-6df9-44f5-abcc-34db74b8e266@kernel.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Tue, 26 Nov 2024 17:34:09 +0100
Message-ID: <CAMT+MTSetzODw-cbteQOgEYmEgpiFBVP5eDgjvyHGqofCU=VXg@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpu: drm: adp: Add a backlight driver for the Summit LCD
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 16:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> BTW, max-brightness is a property of backlight, not panel, I think.
This is an oled panel, so no separate backlight device, the mipi commands
just change the pixel brightness. There is prior art in other bindings on having
the max-brightness property attached to the panel itself.


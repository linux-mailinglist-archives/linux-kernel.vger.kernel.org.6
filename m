Return-Path: <linux-kernel+bounces-517723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66319A384BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7611896719
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25A21CC62;
	Mon, 17 Feb 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4LHnJ1c"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED6216E35;
	Mon, 17 Feb 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799027; cv=none; b=g493jJ2ecLRu6zN3xsbiuIjIo7T7IZMYtdAiI5jWfzD5jC/qnDOv86dC9Bp/b8QrZvz62H/vAHsJID4ida0vApMafYCMuiuE8e0b3oLrxYmYQlKytRzad0Zlb0cCOxF3yQ7v9pWxnObezsmKXgFxp0Lm7R+bPpa3JMmOd33g3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799027; c=relaxed/simple;
	bh=77G+qwzoFLoNAsQ3YZKaFAwVbGfr3rRsvhGhU7TMI/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLCuFj47I2ebglJhIBnDFezYl8I4M1KlSEpf7IMiy4HjW7Ph8sizkvCxNFZBN3jDfaqNzGzQ0r8IXGFA5xnSFTk+laJgktgwEF1IHZwh3pPK6Hw3zIwhx5/w8rp9Yv4wd7na57iBmDufFakEKVLCT0D8JdDpUTdMODrzkPK12oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4LHnJ1c; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5dcc411189so789506276.0;
        Mon, 17 Feb 2025 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739799024; x=1740403824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=77G+qwzoFLoNAsQ3YZKaFAwVbGfr3rRsvhGhU7TMI/g=;
        b=Z4LHnJ1cC3JOhEYpgCV2iBJQ+xIdZkdmK4uQWmtKzqCRk11oiYFBxqypKKaO8ocXDN
         ub0wZ3dpH9NmNFKtNGTOb/ADVI8MTpHL8KIALpMWygVZPEF5Z8wWB/Z2bGH10LH8D2LZ
         mkD5mPAFB3ovjS3vdH8FKzUovJApNd9GxQbG08Fg73mGRjxA7qaE1R7pIOxzfaByFYaM
         8YNedZNpCCZ0yaY3wp1B0u0cYKuYr8iwU3j12Tlur83a1TvoktO5og0q5ORUPhrBtgOj
         GmvPEA0oth00q0DXVP8ykL+9PgQKUjyWPTkvUUxsGPU/vVYkQIy/hCiGHhoTI3G7JiqC
         LFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739799024; x=1740403824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77G+qwzoFLoNAsQ3YZKaFAwVbGfr3rRsvhGhU7TMI/g=;
        b=H7xbK58Tl0DQtQ2pDa6UriTdX87vHdebZQCJneB8WLejUApvCo1eimG9r+jr/PgonJ
         EElmjHtj/Zton0AJGWAMz7AZf4AXZGEfxc/EUrqI1hpqaCc7S0zmWWSpaW88rHfwK7Dw
         XtL9TWcZ/Ar/yhV9/SvHdRSIxDVEo7Qo9te5YoM+uHF9MfL0X1pdeuI4YjYlTOGW+Y/6
         +SjDNwUg5+olJgfGcv2PaRCTnZXnMwTarpoz7GGC6WLzhirRZ/ehEa0NPfFxZIEa7Msv
         eEFrtZ07tQJa5Pzn+iOIJnES05cc/usD0pLwUpYEyv2vKVufKdRQbhpispDdxKUkEpS0
         N5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWc+/4PGFw8ajDz65xjfyPfm0BVi8fGY1mZgkdzIJkcYk0eg2XgEp+W7Zf6c9DpttfWG+2ITG5JREO0@vger.kernel.org, AJvYcCXwwRY6G9TiEaojx/I049j38HaJeJAkFuLeeW3wpBhpNfKKgsV/IDei3dsbvcUVRYumVm3pMYdFhOhHAEkC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XPoRRhH91Yf9BKCA+zOS/cBhH0/rf8glf83LdcfqBslCRCvh
	lherTqAzASn0+9wr42aYbjP9kMco1twPPR5cHeU+6hcgIjblIRJ/m58tZj+5csuI4OvdOic10Pc
	inF+vy+qEF0NMuZSJ6m9q5bf7/O4=
X-Gm-Gg: ASbGncscJBUWvfELZbCBMh6jF4VyldLjabk7om7DubcQGLY8ZIzhzFvSN1tr50OqLIh
	FzKOuWr90rpoh6BEFINjNbHR0DWLhJXkAwjai9Pe3HoEE7Iu6b3FVN8lpHi5ziwmcsLh5+cKqmQ
	==
X-Google-Smtp-Source: AGHT+IEB+MJzs+GIv2z74KvmTn3I75FACBN5SxbyoNwzXh0aK5QoppHOlpFhtMuTvychYCVQsoczFA/mnvfT2jm3ops=
X-Received: by 2002:a05:6902:3387:b0:e5d:bf09:452c with SMTP id
 3f1490d57ef6-e5dc932727fmr6866952276.49.1739799024419; Mon, 17 Feb 2025
 05:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com> <20250217-adpdrm-v7-2-ca2e44b3c7d8@gmail.com>
 <40e59cf1-86da-4c1d-aafd-f409d8179167@suse.de>
In-Reply-To: <40e59cf1-86da-4c1d-aafd-f409d8179167@suse.de>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Mon, 17 Feb 2025 14:30:13 +0100
X-Gm-Features: AWEUYZmCQ2KktIIoXJ32NnC-FVTPM5zygmYh9xHWyp5QfVtkMZOiANCC-UiM5nc
Message-ID: <CAMT+MTS016CLK7cawdF2kKv2tpGH-N4p3rqGLBPLkPv4A=j67g@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] drm: adp: Add Apple Display Pipe driver
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 14:22, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Unless the described problem really happens
> in practice, I'd drop this workaround. There's no point in working
> around legacy userspace in modern drivers.

This workaround was put in place after we noticed x11 either preventing
the userspace daemon from working, or breaking itself. So, yes,
it does happen in practice.


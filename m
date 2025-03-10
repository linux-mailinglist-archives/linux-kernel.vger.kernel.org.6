Return-Path: <linux-kernel+bounces-553719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00BA58E19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605D1188E784
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75A223311;
	Mon, 10 Mar 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="PjrB2y7m"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC914A09E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595120; cv=none; b=ddSJGKaKMCwMVgCVthOxgYWDjWhQ1+i8bOEvZvPSmo2Mk2Q0xwcIpOnF89D5Yhx/uN1vnmGin/9W/v0dfpzmn7vbW8D/+hpoObBS799nJo7Ez1dniEpBJl2/XDFvvK8uYUaLrttrq6eDOe9/XggK3wEHiyJU9MWLizABDOukKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595120; c=relaxed/simple;
	bh=WFCjD2pm91x2pAYsF6fwnsfs82FVkPEy9qzGMpxtJ6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2Q62bSpWtynW5kai7dEtZOMWs4+fmrdzuAIJFMSJD7hDSFWurFtikyq+6E909nWrVpuLMtRPW8VMT1glvdlInvK46OQywKXVoSk/L/tuZJfTDbUizWolrkf3lNf3ma/NYkOqCmPUdAnh/+CbBOVn1Eiz1Z1kxRh6WCxE76xTJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=PjrB2y7m; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f916e75fso36859966d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1741595117; x=1742199917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WFCjD2pm91x2pAYsF6fwnsfs82FVkPEy9qzGMpxtJ6g=;
        b=PjrB2y7mZl5iHZ/lgEi4WDivqZrlYlxlwqPek2gGObfPutqyN9upnnzCpvPWFlik6W
         RuxTIYVaa10nFXkPcKeeij7bI3G3stl56+K0Wln2gwH6WKI/eHXoEMMFfuktb5wgJM6U
         rVNTxVWbmPkCVGpw1WiYUjT0TWEtAWh0SWGJtydclkOmIoc/rARjLTqFHyCM52GWeN/2
         z6fw3GeCHRDHt/M27qyLlbS1cVG+xr4Gd/NDB7icKN2cAYaL1Zr4yV/+zP1K24PpUVSs
         j58MfKpwO2daJZJVjZqhZjP/u5z23DGDuGu050eqaug5TYM9YBkHet2VYhEAMI0Q9iEB
         Oa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595117; x=1742199917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFCjD2pm91x2pAYsF6fwnsfs82FVkPEy9qzGMpxtJ6g=;
        b=cLAteEnAmfE2F/3k1OZTHoPj0X/x75mdrtefUXhHFfvyZcuN+8Ot+2kskei6Es+xsj
         J5YV/RdlNQQ5BqqmCntxt76mVcelFcCFM1WYZhCcm9e/gLzN3k9w5yz0r+6kRDzhZUMZ
         B1/a9kF7Q+X98USxVSWocQH49sB9tE6IW5xeXwIlenZ40Kbivl/bxJCiWFbv1/88SD88
         zYbAmaNvH6CQwuekNBmycZO+1uh85cT9oZ0yFYVnGtCkV6IQSe9kp/2mUaJqIf+huxBP
         r0u7FLNNnvCQNV83OVyUGgah2ygFh2DYZJTK5Wr0AEZB/CONW2oQETnBhHvERrACZK3B
         MSww==
X-Forwarded-Encrypted: i=1; AJvYcCWlUm5hLre5SPt/1dRYQbaBQYBH2XYXhM3rfltBh4gYUcPnpAXuuUxV3MboHpkFtLJq22veA+qIwdp4+xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bILz569APguoZoEKbdiJbr0TVvoz1YCJDMEitRu2AEm+zzey
	sZ4RT/gaw8pI8F4PIbouA/qt/6fRL/+FzgHsO8aEKLvy3aXYaJ3URJHIAsM3DRXaaBEz4WpXNaj
	7rOMOOkw2utbmyt/izK6J7PJkX2pmdQOdKeCJskoAAwXmWS7TY/E=
X-Gm-Gg: ASbGnctu92Y5ni02gjYyrbdYm9qkHmuy2DP8fCW+Oj/X9DxI+oufznSzFQGdNM5iG4S
	/4JH5pUyIQ1NdDFgK/yUwELu4+AyN+CiNl62kI5vKV14IjIPYs7iJ0nKRLP6CaFDffzrDOrmctg
	X+/SY+WlsbBGxh27lN2cKBMoxH+J4=
X-Google-Smtp-Source: AGHT+IHFjOxvl1xVryimBup4mUSkgrxpkGXnTbpi/hekfI6Ejselp1PBPQEXjo6x+XS6KiTsDhXEHPG5Wdrkd2vigQE=
X-Received: by 2002:a05:6214:c29:b0:6e4:4676:85c3 with SMTP id
 6a1803df08f44-6e907cda399mr121581226d6.11.1741595117305; Mon, 10 Mar 2025
 01:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228132620.556079-1-vignesh.raman@collabora.com>
In-Reply-To: <20250228132620.556079-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 10 Mar 2025 08:25:06 +0000
X-Gm-Features: AQ5f1JpOKKkQYeVyyUZcg7jIKsetRzi1-yUgZnliBUsBYObogvANsBD9Fq2UZPw
Message-ID: <CAPj87rMqHWtovJy82WXuJ4ZsKg3PbD7Z4hX3kzOYpUyrrdxE2g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/ci: fix merge request rules
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, dmitry.baryshkov@linaro.org, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	valentine.burley@collabora.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 13:26, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Merge request pipelines were only created when changes
> were made to drivers/gpu/drm/ci/, causing MRs that
> didn't touch this path to break. Fix MR pipeline rules
> to trigger jobs for all changes.
>
> Run jobs automatically for marge-bot and scheduled
> pipelines, but in all other cases run manually. Also
> remove CI_PROJECT_NAMESPACE checks specific to mesa.

Thanks Vignesh, this is:
Reviewed-by: Daniel Stone <daniels@collabora.com>


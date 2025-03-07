Return-Path: <linux-kernel+bounces-551906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897ECA572CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7133B91D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550C2561D4;
	Fri,  7 Mar 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JooKpY1U"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650BD2561DC;
	Fri,  7 Mar 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378301; cv=none; b=b5EYu2nyQFSZi4IyseedP398NJrhiW/pJqWW1tv54qduKO8HeYVikyIeVtl5hvahUTm/InY/Ay+xOicHojH/uiJwP7LVJNGNv9TGDt+/gW27cuz8SlU4y5XMgNGk+boJI/RxPue2s/I8coeSeNTIzTDulxKsIiM6J1S1VKF0+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378301; c=relaxed/simple;
	bh=kvUDm8am0hSMA2w3XwH8qyN8rQp+p+otQyAY+cG40dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXYeGZ74eSkWYpL+zCAbK8kA+MkMZ2N3D4cvz9TUdlMilU4sXKtFFB2hZueA6Ru2RGzPPWfSWkeMW3cWABLB3EMOxxZ5oSpiOEv9cU/fF8FG2ihTneqEyaDxh8B47LHc20aJeROByTNmupYM0PaL1R/lt8/dZpmjE5r2M6eEnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JooKpY1U; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fda22908d9so17202607b3.1;
        Fri, 07 Mar 2025 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741378299; x=1741983099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl996EB/BPN5hEnQtgwscpPDmaZ06UU290EobaQCcK4=;
        b=JooKpY1UikjsqgSwEq1z/8i8Fh2puW/gP27hM3xbCZ+FaTLDOsKPRMNzTInetOE/X9
         al/xezAdNjsU5sM2VVCTDB+YeBTpmpHCDuMFtasZKV4qXDN1Io4pb5eOv+uSrtvv7uOq
         OFgvCvr8HQrQAGr0kUU34V9RFtV3oMME7LnLr2w+UU0ZGynYkZQDXc1ldIiKwQfYC/BE
         lfLqf8LmJ+kJwVgU8UfOjfXiyFjdyVbSeCVA5YDPq7d3yL3aTfBy6+Fz/2FdG8d/opGT
         WfBVPevdrvxcc8WgGQ9OaUAjn6zR9vwe2egwWfIJ+dOyHpBt7EdjoDWQmukrnO7oiSqf
         33Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741378299; x=1741983099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fl996EB/BPN5hEnQtgwscpPDmaZ06UU290EobaQCcK4=;
        b=d/7G+YwiV0OLrqpWSVXZ6APHPfclMri8sut6ENSbuXPy9ckr8aI6+ZorijFautphup
         dyzfwJpd54qryR0BvvRQLa80xsKjIiOqgpPkATiP8wW1ljXpJ88kGDGh/sQi3yVwnA7a
         NcUE180gdg9TK3knGlsPoQndFMQUwPlcx7z6KGXf+JgyfwXpGgz6wFLdh9OuV2ZtkOsl
         KGDgMsiezM2HXjLPPZDlffaQ1TMr516QWbBqTN9lNom2zN4NSxXKg/a6y3S5LgfbQg/v
         PVB3XYl2EDF+k9GbQZN8c9b4qhpWyXczT+7Ak+ESoEr+Hlop7U7eFsa8CeI3uJNHANz6
         LUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVLWI+31z/6k9d1fUuXAIU9mIDWzDlgdi73+TiCgObS/mIcNW9wIJdWuHDsWDGJhUfnnBFPFsvSHZWKqPOi3Ts=@vger.kernel.org, AJvYcCXmmCS0WWC4koWPhcPscPcKBrZUoGL4MS4dBCIek1Po3PbYkl8Dt6mFEf+DuYSYijjjsYW9mgZLZIWnGZiO@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOy5ELO6TRjqc36jXbfHLBOLNk5e8BvFwn6QfNzOtL0mLe+cC
	eLgny9YATLR7a9FXcAbN/pINTrOU0ejNeJorZf18vIVDwC2ODN380N2W2FTYW7tu/TViJReOi+W
	hWwrMF/M5FcT7Qt/a3ADW5jbZEwg=
X-Gm-Gg: ASbGncvDa0Y9rtNU6KZbxbDqTQC4PsteWmOqdVyAIRlOu4br67DBSSesG8etokaRlL8
	leF6rkQxqFt7M+LjHrEKmLam2Z2wT9Bj0ptGqFBhS0wW1rKnOYFFd7ccqt6M0pmM3qwy7g5qK1m
	k45/HAa6jSHWkxcx0A9SzMXp+3LrY=
X-Google-Smtp-Source: AGHT+IG4pG20Yrepe041wDSG8GJC3NZSymhx3boOCHZlIMGASclrEFPEzLQZrlRc2a50xWaYhD2crUw3xuwpdrKBiYM=
X-Received: by 2002:a05:690c:67c7:b0:6f9:b12b:8943 with SMTP id
 00721157ae682-6febf2f3a9bmr72669737b3.19.1741378299319; Fri, 07 Mar 2025
 12:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14a845e8-54d0-45f8-b8b9-927609d92ede@stanley.mountain>
In-Reply-To: <14a845e8-54d0-45f8-b8b9-927609d92ede@stanley.mountain>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Fri, 7 Mar 2025 21:11:28 +0100
X-Gm-Features: AQ5f1JpZohgGftYZeUPmd7mjaK_v2MjyriIGwTdsUOZcHqxqIzREXd76VJK0afk
Message-ID: <CAMT+MTSHT92Q=Xm62zfDgTnR0MEw5gKEk1rmvmrQSbXgQbww_w@mail.gmail.com>
Subject: Re: [PATCH next] drm: adp: Fix NULL vs IS_ERR() check in adp_plane_new()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Janne Grunau <j@jannau.net>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Neal Gompa <neal@gompa.dev>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 10:31, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The __drmm_universal_plane_alloc() function doesn't return NULL, it
> returns error pointers.  Update the check to match.
>
> Fixes: 332122eba628 ("drm: adp: Add Apple Display Pipe driver")

Acked-by: Sasha Finkelstein <fnkl.kernel@gmail.com>


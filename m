Return-Path: <linux-kernel+bounces-224779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEEB9126CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC94C1F26AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79A10A39;
	Fri, 21 Jun 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="xDmplScs"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281AEEDC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977206; cv=none; b=QsAs6xji5voosZsqxomXNOGV0fUyEFPIa+TJSHvKZyItjUAwRfF2/itWO0CKCaLzgunlLpNxIxF//J4DBHFURFBv8dI7Xl+puUyVYRHLKD8UjNSEzbb1HbmeDimaa9iOvaATcT1s75JeSG0YQQWdmaTxPsJC1wdAh+3nmlppYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977206; c=relaxed/simple;
	bh=Ere1lwWxpHnhEsQv1+nI645ZaQSfuhySCfH81OCdqI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtkdiktVN1gQT5ZvyE4vbrRoshCxv5DYY9Xeacf3xwTt0fv5SnhJgrYSN/nhduWjP/nOnTr9dRVHO+bkI3HT1bNniFyj2+YKhOVQMMCEmTmZNOM/NJNp6ykgW9g6e1L9TTvAzNMCYI/sAuDHDRnWbSOiPI1A7jR4AN2iJVAELIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=xDmplScs; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70024655285so1124466a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1718977203; x=1719582003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ere1lwWxpHnhEsQv1+nI645ZaQSfuhySCfH81OCdqI8=;
        b=xDmplScsnVjOQHJarm2ADomoSaKkYDzIgejt0baJHyiz9bU1FlZdA5WXbPfMo5Qyld
         JvUsifmDPaCrim5ye0BzHM6BaVQj8ktrYQ5334qE5KLKtmFChi83ouYKr6wDF8GHGwvK
         O77op/weht7YA1aUyIDrlKa4P8rInetusOp/dC3JdsVtCL3e5XO/DJQtI7yTCSLw7SCr
         sGgKOWrIObU7+3QtzdwXet2vOlCyu5oE4+QsaKeWYqvkg1r7pPC3x+V4TeEk52Ofkdqy
         pctNh7awHGPax7Di/pRj8kszSI2hrjJWwWzFFl86sdtbTzMR3KXM6ZMjzxmuhlTuI4w5
         6sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977203; x=1719582003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ere1lwWxpHnhEsQv1+nI645ZaQSfuhySCfH81OCdqI8=;
        b=ujlFP0Mj7tKJsfeMtMB+st89tX9+kBs3EThzjrH9iTB+iK1b2Lgfe80I457unxtgmX
         6VrxRaWuMGCsYQRKKreZudF6q1Q1jHzd8jjlrLagR6vs03CzG5bJ3ww6oY0Rf9NFBhzv
         N7v5sZK4nKkB/+J4lJ95RiMLDnfwsiU7HtmSVyuF8I7uvYLVwe4hCF4AgqRyvIsjUBdY
         2KMmBGGjpAPFhVC7zRPBoavrzcVU34T87eYbEvbWFljhVyn8eck/ouWVr2ibdk73OMR4
         6EhraNlZor8vP0UFsK9RRdAh9apEMgFKy2WAWJDQ+MAVs7ii4T8Tt1+oJHaymV1jhjt+
         V6bA==
X-Forwarded-Encrypted: i=1; AJvYcCVfl4Q4HkRBIhvsPgSU8TofGFh4013Hg2Xb9Re5rbyaYtQc861mWJ2qpGYPZlSKN/JFNLEOHbc7kFa/jo4tnNnypF4pzmgOcc210cQZ
X-Gm-Message-State: AOJu0YwdJvDXTqWeLv9RDFNVN0Q2ld1jeWhafZ9zQwQFs610DU4DbPBe
	yK0rIdoS5r2uAYdw/Opqo+Ifl3BIUpMOPfljFp3j7Wi0srr/73oaAXYJO/eTwvlN9RdUC4ycMWL
	SrRScOgNdI/mjRykQ4JrDqCtf9F1QmsH/3IOEsw==
X-Google-Smtp-Source: AGHT+IHNSvkive/L0tVLG0oV13zogBCO+6olLWgA1mQ/9kJKAK+336sy9TtUrgTi1RgDuWzriflW55CV7g4gRc9Dkqc=
X-Received: by 2002:a05:6830:1347:b0:6f9:5bfc:81f0 with SMTP id
 46e09a7af769-70075a76e1emr9246260a34.31.1718977203186; Fri, 21 Jun 2024
 06:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
In-Reply-To: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 21 Jun 2024 14:39:51 +0100
Message-ID: <CAPj87rMPJvjw368_bW81p2kr=1Pj1Rq0gZeMRZOh+5X-fyHA2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: drm: vc4: Add Raspberry Pi as maintainers
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dave,

On Fri, 21 Jun 2024 at 14:19, Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
> Add myself as maintainer for VC4 alongside Maxime, and
> our internal review list as reviewer.

Both patches are:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel


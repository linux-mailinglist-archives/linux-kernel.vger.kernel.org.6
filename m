Return-Path: <linux-kernel+bounces-181527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAD08C7D19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50C21C218B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCA156F43;
	Thu, 16 May 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T78WJJpK"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71088D271
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887222; cv=none; b=d5LVSMYLsUwxLOHSTmkwUwHzU16wz1m+c9pIl+Ht0761li+vF0ubgVbzO55WZ/uKZPsNIRYonp6/SXRoj4j+QMh/QtTTWt+qohlU83SRfSNI3QAJSX6Iv7krxTpBPto0kLDJXbCiAYRSoUd00+mwxKoe38u2xWKcVSdU64Mjwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887222; c=relaxed/simple;
	bh=cecDsCS1JgN0/FP61uJPZQH9+fhYkN4AuLokJpvFnD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhIt/Ssc8I3EmXnvGeNcfv8BTHtbpFkuELSbQrrnUg1WniRnahEHPVkDvHBsM6h4hLY9MmL3UVDA9a+QYz+TzqwPxWN1+9mf/m+2+EHg5Merv639HRYilEOtSTXcMOn60f30bELnnffxy/lLWJB4l4iy8gEcmfCGcqJDv8EBueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T78WJJpK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso59078885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715887221; x=1716492021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHSzNaB00onTGCVgdV5WXuaIuSKL0HrxfhXFYoCqc/I=;
        b=T78WJJpKNSF/EGdllf7oVLmKlN7E4izQ/kbdwOcfo7FmVi5BOy4Vx1SsHCmTA+xJIj
         2UMS2gA3zxjQG+aKhdv+XuUh++otUeo5J5tQ7d9PfNfNcCYNFsYxV9dPvKUX2iCccQCE
         qN61uWNo19H7xjeX0EOWIoCwsPKFU6MDX+duA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715887221; x=1716492021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHSzNaB00onTGCVgdV5WXuaIuSKL0HrxfhXFYoCqc/I=;
        b=arcumN3g5hMqTSENFLp4l6sMFmR1yaA1lXgVE3hCyvAigNDfaJLUzq7SM58kLrkGqg
         cWfcPLrV7FsvIyZu5Xf9V04FyVDG2GQOmoNbnAX0Ie+hBIUnY7MN2oDu8Y/sUOMmOM1Y
         +JDrFbVk7Gdqf9vjE7MyqT9AlLgCA+8jHYYOQNROJbSogIzFfdAKAwgSAZWdmR2c7Tkx
         D1ERGFkR0JdQ4lsb/501y/kqZ4Gi57lXN1dR8iYOaFE7taUqT7M0KFgyFbDpusOIqwXb
         7G2XaVzpz8nX0u36PkdnF4MNpwA8L9M23Oh93Xs7xxMT1wDmb2Ng3zZgHfP6Q8mQOmhp
         VgVA==
X-Gm-Message-State: AOJu0Yycld/hD2uErCsVvBMR0JYgimwGJq70Cx+m+ms4C3+2RsueT1Wn
	5zWBl7r2qKaU2UNug9ryQK/PanxNLsKcU59CXL29+bUsjEEBHp9YC5msYhgUiA==
X-Google-Smtp-Source: AGHT+IEl9yDXsJVCh8Q+woUCQGWBCD92F59UBfoXPHHzCsxbLL7z7A6t1AFJMPRzTRnJ3zY+pojz7Q==
X-Received: by 2002:a17:903:1c9:b0:1e3:e081:d29b with SMTP id d9443c01a7336-1ef4404fc55mr246620125ad.45.1715887220716;
        Thu, 16 May 2024 12:20:20 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036135sm141967705ad.205.2024.05.16.12.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:20:20 -0700 (PDT)
Date: Thu, 16 May 2024 12:20:19 -0700
From: Kees Cook <keescook@chromium.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Stieger, Andreas" <astieger@amazon.de>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Subject: Re: Extending Linux' Coverity model and also cover aarch64
Message-ID: <202405161217.4984DE258@keescook>
References: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>

On Thu, May 16, 2024 at 03:28:16PM +0000, Manthey, Norbert wrote:
> we published an extension for the Coverity model that is used by the
> CoverityScan setup for the Linux kernel [1]. We have been using this
> extension to analyze the 6.1 kernel branch, and reported some fixes to
> the upstream code base that are based on this model [2]. Feel free to
> merge the pull request, and update the model in the CoverityScan setup.
> We do not have access to that project to perform these updates
> ourselves.

Thanks for this! I'll get it loaded into the Linux-Next scanner.

> To increase the analysis coverage to aarch64, we analyzed a x86 and a
> aarch64 configuration. The increased coverage is achieved by using re-
> configuration and cross-compilation during the analysis build. If you
> are interested in this setup we can share the Dockerfile and script we
> used for this process.

We've only got access to the free Coverity scanner, but it would be nice
to see if there was anything specific to arm64.

> To prevent regressions in backports to LTS kernels, we wondered whether
> the community is interested in setting up CoverityScan projects for
> older kernel releases. Would such an extension be useful to show new
> defects in addition to the current release testing?

The only one we (lightly) manage right now is the linux-next scanner. If
other folks want to host scanners for -stable kernels, that would be
interesting, yes.

-Kees

-- 
Kees Cook


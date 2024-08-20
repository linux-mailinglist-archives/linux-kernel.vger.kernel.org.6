Return-Path: <linux-kernel+bounces-294494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B671F958E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735782866CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454681547E1;
	Tue, 20 Aug 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYxlTqj8"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890514A4DC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179919; cv=none; b=b1sWUDUSbazZXAYHu9LjXwkwUsu3yqAQyP7WFgC0FM4gaS2QNYrMaAMKEIac1n1tACJ3E2rUDR3dZv40jkz5/P6uXCthwduqYdEW5sgekxDsX/gELzuZnaP55M+j6UD2vD8bLCTHzGVRaE8UZ6C+X1Ya8+ufYi0eculjoL/UOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179919; c=relaxed/simple;
	bh=D1EFFFdDIAdlvHhSJDTq9mzYRmGqipFW8FpnDRMjTVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIpsQ8HeEeQnr0xQafxb/dDq1Xtb8keGkyG6/WBQ91gwswsI4Z0aSJnFBColg6yS+KtqZBh+K+GFlV/6fD6CC0N5yIrfLjAAq8tkNhRyYlv5YSRbI4JPuzarj2DKuzrUplMkxCqj59jAdMJnYdaJLPZWc7Pr7hfC+znmxGBCqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYxlTqj8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20353e5de9cso36695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724179916; x=1724784716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPcasQ3kvREVJkd1ucwqptMMNYCdpn8YRLNni8VAEkM=;
        b=vYxlTqj8/vzenvd63/ltxu0YmB+5Kp9TOW3KhJ4CJlMzvZy9DUFQjyTSLM2GoxZxcm
         /CywuCHKWlXyrXc5482kEW5Y5mdLO7NQSOT2mpwkCet0eFslvkbB/wIv5H1P1NaqtN9B
         X1fnGdTbT3b0vgvVBrvSqvbMeulKFSmXndnpEfPJMIJVqZzFaMwfmzP4IsFv0BfvKF20
         U8Ufdm0esoJzTh2i7PDVPsknP7HhDEDeP4/JxVDXieBlNPJetLgSV4Z2J0TDZOQbm9cQ
         SGpOLNS+ui77AnjzUnw/OEbO/wyXoF2NpIBriZx3V3CGLXMgsluxVUbdJt+o1SeA9p5c
         aSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724179916; x=1724784716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPcasQ3kvREVJkd1ucwqptMMNYCdpn8YRLNni8VAEkM=;
        b=HygYImcXLcdHkbGXpTBLcryApgoaYA8L3tDJxZcvgLGgHPRU6Decxo2rjXvChBxyxt
         csYXaTdu26pBTg8stnsKH/SnOjM7QQ3RJIVrG2T8nrKup6w3q117r2YQV/THUUtRnuqa
         jOSsob7LC3Ama2B2+ZCyjAW14Y71fEGYz0x0QmFDrTpMZE6RjMrSj2eOcXREZxqxSHfX
         jo2jEqImmdfpAN3ODiphXey7fSGxBXHfv8RoiJPDktxmpVBcba5ZOae7dSJdXqXP/Kcw
         O6FXQZHv1N1E4yF49HGSEfvxLiWimCZhUkNsDwGHCLmQ97ekyxfdZmoeoK1Qxrj/hSZP
         0MuA==
X-Forwarded-Encrypted: i=1; AJvYcCWygUl6feUn5OBU56iofRlsaQAy23iToRTI1UR5Rb8zA1UHCqL3as7knFaVMxKNKi1/S4GhlrXXi2ESJTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYf7DFCfJ+3JNjLauBS/rnehFvL5EMJULQvCfXm0bSo8PQBsb7
	mzYyV9AJJrHB76DK4DAtHl8XK3BLgRIOhV6kP/zhsS4EWJ0LcU9gS2J2VcyfGw==
X-Google-Smtp-Source: AGHT+IHlDkP8H0tPbST6cYiculvDLz+lyq8/yljE7m2WAxZqX1yv2ix29jjd6PU6xhlCp5StM7Vgew==
X-Received: by 2002:a17:902:dac5:b0:1fc:719c:5d9 with SMTP id d9443c01a7336-2034ecd1e2amr2528815ad.25.1724179916100;
        Tue, 20 Aug 2024 11:51:56 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aefa520sm8538550b3a.101.2024.08.20.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 11:51:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 18:51:51 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH] Revert "scripts/faddr2line: Check only two symbols when
 calculating symbol size"
Message-ID: <ZsTlxzwRK2tCTk68@google.com>
References: <20240812230121.2658059-1-cmllamas@google.com>
 <20240816125046.GA24389@willie-the-truck>
 <CAOZ5it0ih05MBMzQxKuD8LYTL-by5qppjj_YXqA6iuyikm0_6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZ5it0ih05MBMzQxKuD8LYTL-by5qppjj_YXqA6iuyikm0_6w@mail.gmail.com>

On Tue, Aug 20, 2024 at 09:38:46AM -0700, Brian Johannesmeyer wrote:
> 
> Acked-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> 
> Good catch. Thanks for the fix.
> 
> Just curious: What compiler did you use to build the kernel, where you
> hit this error with 'update_irq_load_avg'? I was unable to reproduce
> it with LLVM 14. Thanks!
> 

You should be able to reproduce this issue as long as you hit a NOTYPE
symbol as the second entry. Using aarch64 and CFI_CLANG will make this
scenario more likely to happen. I believe I used the following:

  $ make LLVM=1 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
  $ ./scripts/config -e CFI_CLANG
  ...

Cheers,
Carlos Llamas


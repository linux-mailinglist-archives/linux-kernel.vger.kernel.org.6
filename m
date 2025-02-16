Return-Path: <linux-kernel+bounces-516604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC02A37492
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB293AEEE1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DB71922DD;
	Sun, 16 Feb 2025 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPGdiJHV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD69450;
	Sun, 16 Feb 2025 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739713768; cv=none; b=u4YH80ZjDPYCnCPyZQF3tnxTRyIDMLoenm7SeePup3LwZOsc6fWwc4dEvk0jQuOQFPyRMOGVE+jz2p4sqJMzevAphVBIAyN66uTb6sgYYlhXWBdfAFfweZPfWXmAlophCqQS2D8sRm3odiqb66CioYQtrXXnMy1wtVCYzkAxqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739713768; c=relaxed/simple;
	bh=S7e8sMABN2b7K5nBtyYMhJN891hqdkLBfQA9iEPb1kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smw0bSJshnbEEG+qcR8ExxzhvM+4cDg0IHVY0rQuW8uQCSZDF1h4YwxcvYk+ygt3wK5Cuyq8I3dzcF6etCmzgDrDwRAWJELEW2sRPev8ehI0Vewdq8slqN2a0N0toLmZzia0kC4kKXM8ND/r0prqQLHGM9RgWKfWQOveOMmpH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPGdiJHV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f8f3bd828so6676655ad.2;
        Sun, 16 Feb 2025 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739713766; x=1740318566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7e8sMABN2b7K5nBtyYMhJN891hqdkLBfQA9iEPb1kM=;
        b=KPGdiJHVpWJABUpkRChxrP0vTjxsPVDJ8IVmnRnMaCRoiZCfYy6JU2M7axOo6UL38j
         Zua+rvexD1+eISWiwqjz33lbRUyaLlgt90s2r2YtnTWvNb2F4tlk9dZ+pdQEuF0BBswZ
         liGtfUttj8XGwNMmL4LvEtTrXdgcIJ9tAAUn08cII9HySvHa/F6NtbMRlYSgO9zyqgL+
         2cvNQi5lGYLcYH7quONK5ESR5fhCAbHn6TXvHuSs9RqNOyf3K9hnec5gO/RDydUz3Emq
         EG3O5LfaGNcFQ2QaVBqW4duiTzzGP8itcQqlzMIueT+mafIK90KoM48nDLx6/CQfiN8P
         Ewvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739713766; x=1740318566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7e8sMABN2b7K5nBtyYMhJN891hqdkLBfQA9iEPb1kM=;
        b=F5MuNgSHAUT8I6FsswaKwcYnmsB+773tKRkCD702Z69P3YdUOvG8YxDe5OYb6SyH3S
         45BFf92/SYSdTTRZGYHy0WdRJRWUNVd9wqs2xA15TqnOufKS0crBiMlNpM+gjFLiVfhL
         plaZ7K1Uj8Em23G4o+9d0OyY3vKR6/7nClsnl4R4ySDA0/W+4j3NQAzcnvL1hmnpe+On
         bsS5qf0qpsu9C1U/KC8Ef7/4C6JR1WJkYmMBG8y4aw98o0mR9MPwAzvNFGgVDV/22ovQ
         6B5S3i3zCRBHgxygODHWNo1NYohsLt6dy9qS8ZGsrMDtvcalee5WRCMUQQUo9SC4fKd4
         /O/A==
X-Forwarded-Encrypted: i=1; AJvYcCV77VKsmJyNNwYF5dnG4pGsNN+Yy6OdbTAp2HCYpjB5wxSm8tueM0RwIqJ/gH2sSeOBInORI+5QLPU2CgAv@vger.kernel.org, AJvYcCXnoI01mhozx4Vg6jlOT0WicbFig7pv4jQKLGvEPrbhJ6muX9Z9gpQdo5pUm07AcWJavOYG6S8+f+d6@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDOfQuOT+F+VKNsHLwPzyMZ1Jiax8WsH0Bs0tLhivmw7GIzFl
	T4RSBmKCl04yPIfa+t6MaKBidIDO2t73RNFDL7MFu53Ehgk60ztB
X-Gm-Gg: ASbGncuos9YWGTuVcP2OO5kB2Z6rTLDXxd68UNMm6LZcCdsf7EPdWZPAS01wGKz7xPD
	32Zri9EBNz4IAYdEwfo5T3OHIwjV71gvOvihCyNpcuhG9W7YIpVOe5Cwz4b5pFl8dRGs1GBQ8vK
	GIf9J7p5m9vpUbN1s0P2bdtjXz6/NKJaCEUGQ139dmuZPofyijPADUBBOCKGDYtIMssMYh16tzp
	c/yLvARVyRidqCwokS8G77WB3QpUnxCHfTSs0c1M+8X2TdY4iY0keIM5gOdaOGdFd6RUq2eeAmZ
	tJUBBv4YPF6fNZvlNSkv
X-Google-Smtp-Source: AGHT+IFXugIHaSfIg+wP+gViyrZOahiwtYnx7ACfVX1OGYP3jnCr/KLLZZXjEFpO+K+dZuGLwR5xtg==
X-Received: by 2002:a17:902:c94f:b0:220:fce5:977c with SMTP id d9443c01a7336-2210402b42amr36437495ad.8.1739713765745;
        Sun, 16 Feb 2025 05:49:25 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349056sm56776745ad.22.2025.02.16.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 05:49:25 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: piotr.oniszczuk@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Date: Sun, 16 Feb 2025 21:49:17 +0800
Message-ID: <20250216134918.1357069-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <566E6F11-765C-4415-8805-55DFD3C2BD4D@gmail.com>
References: <566E6F11-765C-4415-8805-55DFD3C2BD4D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Piotr,

On Sun, 16 Feb 2025 13:37:05 +0100, Piotr wrote:
>Is there anywhere repo with this patch applied to test it on rock5 itx hw?

This patch is applied to 6.13 and I was testing with armbian:
https://github.com/armbian/build/pull/7829.

>(asking as I can’t get it working; even with hdmi1 only vop clocks like here: https://gist.github.com/warpme/49feadbe1f53ea31fca76f41d5bb3ee4)

vop has a dependency of hdptxphy0, so only hdptxphy1 won't work.
If you are testing with 6.13 or 6.14, you have to add hdptxphy_hdmi0, and
if you are testing with linux-next, you should add hdptxphy0.

And I recommend testing with this series since it adds more display mode
support to hdmi1:
https://patchwork.kernel.org/project/linux-rockchip/list/?series=934232

Best regards,
Jianfeng


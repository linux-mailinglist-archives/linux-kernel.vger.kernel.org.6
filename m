Return-Path: <linux-kernel+bounces-531420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4AA4404E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A8E17F4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852E269817;
	Tue, 25 Feb 2025 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG9jRTpj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C80268C40
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489002; cv=none; b=GJ5P8Tvkh9HzyunBrdaePru+gjw1+jXO2otFqOwGRBUYHHxD0CyX5L+yYE7qsdgvHPMwtDvLQF7AufwPeHdA10JQh6y/KH0rulvWDU3OuD/aZywiwBMEubeg56v1syd0vgE/6iiCap5chT+SRmvX78zKspJYGe/i7+Eu4RGRNtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489002; c=relaxed/simple;
	bh=NmgbRQa5MS86snbaEZWHJjQdnfuzUG+P83d5Gw//rMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hfJYjZIxFmXHE1iY7Dz1m/G3DcbzFLOkX1VGNnEX2lV/Hb1crAx5dIQhL9p0em4HuTLwlo8AgvAH0uhpKpX3HIcPykKrrOY7aMFjecx8n0Rp8hlGnd4vVjIkSm1LfSXEE0wkBHUrQWKt8OIhi5JmsCqoTkKL88d0Vi2iCsMcIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG9jRTpj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220cb083491so11553715ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489000; x=1741093800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmgbRQa5MS86snbaEZWHJjQdnfuzUG+P83d5Gw//rMo=;
        b=OG9jRTpjQlDwu+Yc6sJHuJSi3Y8gAJOESzts/Nmq36g5A/GuY+upJX1EZLaZXGkDFp
         XDfrmixVSQtCpNoaoGhBf75PtBkXHECv6qp/6QKUSWfmNdc/BD8ZEm4hinM+IKPOu/Oi
         AIyk8Ij4jH9S0N15znpmcgIDvLfZUyMojugLv99FkQmLSFTrxjb4ff/N9LmT+sKagLM3
         AGw+62wg8BxEwNsStfPwRWB1M1WUN0tVdyzjCuRwrYFeP6SLNCE4piGAXSIVTDF82S3G
         Hr3fgYrbA44OPDlHgYCmtn1ANGygsPcMI8V+xglyC6vax1FSlWUmJo7DFQpYsYbWyIKF
         jwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489000; x=1741093800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmgbRQa5MS86snbaEZWHJjQdnfuzUG+P83d5Gw//rMo=;
        b=fjf5++ir5zfqOd8jSHfaRKk3LJf9QLMDxtk2zPwf4/+hW8QBStXgHwVIB56QPWLif6
         ftZwdYI4aKHKd/AEtvw1hmSARyvg3N7EzxkxY6RSg6PlQia4xsPe0dgfQPhhI7VqXvTI
         zq7i9WTkxx8lHEOWS5xPx1MxLVAYopCy4vW5rC9Nb1he8l6m8yXoQFX6NK8mMmDvxCSQ
         z9llwXGEZD2xHz9+PucSwxSpZ8WLpszJ5B9b5Xf+z1/i9n8nXt4YV5TZlteKLy/FShk6
         pKgRHx8cOBjWGsl7koOUsg7qVKOABWfvR6lPLE0770yCeziV52SrYpWc2ubaaGngXyQH
         QZBg==
X-Forwarded-Encrypted: i=1; AJvYcCUhL6TfQrONNAm3c2mplfXKotXsOmWRkHT51HDHZz/rNq7GV/DnvgWznkq9y2WnMFAsYB0l4D2DiqEbK6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcO2SUmHiZEaMaVCJ9HdaB2gjSioRjmC1jDJwmcDGsLO804AhP
	r8/U0a6ZqO9ceKyJfDy1X4+HB5Gn1hs5cNt2are8YVI/hHX9GiXWSWRnnwyR/pwT4Q==
X-Gm-Gg: ASbGncsl6g++SPOX3iG+FgMuGYCkg9Kazq93nKN3KabLQ7h8orRi7ZljrObL6clh/Tz
	xEGBVWCaM9Uix1dTEZtozvxDMNwG5qXOmGZmVHrsPG4a6AOp5EpKmUmdIG5u+on9BIWexRTwoAp
	y/lfFIUX/5Sxk/ZsH4GuoHKu6C3k+JfKDHSVDp8zTSNJTABb+1MFoYhnGQuMiuJlfhcl2bpx0nH
	teKphT30p0VWgQpbg41rknmBPIddaiOjI3aG6czwlYYPGl8GaB/IM/36PMmdXELMJ9x9D5yEmkn
	WLlAcWKfQafXStcTxOLMxCwmBNW57m8Lus4hUDG3wQk=
X-Google-Smtp-Source: AGHT+IFAOl04FQd9DYpn24JBIFzBlWQ2MlsHQBRasgHUbKqN9nNVyvOkNVWTDVi3kFIyQpABTIYMWw==
X-Received: by 2002:a17:903:230e:b0:216:30f9:93c5 with SMTP id d9443c01a7336-2219ff56b99mr109777465ad.6.1740489000319;
        Tue, 25 Feb 2025 05:10:00 -0800 (PST)
Received: from localhost.localdomain ([171.217.43.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a7ea0sm13413485ad.177.2025.02.25.05.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:09:59 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: phasta@mailbox.org
Cc: airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/scheduler: Fix mem leak when last_scheduled signaled
Date: Tue, 25 Feb 2025 21:09:53 +0800
Message-Id: <20250225130953.100871-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <141295638b73e885f51a4b82ea7e417a6b0f5140.camel@mailbox.org>
References: <141295638b73e885f51a4b82ea7e417a6b0f5140.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Oh, and importantly, I forgot:

> Since this is clearly a bug fix, it needs a "Fixes: " tag and put the
> stable kernel on Cc.

OK, thanks for reminding.

Qianyi.


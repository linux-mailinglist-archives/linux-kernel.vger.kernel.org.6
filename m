Return-Path: <linux-kernel+bounces-435551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540159E7940
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152AF28314D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CBD1D04A4;
	Fri,  6 Dec 2024 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIkE3k8Q"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CFC1C5490
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514523; cv=none; b=Yqbx/RYVbhCqwpEZcri5xbI81TxXTXm73plmotw6EmyNx3c3p36xvaaAElYd8PUtIkcocw489l2s6U9I7oBsL/omBFy25Itf7PqaM+MUEn4V7LqrvPC4eUyRuAaekisdb4JSZs0EYDZHY8nTG3invqUYoKP9mOpwHOuz+g1q/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514523; c=relaxed/simple;
	bh=q4U1LXC8ox3d7UwtdidJGxH/oi2EvLePFYdjxr+tYug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBQcE0qTZYcVT5RIwIbNIdD/xRwEwdm3uBYYCXYQD6nu65ljumGpaiFj8cjVFamkbgoB/8wKlQTUPhSROBwM7N+4yXfEweYxC99pzPXeXeR3qXPlxM4N0r5nSIcwIaLfd+GhU0ypZhmHBEWb6AtjiOcbAXtL7huzhResdbLStrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AIkE3k8Q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef79243680so72977a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733514520; x=1734119320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWHOSFnp6YO+lsoFcP0qwFbbFIGSFxBuBWk/HmNV+8A=;
        b=AIkE3k8QipZUTwj+8z9mcrbFfFMGUAzFaMzDK/7miqwpBT871sKq4c+Miqxc+ZHWd4
         RGYqOWy/cF+AuvFasqTSwAni2mZBtKv9FbGPSM2ODgAS4u9pqmPKGB+LDLfoI5CrL7ng
         Oa7aPRujZbXaoaLpy1ut91AqpXa8ayS2aN+EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514520; x=1734119320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWHOSFnp6YO+lsoFcP0qwFbbFIGSFxBuBWk/HmNV+8A=;
        b=Nr85LoGj25rFBzy4pMjYvISpGomKnJUGdi6xu1hRGztmUzgWm6SODA10vyLB+KxbA5
         dGU/Dz6GoFWmq1zzPxU85owqCkricFtBFRAS/ra8CjvoCLeB4Zcn0MXA9modSKfEUhFt
         kDU2tAh7hChdl56HkDDY1y8hWnK5oHpLKTpFsslbkU079e+WSM7/XGwJt0nNwS0nx7n2
         gEudjveMo8Kc/Ss0F1nSegdZ7AwwlZMxzZhwDZqjKq2ji3YIxHHY+qSpO8y/6wBiydjl
         MU75HOfzwjrAj78EDUWBRPP7Qf7Wj6Nd7k84ZTA7KoP99A64wH0JH9scwAqX1+p1oLlw
         KMMg==
X-Gm-Message-State: AOJu0YwEU9kY6S+CmcIdpwNjkO0dyN+Fxhcr3ySBczr26uFqgG7zcrI9
	trG0qPU+Zc0NFFphQch32BhBhJGgpAPNWsa/zNMWj/CJSDaLWH7pgNg5ChF8iQ==
X-Gm-Gg: ASbGncsOvFHOYnKaXxgZvkaOXmYow+8eMa7j/w2kLA7Q//PjXsYRN4otcnC1ygK/D1W
	qZkSIMpcPRQvG1kAxUqUP3DS/K5+fPCuEKo/vNkyRVV5GrDqC6YC5uBmy62a/m/LipITK4irkPz
	xP6WL/RfhoCsm6dZMvzHjywY+JMYw7mMPXZ9Ug3PIghIJyb35UjVqmjpnNoG34hxPtyseY1FpB9
	WjSLXnTomyweZQKkdQhd4WKh5c0Lfpr2ka2xogAeHQrtzNjo5E9Orx30eTHBTG3chLqErTp5bFv
	B1bPYMVzylQ=
X-Google-Smtp-Source: AGHT+IG65sTKlmsqpI7GdM3gNDUVOxz/ZHodlOQCUdzYHPngVaIbt2p5YZVSA9/sCstTA9tW0wBaJA==
X-Received: by 2002:a17:90b:3910:b0:2ee:3fa7:ef23 with SMTP id 98e67ed59e1d1-2ef6ab23270mr2485494a91.8.1733514520663;
        Fri, 06 Dec 2024 11:48:40 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ef45fa64e0sm3536432a91.26.2024.12.06.11.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:48:40 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] remove can_do_mseal
Date: Fri,  6 Dec 2024 19:48:38 +0000
Message-ID: <20241206194839.3030596-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

History:
V2: remove the can_do_mseal (Liam.Howlett, Lorenzo Stoakes)

V1: initial version.

Jeff Xu (1):
  mseal: move can_do_mseal() to mseal.c

 mm/internal.h | 16 ----------------
 mm/mseal.c    |  6 +++---
 2 files changed, 3 insertions(+), 19 deletions(-)

-- 
2.47.0.338.g60cca15819-goog



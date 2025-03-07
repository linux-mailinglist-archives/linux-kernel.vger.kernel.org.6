Return-Path: <linux-kernel+bounces-550756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2AA563B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E816D7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C061FC0E3;
	Fri,  7 Mar 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouHuDhUH"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B71F94C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339564; cv=none; b=l81O+VjMtTLNRVDpNo4qDwLU1gW6c5iWDsiNarDEAoVTK9LQqQDKCf2NYIKZA04rksTOJ/1YzLA1sYR8LiVdVWjAAVem4dmljXjWDVrlZzlKghaAGrRYY8F+BJXY9oi5a6ECoGUOAHuUsAn1bgaUnhDE3mGrCwerOM8cVJv5pNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339564; c=relaxed/simple;
	bh=lQaPnTMrNhYTA3wyfboQpWCi5jJ+nnpfBr+z980m1/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH0CyluPFILAS9b8ouLs6RoHyjg3nvUG6K5GKablWK/Hxvvmez/iPXiflMltPE28m0wkWEAPGHstTrqYUd0vD8QCRl4MljHsr/ePuzNNbWPyHSKB1t8pRgKJ2MsrNTBgnpik8A3BBkP0A7SshVYak8aweS9d7rfj3oYiMk8Dn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouHuDhUH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so1634482e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741339559; x=1741944359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQaPnTMrNhYTA3wyfboQpWCi5jJ+nnpfBr+z980m1/4=;
        b=ouHuDhUHSMb12TdkwLZpuKT8FZKNwbAx4npHvyArljYQfE1XGGPcozIY/gvpa4jgYz
         M5jtjmArFYlsOocQZEUrQ+NJ4/FXHXecbTsb/opyuy+tQ6OwjTMXUHKFHx6/eN6nc5g4
         kLreoqE715zp4mIInTcSywSg6WHNVBl1dKnsPIZCe6hVXWL36YVz8S0iFF6wjcsKWMvB
         3uPZyTU/8LntyDwesu4widE1hdU6VdM97weyvkf/rrggIwV0O4c9I3nAvinma9MdZkmr
         GvyPrjcApq7mCBBlLKFH9IT9+KvB815YwVPvPJUEYRwgBhaWOepWjcIs3O6yraOY54nD
         B4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339559; x=1741944359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQaPnTMrNhYTA3wyfboQpWCi5jJ+nnpfBr+z980m1/4=;
        b=XALOYCbQTWY2W5bBhO5RzBJ8zWVdnNC+PO+EOaf/1IfT/akGnPMgSMrLX0SQpou7jS
         bTD/EqMLjjJ91kIZbZmlpoW9bUi8bmP5dIIaNWaeViTCJwk5+rG2br2RmfPmamcmklKg
         YEiEel/nQobHIyGCqeoGllB0Zw4mbFa7XZdvGPme5IYwCppPpsAwqNZimcb/tMEBD5rG
         w9X7o1enxYVm5vUUw7EIP4VHMEXeETLOzr9cK25VejiHVfUo3wB3d+0SUbG22LVe0t2o
         TUucsoQI4nBYDAGaAaJON+WF0xxdcQTUaoTcyO4idtcaNCoMeX+xBKKHkVol4wrMYQvW
         884A==
X-Forwarded-Encrypted: i=1; AJvYcCWhuzNCIl7ooa1pkdAjPmJaNjOB/kLvnITrl/HwehuB7ic95j+s24EHcWweQlfkpcJqWRmVlu9vRTMM1cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqipeUj1n3DGCMaYbxlYLx+LioUvyDmCHuXG90W/CTa4l+g7ny
	BMvBhFNyFUk0iuM3ow4i40itCg+pDctZGUzWy7iALAvtou79N8u7nzaWK1uaz9JkqraKHuTX0nP
	9FminT4M716kHkw99bRnZSBfSMgiVFH2wWcaEyg==
X-Gm-Gg: ASbGncuDBAP3RBYblcFrjR+D3+MaEj9M7j+ETZh1LN4PUsmC2+CMuO+EPoa0IcyOHww
	JgOevKFf30d5QWASwHAnWNCmHBhhb0IDsrZcIUVoi3UsGJXLJJyzkSh5uZuvt4tzaOYkx8BAp96
	gv6+udM3iVHVvML1X8jOTph31TiQ==
X-Google-Smtp-Source: AGHT+IGTMFg4rHCTu6ttxl0Mr+bTUADbHsG+rzinRECLP3rop37VYukVmNbikYkvL3gcLQNvGyPZVOEAOsxdj/JgNGM=
X-Received: by 2002:a05:6512:398a:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-54990e5d965mr764732e87.13.1741339559573; Fri, 07 Mar 2025
 01:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305102540.2815-1-hanchunchao@inspur.com>
In-Reply-To: <20250305102540.2815-1-hanchunchao@inspur.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Mar 2025 10:25:48 +0100
X-Gm-Features: AQ5f1JrjUjFMK8KGTJ2kXkFBNIlWquflwX47xXJyI38Ro8Xernzfe-B_XkKBVe8
Message-ID: <CACRpkdbv0f+JjLoWRYO45BOskFtUh7FYnHEKamapvqvhSdezyg@mail.gmail.com>
Subject: Re: [PATCH] drm: pl111: fix inconsistent indenting warning
To: Charles Han <hanchunchao@inspur.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:25=E2=80=AFAM Charles Han <hanchunchao@inspur.com=
> wrote:

> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/pl111/pl111_versatile.c:504 pl111_versatile_init() warn: =
inconsistent indenting
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Patch applied!

Yours,
Linus Walleij


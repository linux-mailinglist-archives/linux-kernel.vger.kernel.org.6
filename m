Return-Path: <linux-kernel+bounces-225052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858ED912B18
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A22864CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007DD15F41E;
	Fri, 21 Jun 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mlwL1WeG"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45910A39
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986579; cv=none; b=CRquTSx93AcJLKPlaLgxK0y8oeP/CwQ69VjjDlG0t3RTMbMWQ3qlkEPK2KG44ATPeMxbjJKrnPsAKxDDN8xnyPoDHF1uUk1SJepjNpS3Mrdy2RgstjMtLWzYd8RFn15ed3fcbxA/vRpSbwzfc8tm453Xkp3aMlZl0NJlQkNrlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986579; c=relaxed/simple;
	bh=18fpC2mmrMKTv3oRpms3UjeHVx+1bFxG7wEgjdV3K9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gqn2RjvN6NM1gm3g8e9CmCQuhMjmK2T7bM8CAPtxxPEgoXWAiq0n1JzZEY9fjO9ylRk09+mwztQO3WQmwnWcfrmKKct05b4Ea9JFpqr7fnDcmjY8oKWd/LT72yorLOcNw+B4YwsCK0A95KFgCM9/CJRXVqjgLWsuPHFfP+n8jZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mlwL1WeG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6ef46d25efso258209466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718986576; x=1719591376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18fpC2mmrMKTv3oRpms3UjeHVx+1bFxG7wEgjdV3K9c=;
        b=mlwL1WeGBKGvtLCs+CNbMDsYwbwpdloSAAW20Hz3PJ9nCh1coLf6rleBSDbqo9EsSZ
         cqENGNajoz656tqdba5ZeAn6TK3b44uyplB87Qs2G1Kc0y8z8GmZf5llq2jUtInK/+Nc
         VQbKCRbIoV1I4UhEIpo7f2wL+3Yic355BFs6Boibb0t80fp2o7VPyfK0Y36g70x2MQ9m
         /bDohb0GVs0lw5y74WNrByP+z24xDt/7Cil4MukJ/iWeh0m4gxWHsV7ibwkkR5TFR0Ge
         xxFN1fjOLfOEOAZUhxfux10+PbOV5OA2/xN078Pu32EiTVxuOiHiuKyhZ8T5B/W2V7GD
         YZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718986576; x=1719591376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18fpC2mmrMKTv3oRpms3UjeHVx+1bFxG7wEgjdV3K9c=;
        b=O29eZrnraIzc07iGH8Z6zh/xEqCj3IKpqZLsXiwl01xjFZwkOXH7LR6bDftYkQgzNh
         m3EhOs59RrszuaOSt2QI30Y6Two6THHsqfTXhUZfCb0mofO4TzgLUvhqoALRkF7J7z2i
         aL9RKR54kSDYlCy/6kN37Kd80WIQwLkirblpRiq0mlUx3vaMsXpn95eJvse6hCM/BHC0
         luJuW36IQPzzwQfhcVQrg8zYY6Zjqs2ie0GjtQ6QpTODHp4jbPnYATSCT6rwdgmjpAmA
         5lSF2j45qkCkykjZxA/+4ZYOasdD4AC3o7ayoJYzKuqy99gtg8S7Cr2BQ3dZhGXlddJ0
         BqNA==
X-Forwarded-Encrypted: i=1; AJvYcCXbZjmxWXf5nIKFVXYUcxFrcpcyS3vn+eUyEwjIIvluOn8RCXKgLp7qClsCWM9MxiRo6iSz9OLnvCkorzpOnPVxFomU27vRGypd65m8
X-Gm-Message-State: AOJu0YxV4IOw8/UxIRSjtkw78RiYyPf5pZxeGVnqdH+iX6SuxciXGQJ2
	DaLD9FiBEHRE7JXKPAvjssY+YIJ2iK+Ozn3VKV/FaxuGIUk5qdyhS92U5pyMDM4I15um/brFuWs
	Ma2GY6DO+9lokampSYI1oZ44OZ8OqZqWfMQJG7A==
X-Google-Smtp-Source: AGHT+IHUgpELxXazT/rgMogScDnz0wJSG9MkwGNjNTPk3PQKUHC2IJ5DGZyMy+SWWoBd56/L9PJpn18HsbcbTyMo0Nw=
X-Received: by 2002:a17:907:c70d:b0:a6f:1045:d5e2 with SMTP id
 a640c23a62f3a-a6fab60b27amr565324066b.4.1718986575632; Fri, 21 Jun 2024
 09:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621113143.35827-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240621113143.35827-1-cuiyunhui@bytedance.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 21 Jun 2024 09:15:39 -0700
Message-ID: <CALs-HsuhtoBk2x-u5mqiEFsFTGO-_U1K0UC+Te5tZrH=gjY6Vw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Provide the frequency of time CSR via hwprobe
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, cleger@rivosinc.com, conor.dooley@microchip.com, 
	costa.shul@redhat.com, andy.chiu@sifive.com, samitolvanen@google.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:31=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> A handful of user-visible behavior is based on the frequency of the
> time CSR.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Reviewed-by: Evan Green <evan@rivosinc.com>


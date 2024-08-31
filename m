Return-Path: <linux-kernel+bounces-310038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46FD9673D7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 00:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C801F21E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07AD183CA0;
	Sat, 31 Aug 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/56gX9C"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561551791ED
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725144389; cv=none; b=e/ERkcOI5vzQ85mu1kpJjzldNTNBqUGjioaniN0GaucwElGqPtKv3tvWD3dJS38Sd5bPe6tRnN5hCb24malk0XgYDpj9OY9V4d68IIbjERtDclNmRqO+kPOLTgLrsV4OeZhGtMOl+BcASv4bdE/xChZ/yIPqVn+2L3lzYwsxolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725144389; c=relaxed/simple;
	bh=BRm+ARDpczVRlIDf6yxchqx5sSkNF0E4CYM58sI/Jhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tvr0DN9OICGRBcJES9UAeAFLO3paNcaeXNKHKH4KWwd5v5pHUYpbrWB5bTaMvaAxhOE/h5vg8/JVgSn0EO8Z37KXHBlnuhKo/u3SbQUOFgDvYKFnbBPhz7nzCVeBsD3FPjhztzE2IpQjUaK9W/HUONGG4GY7T84kJESITab3QtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/56gX9C; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso39255081fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725144385; x=1725749185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRm+ARDpczVRlIDf6yxchqx5sSkNF0E4CYM58sI/Jhk=;
        b=p/56gX9C9Is0FYyastNZgM67X6ZOfSE4T/eUt7408YiZad6uJKF+tL0w7lmvP65EKB
         byn2QhjKsjebSnB2PBcLNZ9gbKClR8i4ahuV63DqhqMaDNOXRXkqBsULmChFIcWCBXpe
         UWK4dk2h0MVTGgRY66bf69LH0LtQjppvazY3yd59Yb4M8pxYWNF4ErF6e4pf/BsJUUAM
         fsTlVTpSSnfNQRZgVz2r3qRjb4Ni2c4hqc9Mj+HThEZLaKBHozxtYlI1wB1L12AkViQh
         nmoHGRlSDjfrkxAM1z4x/cFxEyNBncKJZz05zIp1SDEsd4igvYZuZF3IEwL6qhyRJbrv
         pQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725144385; x=1725749185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRm+ARDpczVRlIDf6yxchqx5sSkNF0E4CYM58sI/Jhk=;
        b=lOfMORGtc7IDQzdlpZ9xwS9Lrgbwv+0bOKgubfToouSkrS+vbJdnH4BPUID+zrg/OI
         5ltFrfWZ46rQaCUNcNxHo9JUvGE2oEfzfWESVJH5ndZk/wqJWLWjnjzaKvlnYPcBUr8l
         /QeVSbDcU1Qj2HZJ2te13iDxJOaUp1XKiLipsi1cowbJdJr3VCRkwGj6v4TI12H2oluw
         Ppm4jvwQLS/lkM6NHoF9nEIR5NyOraQlaJQOutoI8Ha4ET9fgAEAkjYKcrpjJFV4i00o
         OjsoYsNMWPO9/g44oWT9NFkve19ViGDf1jnp+45wW2p3mq4xxoX9dmvR7VpOmaAJXpUo
         PCzg==
X-Forwarded-Encrypted: i=1; AJvYcCU4iLwXlX75zlW5XJuS4exgmQa5cw9Fqk3r5Dm4X+Qitt8p3zekP33aP9PxJX0Rp9zMmfn0zrm1QTyN+yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hF9Jo5hEfSRLy1iYVBxE1IGwLmz6kOQIa9B+42B78Y3BXvh/
	0louiN+daKhZvkAxsocFB2tVaODFe4RKpD5bxPnHLznRuCSQXTVvkL3IaSoc2tyZlWAbV37W7CY
	RD4gZl8f3/43t0pui87FZhwiX+3uuB0g5RrcG7A==
X-Google-Smtp-Source: AGHT+IEa2JRQUG0eUtArY4JUyXRBDslBLdWQtYoHMyvzPXfXNsUanKaJzmlwUkEiXA5xQcEobfjDIFVUjubiH726ddk=
X-Received: by 2002:a2e:e1a:0:b0:2f3:df8f:bfaa with SMTP id
 38308e7fff4ca-2f6265d7890mr17467031fa.36.1725144384823; Sat, 31 Aug 2024
 15:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR20MB495329EBE498DFFDAA1EC457BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB495329EBE498DFFDAA1EC457BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 1 Sep 2024 00:46:13 +0200
Message-ID: <CACRpkdaoCw9LF7f9rgg2NZxmSrvUZJEgS0p0aUua75wkUwOPUg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: sophgo: cv18xx: fix missed __iomem type identifier
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:56=E2=80=AFAM Inochi Amaoto <inochiama@outlook.c=
om> wrote:

> As the variable reg in "cv1800_pctrl_dbg_show" misses a "__iomem"
> type identifier, a warning will be issued by the compiler. Add
> this identifier to avoid this warning.
>
> Fixes: a29d8e93e710 ("pinctrl: sophgo: add support for CV1800B SoC")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408271555.kpOmi9I8-lkp@i=
ntel.com/
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Patch applied!

Thanks,
Linus Walleij


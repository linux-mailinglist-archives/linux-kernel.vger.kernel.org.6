Return-Path: <linux-kernel+bounces-178081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8F8C485F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1318B21DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271BE80BE3;
	Mon, 13 May 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNA188kw"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082138004B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632984; cv=none; b=FSz95Y6HUT/CwJQOT0lpHDnQ4vBN+m9PXChj84kMflmHCN3L8qtoDjSw4JHsCT+eVd5PjuI07bV/3qgSBS0hIDJSDfBVhLnyeZKgMsUiMJA/mjb4v0TcOw9nBtBF4nhWmtZ+4g0xOwOFsZm2NEKdBT0H6foMDcheoXta3iSM1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632984; c=relaxed/simple;
	bh=UuNdNJXns6dDN+0ihImEqCVj+1rlYEPzuqCZqo3qPlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPXomSL+qISpIe3SneU7DM6D6mIveq3hKpT3ZySYazirO3SX8vj7V/Z7otd9gv4f1Kx5hJacWEsnga0WT/cV2Dwgg72fGwHipT+ig2KO5iPv9kBMSmB8oWBDERC/MScjfFfY94M9NHjDUIYSnKu2f6jSBbTH0j9jANoFj58KXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zNA188kw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-deb65b541faso4835592276.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715632982; x=1716237782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuNdNJXns6dDN+0ihImEqCVj+1rlYEPzuqCZqo3qPlI=;
        b=zNA188kwjLOOAHpjBfQaSAugXeibT67S02hMkDJCDQw59GyqY83JtKj89jH7bjknT+
         I6m2RvJCIaVazxZmoyw0p8fXZxEy56OOhbaF4Xj4hvo0cqo6tTbvoDQB8tiepOBZDuqV
         ImjMV7ZIWlVILFXE8tpDi24KstO/iQn2CuPzW1r9uw/MwjIbx7S4KuNdtGm+uf6rPAlZ
         Wemb/LTX5nkFg69vBIDLlBXicUF3WRCIVyJ8QtEVfKPQqiiSY3Vg7MZMum8cuWkREnab
         llmT7uHQraXWd+m3nqLiQLq5KeaKFg/ptn7GwLB4scMsOSxHSXgpAkUZKiXZ9tCqlduP
         56vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632982; x=1716237782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuNdNJXns6dDN+0ihImEqCVj+1rlYEPzuqCZqo3qPlI=;
        b=sMGKfZT2I54aFOOYTn19qB6UUsVQJxEFSYWr6lLxYDMcG+aUq01XMpAWKfOb9/ijh2
         AwI+MdzNhMTTcztn7Ii/6OxmXX8/hnQbY4AypiyqJ51PPwcKdOtunT0k4ajUNBU4Jb9v
         D0XrCssgVtdktrb/5HEm+uvWT9QyBK1OoeJ+fTdzYhx1EW5vm4J3eMDhXj3iKjzPfAxe
         1iGcIxvbKH4IaSomyDd3/5XU7et9DUEPp/xznUVP4w2JpaUq7FiU34gmCuibN1lDawco
         yQd2DTlW14wGaEv3uTgz7lFOPJjhLITdURQ/naCQAZ+VFHEsDL8CdIdDa7vn8OhZuR4p
         O35Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzhsAe/WwAtA/QPdzZkD//CLjOeizzF4prCpCyXey36h3QdvFC+xR5IRM698FNL5XGXuj12tVCwQXw0Dj+VRcifJy4IwNYjF4pqcO0
X-Gm-Message-State: AOJu0YxX8vIPyOCm22Lb2UWZmQZBL4P0z+SOslI92pWJqTY+PPQWF7K5
	mcupHYzn5ECnLWnqyk8DK4BGjblIvVP9d1dA4waDNgrnGsVFG6bet6B3xGyhWtFTuWzG2HOG2Gn
	ilcgtBekE9Qc8cAuPSYgD+1KHauLtt8pwo+Glow==
X-Google-Smtp-Source: AGHT+IEX6KPDt76VMH8DusZN6kwrfvpwFAq6ldOIQTWXfHei1P8U/WWYsNI9om7Q6yw/44QLsFE2KtOjtumhQKYNo9s=
X-Received: by 2002:a25:1057:0:b0:dcc:8f97:4c42 with SMTP id
 3f1490d57ef6-dee4f324d52mr9984118276.13.1715632982104; Mon, 13 May 2024
 13:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510123238.3904779-1-robh@kernel.org>
In-Reply-To: <20240510123238.3904779-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 22:42:51 +0200
Message-ID: <CACRpkdbNCu5LhVkMiBnZf=kN036C+mGdZqQEetAUypEc-w8PZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: vexpress: Remove obsolete RTSM DCSCB support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:32=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> The Arm Versatile DCSCB support is unused as the compatible
> "arm,rtsm,dcscb" is unused in any .dts file. It was only ever
> implemented on a s/w model (RTSM).
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Nice cleanup!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


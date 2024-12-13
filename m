Return-Path: <linux-kernel+bounces-444095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BFE9F00B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1836628555E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B623BB;
	Fri, 13 Dec 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcdQZCWX"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856A621
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048928; cv=none; b=TCL9ImWdyhv5tjlkGGEB0H/ypQg1DGz9W/GgpFoE9Z7Ceye1IR+4VNJu3Gf1860DNXX7iA3CD/x74YcAZxVh1/vIa2m1d1qXerJQ9R043vwNd1+6ELij0eWT/f8tIo3fkH8MMqMpDh8rpUWjBkbNVeNYxfdOI/l+T2JTJ6mWfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048928; c=relaxed/simple;
	bh=vQLAAHrNu8HAwhOxh+FkpsYtnnkpXPTL3VdKn+y7R2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQbDEfO7ZDPLLJXmVeP3swmXiqOvDnZt75N8Yv35fHn0E9I4vT7jKxjfu8Wl/fPoZ1fw8sxAu0yfbCSGHWhTIX62eGm0bjv+DqS5/L5iOmDfMgKIAwI2Ec+lTIxRy2if92ctQ/AkSpUb/26LNaw8BxdK0QizrBp8mOFeBnTKFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gcdQZCWX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c68b89eso1270163e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734048924; x=1734653724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQLAAHrNu8HAwhOxh+FkpsYtnnkpXPTL3VdKn+y7R2k=;
        b=gcdQZCWXsqCvEfKfuvh5nFAH7K9UBZY7DAWuEEWmlM+YGuD0C/xUdXWp6rCOH42AQA
         Gt+wWxtDxMVKn3TojU9IPPFkgfnu4HyHUubNKvqGC51l7MSZZBrsMowx+M7H1tIQMTb8
         TCv1oawCTX26XR4TbAeodC5OBWoTr+mfNKawxGcpF1Fjq5FpPaEsP3HnxLva5QnMRmUq
         IVZtUX7FMZ5pwthftWR7qlLI3dnBJm/ze+oLK0lnlC7NBxC2Hh7rVPf98DfFWSwNBDqw
         lTDPpnf4zZYZtMUHkH19Gyuf2Ow0NOXj7Zn+2x2u7vVEUNlsp4T9EknxBlzCDFuk6biH
         X94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734048924; x=1734653724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQLAAHrNu8HAwhOxh+FkpsYtnnkpXPTL3VdKn+y7R2k=;
        b=tplaxpkNV/RKHaV9ojOy95qfTPK/1pdP91vipNB/MspZYLJ0nfdk65VAXozgVYm1Fc
         91hU6werCerjs1K++Gvu53frPGBCsOHZV2CD6tIxHSufsB5mWBS+GhQgmkXagkgWXWv9
         yb+0V/iNyhXDxFI6LyrNi5G/F+++EfiJbH3NS/b2j9nh8t/gBiyhhLIQOegrwEBvmGqm
         N9M83oQNGRgINP2J8TtO4oo1TOEFQ3KSEgXDk6S38/3lyzHHcXBwrO6/qgSfF5/uCGzl
         xxKS9bwLUCLQDriA3Y6ocSwb9jTjmUEae5Lm3JC8BBhpY70oIGYm+f8/scLXy/Tenqw2
         ljWg==
X-Forwarded-Encrypted: i=1; AJvYcCU1EcnYCrA21Jptk41xu0JWAZTOyjq9n9OWTBFiR4KHCv762sn8y6BxdAWPodmyF8n5nwWA+hAda41oqpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuwNSUYoSZdpGh9TKctgUa9ppGxp92Mvi+jwPTDZA3aAD/qTM
	Za3tgF4ZWdgFx4SVJ3mfnt8dzIbFYA9kuPHj6qW2H4OYcE5b0Gs7TPYbCSmSwtR06bWbLgHoEsf
	ba9XonNAf9Wab9tAtbrILnh+ijSita2D3Y0LuGg==
X-Gm-Gg: ASbGncslfxRbMGn0/n44P4n2vGCkwCYU+/IaT4At8RhUO+9xH8JJNuc/4OSxb1C7OJK
	CC8LlcVesimlUBwvYR2x2snCyxBjKDG1O8R+B
X-Google-Smtp-Source: AGHT+IGto+HqauyF8o2vgmuC7GK7AZOSBMmGgSe13yKc4BaTYV1aQRpsIlQvUoBUfr6hPCD6cUt2MwGevF3QkBLKPeE=
X-Received: by 2002:a05:6512:2396:b0:540:2de0:c363 with SMTP id
 2adb3069b0e04-54034260c67mr627269e87.13.1734048924079; Thu, 12 Dec 2024
 16:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029012312.3448287-1-unicornxw@gmail.com> <173395639623.1729195.12285623767079173929.git-patchwork-notify@kernel.org>
In-Reply-To: <173395639623.1729195.12285623767079173929.git-patchwork-notify@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Dec 2024 01:15:13 +0100
Message-ID: <CACRpkdZTrb-CYtP7Mbdon-BdVWxtByJP2M0CegV_ikodJ-dXSg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: correct typo of description for cv1800
To: patchwork-bot+linux-riscv@kernel.org
Cc: Chen Wang <unicornxw@gmail.com>, linux-riscv@lists.infradead.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, inochiama@outlook.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, unicorn_wang@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:33=E2=80=AFPM <patchwork-bot+linux-riscv@kernel.=
org> wrote:

> This patch was applied to riscv/linux.git (fixes)
> by Linus Walleij <linus.walleij@linaro.org>:

Interesting, I didn't hear about me doing that or even being
able to.

Yours,
Linus Walleij


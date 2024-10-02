Return-Path: <linux-kernel+bounces-347612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11B98D794
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F8D1F21F26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D501D078A;
	Wed,  2 Oct 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpyHU7rP"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02117B421
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877048; cv=none; b=bKYEYyYvWRQPVBh6enIQWtciZ5gSrKiNjm9BxkJjiNP+2FAn+lIln6d0hI+CwLUIRiiRstd7LapBMmQqu5eC/qd8FDEaM0npe76fZ4OwrSmFjkYDbluaxGQTVaTeXcuP48cv3xsUoLqjtZz2RbhyO3e9KBTJe68LWwZlEfdGEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877048; c=relaxed/simple;
	bh=59H89yVeFtS6tWwbK/cDvB7vPxNqhqsoHH1PKVruKbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aATPtnW8sKG0wCadzeu4JwhS2XmXi6uO5AciQGvHAO1foNP5KLdsUFxSHgvj5dAYdpUFYNLvktIteW1dMxohNkNOv0yh73bC3lrQH0XuilVxIldRk2W8iJDQHV77Y266lR+YGqTRa+ORhMEDMyzsmNySCxdLsP+zwqDS3mYjAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YpyHU7rP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53988c54ec8so6150036e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727877044; x=1728481844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59H89yVeFtS6tWwbK/cDvB7vPxNqhqsoHH1PKVruKbE=;
        b=YpyHU7rPiCmw/oYH0aAJ7vraMN+4g0A238lPJi0K7GhJm9jt4/QEzsGUvdL3VNhY0N
         zpJbaPzpGXQX+qq/YZJvDQczrPlCzP17GBl1sq/YUZKmY0WI88/xIt2TH0EBeb5MJLcU
         jHTW64riDZ7kCVITN+GwMIQ0r79cZfX5ZisIVMHOKp3LLYVgpxBWtTy8RfFv5SXMSPAF
         YEQqIp5AK8GBU698WegU6UF9MAwhu8paOxzldduaGmH2OniW1F/oZUkwyPIQQPjDkRUo
         u9UuYzeDuYgwYAXIpM3z4v0hG25TfFL5Rz67NV1xJQrhIf6BrB6UVjmiD4LuQvQW0Tgs
         txeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877044; x=1728481844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59H89yVeFtS6tWwbK/cDvB7vPxNqhqsoHH1PKVruKbE=;
        b=m2dpv6hZONfgYB652ye2eZQOI96TADQXuNgw8WA8RPSCciAYoI/dDb50aKFpuGfBD3
         0k4flKfWl258F9ICceHdGT+j+gz8Nz/CIFPyB/TMf7HodIlxo3DBwBmtQl9fqUZ5VgAK
         ljO9lp0FGOxZbWOc1Ud1zdFQyHYkSjXoyuJbF8iZ/yLEP3hr3dH6kp71WhMBSP61qiqA
         69V8uUWjVKxdhmYiPXXtkRkw2VMdKtenkCPmzgf9yrKZTCTVlRHWj7WPNqwzO/BEp+v2
         uEYv2cV246F7dq3kOjkyMvsCw7rK+kbwGClGBOQIWXwkXHOC8iUOoktaW5Z0UmzfFzgL
         H94w==
X-Forwarded-Encrypted: i=1; AJvYcCU+vyPOVVDuG2fCW+4IAfHVnd7A2N+cfQiYo/ZIid6BzbjXQUleb4vN4R2a2+e1tGn61z1m2lJURCMNfKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOiL01/PqqdyVLFqMLa0rHm0/g3kJYjLqPFCxKp4FCuYLa/B2
	nQTcm2V2Qq5BozTJxBOJ0zPcDa04fgG1E7jbBRyG+3ogHffV6viuuywtnhSpaSz6EzjgRnUbfBA
	jCBPlQn8DUqrgoRfM60bhuV8/ZbxD9G9UqouvJQcVQbIcGpAq
X-Google-Smtp-Source: AGHT+IEZcOr6lq+jfK+97Wn6bGTvN/MsUAPJUFZ4JErHiWrxoOLFlE8IkjVw008JZwW/Hotqfl6Jx0DcSbp7Hutlr3g=
X-Received: by 2002:a05:6512:4023:b0:536:7b74:ef50 with SMTP id
 2adb3069b0e04-539a06638d4mr1949487e87.18.1727877044200; Wed, 02 Oct 2024
 06:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001212724.309320-1-rosenp@gmail.com> <20241001212724.309320-2-rosenp@gmail.com>
In-Reply-To: <20241001212724.309320-2-rosenp@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:50:31 +0200
Message-ID: <CACRpkdaQdNgm-ZfQPLOKsDby0K=y+QANQL6viN-XeAC4nokr+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: aw9523: use enable for regulator
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:27=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:

> devm_regulator_get_enable_optional can be used to simplify the logic
> here.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Patch applied for v6.13!

Thanks!
Linus Walleij


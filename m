Return-Path: <linux-kernel+bounces-178074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7C8C4847
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF11C20B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA5D80032;
	Mon, 13 May 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqsgXXBC"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BC1E4B3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632542; cv=none; b=KpiCWz4MssEPrMOK4qZMxUGvcB3f8haJxXyPD7IjsjhYXpp+xOCxeIk8ytRkOLvkxuJNrwGbVFIM3WYF175KbTQlLVtk+zjraRyTJex/QkVp+8oO77kquxwY4rY13tDN37wauOh7NYaQyufeJ2/FXKHMHD55z9FxPyPWP6Mj49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632542; c=relaxed/simple;
	bh=K5gJymEU887CrNC6X289CM2zG0sNjhqiEQwzbLWQ8aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvnibBXkEGunjZFwWePbFtGY5wNNzPzTwN3EKt8NqhWgihpmA8Ov2GkupWhWjpQQQPWkT5+d471vmKY+8GjhsUWPnVH8BTrwEzPz6r/lk0gmkh1e4HMEv+cr/0EM4ePnhPrFycM8KmzZovDRRajebRjLWfq7JiuifsnZoMvjUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqsgXXBC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61bed5ce32fso52041457b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715632539; x=1716237339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5gJymEU887CrNC6X289CM2zG0sNjhqiEQwzbLWQ8aI=;
        b=lqsgXXBCWoP4mfkbmPLX3+Y7tKuuQbuE/7eQ0VgRM8xV2eLjdsJMqmKG6likQJwXlA
         6UCbAjQpNzs1YKL3uQfFcnrMWtX53p+/544o1p0JKxmTQw9jeTh3S3280k18a+ebrGhx
         CODiN3MR+ZQNmRXmqxhfUf0+pNg9AR+hoQvdOfBCVwQhaVcEQ60EnAZugayaDi2fRHRK
         EQnAX2iF3rQiAT4UgLuCXdNOTxhBfwDhSqVwA6nIAfK1pC/GY1QHphQoGOsFKJMZCOHq
         vHpMZlPbeasNM8TLICrV9VDvYRH0pubfgTdNYpjOg1JPM8S7nbECnpHtNy/IHKzqYQLB
         A6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632539; x=1716237339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5gJymEU887CrNC6X289CM2zG0sNjhqiEQwzbLWQ8aI=;
        b=I/1CLY/TdBJeam4p1XcveS/MJxoEsEZgraMu+3Y5UQWLwn1Czg5E0F68p2YM4rXMfM
         t7fcwNKbLjo33a56LiX3d6bz/Mjn+SmSDx6SCf3vUB3W061qP+ICVItq3ABtsJF1lrtq
         5UpDT6sbsxen+ziYOC9/wmnWnOYL2lRX7DZ1Kd0sroeUMhtFE/R99a6C8T2u4ipHIdbK
         j3a9wuw0mJfAf3XwxTdSOFX1KrquE2xmWkxcoHWCCIZZtxzX2AraUYcAzb4zRfQCouiy
         5InDTqZ13HiaNQ5ynKcrTH6rPaKWaCr7w110mXtm3DeftXGYHlaRBCjWzKzG1xZKvJLm
         HZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUf8LDsy8xfLr1tYgObva7gKqZFZbIytMw0tGNptUTSZbyVt9oLXiXcBxhZ0Fv5V8+pnaD1nGBp1EvmJvHuTJbwyZREaC1gO0S7dLVo
X-Gm-Message-State: AOJu0YwqHls45Pwu4oskJQFJaWfwKXSXGRtUViOjcsLafBh/BBoXMDUJ
	xQBhEcbo17eoZdaXdU8cVTss27o4m5ZRIuOzTSAr8Ve63Nc0QN6YY+SlRZho0voc3wz5Rklr4DN
	j77VwOHEtywjrIiZNrdoMlW7Y3v6sLz8YZZIkzA==
X-Google-Smtp-Source: AGHT+IHSl/yR0nTZcRlSe+ORPztjmoog4CRZc8k44qPEv4107dBUri0sSEMdFfUGHggaDXOsYQE07EPlHgu7P5eK1hg=
X-Received: by 2002:a0d:df16:0:b0:618:83a4:588e with SMTP id
 00721157ae682-622b013d333mr108562117b3.37.1715632537678; Mon, 13 May 2024
 13:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com> <20240511021326.288728-8-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240511021326.288728-8-yangcong5@huaqin.corp-partner.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 22:35:27 +0200
Message-ID: <CACRpkdb0YQZsFY-uYFKLo_aqE_G4mQ+5mtiszDGsrgFz5R+CcQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/panel: himax-hx83102: Support for IVO t109nw41
 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	conor+dt@kernel.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 4:14=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel, use hx83102 controller
> which fits in nicely with the existing panel-himax-hx83102 driver. Hence,
> we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


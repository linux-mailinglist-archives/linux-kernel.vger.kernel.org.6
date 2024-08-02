Return-Path: <linux-kernel+bounces-273126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8D79464C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4791F22BF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F1073509;
	Fri,  2 Aug 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqadluUq"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348550284
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632687; cv=none; b=KZJhuhMqXt+as3+FUBy7DeuXxzwrizW1dD9xz8ZmevobgtFDwB8e7Zu598YEHLaRFCoH3kLcrDyVEQpVw+BIkY4Mcv6Z8FAiYgVAgh4quJ2BWTpDKifLqHSbT0oTUBXZbzBbcBj56koXOYptM77okmMaJ5XIT8u6+yeya0zqDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632687; c=relaxed/simple;
	bh=aDLyGh7bJYGOVqjx0U4lXYCia0yq4G2ZZHzfarZrrAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaQbEHTyuIpADjgxaUoUOcS+PsjUCwWRAVUKTb/6nDLBAAt+kRiIc+Akii9hys3WzLoaUhAUJxNkVECw5MNS+GxFAczLm6Upx5DeKHsnVmxcGIrqsV8tfE/JmoXnTvLmHwcCl4kkH8/6ZHkw7p0KmtBRMHmuDaXY7A0EXelGwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WqadluUq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01613acbso4281513e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632684; x=1723237484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDLyGh7bJYGOVqjx0U4lXYCia0yq4G2ZZHzfarZrrAs=;
        b=WqadluUqJOO021HQwey2CpEDXaUzDzzmyl1slKJPNs2BkZDw9qUSPIviYlvUrhR+54
         nPeOoSKIDkWUsKY/9z8P3MikEyLmYF/av//WgKgU1zumnp5ItELcapOE+y3KI5XXuJF1
         /HyEIWtdLL9tmc0ev4OzZE28U6W7rd3SjBPYMFyXcYu3HNeEEDujj1dpi0fbS2VUVS6V
         DiavI/Y6ozEX5KJcVKUPTS0d/s2K7PBgfImQh9Tw4kQigEoYJMTB8j29dm1lGjHNKaE5
         x/YFPV0S+CiFGr9YW8cQbWct2DBdSMcBrNJIItpOn6Rc5NbMiIilhBlXCCQMR/wj/8WM
         yQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632684; x=1723237484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDLyGh7bJYGOVqjx0U4lXYCia0yq4G2ZZHzfarZrrAs=;
        b=hCVPhIa+oQYzhvxw1271mzoaoiZ5vD0nqNPpQKURTpGLmHEsMcYbmzxDcto4S/ZhSO
         zvLwDht5nOKZ6ANxNNYp49RcBraGXSjgBwQb24XYQIZDYGDm5/YpwtlRT4q5jF3BwW4s
         wm4KZztFB2Ks7cMrEBMb3L0thpKcvrAknRbNyc28+HyluIajUp6ih3I0tPOykPQHhEys
         Ib3todvd9m0+EOq5RCoKoheP80HtInZPa+B5MIJebFjkimM9pc0seH7Lhu4AqZagS4P5
         CjLuYUENUpO4cq0wRanos/bzbwUrqPfsoQo7RDvQgbS1lq2ZPhBHiUOXwfPI6OPhQgRH
         LuNA==
X-Forwarded-Encrypted: i=1; AJvYcCXaQDh4TctHjGxe+OvcDkAz3Cctmp4fcqkdp7gmHPyWGjmg372hxTRQ1eaU1nMoJNwhcR4JezH6oROqSq3wX1esbHaExOgv/3/b3BGs
X-Gm-Message-State: AOJu0YwmcfNW8We6eEHRjft9K/t13YQfhVZo7cjaQmRz4Zwt7R4IQOed
	lOuw+o9u5vdwIQSuECiwR6Hi+iBN5hw/tWwRsVP753SoItPVNYXDxvwRtiEAMC3kF1yhnPNpMbI
	jlfxasojj9HCI1n7DVZq9jx9QuUU2ssQhid5bcA==
X-Google-Smtp-Source: AGHT+IE2f7ue0e7xkgTEx3gmrv6xArEBww4Gfh261DIr3CTE/+LgbXg6yQqeUwGjCYmnNUcu3A7uOInp8L6uRFgcmU0=
X-Received: by 2002:a05:6512:3e0a:b0:52f:3c:a79 with SMTP id
 2adb3069b0e04-530b8d098famr1823700e87.7.1722632683707; Fri, 02 Aug 2024
 14:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-5-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:04:32 +0200
Message-ID: <CACRpkdZ6T7e3eYod-c38tKhNfLLXAFXuOBV1trBgn40-u25tKA@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net: dsa: vsc73xx: check busy flag in MDIO operations
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> The VSC73xx has a busy flag used during MDIO operations. It is raised
> when MDIO read/write operations are in progress. Without it, PHYs are
> misconfigured and bus operations do not work as expected.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Haven't seen the issue but it looks reasonable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


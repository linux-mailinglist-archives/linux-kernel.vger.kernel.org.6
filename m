Return-Path: <linux-kernel+bounces-216849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB290A764
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9891C24924
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773DC18FDC4;
	Mon, 17 Jun 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNphIsM/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2E18FDBE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609685; cv=none; b=ND/o1mW8C8Q4pWwMLMcWQ+kg+lKjw7Sc1h/2Hv1c+IqGjxrimD9jsf59VJY4NjxkaTb9EwIzeZtCyE8jqtmrbeG0cdFRwF0iggN7u7ohoViwmyhOaSNOXacG6nXDmVFp6/qo7CIHzWUn+ORHHO37zQclMctx6gyWSkHu4VWxFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609685; c=relaxed/simple;
	bh=Xoq4EUAvhohkGeVSJqSuDIOlvwFj9GujMdx8Xhlpyd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1OHwTHhGXYQsWs8paBmhtw7jOw9BXRYEIxIDDtqZs72EnPmUT6Rii9uEay4ZiHWBdH/nawgt2KdDRb19wK963usQf+aOI05nkmAoXa6YQv1o1XBpsMJZgZU+m6xtXaGTCWbWQ84rcF6WcJyfDjyOYLGJl5DD/dG+EwXjZ9CxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mNphIsM/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cc0af6995so128289e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718609682; x=1719214482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xoq4EUAvhohkGeVSJqSuDIOlvwFj9GujMdx8Xhlpyd4=;
        b=mNphIsM/hoVzAEnpb0VtBzw4GG0kCULFsFxvBVPMa9nu3Ay0yXAzxFcQ+Au+C4LCtl
         YTmXzI5MR5j8KUWcWkWKFuaHeM5Q6HkBhfzCNyRkETCOah3EU6esgE89oU5N7mid0WYG
         +KZCeKKPZqr+Zn2rzXm0GhPsRPZVazf81+zF8jjeojdJfpCf36RYS1v2olQTGL3SxwJ/
         Fa3OZfqJmAObPnDwnyZlZl2yWdFJJWQpt0q8vyX+ESzZTs2fp+SZzaFd1Q4/qU0D7R/+
         b3/CxuWfl4becH4m5AP3q6y32TM5c5qHJvAvaHoro1mCVQF5+RIF8e65ZB/DpJO/MZCj
         P8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718609682; x=1719214482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xoq4EUAvhohkGeVSJqSuDIOlvwFj9GujMdx8Xhlpyd4=;
        b=R5F2cL2ewTzyZgeK5CByR82CJFsYIENxfGN/HWs2We3thpHlrMaZAt8MCHDf9z4Z95
         qUl/UNXPcBkjjUboyqR10MKdm39Gk7ajMAAfvLWPWfkzpwP8aLpbXG141Ebq350y3fvO
         8vjaeLfdIJjOn8DmYuRUeZwLxbQ7Xjb8jvqqRBlbxoanOzpcmC59qkNOK4OH1D7yAJSM
         M2Yu0o53q+pCclOeIk2PVaVDsMTcONWTEOPP4z+FiSKjLQkGOal7ge6WjIyGMQGefU2G
         Cq/j1nrkMC81OIgI6h/JaoPN60AfxpbXqLDEfR7j583SduOJIsAfSJu7Hy0vRcRCRXfw
         vwyw==
X-Forwarded-Encrypted: i=1; AJvYcCVFEyHWlKDJgM8XPN1xBIPIQuI/PHP6kjA23vpmLpTxOqE8qVr61tbslgkShBZNwerxVkArM6AjpyPyJd/uUkT71pFV7YPpU+GQi93+
X-Gm-Message-State: AOJu0Yy+V/qTgDL+j74om9mIRSY7D5wjtL7mFQZrYSvyyEkMsGqbdhYJ
	G8cMBItU0DfMKZ/AzivNYCa+OoaVDKqIqfQlRtb5P1gTSAxIgrkDrvu5740mOUrbhzCSV4NpfWY
	oCdgtwrQr0PmJvgiJBpMXOhEh817uYBFq/fqHBA==
X-Google-Smtp-Source: AGHT+IGqIDqoMDiWUnJbMVSGr1EJQQ4GFqNlfiC0YOW4DAh8bCGdlwiNhRqn/j5asJGjevkFUoLeA+A2JuGUQ9QeAF8=
X-Received: by 2002:a05:6512:3c97:b0:52c:adff:4bcb with SMTP id
 2adb3069b0e04-52cadff4c84mr5977471e87.53.1718609682402; Mon, 17 Jun 2024
 00:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-0-a6fe2281a1b8@codeconstruct.com.au>
In-Reply-To: <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-0-a6fe2281a1b8@codeconstruct.com.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 09:34:31 +0200
Message-ID: <CACRpkdanSAkR-czs=OUKLh6dpiRk0QDLR-T0ECrG-Y4cY9=Vmg@mail.gmail.com>
Subject: Re: [PATCH 0/3] dt-bindings: pinctrl: aspeed: Define missing
 functions and groups
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 5:03=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:

> This short series cleans up a collection of binding warnings concerning
> use of undefined pinctrl functions and groups. Together they make a
> reasonable dent in the volume of output from `make dtbs_check` for the
> Aspeed devicetrees.

All patches applied.

Thanks Andrew!

Yours,
Linus Walleij


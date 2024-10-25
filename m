Return-Path: <linux-kernel+bounces-382507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19209B0F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7991F23332
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752D20F3EC;
	Fri, 25 Oct 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaKc0WUU"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1115B97D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884762; cv=none; b=i4TAhicHxoHCRMeOL1tbLirYHYBOu5wjlQW3bznFvieCsW+A341B+iH8lK/BtahrqzlUCiwokqwZhHwlZH5GsN+e934OD+vKTh4zf/TS/k+sWQS/5yLNP1413pbZ2G8Z8pB8g0xEne+nVIZAkgsZIdmNbs9rw1s/uKXSRNpaAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884762; c=relaxed/simple;
	bh=Z6i/Hjeb/JPlscoyQ8d9eFiiniatnIGdcrXThIrqj8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekZIHxkeVn9F+cFZBziguUFeZXupXuuExPUThersPLyBWeZ+k2dR+H+RGZLQ3web2zEDQgBdr/mZnjCy4Qj4BQowkmmGezS+40qRyUxFfiCV1carz6MrQTw7GlG60pyJ2jJmO8IMU+943sijdJvId9gCPLpfk7zbM5peT6eFeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KaKc0WUU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fe02c386so3367909e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729884758; x=1730489558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNXBWXjhsZyIQldGW6G1S9FbbG2idqyPgFLxk9omLZg=;
        b=KaKc0WUUttwDyQfw5vNOXxo7dp1qeFAAOaxBzljkousF1G6U3Az5SGqbu90Eh+8uSV
         +9EK5Rqe2Q+9wN5gDIFH4C+PcbmBN8RLH14Oo0N86dxG6oL07h9HMwuHm9cgOsxjrBfK
         1BB7BXAvrVt1rzNEzhX+q6G2QpyGnH4lrqokfxWWFSDDJl3tD+KOImNmNkNAW8tQ03w4
         PNZ2rCq6VwgxrEQQkxs8b63MTa7okMe3KKwNh4NCYcCV6XLH3EREJFPHNAD3Mg9Qe03g
         bEJE0RwqkwLFP7N2VwdwJvIiuVqEdS2TMa0HGzxLvqcykU/Q7frVfMdgwSSIR47SvhBx
         Lxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884758; x=1730489558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNXBWXjhsZyIQldGW6G1S9FbbG2idqyPgFLxk9omLZg=;
        b=VBozjoLZ2EMzRqRmfUz+y5DjXmmj70LVW23HZ06Wra79zRMDRjtSTL45gx/UbyYcxp
         q1cy/2Ie4WedA+8C+l3uAxtTmGmT6CV4FweVuaJxg+m7KnzhXpxYd9ZXZmGV1bkw/TS4
         8YCh2FKjvaWcYs6wZhQZ4leaKoqF7RVbLCaORXE5j9/j2ECu7NVrgS8mqkMTzmwzZVHv
         AMm8KSGWdn9+r1HuzeRKvMKYUdiYp/xkwuT/AarOUqaoMy3yUTDufxaKaNb/e0+zXqLJ
         Z8OsHvywoqivIDwAkOvQrQlcIUh8tDGiodMyafwYtEBWZToFnV8YoyZ2QZu1025xfOFS
         +alQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx3Qik/brBKyIHRh6gmthTn76L/ziq+F7pR6JCq/dRfAl1WxsKNwvQtjy1grXg7f095lB99PZ36noScp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmNke+1DXlClfn/MFsb8HqPsvYQgSYIkwBrZQNhVAViG3eXSW
	M9r7V/6cLptayvrVw8M4fDyA+RDp1dV/+RJ6U6t8yc0Vj/yPr2MLJRWzr4CVRM06bxUdjp1A6Wq
	5meUVgqePXTaGuyPcQJd9Wm5NvwGdM500qkZndg==
X-Google-Smtp-Source: AGHT+IFLkzZ+wz+p+8WFoTEL7BHuwKGT7/kp/mS0VJouAv7JpyextHokY5bgqYOvVyRs/rvthT82dHBrrhPH7m27hXg=
X-Received: by 2002:a05:6512:6ce:b0:539:fcf0:268e with SMTP id
 2adb3069b0e04-53b237094admr2369094e87.14.1729884758231; Fri, 25 Oct 2024
 12:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729738189.git.jahau@rocketmail.com> <886ce1a2443dfb58496f47734d1ceffd3325fb4b.1729738189.git.jahau@rocketmail.com>
In-Reply-To: <886ce1a2443dfb58496f47734d1ceffd3325fb4b.1729738189.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 21:32:27 +0200
Message-ID: <CACRpkdYp+3sqbZPZt78wKaJPUxh7yq1+WS6jnZ9fFSTROJAqmA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/panel: samsung-s6e88a0-ams427ap24: Add flip option
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakob,

thanks for your patch!

On Thu, Oct 24, 2024 at 5:18=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> The way of implementing a flip option follows the existing
> panel-samsung-s6e8aa0.c [1][2][3].

That driver is notoriously hard to read because it uses so much
magic numbers so please don't copy that aspect of the driver.

(...)

> +       if (ctx->flip_horizontal)
> +               mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcb, 0x0e);

#define S6E88A0_SET_FLIP 0xcb
or something like this.

Other than that it looks good!

Yours,
Linus Walleij


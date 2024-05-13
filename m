Return-Path: <linux-kernel+bounces-177843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E806E8C4536
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F28286D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1182918B14;
	Mon, 13 May 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcR9JJ8m"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5315AF6
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618512; cv=none; b=X2FiK8YAxPAFc9c41xx6YgMpyRl8THs0B9p6L4mJdhOzqdRM+Qg82EhD3pQSX2hSV8js1byyVGzIk5yMA6EbfZAySWwfRXAEE5fEQFNRGto98dOPs9OVqG3INVwhvoZP/VQw7No0IOxIHmLmVKBexquf5hmRHmicdGHqGN3YZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618512; c=relaxed/simple;
	bh=8mSDe/ImppLgPkyTNhXsgjTCK1PmL1zw0+0a6l1PJL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4zmlWLParIryOWlt61gaQWFixvjS6XI23dWk3pKqXxwK6gz71USqqlAz6eXAnmmSicVcqAGsP5w/jhtKXqOVpSP1AfZfQFrJrIwiQ95sd/ifME/hHIH0R9uCWZTvDEXiTQcuHtBJOv0uaMPW90r8DS/GdlTpKp4ZfPhZS9j7OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcR9JJ8m; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc71031680so4817936276.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715618510; x=1716223310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DH4khu6TurPS5qb0OEXIieAt+VWCVTM6kLpaEQH1DyY=;
        b=xcR9JJ8mq6CGmXUmnNPv1Seo9swsZNYS7znOnC2h69UGt5wj++0/YL/qizbfyTlOue
         kSVJ6y+0DqjqD0EK9p9n5nEvWhnKfnMbipvFDo6B0cYjG7RXmiF2VnFytyEA737ha/xC
         cbQO3e1YfgjjiasfnqKYKkaFuFenfO5DTmlBtXP7O1Xt5TALIy61oOxXrVJQgCSKtGXq
         RTHs2Lm+Zm9MPJd5zGOFQtGFHECuawzq5xPOIwgOm+v0iANuYQlpQotJfVer+mWp1N2T
         bqJrw/qzQ360CWbd/PINiSslX5V1XoaTnCBp9UctThCQK4gabxUOBaqn2Fcm5UYrEFUl
         Lk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618510; x=1716223310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH4khu6TurPS5qb0OEXIieAt+VWCVTM6kLpaEQH1DyY=;
        b=ZZLAty6oecV5jmYFsoNQmd6R1TErpEio9VqPKqlotCKI1NkuuzUNdxT4JAJewC3aUH
         CFvECklcYDRoP1Wr41CxYzdpCoiKqlU2Zaei5Hpyfn5XzCu/BRSOgaWk3YTmLfB4MgcH
         Svrfu6PvmsF5avcwRybPlotqa9kA0HZH+W4zohcR3hzQKGaiZJRWCURNZodbcOuAuYDS
         zhYv1hxfhHUmtafDMFnxJ4o7DJ0M8M5zPXcPvbsLDeo6XfS9wsQZVliKLYxKfRmuh5lj
         nHUVNgpVIJuiiukeA7p8sawHVvuyaGrV07MBP0KGHBwwnC+dK4UyBhPzgcsqdcoxLXJj
         vZjA==
X-Forwarded-Encrypted: i=1; AJvYcCUd7SmKZgTHm6xdXZRsopKuQaj1VkfyC8oCYXnMHbM8DqbqAy0piwe2HorT/uMdWQQYh7dK00APyvm+rwZHtEVqkqxoRhhlZl6pACYM
X-Gm-Message-State: AOJu0Yz/cRWV4kuxQzlWlVL0jCH0xjUIX16Gtzf/Fm46XI6c+6GGTzWx
	xJqvmsmLhGbX43LfRZTI+3yJEBDQVZgWgTuonWhBj1XYtKZtCXptAZZ3yUJLX93TuKIK1Ah0MBH
	a7aG4EWE0pwavDZFEVvql3pxTgddTZ2KfNaF32Q==
X-Google-Smtp-Source: AGHT+IGq2C3XDhTaH0foAS493CYmJmGVWp1jeF0dF17vOTZlUltQhDhRhnjWctarnqxlh56yWFXuox8WxUwgr4RKcNc=
X-Received: by 2002:a05:6902:2401:b0:de6:1645:499a with SMTP id
 3f1490d57ef6-dee4f338380mr9928504276.30.1715618510038; Mon, 13 May 2024
 09:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org> <20240513131711.GA2419451-robh@kernel.org>
In-Reply-To: <20240513131711.GA2419451-robh@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 13 May 2024 19:41:39 +0300
Message-ID: <CAA8EJppkJ9rukeUZ=1kAL3Y0WVhN5QFXnNU3tjv4yuXMjc++7w@mail.gmail.com>
Subject: Re: [PATCH 0/3] dt-bindings: display: panel: constrain 'reg'
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Konrad Dybcio <konradybcio@gmail.com>, 
	Del Regno <angelogioacchino.delregno@somainline.org>, Heiko Stuebner <heiko@sntech.de>, 
	Luca Weiss <luca.weiss@fairphone.com>, Shawn Guo <shawn.guo@linaro.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 16:17, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, May 09, 2024 at 11:42:50AM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > Cleanups for display panel bindings.
> >
> > Rob, maybe you could take entire set if it applies? I based it on
> > linux-next, so letl me know if I need to rebase on your for-next.
>
> Applied. These 2 don't exist in my tree:

It's most likely fine, but was there an ack from drm-misc maintainers?

> Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
> Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml

Because those were added to drm-misc during the last cycle. So ideally
the patch should have gone through drm-misc.

-- 
With best wishes
Dmitry


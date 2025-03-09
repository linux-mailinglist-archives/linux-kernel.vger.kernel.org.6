Return-Path: <linux-kernel+bounces-553014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0757FA58291
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F453188DBDF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465B7192B66;
	Sun,  9 Mar 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URV2TEYo"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F74690
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741511775; cv=none; b=RG4jSZEgl3o8py1VZal0IBTqslk/0kSr74pqYB6+bZg/Ztr/Q/BHTzUZFtY0hN5CKoN0ItMqT+9guzvq/f0ISt9rC88GF5fcK35NWgA3iF+B2abVoJ2db7637Gw/KW0aAaPkQgQtlLyk3vW1b+UisONsdWWTpToCwTZpbkrjQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741511775; c=relaxed/simple;
	bh=fZ6tCQq99wfj1FkFGTvD4HB8+OAKX6gyz0YZ8w9XK7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBkuKYamcK3qxz2UJ5L5C+vV6LPdQVHq/1DaR6ndofqqg7MQ8A+ZojWsFNHUHkwxHcafAXpQwCz1at5ay2JAJrlHzD51fNQpfCYkUrDXHOBt5M1iuMMzyTEca5wfYzbIcUEfmuHtuwsZiITO+P+BC9KSBVI4qKHB4MAFd/8Y4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URV2TEYo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fda22908d9so23781117b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741511772; x=1742116572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y0eUpkni4OJ6N5I2ip/hczJtRuPECve9UUx0lHvZiWc=;
        b=URV2TEYoCocRn0J13xLOCmhvXX6a6naCapaMhmqMh+erX54uc2Akrm0fi6vGm6X+Ug
         MK0v9ISOTdte6vMrux79LHhNzPvBqtuxMtEhjMBLzLzBHZ0SDVcvS+43Sm14ehx+5S8D
         SO1ICQ0MJhPlr/3SRES3G+otJLiw4nFAZR/I/MsYuCcH83fZnOinds+fLmb4MbzmoaYn
         b2XwukYR3w/XJHY4FedfSe1/tbyzrHK7fLJgu8Qi8lOy9Hq8MhCMLTQ6sTzYddfJp+LZ
         6P9mdKHVbomCPDD48P7dUyj2EHz6bISKZkfb5o6zAjlydhhiLGbkKhqGk5lmMhSHb4bB
         H/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741511772; x=1742116572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0eUpkni4OJ6N5I2ip/hczJtRuPECve9UUx0lHvZiWc=;
        b=W527fE9mvzupNZQlmp/Rgwi3Sz8mUKxQ9mk7113tkSNRTdJTN6rC0WCSpbgczEaRXk
         xIEcLdMuZpb46HPt11sJhGk7ZPHZE57IetZ7wTbvnKKG+UlgyDyUhIZvLOE67d0CFjx7
         yPz6QL4+KsuQEdnet3HJpXjjAUCEncxOmx/hJDyAI2M3dbs6UlF1gubkDii8wk4Sm9ES
         g0tcHFkPxsFNS/16E+Lq1Z4zaBVuG3UV/9tn5fwf671ntIx0ie9OZ5YS4hPmzIAPmMPb
         hPmHCRH9HN2EOA9But1ApOaQqD2dq2QvrKUy5Ymllob2rQYwhzJDEGgiw5rVLrmprCpc
         /f0A==
X-Forwarded-Encrypted: i=1; AJvYcCX9P+a8miroPIVExba+RAol2Ia9MIGB3535g7O3YLDjDeu2br10tcQHc5UlZnszlM2Zlon4exz27Y8qvco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABfAqk08VV4DTrfet93qlCiC9HN79INK5XQ7/7pOqMR0R90V0
	9JQ6y+nSZCFqIhCj1N9Rai91tPPPkgSbCFY2BZLoIMJJHmCoOMYAH7UlOqR/FoSZYC3NrmIMPek
	1Tq2GmB7RCC4wf0ntpEoAjH862y8Ad0MzSycjAQ==
X-Gm-Gg: ASbGnctG2lOXWlnOGhIDx8LR89JpOxXSuBMqrPWX5MEv0uhRJhjiXAPT5z2x0DQRQe+
	WtI+jH9bz8lZurYZUvYr1mOFkgfkvDYPTw5z6X+yG7/HBTUroYW/+rdjqm6dQvEDFT5fL93jepw
	kNlWtUyMZOPUOKpJOjKSIXaQqMDfzJ30fuUGsMnhyYz67Bsk+mSzA=
X-Google-Smtp-Source: AGHT+IFPECWoQ2SLQxFVAn6AAfos114PtgmwIoKQ+zMM+yCAQaFRw3Tq8C5wAZ3CID7rhAZlrgL2zlDgjqBdRN6ki9A=
X-Received: by 2002:a05:690c:6382:b0:6fd:3fd0:6f2c with SMTP id
 00721157ae682-6febf38323amr131915417b3.29.1741511771952; Sun, 09 Mar 2025
 01:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com> <20250308-phy-sam-hdptx-bpc-v5-2-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-2-35087287f9d1@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 11:16:00 +0200
X-Gm-Features: AQ5f1Jp3ty9yF8Gy946JtVIhFnSayq957H6H-29ZcG2uPAfgmPlCXdifLdlKe4c
Message-ID: <CAA8EJpqYE1drM6=C0AwPZ-e5RkWqjMTpWQiwhA64qby1mmVL1Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] phy: hdmi: Add color depth configuration
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Extend the HDMI configuration options to allow managing bits per color
> channel.  This is required by some PHY drivers such as
> rockchip-samsung-hdptx.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  include/linux/phy/phy-hdmi.h | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Just to confirm, are you passing TMDS char rate or pixel clock for
DeepColor (bpc > 8) modes?


-- 
With best wishes
Dmitry


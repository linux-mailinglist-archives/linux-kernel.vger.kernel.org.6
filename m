Return-Path: <linux-kernel+bounces-178076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C68C484C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E802B1F233AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198F8003B;
	Mon, 13 May 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9XJQe89"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DE7F499
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632588; cv=none; b=SOfx9ajqzQxjRmVsnOTYZJ0X7n76Njpmz2AGOFXbPzJDVCXBcVLZgTOQMswlBhmwO/KrBbcarxGPsm0POo28m9DQBgoRICAGBGE7ajGAhvrpusHwQaAGxbDD3DZpcAy7kdtqoEpDRmcYzfa54NF7M4oGNj3A1rm/ma+fvjL9Y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632588; c=relaxed/simple;
	bh=SA4bW/xLJg6YuBcd2QES1hRhoe/jYuqsZNcpNb5KJNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTKKf8YMyl6hNCco4GwCIQl1v/XkCyJ+f300MgKBN/e5zB1nCqLK+tK2FfumTaXQNV0/R8upFAC36PAz1bnirHKyqBXn0IxHndRNtuyfRk8221XcIp2NGng0ttHPYO8nDuHHkiV3MQb3jRgdoU1/URMQ7TDE5Ib6i6z9hRoZ1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9XJQe89; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4111857276.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715632586; x=1716237386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA4bW/xLJg6YuBcd2QES1hRhoe/jYuqsZNcpNb5KJNY=;
        b=k9XJQe89XNL19VvGqRDYMOT5tXt6SKGnDFGMrnfXs1KhnTzW3ta3hYq4dEaZZHkT4V
         jkdZJ3uQ6kR2ZLXD0UqnlZ4VsucGacG+IH4axHw2XljmfoQEEYzLCbvROyjlQ43+twae
         sWgUK4mSZTai7EH8ZwkYgpzF7xK5ZIe2CqNBiS8qCiEiecz+J1sh8r66YVSFvcECanPz
         R5pl5+G4J7cjLkzplWRkj+Yt3nai5L21qdZcqhdu3DcjkWH1Nc56rYYPaE3qiDMvH5gZ
         2nTY7bQQJ13FHEs/oooAupSikNSfp9x/CfdCl1odpzLWL0PEy89k2JKHgsmpS/pUp7/q
         +wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632586; x=1716237386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA4bW/xLJg6YuBcd2QES1hRhoe/jYuqsZNcpNb5KJNY=;
        b=UsUb6i/ulfPusYsjczG+XcLUy63pWQjGU9GbbiXpzr/i4gEe/1kSichu1FyFDGM60U
         CmA4L6oN/9gSoghkb5XGwWVOSzPntEScQKGVoyy+503w88gOpKvTcY3SILwoiRUG11jP
         HkCWkhY+UHCI4KfScLF5br6UxCvIt72HBbzPk77sAsPA1Vcf39QS1sGjLtYubzo/2WDy
         TZ4GjTGuWYUYZhFdv3rQm7txTUgPHyp3dVnDWRgf+C7K3c0inMVzQ24jyIxFnvVhA2k3
         TWCGJN4F2AM/5Ae7vldPayMaOkrpPn6nte7eW5/NDdWvnJsM4fCiO395lNRj0tWzJjbT
         S8vA==
X-Forwarded-Encrypted: i=1; AJvYcCUIQLo1UFTA/+Je5DNsAQH9DzMrwf7TNrwXtgtjV4TXlVY8wf1wQ33EHO7oDM+EL/53cbhGmguac7gugxoXW/OwS8PdeV4fEgATmEJ1
X-Gm-Message-State: AOJu0YwmXPkEsoTz0PJxS2ThUd54ocZm7puTYM1u6nR4RcOdPU2a7nkm
	eqN6ZyXASR2vlmYzmzyyeZS1rjc1BjN9JfoPK3/PbJvwzdM7/jdrcYC9u3/r3Z/kU5yDonnpiCQ
	UaUc3+2uft+WJVX+mTPHN/UFBYc+Pjith2N5lJg==
X-Google-Smtp-Source: AGHT+IGLloi3lhRWV20W7xA9r5SsU5g+2Owk/UejzB1t2DecP+EHOQs1IPoWLpxgX7GwAk9KqeJ7Ka+d0dhqsAlSfWU=
X-Received: by 2002:a25:bc3:0:b0:dcc:8f97:9744 with SMTP id
 3f1490d57ef6-dee4f3a9f25mr9748339276.43.1715632585931; Mon, 13 May 2024
 13:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org> <20240509-dt-bindings-dsi-panel-reg-v1-2-8b2443705be0@linaro.org>
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-2-8b2443705be0@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 22:36:15 +0200
Message-ID: <CACRpkdaeXcy4uYTD1Ub-BRG9RCDKaY0wCbe4xoUpLwZWuy+KuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: constrain 'reg' in SPI panels
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Konrad Dybcio <konradybcio@gmail.com>, 
	Del Regno <angelogioacchino.delregno@somainline.org>, Heiko Stuebner <heiko@sntech.de>, 
	Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryskov <dmitry.baryshkov@linaro.org>, 
	Shawn Guo <shawn.guo@linaro.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:43=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> SPI-attached devices could have more than one chip-select, thus their
> bindings are supposed to constrain the 'reg' property to match hardware.
> Add missing 'reg' constrain for SPI-attached display panels.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


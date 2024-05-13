Return-Path: <linux-kernel+bounces-178077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700708C484F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA8C1C20CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C118003B;
	Mon, 13 May 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oo94HEM6"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4801DA24
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632640; cv=none; b=IZZ+5XQm55P7yEySdmXMpwu040kDhm/oot+urigzE2lDuEFu4cNmQOl0nLRdwCjYQWScHp3cr4opVztuRlaiGIR4SME7JONwXAvCApuHXIS8OFZBOZrpH5xPlGf2s/nAH9hjqMw5MpDXZPNiRin56BsqpJQO+xwMyJwOnWwT04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632640; c=relaxed/simple;
	bh=/s3/UizLB9d9fYOIbdf0witT1lzFPXKEbUQjbfvT2sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAlBH8VbQuMf3x7IeEgjSvGOL/n+KC8PfZjCjteFXeD6rxIqaL4pn2cxPRcNIjsooTpdA9EPlScqW4CCbBvMlV89bg3lFyKR3U/RucQ5/JqUQY5BcDVs69T9ecPm48yg3Wvc7vc311o8iaq9uFAs3090v8Sjt+OGTZK1Wmz0qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oo94HEM6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61e0c1ec7e2so51575687b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715632638; x=1716237438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/s3/UizLB9d9fYOIbdf0witT1lzFPXKEbUQjbfvT2sw=;
        b=Oo94HEM6V5KE8wmGWaOWLxp8rId9hegFRFFXrS67w4xn9g6ts0D6CckEwHKuwtmvdC
         sGbqugQJj6Wp87viuLeVGEGWs4ek/w4M2vxWkqXKazgWyKCC2L2FxaQz2O4Qen51DV44
         u6Wfg+UqjUjjdr6IJIsNUsR8KlrWvb0LyPj/sBjJH3+uRDyXnwl7DQhz6arCmv3KfEz6
         9VzDrYxj/pIMtnH2dv+orIdcPh5aEPbIlD6TKV1xoLmyfXp4GTZiKZnrdyr6M8UuR1UM
         ZDxtGuCVkFMDQIaxOdbPeGsbch2wJMzwnhKdvEpG7c/bOuzztdY0jN5dWBuBlBnvg9ks
         3A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632638; x=1716237438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/s3/UizLB9d9fYOIbdf0witT1lzFPXKEbUQjbfvT2sw=;
        b=oyIctzOQeM3NWfDuwHtkJSLZq1d5iQcQRK8ttKhVDikVlZDzhGw93MERu4rUTF0Y93
         ilaYcwC8bNRzEP4PMK7ZEk8IPj58VEenNl8bUKtC5tmDK2QL3PZdJbVHELAj6vRurs3y
         FAqgs7nNZ93ODED/gxljXmnHzDRxVwoHx9yllMQZ6kyJ0FhTKlRhUdcmQbQS3cmn0RQq
         ypY28Xf0UM7tyy54SfumiyPEPoKpmHzFhprjjKfcWIYU3Vko2CIJdzdMKk4QRIuHiPi4
         4IQfhSJoxypPemmx1i0xNf6b4S7rctJiRFQOFIt6IrA89Ys2YCAt+810PZMavYlOGDRZ
         U2dA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8YcLJyE0JqZ2ZZhIku3EOOVvl9kqh6lNUzrWLzZX30JFFDmTI/IxEY93wE+OP48qN2Nbq769jLfu9lfM3sa89m13HPOuCsvdAmGj
X-Gm-Message-State: AOJu0YzoUaFqaKNO1+1i/cIJtpN0IFwOTOEhN1r/DA1UzMCBHlgiYVSy
	xzSirq+8jP+mBd2ietBkja9bkxn9b8/1pSEPHXR74xnJt9qMP2F5VlVyiTNdVk+b79zJzTaekjs
	fdmZfLlAXcVG0KFRARGniiEOKBbnAo4Y0F6q/Tg==
X-Google-Smtp-Source: AGHT+IEcMlVLKcTYYQyZW7CkpC4bBM2Fd32LFkkd6763hdBeNFF9PnfVfmZMf9sLj0r0NA2+7tzRkznixINWUAHUzwI=
X-Received: by 2002:a81:924c:0:b0:618:498f:9dbe with SMTP id
 00721157ae682-62099381e4dmr101763867b3.10.1715632638569; Mon, 13 May 2024
 13:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510123238.3904779-1-robh@kernel.org> <20240510123238.3904779-2-robh@kernel.org>
In-Reply-To: <20240510123238.3904779-2-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 22:37:07 +0200
Message-ID: <CACRpkda69tvg=B6BsP2sNx0ah_GyrHjgY2EFNrkqOxN4g2DapA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: Remove obsolete RTSM DCSCB binding
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:32=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> The Arm VExpress DCSCB binding is unused and was only ever used on a s/w
> model over 10 years ago. Remove it.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


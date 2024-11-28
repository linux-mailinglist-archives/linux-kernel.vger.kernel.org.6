Return-Path: <linux-kernel+bounces-424573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE879DB619
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E67B254FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB1192D82;
	Thu, 28 Nov 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8YcD90M"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AE192B94
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791380; cv=none; b=E5M9J2rH32j22A7G+vj2KCCJHBnzhF80NjjSwNDAl9SoGETqSJxC6lEQPdxLLjlj84CjuJU90+9ieY7JRXHKc9KdSG4a2YPzJCX4yAMT6hy2ST0Qlw4lmFoGXrU+Ba1eI8uxHr026o8wqx7TG/255+S0vImhwF8QR33/gHNfvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791380; c=relaxed/simple;
	bh=UHpZFedHEBtUcb+szMjru33LYi0CiBGsIbwkSU8NyIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiiJ3Z5ebKwAzliKssJ7b8OtWJvC/ZkC/PgdpZgxdiWPr/D7ewvY1J0UkzAJJOJ+DXKAPdUXTXBdotHu97eMir6b/jUwFIiWFd3Tkz426P70j0MPAnVPSTnK39j9Lh3yMxcVfK7sw3jhsdF2KPh7099InNDQZVLZ/SmLh0QPHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8YcD90M; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f1e7639391so283335eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732791378; x=1733396178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHpZFedHEBtUcb+szMjru33LYi0CiBGsIbwkSU8NyIs=;
        b=j8YcD90MGucrKbRYkycUXRZYgEiCjq32yAiTbYrVcss7Lz0bRdSd9fpvQxG2PdTU8i
         mShDU+o00t41KOPY32JWUCG4+hBb69q8RcPb2ijQ7Qs+u/JhnEEnMGLVYR7cB5sLByNw
         3Oyyo4+OevlqcJgTZaojPj6owIbVJoL3nIEBdNtOncbSXohtHVfk6zemrJ30RBdEkYXb
         6twHE3DqZD8KneWUvUVQCR6NAQb+RdSKRMB1/FoAaonKh4rXfkhKYvkaQRZccyCloeS/
         PLRdb5CYgg0UQnNptr8qWopC6e3eMjCOX0bdlpHhW283p3oAVl8iouLcKZvn5+KlhwUs
         6BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791378; x=1733396178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHpZFedHEBtUcb+szMjru33LYi0CiBGsIbwkSU8NyIs=;
        b=W/juXtIJrAAoWLxRYcP0UAG/tgwMIiDjgn+nfMmyC7e/7b53BF9ih1odL6dNvipcqC
         WCdOdW0KsGOqOXDsm/6L7TFwZGG8hBHrucRjZGdRMyNETMqWFpclBPB5/73z2R5lrea5
         Rh1jqsuAGSlmbXurCeXucnm5+zkh2CinODpYgahLJOXsNjzbiI1bVSVl3bLmNMVww103
         bmuvqrkbLHe7xwz7lBVNoHrHdjs59fhGbR3h4zcmGGjJtJ/ceA8+4TPGbYio+1/IANxB
         HMByzEepUGi/Cmhj4k6zJDxEPr2jQrsJSztme3CNHqjpTw7x5pK2oSbPvG4AfG4tvacZ
         Jr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe9ayTbfSufE31oc+c/xZvvJ0JNlrfzmHEg2/nm6nNMzPvHBHedOpRrRFC5Dz8RS1zvK/Bx9NX7VcoyWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZLbujKMOYnfFJfd7FGO9M845zrIXtAdlaEkxfuxicNZRV7+4
	KNYWJB+AUyPmk2InKG6eCTFZGm7McOoJyTH5d4SLtrOHF857I99iOPY67QyBYMQElwWNN9zmKu3
	0GGky2OGJjEkoXLvJvgueP8t7VnzkwpPFzngmrJzJWDYlScI7jdI=
X-Gm-Gg: ASbGncup6LqpNXZfnssgAt3g2JZuKEsAK0fNKnkyZTa6iX8rfFrcGQpkX26mtg5iy7r
	PujeAhj2ZpmVVuWgJWVxTaQ6ZRBhEY3Ws
X-Google-Smtp-Source: AGHT+IExQGgfObepg/1Hx1vn3/3ajGhOjBe+ADkPuF/jgeiOTQLuy+sihE6vDknoDDEFX2CMag6bWzzgs3MwxWCbYFk=
X-Received: by 2002:a05:6820:2704:b0:5f1:fd30:f45b with SMTP id
 006d021491bc7-5f20a275359mr5606418eaf.8.1732791378483; Thu, 28 Nov 2024
 02:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
 <20241127-gs101-phy-lanes-orientation-phy-v1-4-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-4-1b7fce24960b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 28 Nov 2024 10:56:07 +0000
Message-ID: <CADrjBPrVgnS3NFVvouRYQ32xBfyYBHKAgFyhEerMzenarE3G7A@mail.gmail.com>
Subject: Re: [PATCH 4/9] phy: exynos5-usbdrd: convert to dev_err_probe
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Wed, 27 Nov 2024 at 10:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> dev_err_probe() exists to simplify code.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

regards.,

Peter


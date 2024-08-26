Return-Path: <linux-kernel+bounces-301067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E2195EBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0625F1F211BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA22145B0B;
	Mon, 26 Aug 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKj/rDxo"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EA142E67
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660918; cv=none; b=nnUGaqCLAhNAeihPwG6QQoJYXoDX/bce23B762sy5xqHq/7fHklH12fYfG4zQhpSu+ZGa14RR2Ir1kB4VMzkJ7lJc7X10cjit6TasDVwqp101lMo2VzXN6ktjm563vDFZ1Aljbdgyb2CzllhElfdLjeQOlbWKNQO+ZU0PiplyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660918; c=relaxed/simple;
	bh=nfo6vvrJ5XV3gfIqsZYHsSskX63WjQAbbcEx2YLChhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQxoxZeNrzZAvG4u0TFKAk2ORBT/SlNKhx1VQayChC6/t2e7yC4AJ5zZgREg1x0TorNGKEhQ2ejpuE/8iWTlg8QGC+WnNGtU4FsLufpTBzTpZR7oTEyGKwNBippTlnl2mQ08mwcUZDyilG58Amyww0+LFJHQPy7dngz43PbfMBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKj/rDxo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533488ffaf7so5468623e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724660914; x=1725265714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfo6vvrJ5XV3gfIqsZYHsSskX63WjQAbbcEx2YLChhE=;
        b=hKj/rDxoWVS/FKQs6HAsZtjSVTcP0L+ImQXAxHb2+U7/uOTvCSBtqTNDTAF9IvxQNn
         TdFVnDm74NOduhJTZRKC5h9kMO4a2t4+MkxJ5sBi0VN9xJrmQBNMI4/iszb5AfavvEcD
         sctQ/PtjLfHNNbJhB1aaeJXS0Fhqn0ulNL+9AKWVbeYpyWn2LaijzxTFBBtfi8V02bMR
         2UMU2ASOJEOhuyLJaA9nt+f4CFJLuFdh+WnJTX3oZCzdxluEaHmH0lqm2BmtaJCCLZnI
         zAO5/IzBUcxY/GlZJvlgGBXitiGmDUpeWTWByD5GT92mTJGnFDdbjxXUzYboRlqcLYeA
         efWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660914; x=1725265714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfo6vvrJ5XV3gfIqsZYHsSskX63WjQAbbcEx2YLChhE=;
        b=vxbeWSRt/owDrVkY1HaVWvseZD3rJd9crgTsvxjWMADpwEwXfrFyiQhWqWPQJLdyDz
         O9ocjlbIMguXyvDNm5ccXXpeysUggnx2gm5OW8ajV+XHy12OLt1V+bWCw4kMh0HFStZk
         qt05GKs91PlyOeqdJTD4DGUlbSyMhbfWC2h3tbUUrWicMEMklOGi3bZUFMoWevoDPcpC
         eRmhrml75hLwMvoP7vOJox+zaGynGKmNAH+AeXF/pP5flmbpjHCAi+C+GkSfX292LWcv
         Z/vemwCYQzXZcg/kAXYR5+/SVJbt2QKdMTItPvSkesTZdAthRV1pQh8Sa/bGrpHzG+2K
         RhMg==
X-Forwarded-Encrypted: i=1; AJvYcCUHDfAQhg5f+kQ5zNhFLegHm+GrvwS3TdCJJSdQLRVEglyWH86Xq8nIdz+/KegJsh7jUJ+Yx4xNYE13TF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5tOvl4OBvSfpx4cYd+7Sw1SSLWIKTJ7qp9pm7kypQKUx1V3b
	CBdPpZfxR1KBwbaR9i26JLvyLFAVVUqwhLCqUIYIhLe5mrIaqQ2sSuLkY8hXBIRxCLYtQg+i2f9
	uX2nZhKQ4QAqTN7cQ1wL6dqbyijn9vjCk4eGA1A==
X-Google-Smtp-Source: AGHT+IGs2ltol32MbIOvJmgZIbbFRg3owZJ2hTo3b8Xo+4GFhbYq6Rkj/hqrBlVkUe54/vwZ8VgDB2KusvtF1yMA0E8=
X-Received: by 2002:a05:6512:159a:b0:52e:7f18:176b with SMTP id
 2adb3069b0e04-53438755531mr6354000e87.11.1724660913886; Mon, 26 Aug 2024
 01:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822044156.2301-1-shenlichuan@vivo.com>
In-Reply-To: <20240822044156.2301-1-shenlichuan@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:28:23 +0200
Message-ID: <CACRpkdZW5o36etsTG3CBb1hC3T5Zu_cdYa9tz+BOsHiKP7mG3w@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/pinctrl: Switch to use kmemdup_array()
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 6:42=E2=80=AFAM Shen Lichuan <shenlichuan@vivo.com>=
 wrote:

> Let the kememdup_array() take care about
> multiplication and possible overflows.
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Oh nice patch! Applied!

Yours,
Linus Walleij


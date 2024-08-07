Return-Path: <linux-kernel+bounces-278030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0770494A9A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792AF1F29DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640B7347E;
	Wed,  7 Aug 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OwD2h9d8"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377C39FFE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040048; cv=none; b=IKYH74xZb8WqzblIUZn/M+vQVn1uMLZ9xmqnrvtN56VHylH7v9tBO5/BvqTfahbmlvcgcDdcDe07Kzg51KkY/stuhTdgyxBmrtcEdPNbOtpSzEIAPlXlbanwZ6/FpLBz0NrvhOSGtXg2jftZ25FFSySRELZt9Uh1+3iToB9CcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040048; c=relaxed/simple;
	bh=8U6pF6oteZB3sbXc3seOXknJplxg/i1fuxIfbblSw1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SRVrOm8gjEpFWlfXNcrjOlielzirUNQ9ZNjZHJaAd+MdIoC2Sb6lNuqGN8/x5pRhnv1pSOp9pHEx+t58sJE0T5migohwCFcJ4tdbm8Ep5/WWSx2FtqMrBFsHSG5+EakAL/JnBt/nBnw1hXqaLURDK/9a0GDo0+SunKle8nL76Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OwD2h9d8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso17730315e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723040045; x=1723644845; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8U6pF6oteZB3sbXc3seOXknJplxg/i1fuxIfbblSw1M=;
        b=OwD2h9d8Fq+AxxtD6Eqc/1OmqeQCR2VFt/qMzg2llFEecWOqAuZEat40KAIubrtN43
         fTjPpCxt6g4SIf1ENA+Yp3152uMi7wSp6cdL5sfWb5dTfEzZIy3JdNeE7/qYX9/YiMZf
         GFfvIEjyqygrX5TpFSbIKaqXqkr/5WFoZH+OmgViQNpV24Q0c4guDT3jFUNqVhjeDAsQ
         ASpgvrxr3wpjfs6AsVB4V220UiOfslfrjCT4zSHQJDCSgH+mkKuj0l3/9llIeO8S4jyg
         zWW79zCnWONI1eV2ymqvLhFVwnxS8LjWGvU0DJ+NcdEu6wu35c++N2FmgeEsC5nQrpUq
         EwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040045; x=1723644845;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U6pF6oteZB3sbXc3seOXknJplxg/i1fuxIfbblSw1M=;
        b=tV6pDbDuJRj0Rjo8iVRRddUtaIad4zokNSeb3rNZSQetxZq2257S7ePKeAhxS3Qqv7
         hdIy2Js3oXGRFDs9f5HjNfOdlL9762jITdtdSpnMtl7dJmFEoyrvr0gsnCx8M1cg1Bb2
         liYNEpUOBoeKScqUmY+xLIOy3JfNt4ZUzexpZ9iOvAp3/GaraSFHvbPQLCn6ZmInKO+s
         ty0ZiWG9RP4Ey1hDtvwAQIZg5g+xvXGN4xLa5CPfVyY50kmc4PQW5ZePePuNLSUs58q4
         qMXZNJFwXfHJed2poF0pjcGyTiC88LoN7LFSAcA6ySmhVnnsoWLgovne6Zb/2gp41OBJ
         Z7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRonc7FU6vXTbf9Po50y+uNFoXj4FDZ0JY4CIZtj00YSlFddXx/++CRdM3/NmlZKShGsR5NoURlvQm65htYLwW2wd/wPzf5Ay5rZbH
X-Gm-Message-State: AOJu0YyRJA7hlj3dK3YyvwN33qBj55ezJAxUaYZLNCOALwFBedSlrdqr
	fma0aMvtKX7GhIubrnz9lsci4lPBJdaGWk19K7PYbM3eJjcJIcSuigB1NQq8n6g=
X-Google-Smtp-Source: AGHT+IHFS+8FxIsgPDMxXI2119/zXQ32Pp05XpEgQOQyCV3S6/MHUfyYDHMpWs/M91Kr6YsvZoGl1g==
X-Received: by 2002:a05:600c:4853:b0:428:fcb:962 with SMTP id 5b1f17b1804b1-428f06c44cemr111691625e9.36.1723040045344;
        Wed, 07 Aug 2024 07:14:05 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:90f1:3c4c:261c:b0f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290579fb34sm32100245e9.14.2024.08.07.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:14:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linus.walleij@linaro.org,  neil.armstrong@linaro.org,
  khilman@baylibre.com,  martin.blumenstingl@googlemail.com,
  linux-gpio@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] pinctrl: meson: Constify some structure
In-Reply-To: <cover.1723022467.git.christophe.jaillet@wanadoo.fr> (Christophe
	JAILLET's message of "Wed, 7 Aug 2024 11:30:54 +0200")
References: <cover.1723022467.git.christophe.jaillet@wanadoo.fr>
Date: Wed, 07 Aug 2024 16:14:04 +0200
Message-ID: <1jy158xvwz.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 07 Aug 2024 at 11:30, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> These 3 patches constify some structures in order to move some data to a
> read-only section, so increase overall security.
>
> It is splitted in 3 to ease review.

I'm not entirely sure it eases review in this case.
If a v2 is necessary, I think a single patch would be better.

> Patch 1: struct meson_pmx_group and meson_pmx_func
> patch 2: struct meson_bank
> patch 3: struct meson_pmx_bank

Is there any reason for leaving out 'struct meson_pinctrl_data' and
'struct meson_axg_pmx_data' ? I don't think they get modified but maybe
I missed it.

>
> All patches are only compile tested.

Looks good anyway
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

On the vim3l:
Tested-by: Jerome Brunet <jbrunet@baylibre.com>


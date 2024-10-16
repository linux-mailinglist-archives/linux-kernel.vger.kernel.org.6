Return-Path: <linux-kernel+bounces-368342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A519A0EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1929B1F23A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA0F20F5A6;
	Wed, 16 Oct 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFhkihC6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D720E011
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093212; cv=none; b=cy+B7oBVmbLhqMI7s9JaKQ1cbUctrBOcMTHVrwhvx2IRvC7cNJkO+AbngxoZi3auNZbe2tj45rowVoTP8C/yH1Qtzm6xHi13+Dy897UHbsFf3Dj/5c1ALsI6SJH+iQKqF6qEQAO+nem3qoFq+7yj3/AjY4chO0EvQGUBXW3UgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093212; c=relaxed/simple;
	bh=nJMbjUcKi6EbniPKKMf5mPOzUN+tw8qhO/6T2EniAjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm8f/gPyYs5Gd+MIB0ekHbIHRFqYl2Oly8rWLFs/vKjT0aB91EHUpnKFCrn8xGWNmz7O72v9EqQ+L6H+CUfDH+EOSznDKE4jy33v2h7oJI/CI3Dumppq4nSISDa208B5ouWkZp7ZNxf8Ldt8B5NAgKVyUAZ24D4QSrYqINSGZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LFhkihC6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so864311266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729093208; x=1729698008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJMbjUcKi6EbniPKKMf5mPOzUN+tw8qhO/6T2EniAjY=;
        b=LFhkihC6h+SuV4bvI/8MUeIhbL0nNdBLD+jr+3Mdpr+hN19VrzTq9ZdW87B+l0ayJN
         rCWj+5bBDrZh1AaaICUyaoHwofAKUTCT/Q1C5qx5/QSO0CN2m/DhY0M5Hy7gipviLFvK
         XSq85qciztECP2GstvtW9V3TJhNgzLo/6d/dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093208; x=1729698008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJMbjUcKi6EbniPKKMf5mPOzUN+tw8qhO/6T2EniAjY=;
        b=Fgw2qhrGRJUkMQfYD7RwppifP1LANBD0bzJSxK5hMPtGNUWvZriXJ9X32To3UsWc5M
         N1pJhwA/3PValXhgwmpENIKQymcHqx9YDhA0IVTGHfUf6TwtAtle0NAFzdPxsbxok1sh
         haoK+7lMkdyTtSeXxRpmYzvM3gd0FrMVvrXwZi54xbiH7IhEmnvMElR69/jVI2X4IKVm
         6P2EFBL9mWEuWsAWQOpKUQlMr7f0EPd7yBrV5BkpNmLOz0P1RkYEF0IohQZaLOoyu8la
         FXSOuRNxXSQs6zTVGjV4a86EKnArohk1tv1/bsJ2chvDojFtA0zfIv74M+voMHOR8WAL
         A3vw==
X-Forwarded-Encrypted: i=1; AJvYcCXfbQM3j4dfFYX9lQuFCzmjVDW9jAezYchmqzuSqqa7cMsH6IOWK4n9m8kW+3tbLab2r5jpGarWkKJ2zps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2XMVV6MUEtAcD/RPwg/QgBe7FCMA8wc1G3efTrfbIfvZMkmb
	aZJwghC0HK4qUzOyDmbJ173ekwesWPXEaPCS8z82wlJu1HK2ndCD6nVWuo+CJ4J1gFWU5WzLaRB
	eeTrV
X-Google-Smtp-Source: AGHT+IH4aYW2nwoGoq9uhkkZZspDNO/jKA7DjqzeTUPKeW/SOa+Js39dRhjEgdjOv7yHL7qolfXMOA==
X-Received: by 2002:a17:906:f59b:b0:a9a:238a:381d with SMTP id a640c23a62f3a-a9a238a40demr602135766b.52.1729093208531;
        Wed, 16 Oct 2024 08:40:08 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29847477sm200480066b.146.2024.10.16.08.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:40:08 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so864308966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:40:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoJbrkjrl9TfFruoKpbzU185GNmFs2GeOO95iQQqYcFnLN8mq63IYrhq5Gx0L58LtyO+a7PCWT2FtXWTs=@vger.kernel.org
X-Received: by 2002:a05:651c:1509:b0:2fb:6465:3183 with SMTP id
 38308e7fff4ca-2fb64653a19mr17100581fa.3.1729092857448; Wed, 16 Oct 2024
 08:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-7-wenst@chromium.org>
 <CAD=FV=X+_iYi0_RSakh6bzVYuNpiqUvjHTrL81n8h4dO+WZf9g@mail.gmail.com> <CAGXv+5FTdNqK14OYe=PN5_BcF9Ve7-FyBTKz=mJ+1QiiUzu0_Q@mail.gmail.com>
In-Reply-To: <CAGXv+5FTdNqK14OYe=PN5_BcF9Ve7-FyBTKz=mJ+1QiiUzu0_Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Oct 2024 08:34:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNZJ82e2rfMicAiXmxAx5hwydsnMVO8naaakRfroyNow@mail.gmail.com>
Message-ID: <CAD=FV=XNZJ82e2rfMicAiXmxAx5hwydsnMVO8naaakRfroyNow@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] i2c: of-prober: Add GPIO support to simple helpers
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 16, 2024 at 12:49=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> > Just commenting nits, so:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I assume this stands even after Andy's suggestion to drop the gpiod check
> is applied.

Yeah, sounds fine.

-Doug


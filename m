Return-Path: <linux-kernel+bounces-182801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89B8C900B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C91282C6C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5EC10A11;
	Sat, 18 May 2024 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="DkrpsycO"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC96D53F
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716021977; cv=none; b=lHBuYnFRWFgQgCoVLvTYuicW+RpURZu1kDNkfAUGwxjP0cuX9y0AZP/jpk+eWlBfoiTzDqfHehH0w+y2sz1CreOew16YSxeP56YpKeM9T7N0O9hgwyXHVuOUKWItWhn7Zg5jokeSQdEuhaToDLyCuudv66oWx0ORwfQn1Cku4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716021977; c=relaxed/simple;
	bh=n+rd4UdCyI+BaLvkA5VSQVIe4oBJ+kbE0mtFLmAsgdo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G8JUQoDMxTFjPXkZx7/zL3gRWHQyuSyRPFmvGyPfLN2zodZgqDGSqZVeZ1aUMvWhUme9PwcLZWIxrd3KXjHwaDnLms6wPznfQBv0N5cYbLzfugOz/UIEULE2i4VluT66i62HVQrPY+TaSjfgDdKLueFFrydRGAlrJcQhbH1+RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=DkrpsycO; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-deb654482bcso970291276.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1716021974; x=1716626774; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+rd4UdCyI+BaLvkA5VSQVIe4oBJ+kbE0mtFLmAsgdo=;
        b=DkrpsycO069AYhYq9GBOaJ0uKtv1y7uVKOqqstq4wpKCt0BHPdejaA1pywFSJHmxBe
         lMFY79NlTOiRucxYgbbL3WOcZhxrkY92vNBzWzBLFvasGOU1dw9POI0Jcp2VV5BHTaYV
         Hh3yl8hYFh7PUYSUL57J0L79tzqFLqIce9PsDRpL/LqZtUBFh/gUF+qv8SDk4sWs0Mbw
         wYQMBoGcx7M2UP7hX/hp+TkeiTJCp9o5WKPj76NGNPSgxBlJ/gfpqbTDPrduUKHL16Ep
         spkkIq0hbNU/PGDODU2Zy9homXVUi71vwGduy/8Q6DoFmjWFQbDk2YsnK01R+ACqzAro
         ohOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716021974; x=1716626774;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+rd4UdCyI+BaLvkA5VSQVIe4oBJ+kbE0mtFLmAsgdo=;
        b=kEfMqTnY1YMT0r2RWqTmVko82hkw2h74HDp5+pcNKzSAhWf4LrjStqJH9gl+GyW8N/
         VLxGRVYX31yHLRJLJazULocOOHiOj1lH7bJhMhl7IFCQfqcy2JodHODMd9wtZumarmdo
         m0sZqvax7v7Lu97ObrsZzMGN7bCCb8pUayIo+wTesU+xDpRufvEC2CqV5UdnCLNcLmYS
         B7EL3CsvZoiClpaJ7vmV9WlvRTFv3ypsLLOWJRPxWOLl5uteOoLr3MrTKzG7y5cVGI57
         ybhh7PC1RofqCde4SFMLuvT725efL/PvIWI/VUgKbU6/K2udDUzH8Wy6KYL8IccEPfcy
         HpkA==
X-Gm-Message-State: AOJu0YwnmRQ0pDm30F44h0gg0OIqaodVBtFDBew9sx42m0D78aWrY3UF
	o6diTAWam/Rh9vy2wP4dccgV26v80QdLKqtxgQmpkDzp79fTeadtse1wJXVFflClIRM6ctCV4nV
	dRihFEw==
X-Google-Smtp-Source: AGHT+IEG/Qg9DqrOMcsGkH1NwVS01fWthCqMi/t7m8lw5wBsgjPXSwXeh2aqtg3QoDBT08YMCz3LDw==
X-Received: by 2002:a25:a428:0:b0:de6:40c:1910 with SMTP id 3f1490d57ef6-dee5229146amr21092641276.50.1716021973874;
        Sat, 18 May 2024 01:46:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd382857asm4077650276.45.2024.05.18.01.46.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 01:46:13 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df1cfa7f124so1001260276.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:46:13 -0700 (PDT)
X-Received: by 2002:a5b:5cc:0:b0:dc6:d738:1fa6 with SMTP id
 3f1490d57ef6-dee4f1b8bdcmr21070438276.6.1716021972694; Sat, 18 May 2024
 01:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Sat, 18 May 2024 10:46:01 +0200
X-Gmail-Original-Message-ID: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
Message-ID: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
Subject: DRM Accel BoF at Linux Plumbers
To: open list <linux-kernel@vger.kernel.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Christian Gmeiner <christian.gmeiner@gmail.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>, 
	Lucas Stach <l.stach@pengutronix.de>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I would like to use the chance at the next Plumbers to discuss the
present challenges related to ML accelerators in mainline.

I'm myself more oriented towards edge-oriented deployments, and don't
know enough about how these accelerators are being used in the cloud
(and maybe desktop?) to tell if there is enough overlap to warrant a
common BoF.

In any case, these are the topics I would like to discuss, some
probably more relevant to the edge than to the cloud or desktop:

* What is stopping vendors from mainlining their drivers?

* How could we make it easier for them?

* Userspace API: how close are we from a common API that we can ask
userspace drivers to implement? What can be done to further this goal?

* Automated testing: DRM CI can be used, but would be good to have a
common test suite to run there. This is probably dependent on a common
userspace API.

* Other shared userspace infrastructure (compiler, execution,
synchronization, virtualization, ...)

* Firmware-mediated IP: what should we do about it, if anything?

* Any standing issues in DRM infra (GEM, gpu scheduler, DMABuf, etc)
that are hurting accel drivers?

What do people think, should we have a drivers/accel-wide BoF at
Plumbers? If so, what other topics should we have in the agenda?

Cheers,

Tomeu


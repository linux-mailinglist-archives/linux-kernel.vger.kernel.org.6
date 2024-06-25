Return-Path: <linux-kernel+bounces-229065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A40916A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E1B25227
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15416F0EA;
	Tue, 25 Jun 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eX4XOT27"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960A16C438
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325637; cv=none; b=dc/87s00Kk3nS7pGDhJwPEO7cJDr+ltCXbOXYIgtb6nnYEeBK7srkwLOE0LKyzj3s/t59ukuGnQNU/DZw7BR5yH0Alx0HnOTOtlp/eQe5fBHUNVRQMeSMBIshlCXvUTFglkZBEvA/0HjCRQcXZ3SHr9LwncP1Q9iINjTs5zG6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325637; c=relaxed/simple;
	bh=knO37GDukZpiNtbnbyInUf67MD3lGHaNFx28byTdB+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzWRBNNFfhyrbh43YHrbGri+NNdQzcQJ+qgit3XjEsYgLiwp34sX8Pr3s+nOEerHQU6IWDNcJp7wlNXacnGRTQjqE+LaPbM83jwuiYiKiWl+GiF3RuwcgPTK0nF9keVNd9SP2FU1D+6Nqqq8CHkERUg9I0OrWCNKb3lZFEyN+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eX4XOT27; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so11911a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719325634; x=1719930434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=knO37GDukZpiNtbnbyInUf67MD3lGHaNFx28byTdB+E=;
        b=eX4XOT27ymOofLAhI4xdB0902gFsMVOrba+mEXGmiYQbk/bPaJ6yiNCAMxvohXB52B
         KrlG42IY2yJEQ8JS6r1flBH66P34ZKYw4ikqb6cWjpqrvh5MiPt61BvMAkB6a9XZB9jK
         1zu8ynJazEPt7owO3c8dEh++BPWJynHnhY5hCpaw/io7NYy9dlw9T5j124K/aaBvF+Xz
         nyZ5c6nusUqEBiwWEmaXFa3L3jlaFFDOtE8pPgfnt78amAIvLvCpvK0VidP7JfRAK6Zi
         VEXTnGytCxVDbkTsl/fXHBs/Sf6SaxhPpkJgp2Hh/oJHnPEiLUh4ZmL7dSOenYhUdJF5
         HOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325634; x=1719930434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knO37GDukZpiNtbnbyInUf67MD3lGHaNFx28byTdB+E=;
        b=El6iJap4y7LEyo/m35fjaCYpzAHvTMwXbOkq1uowQBhtvVeJGBT7A+qBpF0BieF+RW
         AQTy6NNx2cWn5K0FfCZtkshpOufkeiGw07MnK58oXXkA6BrpH6MYl+l7cRl19TqfKBdP
         z9Bfzxh+RlYyabaUqTCfk8AsRVRdH8B0KiOCFwHhJWHf4fv23eWKl/wlxJRLAhpNPPiR
         UgcUDf/nvm8uhgj9zmhrUf7gzNZMmTVPrY/RUfOJY0lzoKg9pvqw+g2cfUv4pSIvM3Iz
         +X6lKcKGxN7p9DSTCqVzsObaajNXczKCe3RBTsD2Pirtg9B17fQOLzX2py6KsJDNc+9p
         /F3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAeNKz7sg4wW2iUM+sQYgpIUhCtk/PHzlzRAligohbABE1Btk1eIHcKcGnzDi4CIoqeuLdipmwGWcq7QOZ0Kw5/edpcQS9x3+5VA3E
X-Gm-Message-State: AOJu0Yzl1qOOY3hzoOskB5McSdeXSLHHm/rgakFSemO9X75/tv/loyHM
	0vi+XxaIHICgFkdnsQ21sVImWlILYm548uuPC+j7IPkXW4J6hJcB4uCAxdO2s564gXajh8U9r90
	mtq+sVECjD4QJRO8feKr12cJKlrSltI/dlhyo
X-Google-Smtp-Source: AGHT+IHT3NVolr6Ef6aOrP30B/kob1o8Kc+MQP0V7uf4eVGsPB5MquC1QY9yCGsgJGZT5y2nYfKZOd04HyEN63bfGTw=
X-Received: by 2002:a05:6402:5206:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-57ea5f50837mr166319a12.7.1719325633577; Tue, 25 Jun 2024
 07:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612180448.1.I805556c176c626872c15ce001f0e8198e1f95ae1@changeid>
 <2024062032-bobbing-backspace-8bd5@gregkh>
In-Reply-To: <2024062032-bobbing-backspace-8bd5@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Tue, 25 Jun 2024 07:27:01 -0700
Message-ID: <CAMFSARehnCK-xEe31_diLV_oavMSctXgZZcJKARN8gg443R4nA@mail.gmail.com>
Subject: Re: [PATCH] usb: misc: onboard_usb_dev: Add match function
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Benson Leung <bleung@google.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,
this fixes an existing problem. On chromebooks using this driver for
an onboard hub, connecting an external hub in this ID table fails to
bind to the generic USB driver at the lock screen (devices default to
unauthorized). We are still trying to figure out why the hub isn't
able to bind to the generic USB driver after the onboard_usb_dev
driver when the device is authorized after it enumerates. But, I think
it would be preferable for this driver to not match external devices
in the ID table. This resolves the issue for me.

Tested-by: Jameson Thies <jthies@google.com>
Reviewed-by: Jameson Thies <jthies@google.com>

Thanks,
Jameson


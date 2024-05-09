Return-Path: <linux-kernel+bounces-174528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1398C1021
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFE1C20D49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645191514F4;
	Thu,  9 May 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QVwpTfNp"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E31474CE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260077; cv=none; b=IWLoB6HUBc5l2yaVXQHaHFjZqgNYkyVroGvdSq7Rnj56q4nTQLra3iBiFjgt9fPLWZmldVh7hIJbd5UPNIgLaw7eNhXTVefsPVcWrQqlHmDIURL8FtnL1Nj6Tqf75mXpYNWsE6xU13wn/iHr5rg/JwSC0OTFtuy0RT8PGZDmgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260077; c=relaxed/simple;
	bh=z8SqJFswMNiOCt/oP6O/swgxgA2P0/VGrYDi7IdlXyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXnTZUBXCOZKsP8HRPKvcvo5FH3s1ohzV1B5/EapuTggdgP837MlYOwwT8m80VtJg7yhqEaGImyXiE46GM1hcVv/0lvljWXzANKHdVsPj5wXBE665PidIjqEjB5OUl9u3rMCY2GsOq/F17GIF/uLVn1KIxqe9q3i+2aigeB+Apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QVwpTfNp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e3e18c240fso8979291fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1715260074; x=1715864874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnIPJSuPpdfHAhCpgelWzQDxXKYscFTQ9fmV3MxWiXM=;
        b=QVwpTfNpnFBE6FSBD5Z1mVRCF0biN2xFbwAnyst68JqoS9BEABNmZP+hUhvkAiG9KS
         1tSRA5djNokPEEGG2lHtZ3Rco9n0H7FWKbNVsgRjUS1eQ3+0G5BqPw8n1CSlQEGxuZow
         awlG60ddW+ndAC0R/IeoBcGdOepQwKc+68w3HONwScqLSCoU7l01Fa5ryg4UOuumXzre
         EcTwFNNf45hM/knUaXjagCp1YD04K9hopJPtuRSl13jHvLELNqtlN1xPiBJV/+NtqpdO
         TYYYjOubTWoA+apwtmZSlQlm1jv5X71p1W/Y00VgPnK5dXR3etJ6NMahhA6iP8bqW+3a
         CXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260074; x=1715864874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnIPJSuPpdfHAhCpgelWzQDxXKYscFTQ9fmV3MxWiXM=;
        b=tWkPH+YLLylRB5sLD72q6NlyiL/kfeXVvcnhtJfxZCs+UE7AG5YYcQOKw6jcB4EHaw
         zMvRaKx+SXSpf6xpIDGvXuRNlbnxM0YdGQ1jOpccvxgbc3ZEoaX7PXgr6X6h0nTw5skw
         GZ04/dwuR62CHmY5+ZpAqo+YNC+7cIdjZbHfZO/qnQ651qWSS9pfun0M4vC1trvoTPGZ
         edvjD6zEkGGu39u5q7khMvcAm01MEGs2kF2xs1uZ4jPhRDjYoe7E+Bineo7YohSL1eqT
         +CubOg8vS/OPuzVG+kn3mz5+un4PvEUJrpheMs/025EwV2ZkMtH6RjRWRfwZEd946yzk
         u59g==
X-Forwarded-Encrypted: i=1; AJvYcCWbX0qe4ufkJf6Drzagw7xvYEY2jcrwGltBJsVjGZKTsGRRny7448qN9DMAoQHJooP9FVpijW4C7RIR1PEE1keZA0RPj8iXRvDJztT8
X-Gm-Message-State: AOJu0YyJBqQzQdKLJTHfjUylhACt15IEaaqoabygFTzXRr0DjZPJI4R1
	AdsHD620aOR1/mMUt7StFT9Xe6++ycrPS9vGl7D4Cjjjn0FzZu3qUW5kEWe1Gy0=
X-Google-Smtp-Source: AGHT+IGqH7UFebNPJ9olqkCf6MNwQWe3pDuQuLPOy+hnDSHelK8uBIUKEyXUUQ5x6P9RLIO8q2+38A==
X-Received: by 2002:a2e:870d:0:b0:2e0:3f37:5af5 with SMTP id 38308e7fff4ca-2e447697286mr45694331fa.41.1715260074260;
        Thu, 09 May 2024 06:07:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:5c73:df7d:ebfd:d941])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882085c5sm60626675e9.40.2024.05.09.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:07:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] gpiolib: use a single SRCU struct for all GPIO descriptors
Date: Thu,  9 May 2024 15:07:52 +0200
Message-Id: <171526005990.16179.13548989415103122490.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507172414.28513-1-brgl@bgdev.pl>
References: <20240507172414.28513-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 07 May 2024 19:24:14 +0200, Bartosz Golaszewski wrote:
> We used a per-descriptor SRCU struct in order to not impose a wait with
> synchronize_srcu() for descriptor X on read-only operations of
> descriptor Y. Now that we no longer call synchronize_srcu() on
> descriptor label change but only when releasing descriptor resources, we
> can use a single SRCU structure for all GPIO descriptors in a given chip.
> 
> 
> [...]

Applied, thanks!

[1/1] gpiolib: use a single SRCU struct for all GPIO descriptors
      commit: 7765ffed533d4a9f0291a0edc660496d104396ec

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


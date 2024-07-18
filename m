Return-Path: <linux-kernel+bounces-256610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4398793510A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E84282E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF6145332;
	Thu, 18 Jul 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OtcYOsD7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1913C676
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322238; cv=none; b=QtuFL03UWHXIRf6i/5QjyTmwY4NMih7PhnOl2NEctZGoD2sFih4cSh/x4XMQMbLvVjWCeaQnk4PKJ1Yefadi4KNmcz8w3YH/RxxWPP0jMwve7OKYSswzVl1xXMM1/6ullg4WdK490R2QeS8zkGqWFnBo0D2AqN51849+iJAvBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322238; c=relaxed/simple;
	bh=eMxvtXjmBofXpgHzdVBZoD12gU0IqrUEaQAh4h0MU28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlNlsjNhGBbAt/GTN3jeEkX8dfwwOlhM/e9FfUfEqVU89ioMDpp66riL20fn62pz/oMPzR7OZjrd22q1ajXn6NIEw7CrjdJM3+1h6wkIJwV2WUpwHYHxHmoXgDndgk+YZ6aKPpv/Bl6Ib7vVVeMuoAH5khfCFMjF+MF2YaR7rf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OtcYOsD7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so15823831fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721322234; x=1721927034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mSur0PwJ6RbW9RkHokWDBMKMWW1APUjGaX6bxJxcylw=;
        b=OtcYOsD7YhRjsbmOxCPXznNTVfJeQ+lqoGS4KDMDYzyZG1nvRkvNJyP+K9m8KWqdWZ
         UkbQhAFBqb3LLRzS815OM5yukhGs529hpB/UrvrV7c4FACK7yTRAef81XBHlQgai3/84
         2quqLZtK0PekBQsd4QbLONMa+GlQj9K7AW1cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322234; x=1721927034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSur0PwJ6RbW9RkHokWDBMKMWW1APUjGaX6bxJxcylw=;
        b=UEywjuHZZk0l/P95MOBN55L/+8wFTv3DGdYjlt6OlrwceHPT8u/amYglTHe/xZyPnv
         7IzQVmiofycWL5bRGwP+cpplzbuvZHnFX8NDzCAY4dEJVJIq9uuHkz4FAkKoKlfvtyk5
         lHPAiw9zKSfl+zOLA0iM/1O+qqJf3/Lb0wNbIKQ0KS3d4jCnYay1dw/ritUQ57p/qB6/
         g/3XpDEmYTfS8/Pxt8yRyDzPMo1Ryvx4tPgoMmqIB5oBiRM6yQ0aADyFUwuXhUYxB3JO
         v7C+XTfvfVLLl9rsvRrB9oUOdbKRIyFYVGSdPgQsGmifz012qw2P6KcFHgr5rJ69hXFF
         6kQw==
X-Gm-Message-State: AOJu0YyZ2LEc+d5tiLbp5slZEaYQEc2b6BNjK8/rSB1s72AaDjBwoUU9
	6XRYrFLFGoTNVkEI89MuB32fQcik5/x3b/j4ZyIweWKxNno2Z91ps+EmzmXrmHvBTZL2ClWThEo
	zSjv04Q==
X-Google-Smtp-Source: AGHT+IGnKjFHC5gPhOlMf1aw1eO/l1UJdZnPrEDmGdOUAj+Ox5j2sezJL3NJ/EeahmkUw+G9tgFkKQ==
X-Received: by 2002:a2e:950f:0:b0:2ee:bc94:6854 with SMTP id 38308e7fff4ca-2ef05c6fa1cmr20506311fa.13.1721322234437;
        Thu, 18 Jul 2024 10:03:54 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a2b6d36cc0sm64952a12.35.2024.07.18.10.03.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 10:03:53 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611baso61786a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:03:53 -0700 (PDT)
X-Received: by 2002:a05:6402:35c8:b0:57d:2c9:6494 with SMTP id
 4fb4d7f45d1cf-5a05b9da300mr4830368a12.10.1721322233393; Thu, 18 Jul 2024
 10:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717162421.1402773-1-masahiroy@kernel.org>
In-Reply-To: <20240717162421.1402773-1-masahiroy@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 10:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipzh7eC2uSiVgDK4_1Gz250S_TNwTyc-9B+UNi9z+rKg@mail.gmail.com>
Message-ID: <CAHk-=wipzh7eC2uSiVgDK4_1Gz250S_TNwTyc-9B+UNi9z+rKg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix rebuild of generic syscall headers
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 09:24, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit fbb5c0606fa4 ("kbuild: add syscall table generation to
> scripts/Makefile.asm-headers") started to generate syscall headers
> for architectures using generic syscalls.
>
> However, these headers are always rebuilt using GNU Make 4.4.1 or newer.

Thanks, applied directly to make the rest of my merge window go more
smoothly when doing my arm64 build testing,

           Linus


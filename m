Return-Path: <linux-kernel+bounces-569866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83CA6A883
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EDB1693CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96395221F00;
	Thu, 20 Mar 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKOvaGX4"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F31FB3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480905; cv=none; b=lgehj5UOiWQjb2gm+IsQvQZ0zLD7UUV3JJkG4kJzmikvigskijBBLUxdpKHle5pGdqb3ThQrrNylBhB72qydjuR4Rdgb4tAtheSqxZ0eDAu9q+Hz2NMv8vJOfeAoeIGWSIY/MASyTLJm4yZBGEYaicH0QEuV9HXdTIEm19FYJmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480905; c=relaxed/simple;
	bh=RsdZkUsk5UtzFzqDXdhsrRghLXEABXsbDQU85n5KAIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSkJ03Lf8E/ywzsDnPJR0SnmYW34jj4XfVA0wP+mr2yhcFQ0cQn/rpPYhdcJ62OG+W65vbm8ctwRtUz9aoIgySZeZeTc9zOa7dLtFwyI379lPiA6Hbplx2jFrD0dgmWXvcfEVF0Mo3lSCz6Hdva/Hcq9jUAOi4ZB08Zax4WYE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RKOvaGX4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54ac9d57173so2142186e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742480900; x=1743085700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ww+0bTeyue6svnMeKBSk/xdNyoWqvfMEKk7bLUAAgc=;
        b=RKOvaGX4GNStSRx6ivwvEyh4+EiPRezV9AaG5urfN+3YvRfqJacb/tjZ5zaABWedPT
         yhjTWMQixKhNIG9r94WnCEHxc0uMpKfUv0ZU18YrxcPmIUEPlzyAKaJnOfnbCFP/3Lx9
         MkMW5ZrgZWow7DEeCLjNS2Orxzif5ivyVzfXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480900; x=1743085700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ww+0bTeyue6svnMeKBSk/xdNyoWqvfMEKk7bLUAAgc=;
        b=FeHqKCU/2IZ5rbyXlpqQdhR1ILpID/iXaXEiTfQiyOvXjnbNblPF5/jhpSiFxbJYBf
         OCK2zpNUT5uLElfgLBB3yvXjOw8c/StcYmme1Kh38dWrcr1IuLpWZBWQ5qT4EBd+Qtu2
         Wbo942MEOZFtD4GwQQEIV5jsBPZnIgWF5fy3Ocgf8NH1JwmuqUtZizUbtdWFAOEuxg/B
         StOJd331qVxw+oiwGgEKpuj3WXm5XYHLE84dgalFsS0YbeL895AZv3WlHHORtOQLHQZG
         HtJJMjyJa9Uoq1fBQQywML6T51q+gTw8jj+cGwM1L/hOGjw3J+f974yJU2VrAUNrWAXj
         zrJA==
X-Forwarded-Encrypted: i=1; AJvYcCXg4JoRAeOGxtOid2XRANeJq7z7kEG7i2NUPzzogRTtD8O1ht2a0T1MXH4ixVzUSubQOTue5M88J/ei+aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu1ovkIBc5plzs7LnYR6kAr3YMgmeox95Ds5vGu3mF1N5/PP/H
	nLNEy7Odu1HgRI5bFEAQ5OYfixsmu7STMogRAcc8qh1OG7JRJ5wZxxpNLwWHNwmDwMIErAA1/1f
	bk3aL
X-Gm-Gg: ASbGncvaTU7qU/vvvb0AXZK29qW9XFBjXxGkH0uAO1Y8TwIh9msMehqM7NeZFf1BI10
	oopuT+USEbdtikWb3Ll8bTy4IZQOHTIJ1fx9emIE8GLupi7nOHmYtw8xwrFFwzIq/nMCyg6XhDy
	UF9uph7uR/jF1JpXoAyuLpQoiAMyLWM3n4I+ys15rX21cH67S6CWTBmB2+kMqmmIzcAsyp2e2OE
	yDBCi63xAUs7iKj03NfZTUvSW1xmJDo8odLcO5gyrXiAs1vEYKGIqF7smA3NlrujoMx24KLbJId
	RXEUXXm2UgiZ6CJpRBn2/4pHbxOBI9Ne6uepftXle7oEhzUvYojMhKK+XCt308/4y3DVX8GgnVf
	svQz5UgsE4WZ2kZJf7Gc=
X-Google-Smtp-Source: AGHT+IG38LvfDakzuTJVOME0jGxg3+vxrdh/v5VuUL+cdMnnd+T5i2L37DGrSgoMkiIi0dPMSxYqfQ==
X-Received: by 2002:a05:6512:3092:b0:549:8537:f337 with SMTP id 2adb3069b0e04-54acfaaca18mr1487912e87.14.1742480900108;
        Thu, 20 Mar 2025 07:28:20 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7bfed0sm2242342e87.69.2025.03.20.07.28.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 07:28:19 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54957f0c657so939853e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:28:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIPeTiFoFQSEYEVcoEmTtTRhzUrAnUmEzFiczf7ZyM8DoXbW7l2y2bIU4PEUJIN0ximA8VMJdSvsT+jGE=@vger.kernel.org
X-Received: by 2002:a05:6512:238d:b0:549:94fb:ecfb with SMTP id
 2adb3069b0e04-54acfaa1b01mr1619820e87.15.1742480898219; Thu, 20 Mar 2025
 07:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319163341.2123-2-thorsten.blum@linux.dev>
In-Reply-To: <20250319163341.2123-2-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Mar 2025 07:28:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKiPk=G_ZauCwjDqNQuANpoy_jt=nwU1LKj9Ruq2yAaw@mail.gmail.com>
X-Gm-Features: AQ5f1JpMNxEN2a0_e9j_OWlkN8Z_5_oZ0bAFAj4yNCnYZV9svYCZXueqb4XkgEw
Message-ID: <CAD=FV=VKiPk=G_ZauCwjDqNQuANpoy_jt=nwU1LKj9Ruq2yAaw@mail.gmail.com>
Subject: Re: [PATCH] kdb: Remove optional size arguments from strscpy() calls
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <daniel.thompson@linaro.org>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 19, 2025 at 9:35=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> If the destination buffer has a fixed length, strscpy() automatically
> determines the size of the destination buffer using sizeof() if the
> argument is omitted. This makes the explicit sizeof() unnecessary.
>
> Furthermore, CMD_BUFLEN is equal to sizeof(kdb_prompt_str) and can also
> be removed. Remove them to shorten and simplify the code.
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


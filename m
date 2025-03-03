Return-Path: <linux-kernel+bounces-542672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B5A4CC45
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3094717492E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653E23535D;
	Mon,  3 Mar 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Een/v3HG"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2D233132
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031603; cv=none; b=p9J15lpZN0f8wdjx5SpVjeqPcl2bLYAnHlCQN6cQ6vtcgUgxbYoahxWuPsXaK72k0mSEa/Nt2Ohuh9/HDBfkG2pPRKRim4O0MiN3H56KZ6lIo10Hznqpj9jQugGpe+dCm3g0PYrjotUj4WSu1mdVfVzmG9LS5B1ALMOhuHTPZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031603; c=relaxed/simple;
	bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkAad2LLNK4KcRP5E3w6Ys72EPgiYP+mmVcDwM+rugLULeYyCuu22iwPJpPW+ZxbGvQP0/w7C0JIRyfC3sVtT1MKHq+/hy77ywtNqGwYcfZiiJ5JWPf/nglfII4+3GEHGrZAHlT9XI6Eg9e9G73CvXnEQJYNd+mD57jr7lcjln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Een/v3HG; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so51533811fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741031598; x=1741636398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
        b=Een/v3HGrIUsxKLvpK/7nPtnYTaacphMIjptWX0/VuJMJD3H070xA1XR6kTs0Mo0Qd
         +NOCoa/Jo/5AUSoG0ChZRnnea9heys6gnguP8YjQSxml+Ytto9mkOmHzgxt8tqb8DhG/
         7PdcgP5XH/C3n1+2dUCQXK/6Qtt3VvGfVnEwPsornhgflN7+XsagEBSyDbK9GSVqwKBd
         ND2VFZW12cCMLJJEbLtbjYb6VZQwXVL+riMPhLNhS5Vw6moP6tA4UagIaUTgb8S/G21z
         c4Q1bGIuFkKzstiXIIcrMMPupvCJy7BXLh8FWHajQnfvUTIxSTQBZ+2YUzsB0kyfS0wt
         GH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031598; x=1741636398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFTGZif/JgVgVDzzGQgZIl8WC/WC0ykZHCXDdOp8REw=;
        b=K3bMcQpAeEiJttyKw0vmlOtPA6TzwfGGGw08q2VZCjJO3KwwI/lrGAJMB2lBpfDk2t
         FTW70GOZsflHwyhyg6WkSdBXlfqauaResaHkjXTPgDgzroFVc8vwHl8lorxvYFtN6CL1
         0QB7oewvWIFen+J4Dat1XkIgWfl4rxfS2asgt5F3yCTHAWp3GDHXa9eBNWgLEbUyzSct
         BedoMHP663m8yIOIHp7xhLTHvvwJjPH/5QX2sI/jU7CMePQhy6MrmWTHdXGsCxaFlKJn
         mOSQF2V29bMj1ITei/Rh1+25Jcm2xUjU7LLDPdNTZlm3XGungLdoF/0pB/fBVQO9kUVY
         nU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV67m+rWZsi9mFR+g2SWacjZDn9Isi5cyFiw1rjWCB8nuvMn4eda1QcXMYE52TVRqdyOX3cF6wEsVIKaok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+Ikl0pbMK5xZnD1HbLzXrKZdqh+95LcDHkW7nshtA8pHUIN1
	VIWH5so/4pazNwgBcyhseNbRTJuL6GeWXTi0D26Dz2llTA9wFEY8hjeBYH6IvR08yeL7XkTsAKe
	zthBeA7ua6eEoFhKrkw6MD2f/yhSUvMpWYSQBLA==
X-Gm-Gg: ASbGncvPqqfjfs+GIVXMPv2pUQsS2ucRPmqWrM+OGE5m3D/Mrugco6DE6TuG9heaxTU
	/olCivCDBBH5vKUQLHuu+L6zTB75pQhW658KywtJKcAucusG9MznaYVoL20Giva9Vv5UZcsAie6
	PwrAV3nPLCdrXEygHuf0LcVCMmvQ==
X-Google-Smtp-Source: AGHT+IGAA1jTPTvt6x1HBPDHZpPdg7RIJLS5NDUt79SNfZEN5S213uxZfLpsDGTLhFe/KqTn7rcm59WJNzLGOylvX74=
X-Received: by 2002:a05:651c:1a0a:b0:30b:badf:75f0 with SMTP id
 38308e7fff4ca-30bbadf7dc2mr20317411fa.2.1741031598367; Mon, 03 Mar 2025
 11:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com> <20250303164928.1466246-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303164928.1466246-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Mar 2025 20:53:07 +0100
X-Gm-Features: AQ5f1JrLhAM1wiHutYCTK7Ia19KZ1ZhoXNrkXyL4siFeXMeh8rxos64YMy1PhkM
Message-ID: <CACRpkdbeTG_55VbH3GBVpB31D9uuLHTZpuzjA3PuxwTB+KEq8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] ieee802154: ca8210: Get platform data via dev_get_platdata()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Access to platform data via dev_get_platdata() getter to make code cleane=
r.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


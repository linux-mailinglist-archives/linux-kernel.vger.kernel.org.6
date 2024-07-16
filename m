Return-Path: <linux-kernel+bounces-254313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3702D9331AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8631F282A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212001A08AB;
	Tue, 16 Jul 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DjC3DG1s"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671A19E83D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156545; cv=none; b=M7zHYX8Okt2ordViLfhJP/HC7r2iqj0YIuv6HYoONmvF6ZUnCM/1/zE6Z5Y4vq8SmcqeelTIT3ofQiv9X24uX/y6qfOSf4ZAXJfSWDwA0Sv5bMUCcUSUFhgNxVjrPI/NfAoNhzQk4lvpql5Mz1KVp6pbouDvp7rEmMZtBltoGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156545; c=relaxed/simple;
	bh=IcvoyPAiBWsnUIXDnUolardaawkNmtHP8hBYcpNxiyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGId/eMpzNzIypvuGfYSGXHNQZiJ8a8mvwZcNePkY0LfYT3Wmvy2OEgWn+3lp6rUC+eIJ5bKU1OT290AdokQzrqpBZ4YlcXyYsvCUafKAhxI8O9jWlAWy0ETuhnrwsAyIK95BTthqV5ZFAzT85FIrUvfiCdHNLb1EsSKdiFSgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DjC3DG1s; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-59fa3ba8395so486674a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721156541; x=1721761341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlb1twGtDgpkIuFqjFEwx2dSO55N1dWs34CngBK1sSM=;
        b=DjC3DG1syj+8WSO1pxFbqFTP+TOp+lIH0IWW+wDZL5r8mvx0s3kLYLacdRyQfVHrfM
         fSpfvbcJDRlqjRFXakdba/0DLKI/m9W3MLpsvOsRZa15cEUl26zZ2zbGNvwhUzyKvIQy
         GcX4Dz7UdalhsxLEfukx90CkMyF6zeqXqbMAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156541; x=1721761341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jlb1twGtDgpkIuFqjFEwx2dSO55N1dWs34CngBK1sSM=;
        b=jrQWHofHdX9GMCdbet8upTp43g3s7GgZlU6QCno8mx3r1R/PIIlDHsMu2i915jPEED
         JySfwkr36RO9QJxIYjUFlca3QVCaGep9U+blV5k5VLy6Ux1biWPXoAId35maz0LeFOz7
         TM/jlwOGHkLmHtBaKo8rlKUsOUWmlNnjggLAw0Ewwawl123pjCW4jXBjanYm7+x70BOP
         YHvOSuywkUa6EY23dV1sAOU/GyPGu4X4EdeNQ45bwRu1UVis2eoHjcyoWzfNPu3eE/4Y
         bUsi+hdMkgI15mUSxlsvjS6Eqo3HaT1Vat2BnsDIIGrT/gwWzHBbaViOtHci3rftxHee
         rNpw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Iy2xRXnfIOkPWy400QZbmW0QNltQDR0PmZaWNmniFBkiU22RDk71xZ8nq9Lol4nh+cKlYSFtd+3xcOJeaB1wezQcfqE2MGVwI86m
X-Gm-Message-State: AOJu0YyXW8BS9ObOi96F6cbmiL9RsBBlWxvaZ+G3h/ZwzgkFpsQmsnco
	49D4qP7Z3rLsaq4d1pmczXJcY9udsMcAsWyoEVbb+gPV7mz7bQAycEIlEFH8ZvUHtZXCQo3qPY9
	2Sf+EAQ==
X-Google-Smtp-Source: AGHT+IE7kzxzpB5rBaYWsqIhCkoMvWfgBdLUuqksglKjsY/aXxhe2lbsZxG8ysB6Wjf0HMQJP9GROQ==
X-Received: by 2002:a50:aadb:0:b0:58a:fa6e:9dae with SMTP id 4fb4d7f45d1cf-59eee53f70cmr2081778a12.15.1721156541269;
        Tue, 16 Jul 2024 12:02:21 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62b8bsm5363904a12.95.2024.07.16.12.02.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 12:02:20 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367a3d1a378so5221846f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:02:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2JeAWInumwvkzxqurEAXd61yXXVksa/A/t8uUPEnpHPXF4JWzZ6B6pT4us+chK15NUYq+Chn0OH7Ix0z6uurKE2VVrcLTi7xLmiXB
X-Received: by 2002:a05:6000:1848:b0:367:434f:cab8 with SMTP id
 ffacd0b85a97d-368261eda5cmr3359220f8f.43.1721156540333; Tue, 16 Jul 2024
 12:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
 <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
In-Reply-To: <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 12:02:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com>
Message-ID: <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 11:48, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> But this patch does it. PCI_PWRCTL_PWRSEQ becomes a hidden symbol and
> the entire submenu for PCI_PWRCTL disappears. There's no question in
> Kconfig anymore.

Yes, but look here:

        default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)

That has at least two issues:

 - what if ATH11K_PCI or ATH12K is built-in and needs this driver?
"default m" is *NOT* valid.

 - what happens when you add new drivers? You keep making this line
longer and more complicated?

See why I say "use select" instead? It means that the drivers that
need it can select it, and you avoid complicated "list X drivers"
things, but you can also get the *right* selection criteria, so that a
built-in driver will select a built-in PCI_PWRCTL_PWRSEQ option.

           Linus


Return-Path: <linux-kernel+bounces-202021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD08FC6AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB861F24999
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F84962C;
	Wed,  5 Jun 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oBn6eZg8"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B21946DC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576703; cv=none; b=kSJu54uNSSVvXzhyCWYBUfv1OMsKqVwYXEJZzXG5MGls09aLBaHxONWnC+WUjS9ekbvLz4UjcpA+NVhGkga9nH7KIIq9ZXQa5chfEZ1nwsrtg0oPyAYTV5gp1zqRSgFPY+uxQQEPCScQCEiyT524Ud/JINV9kZ64wnvMUiSJ4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576703; c=relaxed/simple;
	bh=uB6WNlNFMa25Q/piLdGW+h2FWN9ed9vG8wJIaY0J6ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvVoDHURMLyOIaWMZpeCEqsRRagHUJT+Mgz6RVxPPCcYDTN8rqdPaWaQ43oC0MqqVtwXlTzXRDVkOO+xW2LKTs1WmbTUFIZGZ2qj09O176mbp9haHMVMzWpW6d2mWxjvARH3sXADQHJB2eYQ+2Lr4v6Dr5Zj09BqFxPxjV6k+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oBn6eZg8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ea8fff1486so6331531fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717576699; x=1718181499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUWSW08nntJrf8CGVr9DXOkBBBauaj8YBTu+CpBRFmI=;
        b=oBn6eZg8h+bXTZ9U5iVDK1CssKZMfHRQI9hvl6uI7NPD1eG2WiwVZG2P/kWweG0KL6
         C8tjzdDO+9e14naPs7LAUqRgzk4MaijtHqNd7QaTfnqC/DJCfbZGBpeZ+U7FgIQybLIx
         VztlpS+XQnQtMX9FYn61CXh8UiWEHUXEyHU4GucVrguBvhHvoRGIwWWT0zbKlDrHaOz1
         B+6bOYHsAPegSnexiZ4qfuj9A3PVUZsWfMcxY5NG7Pv6pRM2k9Hu90evL4dXSMKxSWaD
         vsgtgQwGQWQytX86D9IETdw4tVduFGLsVmPp7pguXbMy//R0UcMspDCzkEUowqESPUY2
         iU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576699; x=1718181499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUWSW08nntJrf8CGVr9DXOkBBBauaj8YBTu+CpBRFmI=;
        b=nA78CR08P4LEijCjwKjmu3lswtuA4hDTCVZy2OYBJj8MPX3PO3GDAGVe4775YKiURK
         WM/GnHKBtte9/URHMblSDB0TKFQFVYm4Y4mWqOwrRh5eV/kYmy9F6Vzj2f4WDjZ9IzIe
         5V/5Fcm1ydj6LOCjYr0NIwFrQemyEG37JQGosjtLRaudB42oZDal2rfF2qHOCM1g9qtg
         hAOl1cVdSwpWX/+a1my/wTQJaDkkWSy9nyrGrFgDBIDOaducJhQC2K0XkI1HMGmStvpl
         /dJTOFlO39yiO1JfBRUkwDLUrJoYV8GgzIWPPKjCzNNh8NUlHGp+KeeV/DDladcefcrS
         xung==
X-Forwarded-Encrypted: i=1; AJvYcCXk4yKYlnhjU6B0sJYYnfK2qPIrcPKHAwoGCipzSddDemgS1wQQaShcivUnptckv9qZM40mFgpiex5y6MXUJBcdC5aIYLhnEvdizFxI
X-Gm-Message-State: AOJu0YwwfmhT38V0CzfypxyTnu+BBhe2QtAEe+QWYmb8NDyNx+CkAw3s
	9Pt6Pd5OHWpRRFKyljDYQ8pwhgloyisZ+VlCClXCkr/HuA00/h1lpRBCqHu8PjL/723nLUklo4Y
	takUrmZCMxQQCAsGgDr4vaXf4pEmcl/PzUAyknw==
X-Google-Smtp-Source: AGHT+IGa47xxFBOoSvrEt/XV5uGA0JUIqf0664xs+6A6Aka2gt3WvS4ie0V9Y07HNcqrVkyEu+v0Wuo/YC7l78WaDXA=
X-Received: by 2002:a05:651c:546:b0:2ea:7f46:174f with SMTP id
 38308e7fff4ca-2eac6470b9dmr7173571fa.20.1717576699220; Wed, 05 Jun 2024
 01:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-4-paulmck@kernel.org> <CACRpkdaYQWGsjtDPzbJS4C9Y9z8JGv=3ihQrVKvegJf8ujqSmA@mail.gmail.com>
 <2fbe86b7-70f0-46cd-b7b7-9d67e78d72f3@paulmck-laptop>
In-Reply-To: <2fbe86b7-70f0-46cd-b7b7-9d67e78d72f3@paulmck-laptop>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Jun 2024 10:38:07 +0200
Message-ID: <CACRpkdYMiaMFmUoXyHdR9kLyAZma-24-m7cofztxd=n_Fr+GYQ@mail.gmail.com>
Subject: Re: [PATCH v3 cmpxchg 4/4] ARM: Emulate one-byte cmpxchg
To: paulmck@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, torvalds@linux-foundation.org, arnd@arndb.de, 
	Mark Brown <broonie@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Andrew Davis <afd@ti.com>, Eric DeVolder <eric.devolder@oracle.com>, Rob Herring <robh@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 11:14=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:

> Thank you for looking this over!  Does the following patch (to be merged
> into the original) capture it properly?

Yup, also fix the commit message to be =3D=3D CPU_V6,
with that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-190697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E28D017B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD80128B730
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC5115ECFA;
	Mon, 27 May 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRj30NTu"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1B15ECE7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816585; cv=none; b=YoBttu6kN6WNMolnzzzURtN9b1qlOA/F9Cf1UW6jA1xEUsffOysaSPpwj67ShtYEdLTTOdWp6vUplEXETgkmpFOmso/8r20TR0Gfa9oOCRSg6jOBoXckU2Y/ACEVWs7VLZF0EeNR110SBMW1mzNo+wvnoWazShcNBFWMuhOBFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816585; c=relaxed/simple;
	bh=TUR5iHVq4C00Lj34rx4EkblDQMaAxdKYYoyqrIiTXic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUZR8w/P4Nz1jCyNGj5UKqfscgZwThgmlT5bTx+W2lngaPxHro5FCLHTdVvg5+LNacbVTvq6CgK7OVwZxgKUoBWkP03oiAClGAhlZM/xVXVAy1eF8lahWHqskdDk6e/lX3G4Nj7FCB4wULImegZ5es4wq0uxZPchouIh4Thjl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oRj30NTu; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df4df150f29so4690387276.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816582; x=1717421382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUR5iHVq4C00Lj34rx4EkblDQMaAxdKYYoyqrIiTXic=;
        b=oRj30NTuRIhyAUguPdzTypxa14qbw0XnB9CF/70d5W9XbVoho2TnaxQL4/TowGddRi
         ahcJ6M94Zkp8FJhUZ5dv/Ba0vr++0OozdITxhMj3ySkFzF6v98hObnYt/ZCmd6K8SUak
         z14SNILQawQOBb8JEuJXsjf/YrfBz7Dj1TdrimHpqgBGc9RoAkQjoJwzkJEAeUWBdo2g
         2eTf33cfhqn3Zun1HMtIY9e8xvGuc/3YfZX8M4/30kyKDPdhV+oPHRNh7/qKOxV4yByc
         oYAXuN+/rQMNXf/8zA1UZ3CtmsJ4qoRir8XVrzd13Qg4eOh4hCOdU6X+obllzTF0cHYb
         e8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816582; x=1717421382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUR5iHVq4C00Lj34rx4EkblDQMaAxdKYYoyqrIiTXic=;
        b=qTsqvA4P6XsdJdhAdlmT9fMwYcizutLZw3C4PWDnSk+HUt00r+jJuw0qa0HTJMasPh
         fI3kcFXNtRkmXNKTUWUTOYWXUZiwB0+BYE4vcfQUYU69enn59x9KBQR9jOqLEMRnaaWo
         v3tCCkfgc7IJ5uJkNamYidmEFzeCTdctjChrtxQJSxSA2uIwgyC1G3XbRpP2Dz/kZ0S9
         HCy5OY+dViv6shVPLiXWffV3oykSqcMNsvj3kzGp/pEb2x3ScSqy6hp/F6bKy0UWY1y4
         2sJORaHg8fLMwQj+AmTk0hIdz6X8rFOkF7H60gg2f6q1KGncmnNRGNRFZThppTXeS7Lg
         Rrlg==
X-Gm-Message-State: AOJu0Yw2tFjTPAZyequD+Gz0WFsMpb/0yibRcM3tr4MLCdCGE4vFOkJ4
	8d2eL7GBxEdSMXKxi+U1p3Sd/x11jd+QOmjXOHZVglO1qK141lc84woJOO8MwtQHYSxTTtEPVIV
	nXrEl/n3OWemMtFvim1F48BHRimm6UNW+MbYlyhbv4FmUvAO1VpMgBwSL
X-Google-Smtp-Source: AGHT+IGfy33vxPqCmN3aVRaDgOxMIHPeWUDbL8ofaHIPLfZbamOI4nHFjBVfIUQ1vBeRF1Vyl1VmP+WFCGBouWIEmC4=
X-Received: by 2002:a25:8392:0:b0:df4:9a10:4e12 with SMTP id
 3f1490d57ef6-df77223e466mr8728329276.57.1716816582527; Mon, 27 May 2024
 06:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-9-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:29:31 +0200
Message-ID: <CACRpkdbsm7cfh4iHpDCX6WgHazoz9NEZyY-A_oD1TkzjWtNC_g@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] misc: eeprom_93xx46: Replace explicit castings
 with proper specifiers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is no need to have an explicit casting when we can simply use
> the correct printf() specifier.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


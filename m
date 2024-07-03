Return-Path: <linux-kernel+bounces-239024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DDD925501
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836AFB23C19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1413957B;
	Wed,  3 Jul 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaMrDwAb"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AED137904
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993607; cv=none; b=V4qOFxeKSVlqi4/qpYfvBcoxxFPy7ByIYyYpp+xPW9PJxcJj8BUT0DUWXZe8nCk1oTwmqop5OmapmJ0xfHLJztg58fyobVdQjE6j6NmN3TlxYP88jBFJdV2HVPlyax5TeOMYIMGqYJz7C5RnB5lqUfVSBvX/sA306mTpOzJQazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993607; c=relaxed/simple;
	bh=CkLTNry7yU/uuwFkqFDOD2cX0PPHh08s4HKDUGyRcCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhjjAzO+S2zKO3mLtclsiK5YgOlH2a7B30AsLewKPoGEoxgzf/nkiRtIKQK6ZTqjrSSHANe4Z7VUvcTI+K+GYkpu6hxEYSJuFg+EVNpSIVZl4yXfNtT/eWCPHDK6r0jSM8s1dCdGBuQ2DunsDq+Zl7pGhDr/yTqX32MKCV2l/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eaMrDwAb; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9944764fso253038e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719993604; x=1720598404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkLTNry7yU/uuwFkqFDOD2cX0PPHh08s4HKDUGyRcCQ=;
        b=eaMrDwAbmo2AAWKUJxgz00KYJCs6OoOx/CZ/3I5iLTE/ObtPcZVmpXkq8vTGTYYaW9
         3n9hpf3EekKWzYbD02HfwoCeHjJVM/myh5Kzlt6Ftke2ZwrYbF0wp03gzTx+FHiKjNLW
         nksd3Qws9sD7hhXo0PHFrjq6rTOjZXf9L4Qso2LBPysfbW1YwLtFqkKwqpNKZvKIp3v3
         ULVNkqmahiUhi607+bM59YZQuGGWWsoaebTISgisysZETk3ggMhYy3txnjWy6ewD03Ha
         uFhHFySu4maRbM7LLsUkn2ccEHbTyd6Pgp913anqZVDE50fazKJP6A+Jpn9NMgrp9pC3
         yXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993604; x=1720598404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkLTNry7yU/uuwFkqFDOD2cX0PPHh08s4HKDUGyRcCQ=;
        b=OLyuGYN9q/zttyxj2mFsMTE6ddel4NVA7Gw7+cobVWpPZUepKLWtFCKpJ01uTOWuDC
         jeZTZMSoPQBM6yDT3NiiynnJ3IlvLFrnGCcuqUhKzoZNGZ+D6icTFcb/QKInUGfFJdBl
         7gmWMnHeddyR4WjjA+CeRlSxPOnT+JYZRxtxU2u604O9pddVIZpmP6pyURJIREX+WOT5
         K4R6UkQ3YA/YjEEXXCiSOU5mJbYJiOJkUS/DrJrnKFZtbrWcGJysoamy77OHuixqbi7A
         Utq8FjSZ7h+ZnZ0hImiOroUX0ViGmJ8fMcyoyqwpHDJd62KL8J5Vat///NXIP9RPXTEI
         rMEw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4NINNySBNGrUhl3d5DWcjk0A8//n+6PCudWgEjfPBIoMgxsAp3Edvs13c/TosBt1KT5AYEmfq/3kffT88RediGejx+AbV/30U2Zy
X-Gm-Message-State: AOJu0YwP+/YQhDlcczujEIKeOT2aCzewKeUAorRnHlrlhH/2YIdodygy
	XvcPGGC5BqeLjfXmbWt54EumDtgpx5vsIvZep+g0ozRCmXgC6xrTHTjOaK2KUyl6P+C3fUbFjZu
	cnQ2IDrvXnfGu1QyjrqrXV4AlLnIqRP60y5Mh3g==
X-Google-Smtp-Source: AGHT+IHr2vBqgrcFtBtrFIjitcAzlZk/XsN2VnaBSkBodd21GrpqWwe2mqMxd3GXsu2MabphGy7pE6MPdBpPzBixzec=
X-Received: by 2002:a05:6512:3056:b0:52c:dea8:7ca0 with SMTP id
 2adb3069b0e04-52e8270faf7mr6755061e87.55.1719993602685; Wed, 03 Jul 2024
 01:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
 <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
 <c19eb8d0-f89b-4909-bf14-dfffcdc7c1a6@lunn.ch> <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>
In-Reply-To: <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 09:59:50 +0200
Message-ID: <CACRpkdbNevzCd-5n5ccgJ5HZpg0JEMd47a0PNiWPBr6r1mok6g@mail.gmail.com>
Subject: Re: net: dsa: Realtek switch drivers
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Andrew Lunn <andrew@lunn.ch>, Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Florian Fainelli <f.fainelli@gmail.com>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	"ericwouds@gmail.com" <ericwouds@gmail.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"justinstitt@google.com" <justinstitt@google.com>, 
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"sander@svanheule.net" <sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:39=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> I've just found is that in theory the RTL930x
> supports a CPU disabled mode where you do connect it to an external CPU
> and the data travels over SGMII like you'd get with a traditional DSA
> design.

The Vitesse VSC73xx has this as well, it has an internal Intel 8051 (!)
CPU so the switch can be used stand-alone with a smallish PROM for
a random switchbox, or it can be used over SPI or memory-mapped from
another CPU as a DSA switch.

Yours,
Linus Walleij


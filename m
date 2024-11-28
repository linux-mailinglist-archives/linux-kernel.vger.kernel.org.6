Return-Path: <linux-kernel+bounces-424514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CAD9DB532
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEB51634DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9CE18C939;
	Thu, 28 Nov 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcXYQsDO"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A315854F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788071; cv=none; b=QE7jwlP3o++lTGUQ5ysIskd4Zdkgs/AOZQWvugYqqG4dfcZGs2uzOG1oNmoYDQmWpxVQmqtOtP5yRSOgpMd5B61PZ+sIislbksQenOjywJgzE+qHUSBNYVLLacbt5uX5z4NCrHdQl8F07fUsMR3y9vDlMa8hjk0360m+i4Q+kJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788071; c=relaxed/simple;
	bh=sr3m4q8NQ+yWL/GM/aZn5V9dc0T5vWuPfLus3LYfktY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgyPrMsOesoQkIgRTgx/StkorCLzNu+iQihCKRz1/Ui1HwaAUY1aVza3Rld9/qg4WO4wp49VAzuFD1RpZcmIWaVvy7ujCipZZfcl7fOmxTD8naky16YChaPEgghXurAZ6JG4RqSbf3xCWHodDZAZ/ll3wgI67z4PCGBIlEPOKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XcXYQsDO; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e786167712so341086b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732788068; x=1733392868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JSLLTaqyAduW2ArQyIX+tknhwh7psIKkLCezIRIcTH8=;
        b=XcXYQsDOVnb5OSSZRZLXmh31hn3L6YyBR2PD/2RPec60zcwpDj7AsJFMikOmPsI4GI
         LAnZoIZODfViqK4ZaoRj4fSCyzSYvvGoEGme98f75LL3WYAB9bO1TWIJE/yjKiLJxnJy
         4DhXdV6LqwUJbHC6NW+QvTfP1/DXZBbBnfdxczJHYvaVDxGKh4EJjfSoyKsn3PmNI4Gp
         gKYnoLC6MESdtHXfGcVqAd9Ct3yH8g6PDS7gAPcgpVGMw81SJu+QkF28kJ9+Hy0va7/q
         c/anAN8ucdsXaO965M/Ulf9BxYqhqo6XI50wE/JUFxDeO3AW6isHdtWmWjtHB0F7aneS
         BLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788068; x=1733392868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSLLTaqyAduW2ArQyIX+tknhwh7psIKkLCezIRIcTH8=;
        b=LmXyZaBoLn/tqo9qlcCZTWK7bAlJU/4bCtfeuIzyP4136RYE1piFtFj8qkilYkb+WT
         lBIK11xfLHLYTIhWn/yPa9/voDcL6SGHfUT5rxrXfrkVCk/sj0wYPpDt7f+5/tFfDNbr
         cX6wrGXbAWcBUGmQTu+WJ/t8hF1p+o3GLMp+Vofm+dAd1ckNPoUGnCy5lpKShZ4cu17n
         YeKH3h8wbA+sBmD5E7T/qnCOdk0G//qOGMSIlVrNaAWSjjEWPO3tPogmMS8GqLyKU/CM
         RxcrZ6jpf44YcrGd6fd/+oGWy+Cn6KeXGVqeh2Og4lN72xVQvz3rEwTPN5GHGpsNHB+g
         9M2A==
X-Gm-Message-State: AOJu0Yzp2lZ7Ur/TGF5yRJpXFv4djLW1VIAHgVsMmnZ005xCs5CtcYId
	8iSgdM4BA1wFR0KNeTzoSvp9TlSoUKDpKYki+0Xzp9F6WDuE2Y/TcEAQxI/dxa1F1AI7fjBxb2z
	RabDKo78LoDhDtQsqetA9Eczg0n5S+DZFcHpLNw==
X-Gm-Gg: ASbGncvs60OPVNdxnHDreD9i342BQGZ51k/GbQBBlw0A4+HUc3KleX56cOOAChw5MpV
	62dSMEnQQbY8Jffyo4E712K9q18NpCuf8Yg==
X-Google-Smtp-Source: AGHT+IFQJ2vqlwir+TVj8VrxIEsFkK/0glqr+WYlo4RXfaelhJ1mOeWad0OAsfuEv05eXPQ6Wfy96mNVzfuVmE7f838=
X-Received: by 2002:a05:6808:d51:b0:3e5:cf3b:4fc5 with SMTP id
 5614622812f47-3ea6dbd5d8dmr6480398b6e.15.1732788068001; Thu, 28 Nov 2024
 02:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuaWJYQcxQ=3UqQbbuD_YNdOS_KB46N=mh47rxE049f-Q@mail.gmail.com>
 <20241125162354.GD2067874@thelio-3990X>
In-Reply-To: <20241125162354.GD2067874@thelio-3990X>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Nov 2024 15:30:56 +0530
Message-ID: <CA+G9fYuf6A+3gjNfifnd5cRL5oOU6HA2j-KXaaP90mskNVrV9Q@mail.gmail.com>
Subject: Re: korg-clang-19-lkftconfig-hardening: TI x15 board - PC is at
 edma_probe (drivers/dma/ti/edma.c
To: Nathan Chancellor <nathan@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	dmaengine@vger.kernel.org, lkft-triage@lists.linaro.org, 
	peter.ujfalusi@gmail.com, Vinod Koul <vkoul@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kees@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 21:53, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Naresh,
>
> + Kees and linux-hardening, since this is a hardening configuration.
>
> On Mon, Nov 25, 2024 at 07:34:22PM +0530, Naresh Kamboju wrote:
> > The arm TI x15 board boot has failed with the Linux next, mainline
> > and the Linux stable. Please find boot log and build links.
> >
> > The boot failed with clang tool chain and PASS with gcc-13.
> >
> > Device: TI x15 device
> > Boot pass: gcc-13
>
> Are the UBSAN options getting enabled with GCC as well? I am somewhat
> surprised that they are not agreeing here, unless this is a __counted_by
> related issue? Does this not happen with GCC 14 as well? It would be
> nice if we could get a copy of GCC 15 with __counted_by into TuxMake for
> validation of __counted_by between the two compilers easily. I did not
> see any obvious instances of __counted_by in edma_probe() but
> admittedly, I did not look too hard.
>
> > Boot failed: clang-19
> > Configs: korg-clang-19-lkftconfig-hardening
> > Boot pass: qemu-armv7 (Additional info)
> >
> > This is always reproducible.
> >
> > x15 beagleboard:
> >   boot:
> >     * clang-nightly-lkftconfig-hardening
> >     * korg-clang-19-lkftconfig-hardening
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Log details:
> > ------------
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 6.12.0 (tuxmake@tuxmake) (ClangBuiltLinux
> > clang version 19.1.4 (https://github.com/llvm/llvm-project.git
> > aadaa00de76ed0c4987b97450dd638f63a385bed), ClangBuiltLinux LLD 19.1.4
> > (https://github.com/llvm/llvm-project.git
> > aadaa00de76ed0c4987b97450dd638f63a385bed)) #1 SMP @1732428891
> > [    0.000000] CPU: ARMv7 Processor [412fc0f2] revision 2 (ARMv7), cr=30c5387d
> > <>
> > [    3.543395] pcieport 0000:00:00.0: PME: Signaling with IRQ 136
> > [    3.556976] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
>
> Can you turn off UBSAN_TRAP and see if that gives us any indication as
> to where exactly UBSAN_BOUNDS is triggering here? It is not entirely
> clear because we do not seem to have a line number in edma.c from
> decoding the stacktrace.

Anders made a new build with UBSAN_TRAP turn off and the boot pass
 CONFIG_UBSAN_TRAP=n
on arm TI x15 device.

Link Log:
--------
 - https://lkft.validation.linaro.org/scheduler/job/8008096#L1846
 - https://storage.tuxsuite.com/public/linaro/anders/builds/2pR6MSNK0MqztHMe45eAqWYlIaf/

- Naresh


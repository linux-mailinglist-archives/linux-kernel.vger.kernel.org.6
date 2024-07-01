Return-Path: <linux-kernel+bounces-236357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03191E104
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA951C21955
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9915EFAF;
	Mon,  1 Jul 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQ5fm6tk"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122715ECE0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841382; cv=none; b=gXakXlK9KBmU7vWUG8rjhLtcEBWPjFg27IHwQZ0rzKk4Uh1RZ6YA2Di2NzuwxNKLmrsQUmauk0R9XQTNLU9nO+iSC0tcGi/0xv9POaH1i+LBRnVSZlLjkpProjLanfItej5yeejPGvlSZDPYCU5Hy0y7KIpukt7IchSHGTGFefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841382; c=relaxed/simple;
	bh=6TJrdqdGOFUfNAc2K8v9vR/tcthQDljpvcHgKkBQdV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6FICP03Md4KspO0vWg5rtVrVVQBg44laSQyytjLQTSasjxBzGxnIiVo8Bs7TFPrC8EoRIw68VK+TIQwo3dupQRHUMZGVZ0EbYMLWJcWzJ/syhziPpo8ULsVufuKzdukYLAzrB7HGbORKSDymBt1OLrq1Xeg0lK2TtKITOL7R5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQ5fm6tk; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80fc48bb31cso1068684241.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719841380; x=1720446180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzDzN8qMadfykp4fLzSl/Fe/+BqVWg+52h9oZmO7PNo=;
        b=ZQ5fm6tk66Ve3NlZ1tqnqDiSiwFmhVXzXwJulx+zW1NBeP94jz8kwnlaVq6IguskLh
         Xiyz5C188tUFmqFN61lUALCI71aDoM18GpJuPQywTiSPHmEAUERrWjual1eVycpzv1rk
         lYVGycYTokXNXi/QyDhNBXfhTggaHJV90bPDOVT42WogYayglGH3D3OgU5wyWpRcdv0X
         moqTey+ScS2FadTtLqK3B32jJhPp6y4zNiZjTc8BS7ML0IyjZhUVBb7DW3WzoKJVEzNG
         k3P2xTZj0Vw2XchxHa63PktDK6A+kBxt9+rZ4mqf/gIN6oRVErP4AbCwP+5no9Z1MgEs
         RJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841380; x=1720446180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzDzN8qMadfykp4fLzSl/Fe/+BqVWg+52h9oZmO7PNo=;
        b=HDvYv0xNlSqCIhEb7WNw3IRxvf+yvmuRR/w8tIZRBT3KkSv94p7gquXwvFL9NHwwIO
         SZz8dNqyMFUsmp7nUwPHI3B965ssh9EqPdZ1xHPf4gu/T3DiMCIwVMDNLDrTmHbiDuMU
         2GsgxCq3yKuAzeDJtmk9vxZejAmY/f30OhQoh+6AS3/K14+JX4KRqR02golWPy6K68dQ
         C3jmiyeX0rpMS0tIuD1pigTQuBDGj9zgZnVdZ/id/UbMLCMZsO8bLNJMrrb8ThrGWoho
         OtIVT6serBgZ0UuYXWJ6repNhA+bKfrFjL+8Q2h+t6bqrN16iO4Iiw5DndCOusfPvWnL
         aSPA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7TAxa8Gk5bVh/8Cl8F+6j9iIMsDieO5K420lfXgYHCaU9et2OSX3uDVDvmP/AEZAJgzEWu9SyU9/cso/t9NaEsGwQiAj1RDIZijy
X-Gm-Message-State: AOJu0Yx4tmQ1GUAWjeVfPNNgdvaXn7ATqGKm+hA/rSBSbVyJn/GSjWJA
	/PeO/JASNf0gZXM1yxg1AsPI8Q8eh1YXtrN9K0b2Isds8+j9r3wgzzMMM3yRXdaH3k/vXk2Do2x
	QRVyTlmKW9UPfIBvsYu7R+gXdU8cbUSZHGYaijQ==
X-Google-Smtp-Source: AGHT+IEiXUSbYSAJMo84UhUarOx3CsnYlrPxZyKJQGlBzRnCF/WKnt/Ht7O8aq6MeKZvdwlxYEkKcMyqbYdByzcAwDk=
X-Received: by 2002:a05:6102:3109:b0:48f:8be8:970f with SMTP id
 ada2fe7eead31-48faf15a142mr5297794137.32.1719841380229; Mon, 01 Jul 2024
 06:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsXsbHp+0cWoTjEhkpANOav=GLSjPx5ghtUY-FjMPyoSQ@mail.gmail.com>
 <20240701124733.GB2095@willie-the-truck>
In-Reply-To: <20240701124733.GB2095@willie-the-truck>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 1 Jul 2024 19:12:48 +0530
Message-ID: <CA+G9fYu2GQXEWECWHi0LZZ_UsMSPGaJ1ORKTR8k_E_LuYteLAA@mail.gmail.com>
Subject: Re: Mainline: v6.10-rc6 boot failed across all arm64 devices
To: Will Deacon <will@kernel.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Will,

On Mon, 1 Jul 2024 at 18:17, Will Deacon <will@kernel.org> wrote:
>
> Hi Naresh,
>
> This report is quite hard to follow, so just some minor comments which
> you can hopefully take on board to improve things in future:
>
> On Mon, Jul 01, 2024 at 05:28:29PM +0530, Naresh Kamboju wrote:
> > The mainline kernel v6.10-rc6 boot failed across all arm64 devices and
> > qemu-arm64 and no crash log found (earlycon) did not help.
> >
> > But the defconfig builds boot PASS.
> >
> > The boot problem is with defconfig + Extra Kconfigs and builds links
> > provided in the bottom of this email.
>
> If I go to the bottom of the email, I see this:
>
> > Links:
> > -----
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2idWrbdtwMqpD9wx7IPRGJ7Dsx3/
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2idWrYDposdlRsS4jwF916a0qGE/
> >  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc6/testrun/24473346/suite/boot/test/gcc-13-lkftconfig-libgpiod/history/
> >  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.10-rc6/testrun/24473903/suite/boot/test/gcc-13-lkftconfig-rcutorture/history/
>
> but these are just random links without any context. The first two appear
> to be kernel build artifacts, but I can't tell:
>
>   - Are both "good" or "bad"?

Both are bad. which failed to boot from these build artifacts.
Which is the location of storage of Build artifacts and build logs,
Image, Vmlinux.

>   - What is the difference between them?
 one build is pointing to Rcu Torture test build,
  - CONFIG_RCU_TORTURE_TEST=m ++Kconfigs

other one is pointing to libgpiod build,
  - CONFIG_GPIOLIB=y ++Kconfigs

>
> If I look at the first of the last two links, click through to the
> "qemu-arm64" target and follow the "job_url" link, then I end up at:
>
>   https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2idWuAb51mcz7lO1BAj8Aw0BrNY
>
> which has some empty logs and something from "TuxRun" which says:
>
>   {"error": "File not found"}

Due to missing boot log this file is empty.

>
> It's very hard to know what to do with this :/


Sorry for the trouble.
I will add more detailed information next to each link in my next report.

>
> Will

- Naresh


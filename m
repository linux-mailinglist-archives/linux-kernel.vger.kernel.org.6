Return-Path: <linux-kernel+bounces-234836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02691CB4A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4527F1F2384A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D94381BB;
	Sat, 29 Jun 2024 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYFGtGlj"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEC2E651
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719639547; cv=none; b=GuxqHmJfppzlT0Jz6LimBVej/b63x+NEdZqFXt2B0GQOunSbuYx/dJd13DePAi5ZuQB0hAFbiGb1T52fI92kQOCpJLoDHHOOxQss6gl0+QShpD2BjmFe6fnElHqtBJZpV8o6WhKyAax8l+aI2rB/8LIDjFWwNFslTSJd7xO2fFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719639547; c=relaxed/simple;
	bh=dgc6xvAjvfE/v/Fu0Wa4FCknwaQQapO79iC7eQ2SGb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcA8/eYJjwz0z9GPy0r6YiQMqz99ycU3en9p26ILFUdkmsn0y2i9qXuwHP+2wKtTI+GVoGRwZ8hcKAKMXduqdj/kUkARVSqvOhAkKbPg1NdQ9qhwsrN0HCVqhKROS+1R/26e6fK+QwA2E5JGeZryTaDNifcYoKMNn3eVWWHHcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYFGtGlj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-362bc731810so1050755f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719639544; x=1720244344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUzwPwCHgHKPkQHNFBpZ1K9OnL0JTl3sanGYsV5qIZ0=;
        b=MYFGtGljDQu0CmCs/jw4j5o/ZnMZC6VGaVgZoPyuIkp0eXAGAI6aZxfK3Gbb6TP1s2
         KL5F+G+rGhCxnIsj8cnyKyWRbQWolcHcfBTxUBF79mfI2v2U1EYYk0yf6sW/U1WiDsjQ
         wvuceyb+8IYSd/XT97SQYel512WpFCk28vr6Q9RImQ70zqsdFB3CUZw3ZszV1utQFF1Y
         tuccsf3Jklp/2/IBjBh+U07KWJS+M+W5XaXS5wSSScWyI17uU1zgP1MKQfVcOC9KM7R3
         JxGzVuo3gUpizrsACQ9gs0y40SY/Z/LQGibwZYGrfi9GgNQibe/yPHFD3taSwFwlDTFG
         TQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719639544; x=1720244344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUzwPwCHgHKPkQHNFBpZ1K9OnL0JTl3sanGYsV5qIZ0=;
        b=c5p7DM4T9CHByrnwRZxP1iiXhMY/SH5jcNUv9LZZHdetwNQDltZrhudmMngLljk1rT
         EDXIeH9BATwKLQjhUDPZ7itibz77HqoIantMJ05y9H+GyRKyWsVoKTPbAkbZCOjwcY9j
         bVJ/UWfNbz1vYVmwyGgzek2eGfMfMcvFMcYbk/lGZLlokkQ3bHUoQSmJGwk6aZV1lIPf
         jx1ogPPJh76aIH+J4gd9tNH3pycPagfXwFab5Yx6IvxsHsWMx52scRHjzdCbovqNyFaL
         zH6roxeoLK844Z8kqT7vIpgwFLiuxg70hr4bF2YcwFGvt4HJ81dxFuK0ha1ST7cyE4yN
         t+vw==
X-Forwarded-Encrypted: i=1; AJvYcCXpuHTTAGPubfZy4aXBR+mjsMa7/OIdsZev4gnt4zdlxofDGzU+li2z795NF+TH/g9SLYREdmBkgYi7as8VCHDA1Wa2WxcSsQac+JzL
X-Gm-Message-State: AOJu0YwYWj783K0LDuWh1P9MwyNJs9L9eZR6XnsMIqTF/DEDFzL1ulY2
	UjkLjO63t6A9M5bCgPqDZJe9DX034s4uSi2gRbAKwmGoXE2bPy+e2NuirAl6UOLggECXHZn1hiQ
	EQbXhsnDY1j2SQLSI553enaERnM8=
X-Google-Smtp-Source: AGHT+IF3nOQLf+UeCFUaGMVyL5ySPznNzaEJeKMo/JUOOkp/ZF2sPP6ooOdTM7H1c1ySqDQizbAZ0cwLq+xVJEiNH9s=
X-Received: by 2002:a5d:47c6:0:b0:367:2d2f:e634 with SMTP id
 ffacd0b85a97d-367757249a4mr143732f8f.55.1719639543566; Fri, 28 Jun 2024
 22:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
 <86pls2isal.wl-maz@kernel.org> <20240627101207.0bbbead0@rorschach.local.home>
 <CAJNi4rMeDgDJbN0jjPguU_v5uoscJJN=5bZaShXpu7Q8X60hcg@mail.gmail.com> <Zn63DQhf9nMLooVw@shell.armlinux.org.uk>
In-Reply-To: <Zn63DQhf9nMLooVw@shell.armlinux.org.uk>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Sat, 29 Jun 2024 13:38:56 +0800
Message-ID: <CAJNi4rO5imFOrY-uXGGdEQ45whcOfRoyLtgYqW_s9mOVTpomCA@mail.gmail.com>
Subject: Re: Will smp_call_function_single(cpu, ...) broadcast IPI to all
 other cpus?
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, will@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 9:13=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jun 28, 2024 at 06:21:25PM +0800, richard clark wrote:
> > The output is:
> >
> >           insmod-1746    [000] dn.h1..   928.400039: ipi_raise:
> > target_mask=3D00000000,000000ffe (Function call interrupts)
> >           insmod-1746    [000] dn.h2..   928.400042: <stack trace>
> >  =3D> trace_event_raw_event_ipi_raise
> >  =3D> smp_cross_call
> >  =3D> arch_send_call_function_single_ipi
> >  =3D> send_call_function_single_ipi
>
> I'm not sure whether the above is misproperly pasted or not, but if it
> is correct, it shows a problem.
>
Ah, you're right. Indeed it's pasted improperly, pls ignore it peacefully :=
)
>
> We can see from the first line that the target mask covers CPUs 1..11.
> However, the call chain is for arch_send_call_function_single_ipi(),
> which does:
>
>         smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
>
> and cpumask_of(cpu) should only ever contain a single bit, and not
> multiple bits which the output above suggests it does!
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


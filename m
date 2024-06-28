Return-Path: <linux-kernel+bounces-233751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42CE91BC88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681341F23B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626415252E;
	Fri, 28 Jun 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN+zxccN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A821103
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570096; cv=none; b=DJuFGGAJbcarapaHFJ6LAm4SPojzu0Z+AcOK/LtZjLgP5UckpwIcGOkEPQUXzcD4STZSNw/8IdU3hTwpJCxCu5bHDCNY9RMUDOUt8aGzfIA1urCTpawjijHN04WQcdGWXF3isUPvLRCEzQqB/Ea/kP2tSB9/aY2kZ7mz4DSONb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570096; c=relaxed/simple;
	bh=4noTiBTuRJIBasprkGtDXC3pzOiAKK7p5eZyUiUQ79o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGYdpIeQ2VnStlPh+v5fSmr8chKTE/NlZXJWbJDYS3aPmuXDhgeY7bAlXpVdAGCnU7qWYjuizbgU+vCuGDTf0E9teOUEaibh5TMLs6RvHbHqhP8kbYOBWH81XWsdKYPj+x9JgyezxWR3QL9erBjWGEalBralVJ6sRtm0LaX0TjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN+zxccN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52d259dbe3cso456356e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719570093; x=1720174893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toVPkOVmbaOowz/vXyMujJeijcs/XV50D4pxSeTHmo0=;
        b=WN+zxccNbGVvLPmB4ddTYnNEhXmdiEuMj2MFPxJ9WlnT7t2e441PowPVZyfwl6fDiS
         zvN9Za445suVnivRZ35YMD8ukSKvbfAp7944+CxBepFrk6VdGYnwYAgNKW4jk1o1PY/g
         zNUUTgdS3g+7ajKbpKtJ/hnvhqYYd6F0O80e9zlSCIry55RgZT+02yp5yVQn1YgtEkfi
         Ga6sCwuHONRLKazwk+CyTTGjGhjA1zHFsyK9gr4wFIM0f3wEEK6zoc7+07Saxhhnu0fC
         NFdWg+ql+6plS2RmJItpBUYef5KFbytSxz6iy1oEv050ePaYWgzxE2RaJc3Nj9BFIoAc
         6qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719570093; x=1720174893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toVPkOVmbaOowz/vXyMujJeijcs/XV50D4pxSeTHmo0=;
        b=vqYtcGH8CA+YPHrvlzFDiHflrdlKjg3LJuHQJgYB9lmyjlEkwiXUdQi3lqwZ8OuFS1
         Dcp80kgdBmbsrfQgqXd9yjrfed6S+zeDbYFunwdfypnjRPUfmy1uaycdtZDThbHRcg6K
         PF426bYGnWhXUKiDI+36J0Va5gBcB99ckyBhYOzWzulVcJPoRnTOUIHKKk0nyrUIGVBM
         5i30HMWScBwyXBiFg7yHTKWMIvYN1mJ0hJYq4ow1hcGSbh4i2wYIBSiDVptJhCXcriRM
         kwIN0UxRCmnXVaSl5j8bFASi/S9rgCUwxWL+XFk2EEIBLWtLRr3T3BwYkklDzXDoa3Zh
         90nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKzOafPVEMd6a5Pkvhpgbv83mK5hM+E2ba+DGKo/pWIMUsLqbfSiRyeXcUrAziJjhyJHE8vMqDkzqU60nZZ1/O75yw87yBOS8/INru
X-Gm-Message-State: AOJu0YxXQZ6A2T2uMAv+2o6V+UZVPaiBGbFmOWsZFOuSgmXscl2n1bTC
	f7adOQvypD2kNjDbTdAdOemWrldhsKv6Liz0swhzN+rn4ldPxT9D/xY7EmZG7zdp7fwxM54Q8H+
	hMra9aYJJi/W+K+s5ws9flEDslYA=
X-Google-Smtp-Source: AGHT+IHEOHLUfclUMbaNJLdqI2SYM1TMiamxu0Nbh3QlfW5c1kRXgDYdE9DKeYAN6zJO+r1OHy6e1m79KNaqcWAt5K0=
X-Received: by 2002:a05:6512:2311:b0:52e:74d5:89ae with SMTP id
 2adb3069b0e04-52e74d58afamr2949893e87.39.1719570092485; Fri, 28 Jun 2024
 03:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
 <86pls2isal.wl-maz@kernel.org> <20240627101207.0bbbead0@rorschach.local.home>
In-Reply-To: <20240627101207.0bbbead0@rorschach.local.home>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Fri, 28 Jun 2024 18:21:25 +0800
Message-ID: <CAJNi4rMeDgDJbN0jjPguU_v5uoscJJN=5bZaShXpu7Q8X60hcg@mail.gmail.com>
Subject: Re: Will smp_call_function_single(cpu, ...) broadcast IPI to all
 other cpus?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, will@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, Jun 27, 2024 at 10:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 27 Jun 2024 11:38:58 +0100
> Marc Zyngier <maz@kernel.org> wrote:
>
> > You may want to enable stack trace recording and find out for yourself
> > where these ipi_raise() calls are coming from.
>
> Try trace-cmd:
>
>   # trace-cmd start -e ipi_raise -R 'stacktrace if reason=3D=3D"Function =
call interrupts"'
>   # taskset -c 0 insmod /kmods/ipi_test.ko
>   # trace-cmd stop
>   # trace-cmd show
>
I found that the 'stacktrace' seems like a stick bit. Run the above
'# trace-cmd start -e ipi_raise -R 'stacktrace if reason=3D=3D"Function
call interrupts"' ... command sequence, then
# trace-cmd start -e ipi -f 'reason=3D=3D"Function call interrupts"' -v -e
ipi_exit; taskset -c 0 insmod /kmods/ipi_lat.ko; trace-cmd stop;
trace-cmd show; trace-cmd clear;
The output is:

          insmod-1746    [000] dn.h1..   928.400039: ipi_raise:
target_mask=3D00000000,000000ffe (Function call interrupts)
          insmod-1746    [000] dn.h2..   928.400042: <stack trace>
 =3D> trace_event_raw_event_ipi_raise
 =3D> smp_cross_call
 =3D> arch_send_call_function_single_ipi
 =3D> send_call_function_single_ipi
...
Actually, the behavior hoped like this(no stacktrace):

          insmod-1677    [000] ....1..   473.474846: ipi_raise:
target_mask=3D00000000,00000ffe (Function call interrupts)
          <idle>-0       [002] d..h1..   473.474848: ipi_entry:
(Function call interrupts)
          <idle>-0       [003] d..h1..   473.474849: ipi_entry:
(Function call interrupts)
          ...
          insmod-1677    [000] ....1..   473.474859: ipi_raise:
target_mask=3D00000000,00000ffe (Function call interrupts)
          <idle>-0       [001] d..h1..   473.474861: ipi_entry:
(Function call interrupts) magic=3D0x55aa55aa
          ...

I tried to add '# trace-cmd stack --stop/reset' before the above
command, but it did not work. Any help to disable the 'stacktrace' in
this scenario?

> -- Steve


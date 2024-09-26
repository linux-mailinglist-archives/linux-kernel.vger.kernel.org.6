Return-Path: <linux-kernel+bounces-340246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6F987071
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4242B286DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF501AB6D2;
	Thu, 26 Sep 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="CXGzRBFy"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8D146596
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343672; cv=none; b=NzpzSSjJdGtLoqR+LuVdn3pIw7FpGRsirqtJER+5kkIqF2jdmK7Fxlp3T8bRLfZ7qn/7kb3VquMcV1iebx6DWm28IwXRHLCH1Wk4CC2GTmSZsT+X1yaq61RBCFLRCZMfDIXAPV0qr4MB39x7RJwGXppzc7Lm1oU7IZmQSYrNjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343672; c=relaxed/simple;
	bh=xskZouvFV/Fx30bVQpBOCRnKu9Pt38UA0tbzCtzke7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqfGaOe967rMOrmBXhgNtJ6ToI0+FgefjcgwG5P6y06w8RI0LQjDYqu8aUn4iaYX+W+NqOlvNxWUykUxb+dCVRxcLVQpwk9lwXoY+xdiz0y+BOaDXQ+WQl6d+fKVrgs8ueCe7fQ0WUW6Vv7WrtgoqAPtBE2JPHpTEoRnySYGRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=CXGzRBFy; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a0be4d803eso2850015ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1727343670; x=1727948470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FnhWXWhJY5yX0Pz22eGrT3yNZ4PY7RxqE/CT+upcRM=;
        b=CXGzRBFy4kIey4B1W41TVzMU/v+JtpiwlOJR8dYvERYfeAGOl42unEw759WoRpR7iX
         gAf3FggVhXW4F4v9dhahh2NfxMXhOpy5JvQdAQKYnOL2wC8BTmT+Xwrzd1tJq79LeJ3J
         mtoEmrClq4stuQ9dnhWWdISLQjbu+VM/HSWoyrGFL8fsus29tqb+QmU0+CJJVS2SYGes
         uxVHjqyiugxx/2HkRX3Hye6oFGdzCWmtgZWfyrdy0PO9PUt3FLY2ysvvRwC9cXVUvljW
         0xcyna0apPgCWuHSJNEuNqMkvpY6u2ILXnsCh+GTsTavg6fpHYGRRxDNdrlJKdOzF8RQ
         5LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727343670; x=1727948470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FnhWXWhJY5yX0Pz22eGrT3yNZ4PY7RxqE/CT+upcRM=;
        b=OUoLHJR3sd+9m1heTucnUIQ55qpGxQolZpSxd7OD9b4KQpDqYNcVROO6BYwnbxlFYv
         RVxIiPeJan3dI9BqD5WVQ43HoGVzVwXDg6X3PMiE56LYLyLJOqbw72w9tey2vm12mLmm
         RUf/hpmnr7Ucq9g3LTIySo2ytdrCawkPm33Q9r1WenWTme1hDxVEGgYnzYjeHrqfaFdO
         +2EJnX15lq6kxQ0Jg675ag9JI3HGMzuYDzxJWClUlh6ewA5aiPpix1xT/nbygQ5QOCWw
         m7Yl7uv/OlFdG9zk20PT2ApGTeGTyO3RgDMElR/syF2Hf6pHSH0RJMKhCkpyp8jjDebV
         RZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWCFuZxMRyv6Q2tk99K+HHM2jiTIeqXSklxXQqNd199kh5DVuS7kZarCfvfzznelnElrfb3gk8e2WueeKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxds6U44tpCvVeg6i48Vfv/fEfbBgYJAUbXfm/iVeA+yCO7JLU6
	mnW3tYOQrxXsuUFawxG1nBvavUaS9X2CyBfo1sMgBKC7mPdhwkP4Ttu+ip8TCe0VFGbzA4TQh/h
	J5i2RPNQYxP90wsPBHlGqWOXuMH1SjaxAN3qvTQ==
X-Google-Smtp-Source: AGHT+IHqNUMKocHT7RIHy4uucpu7Fe6ujivpI7W/6ABihTZ2wyqDu266A5BST9H2zCCJnzEm7SRobEf7LeCchdTK+UA=
X-Received: by 2002:a05:6e02:1a24:b0:3a0:52f9:9170 with SMTP id
 e9e14a558f8ab-3a26d6f9e12mr58910685ab.1.1727343669759; Thu, 26 Sep 2024
 02:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926065422.226518-1-nick.hu@sifive.com> <20240926065422.226518-4-nick.hu@sifive.com>
In-Reply-To: <20240926065422.226518-4-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 26 Sep 2024 15:10:58 +0530
Message-ID: <CAAhSdy3iB++KRj_q5GS5qpri2A9OZii=p1itxiXQnoos3So3GA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Jones <ajones@ventanamicro.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Atish Patra <atishp@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Samuel Ortiz <sameo@rivosinc.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 12:26=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> Stop the stimecmp when the cpu is going to be off otherwise the timer
> stimecmp register while cpu non retention suspend.
>
> Suggested-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive=
.com/T/#u
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/clocksource/timer-riscv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 48ce50c5f5e6..166dee14e46b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu=
)
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
>         disable_percpu_irq(riscv_clock_event_irq);
> +       /*
> +        * Stop the timer when the cpu is going to be offline otherwise
> +        * the timer interrupt may be pending while performing power-down=
.
> +        */
> +       riscv_clock_event_stop();
> +
>         return 0;
>  }
>
> --
> 2.34.1
>


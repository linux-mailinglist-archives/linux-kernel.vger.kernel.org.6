Return-Path: <linux-kernel+bounces-398693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB039BF4BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7542D1F249A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52520820F;
	Wed,  6 Nov 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hhhut2qi"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C6207A2E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916029; cv=none; b=sFUSHWQ6//hEVAonXWbgzgoCf00j4RavmZV86rzLrxAi9T8cCHYYXH1gSNX9ffVxldeqOmBhLmna1lab94leKlxIFRSS75Mj/nYA9zcNOmHyhPMhjXvrF/V1G8/Ur8q209mRtJn8twz9vwaxbPKETdL+w6k/Q9DuoxAZ9zeSd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916029; c=relaxed/simple;
	bh=2uDUvUN/86SpqcEnCVLZ/V2MpmasoOsNoFzuJhsE06A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYTqVzQ4qOua5h4WDACr0K+GCMBsK1jxyfzP+JOZgaRoU/1+k6r0mmP8Di+xynkP+1BG1veSKBmZe1GjFZr33BHuCK9C/ifAzLS06Xyb8JMlpyAhrrXBhgfTCmeXMSirn7qVlZzD6Zn9MDKQ4vZvhd1FtyBLNsooOiumVxJSwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hhhut2qi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ede6803585so952574a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730916027; x=1731520827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHvHVhlJUFnqh+GtXJR/IXcya5Bnm4YoBQuvLZg0UA8=;
        b=hhhut2qixZNlRkI/MOY5/yJcMdBElqrA2zT932uG8s5XZ3kV+wn2MD0F5+BpFi0cO5
         Ja9wxC9PEKivrNkoCzJKOC0UF5btflSTYnoTjEIy3DptRixaXx1LwIGR0+obE+MDl1yJ
         Po7dDS3nz1PD+SCkbCkw9bQyfuyElSit4lCYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916027; x=1731520827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHvHVhlJUFnqh+GtXJR/IXcya5Bnm4YoBQuvLZg0UA8=;
        b=hcASSAXO439dxYT/2jhqAKvkW8jLJwPy3bntCID1/8O4EiwOIO7iebK6fpKPQyrjTa
         ZLKZizSOLSktENMKVK7VqrIh4MVHbv0UUzkTyq8cKoV9MQLyLYpFvNTBAzCo4pwYQ0B+
         StjXC7JUDlWjpkYYOj6O2SsDxGPtVncsWh2g4C/DSjvJ1TKCLZEIXk4O1K/RGXXONC39
         1MLjg2JBuYV70+IgsQa5cPHf/qZPRCoJzBP16waCtFIPllIfUPwZ3ahq3R6sYnM+ZhVK
         bvHq/gxaFyIAxGhuclXkpsWOfKnMcAPOh+ucnw/nJ2FUDRa0/ZQnj6CPIEEyr2q8+g1Z
         BpBA==
X-Forwarded-Encrypted: i=1; AJvYcCWEbbV4QHRZMheqeOVB+s1lnZr1Xl4Qpg14V7wZRTEjICfOsUF1jSUJqnV6ELjhbq8QVqrkWXhUWgDgW6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH7Axdfq12Ne4rqXr7Z0dZAoihqQKdNYS4GIaEdPh8MwSElrno
	6a+P6OSF8e6KvVBH2sOkCTyUopOeRUnIztq9cbQfBxV4LlzGSgtqfawwoXiyb0OA/CdRM0VcoAg
	=
X-Google-Smtp-Source: AGHT+IHa3A3mRl8BuAJCpkQuWshaxXrgXKnDuGI9BjBBL4bzXyeEICRgLsnPDJJJeDa7AMPjqNPJ2Q==
X-Received: by 2002:a17:903:245:b0:20c:cd01:79ae with SMTP id d9443c01a7336-21175b333f0mr2151495ad.24.1730916026614;
        Wed, 06 Nov 2024 10:00:26 -0800 (PST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0618sm97991975ad.205.2024.11.06.10.00.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 10:00:25 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c8ac50b79so6165ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:00:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1pfuxKn2W3clj+zGx3nMZoVzsNL4S8Zwkrl1AqDF6Nw4EfPGGS+SBJK67gSL2VHQHpSSimuekIdSuQVU=@vger.kernel.org
X-Received: by 2002:a17:902:c407:b0:20b:b52:3f7c with SMTP id
 d9443c01a7336-211749a4520mr546035ad.18.1730916024977; Wed, 06 Nov 2024
 10:00:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>
In-Reply-To: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 6 Nov 2024 10:00:12 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPKosUXy1x7Yvbu3pEYiMfDPSt69xt3Jq-zHw66yeUSRw@mail.gmail.com>
Message-ID: <CA+ASDXPKosUXy1x7Yvbu3pEYiMfDPSt69xt3Jq-zHw66yeUSRw@mail.gmail.com>
Subject: Re: [bug report] cpumask: gcc 13.x emits compilation error on PowerPC
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kees@kernel.org, nathan@kernel.org, yury.norov@gmail.com, 
	linux-kernel@vger.kernel.org, Gregory Joyce <gjoyce@ibm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 6, 2024 at 5:02=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
>
> Hi,
>
> Of late, I've been encountering the following compilation error while usi=
ng GCC 13.x and latest upstream code:
>
> Compilation error:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   <snip>
>   CC      kernel/padata.o
> In file included from ./include/linux/string.h:390,
>                  from ./arch/powerpc/include/asm/paca.h:16,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:23,
>                  from ./include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/swait.h:7,
>                  from ./include/linux/completion.h:12,
>                  from kernel/padata.c:14:
> In function =E2=80=98bitmap_copy=E2=80=99,
>     inlined from =E2=80=98cpumask_copy=E2=80=99 at ./include/linux/cpumas=
k.h:839:2,
>     inlined from =E2=80=98__padata_set_cpumasks=E2=80=99 at kernel/padata=
.c:730:2:
> ./include/linux/fortify-string.h:114:33: error: =E2=80=98__builtin_memcpy=
=E2=80=99 reading between 257 and 536870904 bytes from a region of size 256=
 [-Werror=3Dstringop-overread]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^

FWIW, I think Kees already was fielding a similar report a few days ago:

Re: Fortify compilation warning in __padata_set_cpumask()
https://lore.kernel.org/all/202411021337.85E9BB06@keescook/

IIUC, he was hoping for better compiler diagnostics to help out there.

(Also, I imitated Thomas's .config notes from that report and couldn't
reproduce with my GCC 13.2.0.)

I also happen to see there are a few scattered instances of either
disabling or working around -Wstringop-overread false positives in the
tree today.

Brian


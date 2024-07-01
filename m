Return-Path: <linux-kernel+bounces-236836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E065591E7AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845051F216C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632F16F0D8;
	Mon,  1 Jul 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m1MBwG97"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3016130C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858828; cv=none; b=jn2QkeQq4dVZMGclAXuaZHWsE0YAUFnLUXlQL4ModA4F9kfFhqQgCDBIUYUv/46rvKGW1eUYu3ZWs+zCwlgPbhnQywXtvcSidyM/1geUZx7XJ/Y1fGE+WZK5HEemBeaPJWCWTbM+zoF6axg4ufmVoRRZZOxmXPMjFPRDyk8aY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858828; c=relaxed/simple;
	bh=o768OFO8ymKF2WN6iJdKjiEs5teokkn43UIghq2x2Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kG1Z2l7QjZI/5Vz3EJqsnwB3Dqe1OWnGM+f0+X5Qmq94HrSM1CfoN9JD8f/RlG4Ra0/8Wxn41Y/avzApDSTyrZsWx0gPg+g3SaE+gBsaLKLCEIGIAxg0ZcaX9t18LB/K1UgQyg8/mMuhpoXHrIuEAYvpa6T8ZdzRx6S+WJI7zpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m1MBwG97; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso3836409e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719858824; x=1720463624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o768OFO8ymKF2WN6iJdKjiEs5teokkn43UIghq2x2Fs=;
        b=m1MBwG97iTcxAFGg4Ap9zyoNHShobImAVzg+2PzX58uud+CJxzKxoufzwpZmXQQg66
         eQboiaDlzUvLe02MDuwhFQ0qQI+8CjnH+WzufcH/vu/HSvxZC/3/w7AZZ4bA75ly4sBw
         Gt4OiA9jgr3t5pllzn06KbTOGyWdwew5l8JdgoHVYCm+5pOwYDYY0K3Njk049+S7rau9
         DdvOgDkdhPlN9AOSK7d9ipTcW88NV/p9TQ0CbDpbrv1y52RPkGNn1cG5VfzuVfPy77Nl
         AoWvH/iVPM4i3+r+L5NzP67wqDHzw+cRtQku4xrV8YAB2TYnACeSIEKww428jDxJb2iK
         Nflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858824; x=1720463624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o768OFO8ymKF2WN6iJdKjiEs5teokkn43UIghq2x2Fs=;
        b=EMPgJ0aFDm19Ue7/rs5QgzRIkGpoKXMGZsPXxs75MpEgkLkT91WrD9dl9jyjjlIT77
         F1PIg63QRLpALdFHm2ay1ix9qmEGDSPbyseCGArM6NOvfQ9tG5Zlb3N+B0fNUXzZ2UPs
         tx8stvg/xpg4M/Q7G1xJQt0we9N6aK6uOUURtU0fb5NEekNvziTn7ItivMSGT6vICJHa
         BMbvixwOBGfu/6fl49yL03nYtrgSOcnBWcMxmb1l8cUMPlNNtejTZMKRSmpyT97tOyxw
         3DjFs4ESjk+Y0oiKDV/Mn5ea+3OltiA78XbirMlATOdGwM8IAf4Rugm+H4QtRHVW5rk1
         3RgA==
X-Forwarded-Encrypted: i=1; AJvYcCVKSiMfQbps2HKCdBVWpg8RVbCrKOTA/0g9lOhWIOoibWUmOG06IMAl9QlkoALrK5iZUUJCirUuXt6qlo+zmN4eIrs9KBurIabu4XR1
X-Gm-Message-State: AOJu0YxxsFfdyI17fPqU93qSYxm1FSfwt7qF0fLasnKAlrp4aXQjSMmn
	CSfrIdwS0ym8HHbzBi5T4mOmVXiPgrrmhF4LTPXPI3RHsf00OG+ivukxctklCpHVi8rv5A4EwMQ
	9casajczFC2WdNW6HSwz+UBJbXPa0uFspVNJ4hw==
X-Google-Smtp-Source: AGHT+IFQ9mRosBK5PT0v4bYt3n6ANEe4IwUtPMWvMAL3GS7KvQKxJK01J5Eg8zPyYaPZntVpFAZHwa61OYHF/xeWlKo=
X-Received: by 2002:a05:6512:1154:b0:52c:e5ac:ecd2 with SMTP id
 2adb3069b0e04-52e826feb8dmr4493189e87.51.1719858824320; Mon, 01 Jul 2024
 11:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHBxVyEaCFt+bC=bwO54n30urANy+DaffOBk2odpqjpbBgOPKQ@mail.gmail.com>
In-Reply-To: <CAHBxVyEaCFt+bC=bwO54n30urANy+DaffOBk2odpqjpbBgOPKQ@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 1 Jul 2024 11:33:32 -0700
Message-ID: <CAHBxVyGOiurDC+ep2Rzw0tTWHSWa_tXGA3ftd5JcWm6SznWyGw@mail.gmail.com>
Subject: Re: RISC - V Microconference CFP 2024 CFP
To: linux-riscv <linux-riscv@lists.infradead.org>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI: The deadline for RISC-V MC CFP is in two weeks. Please submit
your proposals asap.
Please let me know if you require additional time.

On Mon, May 20, 2024 at 3:33=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>
> The Call for Proposals (CFP) for the RISC-V Microconference 2024 is
> now open. Don=E2=80=99t miss your chance to submit a topic proposal!
>
> The deadline for topic submissions is July 15, 2024. Proposals can be
> submitted at: https://lpc.events/event/18/abstracts/
>
> Be sure to select the RISC-V MC track during submission.
>
> Due to an unprecedented number of submissions this year, the RISC-V
> Microconference may be shortened to 1.5 hours (nano conference)
> instead of the usual 3-hour format. Topics will be accepted on a
> rolling basis due to the limited number of slots.
>
> LPC 2024 will take place in Vienna, Austria, on September 18-20.
> For more details, visit: https://lpc.events/event/18/.
>
> Update on the microconference situation:
> https://lpc.events/blog/current/index.php/2024/05/13/update-on-the-microc=
onference-situation/
>
> Best regards,
> Atish & Palmer


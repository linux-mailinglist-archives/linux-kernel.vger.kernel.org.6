Return-Path: <linux-kernel+bounces-576097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1511A70AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF95189CA96
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B752265CD4;
	Tue, 25 Mar 2025 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksPX684X"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750A1F3B90;
	Tue, 25 Mar 2025 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933039; cv=none; b=W3hSV5ahYoGC59TtwzwCuypfMH3o1y20jiscSpU2qqbhPf9y7jwWUpWjw14o0DLhofD6CDGMxpQU7s5HgYOafDbxxZRDZy62FkdhtJcpfAz5P3n4xjdthJHosCchehi0bchgqOvZ6WMf51vDF1UHuH1f5aiw2R6ZgguOfj8Nk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933039; c=relaxed/simple;
	bh=O6R5vStplW5nRfRkI3i54E6IZ6L6vROkfTyRjs9kAhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFPRQPU7fF3s8F0HUDqZ4+FfUP8ghYbVh/ncpDIELFGuasle4wbAQo37FlfaWNVniRcPRULn+RciSRyZea/a3Ggez8k+D9VMCJgPsItwN9S9QATMR7QbLypVzR8pW8/+K/xZ/tch/FTloR9YcfamoLLHyq2yDIbDK3Ta24iw/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksPX684X; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso1653114a91.3;
        Tue, 25 Mar 2025 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933037; x=1743537837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+A7Kx73f0r/rQykEaZU0+gBmprXdCz4INqBdyDs75w=;
        b=ksPX684XgwdRBC2mMb97cly3+QOdxaADh2wqdUBn2Ku1C6ENdq4xInXS6mbb//ObbR
         xDNjf6HkliO98758FgLoPdlWymoqDwnPNaz51wKX13wDi6edy1X1UPN1h35vaE5asVfS
         hUMT6HmVtpFPoL4xU+sXvcuPo2QClYWOakqYazEmfZdMxOYDi+yKmjH9hYpHqY0c/113
         ZzqpfozI2NGMf3SrZMwmZ2xKAkpesDcc8235rj8GCNpDQheF72Wzs6aPTtOZR0X8nZUn
         we9NSp+vgwRtUMrNczU+EVjA/75dSXsHXwkosckSBWH8m8icx1rkYCh2pczLW4tdVJwK
         AmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933037; x=1743537837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+A7Kx73f0r/rQykEaZU0+gBmprXdCz4INqBdyDs75w=;
        b=f7TDDVkLi0qW5b4PmaNGsyZls19D4t/ESigE57cX89Af7f/KAIwzS9I4POrWQweREj
         QqfQfpWlNlPUqhAx2LnQSTZCzbQzyIeavRAfwNXXjkYcAf16u+NvDxnzAqbLCGv0Zu8Q
         8KSsNTdutppe+LqBKK1vsurvDaozd0tdugUp2IItZDENNHyaQBJK9vcHw26M4NDVFRum
         vq26+LhjsxAru5jtjn8dbWvuZ4ZPZ0fs9NfS90EcNTOOVKhCT10gtHJVMbWi7pveHphd
         WwimnEm4EQI7/b0Z9rCpdUcOg8QCIUsa5c9yn3SXeIpceKW6rZQJaU9cM7akknru8IZK
         xh+A==
X-Forwarded-Encrypted: i=1; AJvYcCU4GJyDft8jbRLRuqJbcYUNErTH+h1eiJvSBW/GBqqg4TfZbibLTQkqc803tm+V1icqmsaVEJ4CzCXhY54=@vger.kernel.org, AJvYcCWgjdTffz9/iuq8fSxvpBhwpapodU3pfXMmUuoG0/7dVac/ECl8Vni55SCfYCJsNDW5VcVtGGu+rXzU3P95QPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JzOmQJ02M1/PEJyJdNeXMWxkj08+8w8T6gFt5j1NRmJiZNQc
	snttu01/VVedWsk89pm4fQrULBtxIEFnyLnxVWsGnrQ+8WKtKtG9dwxnJ8KJOPOLxXQ4HEx4keG
	bMVB36KbNAI/wHpRPj1LPd/CkVHI=
X-Gm-Gg: ASbGncv5F0nO6aSDZcwnvyfW/ECuvgDmqJGXqSKCY5XFOLatTfy8B5YVi2edkB4dPFe
	/qOGQAm8J9blkdLQYXf6tfvRdhf2/XbGsnGgWs1jj76PJaMestNkz59vNzhk1koAox15f8lHAOW
	1m4k2YxY1lEofd2Z9RgZfYnpmUyQ==
X-Google-Smtp-Source: AGHT+IF77yfJsEs1rNlWIdeIMX6PH20OJhiYagR24JLzgL/YjqkLtfQ980ZkNSwjPWRXeltKVbheDFZnhlBV4anpCKE=
X-Received: by 2002:a17:90b:4b51:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-3030ff111e8mr11378369a91.8.1742933036780; Tue, 25 Mar 2025
 13:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87pliljcvy.fsf@kernel.org> <87tt7md1s6.fsf@kernel.org>
In-Reply-To: <87tt7md1s6.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 21:03:44 +0100
X-Gm-Features: AQ5f1JptoHYM6pIDmyum5kL3Y74I2pu5LLA3LU6gvLquJNER5Pz_N-xIGJeRAuo
Message-ID: <CANiq72kGAbhSi6y-2iouuRYhEZ9rGnDmQKJo8YwYjcaM+P5FpQ@mail.gmail.com>
Subject: Re: [GIT PULL] Rust `hrtimer` support for v6.15
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> As discussed, I fixed the UB you fund in:
>
>   rust: hrtimer: allow timer restart from timer handler
>
> by casting to `u32` when assigning enum values. The commits below this
> commit are unchanged, the later commits were replayed on top of the
> changed commit.

I reduced it and filled an issue upstream:

    https://github.com/rust-lang/rust-bindgen/issues/3179

And I sent a potential patch to deal with this cleanly in a single
place (as long as the C headers allow for it, which in your case it
does), please see:

    https://lore.kernel.org/rust-for-linux/20250325184309.97170-1-ojeda@ker=
nel.org/

By the way, it wasn't UB, no? i.e. the UB one was the parsing patch on
the modules series, which we discussed roughly at the same time.

I hope that helps!

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-545591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6593A4EEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FEB77A88F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7325F989;
	Tue,  4 Mar 2025 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0ZbDbgq"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231513B58B;
	Tue,  4 Mar 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122080; cv=none; b=kOzd7OCS5h/4IOEqqxvNpj/SIFivkvpOopVtvsZWv+tZqNQ3SAxuBRjTMqXd++IKgSclPtrlAcX3QbGWPQrs2JLp/e+fNLBCme4yrYgO/Z/VvacVTj2vTAKPKfRgC6EONUPDxjQXC+15FGAiFuSMNrD0eFaOCJcCHNmbeukMcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122080; c=relaxed/simple;
	bh=5Rt7HhMnJR87FIHk+sbfLnVm2bfYWZ0GWvkeiHdnnI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ki5/YAkdvUbaWqsJJXAR4t5X6ppBCR5tAUOGOzv25zAIsJUN7gNhMTQ3Nx9F+jQzxiK+TgwhFn2OSBgP+ly3TgrVIWiBvoRDv8t9+LY0M2+0MKgIaBB8b0JxMk/t7s+jZim+6qqnCAHciG3HdO5mt55rflJPkslF8uOiIYss9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0ZbDbgq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fee688b474so705213a91.3;
        Tue, 04 Mar 2025 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122078; x=1741726878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Rt7HhMnJR87FIHk+sbfLnVm2bfYWZ0GWvkeiHdnnI4=;
        b=J0ZbDbgq/2wIATYmrwp1yh3Gb3BER1LJ8k9TiGR2d0Ce1/78Uhf4OcW5XlfTR2juiK
         ExqJPr72UyxL5NaTmM60q3SiqEGP1TFQeNy3TKbw5OpoxWOHfvRczSxVXxPsWev4D3nR
         WozfjdZNADevJiRJf7K5s/F7iOC13PNRl+dfMulgJhpijOtWes5Ld0229+Q/FLjoBPpN
         iC/A7TIK8IFNoSmAJZ/dT5My5mrIzdV1gPMcoZKG7yFOrjC0Mm6WZfy+iJG9zYJPPsxf
         vf5OMQGg5JolDvhq8DDRbinnCdcMWCaGLfeBQGmLOclsVTyEd7nIcAFDJSXe8pvNBGhk
         mioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122078; x=1741726878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Rt7HhMnJR87FIHk+sbfLnVm2bfYWZ0GWvkeiHdnnI4=;
        b=YHy1eEdCmSwbFen2aD3UzxjPHOhDmpB7WFwL2AHs4oB7diLcX8VfNqUKJkA1scmQJx
         FmuBc9jNFuF7E+S/glHjLJJYa3dXQJSR/SzKzYdpTlBCb+98sr/t6zmwn1yu01G8u65/
         AgdAs4I8yMf0lJOvYN4VMpkmHUfYUKUC15ekWH6d46f6bbGaobOipb4NijWNzvdieeqk
         xSaU83og5QQnLmoEqbrzuVHhhARuiWkkA4W6xSjB09g841H8Iaue0GR1mVKUc6chh6+k
         Fu50QJJ80aY0X3jyvS01Goev0z+5DN7YWz44ofTopeLQyiM2D6q3zy+DWDnB45zc8zv1
         phPA==
X-Forwarded-Encrypted: i=1; AJvYcCXUM2Q9EJfUUAnxEcGiccQmJ2GIvW0N9eexC2LPan+oT3rOkoLkLDiIIZAXDuslU1WyYrDbk/Y0MFyL5vIn1Ho=@vger.kernel.org, AJvYcCXWFgiCY8mQQnsOurQI94fPFvaJvHQbKnMZnW7zpMa60BKOYBzPkH1QkiTSeaAVC+9yydoGCrzREC60Mo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPvvNJP1AIY+uD7FEDfn05DqD28fFp0qsd0VmZs3sLQceU/tB0
	hAnoY5MdnO4nIVjA30dREnCsvkjWddPSCSHcV2gdZBAW3rLrbg/1Jxx+yN8TArx+NSpGmZ6kyau
	AIN0+M5TP6cK2Wjudrxo9tt0QyiU=
X-Gm-Gg: ASbGnctlcqisZ0FTxtAGqHuv+kf2U/6GfMYbdbkabHAAq5f5o2erxdBeaHZBAX4z8Ol
	7qLeue4C4FrPid3gBKEeYY0KTR6Ga6gx3n0uOXhDOVZzBPD4Ovm+CprxR522pMYzseBL41Vmc9n
	mBL01e89rcc1djDBuXf4I4urT30g==
X-Google-Smtp-Source: AGHT+IHotE/T0X8lzHaRVKUzNHr91tgDUR1NTtwaUOkHawisXlnELgc8m8HPLRWUglWGRhQ0+YiwV/wtCqb0DiC0PBw=
X-Received: by 2002:a17:90b:4c0b:b0:2fe:957c:1146 with SMTP id
 98e67ed59e1d1-2ff497c4309mr440110a91.6.1741122077913; Tue, 04 Mar 2025
 13:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt89gfe4.fsf@kernel.org> <20250304205054.207285-1-trintaeoitogc@gmail.com>
 <CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
In-Reply-To: <CANiq72koDba445gMYtC_VEcFk2+O-Xg2-2y6uMyp7onBy=7rcw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Mar 2025 22:01:05 +0100
X-Gm-Features: AQ5f1Jqd9-qXA8BaSLWNNSh-szg_2ed-Qt7ZD7z_Dstq70U1UUlWMvHuq3U8Pok
Message-ID: <CANiq72kNG7jZf+hZARjyAp-uG=x99CrUKZvJYT_icaF0x0G6iw@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bhelgaas@google.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, dwaipayanray1@gmail.com, 
	ethan.twardy@gmail.com, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joe@perches.com, linux-kernel@vger.kernel.org, 
	lukas.bulwahn@gmail.com, ojeda@kernel.org, pbonzini@redhat.com, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:00=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I think it could be a good idea (it would be lovely to write the
> checker in Rust -- I also had a checker bot in Python from the old
> days of the old `rust` branch in GitHub), but `checkpatch.pl` doesn't
> need a built kernel, so it would be a disadvantage or at least a
> difference w.r.t. the usual `checkpatch.pl`, and we may not be able to
> call it from `checkpatch.pl`.

By "built kernel", I don't mean an entire kernel, but rather having to
call `make` in general, i.e. we could have a target to build just the
script, but still, it is a difference.

Cheers,
Miguel


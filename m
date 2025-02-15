Return-Path: <linux-kernel+bounces-516356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB87A37011
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8DF7A3DC1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E0C1EA7F0;
	Sat, 15 Feb 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy1dbCmC"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC11519A7;
	Sat, 15 Feb 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642871; cv=none; b=apdU/Ql0RMJLfxW4IHfBXxylN5w5w7KsD39WKDCUTuXTiiDHof++pmvNVHVC0E83+sEf0cQbQgLfCx0bDjyygOjKayPbfcCFZSqZUeEzhIPhXlcuzg98JJdLQWqZZRcdtUtzNvlsOu5oLA63tDGHjuR6lszLaqf4qnckWmK4Pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642871; c=relaxed/simple;
	bh=27ihcGwNfhMOX6VMaeABMmzgHM6w++DatbE/dq/QeRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrQAizxkChUNWX0aDdPlM+nCbmaEhUf0j7JhReF8/+a154bz16KH5eymapBDdC/C69R1ukcsfVQcK/kZ/lClPJYVkcgE7huAYiend9T1Vfm5H461pxn2LK+KmgEiD6cG7kc1d/gIEYIaAVmdXo+uDezNL5quTxxPpqRClwyuv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy1dbCmC; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3d9348251so1993006b6e.0;
        Sat, 15 Feb 2025 10:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739642868; x=1740247668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKiFbJxF4Rgzv9Phfm+fANcxT01MHoDXmdNdQTptkMU=;
        b=Uy1dbCmCQLIt+gply96rAV/LII6lTLCQtApzmU44SzO//K+Oj1USWLnlxrUG/dX2DR
         jVm12PcZVTtqA+PKI291bhqUE9lDhYR5icGJMJBt5wtOENv+ksQ15TU2l/CJv6JKxt+Q
         rbI6a5CRsnqQ68ChMztcvF17z6Fk3gcQGYujo7JhbZ39uDhQM0LN5rXAvn7PGC27aysQ
         nYbtY6EnoYNHBLWiH1C3ij4UaVS5iJIAaMZ3Zt+y0yoyoiHTGT9HNzUyT9Sk9pvoJA44
         Zm4NSPrLmIi+013ZVuK8ehgmO7pFVmQ4/IWpIcG5f5zqGx6pt7G4VNaRmJhvOhc7OJB/
         z8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739642868; x=1740247668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKiFbJxF4Rgzv9Phfm+fANcxT01MHoDXmdNdQTptkMU=;
        b=Ki9BvbVhbyAwtmZoBtyvefYmEpp38rpuONygkLfGO7uo67Vr+gBTEZKl5w5zq2xVf+
         02OxExbDcw1A7LTsHuqfS9XBV2HaczmtP+8xkUw1Ad5q/kRbyLP2GLwYS2sbP7Of8Tor
         dkDuSqIl+1zMfGHM4eQBDUuWEuvHEOmpyR7ljEtpPy9b9PayR8YuLhI6YeitBokgUYYB
         85pLiD4U6eV8qQrLaib8IzBfZF4MHKmesJjYZvsFDVbixzqcvOPSqAhud/W5kO/4rffX
         +k7DWqdy4COqKacDgeJMDpeH+tLJBwQEwCIXQbSwKdD2ILmIcClPROt3A0t/4RajpYg7
         abhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV246sVXQtYths6dpP4xdJ3tuJbRvYayW3B92St05o9DcFwbGrdPO2Z0QPGuZxeps5FwBp6MOktZQM=@vger.kernel.org, AJvYcCVTCWCoCKSXW4I9A99w5KEV9ir+TmeHcvwO5mDmx2HCIDIujD8HRTUTkF69bnAJJd8X3NqmaVdx3hJ7qFxE@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuu1+5YGYAE2KLLaufXbd+Xl319tR0w2x8RvtReAL5CTARiqT
	KhRSaYS0/1ef6JuAqKiOdnEQ3E62Uil7+zkDfJGFpO49rU9uEeEnEqrwPVuRN7IXcKLM8po1kZQ
	rYWoqtaG5kVumIpXMmIwXJpNrePo=
X-Gm-Gg: ASbGnctRXyt99HHTVphwfrefFH87Fqe3484W+4VTTlCbznBK2Sg0Bqg66cRLwMNuV0D
	T8XY+PfFIEWpWj4IclJfJS52dO8P/jpSVT/AY67gvaD4/WWF/UGNHF4tAXJpdsJ9ZqmDQOkdQRo
	oJXcnj9GTHZioXAA==
X-Google-Smtp-Source: AGHT+IEx5XmUNpapb32FPHN9D0DNU46AjpMk6k4efoTko1Wr4g+bLxj/u7aqTsFdIk4at+JRnBNAqBmm0wLqxdZof+U=
X-Received: by 2002:a05:6808:17a7:b0:3eb:66d7:a345 with SMTP id
 5614622812f47-3f3eb1736d6mr1977430b6e.39.1739642867013; Sat, 15 Feb 2025
 10:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFiZ8wyangitV6RZLYiL5yF5CV1eRXYYzJKhXyP2UvGDJQ@mail.gmail.com>
 <87tt8vunmv.fsf@trenco.lwn.net> <CAO9wTFiUW42yKGaZDQD=CR5f2pmjLNQfJcd81+gargstGVrF8g@mail.gmail.com>
 <87ldu7umjp.fsf@trenco.lwn.net>
In-Reply-To: <87ldu7umjp.fsf@trenco.lwn.net>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sat, 15 Feb 2025 23:37:35 +0530
X-Gm-Features: AWEUYZm1mlF2nvmEzJhCqnl6Y7YioGfG-IzgjtzA9oLBXLkhV8_Qpf-8U0uT6uY
Message-ID: <CAO9wTFi+T3jzgEZk97SRBaEWUYWO00YZFi3amrOV=GwZkt-vRQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/mm: Fix spelling mistake
To: Jonathan Corbet <corbet@lwn.net>
Cc: akpm@linux-foundation.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

I'm sorry about sending HTML content again. I've configured my email
client to use plain text mode now. Once again, thanks for your
understanding and patience.

On Sat, 15 Feb 2025 at 23:18, Jonathan Corbet <corbet@lwn.net> wrote:
>
> Suchit K <suchitkarunakaran@gmail.com> writes:
>
> > Hi Jon. Thanks for the suggestions. I initially sent HTML content so
> > it was rejected and had to send it in plain text again.
>
> When you resend, please always say why.  Meanwhile, though, you have not
> yet succeeded in sending plain-text-only email.
>
> Thanks,
>
> jon


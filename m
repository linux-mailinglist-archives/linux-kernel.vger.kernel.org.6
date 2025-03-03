Return-Path: <linux-kernel+bounces-542546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD47A4CAFC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3735F1750AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40222D7A7;
	Mon,  3 Mar 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FCFfmUKh"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7422CBE2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026513; cv=none; b=YfzZCwms3hNTqTN9PitvFU6Bdj0FJq6QxIHUtjrlEyIowCNFXWh/eF5w4xNxK4U55Gbd8/ei0Hx2ashpGfpwjjoMnrcev8JehevN2BNq9mC4bRoqZD3y3vOe3A9LFwkTZ1Xv6M5VK5/fBduvyJwj2NLC60eTZdkIs+Igrd05LfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026513; c=relaxed/simple;
	bh=LJlJ9+pfOZXD2l9ILKB0AraWpZl4WF3Irkph39J2hTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emH+BtCoveKjFrM0HJrHHhzn3jz2nA1P314WsP2ZxU6CWXIOMbimP8hv2kxcEc+MzUk5NtT9HCUJ4plQXbz983sxKHE+8Twu0at0Tsf5HIKA+kLAZZirL2E31AXHKwdEOPYKfM3lUbcWtg9U+hPdeKLNsevct5UZ5G9v3vZLxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FCFfmUKh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso7088980a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741026509; x=1741631309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PiuymdUWUCngSn51k54uj1Me9yyCCIJ/YBBpvsVy4sw=;
        b=FCFfmUKh2NVH2XNKzWAZPsxP+FV/5dfUm118pWNPpcNA9363Wta3BkEYcI/U3gZDtA
         1wLDXiepfxb16+5f0mcJJTzBjn/hrNt5rbyksLNQUiRLtTF0kpdUe3UV8Fk9yhi0p4oz
         58OjtGbGXxXwFYCmpn88s8n8nXV94ZlECHs54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026509; x=1741631309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiuymdUWUCngSn51k54uj1Me9yyCCIJ/YBBpvsVy4sw=;
        b=M8MnqnTjpAp51mPHWv3tNnh+ywJdpedqYbpduzrQbFAdDW2fqzJ1PmtJzee/UJTaiZ
         2A7avbpJqnqB7087XVJ1CjI58oD6YcaB0GyDyD+bGZ+s5Tog2oFSyoA78jt9vacwvrnR
         Q2ACriAKH790wkYTXUGHkgzWGR24ojC3Zkhts+WjrOnY4heCTR/Mb20EXDIuYU5H2lw6
         UhpS1eJdc3BQrp6IOucsMpeVv2VJR71lzcfcwPMer9e6pPAIxwjYFkmnlq9JhNs42/qH
         fb+OKJU7vNnlKIEegAsLRadjf3hQ+aYunjtw32n1EwU93sL49e3qnViJ0lRakEph6EO7
         BMCw==
X-Gm-Message-State: AOJu0YwWlUxa6yzLnfxT0/NzEmed77JlsXbsTFEGxumKkIH+xCBbAzxJ
	OIWukFr4VgzT8Ka0LlqtDRqWUzXQ8Ad1HNmFksPCl7oH8FJteukMqlJc5qgLmzEihQQWTQeQ6qv
	tAj8=
X-Gm-Gg: ASbGnctXshqLoF6mdSogJOuoYikp2dA3TBEP21ZfQ5r4V4FXHYHPm1tvo833y9zTyjl
	gsCU8gUo2ZpIzHublEjIdLxf8jzeHK/5PsTvLGpG7UJ7YUc4MorkJPg8QjlPZ2I2dMEnD2s68yg
	F3dCJ5Ms5Qskvj7HT39Fkdi7HhpeNE4tOK9jYYU9Us7FCnEiqB8pyK/lMpjULj5JFcg0UgxSHFQ
	Ghq2m8R8IV9dmMQM8peOtGoAC7c0ra1d4YxyrF5VMWKrm97I5rpNPh5eQBdBMGcUXAWwpFw23ch
	MwaZ6c4Sg+h3ah8f15K/nRnU13qhECk7F9f6hCzI0afLkFHiQzwlQfMmU26BVKJR4lu4m3IFxfZ
	LdbaNwrvE61yzK225BTg=
X-Google-Smtp-Source: AGHT+IFn7XhPv2xwpCsBrIGrKCCp9UpVOCNk6OLPHO6v7CEqiDlrAtt6J/SD8YlLRgrjTwe1gEbP+w==
X-Received: by 2002:a17:907:7216:b0:abf:6951:4bc2 with SMTP id a640c23a62f3a-ac1f0edc6b9mr23586166b.7.1741026509035;
        Mon, 03 Mar 2025 10:28:29 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf5fa63b4asm400965766b.33.2025.03.03.10.28.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:28:28 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso7088914a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:28:27 -0800 (PST)
X-Received: by 2002:a17:907:980e:b0:abf:6e87:5148 with SMTP id
 a640c23a62f3a-ac1f13720f7mr23433866b.23.1741026506915; Mon, 03 Mar 2025
 10:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
In-Reply-To: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 08:28:10 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
X-Gm-Features: AQ5f1Jp9645mgpnQPPP7_mu4D7GdZbGoQmNM73EpDQqK94X1yTpIjhLLMBkkATc
Message-ID: <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 01:02, tip-bot2 for Josh Poimboeuf
<tip-bot2@linutronix.de> wrote:
>
> x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers
>
> With frame pointers enabled, ASM_CALL_CONSTRAINT is used in an inline
> asm statement with a call instruction to force the compiler to set up
> the frame pointer before doing the call.
>
> Without frame pointers, no such constraint is needed.  Make it
> conditional on frame pointers.

Can we please explain *why* this is done?

It may not be required, but it makes the source code uglier and adds a
conditional. What's the advantage of adding this extra logic?

I'm sure there is some reason for this change, but that reason should
be explained.

Because "we don't need it" cuts both ways. Maybe we don't need the
ASM_CALL_CONSTRAINT, but it also didn't use to hurt us.

The problems seems entirely caused by the change to use a strictly
inferior version of ASM_CALL_CONSTRAINT.

Is there really no better option? Because the new ASM_CALL_CONSTRAINT
seems actively horrendous.

                Linus


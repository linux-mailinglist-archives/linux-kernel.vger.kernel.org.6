Return-Path: <linux-kernel+bounces-365282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A778999DFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E3A1F2210E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0E1AB526;
	Tue, 15 Oct 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJ6649l7"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CF189BA7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978967; cv=none; b=RYagj7WtvlbeJVS796/5FLBhsOvGL7dlWbyaVMxhtwZaTfv/8PdXOveTZWeodbGqtUZ7ySGLr7GaoX9LOf8n6Soc1oIV0Xd26a8UR2SPhn/2PrfgmF/QSZ5r6Wq8yaOayBDIzbHXzklUHt/pGkv7uYV7EhsLceSxYwZs/goDLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978967; c=relaxed/simple;
	bh=W4f2iJU2YRRvkqlQGmRp0NrctfUTlxD5uwwI+OoQ05k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmpL9+uglZoKg+4nS2cju2mYcrTJDiEZsdsDp2VEdRTfWAFfXA3PABm2iIiQOWGVuHlhduD5Pnwki8kamdljhTwoUNXQ0POOc0Yrz/bASEXV4qgg85Z4rRyD1RPuXf8qosRUF6KJpdqDpSIDto9G4/MKoamKsIXF6jCUCOqo11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DJ6649l7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1966865e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728978964; x=1729583764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4f2iJU2YRRvkqlQGmRp0NrctfUTlxD5uwwI+OoQ05k=;
        b=DJ6649l7Ej5D6iP/gSpXgvctovstvezMwapTSW0qRipinXkXFSJGt0VhIIsNDfeNuM
         qIqETPAv2VPpHQb8l6QDDEsdEcDchvuQ3PkMCuL6DnPblF1ds6/S1n3c7gRA8cViChUu
         l88vxr2M1ti3fDXvl+vnfqVqYkOo86F5umy93pCadAInMSRIcoa5sl6IZosDRfO7Wp05
         m4WG5V8HltzPnzy/WefF9EciHDDM4TgxLlq5y9igq6/Binwe4LhmeavH5L1vA73UeZnd
         SJOBUi0dNnnW0H+iNmQctSx4OW7TzILwUIe6obixfwYWDqbjI23ZZJZAhVzQ3uPqNEXt
         uMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978964; x=1729583764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4f2iJU2YRRvkqlQGmRp0NrctfUTlxD5uwwI+OoQ05k=;
        b=NUVtRnB2OtxyTNyP2bIVhQv/YOireq7K/o34+1+ClRwjm4tXy7GZuHy+d2eQR+UN0D
         IMLhmzsxEMJFnhVIOvkYTqfmhdgmhPBLhtM37WFR19reW90wbUYVPna86Q0BNXpWpwzn
         6/2W7RFxYRA1/xIrxBihbJdy+4aj2hgn+BmHVuS9xNWsdVU4YThQOIJFikqMTdb4VFi9
         /9D8qIZGiuShvB82zVo8kX0XWXMcPlCefwJu+HAz7kFDNCV51c0DKn8rzZ4KCYMKUxYP
         5aydVj0zQpg/JTd/qS5ZeT071JcJPUkFsM6+Re3cQMjpH/onhP/xAX/ZtP2F5KH1x39U
         sBpw==
X-Forwarded-Encrypted: i=1; AJvYcCUu/i3BJDBI3NLrZR37ouHbcgm/zXZiKxyjMwGFUbsua3+VGiZ3KWQUxr8ZJKbzO1jXIbSIsCna0bonzXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iTJ2lN7+DyvR1GezK58SYUQwP6Vz0J+Mpjmoucmh9FgGeG8C
	QAOJWevwP6zMn2MuvHYiRbWvEdbjuYfu3XZaShsPvtoBgL0yKCyUi7r3EGDUjB2LsQi6ckbVuxj
	XHsl3/j4Vl79UHz6l/kB9EMlJhCe7XznM/96Ecw==
X-Google-Smtp-Source: AGHT+IGxQoVV1qAm1koIq8EsNt09kbaJ+UbkKc4EVXnZTt6xt0Ql1TEN5rxOvW8w3QwasQCGnoEZst65gfgN3WuoTY4=
X-Received: by 2002:a05:6512:695:b0:539:f37f:bed9 with SMTP id
 2adb3069b0e04-539f37fc164mr3497720e87.8.1728978963859; Tue, 15 Oct 2024
 00:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
In-Reply-To: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 09:55:52 +0200
Message-ID: <CACRpkdaMMsHXkgcOtw0aC=SPfJJURCyCgzDq-rEXrBGaM44Sdg@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clement,

thanks for your report! I looked a bit at it:

On Mon, Oct 14, 2024 at 3:21=E2=80=AFPM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:

> I have detected a kernel crash in latest kernel on armv7-a when Kasan is
> enabled.
(...)
> Crash log with recent kernel (v6.12-rc3) :
>
> ~ # Insufficient stack space to handle exception!

The crash looks pretty "expected", as you say you start a lot of
parallel processes
and whoops, you run out of memory on the stack. No software can add more
memory to the machine.

KASAN uses a lot of extra memory for intercepting all memory accesses,
nominally one
extra byte per 8 bytes. This is further restricted by the complex
nature of the virtual
memory space on ARM32.

That said, we increase the size of per-thread storage when using KASAN,
THREAD_SIZE_ORDER is 2 instead of 1. Maybe the interrupt stacks need
to be scaled similarly to manage the increased load?

Yours,
Linus Walleij


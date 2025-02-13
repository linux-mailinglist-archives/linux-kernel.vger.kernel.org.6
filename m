Return-Path: <linux-kernel+bounces-512820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B6A33E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C2E16682D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F8120DD42;
	Thu, 13 Feb 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVUlp8HE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF920D4FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446221; cv=none; b=pCbznUFDEIBRP5z9jmQ0KIsBSwioD1dEbbF0nsoxYfr5ClkMHVuP94A5i/vAgiDPTpVW2XcmXFarZQs7qh0WfXyyBEPHV6YzWF1eXeUzG54rNZZJoKVL08rtzAfuSoYzS/9laSD0ef+8O9KhztpPPIHbb41sQJ7PAwc5zpGAqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446221; c=relaxed/simple;
	bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJl7ch2SsAEmipQ+Ck7qS07ltetZAPaYDEdhVQoVDxYL6OcCD1xWlRIAHPQo1B+NKyu4w0ZscR9acFjNrQIaE/ugzdFZwe0oeYmsZRY1XFoZyNgQxrWR7KwrV7UtmYKSDnBuidwGazgDSQ5XM2wJOWdU/Uvn69SZ6EXmVKqsW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVUlp8HE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5450f2959f7so708589e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739446218; x=1740051018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
        b=aVUlp8HE3Mj7Yw7D+M2Ilr4HILAWlFgq0W3QEgCdurBYNiGOc/07AzttlQiYIeIO8d
         Ic71Tdj3Oz5HCo1v1Qj8syKHM6RoXfC5tRYaNXfBYJLnvUcPgf7xHn5dVV0KqqThBvVJ
         bVIPVR9ck/VY2Tgy6z1LtDBh395vM/i2OcF6e8ZGpLHX0wFvaKo1f/MkKnXPXEtzcROO
         Sskoh9CVyZCvJBCaCR5MfbL0dvOLw2ulPxWcRWTR6WwhQeLa7gIrl8zpan2jdmjrTLF6
         WdTqKjXNYFttme7LiFvF5AaFz52Ym0JulLwEJkFA55FnkGgaoxr1fxJEKXojdudKcm+s
         4urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446218; x=1740051018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
        b=q5givNDWpB6nIdpRuGrIidRTyhfTlZCu/UvImkWITAqBIs0NfXkYEOeiO9tx7Dm8IT
         FuHJdXvvyrPezsXI37jJzq+S/gMJL4pzHuIrojkLB1A02CLdSicCkOIvDIYFFPRtaDQc
         yrVKqe0QqqQnbkQGDFWr3tDWaU+ZTJF3fWZ4t3hkDGas99u66u3w8V4seGX7prUkmVVi
         7ceGVHhNBUPbeRixrQoXWwgFrfvdxzuPHSFPMKVkXzw6fLUwu2/TKi2A8ySMUTxWMz2/
         c11JkzOYP+dogRYt6ffJ3YrnGvdmkeay5W0I6GMENfF7p7eb1IMsMoeTbIcrrR9i8+pS
         0bWw==
X-Forwarded-Encrypted: i=1; AJvYcCVVGz1t6Saj88f9ly0g1QUglPpZbWaDshePS/gBQHcrIhjsBY/N3Hlg1a46C1S3Vs8CxtSV0M3wuyvOygU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGVyC6V3KrdlTboCXKEk2luRvYetqMF8DTBtQy4fzEi9LFnO1
	Xcg6NwR1cO3vE4C+tel8qSKpEuORTGrdB7st8s+jOOk+c0DYZUvqarZ/4aHqo2efAw6hDIGpp/j
	bqPKkWdGzRmwigJAYJMxh2odEKMP+dCdRZZ60HQ==
X-Gm-Gg: ASbGncthTDa6NgKa1cKvD9ROZDO+bwqmB40LfJpq1jli2mIiUX2H6ymwdcr2ol6E/JE
	KP9lAzg/YekhGONfR6RMtwvBRoYooMuSDs7llhPPqLxkeV0qvPsEqlr7URxH5mPiNXoXJjqsD
X-Google-Smtp-Source: AGHT+IGtr+B7QUg7ovhczdnIrY54CJufjoazE+Gk4x6uF30Uby+ckGzBKyKIc+SyfPUrY3/AAaJl/Zu1tehVGQNXynI=
X-Received: by 2002:a05:6512:3447:b0:545:b40:6566 with SMTP id
 2adb3069b0e04-5451ddeb857mr591146e87.53.1739446217812; Thu, 13 Feb 2025
 03:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203144422.269948-1-ninad@linux.ibm.com> <20250203144422.269948-3-ninad@linux.ibm.com>
In-Reply-To: <20250203144422.269948-3-ninad@linux.ibm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Feb 2025 12:30:06 +0100
X-Gm-Features: AWEUYZklvT3HDVtZsVqTrXdrtQL7QNdhFrM_NmeZwuKBhmtHfAH-J4BH0prCplk
Message-ID: <CACRpkdZW9aNbrQk-zz4G0_W-HXrxgpWi_QzuLvActcWkh+U4Tw@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: brgl@bgdev.pl, minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 3:44=E2=80=AFPM Ninad Palsule <ninad@linux.ibm.com> =
wrote:

> Allow parsing GPIO controller children nodes with GPIO hogs.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


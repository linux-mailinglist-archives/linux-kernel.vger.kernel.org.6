Return-Path: <linux-kernel+bounces-239486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C59260C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C017B1F239C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00C177981;
	Wed,  3 Jul 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mS78ReNm"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A6157E6B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010783; cv=none; b=s/TuwREnAmiEgn9j3cxPLCGYQ1H++AVN+DMiV1+G79gjqeLd1X+gmvF490Sy2SfoE8dPLuP7OC3p2Q3YBgL/TJWyJ12+dIMK28gYcuNYovml+m9sV8vnHI1ZJ07wuneyXX2Wq/4PGfOYZW1prcN6C6RbrWjiKzAqT8MCsl+wXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010783; c=relaxed/simple;
	bh=Ut68rqDrN1TwpAu4QkfYXs+IX6JiITiQUrIaV3hssN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4dja+A7122MXyc64NyWjEv6avviKqlvZnjErTNqTHCb1e6NlhKgY4vnEhPZ35Zc0c3ZBd7IECYUz8dDiBGoAOpfJ8pVh06hK0ALAkMNLpYKiCBCFQ5QgglHqU/VoMfkzRbV8NBXnVA7VSKWhhO54tv62kiLPMlqwGVuGPC3zNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mS78ReNm; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e03a6c1741eso1245827276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010780; x=1720615580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut68rqDrN1TwpAu4QkfYXs+IX6JiITiQUrIaV3hssN4=;
        b=mS78ReNmhgmFqArvi+BIe1Wpavb6l+9y+2EBiwuCJ2cvlJT+eyuryZ666VPBjWLNsp
         AczWs8UppwbhYwmSV4FYUqJ7JxCGh0IjrivuKnPeLq0Su/s4fSslsVD9h/niQUB1fq18
         EIH+A9yxLMHRfAkw6hQ9nZUOQHYZG9sumlusw+P1R/Tn6A2PwliYNl0a8LlSEZLC9dyr
         kI0l5SjlnZ0YKI58w4xaIMUoRJ3tc7Qxn6bOwUF+2QyrRqH2rdfrop0uS8ZsIa3pbc5P
         DV3dtxAXXDj0zP99+QqcmG8Pdvdjtk53zDUnxCdR1AILlplUVT0l2l0i+lM8yRMNY0j7
         M+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010780; x=1720615580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut68rqDrN1TwpAu4QkfYXs+IX6JiITiQUrIaV3hssN4=;
        b=Wh7p0zNNRBY4PJZtuHMnWi0oxkDmsgOINHs/zCMIb1vVa27+S4m4mGySWNTU3PjNsR
         X1VLPsEX/d+s3Doh5/BGowxt4C0DRThNNKD/8dmt403/34vpKTiQAx4e5rkKNflmdC9E
         KkiKJP0jOXJqYWKov7Bv9KM0EUAxAORCZx0i2/rjn3uVMtSoGUgdlOYlz5f6zjTV6vWv
         f3PP4lL8foeqcULh9nOSpjM+iltR2pQ0N7eLy8Rqnpd835h+/+31JBHRpivjk3M97aBf
         CWpfWUZLpsviA0ogCnyuI+fFvfwqydqM40cZNdrb4tsmNxnr1hNE5E7hQ91nmyvy/o7N
         HIow==
X-Forwarded-Encrypted: i=1; AJvYcCVMQp02mWh2r+lhp+niWA6t1ZzhEQckKJ0RfAqPU/WI1EM+b15YPFp6b3m9x5KztPeO+LUb2hA0cB0CJO00j3yl4pLbzwGAf/Dh8hlv
X-Gm-Message-State: AOJu0YwRfG4Fx4zF4IUxAEBkxXNvdIvOV77ojwy23m44qgqM/A0QxVV9
	bQ9WYtEEbzEDAdpLznvxg8wxlSyJVKXCh0rYybInBqcr6kEhuHzaJsnokmSNItuXhu7hpQf4ELc
	D7XMWYxRbEEPF72FAVkPAupktmCKwgn85H3gROw==
X-Google-Smtp-Source: AGHT+IGx0EtqF24mwZRqfU+d7OwAJMjAo8uBkj9IVIYdq7kjT6pCMEr0hMuMUufGQFu/0P086qoqyzdlDDqlq5KxMEs=
X-Received: by 2002:a25:c5c7:0:b0:dfe:73d8:4593 with SMTP id
 3f1490d57ef6-e036ec454b4mr11736791276.48.1720010780692; Wed, 03 Jul 2024
 05:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR20MB4953D5E7D7D68DDCE31C0031BBCF2@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953D5E7D7D68DDCE31C0031BBCF2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 14:46:08 +0200
Message-ID: <CACRpkdYJCnTXHMwUi1-uhdrBjt=dukyJNGCZM2pLfN+tbw8bmw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: pinctrl-single: fix schmitt related properties
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:15=E2=80=AFAM Inochi Amaoto <inochiama@outlook.co=
m> wrote:

> The "pinctrl-single,input-schmitt" have four arguments in the bindings
> but the driver needs two. According to the meaning of other properties
> and driver, it should have "enable" suffix. Fortunately, there is no
> dts using this property, so it is safe to correct this property with the
> right name.
>
> Rename existed property "pinctrl-single,input-schmitt" to
> "pinctrl-single,input-schmitt-enable" and add the right description for
> property "pinctrl-single,input-schmitt" used by the driver.
>
> Fixes: 677a62482bd6 ("dt-bindings: pinctrl: Update pinctrl-single to use =
yaml")
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Patch applied!

Yours,
Linus Walleij


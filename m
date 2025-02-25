Return-Path: <linux-kernel+bounces-531746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389EA4445F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1877A8E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE4326BDA5;
	Tue, 25 Feb 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMYlqlDh"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93382267B9D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497312; cv=none; b=pQ+TGDXznTEbH0eaZqtc5iAn1gM3ZUvaY6JSUczzgz4ysjZBU7/6tTsNb6NwNHDpsc3/vQJYhsaqHJhy2v22Rl2ZGz8cS2aps4TanvuBtyiTgVuCyutWwmzxnOXgVKgBMWmEZz2djatVMt3vkJr5CQAcZZ9/i9cU+a4J3uf996U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497312; c=relaxed/simple;
	bh=rSEl3QGwsciK3DZesh967er1Ic9Jq5iFZZ00R3tL8wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1Z2a6plEux4haFlmOj+afAiK9XEVllsI5rV3mpl6JJrvUXm3OXe4RcyXQrRQPLsY0NXNPavSeC+Ned6x0Yhw5O5A1Nu6eeFLMWZk8IB6loiFdqj2SiataVvWTNnriJyEYJ4LYwzKedG3//QN8OjjwJJm5a3r65skekd7jpKMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DMYlqlDh; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30918c29da2so61315561fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497309; x=1741102109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSEl3QGwsciK3DZesh967er1Ic9Jq5iFZZ00R3tL8wc=;
        b=DMYlqlDh2WyxTfxyDyYTUfYNUfTLyGIJqFNeFefPtHKUrGzMPMwjki4a3UTnMDQG3A
         nD6sf3V6xWbYEoElXjZQ07t+VVBCXcKIQ3JtudqhfGfbRnAL4d9iBOHpqvwccS33QdMX
         SqZnk26Jy2vIEFF/mjoCOu4/RoW2JV7VbtoCUDjRPBZb9aRzYaGRVGe4jmONRhzZfeik
         P8rYCskQ9aLbpZL++TCghLGUhAxZfcURWCi3CRm0vT2/61l6IVK2ZFojKadipYu/X4zE
         1QRQs66Dh8FyzuqVVKt9Qjw8SAjGJVka12rCCQV7VA3i+xMpdDzr6FbyNx6oP7aZyflc
         pQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497309; x=1741102109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSEl3QGwsciK3DZesh967er1Ic9Jq5iFZZ00R3tL8wc=;
        b=p0y9jxP3Xeylyu5g0Wp6YB8CkmIc4ANXRw117PXuujEJiVIpRrM6Gd5ZwBDg32lA94
         fYam4ENYov31A+kG+ndbYEoOJChBFnjEEWBD4DUQ+fNIvkkFaKlmXpj+PZ7+jd7D1TGf
         KTp98f8T2Mpa5gr/X1+4yhjzCQK3mX6etu+Vm+1rcXi2jdfX5inYq/tzge+CDLkLpA5X
         eIXpLVANtgAseXL04cULaXCInFes4bNWW1A2Rtv/QrXuR/I4zWfTWy7p71kVQD951ibN
         2xBD6VvX0EOqnO/6BqjICYqTLvhlpKeCaEXTXE+/8y+aFz2upNf1U6QXv7OgOD4qaNbp
         qwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7I8QyOcif9C9ZJukP2t3kKfPT4qZkON++AwY5RotdoqaZsaTtMc1veF1MLv5CC7OG0bIZ4GZVTqTQXGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDKj7+fWpxQwPPFCSQ1lT4scbj6qT+x1B/WC05qfLncVXZvwc
	E+x+otv/bRwco+aG91ZJeYJMA1AI+bWq3Yvtv3ZVOKrhnXZygkV+hzlIZLAIjlc9tn/CmDxsSoz
	DbPxgRwCyRtWEltfpIDaiaep8b9JaKVaeEpL9MQ==
X-Gm-Gg: ASbGncvebrhLi/uQm5InvKD5sXALcq+0gOunSkRIGUaz2XvP+A3X8LIM6gLdEvxe94H
	bjfkQ3rAmoSloC7+WVTEr+Hgzzq9XiQW1IIFlChnJN65YI5TMHTRdpt4tw96syEG3icDI2M6YHv
	czImCRArU=
X-Google-Smtp-Source: AGHT+IGhBcI3R96Ygjl+ia9NcJw/ZFQLjv7p2n56sPt5viyPNoWWS80PuvTaUtF7NwD5c1yT/18+krfoAge6OiTuJt4=
X-Received: by 2002:a2e:b38c:0:b0:2ff:e7c3:9e2e with SMTP id
 38308e7fff4ca-30a80c16470mr16634731fa.17.1740497308697; Tue, 25 Feb 2025
 07:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com> <20250221180349.1413089-6-vincenzo.frascino@arm.com>
In-Reply-To: <20250221180349.1413089-6-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:28:17 +0100
X-Gm-Features: AWEUYZm9-GSXUNrjqwaX5LIfxqSFIktvtYAfGG9Wtd97LclpY3yNzhXHmiBivzk
Message-ID: <CACRpkdYX3Ad4PDDwFV-9FG5KgB_55JmiRMuCetVAAhmw38NBHg@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] dt-bindings: arm-pmu: Add support for ARM
 Rainier PMU
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> Add support for the ARM Rainier CPU core PMU.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-181054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EFB8C76D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9301F218E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4773146584;
	Thu, 16 May 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OUaZWwnG"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A0145FE7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863712; cv=none; b=Hn+rO2vWvi57EuvWHcLHJUZfs0gRydvop+79dpr/HvoKmz0YkOCgPWCfdVQA5J75Kql7cTk9JkZa/dskArd0zzWUrMDhvEaMeW8ABasPvpT4z5Qdo4sbo23nv8H49quM4OVQbwqKYRUXxDDYr4QtAyR4VoTmq/1rcTDlZunE0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863712; c=relaxed/simple;
	bh=llODjkQVmJ0JRKqb9IK76GX35Rinj4g9QpPEqkPd/NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoEFyzT0qw5DCWK8WwmNUh2y9UYHIDZAweckReZ+hsraZ2c+8nPabkLwCjM72JduXRisFypCqedyhxrRl2EBj/21KWaYex9WIVzhocVR5SWoOxUrZKwJeLuI1wT79vrZFLZOo+yzdZRRAlyJmlekD5dxo1yv/QxcSbQIgQFdJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OUaZWwnG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6181d032bf9so79383647b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715863708; x=1716468508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0YMZmj/yuBSBh3+Prm3doCFTI5UB0khyraQ6llJYcQ=;
        b=OUaZWwnGukTrPBrYgpPgMd1Mow6UWQwtew+9Lw2/5dDHJlcLL9tb0QMmazNf28brgS
         YcEwna7b+dSvrX4FCaoPzyvRdP6Ow9wEyzh+d/vmvH6HZw4HncO8AKe2hcW9xpTihkxj
         umR2M6/Tzjtk7/vlz3OhzWmtmP45Exk4ZOB65CQEA326cOq2m/AOkvcZY921ePkLIIYp
         Y9o9lunFpYX16TPdWSxktA4sbnyuovQGJC0QrD3J0qHGip46+W9ph4x5GTZG20Y9MrM2
         AUu+pXccdFxqTf+evpQIZ8KUMtSjJAxNBMvUkPq8GwaCwh/j7mMRzkQfBWIjjzqrIZWJ
         nkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863708; x=1716468508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0YMZmj/yuBSBh3+Prm3doCFTI5UB0khyraQ6llJYcQ=;
        b=AOgJjJbN0pYgu4JGGX1MVMKUdv4qh5KaxcPEQKBD2KkpHnTexpZXCkUWD64oigvOkw
         wmo1nguTzgjC6Ry/0v8kcy4lz2HhjYC9yVb1hMKW3sbG/ffbOtu02RICX0XBo0X/vOnF
         kyeRHP0yyiZD1ykwKl5D/xprUvR7hTQKjwnD34oWQ0lrtlTBju0MT18pCHmTRrN74G/A
         PxeViO99E+UnA/qsxXxmH8sQQ7HKpf51rJoCEwwiDaypunXejvzwWxV8CYVOI8EqgtpV
         8RcF6JrLIoi3YhN6QndSiE22djo0BgVNxwyiLTsWn9/+9kiCwQpDh5zNPfFusMsMsbO4
         +O+g==
X-Forwarded-Encrypted: i=1; AJvYcCWaFxIx6nXv8G2FUgTmdZ9HYCW6B+VjCSKj/LolElmr51TBNbzJt7iuF0czlAyUzS6eN3whZpp1sv1eEKEwlKSNZmPXaDMAdI1+FaO8
X-Gm-Message-State: AOJu0YxBGZ2GGef6Ql/3XStCk3wuijDpUcUZwz98BxPvBBZZTRjtqsXA
	iOb8ml6FVD/JaKT8QWy/alxITTD4DnE/cxJdFVN92C04wWBsmWfKZvxTHL6Zoa0DKe1hVaSixtQ
	hB1+7emmNKeyqu460XGywSKS0X2e9ciqduVteGA==
X-Google-Smtp-Source: AGHT+IFmiatJ0VGsQTQP54hpUSwoqwi/xnPZ1Pzr4sv0QEqyqVyV9N5SU92rESBXEGjCyeby+CMydFjJBhLe6iYVziE=
X-Received: by 2002:a81:c70d:0:b0:61b:1bf5:67a9 with SMTP id
 00721157ae682-622affc9c33mr175662497b3.22.1715863708404; Thu, 16 May 2024
 05:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-1-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-1-cb7624e65d82@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 16 May 2024 20:48:17 +0800
Message-ID: <CABgGipU6rybwUo3ZW_RhH5VgWcFqV0x6RTrKAaMXS6=tfe2t5Q@mail.gmail.com>
Subject: Re: [PATCH v6 01/17] dt-bindings: riscv: Add xtheadvector ISA
 extension description
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 3:33=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> The xtheadvector ISA extension is described on the T-Head extension spec
> Github page [1] at commit 95358cb2cca9.
>
> Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cc=
a9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 468c646247aa..99d2a9e8c52d 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -477,6 +477,10 @@ properties:
>              latency, as ratified in commit 56ed795 ("Update
>              riscv-crypto-spec-vector.adoc") of riscv-crypto.
>
> +        # vendor extensions, each extension sorted alphanumerically unde=
r the
> +        # vendor they belong to. Vendors are sorted alphanumerically as =
well.
> +
> +        # Andes
>          - const: xandespmu
>            description:
>              The Andes Technology performance monitor extension for count=
er overflow
> @@ -484,5 +488,11 @@ properties:
>              Registers in the AX45MP datasheet.
>              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
>
> +        # T-HEAD
> +        - const: xtheadvector
> +          description:
> +            The T-HEAD specific 0.7.1 vector implementation as written i=
n
> +            https://github.com/T-head-Semi/thead-extension-spec/blob/953=
58cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
> +
>  additionalProperties: true
>  ...
>
> --
> 2.44.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


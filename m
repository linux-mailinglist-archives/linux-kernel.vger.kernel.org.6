Return-Path: <linux-kernel+bounces-183550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E48C9A85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2E7282924
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13B2E859;
	Mon, 20 May 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnFda0hw"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789424B4A;
	Mon, 20 May 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197999; cv=none; b=CmaPcr1Zf2G2e9sVQ0xxhML6AiLsLEdJIfMERZAiXsrgwM4W24p9JHBUqlLhtELWymf37lG03QqqjbCXBlV3JQaesLjIMcDPM8l5FvMV2l33erc3JIUDAbXuOY67D18+1flTZY9P/GEdR98BsoEcOmCUoPuXGQtuHICX5PnVcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197999; c=relaxed/simple;
	bh=qiB8xlmpcLdNrroFuhShUQxYvOUzN7pauknySfo1KXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQlI7jowzViCOMQWxYScV4Q3W6YGDsoEcafLwat6J2IikdoBN/j6yaaVf6dsv0z8591XXi9GjjPAwx/MTEtT0Yxomt7dfRNqpN/4RqZanYnd/e2xGTGKn3+48eI0P69+FXRkHTarKApWnhd28sF0j2dnNV9JWT9ISlcy7fEtiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnFda0hw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so8026934a12.2;
        Mon, 20 May 2024 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716197996; x=1716802796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE4Bjv61tGt6MfM/w4KNZws90Cz9+Zg1L5iuglgNgRU=;
        b=QnFda0hw9AN5F3vh21vEkwQd8lJmB2gFkZzUAr13+md0NVaqhVEERcNHpWVbAfFZ+N
         PAu69zUV3vhvBI9cOZEYNtRAsQpzyO8T+KTbxMqPLSG86JobMLYDtbfHCKFsfVrRZKtg
         P0jntSY+WirnMlkB3owo8WKYtfTGPjou771lk/PEZgqgegNEiHFYrmdn1qKOXDVhcsb7
         gyjtMkgoSx2xeOddgsKDXqgKPzSl359LVP+CU+DSs7w7qwNlul5nfcSlmgJXa7KpvJHU
         mbmJlnwwvtApDd28M/nIha5J0hOYQ4A8Z3kqdbKWjDnX56NpCovPZ1E2R9aQBDRVTWir
         uTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716197996; x=1716802796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE4Bjv61tGt6MfM/w4KNZws90Cz9+Zg1L5iuglgNgRU=;
        b=Zs9vXU/HiIOj6PjVY6XsBthdPACD2Hn7ezmo3/E0vMM+rk7e2tg7NfnuKZz9ZdKIwv
         kFrSfTrWT38RvXOqxal4+lNGRmqLVyq9Xhz43tOqOpqO0WA6UfK4Nzlh70Ht1uvsG5AZ
         SQxQ9CiwuHVI6uRDOya30ejl1UU+7D1gxRsY1/zQCkqDtX6sVEkwGhNQsa4TMXteV0IR
         3MGdE+kqQgodzg4wcrvS3VnprquAbkrgheN6zbOqk+wM+Eju9kB7hdK+tQv8m+C7NbIH
         4gGhX4EqYWl+plHbTSLVvQVbS2mrHLSApcDVTPqdRWQalM5wejPY2zH1iYu4fr0i1HuY
         LdRA==
X-Forwarded-Encrypted: i=1; AJvYcCVNheAom4QZF9oURL+meG9KHgA2Vf49awiqLpCCmFq0B1Flzol9mJZhwjiBaGfo6wLE6j8BkxUs2nvE1J5uCGPSW6oXuJ2eQAgXsUvAemBC8rDk+E30V1JZXr69dCnEozgmoD1bBw/jqw==
X-Gm-Message-State: AOJu0YxnymGHvnY9UanwpWnPLfTgWmMjh/dl31vuwAXmpX8lofv4mZXq
	JMaHI7wELLGoLYjBxEBMZDIhUlwoyg0gbK3C1jhkS9QCoIsaI8qe6b1SD7d4DFNiTbntBawaNdG
	PAxx8+NO7/cqpMk5l5K1yWFyxFMQ=
X-Google-Smtp-Source: AGHT+IFTjPcbAOBoZPuDA+2ZVhZiSxbh5DItcS/p4qaB3QtONbnWddERDXFwXh2FDVKJSw9VKN4cMxjpfjWNaBqlbQ4=
X-Received: by 2002:a50:f60d:0:b0:571:fc6b:966c with SMTP id
 4fb4d7f45d1cf-5734d5bec1amr18121585a12.13.1716197996125; Mon, 20 May 2024
 02:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
 <20240519175906.138410-3-kanakshilledar111@protonmail.com> <171614715439.2941344.11264816105918092609.robh@kernel.org>
In-Reply-To: <171614715439.2941344.11264816105918092609.robh@kernel.org>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Mon, 20 May 2024 15:09:44 +0530
Message-ID: <CAGLn_=tLdJU1F-i9YV5aCZQbS0L7y7Wu+_k6Dn=6HwH5JmZoMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Kanak Shilledar <kanakshilledar111@protonmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 1:02=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Sun, 19 May 2024 23:29:06 +0530, Kanak Shilledar wrote:
> > removed the redundant properties for interrupt-controller
> > and provide reference to the riscv,cpu-intc.yaml which defines
> > the interrupt-controller. making the properties for riscv
> > interrupt-controller at a central place.
> >
> > Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
> > ---
> >  .../devicetree/bindings/riscv/cpus.yaml       | 22 +------------------
> >  1 file changed, 1 insertion(+), 21 deletions(-)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/r=
iscv/cpus.yaml: properties:interrupt-controller: 'oneOf' conditional failed=
, one must be fixed:
>         Additional properties are not allowed ('$ref' was unexpected)
>         'type' is a required property
>                 hint: DT nodes ("object" type in schemas) can only use a =
subset of json-schema keywords
>         from schema $id: http://devicetree.org/meta-schemas/interrupts.ya=
ml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202405=
19175906.138410-3-kanakshilledar111@protonmail.com

I have fixed the above warning.

> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.

Can you please clarify this part? Is my base commit ID incorrect?
I am currently using the 6.9.0-rc3 kernel version form
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/ repo.

Thanks and Regards,
Kanak Shilledar


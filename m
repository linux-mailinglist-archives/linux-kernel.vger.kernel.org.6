Return-Path: <linux-kernel+bounces-345860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0853798BC0D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993761F22A78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA91C2422;
	Tue,  1 Oct 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JleF9r8C"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5DF1BE23E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785659; cv=none; b=NewayuYPDUYjOXE3kA8GC9unDdNTZAWAySJAJqxOFgCAnzEOaJGdABGPnQy3ywYzuQDq/4Fk5IfMiedV5r6MJZIDW+t5G8sg2tMk8+QHkvdd62YUa/jlOzTS9cIhwuQRHV7OreLRwnoA6Aft9x4wnNg/FosF8rlw/04mW9duBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785659; c=relaxed/simple;
	bh=SoCurHIkleGhUTp4khwR0zEhKLpu15VK4lI1dWVteZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J72DZU0raEVlSEB61a495kDdJUoC3oWjWzdU4RxWYozBEMsCCp4sKaGZ8Qgz2scz5wawNfNJP+3dfquhQRdI7NMvlnuNDqyWu2A9nz4uZjisNTuvVk2Y+E1c5LZWwomrQxKeNbdZOolTgdjY6Eow1VuHhGZ/6vnXZDDHw5lpn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JleF9r8C; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53993c115cfso2601557e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727785656; x=1728390456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoCurHIkleGhUTp4khwR0zEhKLpu15VK4lI1dWVteZ0=;
        b=JleF9r8Cgi9SbBqVu55NMMmAoISmLTy0hHRyDrs6xJgV+eVRDowmb0NJmyMZQyxW+N
         CZI14fImA0403beZLe8mdGEAdZ3UV8JjR51ywik9gPK+N2V9blYDdnMl+DUQ51PD7diZ
         +pwARflZ8+DC6UNJqGdb821COFI3wNKtJHoEOANmTIfX9XdbHvRPLWRcvujcSrQkFQas
         arkNUQq+pzqX8BU04co41pNJUhxkAb0qjvXwAEcHpPoj/1/3/JRun5OKwgjDXCep1YdU
         //TyyJaKEDVSBvj7+yuZq8YlF5repxzxKGMvaQaWL9CAptFaNBq4xhN/e4gfNaBJcvHz
         NyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727785656; x=1728390456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoCurHIkleGhUTp4khwR0zEhKLpu15VK4lI1dWVteZ0=;
        b=M7k7TXez6WLUIH7VOqpuvU85VU5xRsHOmWVK5mJyNd78+aOMu9LezhluwF/P7QvLqZ
         aiL7Ts9a6nLVDHNDCAVzXhcM3lU1w+Se2fV6KeB8EDp7LQWSfYH5iiS47Z2cW1PWTZoI
         VQ/NS1kHQF5Sl6MmozZnq7ka9gMPgAchDa3tr6LKzHBkHX+Tz/PdwPau1PYmcxRDnTKT
         RqmpShhHKyVwnltH5eLV6KikJrnTkYowSZr4KyJSkF+2zRYxW9kMNPbrX044ovE/w9Pc
         vZ3K8E5aNxyvQ6RVHQ7A35T7BHrnHCob6AVWjW9FmJKYbx1Im/8wSdyjJPlAhBRHoolv
         ZXYA==
X-Forwarded-Encrypted: i=1; AJvYcCVmo9bmFDfNFIBefdzkg6FbcZaQ90hDVC3bRJb+kPjqrWJtlCJY4f87rTTG3PVkGmb6i9dCjl+Jfm5Czmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+lLNGXyDU9SK0proecbVaFlir/Uikj7GKLFl5MdRjSBad80m
	kdGLf6wqEiQvU3ihcms7RlN3QqwklrqChdr86ss8BEmQOxITKWyWcgLzP/EZQFVE3MZzwydewh4
	63AaGu0JPmX6sd8R/7cdMk0a+FlxkGJ/EVq75og==
X-Google-Smtp-Source: AGHT+IG8TzlpP6uZVriUb03XpH7zYmc6S6jIBvK4noZhBbrXE9sWhgUKi4i+nF2zm0Fpa+WkCA4CyjTFVSaUXh1u58w=
X-Received: by 2002:a05:6512:3ba0:b0:52c:d6a1:5734 with SMTP id
 2adb3069b0e04-5389fc3ad9bmr8742854e87.14.1727785656074; Tue, 01 Oct 2024
 05:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-k230-pinctrl-v2-0-a9a36fba4b34@163.com>
In-Reply-To: <20240926-k230-pinctrl-v2-0-a9a36fba4b34@163.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 14:27:25 +0200
Message-ID: <CACRpkdYk9aCp7mdWJJTT-1cwNZC4RN_eB6v5rducDY5MGJ_dbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add initial support for Canaan Kendryte K230 pinctrl
To: Ze Huang <18771902331@163.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 5:58=E2=80=AFPM Ze Huang <18771902331@163.com> wrot=
e:

> This patch series introduces support for the pinctrl driver of the Canaan
> K230 SoC. The K230 SoC features 64 IO pins, each of which can be configur=
ed
> for up to five different functions.
>
> The controller manages the entire pin configuration and multiplexing
> through a single register, which control features such as schmitt trigger=
,
> drive strength, bias pull-up/down, input/output enable, power source, and
> mux mode.
>
> The changes have been tested on CanMV-K230-V1.1 board.
>
> The pin function definition can be found here [1], and most of the DTS da=
ta
> was converted from the vendor's code [2].

Bindings ACKed and patches look good to I applied patch
1 & 2 to the pin control tree.

Please funnel patch 3 through the SoC tree.

> prerequisite-message-id: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq=
.com>
> prerequisite-patch-id: 704efc6e76814e1877748959d7319d558c8386c1
> prerequisite-patch-id: c2144cf468c57b856830a61615ba6ba501e8ec58
> prerequisite-patch-id: ced4a01ccd8ddab2fd308d543ddf47bd1641518a
> prerequisite-patch-id: f8b983b301d0c14f1448b9e4c321262a509e061e
> prerequisite-patch-id: 834b65b6a2b037daed5cffc6a41963622568dc9c
> prerequisite-patch-id: 2401703b57448c9ea2c3dc7650b4502491a28944

I don't know about all this stuff but neither bindings or code seems
to contain anything that won't compile so I just assume that any of these
dependencies are purely for patch 3/3 and I nothing blocks me
merging patches 1 & 2 so I just went ahead with that.

Yours,
Linus Walleij


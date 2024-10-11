Return-Path: <linux-kernel+bounces-361756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075E99AC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3BE1C24047
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114AC1CFEA6;
	Fri, 11 Oct 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKYCAS/z"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E81CF5EE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674906; cv=none; b=klBY44j/PVVvbIB/nX1B6q3KQaaYOzd2cqJecsUXgKtFw4leI64i7kfCcIJOXrR3P5PFIP3ofPcsMnTOfG53JL3ZtR1Fy6Au2kZxm9kYkjoSN0N4Bvi8JadNlDNiLOG59+o/LToXLhC5x8/mtmo+G9WeFimJ/cJVlxzBeO6tmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674906; c=relaxed/simple;
	bh=bCrM0ifBSlVXk6QQFecaM58N9s/5IKOpuSb72C4+e6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNnwr0WFfBlyCHBaHxDPZ3KE7pHEu/2O50joaSvXSBEfSE2SQ7zimXEm5Av0fehuOzN0Id5ZVnivvnyxG+gGhrUnld3SzwUSo6dXhcjTxFjo+dyDkiULEJzcoQlOlsyHWbwkHOlyDUnNedoRpkDyqSu0gPmn4m2n9sjc1TbfLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKYCAS/z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso24436861fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728674903; x=1729279703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ib9PFYzvaqKheX8msfR0z/jz+7hM5FTJQOY9PaaT2U=;
        b=eKYCAS/zPP/DNP4X/TYDyaorgM4AZaaZpUZd4L2tGiTitNFjjCG+WaUQhUV4AnNlR4
         eYFc8sbeK/vLeJrti4B3sdBxY1KePFaBK3W5xD/axS/yvHqR7yP705fyT+mxpuHlv3Gi
         g3r32GphcKtWC+AUJ5kh+qXgsYUuhfgqnpgWLAmGvM0MjpqerTzrRWhFfDIOexO1i8hL
         uXfsz1PBn0tw76/MYqikGNHtIVIhW21vt9T4nF6TZl4qexxjsrI7zbeQ/LWlpLNzgGZ3
         x6ci16cWbC9/7C0yzuAX0ZQslnBOTCjSf9jBUYh/MPjKqYdtgpEk/p4peNXDdMa/tRjK
         Ymbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674903; x=1729279703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ib9PFYzvaqKheX8msfR0z/jz+7hM5FTJQOY9PaaT2U=;
        b=webIa+wKYXMITAh+8u5/dfz3P3UwxVFioryuReIBoM5R0T2f75D7W3IfcFUNQ7QlPz
         vbB06N6Md3RLTinU2IdKV5wbX+UdktKRXpZasGSJIQiJEf+kQaAp1ZIAlqdVaMBWdmxe
         M4E6iBaRoCJJoixL2oNcL68Om3ta88i4NuVRSB0JXDPBCMRWByeU3dS9l//9hXU+8q5f
         CWR1iIIm9olxQFvZUPGs627Rt/sh+WGGCdWfGuaWHaQdlRSW75RLlvKMYmq6rJWWOKYp
         ptnIG00frT/DNmMmhSChUoL1DiKei1f1q71xUgHR9ZM1UNjs61iIClCgJH2iPvYq1r6P
         FqFw==
X-Gm-Message-State: AOJu0YyD/AfpQfeIyfYUkcpbdlWTy21T1IAzf2a4MdZICUteLksu1G3T
	BgLWRJIXMHw9nK5BqKk9Xskl0AVQoxQLuTWyG590fd6OSTYcoaSKyhKuDxgvXtr/xn9rXbAsjdK
	z5Dx/CvG5amZZsQrt7jY76DkM33hhLGEEzNPSXA==
X-Google-Smtp-Source: AGHT+IHlWWYZkL7hRcimo9K372QrNGbFn3mXFWV+V/AQ1PzC7xBBqLXpG6DkMtKk+v5931tSyYIzbc46u7Y3dONqlR0=
X-Received: by 2002:a05:651c:b0d:b0:2fa:e7f2:764b with SMTP id
 38308e7fff4ca-2fb3f2b0d19mr4483581fa.33.1728674902415; Fri, 11 Oct 2024
 12:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
In-Reply-To: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:28:10 +0200
Message-ID: <CACRpkdayc=5ee_D-t_xpOe3hSNHKDYN63J_6WO0HECNUH36hrg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] pinctrl: th1520: Unbreak the driver
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:48=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> Here are 2 important fixes and a code improvement to the T-Head TH1520
> pinctrl driver that was either introduced or missed when Drew took over
> upstreaming it.
>
> It is based on Linus' pinctrl/for-next:
>
>   6dbd1577b7dc ("Merge branch 'devel' into for-next")

All patches applied!

Yours,
Linus Walleij


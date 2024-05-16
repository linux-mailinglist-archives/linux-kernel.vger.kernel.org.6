Return-Path: <linux-kernel+bounces-180860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A9E8C7408
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D561C20B64
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7938143868;
	Thu, 16 May 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiJCit0q"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02754206C;
	Thu, 16 May 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852691; cv=none; b=ER6MBbgvkXSojk11y4Mu2PTdqRC5V8J8BePnIz+YTIQcIaX6Yc1QbXqZB6eX8XONUrXsLJrvzbtF6QFN5k2898KLNjbzeewVSSxJgZ60Q+8wk4lchEpFP6+1qLaIou5pdemMNuj0uecWyB8Qq7T9v0u+bqJgc3DkiXbwGO6vBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852691; c=relaxed/simple;
	bh=Mv4lNrglqS4nAOAX/673bvBVveCRgVuJ/fLlNsqmFkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiOlo9gfQQyHNXArjd254twrqCphuQYot6wMyGaqVe7gXF2nUfxh0imNfPgcHZffjTux2Ztvzi5PujOgryxtnGGcX1DmqEyxm2BFCuXBCRgMnrwCdHsgjrD/F5bAMzeI3LLuQ9FiMgR7KVRQGkdTNy/OoAorjAlVMnCTxA9PnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiJCit0q; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so8054877276.2;
        Thu, 16 May 2024 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715852688; x=1716457488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv4lNrglqS4nAOAX/673bvBVveCRgVuJ/fLlNsqmFkY=;
        b=iiJCit0qk7w3p7zytFdclCSYDlrMSZbeoyhUYKtq3UcuOZyUunyZYFQMDqrx37NKkx
         0Yc3cUfh/3L+UwXAxuZQbOglFrugy8cSjzt6wj6sVOZtJaavDYDGL6V/5I/NMGrnHBuR
         Lzgp9z2rzYdvfAIdj6YQM0dLeVbqME/OF3e+G+n9mtVnfyvo2z+s+SrfyXVfyre6tHqc
         Z85HjN1gOp1kBk3cK7nP0N8Mzkf2XqjIbgBI7JIQCVS7yatwsGxD9EMP/JmPtI2qaH95
         4lfvcfdxdoS7RtX1ajs/GgsB/LrIUnk501YWfpImB5b+bzRL6f6MA7Kdm4rY+NJ9wX6o
         lTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715852688; x=1716457488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv4lNrglqS4nAOAX/673bvBVveCRgVuJ/fLlNsqmFkY=;
        b=qnaQT/O3kC+Z3fkTeoYn9sTgig3JG1k2xwtKmMREoR8pddttz7Qbhtw11IUNWlvBmZ
         H4bnD+LfGmArlX5wGASmHJAlpLLg0tjrnGIBni77TpxXpBT8pSGTUVS0Zebumt8gRQhi
         +eHlFT19ozZob36qKH/nqG4RR+RaOMIBzw/81oO+05KjC9nwzidtJXM9s6nyjQmf9A54
         bJsDOhUTFbt50g7C6WKg1HlYoVxLnIo2F3AO0Bujv59eQ9u2OiYh/HDN09hxtdQ+6nEo
         ylxX/2CGGKqWGFNGBV79WrZYT1In8AdgFueYXTpYqpmfzuf5HPcXYVqaTfxi35oVw2o9
         dwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUU9BOrXfQIDyWw1fjWhgpVU8WYLQB3pu1M7FytGVqTajd+2blq2aZhAQB8DS9BcoUhTnlWPekFuwwOY8CdbnHLOrhXCcN3y5KcbtukXuo4xIXzBCKWbzYghVJqUntEa7r0MjcpQnfu6fxu8VILrVJBmMcQVxvXZhg4AZURgz+JSO54A==
X-Gm-Message-State: AOJu0YxIQK3CiHbDNSXyZMK6b6JboXWu69LIi4wnyx9GCMxHFibqwIrz
	hsJiKo1D+aJyHiREwyQIh9vnkGfajlfzQro4t/oG19Dcotia6b/clnEARWJOi3SfuzRKmbnKeHZ
	hipXw2V9Z3Dn2JIU6KgAJgeZAmlk=
X-Google-Smtp-Source: AGHT+IGt4GOJGeaaemGwA4Ckt+18xxZfU1hLBTK3dGN/PrXCsjugWmUU80kcg1X7vu7MfI7i+fk+lUadWbYn6YM/PMQ=
X-Received: by 2002:a25:c70d:0:b0:de6:4ff:3155 with SMTP id
 3f1490d57ef6-dee4f2dae9fmr19813993276.16.1715852688597; Thu, 16 May 2024
 02:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509192411.2432066-1-tmaimon77@gmail.com> <20240509192411.2432066-5-tmaimon77@gmail.com>
 <20240513155330.GA2676859-robh@kernel.org>
In-Reply-To: <20240513155330.GA2676859-robh@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 16 May 2024 12:44:36 +0300
Message-ID: <CAP6Zq1hRw6xfNKKfBFGuKbZk0su3ys6+hnMzqRWrZeKzDoKLEw@mail.gmail.com>
Subject: Re: [PATCH v24 4/4] dt-binding: clock: remove nuvoton npcm845-clk bindings
To: Rob Herring <robh@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for your comment.

On Mon, 13 May 2024 at 18:53, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, May 09, 2024 at 10:24:11PM +0300, Tomer Maimon wrote:
> > Remove nuvoton,npcm845-clk binding since the NPCM8xx clock driver
> > using the auxiliary device framework and not the device tree framework.
>
> Again, this is an ABI break. Changing driver architecture for 1 OS is
> not a reason to change DT.
Is it an ABI break even if the NPCM8xx clock driver hasn't upstream
the kernel vanilla yet?

I thought that since the NPCM8xx clock driver hasn't upstream the
kernel vanilla yet and and in the latest NPCM8xx clock driver patch
the NPCM8xx clock driver.
using auxiliary device framework instead of DT we should remove the
nuvoton,npcm845-clk.yaml file.
https://patchwork.kernel.org/project/linux-clk/patch/20240509192411.2432066-4-tmaimon77@gmail.com/

>
> Rob

Thanks,

Tomer


Return-Path: <linux-kernel+bounces-234435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E691C6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FF51F2567D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C1F757F5;
	Fri, 28 Jun 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2llm/2b"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C496F2EA;
	Fri, 28 Jun 2024 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603138; cv=none; b=DKXSCvc7fsYC6cfCfHIcRg9qczZefRkZUydi62QsIQDHn59CvRREHTpjoRC0HM2dlbOaBx9hU6/tfRHqHYhsxNyPEBFws8TxAgmCT51je8FI0hV/I/2cnk6JjCAkCqB0rBvjMt+H/OplUbQYj6W1wIlRhvfUHaXtbPRcyoxSduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603138; c=relaxed/simple;
	bh=PxckOsAOkmt2Z/dhIOH0h8pCT8yqSu788yaL0xNxpAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szFzc9uES+Qp8QIypGF+DbXVlOwgczmdO8smMTI+7g+JxXHARCjdmBGwdtVFikh2ZZe46oCWP1Jh/rvnKypHSEZJ4gGgRxu/qHDWDxumNjaZSRzWQbfZfZTarUVl22b1x/fajBUCc25DKrhels5FYdQuX1J9hLxYvIXBs6/a2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2llm/2b; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a724a8097deso119598466b.1;
        Fri, 28 Jun 2024 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719603135; x=1720207935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PxckOsAOkmt2Z/dhIOH0h8pCT8yqSu788yaL0xNxpAg=;
        b=B2llm/2bC9v3seUx5RvEi4SEBE7Bl/Mz3zmR0t4jAsjYrXvjvoms0bBZHs5kB8wIka
         CSK5IW04CXJacJxWAtMfOS9NZuxwyYnqJDc3GcSB/Rb/zf+bpLGKYZXLsM8kATOJZxWe
         o8x7m7Hsj45PSaTW9rfVi3nJIGsyKvrpbHSbL3ZgCcemE1mk3+uaq7uJT6O/a1O+/fqH
         CoNYVWfcpzBh1tVQlN4f6lYQ8xdvxV3x3UFqbWxxSr0rZtiRwOjtmyZqwQ/DSdU2pbCE
         nL6xz7PwXPsWzw8Dy6TjYWGGl7fUYaTC1+RSwfKM9HNFy00PXUxzbDb3TDC+5evnq/wo
         rBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603135; x=1720207935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxckOsAOkmt2Z/dhIOH0h8pCT8yqSu788yaL0xNxpAg=;
        b=bQkSrrbJoGjzyeaoTC6NUP7A8m7W2/JlT5cTLZ7w76UVnZIQIqX1JygZoWOUJ/1S6s
         tQa5QfDZf7SroesdfyqEF8dLW33Y1Tk8KF3xsF0/4Wj9v0jXCMV4vMoz28wyM+W58i0O
         q6Q8pKC1ixb3X86+NOCwJix/QPmOixCWgqoiF6FOXq1L2PwcCDODzi8h+E+D4PhmtF8W
         RNgem96TkQDk+pu946v3FqeuH/Y42o5UaHd6MahBdIpVuiDH/T/+mL8itiJGgkHDOwiR
         LviMWjdGgMQexFeL2KLJ0+xlXWQ+x45Jcn+nQ/KPpmr7YNAaCuOR4iaO9HRXA1P+55/2
         4qiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh3qHRxp4dFfrhQlRLzOX5yb9MqYWr9eVN4+y+AnlVbHhUe2IEdAzVdLjpugrCrX6Ys3Fbf6iULHF8mEYvrBz7DZQvsOmjTP3OqxNEti92h9/TnFazYKeuShbINzdOXVuyx/RxBR6vEQ==
X-Gm-Message-State: AOJu0Yzlp/xiELyxtjtNAaZUVvd3gfHcPPc/gIN5vKZQtb/CWnI+Nh85
	VfzTxDpKqklDUAavxmhyFy0w3539zqQT96WBujKwKuLIwJlhn9iaAw6JqVt44E8OzZ3osznl9c9
	/lApiUPHnp+jQRqdXrU513SXgkg==
X-Google-Smtp-Source: AGHT+IEcIJk3aOEVCfHZaTOBEzliwOv1OW0IgkYWVgv3YyCrG+TRBh+fl5e85vwIPrct8FMab5SprzZALrLoAgdlAkc=
X-Received: by 2002:a17:907:c816:b0:a6e:f594:a292 with SMTP id
 a640c23a62f3a-a7242e119dbmr1458130966b.63.1719603134625; Fri, 28 Jun 2024
 12:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628140328.279792-1-erezgeva@nwtime.org> <20240628140328.279792-4-erezgeva@nwtime.org>
 <20240628-refuse-actress-b76985aa020c@spud> <D2BS0YMA48BG.1PEPFC3KMFV8N@kernel.org>
 <CANeKEMMrXK=mw=n=9DuTnprkTs3ct446oaC2QTJyst8Nd+D6rw@mail.gmail.com>
 <D2BT0DT9UQ66.2L497FSY7GMAL@kernel.org> <CANeKEMO9hBhBs91nZkZRht9J29iRC2Tgf6ucWq=nbO7XAqzzng@mail.gmail.com>
 <D2BU69BDUOL0.63A7T034CORP@kernel.org>
In-Reply-To: <D2BU69BDUOL0.63A7T034CORP@kernel.org>
From: Erez <erezgeva2@gmail.com>
Date: Fri, 28 Jun 2024 21:31:37 +0200
Message-ID: <CANeKEMPLqdc0iKPcD5d16r91tsbKZwZ0getq2gxOhc42sdu7Mg@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR chip
To: Michael Walle <mwalle@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jun 2024 at 19:45, Michael Walle <mwalle@kernel.org> wrote:
>
> > What is the kernel policy regarding obsolete flash chips?
> > Macronix annonce on end of life of mx25l12805d in 2010.
>
> Which doesn't mean there are no boards using it. But EOL in 2010
> might be a strong argument to remove it. But I don't see the need
> for it, yet.

Fair enough. That means I was in the right direction.
Just need a better description for the patch :-)
I'll update for version 2.

>
> > > Also please have a look at
> > > https://docs.kernel.org/driver-api/mtd/spi-nor.html
> >
> > The new mx25l12833f supports SFDP, the obsolete mx25l12805d does not.
> > I did manage to read the SFDP, though I do not have a copy of it (I do
> > not have the hardware any more).
>
> So how would you test newer versions of this series?

I develop the OTP callbacks with a mx25l12805d for a company using it.
I am no longer in contact with them.

The testing can be done with any Macronix SPI-NOR with OTP.
I did not check, but I guess most of their chips have an OTP using the
same opcodes/methods.

At least mx25l12805d and mx25l12833f use the same.
I did not add mx25l12833f as I did not use it and as it uses
asymmetric OTP (the MTD supports symmetric OTP).

>
> > To my best knowledge SFDP table do not contain information on OTP,
>
> That's true, but we need it to detect flashes during runtime in the
> future. Imagine sometime later, there's a third flash with this
> exact ID, then we need to have the SFDP to figure out if there are
> any differences between yours and the new one.

Sure, as I said the mx25l12833f does provide SFDP.
In patch 4, I removed the size property to force the driver to read SFDP.
I was not sure about the flags though.
I did not see any difference compared to using the setting of
mx25l12805d without SFDP.
Yet my focus of work was the OTP.

Erez

>
> -michael


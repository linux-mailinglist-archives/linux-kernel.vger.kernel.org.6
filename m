Return-Path: <linux-kernel+bounces-512778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C356A33DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AA11889FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D027521D3DB;
	Thu, 13 Feb 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1V3YuFw"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4521D3C0;
	Thu, 13 Feb 2025 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445497; cv=none; b=PKdh6UYYgIwSpdDbl8y2gkFRj1jNvL8LZH+b6zKh5siLgQLr71i/LH9Adq4cAmI4Jxs3oiylBAahfG/BQvZOxMuaWAgVUwNeAHuATTSu0jbKE61rY3ZtGCJUndcP5HIwrazoQUdPi3NFMdTqeKeKfIYVkN571jcXnqjikuyl4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445497; c=relaxed/simple;
	bh=9LpzrPq1k/DfBL7MweeRVJA4rDbePodzUAIyyC7lXQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuDuOSJ0gbQfWRyXQoaxgM+6B3F0W40WDDsstz7GoqgIFMGdeQEdDgdcY11YY8N8fFnMePl8pEwW7k0XJ0amiHkeN8w6bdbtMIlIwcQXf5/2moCrx1ohv400Xdu4EAlhpwNe4xS9AitlCjYdyUWfGhOxMKXIJQMvy/iKNLHV9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1V3YuFw; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e4505134c4so10387026d6.2;
        Thu, 13 Feb 2025 03:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739445493; x=1740050293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWa5V9+gOF0Da18gHiRuUCSUVEFQiY42ni6Co3x+yiM=;
        b=N1V3YuFwDjoayr/IXx61Y8Q6jzgNK7a0LTc6sOVkOAIGwbiy8y3oH02rYskTNIFlc8
         wIOqcTTY4Bv4IFH1BX4jZ468OX6EMviEX5xL2V/ahb8oN2xkyENICTFytAZYgcKjaovK
         tt3KaCPEdJ3JLWqAuRh6sv0JLH1WRiOX2FVjOS2/exIpzNvPxbCLTCZ/MnZwWM7gwCNn
         kwkrT0+EFfaNpmD0ujQWhffln33xqLpJ7djnZS0YCipCURXf8zVNwveXVAJzq0dxAu3u
         M7YeQunSl20qu9rBmaYuDai9gvf8tJ4MJOPCBzLwA3GDJm9cODwNmZvLiJh+EjEBLXoj
         XKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739445493; x=1740050293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWa5V9+gOF0Da18gHiRuUCSUVEFQiY42ni6Co3x+yiM=;
        b=uOPXT76RYTGJEufOposJm+Et+Yp/daddKen8ye1BqDqzHg4wP/VkaO5x9T+xCFbfXP
         X/kMlYnDi9FUBhja1qAw+UFfIoU92dhzdOh7/oc/7r546Rjc+o3njFvw8CNDf6YMan5/
         vNzxwGAvLKFuIKU7muujR4mwbL9TTU78yF+KhnhA/VHOmu56oKqIEFejFVaRNsaGN+0W
         o/ulz6blhInZ3kGkZVMsOezdF+6zUdRmJ16DoV3gg77F3fIVGzoxret1tM6u3rxj2PNq
         ay82ssh/r4N/NvLwQ2QLmFpYrAtINiY1r4q46JyIuvQTr9CZUdLbOpkaErpl1Hi9USpB
         lgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu0armwjBjF1wL98ApZtfh086wtFAIm9ODaf6VlQnr9gwbwUPVrKQNC/OuQCDOojJxIrDz0+X8iW8m@vger.kernel.org, AJvYcCXb2JwsKj5SlW1+DGv4y8oHACbghiAAAKGNpXBf53gkkjYEnaIFYhhwnJt++a+nDyUgCRaEEssUth2TvxjL@vger.kernel.org
X-Gm-Message-State: AOJu0YzVr3lcQPLUa2n369wF3yNGd+o2XuIrDzHeIQ5EKa0b2/i0HcBI
	lJ+ViKNgCpy0zHdZVT02E/BGCc+iOrqeh9wROXStN5tVLiZVlYfz
X-Gm-Gg: ASbGncu0u+zSGuLwsz+zr0I4M/qXIjZnnPpxaIF4UxmreL0P5kGzamY0dX/ChPACH1s
	iHEb/rEijlMtJsxVvLQSbO8ze1vRtCH8MFuSSaSDYNp3SMUkQ2w5N2OsPxt49aPiFtjMO9rMFgm
	pIQ4oMqbGHSKvcf2o81Q2UUsXQkju9J8wPoKgoe2dYoQQSfasUMPszCnNTbhIgfoFSOcZ9IYYso
	ul6HhQH6AFAZjooeCxW5I6VUAV1SVD17/E/Q84NdoP3tqS0UzeQdnm1A2OpZCYQGFg=
X-Google-Smtp-Source: AGHT+IFLRibe0XYKyIJjpp/EoUMufvpGHOsU5BVQtHPrYtw6m74u8WCyHY1uY/X0uZMhys3D7yZtUg==
X-Received: by 2002:a05:6214:5655:b0:6e6:5ede:7d83 with SMTP id 6a1803df08f44-6e65ede7e93mr16129926d6.25.1739445493556;
        Thu, 13 Feb 2025 03:18:13 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65daffdbbsm7895126d6.99.2025.02.13.03.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:18:12 -0800 (PST)
Date: Thu, 13 Feb 2025 19:18:03 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: reset: add generic bit reset controller
Message-ID: <j6xw7cpk4mfggonh5dhqz7dqj7abo75sojaann5pv2uar5en67@sdo2ygvttzqj>
References: <20250213020900.745551-1-inochiama@gmail.com>
 <20250213020900.745551-2-inochiama@gmail.com>
 <20250213-cordial-elated-grebe-57aaae@krzk-bin>
 <619128481807b279e5d3b7967b00e7f094dae7ba.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619128481807b279e5d3b7967b00e7f094dae7ba.camel@pengutronix.de>

On Thu, Feb 13, 2025 at 11:22:07AM +0100, Philipp Zabel wrote:
> On Do, 2025-02-13 at 10:35 +0100, Krzysztof Kozlowski wrote:
> > On Thu, Feb 13, 2025 at 10:08:54AM +0800, Inochi Amaoto wrote:
> > > Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
> > > a simple reset controller by toggling bit. It is a hard time
> > > for each device to add its own compatible to the driver.
> > > Since this device share a common design, it is possible to
> > > add a common device to reduce these unnecessary change.
> > 
> > SoC components are rarely that simple and even if it is just a bit,
> > usually it is part of one or few registers.
> 
> Yes, in those cases (which are probably most of them), I would argue
> this binding doesn't really fit.
> 

Yes, I agree. 

> > Anyway, there are already bindings for reset-simple and I do not
> > understand why this has to be duplicated.
> 
> I think the motivation is to not have to add a new binding document and
> modify reset-simple.c every time there is a new SoC. 

Yeah, this is the motivation for me to write this patch. It seems that I
describe it in a wrong way.

> I wonder if some of this can be mitigated by adding just the 
> binding document similar to trivial-devices.yaml, without the
> actual "reset-simple" compatible.
> 

It is better to keep the original compatible. Adding new base compatible
will break existing device and make the migration hard.

Regards,
Inochi




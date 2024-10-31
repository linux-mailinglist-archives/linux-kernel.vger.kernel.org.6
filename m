Return-Path: <linux-kernel+bounces-389991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB119B7432
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCCD284F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0F13D516;
	Thu, 31 Oct 2024 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaIp+rbQ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB88C07;
	Thu, 31 Oct 2024 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730353562; cv=none; b=fUkwxdCz6E67yeR42Myp5mcwkMoSv9xJ7qiwrOJASyCpUSEusyjj3qnEk6faunZgyY8sM3TVB9cvKmJi6Xcqte5v5/eHtCEJlRb0Cp3G/IJtwa34nPfaFBI40QGGLV4UDWVos0z2rhFOZ2ejnf0OIgjGmGp0NNg+ZxBMsk35hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730353562; c=relaxed/simple;
	bh=SjVRbND+f5GCJ54JlQz7detYMvwGROj3WUvHjTFiTVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8DwRqynKX0emCLSBUQtqGqOetpz4YjqR93gfy5ifMrzp3Vu/mchcFllQ75iEC0CZjH8EHkcFqkYl4L1+1i9d+VMBJXp0pW4SV4EvvptgBMTjJKpwkDq2qDGnGov57B8p5gSXCAJI6fk9oMyAPhbSC1Y4KpTZnUP/gF4iHo1EMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaIp+rbQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e91403950dso428268a91.3;
        Wed, 30 Oct 2024 22:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730353559; x=1730958359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9b2UEQxs0odyhfy9TOY1tUz8U+i9PmL23XX2DMzkGI=;
        b=CaIp+rbQQIlv4nyM9oBNqGCzckLQhAg4afmqfeKwA/sJ3DLmpjLS6zCuWkmmrJl9gU
         NdoSit/lCaXHnMoWpyE95fvF6Nfl5p2AFZt2ylKjqMN4kWAWgGKjU+czM883551LehLW
         LP7VPy2ZBBEu7Y3SzB5zALQKDV2DyX+omfiEKRybRzqJJn6sWwWTBW1/Ez/S4gud6L1l
         31zAiNdVfeCMn9gb1HrfPhW3L9BhPT0oc6+T3sGqNT1QbkB8Iu7G48NzNl0myGGZGyyS
         nW+vWiQuPHMTMxmZLbsgS/uVDJQa2sdW4qN4TjddHxni4phiCuaRSAi+qMwAWow8EEuX
         yLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730353559; x=1730958359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9b2UEQxs0odyhfy9TOY1tUz8U+i9PmL23XX2DMzkGI=;
        b=Uo2XLU2rY1dxzrS4WOnhS9xChYUZYbJaPWtx/2Npu4SwtkHTBVoMEqmPp5deq60jg9
         Hrahi70J93JdJU4pj21X/BA58ZESY0RxdB8hV0OYc+GDQNkDWTIT1/6URJ97TbJE1hHP
         StYO+Nxrwr6Sv4VOdDlzGkaIsNWjrZtKDJoxcRKTEnkijNjDr8yYTUcmYd4nWJCH9Wbj
         lq/D1VPBVcWvs0PIrV7pZETVU3ovX5mfi/83PRUHKrlQOrv2fuaLJnnyawJIG77psllS
         90RJP6RlDKeKbX7PcSdtvygauFhMHgqCwfdA5LlQpBSwHru9lJDgjWDDhVgT6/68fc2j
         L8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVeXK7z9bgS7qOs9nMQiGpiXAFwL7zQf6iebNTJrEucw0Uaog4q0V08cx4pxgAZu+gpSfGG6hXV5H0J@vger.kernel.org, AJvYcCWfLyNttexh4jSZVh27+N697/T1a7QTvST7SlXvokeipU1gyvFWSpeGMWLl2D3/V4B5v9bu47PbslK4wZc3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iyw5xRE2jVrrZ6qAWgTz+HKiyjjbVbAjuV8nf4jIFMJAcV//
	NgSEZtcS17c68zE/IXI5IunsCazuuLH7/zpBTaJ+hERBcGaZ5dOr
X-Google-Smtp-Source: AGHT+IEowWgm7vFzjvUbXcogbmidT9I+NuH0UhkIydSz86yZ+2NbVSVDMLuTxioICPD//NAuV5bhHA==
X-Received: by 2002:a17:90a:fa8e:b0:2c9:df1c:4a58 with SMTP id 98e67ed59e1d1-2e8f1087e8bmr21635954a91.23.1730353558912;
        Wed, 30 Oct 2024 22:45:58 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa0ea24sm2839654a91.6.2024.10.30.22.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 22:45:57 -0700 (PDT)
Date: Thu, 31 Oct 2024 13:45:29 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Yangyu Chen <cyy@cyyself.name>, 
	Hal Feng <hal.feng@starfivetech.com>, Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Message-ID: <t77tpj3zmabezppo4f2znseauml7w22zdddotdoenmhalm2yaq@vxkjqkleut6w>
References: <20241022040218.450573-1-inochiama@gmail.com>
 <20241022040218.450573-3-inochiama@gmail.com>
 <87jzdr2vyg.ffs@tglx>
 <CAAhSdy3Rmhhv5uzOzCT_B3EzQiXgV1FejZQbc5sLpwwFOXd5cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy3Rmhhv5uzOzCT_B3EzQiXgV1FejZQbc5sLpwwFOXd5cg@mail.gmail.com>

On Thu, Oct 31, 2024 at 10:37:10AM +0530, Anup Patel wrote:
> Hi Thomas,
> 
> On Tue, Oct 29, 2024 at 1:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Tue, Oct 22 2024 at 12:02, Inochi Amaoto wrote:
> > > Add a driver for the T-HEAD C900 ACLINT SSWI device, which is an
> > > enhanced implementation of the RISC-V ACLINT SSWI specification.
> > > This device allows the system to send ipi via fast device interface.
> > >
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> >
> > Can someone from the RISCV folks please confirm that thtis is good to
> > go?
> 
> The T-HEAD C900 ACLINT SSWI is not compliant to any RISC-V specification
> so at this point it is a T-HEAD specific device. The RISC-V ACLINT SSWI
> specification cited by this driver was never ratified by RISC-V international
> in-favor of the ratified RISC-V AIA specification which has a much cleaner
> way of doing IPI (as software injected MSIs) implemented by the IMSIC
> driver and this also supports IPI virtualization.
> 
> Since this is a T-HEAD specific implementation, the description in all
> patches of this series should be updated to replace references of the
> RISC-V ACLINT SSWI specification with publicly available T-HEAD
> documentation. Once, this is done, I think this series can go ahead.
> 
> Regards,
> Anup

Thanks for your kindly explanation. I will update all the description
about these patch.

Regards,
Inochi


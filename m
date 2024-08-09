Return-Path: <linux-kernel+bounces-280294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2D94C84D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC7F1F239D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1FD13FFC;
	Fri,  9 Aug 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WFziB1Q8"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA25D517
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168504; cv=none; b=TieDv0y4xoumm60TjUXyFeUezmAn1bFF8rOr2jwS6GtMr+Ir7xzr6f87LG7tyIAbocVzBUgEgIf4VOEk9CVVmvxvOI7Kbi1QjTC4XlfCugbCsCCVa4+xgROpxl/xNy97FDOKS76jdnHss1Smj1kIWPL0bGAcQ6/Thb1bMlLeVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168504; c=relaxed/simple;
	bh=6NnXnMTX4bioBiW1Fs1jPQ44L8gJYvWVDSigkmjiFf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG9uJ0DL7OrV45NVI9j35fL/qHv5a5h3WNRMZNVdTiKRQyzzKJcGH7YnCqx/6WqLpuE4SxS5bD4zsu66I3xvobxB/k2lMaJcMvYVHjqOx5gI6n2Os8YI9fcWCNhETcZ90s1HRIKwRz9b8XA8JkHA7XjTlM4Qr/c3Hfh/QA2rXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WFziB1Q8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso1340357a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 18:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723168502; x=1723773302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g87pHTYNcLqKymqltlPERDjp4Tiu1YLllz5reVFVMbY=;
        b=WFziB1Q8prf7BQ68P9jwMzYIlDpPatqLxIjjaCa7PQqdLGrXrVYVh52/trHUh7q257
         xkyoiemqqYfN6fYHrMOD2mjohblH1uzJI/yVXQpfpPCi3qvkpkz/oZprCYVYZb/NdWaW
         HKHG0kCuySttXAmxU00lVjTjMRBbKr10edtY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723168502; x=1723773302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g87pHTYNcLqKymqltlPERDjp4Tiu1YLllz5reVFVMbY=;
        b=fCRBmKt9bHKfTYvr7bs88PWsxdSsNCPclxDQZQKx9om9CbIR0qziefA11O9kpgpAi/
         o1JgxOfgrfaPZZZWQsBB0eA2ADBN9+n8kxFV8Eh3z+/oIWsiqiRnHGadpFO2b+3oFxqr
         FjX4MN0ZSsb671vhVXGQ/8d6EAvh4SPNYg8Ys0YGCBMSdZB6QWvk4knI+oviaFyiNtXC
         yPEM9Q8Viaju23vZEmVH29VQZAVSnDHxpQ65YiFcd4WnGdBJLf3OmxTqdpD4FnbLAlZA
         EDgiWJsHNfOBpmGdnTV9t2UN8CHaHwEatdM7WuQluTH26uNwP5KmwmrgXq6pKn/SV1Ni
         LcDw==
X-Forwarded-Encrypted: i=1; AJvYcCV1hzDkWF1leXKuTynMmWHTUsNANK3/sQ5st2YOG12A4+fi7HAfdKlOe6beX0PcmVNtSL6TZ3jSM9/kvyzAH3kN2jVWcdmMvijvPq+P
X-Gm-Message-State: AOJu0YyPhiAEqFfYynl3tjuh8aKqgyxoN16kG/71nyQrzc7cajWC3A8B
	8dk68lTaUHgHLryT0ZPhyRsf1xFCoB/Sl0siT5TFZNtbmQ2DfSMVha8zI3NU6gBTKUvEFebxnfx
	9wjW2/hzRn4GLxHZ4B1R+b+ulz7hfg80KzPsf
X-Google-Smtp-Source: AGHT+IFhGEBp9X1jQeNG940VeNl33LHf0TV1gzGb5GUUFhLURjI/GM1cHFs65SyyUqCs+rGzI9ShPh0OZ2G44L8CEr0=
X-Received: by 2002:a17:90b:1c0a:b0:2c9:9fcd:aa51 with SMTP id
 98e67ed59e1d1-2d1c336ef0emr4444371a91.5.1723168502167; Thu, 08 Aug 2024
 18:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-4-jitendra.vegiraju@broadcom.com> <c2e2f11a-89d8-42fa-a655-972a4ab372da@lunn.ch>
 <CAMdnO-JBznFpExduwCAm929N73Z_p4S4_nzRaowL9SzseqC6LA@mail.gmail.com> <de5b4d42-c81d-4687-b244-073142e2967b@lunn.ch>
In-Reply-To: <de5b4d42-c81d-4687-b244-073142e2967b@lunn.ch>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 8 Aug 2024 18:54:51 -0700
Message-ID: <CAMdnO-+_2Fy=uNgGevtnL8PGPvKyWXPvYaxOJwKcUZj+nnfqYg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add PCI driver support for BCM8958x
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 05, 2024 at 05:56:43PM -0700, Jitendra Vegiraju wrote:
> > On Fri, Aug 2, 2024 at 4:08=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > Management of integrated ethernet switch on this SoC is not handled=
 by
> > > > the PCIe interface.
> > >
> > > MDIO? SPI? I2C?
> > >
> > The device uses SPI interface. The switch has internal ARM M7 for
> > controller firmware.
>
> Will there be a DSA driver sometime soon talking over SPI to the
> firmware?
>
Hi Andrew,
No there is no plan to add DSA driver.
>         Andrew


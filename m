Return-Path: <linux-kernel+bounces-184146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6E8CA325
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2490281BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE771386B9;
	Mon, 20 May 2024 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Xf3/A3yu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C31CD39
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235905; cv=none; b=XrkiRAGDzEBGyuFZoH5AR3sOiCqGexVOmBdvKKRDPuAbfAnroCT8WZvJMQQ4j40TJr0ZrH4clEU+u2/kDvekZWKJ1EJZ/EmJd7rY8o3vC/QrQ686XdIkgkh8D2L6b1rQx7hBmhD50YNXcvXP3etd2kaSwbmNwlGrF6G3i/WAtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235905; c=relaxed/simple;
	bh=3mK/XupUfbYiEhVWmSK+krmIhOz4u5ZP0yn/RTc9hLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o//mNXdTNHOiO2Gil2d00QyPrLxgd/60hInh5sNEU/soubCeAPMGS4cRR/+NlMRR1H3Ejucsb9o46slQA0uFQw0Eg5+UbTjFudSNYa9rireuAcxBMu/BkFNIkmnwtjpWZQHE107jsGyJr27iPNzMKW3YOLkb9YvCrVsF6jNp+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Xf3/A3yu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f0537e39b3so84238855ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716235903; x=1716840703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9PM2o5jNXfuRUuP6TxEIEBudbQR4NtCgVAI1O+sTf7U=;
        b=Xf3/A3yuqqkAKOCO9daG3tXGDreCYNT054DCLigkb7sSdPafCb4tqmTSUABdoiayP7
         2IS5/1PNjM+/gW0TjiWwO1qHJtEhb6X2wTSFzMwb9KMVQUYPhy5h35tOANl67t3DHqo8
         KM4fZTTzj23+UryKu1tyCIxXErixdm2v9RTDRoNNOVzq1eHw54R8fbq4tDX6DyQqMN6q
         qvRCzs83iDdXrPX6qljisZPmjlFC9HmMaP/BViMIb2c/08uzH9wgt4uf5juvcutkE11L
         Y95kLIdJ7tVn0y5UGQk3S8rmSWooyWjRjCgF5rDb4TjHQDX8YCf4TiDarGpU8o0X73T0
         PoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716235903; x=1716840703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PM2o5jNXfuRUuP6TxEIEBudbQR4NtCgVAI1O+sTf7U=;
        b=I84dYJG35cyv1ZNN+SKYsAQalk2tCCP5Y/Z3lMlHSSaPFEqPHjvdLrE4uZVZusj53F
         bhdJQ8t8Cc08xHHjGnd8qqyZSykcyjz9IwR30bkz4WO+naVZuCtIuN/zos1F1C7+toD3
         BzIImRLqszdC065TIOaKPWdfDbRKVa2rAsWtAEBrf2Lz4/nzuFkML/8stx6IFLf11rEC
         QQXJkyvfntzrDgydl9lcWvXp20imN6Crty8AMDOnu2W174SkYv0iaXvTVGPgyXaONl/i
         fByPxR7OI6qFQGo8DKYEi/1IcWSQW6Hoy9Gbc2GYRyrlU3lRuAhE3LOStOVhJgeGHFKp
         ZowA==
X-Forwarded-Encrypted: i=1; AJvYcCWi7d+quu/8LQfoj5zU36hHcCQqWGSyo553YPGLw5QRgQ4MD7Yjt6VAQgo9AyiUOVj0WloAlVbfqiJwqWXrvkQhmkLM1FtGIp2nBFmT
X-Gm-Message-State: AOJu0YxcTh5eflRoCRRtYvItg2vr2EfFVtKkFFa25J/ZXn6C1cK3eOv5
	3hGkJYIBtsT8vpiIxnb43wfrQ3o7nw7UQVt9OqBsPx0gLDKRECJKHlQZwzT9P18=
X-Google-Smtp-Source: AGHT+IFRZhmOYJwGAcLbXRL2uDIeayGTe8D9hUj1uP1w+nEBbftf22Y46efOclD6gUxBji0DKSfZog==
X-Received: by 2002:a05:6a20:3c90:b0:1ad:9394:2d30 with SMTP id adf61e73a8af0-1afde139a99mr33701775637.37.1716235902866;
        Mon, 20 May 2024 13:11:42 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d94csm20112830b3a.95.2024.05.20.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:11:42 -0700 (PDT)
Date: Mon, 20 May 2024 13:11:39 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@sifive.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 0/2] riscv: Allow vlenb to be probed from DT
Message-ID: <Zkuueyrdv3z5QfsR@ghost>
References: <20240515-add_vlenb_to_dt-v1-0-4ebd7cba0aa1@rivosinc.com>
 <A9EDD470-B8EC-4644-82A0-7444729EF885@jrtc27.com>
 <ZkVAYeNnvj99YHXt@ghost>
 <6DDF33DF-07D6-4230-8674-F91A91660686@jrtc27.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6DDF33DF-07D6-4230-8674-F91A91660686@jrtc27.com>

On Thu, May 16, 2024 at 01:58:29AM +0100, Jessica Clarke wrote:
> On 16 May 2024, at 00:08, Charlie Jenkins <charlie@rivosinc.com> wrote:
> > 
> > On Wed, May 15, 2024 at 11:25:16PM +0100, Jessica Clarke wrote:
> >> On 15 May 2024, at 22:50, Charlie Jenkins <charlie@rivosinc.com> wrote:
> >>> 
> >>> The kernel currently requires all harts to have the same value in the
> >>> vlenb csr that is present when a hart supports vector. In order to read
> >>> this csr, the kernel needs to boot the hart. Adding vlenb to the DT will
> >>> allow the kernel to detect the inconsistency early and not waste time
> >>> trying to boot harts that it doesn't support.
> >> 
> >> That doesn’t seem sufficient justification to me. If it can be read
> >> from the hardware, why should we have to put it in the FDT? The whole
> >> point of the FDT is to communicate the hardware configuration that
> >> isn’t otherwise discoverable.
> > 
> > Yes you are correct in that vlenb is discoverable on any conforming
> > chip. However, the motivation here is for making decisions about how to
> > boot a hart before it is booted. By placing it in the device tree, we
> > are able to disable vector before the chip is booted instead of trying
> > to boot the chip with vector enabled only to disable it later. In both
> > cases when there is different vlenb on different harts, all harts still
> > boot and the outcome is that vector is disabled. The difference is that
> > with the DT entry, no vector setup code needs to be ran on a booting
> > hart when the outcome will be that vector is not enabled.
> 
> Why does vlen get this special treatment? You could make exactly the
> same argument for the number of asid bits. The precedent in the kernel,
> whether RISC-V or other architectures, is to not do this. You can
> detect it, so you should, especially since optimising for an
> exceptional, unexpected error case is not worthwhile.
> 
> >> As for T-HEAD stuff, if they need it they can have a custom property.
> >> Though naively I’d assume there’s a way to avoid it still...
> > 
> > T-Head does not expose vlenb on all of their chips so I do not know of
> > any other way of getting the vlenb without having it be provided in a
> > DT. That was the motivation for this patch in the first place, but
> > making this available to all vendors allows optimizations to happen
> > during boot.
> 
> How does userspace read it then? But if T-HEAD need it, that means it
> should be a thead,vlen, not a riscv,vlen.
> 
> Jess
> 

I'll let Palmer decide if it is reasonable to have vlenb allowed to be
placed in the device tree to support cores like ones made by thead which
don't support vlenb. Otherwise I will replace it with a thead-specific
binding. 

- Charlie



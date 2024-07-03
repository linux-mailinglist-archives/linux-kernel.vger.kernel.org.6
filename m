Return-Path: <linux-kernel+bounces-240108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723E926938
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6659B21D38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6718FC81;
	Wed,  3 Jul 2024 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SZSNI2ow"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82818E74A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720036757; cv=none; b=p+bQfgzaw/l/KrAFeQLdnqQmyq6lEaWaEDcFoY+TsAzYHdwplmeLr1+IG667+H22jbfM+NP+wCqVKVrMtpJlrLttJ6KxRpNzitT833/WYE89jVA5Fg2H4o3/oC1dLWjX1qVWweTEuma/+FYkgZ+K8mrBOrKJqC5y+nobcOLntls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720036757; c=relaxed/simple;
	bh=1uzZzpE27QyXXXCxReOkYYZjMh1dw9TnfOmdAUrsY0k=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=tZbRU/KW9LIrRj1Gfi6r9DBsftOOXM9nRO/GMzVO5waXiItdrUfQAJkNl25LdHRliUkjDRiqE8bH+QyAvJ1hn1bZOJhY/ik4hHGTxV7VQ/ziCUtJDr/xQKnc87oPHC+SoU0qJc1A1vBnkQoQUX2CQz9jjaersSjAHykcRG2iCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SZSNI2ow; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70aeb6e1908so798598b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720036755; x=1720641555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llqZeLMH/2BLbFjCrwTuUEHpE/ViSqc2wj4oZtu1yzA=;
        b=SZSNI2owGM/uwYOQgGk+IM8T6DI7EyPrul7gWiYBROkWbSFwawGf30DJstBULI6Ad5
         HEnK+M3W5FzOMEtbwyVUTmkjQ2FZRXWpbN157yGkv26seuywG87kyx0O8Kw52HdP/Iw3
         DLJlio+iCoItqWX/2sL1bql++FztCmIIlBOdHg6mR69kt89A8fHqblzxRH5pTu9CDswQ
         Ob450B2PCyYVTonT0YpuU6ktujO5aagBhx+d6DuKF6pJNVoilbLwt9x5AxQ5t3MTsJ41
         L6w4ufT2ovZoXxywJf9l6BTs+sol96dERtpYi6hjJJzODl+XkcHZsDBo+Anjgqlr4Yeh
         h0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720036755; x=1720641555;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llqZeLMH/2BLbFjCrwTuUEHpE/ViSqc2wj4oZtu1yzA=;
        b=eoYB/ju8LYG3VFg30lj8Kg+OGGYl8z6nZZ6hIOgW+c+yVwaveTGC40z9PxIB6GdsaP
         BWdrf61tNBpYK02fueBWh0+BIAqeawAhzFpNU0Srk5wLCT5aMkEI37TvDnU90LgrIY4i
         2mRrkb67wBIzsd2m3RFSaaB79Vma7wocn0FrbU0wuAYxMF1ov0OY4sQP5Bmjsf03662L
         9JApRF04uOPZHi8IHTosI1B3zqqY+MYNfhhMHCrnBUV3U2hvhGBwNor+yWX+KK7R1KON
         EndMQutg9EoMVudtj920WcivYBeLIW68yZKtw/SzBZ7skwxBJ1kTjtJGQYR9omEUOqtm
         xCcg==
X-Forwarded-Encrypted: i=1; AJvYcCU3VdspoZwlwT6otZ8QlH20yfeJY9Rl1Dk9gQFb4H+OijutCgVMGYjdnggZC9ul39OQMeivsRaIFDfUArX/O2hF+/rLwQySUgFtCKbA
X-Gm-Message-State: AOJu0YyT4wjyTMHPmr+kj2dIC6TLqSrzxbvtlHFdHuGO1pR/1/M25LZ+
	+c4WN7J1Q3BZ9CGEUcC1kOcIYAYw8jgoiDqJyRalpjUTAznCr0E8Zbl2N62mo5Y=
X-Google-Smtp-Source: AGHT+IFI2fOylyhpu9F7a1d+pF4zhchdEwR1QvH0cPmHKjCeEh3crHOa0vuNmj6ebNBPIEQBj9LrSg==
X-Received: by 2002:a05:6a00:218e:b0:706:5f74:b97b with SMTP id d2e1a72fcca58-70aaaf10da2mr11931505b3a.23.1720036754701;
        Wed, 03 Jul 2024 12:59:14 -0700 (PDT)
Received: from localhost ([199.68.152.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246bc72sm10867658b3a.60.2024.07.03.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 12:59:14 -0700 (PDT)
Date: Wed, 03 Jul 2024 12:59:14 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Jul 2024 12:59:09 PDT (-0700)
Subject:     Re: [PATCH v4 0/3] Assorted fixes in RISC-V PMU driver
In-Reply-To: <20240701130127.GA2250@willie-the-truck>
CC: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
  kvm-riscv@lists.infradead.org, atishp@atishpatra.org, anup@brainfault.org,
  Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, ajones@ventanamicro.com,
  Conor Dooley <conor.dooley@microchip.com>, samuel.holland@sifive.com, alexghiti@rivosinc.com,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, garthlei@pku.edu.cn
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Will Deacon <will@kernel.org>
Message-ID: <mhng-c9cb22ea-9f7c-44c2-8e3c-8bd1de101e16@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 01 Jul 2024 06:01:27 PDT (-0700), Will Deacon wrote:
> On Fri, Jun 28, 2024 at 12:51:40AM -0700, Atish Patra wrote:
>> This series contains 3 fixes out of which the first one is a new fix
>> for invalid event data reported in lkml[2]. The last two are v3 of Samuel's
>> patch[1]. I added the RB/TB/Fixes tag and moved 1 unrelated change
>> to its own patch. I also changed an error message in kvm vcpu_pmu from
>> pr_err to pr_debug to avoid redundant failure error messages generated
>> due to the boot time quering of events implemented in the patch[1]
>
> I'm assuming this series will go via the riscv arch tree, but please
> shout if that's not the case.

Ya, it just ended up dragging on a bit because of a missing DCO.  I'm 
just throwing it at the tester now, it should show up on fixes 
eventually...


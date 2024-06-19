Return-Path: <linux-kernel+bounces-221513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF790F4B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314951C21160
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A893815573F;
	Wed, 19 Jun 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f6t2Q7KE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909D15665E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816650; cv=none; b=t9N4m5qaM70pHq0yQODt6OP7mcRpbD8sXeKzNEhY9tNOnI2wZxxV4p9ElY+tM1Wm0mf6M4xE+zVM3ed1BCRMDXh5m4CK70Jcr21575EY+S91IWI+P0gY6kDKWBt/1UF4IH5SYzKvRhu116/2NVWlj6ezp3LHyt4iuVlfrFpSLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816650; c=relaxed/simple;
	bh=TAmY0dpTBtMx4Mn7recj7mq784whApdYU20AquEoqcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXCvLg4kaVqu/AV4GaoT6q8tu9RjE/wcL66nunIUlNdxsHl3qj2eNraw0xlS/AejbUbZ+brv5K/KSk5r8HZmtlnW8EXYFRYE/Pf9mXC6FYq2ZoCoFTldjfhyR43ax8+Jo5HSbjfbRV8HtprxP9DGfvf8w8gQG1mZXqL410drSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f6t2Q7KE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-705b9a89e08so52446b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718816647; x=1719421447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TAmY0dpTBtMx4Mn7recj7mq784whApdYU20AquEoqcw=;
        b=f6t2Q7KEJrXu0kXLXadS7WnjMYytypq9g+G7E/SXXxYVeiPvl+75rQOzSMJtDl8Lz+
         Q58yeYxujIvWXAAF9tGcAzCvRpSiP+njpbhAL96mvYvgvqNrmfdKTcIaQvkBUYvf7aFF
         bwZl+nCxrL3oyIIkhHI2nDDnPgHVccJ2ZZcE/prxp1yz4YEBeKjIyo3Uc44Qdy/SkVvh
         LkF1Wxt2zUGXO81BtHFw71cvh2+hU5gtwSBxEOpIpzAq2xm+ljzc1+jolbKMh1fAav/3
         wSy0IEt8sr7wrhQ8GT7ShJM3EDhcAvIjLlA0hTYIXX6/hsxv833HqNFgLhJrA7zVLZQb
         WUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718816647; x=1719421447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAmY0dpTBtMx4Mn7recj7mq784whApdYU20AquEoqcw=;
        b=sojfLTYM9OT0rJEWklFD7WLI2D4kzSnPHNnTkEMGlYJfX9/RJSKmpTjr/wdumVjmcr
         RtEoqEqtk71EXllH2UACizQ8xgIH38fxYOgll2wR2C5DEjOYosjppKe+z1F2uoLhf868
         yE8r0uXssYE5JQcDae6wPND85mkGqihuezojqAW8y+9ppYK9nBwN2z9NcA3SfTamYSxQ
         GU53YLzIEEXXpdln2HzUHJGtMizxEexaS6S+6nKlxjkWtYlIB9maNBsfwDsL4daywSGa
         3vl6iej/m9UB320+Wk/UUkVclW0k/6pBRV+Nr8ZEiJQzaDKCE4TmhNSRV1aYk0cSIH0k
         KdxA==
X-Forwarded-Encrypted: i=1; AJvYcCWLdcwtNLfDGyqutZ2io9gKxlq2M5AgjP13GC3DrtINR9kgS4koPRdkeYJY8+89FnJbK17BuH9kPCQ4C4zVnWOXK6yCfBhZbHdfMql0
X-Gm-Message-State: AOJu0YxVjVbamkae3WRfb1UzwTra6n4yJnmNKL0Mgz91g2h1X4vMhk3U
	X3Z5YZ3T2yUZ4XCmxnuz2+oiJExpSkkW9redQ1+5W/OKgBBeHITEfa2j1ofbHy4lvXK6N/iUNXT
	L
X-Google-Smtp-Source: AGHT+IEUXk33dow3y7Ft7RbTfxe/eeqqRE8L7RgGsxt+H4OKHabp0dQGgOvRijuFe3sL5j8D4BwSOw==
X-Received: by 2002:a17:90a:ea83:b0:2c3:c80:9ac8 with SMTP id 98e67ed59e1d1-2c7b59f0c7emr3179324a91.9.1718816647303;
        Wed, 19 Jun 2024 10:04:07 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7c989b35bsm1446583a91.46.2024.06.19.10.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:04:07 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:04:05 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Clement Leger <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
Message-ID: <ZnMPhcaTKFRbbE1i@debug.ba.rivosinc.com>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240616170553.2832-4-jszhang@kernel.org>

On Mon, Jun 17, 2024 at 01:05:50AM +0800, Jisheng Zhang wrote:
>For readability, maintainability and future scalability, convert the
>bottom half of the exception handling to C.
>
>Mostly the assembly code is converted to C in a relatively
>straightforward manner.
>
>However, there are two modifications I need to mention:
>
>1. the CSR_CAUSE reg reading and saving is moved to the C code
>because we need the cause to dispatch the exception handling,
>if we keep the cause reading and saving, we either pass it to
>do_traps() via. 2nd param or get it from pt_regs which an extra
>memory load is needed, I don't like any of the two solutions becase
>the exception handling sits in hot code path, every instruction
>matters.

CC: Clement.

I think its better to save away cause in pt_regs prior to calling
`do_traps`. Once control is transferred to C code in `do_traps`,
another trap can happen. It's a problem anyways today without CPU support.

Although with Ssdbltrp [1] extension and it kernel support [2] for it,
I expect asm code would clear up `SDT` bit in mstatus. Whenever `Ssdbltrp` lands,
I think `do_traps` should expect nesting of traps and thus cause should be saved
away before it gets control so that safely traps can be nested.

[1] - https://github.com/riscv/riscv-double-trap/releases/download/v1.0-rc1/riscv-double-trap.pdf
[2] - https://lore.kernel.org/all/20240418133916.1442471-1-cleger@rivosinc.com/

>
>2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
>alternative mechanism any more after the asm->c convertion. Just
>replace the excp_vect_table two entries.
>
>Signed-off-by: Jisheng Zhang <jszhang@kernel.org>


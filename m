Return-Path: <linux-kernel+bounces-285278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDFD950B96
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4380B22AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1201A2C16;
	Tue, 13 Aug 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="JZHXeVxU"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360719924A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571139; cv=none; b=Q5vgUO/WmZDamTVK8fddJ2F9bk4jgXTim/bsoVhU5vHTd5QU1gqgJMgaRH9xz7NuH+55Kp4xCJkvcrmlpFelpshL7QBI5d/w1xOwn9nRw6u8Xk5tU79ThLkIrA5xpK9LP7w2oRIsRzs2wOKsbw2XqaNMEHyU0/1+oLvYWKNJ/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571139; c=relaxed/simple;
	bh=6+afeR/+pZK6lPx8k3vBYy4jK0VSoZbaaGxo+2MWvac=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=HvbcvC1WirwUNLUbzNKUonC0of40AKDS2EFkpw5dD4b66Pt+Gqr/P6B1wVetF11irs69bkmSm4qhr01P6CZDELkBerL3dW5V8NFD+1NK1OD7Nk2nJrqPBT66GUY3Dw00+Bv2jygZyWV8OyUjEwNGoEYFtU4iagTNAVtr9ptevSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=JZHXeVxU; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-260f863109cso3391053fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1723571136; x=1724175936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MubgzmTkGoLk6Sy+ubAhLb2lJQ+c10dRYN9KCEZDVvQ=;
        b=JZHXeVxUK5T2ppeLe/3OoTTLV3uOcZW7fImZ1CBpY3srgYOAPt3UBgstBY2VQNv3ud
         0Ra3CHtwSsHkw5nnvdxtqjuF0I8SQQ4y3Xfj76XyIoBwFGIYBx8svptkGkjqZiJ/sKLS
         FmeclE6bquxahLBZgdCmtbaNV+p8ngP4ZbsxMOuUsFUrhiQTuR1mS0H/dwAoNVIr8pJy
         b6jzTclV0NSKhU/yvE7/MfM+a1Hhw0J01y9izsDVjLVVcid5SBAjG9kdJyJqLQZIKK8l
         dg4lrKfZt88UC7fSyGFdtU0y2tslaNABZGF8kdRK6BbP2u27Pu7S/x/x2xgTnzckjd/3
         iJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571136; x=1724175936;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MubgzmTkGoLk6Sy+ubAhLb2lJQ+c10dRYN9KCEZDVvQ=;
        b=iGj1MYW14As7RdA1UmzigciOfym8isJjnUIExOO4vR2gJxWpuTiwM/OhDI2A56uQkC
         FenJVKeAP4ijrPY/M1+sswnBaMGm8Q8CXEQM9KhPvSXSR8Ds6Dz57M3GCbEw/9ZGQ+y0
         NpY5oMjnQOrivhq4TVaAj/sgwfNA+Taoou/N7n9gapl7uaCjn5aLLwC5MGZe+dzd87gy
         f9N7ORug8DO1DbwnAbzenbxgydjzdqRgbw5Z3g9ThjKldcq/4La5xP7QPLREFEyRYPT6
         5Rz4u8GFMqI1uaK21AY1F86k844h0OzuFTLvDOWwThGmxHyNED6MaNcH/QqnKrwITIe+
         TTfw==
X-Forwarded-Encrypted: i=1; AJvYcCX/op8dtkmDzd+sKICJcIscVWa72FWkU6JS1lHxvACQjTHbr5RqJSt+4DcKK9ZhKVMS1Mn17Ku5/3QKdE0Fqp26dUWWXmoWNS2EjEdW
X-Gm-Message-State: AOJu0YyKbzbhSZaKyp96juwb6WWarhosMJNg84Jp9I+2EIeHb/vS1xJL
	PGOWnuK1tkoXCdICrotVR6XuBjtK/218sdMSMAIZo1K07D+nVBIcfAkvgHwdIp4=
X-Google-Smtp-Source: AGHT+IE3uqwNiNxWMS0aZLT9JubHN+Eh10Kr02K6qabc5dhWWvlSu3SRh9RQgttofqo3VUev7YFzlQ==
X-Received: by 2002:a05:6870:1612:b0:261:1eb4:dd8e with SMTP id 586e51a60fabf-26fe5a04303mr455099fac.2.1723571135449;
        Tue, 13 Aug 2024 10:45:35 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979d3d58sm1755063a12.18.2024.08.13.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:45:34 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:45:34 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2024 10:45:21 PDT (-0700)
Subject:     Re: [RFC PATCH] riscv: Enable generic CPU vulnerabilites support
In-Reply-To: <20240703022732.2068316-1-ruanjinjie@huawei.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  samuel.holland@sifive.com, tglx@linutronix.de, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, ruanjinjie@huawei.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ruanjinjie@huawei.com
Message-ID: <mhng-8bda3a10-9d6d-4aac-acdf-1287278e7e82@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 19:27:32 PDT (-0700), ruanjinjie@huawei.com wrote:
> Currently x86, ARM and ARM64 support generic CPU vulnerabilites, but
> RISC-V not, such as:
>
> 	# cd /sys/devices/system/cpu/vulnerabilities/
> x86:
> 	# cat spec_store_bypass
> 		Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> 	# cat meltdown
> 		Not affected
>
> ARM64:
>
> 	# cat spec_store_bypass
> 		Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> 	# cat meltdown
> 		Mitigation: PTI
>
> RISC-V:
>
> 	# cat /sys/devices/system/cpu/vulnerabilities
> 	# ... No such file or directory
>
> As SiFive RISC-V Core IP offerings are not affected by Meltdown and
> Spectre, it can use the default weak function as below:
>
> 	# cat spec_store_bypass
> 		Not affected
> 	# cat meltdown
> 		Not affected
>
> Link: https://www.sifive.cn/blog/sifive-statement-on-meltdown-and-spectre
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..3b44e7b51436 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -85,6 +85,7 @@ config RISCV
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_CPU_DEVICES
> +	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_ENTRY
>  	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO

Thanks.  This is an RFC, but I'm just going to pick it up on for-next: 
we had a recent round of RISC-V vulnerabilities crop up, so it's time to 
start tracking those for users.

It's queued up for now, it'll show up on for-next proper assumin it 
passes the tests.

Thanks!


Return-Path: <linux-kernel+bounces-327245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47A9772CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB1C1C214F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478BB1BF81C;
	Thu, 12 Sep 2024 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uVko2pZW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299FF6F2E8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173480; cv=none; b=bYipyHdWbmWv7MnmGrcllzQUnRnzdt5puWjKFGvQJttYVjBOt71oQh7y32YzlFNv0bsw1hS2F+0HWmvDpNKHL16H6DHed8J2JFeKdLfY87GRsscSjDbr/0YaLeYTPdFEwjnk9yEDPxpfRy/KtS3kECG2RUs9ReygAxCwLAnKdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173480; c=relaxed/simple;
	bh=YOwLzK1Dj92rH9elSFM3IwcNY361Dg+PQh209tAXKZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVZrVboO2tVN2+bJ9Uae7m24AdVrwvA0/CSOAusTYmIYUp3Ldmypdvmi+4WMWSyIIrA6+QMUyPMBzg3pbhR3UR4SSpIk0QfeFhju7wESM7pXSD+cM3EIOxRVp1Zv6fh4fDFjDjRCu4IREbVuCjX0XjNHRYC2y8/C4/8WhDqViKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uVko2pZW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1853395b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726173477; x=1726778277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suhtOeu9PBoMcCzuCwQpjOOtsg7slCT/xflY4+7rlvM=;
        b=uVko2pZWeD6s5f7PAkYIAqP/scSfyI/eQU4gx/YcQS0GTeC56qSzKyvwvtp5TiJEqa
         YPorAD7mtWOarjgUZfnPYOzDQez5ZnCaGQFnl02QJRREOBwuDXmuPAPsr+UE5SxQhCeK
         xVnqvQxMaZFul9EwmqrvLomv7v3s+Iyu++rmmd2Y/JAmuKDN+ogxE9qKhWN14kNGQQNP
         BcQFUSLaTQChZNnQ6cUxcdUaZ8lVFvvO4IrBf0IG+c8u3NzN7QR5HXWa3heeD7IlShgU
         QHHFvKfTRoAKdtuefDS/aG6KUbuVUaB/XhuhO7smfRiaicjv2Z+r2xX/VngI+r8LVbi2
         uxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173477; x=1726778277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suhtOeu9PBoMcCzuCwQpjOOtsg7slCT/xflY4+7rlvM=;
        b=ZYfkIznTpg+vc71/Og+FESiN89a18/8/uOlCfSJJEI5oU2vbiwpbj8Os94s8m/e+Im
         bUkJTACYg+rLinoG1cZnZ2jPYfBa8ToraLFRGq+wWqoNMK6kLE4sPuc6fpYhlN6XCF0F
         vlqplBa6R0+Zio0HRx95hGXhZYUZN0VZSB22Dn9kzL4hq14zdOZRAx4idQX145O3xkUn
         M62kaeLgzNFFiOV1pkAmlnlw5sGXXAIIPHSxj8ayLSln/85i+dggfPNhcHl2LfBn2Htx
         zUn5SgYKknmue/j18hGqxooAwuiSCncJCWK8eqN/Sl6XOVXzpw4VdgraTuj/ibpozcSg
         vfbw==
X-Forwarded-Encrypted: i=1; AJvYcCVCf8k0+heZdwaHYr+2k1P+s0j2XMN6qEumU/J8o/c2X0I3f+3HrNtOi2SwlAEl1cXYqcJxz3aTlAH3NCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbfR0cJOYA43ntQH24/kUn/GoXjVYI6LiTtNzWiHYgkGY+EXlC
	xdgbF4ohr5QgLIa0JQjJ0nYQZlRnr+de+ln1U35yxefk0Qa89gjbYRclmQutrs4=
X-Google-Smtp-Source: AGHT+IEPZkfWCHuNRnb9w66UzgZ4/IOwRt4Qb1WwmAi9n2EGyfgaTtP8WV199QorTDpuzxXGy3pxbw==
X-Received: by 2002:a05:6a00:6f4d:b0:718:eeab:97ca with SMTP id d2e1a72fcca58-71907d98483mr19442770b3a.2.1726173477187;
        Thu, 12 Sep 2024 13:37:57 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe27bfsm4972931b3a.56.2024.09.12.13.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:37:56 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:37:54 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	samuel.holland@sifive.com, conor.dooley@microchip.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	atish.patra@wdc.com, anup@brainfault.org, guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: Re: [RESEND. PATCH] riscv: Use '%u' to format the output of 'cpu'
Message-ID: <ZuNRIrfLgkWUsZri@ghost>
References: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>

On Thu, Sep 12, 2024 at 09:49:46PM +0800, WangYuli wrote:
> 'cpu' is an unsigned integer, so its placeholder should be %u, not %d.
> 
> Suggested-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/riscv/kernel/cpu-hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
> index 28b58fc5ad19..a1e38ecfc8be 100644
> --- a/arch/riscv/kernel/cpu-hotplug.c
> +++ b/arch/riscv/kernel/cpu-hotplug.c
> @@ -58,7 +58,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
>  	if (cpu_ops->cpu_is_stopped)
>  		ret = cpu_ops->cpu_is_stopped(cpu);
>  	if (ret)
> -		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
> +		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
>  }
>  
>  /*
> -- 
> 2.43.4

Thanks!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


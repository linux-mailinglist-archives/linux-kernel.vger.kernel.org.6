Return-Path: <linux-kernel+bounces-191237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFB68D0889
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA65285C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C8F73469;
	Mon, 27 May 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MGBfFmZH"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DA26AF2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827368; cv=none; b=nFVg/O+azKLklFEvF0m9zVPpTP2HtFKtFETmJhUuE1+fN02+pth3jQo/BlxMQRofQ+zCBhJ9MjiaYQ82uWNRs5kzyLuB/wD4OX2hpLgJlfDh9Nde8G2FVdnU93Wfp+1N0+VJb4WRo8ppL6nYVoYs9/VO3FRrF48EJCRPEgVVQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827368; c=relaxed/simple;
	bh=3YdPeJC2tHkWxyPRxxZlARmOrfnFjazq6g4bTFO445E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb1GPL/psZsKBrMtp/aH/RY/3mKowZ3XKdM3BZ5tsOEOLQSdt8LK5bIiB1TUoC4ysCPIeQfAKUfKz/JdFKmiq2GoRF5yjfz9ZWgb5KfKx3iZqx1Fn2kfcj8XflJlPCyCtof7MF3dmXxi/Fusua1maLf2xFSwXKhapwB3OMaNAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MGBfFmZH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35508106cc2so2795045f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716827366; x=1717432166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCdwiEKZsSLlzQmI564yzAeMM+d5MqZnvy70D5v6p6g=;
        b=MGBfFmZHDeKudFiXHdi9VS0yv/7mzfEcnvuxeCtNAKP3qWeg/miVye8T4MQwHBRnjE
         Fck0lHj4PXuCIjx5xfd1n8HY1EniI0lzw7Su2qgtUeNGXX2sQB2fHBNgZW904U0fbsLt
         qZXt40TtAiVkHEP0h5UhlhVqYkwQU3U3IrzTh+xr+jon917InP9KXfsBhrhok5HRF2W0
         Ju+cjVdhrxNjEP4+vmV26E7KuvBO6LLW8M8IuBSMRNGxotxpud+j0YTMaDAW7vZ8n7bp
         NHk6vx6MlzjngdHdR5iXnYIJHNcsY2Rn6PC8wJTH2b0/jnsXPsn2fmuAXE6pCxJQgu0v
         kkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716827366; x=1717432166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCdwiEKZsSLlzQmI564yzAeMM+d5MqZnvy70D5v6p6g=;
        b=MzS6rE7zm66sW4ZGYDnVU72NIGPLIyITvu4yQlWHgtLYJVYXRUz6WJo1Aj3XzDmtbZ
         3Qj9xugApIuxv+SUvui3+bmy/5PKYTHEbYhARu80gEETLGjz62C4/dTz+HmRFs33wTII
         RV1LtDeMmt7w/v26A5nLAKHiyikRUMqR9UucBm2D4T+zopzD0uchS3U548shz9zwUf4B
         1LQXmgz8cxHQZ+hOQT41FReeofkvPnMSUtAL8SiFERBSP/FYvcvmJHRm+WAu9H8wWI4n
         m+Pdu6IN5TH/fDEFWJ1IOX3PhZx1Cph06rTykHD/LZROtBzide2OT4biupS/iN+x2aRQ
         1rbA==
X-Forwarded-Encrypted: i=1; AJvYcCUlkkuYHEfRusNVW5cfToKk8JAHgHp5/719zhk4YyCxGXO9u7vgtCeUL2c9zHIZmCMOjqWIgK90T1C1Gv5NrGqeQwZGzjR2L0GbL1LC
X-Gm-Message-State: AOJu0YxuWLWXABf0BGhKrg4qSgyI3uLAh9T5HtFINnXt80DasJzOct03
	N5xySFLd4WA9Gs6A/m0KkaqC5cEmNRoTGl/ylPonV61tWGifKmQThx6w7J5hz9g=
X-Google-Smtp-Source: AGHT+IE/a37MX42XQNRb/+dniYNRx1NJyY5t2V95xUKst84x1kU49Lx+w+odCrcs8XgwmmBFVgQQoA==
X-Received: by 2002:a5d:420c:0:b0:354:f724:641d with SMTP id ffacd0b85a97d-355270489a7mr6855127f8f.42.1716827365576;
        Mon, 27 May 2024 09:29:25 -0700 (PDT)
Received: from localhost ([176.74.158.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c931csm9402469f8f.79.2024.05.27.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:29:25 -0700 (PDT)
Date: Mon, 27 May 2024 18:29:24 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	cleger@rivosinc.com, alex@ghiti.fr, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/5] RISC-V: KVM: Add Svadu Extension Support for
 Guest/VM
Message-ID: <20240527-0a37c07cf34bbb0d4fb8067c@orel>
References: <20240524103307.2684-1-yongxuan.wang@sifive.com>
 <20240524103307.2684-4-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524103307.2684-4-yongxuan.wang@sifive.com>

On Fri, May 24, 2024 at 06:33:03PM GMT, Yong-Xuan Wang wrote:
> We extend the KVM ISA extension ONE_REG interface to allow VMM tools to
> detect and enable Svadu extension for Guest/VM. The ADUE bit in henvcfg
> is cleared by default for backward-compatibility.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index a59a8448deea..bcf99264560d 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -167,6 +167,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZFA,
>  	KVM_RISCV_ISA_EXT_ZTSO,
>  	KVM_RISCV_ISA_EXT_ZACAS,
> +	KVM_RISCV_ISA_EXT_SVADU,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 994adc26db4b..4166665e215d 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -37,6 +37,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(SMSTATEEN),
>  	KVM_ISA_EXT_ARR(SSAIA),
>  	KVM_ISA_EXT_ARR(SSTC),
> +	KVM_ISA_EXT_ARR(SVADU),
>  	KVM_ISA_EXT_ARR(SVINVAL),
>  	KVM_ISA_EXT_ARR(SVNAPOT),
>  	KVM_ISA_EXT_ARR(SVPBMT),
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


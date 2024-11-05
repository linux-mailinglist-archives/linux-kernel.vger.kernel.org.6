Return-Path: <linux-kernel+bounces-396164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCCE9BC8D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC29B224FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A701CF7DD;
	Tue,  5 Nov 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KFylEY26"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3018F2F7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798094; cv=none; b=gJkqGlk/noSdxFvt3cz32BVG2qBZ/VLLsw1v8AfKfE77OR+BibGpYvOhjoQ1TZdlEOh71tM6/XhUnFf10uvGoJBnPgkBrTNdO5IgnaAdqIr7ZEuZfcFBGl3RdwKNpdQfErxShnZVtpk78+Zk3M59OwPQZiE/39ms6Qt6+KqGKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798094; c=relaxed/simple;
	bh=fwNtz/Z+NOqo1MyfPZfQNhZLQG3eD5ohKoO0W78enqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOvsd+qFSG6Q3/85d0oAzBOFRTazScf2HxlTwZp9G85i+aTEciSEu7ctunSK8X9XXm+f7nHe04f9Fnh7UencDQ1CMYdO5rmkT4SbwsZ+Sl+thaJFRH/sYDm+5Tq9CssNpJ37ZKw/qZoq9WRU4Sc+rZGTneQIQIHVFGN2lBJ0I2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KFylEY26; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so36346801fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730798091; x=1731402891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P4G0QFpDZpyh7jivQuglDMqb6yzlT1rpR4Jl1yN+DF0=;
        b=KFylEY26KSGOHI8cVyeSwn71wmwPJ90KtcN+YOra5J75CJa4kXbEM5+Uxw1wRVU/cC
         1CIE5hsWTwBnfS4zInOJ/LsN94d+OAnJioTKgBfY0j0VVdvNGq3o4BUXB2OnIEywQMLx
         5M0iyFwG8Llld/rrzI83KQD9VG3LKoFJFxqOLGr8+x0ofELLN9ZKc4mL8fJuhln8Kznd
         caIFCD0ur+gt8DTPiM+svL21gUac4SiQ2NYagCjlDoAnYD3lWIeo/7kqnwYwgEK7XabT
         12gvdS6yVHTZr0avgh91jRJ7O0fAZOvLR+7SPdkpQbE6D5nEAa1F/vSzXkWEI4K2LQWk
         9IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798091; x=1731402891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4G0QFpDZpyh7jivQuglDMqb6yzlT1rpR4Jl1yN+DF0=;
        b=n7jhK5JYDGhha0WqCui3dqUV/axO7Uc4NpEL0jX+20LCQETRvletbq5qzJx4+5BTw1
         58jRpLAtruvAJrS8hoXSDQoMJZTtpGc/2YWqC2g3LOCu0egzu34/YZa7uO6qnazzlCNe
         dOm0nFi3HCA9kIcaorPHsFpt8nMYca+Xk3ziwH/24p8Ikzq16mRtbTV2vZ9t3arbzJir
         yDEMqLOtMUPZwLQt6QGnbgfMJJ/7l69zRoP2RSli+wP2A95lDVDFJprI+swwF2oedn0v
         aEVvub9YmIeqA/8I6n42vLfCzGFdB2sKZfEuhe2Qo1HlGZMq2jd94ODTiAhc/bCHSDtV
         fa1w==
X-Forwarded-Encrypted: i=1; AJvYcCXXj2xDgmNoZqKvlCmAiVCmAaEv5xw1+nRLvrn30KVynp/insA1IFfGAo3oqDQAjn07IydWPxDbJRSOQ+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjEJoKnxtNLSe71nBNLpun+1BQolKB57Vj2Vo+h/SQSWtVKuB
	LZgQHRGJ/JzPOJzsMX9jhfbj5FE90TrJ/iQoZipxoj+8om09aJ8I6v6+0zsLUrrLOGLoYbA0e3E
	9
X-Google-Smtp-Source: AGHT+IF89JsMTBItvysTiIBkAGPevhb1tYo18xBJg4bMSuMI6an6frnp4kuVBULT6FlhF3ie/VWuRQ==
X-Received: by 2002:a2e:a543:0:b0:2fa:cc50:41b with SMTP id 38308e7fff4ca-2fcbdf5fa9amr179020771fa.5.1730798090168;
        Tue, 05 Nov 2024 01:14:50 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm209635175e9.5.2024.11.05.01.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:14:49 -0800 (PST)
Date: Tue, 5 Nov 2024 10:14:48 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kvmtool] riscv: Pass correct size to snprintf()
Message-ID: <20241105-546ce4236046e9742cf081e7@orel>
References: <20241104192120.75841-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104192120.75841-1-bjorn@kernel.org>

On Mon, Nov 04, 2024 at 08:21:19PM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The snprintf() function does not get the correct size argument passed,
> when the FDT ISA string is built. Instead of adjusting the size for
> each extension, the full size is passed for every iteration. Doing so
> will make __snprinf_chk() bail out on glibc.
> 
> Adjust size for each iteration.
> 
> Fixes: 8aff29e1dafe ("riscv: Append ISA extensions to the device tree")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  riscv/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/riscv/fdt.c b/riscv/fdt.c
> index 8189601f46de..85c8f95604f6 100644
> --- a/riscv/fdt.c
> +++ b/riscv/fdt.c
> @@ -157,7 +157,7 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
>  					   isa_info_arr[i].name);
>  				break;
>  			}
> -			pos += snprintf(cpu_isa + pos, CPU_ISA_MAX_LEN, "_%s",
> +			pos += snprintf(cpu_isa + pos, CPU_ISA_MAX_LEN - pos, "_%s",

Just above this we confirm strlen(isa_info_arr[i].name) + pos + 1 is less
than CPU_ISA_MAX_LEN, which means we should be able to use anything for
size which is greater than or equal to strlen(isa_info_arr[i].name) + 1,
as snprintf won't write more anyway. But, it's understandable that
__snprinf_chk doesn't know that.

>  					isa_info_arr[i].name);
>  		}
>  		cpu_isa[pos] = '\0';

Not part of this patch, but part of the context, so I'll comment on it
anyway, this '\0' assignment could be removed. It looks like it's a left
over from commit 7c9aac003925 ("riscv: Generate FDT at runtime for
Guest/VM") which could have been removed with commit 8aff29e1dafe ("riscv:
Append ISA extensions to the device tree")

Anyway,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew


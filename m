Return-Path: <linux-kernel+bounces-203880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8058FE18C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CDB2873A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABB14EC6B;
	Thu,  6 Jun 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Q2sZKg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D714EC4A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663719; cv=none; b=CJb6ncn8Dy0sQEmnfa4MSm2bOHTHhTYFqZYC81mJfJck0Pr8X++zgGbvrAtmKry/9AI44XV+wN7LfQFTojLh0FAoVNzSZ5XUWXNWBN9erDoA9X+R9uRGEITuWg/nweYCRaWKFumF4M0NfzB5bYXLgt7dVShr6ubXw37AWVBUnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663719; c=relaxed/simple;
	bh=l9xAn4M5MGqMAykc7g1jfGArOcfFcSGhYTBvMYs2WIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNi24/bs/YCONZgNnetnHT2zpsxIYgURAElUSdx84hrFLt0qw3PwLMjcnWXZNO6Ha11gXkLBgPKSGDC1JMebb+MCKsLUvCeQNUCkuZok/vp/tJaxiiJ/oqbuQYAUA1YpQAo8Zd+YjU92WZ4eV69+jAdhlwvGsnP/KDGHdjS+mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1Q2sZKg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42159283989so9847505e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663716; x=1718268516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7mm47USfyF10BLhroH/wO49awuW1U7B3PUEMT0cnVY=;
        b=B1Q2sZKg3MsOxvA5pcFl8Yot0bpsvDbNcbe4jPIt5MyHIvqOKCe9bhMUAe/i089QV6
         27YSo301nHupBYyGOfqK2fcnO5HYoht3ELeXtZPl3HwhWDOeSYbqW0m/yF6VjOLC6p8U
         4MAfnjqie/yWnt1P98leGjFZV86uK0/IamvVxI8+ghZ/Zgj838tyN64AQTrKFLTjmox9
         bUg7gCf0GaHCFkblGWl9LyvglTUQLd9EaRPfX2CsZfVHooWlaMne2UQj45xQKGEn6wTN
         x4cLJQqabdBGJdTR2513L30UgOaT4t+x6gQ4VbCsoqJ5IPlML2Ivifplg1bbvXEDhaaA
         Dlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663716; x=1718268516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7mm47USfyF10BLhroH/wO49awuW1U7B3PUEMT0cnVY=;
        b=HonOZHJPCUHRba/ArCEVZrqmGCWXGS6Ljvf1NKv4lnhSAzfVoGrGoBD1jPgs5FLW8M
         /iZLI4nDdI96QXy4PxXoAFq8DF2y2AxkSD3OBGWsY2UFqw6tBBrSRqwBtpV2joqc76G3
         JoKRV9ddDXUwNI0nVm7ZPSOqVv71FW7VEbpG1G+n0SBWm1r7o3MmROqfZ+43hF/D1ZUz
         Wd25gDQMNohsEp3syVvem3A+o+g7F3ayfHg7ftnitlZLbSFmPTSOUayPn/x7M0ZMaX6Y
         4O0oNkG07IEGBfGg2p9yCaCE6mzUHgKIzEiYz2N3+3xupQv9A36NmiFLlRELTXRxImRR
         9mzw==
X-Forwarded-Encrypted: i=1; AJvYcCXBVRjAu4oZBpPdQ3x655wiRVuz72A4buG7rAuOQm5VJ/toSJ8ZLphLlYhHWSA3YixVq7/hsLCaxGYMQYz6o4pmGTlZL9/kYgEwL8Xp
X-Gm-Message-State: AOJu0YwBVjFPpVUQzO2kWv3SNza0IREewM6ckT16DX1jxiBUk6Bd4lAh
	IMvqQKwIJeRta5Q9Rb6B6+I28zf/ejo+rYJzHGUVEH/5UOAuwfo5
X-Google-Smtp-Source: AGHT+IEpLEZ4pLzlDnzqRB1nU9qOswtuCAFnRdf2l6Ek4pUng3hIrk4laZ4SNADkauj6uLxYLwoiRw==
X-Received: by 2002:a05:600c:35c1:b0:416:8efd:1645 with SMTP id 5b1f17b1804b1-421562c354emr56334005e9.7.1717663715889;
        Thu, 06 Jun 2024 01:48:35 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d49esm46855915e9.27.2024.06.06.01.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Jun 2024 10:48:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/3, v4] x86/fpu: Remove init_task FPU state
 dependencies, add debugging warning for PF_KTHREAD tasks
Message-ID: <ZmF34YbJPrV7WQzn@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
 <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
 <20240605162610.GF25006@redhat.com>
 <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
 <ZmFziN0i10sILaIo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmFziN0i10sILaIo@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> I changed the debug check to test for PF_KTHREAD, and to return NULL:
> 
> +#ifdef CONFIG_X86_DEBUG_FPU
> +struct fpu *x86_task_fpu(struct task_struct *task)
> +{
> +	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
> +		return NULL;
> +
> +	return (void *)task + sizeof(*task);
> +}
> +#endif
> 
> ... and the NULL we return will likely crash & exit any kthreads attempting 
> to use the FPU context area - which I think is preferable to returning 
> invalid memory that may then be corrupted.
> 
> Hopefully this remains a hypothethical concern. :-)
> 
> Alternatively, this may be one of the very few cases where a BUG_ON() might 
> be justified? This condition is not recoverable in any sane fashion IMO.

And promptly this triggered in live testing, because while kthreads do not 
use the FPU context area, the current fpu__drop() code does call 
x86_task_cpu() even for kthreads...

See the two new 4/3 and 5/3 patches in this thread I've sent that clean 
this up:

  [PATCH 4/3] x86/fpu: Push 'fpu' pointer calculation into the fpu__drop() call
  [PATCH 5/3] x86/fpu: Make sure x86_task_fpu() doesn't get called for PF_KTHREAD tasks during exit

I'll also reorder the patches to apply these fpu__drop() changes before 
adding the debug warning.

Thanks,

	Ingo


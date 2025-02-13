Return-Path: <linux-kernel+bounces-512510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDADA33A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38337188A223
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C120C03B;
	Thu, 13 Feb 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGrcc83C"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8320767B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436773; cv=none; b=tBGfAPRy8UE2PTzwiigNOixKfqvc0BccNUmAk+4ADiGjEBtd4Ag3fTbDpyye/JVWk1c5FWraz5vou0qXaPWnW+NJjMOeehjRyNKHibig3KP4XqCHgfLCCikZmfiwdPUXk1/iWbQ08lyTJBPPOyNzmsOq1VqKUianuSEHn3fMPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436773; c=relaxed/simple;
	bh=aeltaq5F+EMvjtZgSTQeyt72v0Z1F94i/IxbvZGjCiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9TGMJKh+64OxKI3P3TxB4CaKgDDrnP8ams/93atfVTNFGmZkstF28dtwOJ2qwm0lrsNe7r9+CK55DF/hx33vuiv4n9702ZWvXkuuK9j2bVF7aJUom60SiB5kyxvg1gEXw+qydgVbzqz/fdo41Qd7CPxfqHos8ylFkFLdnGMBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CGrcc83C; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4bbd3cff198so373501137.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739436770; x=1740041570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRQ3dUIptAKwY6MQYxUEHGw6dXXH6tF8Q68IhjO6QLY=;
        b=CGrcc83Cg5kvPo/fjxbpDmNB9go8s1rJtlk8neDix/jTiFs5ztLGObdJeB2BAYmmuM
         cAhcZqs54NSB781n7Q31UAI4ITwrbYb5N6O1LMwR+5urOYAH6Z9+dDqS0VZnnFTyRkXW
         XCVHlRIKnQ3yckTg+u2meqbycIofUUtEBRKnLxOLliNpboecCRzlcjBcPwRnVRItwxqf
         t/f5+Dgop4QCvx0LoMFY+YGF1WLzvmjPhQvp3wqrJon/Ax4mV22SmZVwl4UfnZJ1znyi
         CXx7AY33togDQOjnWy73ZrTJ8MOuZZ8bDUjs18A+tO+GCNCPtaHXmbvpsPa5pyTMxi11
         iJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739436770; x=1740041570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRQ3dUIptAKwY6MQYxUEHGw6dXXH6tF8Q68IhjO6QLY=;
        b=EqAKi7upHVT7aMRBGqWxCUK4yBrM9dYgyDYmb1YR8Oj6yKOx8EhSYeFi7GcNF7MZZ5
         ph+DZLc66MtsUrj74MSeMclthCJxQyPQzZiYVzsltNVLy12LbbSIntehaXpcrcUjUS7P
         5T3UizU6W3NsBUWZr/r4QiDqLZuEBTSleQoocQwcUAvFOLdrExiB2hEyX1vMt9upDHlK
         4D7qV91Ge9t1HWDYOd/dbvdCuQbQTuXoviIC2rQtJNyneQXml70dYQfa8iOxD9Hlo+ok
         uGP97zNIxcsLb5SnEc8aV+3d1jzgBl02bwNsa+wMyWB1PNV/mh8Fubi2ckm0CVD8uLS7
         xE6A==
X-Forwarded-Encrypted: i=1; AJvYcCU5sQaRCB5rFcV9AlMYMtmDLDOA0Vl7xkNmYqjpdlUeYSK+/hAOYDIhBaaltUph843+khDFnhiOdIPjZsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ADHkBnxYHxEOid0B9SbdLmNK94YU1Qw4QFd/fwgsuKVqNSLT
	I3TkOOMK7Er2kU4EAqcAWkYXc+lFBW0sNuPazG2gkZElvRmifYXNPsCn6KEvUAT89p+VSmkYUkJ
	azHkIr1hLTXrZo5ghvdGMJpuY6SVx3n88uvX1M8SYnrUa80lsVXw=
X-Gm-Gg: ASbGncsPUZWAbui1nzBaMDoBZh6WJ4iYeMJvF3yktkzdalNxba6xh4Cj30e+fgmxbqh
	/2KVoTITZYCjnF/VFv94IkyxR4/cBs6TGCyrTmhxiuhAZypg+XOkNsIbDxATRHqKxJtQ4ouHj3Q
	0=
X-Google-Smtp-Source: AGHT+IFnDuYWfE3Q7CuyUtwzYDsXyv9n6Um+OIw404XCQ3zk/sY/TE8+9JT3A2om7er1oTaCb7OwGKlKwkPboIKhvIY=
X-Received: by 2002:a05:6102:4187:b0:4bb:d062:452 with SMTP id
 ada2fe7eead31-4bbf207219fmr5886514137.3.1739436770171; Thu, 13 Feb 2025
 00:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt6Cuu6=OO9w80yhJbZB77Q0qf7nzYdvjbgDbgAw6t1jw@mail.gmail.com>
 <8634gku30g.wl-maz@kernel.org> <3902208d-8814-46fe-ba98-3db833b9a886@stanley.mountain>
 <86wmdvs1oh.wl-maz@kernel.org>
In-Reply-To: <86wmdvs1oh.wl-maz@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Feb 2025 14:22:39 +0530
X-Gm-Features: AWEUYZlmVi_oOrzpHstaYQ-1DQU14Cx8usJ0Mr5C5xxxvEXLMKHSQVpMklUZaec
Message-ID: <CA+G9fYtKxd8C5W4e5sO93TMC77pRVyJYL8w+i6q988jHk6ztxw@mail.gmail.com>
Subject: Re: kvm: nVHE hyp panic at: __kvm_nvhe_kvm_hyp_handle_sysre
To: Marc Zyngier <maz@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, kvmarm@lists.linux.dev, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux.dev, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 19:30, Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 12 Feb 2025 11:41:38 +0000,
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Tue, Feb 11, 2025 at 11:36:31AM +0000, Marc Zyngier wrote:
> > > For the crash at hand, which clearly shows nVHE, can you report
> > > whether the following hack fixes it for you?
> > >
> > >     M.
> >
> > No luck, I'm afraid.  It still crashes the same way.
>
> Right. It was one level deeper. The following change fixes it for
> me. YMMV.

Anders applied this patch and tested on rk3399-rock-pi-4b,
and confirmed that the regression is resolved.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Link:
 - https://lkft.validation.linaro.org/scheduler/job/8119717#L1251

>
>         M.
>
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index f838a45665f26..b899d815d272f 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -501,9 +501,22 @@ static inline bool handle_tx2_tvm(struct kvm_vcpu *vcpu)
>         return true;
>  }
>
> +/* Open-coded version of timer_get_offset() to allow for kern_hyp_va() */
> +static inline u64 hyp_timer_get_offset(struct arch_timer_context *ctxt)
> +{
> +       u64 offset = 0;
> +
> +       if (ctxt->offset.vm_offset)
> +               offset += *kern_hyp_va(ctxt->offset.vm_offset);
> +       if (ctxt->offset.vcpu_offset)
> +               offset += *kern_hyp_va(ctxt->offset.vcpu_offset);
> +
> +       return offset;
> +}
> +
>  static inline u64 compute_counter_value(struct arch_timer_context *ctxt)
>  {
> -       return arch_timer_read_cntpct_el0() - timer_get_offset(ctxt);
> +       return arch_timer_read_cntpct_el0() - hyp_timer_get_offset(ctxt);
>  }
>
>  static bool kvm_handle_cntxct(struct kvm_vcpu *vcpu)
>
> --
> Without deviation from the norm, progress is not possible.

--
Linaro LKFT
https://lkft.linaro.org


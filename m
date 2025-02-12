Return-Path: <linux-kernel+bounces-511056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC710A3252D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7C1188847D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C920A5EE;
	Wed, 12 Feb 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yeh/n+xX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10B2080F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360505; cv=none; b=LUExHem5yC435F7XXhHNptjTVcW0Q/75G7hNXk5r6EsOQt1zYsfeDcSEWPyPWUW4kRSpUca2SS1mGS7C4c9tmTTqUjcPaFt0oWcfM7BDaHIcCYT3erDB2YiOBFS6CY34G49uEcJloj896mmQAG/0vZQWu3RzByY72U/MKOTQjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360505; c=relaxed/simple;
	bh=JeJ2jv2BwBrIa809Su81UECkCgacincdGK1guJn4zFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj9ivpiM2ASNeEAnI0ppmMZPI4I2oSo6P48jzisac/uvSNs2+uJvT7wiRfUknbz6Uw9H5cL1+/U/bOrjsI9O8T1mCpqo8zgi3DRe2jurgiCDzGH5E9KChXevByida6qkOLhqz13OP6V9uWYdouIgdZ9MVwHh2kedqT7X1eP2zqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yeh/n+xX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso1508906a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739360502; x=1739965302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0j3HfohIwJISbsXU0pbsmUuYrw+P0a5WGZgVgQVxGg=;
        b=Yeh/n+xX0Tak2hMWoiqQBs5EAgslLgLrfuAK4zXQN5Trsrm0O7OuLm7LSbj0WO2tPp
         cBx8JETWBpsLyD2ciinTtfapSNvt3zp8ZLptWOnyC7rAOtrS7LaRyKMQIb+MVT1JLWnU
         /RLrXMMlYf+ZEDOI4bWi+ANbRQ/uzPyfMMrCdd/UJdxkJw83m3DfuEn+nY5SIotUzpdC
         s6UO1if9d072eEwx9XoWfYT8dFKVMf7Qg9dz02YtN8KRgcHbdIrM9C7WZzClE0g5IqvA
         1cEEvV2/JTkfiQ5Bl8+kYIMC4Hd01qzTHVvopDObF+JHZrftEta1LNRxvav6RL8kFbMP
         9Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739360502; x=1739965302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0j3HfohIwJISbsXU0pbsmUuYrw+P0a5WGZgVgQVxGg=;
        b=kLL/M36fQ3Q1FpENJwf1by69FPSdceaq3W+UXQQsJlOhGjAVrAiqqatELKczj3wIpC
         LiJUfZuWFjWdy31O66cG7IvN9pc0fdZ0TbCdOUlZjOXJvL7j2nlo5OWbTkZwJJaWY63j
         zo0PE6wKOiBKeT0fFK1HzmtJjFYi84MjBYBN2H13BllUdoO9f7d9SNbgDH9+WyKp1oFt
         w38lildpBvDHT26xP3RysAUARwS0Adj1E1sUISe8hZJBWSH3e0u+U3N3hwhzyDZh1zWG
         rSgDEn8uZqcp7paUXhPDngwrtXG9VfnuWiOhqZbm2F0c+YwWP1AgezPCG4F0K8zaYwdV
         zekg==
X-Forwarded-Encrypted: i=1; AJvYcCW/I9clel/8jJO/LHLes2eppXUCYtSy/Qp/sYyHbQyzFAlS68w3YNGQczfBEnegohjanCFAjKBOt2sZ5U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzlPrqz78+O4Vl446TlgCZgA54DMgEvr8YlZc5XL9e1/TWGJbB
	rUSw5OEkD5le2Z2Ag+fsJwRvVA/qVcJBLCn3COjBxn3r8iwKYFmBPumAiAOZ+Wr1LRt+rxli+tW
	4
X-Gm-Gg: ASbGncu8nyhDy8Uob4v0HCk+LUT5WrHkgG8gmmye+LjM1L4UZizy81nS55QYyftTlbr
	EZC1Y5I2HPZfgHpKqxEXtvUj3sdijcrPJMwxRWXghQ/ydIIe/5XzhM7MeCU8yoZ/URzNfTMI3fq
	wjCPmHeAmozRPvycaZum9IsWz8Xu282QCnnTuozScqypIm8tIVDXKvWiieQGm4Prd55E4qgmflA
	GvCT0SrAUvm/X7jjLThxmm3XDY/YhGVQXT+lQtEj6Th4iarydHVOK1KAv+LKWq+ffZsPDKX7m8R
	ZeCa5Eqjts8WEJTyKeuz
X-Google-Smtp-Source: AGHT+IGjOAjmf6XjmHjeaqxJH3+fWyGiM1rw3hi7aac7PC39lxHRaWXOjo/vo6+0foG0vbJvgDt8bQ==
X-Received: by 2002:a17:907:724c:b0:ab3:992d:d98d with SMTP id a640c23a62f3a-ab7dab331c9mr726269366b.0.1739360501945;
        Wed, 12 Feb 2025 03:41:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab772f893e9sm1267296966b.65.2025.02.12.03.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:41:41 -0800 (PST)
Date: Wed, 12 Feb 2025 14:41:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, kvmarm@lists.linux.dev,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	virtualization@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: kvm: nVHE hyp panic at: __kvm_nvhe_kvm_hyp_handle_sysre
Message-ID: <3902208d-8814-46fe-ba98-3db833b9a886@stanley.mountain>
References: <CA+G9fYt6Cuu6=OO9w80yhJbZB77Q0qf7nzYdvjbgDbgAw6t1jw@mail.gmail.com>
 <8634gku30g.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8634gku30g.wl-maz@kernel.org>

On Tue, Feb 11, 2025 at 11:36:31AM +0000, Marc Zyngier wrote:
> For the crash at hand, which clearly shows nVHE, can you report
> whether the following hack fixes it for you?
> 
> 	M.

No luck, I'm afraid.  It still crashes the same way.

https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/anders/tests/2steTT4f2J8ZJjc3jNJFMuow9Cb

Click on "Logs: html" for the dmesg.

regards,
dan carpenter

> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index f838a45665f26..cb57420a07de2 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -556,7 +556,7 @@ static bool kvm_handle_cntxct(struct kvm_vcpu *vcpu)
>  		return false;
>  	}
>  
> -	val = compute_counter_value(ctxt);
> +	val = compute_counter_value(kern_hyp_va(ctxt));
>  
>  	vcpu_set_reg(vcpu, kvm_vcpu_sys_get_rt(vcpu), val);
>  	__kvm_skip_instr(vcpu);
> 
> -- 
> Without deviation from the norm, progress is not possible.


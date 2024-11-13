Return-Path: <linux-kernel+bounces-408209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EFA9C7C29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E159B26BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571D16A382;
	Wed, 13 Nov 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1He6VNd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93313D2B2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525312; cv=none; b=iSRk7PgpsmUEReh0BmwVp9pyVnKReBBk5mJFK8nROZyeLa9gY/03gGpeoLbtZyA2tHJMj4GGDiLDfbB1tMzERLZWObHaLqgM5yoyjBHu1fjRZq5sbFfVa7TqgPfAo8nIiEMbMmOMSf3EOtiAFa/I8oc8iPS3l7CxRjdrVng4quE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525312; c=relaxed/simple;
	bh=i3tQYyIobffIvj+3k8sUrKhKNjVP1WoZc6jOXGS6E7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDyBc9CPnQxriGnvzeeA3rdIpXbipFJ1UuSmh/PM8yG0vSsxClVA5SPI7DjPQs/9un6B56WsPjy3EkncmWEA7Ugqk4IzrBRYoclihWErXx2iT9Q+wojMT8ecnNwRIVkgwlL+0fJLZwagTQxXt9IrhKIK76fIi3FD3v0S1G0JNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1He6VNd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so6522921f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731525309; x=1732130109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwvBzeYB+oFxjO9ZzJuAzZ7MatGQO+jvmS1Q9roOjfU=;
        b=b1He6VNdN5Bn3Ay2H+kcrdc1ChOMXLq/Vaa5PYhbfcDCv/g7VTIYNhbPhbrz3zEb8f
         RiYqYO8aiAWniJ6LqsSINUeeAvNFxZO6t9R+qCODyNtcUbj0AFCV+h5oiRx+FpzlQvsQ
         NEqQG9NB3TBScL/bCjmWodLmRaeH1cV8qNtZZ6xmQAH3nvvM03MO6dbUiQ8qKvBjJoEh
         D0ok8MLk5kLU5RE/G6biCGGtbUjbITKL5Mz8Sk8rsESasqnGe18XcBq82OnGVMgpHOus
         eFCB492M51wXToEXbyH4v2KBFtU58LuVZY8EoIkZNaQV46SJ27ZMaz3DE7UFIgFwTrOA
         ZE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731525309; x=1732130109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwvBzeYB+oFxjO9ZzJuAzZ7MatGQO+jvmS1Q9roOjfU=;
        b=Zr95p1UYGRCYLoWjO4+2okvizrQY0Sr2RITLftaQYM4cKvouOUprfNhQqVN2P75oy8
         nEvsWzsntcivLGHVasjt47fGl0k7jqVKvDKvGhRuJu4WepqKgUwpUpccHjvwF4dutHWT
         g9DKXPKErLOd59n3BT+ghIYoulB4sabWPaw27IIPRXZ1ArjqPFJOp+iWc42jFrmQDVxz
         lL63TwMdkwnopSaUV+MkngMoYjZIv7Gzl88UR4aPONOEDps6aoeJO3sYCPf+DnGBljYh
         VuegZxJtTpW9TTTj6Z7kX/1Jw9XMk7zVhLgSeD5Yy5KzHuwy6V3Hdvqm8/6VwsgTLxI+
         j3oA==
X-Forwarded-Encrypted: i=1; AJvYcCUl5sJFHy4k8F7w5qazl6DOc2m6yJwODgW6JlL49tsKnDP3D5W0XsBhsMO5GqFAIB9mkar+jUfzJOBIdM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKaxgtaOe0apWQarxNwdtwICSN/Dlhq2upN2pvuCKRZF2mOEC
	/BEVYcFCFF8U7tDKINxemzKawmdwkIIxGxuJ6mHd3tr1db3Uut0H
X-Google-Smtp-Source: AGHT+IG9YnyQTAIodllD21sJzkhAMlb2xsCN0UYEwAkowMrqzjiuQrmEfcdhs78UPAo1rz5q9FNP4w==
X-Received: by 2002:a5d:6d89:0:b0:37e:f4a1:2b58 with SMTP id ffacd0b85a97d-381f186bd22mr23835979f8f.16.1731525309341;
        Wed, 13 Nov 2024 11:15:09 -0800 (PST)
Received: from andrea ([149.62.244.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce1bsm19004945f8f.36.2024.11.13.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:15:08 -0800 (PST)
Date: Wed, 13 Nov 2024 21:15:05 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: palmer@dabbelt.com, jimw@sifive.com, guoren@kernel.org,
	dlustig@nvidia.com, boqun.feng@gmail.com, peterz@infradead.org,
	will@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/futex: Optimize atomic cmpxchg
Message-ID: <ZzT6uRDpkuEu5GH-@andrea>
References: <20241113183321.491113-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113183321.491113-1-dave@stgolabs.net>

On Wed, Nov 13, 2024 at 10:33:21AM -0800, Davidlohr Bueso wrote:
> Remove redundant release/acquire barriers, optimizing the lr/sc sequence
> to provide conditional RCsc synchronization, per the RVWMO.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  arch/riscv/include/asm/futex.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
> index fc8130f995c1..72be100afa23 100644
> --- a/arch/riscv/include/asm/futex.h
> +++ b/arch/riscv/include/asm/futex.h
> @@ -85,7 +85,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  
>  	__enable_user_access();
>  	__asm__ __volatile__ (
> -	"1:	lr.w.aqrl %[v],%[u]			\n"
> +	"1:	lr.w %[v],%[u]			        \n"
>  	"	bne %[v],%z[ov],3f			\n"
>  	"2:	sc.w.aqrl %[t],%z[nv],%[u]		\n"
>  	"	bnez %[t],1b				\n"

atomic_cmpxchg() uses yet another scheme, but this does also look good
to me: FWIW,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


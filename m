Return-Path: <linux-kernel+bounces-192886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB568D2385
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350B21F21655
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174716FF4F;
	Tue, 28 May 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loXC9UMr"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5D2E84A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922227; cv=none; b=ryQddUQ+MoHQMIBiaStaC5cbf+dqiAVLCpBBRxRBUHJk9LuWuAC/y9d4JJn09TBAS9kO24gMRgRFt5TjJZssB5ugJ4wl2k42UYAJIvCCOe/2fqD7Ak/9i7s4+gHnpsV7/cA+Cy2myhlJbOvBTCWf2nsZED9zLY8Z4xpfw07kwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922227; c=relaxed/simple;
	bh=G6ftC1Ky0YFH8Nkf7FAna3fYStm955GB9PskFybuzAE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWJFOScd+Ql0yQVZ/EauASZ+35qovqzyrZ2nWwhIyAR+//NzHPN+btNQiSvzMi2Kvvp0O1/1a39eDBDiFw1In1Sx6RVIsWTzjE3uFtj8cnaRfzXpufrGRh2xNcKqU2zjv0hsaYoCICpaFM7gLwuuGuG35O+5MTRXKVTEEU066lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loXC9UMr; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e964acff1aso12361621fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716922224; x=1717527024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j13vRPUIFgX4iBYHnqM9mukRjmZWb4ImXkBIh2RoNI0=;
        b=loXC9UMraSH9fv2CXv7OnmfRL1LfHhT+GnPlO1j5e4otrXo1oAJytSVF+P7kTwYQXC
         6OmPMIIYvRzr3Rwo6IEykyyu0Mox9UKA+tV/9k+MTimnPC7ba4dYNeB17Ui0TSsBJnSO
         HXraqLFXZyqZHrV7pULxDBoYXQBDn2s54eeQtPrTXm8KQdb7Wi46SiscqQHn0z3FEIiO
         FXNvoX3tRjJhJnQKhnY1xomYzSMWQnYHGjpc2OMNEtkpmXILQwF+voKTAeuK0qnaNAa5
         l/I2rcXTY8j/PFTR6ToVXsbb3ooi67EdDHlYNIVJ4iQ30wNLBfwzL6oXwXG/ueVHGCu0
         GIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922224; x=1717527024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j13vRPUIFgX4iBYHnqM9mukRjmZWb4ImXkBIh2RoNI0=;
        b=HVsy01lGL+rLIoG90ZZlfMjipUX25a9DPFhOfM+jtqw+Q4UmyK76KXCLzxAvnwoz4f
         nlcG2TgMYE3VWTHQVRHoATJRX+t8u6iQcrPITG9oSIuwiCtEVepkj/LFmYylN+xpWkCz
         Deto5pt8pj6Nw2KO73Nqejj3KaCzVFY9Q2odydoJGfvlWFaJIYR+zJaHrdBscvAlXBeZ
         a1M+AWaH2k6vpcPntn1O2xvJFkieWnRviApWpuDsVY1K0CeX7Umb4bb78NSDe9NmjRUX
         gYsUswod87XZAoGeRl41NEv9mLyXHkykN4fkX2cWysM4HwUKseik3sfeHICm6lXNGl/I
         Yngw==
X-Forwarded-Encrypted: i=1; AJvYcCXCXR80qvIkErEQkObSAbWlD5QMPcUqXM0bJIOXvEoRmJgy+07urct4KpO+5O6BwUVPXX+HqjIhpg4PUXhuXphN6B6RgZ+mpuuSSwcb
X-Gm-Message-State: AOJu0Yy4TNX0ZEe4nC/VdgXkHYC9gUSjQUDA9aJ5QsMzo+qbsCjmYqWC
	U3A+fCo83OnMxNH/I4ZejVisoknUFPZ63C2jfPBdq/6DG0wpNIVX
X-Google-Smtp-Source: AGHT+IGezLffucqIhNZoBV7wMcYmoOPuUjoBGMpQ4FZEczc61vi2qZLoJRGJXry1iwGFEp+49qaLDw==
X-Received: by 2002:a2e:83cd:0:b0:2e0:c6ec:bcc1 with SMTP id 38308e7fff4ca-2e95b2dafedmr77704381fa.45.1716922223640;
        Tue, 28 May 2024 11:50:23 -0700 (PDT)
Received: from pc636 (host-95-193-70-101.mobileonline.telia.com. [95.193.70.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95be05301sm23390851fa.114.2024.05.28.11.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:50:23 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 May 2024 20:50:20 +0200
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v2 1/2] percpu: Add __this_cpu_try_cmpxchg()
Message-ID: <ZlYnbL8i69sflNEu@pc636>
References: <20240528144345.5980-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528144345.5980-1-ubizjak@gmail.com>

On Tue, May 28, 2024 at 04:43:13PM +0200, Uros Bizjak wrote:
> Add __this_cpu_try_cmpxchg() version of the percpu op.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> ---
>  include/linux/percpu-defs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index ec3573119923..8efce7414fad 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -475,6 +475,12 @@ do {									\
>  	raw_cpu_cmpxchg(pcp, oval, nval);				\
>  })
>  
> +#define __this_cpu_try_cmpxchg(pcp, ovalp, nval)			\
> +({									\
> +	__this_cpu_preempt_check("try_cmpxchg");			\
> +	raw_cpu_try_cmpxchg(pcp, ovalp, nval);				\
> +})
> +
>  #define __this_cpu_sub(pcp, val)	__this_cpu_add(pcp, -(typeof(pcp))(val))
>  #define __this_cpu_inc(pcp)		__this_cpu_add(pcp, 1)
>  #define __this_cpu_dec(pcp)		__this_cpu_sub(pcp, 1)
> -- 
> 2.42.0
> 
Acked-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Uladzislau Rezki


Return-Path: <linux-kernel+bounces-352520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A0992046
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1C7281D1E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086E18A6B0;
	Sun,  6 Oct 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqh3khzU"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38C189BA9
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238324; cv=none; b=LSOc5I/+5iu7UgcSQrMUM7nFTQDFMa1N8zBsClP0RqcKTExqNc8dRkJ/sQWwwJVmre/HBgE+O+GpuaBTprfWf5rHbRfKghV9utaJRdChJcdcqwqWBVcEZnmqPuahQ73W5jA12fb1GL9UKS6ZDucqbHP0FnYG45C+8PW0c9HK3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238324; c=relaxed/simple;
	bh=3t9+E9CkOzIKHHSuceCwjRc7U0X0Sf01y7bJoxelwWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irAWjVsUU0eITbMph+7VwirbTt66GayWN1gIRaTlJeLVDob7RlgiokW15yIQxkNp7aI7y5pOzHD1l6x8kzYLaLrz1eMKvve5YFnHmZrIfShz6h6otQmi48eFWKP403NTEt0qlY4k8bwVEJxvOvsRRa0X9QIQ0pNjGecTcbRYmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqh3khzU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b93887decso29068735ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728238321; x=1728843121; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ifUrSYHSPVHdHJVoduKWjUHX04NMhaW9v3wwctCAnpY=;
        b=rqh3khzUByvHtTpai2PvjCZxpRtCaMwItGfZmvMnF6AaAO4Mf7quADipnjiCqTTi7I
         5YD1u+h5AZWWUNbfYGmctCaldQQH9c2+Nl0BbdZEd6ODjVA4zd7yyHz8Wnj8kgw+VK7m
         Bp03V7A3qYoeJ9Ia5frcAVI2UXTPUjEqJTkL2V4my0SHXDn/5seRaXdCOlp9CHccBrbd
         w5kxgBKgiOdJm37xk8u37rt753N+yEYTc5NZGZXB+WAqWUJQPXGI5zuCQkAs9mxgBP5a
         eVP2WBv9xWuD/2UFRMhNTLXEV9Pog28IV8ULLmotNX7TGjtqzvPOl9m1TGFar85uLWz2
         Ic8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238321; x=1728843121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifUrSYHSPVHdHJVoduKWjUHX04NMhaW9v3wwctCAnpY=;
        b=reQZCo7YmQlL49GzjXvGtIB7AKcM+UsrZ+iOCULca/mmAthHQmNKUWqZfLfPACFgjt
         13gwP7kDZ66XFp2j6VQyBD4+WL/A5/FVmncCYeNq6eHrPOCBtDOCx72dcXjg/bxQp9Gx
         cyCqeqTxwM7jXfYu4wRN8cwu+jrOFN2ccvvclOk6X6B/YZPXOBMaGDoaCCd224b2G0Dx
         6cL98aZ5Qthp9PIlvZPpAYR7mgOOKbkkgzgk5kBWTQLJvToQ0OJ6KjwFSGsqZsxqF5G0
         Rj5GsgjJn+6xuHCobOWkRDKX25EphiW4bJfmLyVNDS0lJdfBZy0Jvq87D6djWjAOwgsW
         dlAA==
X-Forwarded-Encrypted: i=1; AJvYcCUry6QyOcRYZ++EDZlMk4ESR/SuL1YdgDokhsWvV4jL+Us9hIdF+LznfB/a3RYYggGuBx+Cu/+YjSHtXic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1b9p5O3zkrhoQkxYELGEtAq9393S6VnaiSiZfgISSljvLs4g
	Hpgxd9SoFdCnu6vLrssKbBZM84G4oRgKMMAz6w5TPtBBOVnnMfoU/16BsuN+jdk+hxtMNlmhi3I
	=
X-Google-Smtp-Source: AGHT+IGsV/4alrASeuoSgOfzTV6TQhEtk58m258R8GIYcduuYNXsWKmOLFCw4X2JUrLC+VGgGpHEMQ==
X-Received: by 2002:a17:902:cecb:b0:20b:b0c1:712b with SMTP id d9443c01a7336-20bfe05e682mr132892225ad.15.1728238321593;
        Sun, 06 Oct 2024 11:12:01 -0700 (PDT)
Received: from thinkpad ([220.158.156.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a4b50sm27426525ad.306.2024.10.06.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:12:01 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:41:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Carl Vanderlip <quic_carlv@quicinc.com>
Cc: kernel test robot <lkp@intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus/mhi: Switch trace_mhi_gen_tre fields to native endian
Message-ID: <20241006181158.s6g6h2lwn6vxgv2o@thinkpad>
References: <20241004170321.4047492-1-quic_carlv@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004170321.4047492-1-quic_carlv@quicinc.com>

On Fri, Oct 04, 2024 at 10:03:20AM -0700, Carl Vanderlip wrote:
> Each of the __field() macros were triggering sparse warnings similar to:
> trace.h:87:1: sparse: sparse: cast to restricted __le64
> trace.h:87:1: sparse: sparse: restricted __le64 degrades to integer
> trace.h:87:1: sparse: sparse: restricted __le64 degrades to integer
> 
> Change each little endian type to its similarly sized native integer.
> Convert inputs into native endian.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402071859.8qMhgJEQ-lkp@intel.com/
> Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>

Applied to mhi-next!

- Mani

> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  drivers/bus/mhi/host/trace.h | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
> index 95613c8ebe06..3e0c41777429 100644
> --- a/drivers/bus/mhi/host/trace.h
> +++ b/drivers/bus/mhi/host/trace.h
> @@ -9,6 +9,7 @@
>  #if !defined(_TRACE_EVENT_MHI_HOST_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_EVENT_MHI_HOST_H
>  
> +#include <linux/byteorder/generic.h>
>  #include <linux/tracepoint.h>
>  #include <linux/trace_seq.h>
>  #include "../common.h"
> @@ -97,18 +98,18 @@ TRACE_EVENT(mhi_gen_tre,
>  		__string(name, mhi_cntrl->mhi_dev->name)
>  		__field(int, ch_num)
>  		__field(void *, wp)
> -		__field(__le64, tre_ptr)
> -		__field(__le32, dword0)
> -		__field(__le32, dword1)
> +		__field(uint64_t, tre_ptr)
> +		__field(uint32_t, dword0)
> +		__field(uint32_t, dword1)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(name);
>  		__entry->ch_num = mhi_chan->chan;
>  		__entry->wp = mhi_tre;
> -		__entry->tre_ptr = mhi_tre->ptr;
> -		__entry->dword0 = mhi_tre->dword[0];
> -		__entry->dword1 = mhi_tre->dword[1];
> +		__entry->tre_ptr = le64_to_cpu(mhi_tre->ptr);
> +		__entry->dword0 = le32_to_cpu(mhi_tre->dword[0]);
> +		__entry->dword1 = le32_to_cpu(mhi_tre->dword[1]);
>  	),
>  
>  	TP_printk("%s: Chan: %d TRE: 0x%p TRE buf: 0x%llx DWORD0: 0x%08x DWORD1: 0x%08x\n",
> @@ -176,19 +177,19 @@ DECLARE_EVENT_CLASS(mhi_process_event_ring,
>  
>  	TP_STRUCT__entry(
>  		__string(name, mhi_cntrl->mhi_dev->name)
> -		__field(__le32, dword0)
> -		__field(__le32, dword1)
> +		__field(uint32_t, dword0)
> +		__field(uint32_t, dword1)
>  		__field(int, state)
> -		__field(__le64, ptr)
> +		__field(uint64_t, ptr)
>  		__field(void *, rp)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(name);
>  		__entry->rp = rp;
> -		__entry->ptr = rp->ptr;
> -		__entry->dword0 = rp->dword[0];
> -		__entry->dword1 = rp->dword[1];
> +		__entry->ptr = le64_to_cpu(rp->ptr);
> +		__entry->dword0 = le32_to_cpu(rp->dword[0]);
> +		__entry->dword1 = le32_to_cpu(rp->dword[1]);
>  		__entry->state = MHI_TRE_GET_EV_STATE(rp);
>  	),
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


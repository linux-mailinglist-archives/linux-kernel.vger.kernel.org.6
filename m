Return-Path: <linux-kernel+bounces-550995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680EEA566C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647403B205A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F12217F31;
	Fri,  7 Mar 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTKeeARZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90226217709
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346899; cv=none; b=QpqULLC0pgWIRUVC6ThCjznY+/hktC4YwuqejUzDkK6xz5TJNGbh/WNN8H9tBH2P/6Ju7SARWTE8aIu4FYKUCF/ktrI1zMLX3N40lp6zllMvKuGMBqglnyoFUrfFkWyn8DZFAJVWp7a3rcf3nA9UWH3rhk+ogUzUWOkbDvRXxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346899; c=relaxed/simple;
	bh=77bK4Zp/TbJCp4MDtt6BamPlf5APkGCXJN1UMIG44Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOn9AzEPfqimEQumCR0qYaWMTu0e/47uFUHsm3SRCiDaObdMHSWVApf3TWWMrDqGT9GV3iLNa5B5ltBFju2ghtrpcCvHgDxpO4XqCl8nLfC1tRshLNv21u/dCe2wktIFCprdrrABIvOe2zrOsvUcu2Z8oqYnB4fcVbUuzDRJHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTKeeARZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223a7065ff8so2440895ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741346896; x=1741951696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2KHuSHjoctZDpRbteDuBYEVJTRxTt8Y9MylCsxslIVY=;
        b=jTKeeARZ+bslbWFsD97aEFoRpd3SqFTHIvLlPCYh/OWWxpUdWfW/WncupTBctMd1ME
         zbmA2dGyBK6qs2gUhtl5Smk9M1Uc+qWlqpvFtd/41xpfEs2UZDlXXZ1BhsgGzPXRN1md
         t3LycwxvDj1sO2F4uhnHG5zbfKTyVBnButv12EsUGIb/DToYzCBQ68I6jRutYSU797Qa
         Y1iHZmaoWjcPZOZAZW74HCNZPUdeqtyYobyUaKuYxfZ4Q8Art9amBCU/ecHaxkq5b5pZ
         ehbieWMyNiOI5IuVZrz9dtQCqSUUBx1Cxa5gwKpXgqOBadcCDGfVSlrO6RMECIEVgBAq
         644Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346896; x=1741951696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KHuSHjoctZDpRbteDuBYEVJTRxTt8Y9MylCsxslIVY=;
        b=jWeV2s+oUesxI5Tm9esJItmdWblGnvPl6g6arGDViFWX2P+mxnG8m0tYulQEluEBFj
         tRRw1rQz56l4qVd9TEdiqp1GBdqPU/yEg+j7IQWvyePqhtDXfWaNBVvWg7hsHeLXeD8o
         7u92eZYDc4o4v2fKzQ4X/sVzbNVMKKKVBcpNOQWp/SgG8yxy0kSs4jg3RjBY9NW5q7Hr
         +wUwSggKvRCuLLesW1abln8ALwKfoPmfZ3GWt6kBmYHdqYhPIinSg/r2U9zbnRKNMy9O
         MjFLORl19e9SCt6I3A14NbMWLeRpmyNZkwPELbKbsTZfBULQgmw879teKMdP3iWV5t+c
         r7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/GuO5Ucg34S/Sq20EF09UGFEjnKqwEd8J4Zrl3fSeTYIVuBpJZ6Qv8YUN0uFfPEpjpTvMgqaYraNq6M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFssjm4f+zM0+YrVGH0c2x+88cQ+ahXsPct0YOWE7qnEk7SUl
	f8vdPCYfcNARcCwaFx6AEClnu8/pX5I5UNDchCJpcRQd4XE9Z2DhxXh93lDIgWI=
X-Gm-Gg: ASbGnctQX+Qs7+RPcV60RLvCt8EItwW++ekiTn+Rj6iNOWO9JRR+gAnuZV3Dxj09BCI
	ZWppt9284KuvIfLaotRPM4XNgtHNuVlUzHbZ4A3V/Y3ct4tF4gIb5jLadZQ8Jz7uWLy5qJ3Q/qa
	TRmbLby7k8JnO6cgwJDDVO9iUZ9eo+PGZpVcyYL1wQyMpuPVNK6LsIZFqhKAFwnHj+A+5cSSuK9
	5Eix6FTosbT8MlGQ9cGyw/sKNsXmqkqex46ijNltjX+2mQitxP4pQsft3bBmYLnMFFLI6GCcBY5
	HoWETpf38Q769aPdj54vfa32A8P4CmwZa6XBmIuIj8rQwA==
X-Google-Smtp-Source: AGHT+IEvps1aGNeyDSEfmuS/2kZ/UIoJVeC4FQ3bEv/wYy7E3JSdL5e5iwjVJ47HjPenjvhwUyieNg==
X-Received: by 2002:a05:6a20:3943:b0:1f3:289e:36d9 with SMTP id adf61e73a8af0-1f544c98c99mr5849762637.40.1741346895822;
        Fri, 07 Mar 2025 03:28:15 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f7281sm3085274b3a.94.2025.03.07.03.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:28:15 -0800 (PST)
Date: Fri, 7 Mar 2025 16:58:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250307112812.3la74kiomyqbzhk5@vireshk-i7>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <e3637b13-1f51-445b-8d9d-bd53a691eca3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3637b13-1f51-445b-8d9d-bd53a691eca3@gmail.com>

On 07-03-25, 19:57, Akira Yokosawa wrote:
> Didn't come up in your diff, but you need additional changes shown below:
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 656d2208467e..a6c1961cc535 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -285,10 +285,10 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>  }
>  
>  /**
> - * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> - *                        @n+1. If nothing found, wrap around and start from
> + * cpumask_next_and_wrap - get the next cpu in *@src1p & *@src2p, starting from
> + *                        @n+ 1. If nothing found, wrap around and start from
>   *                        the beginning
> - * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
> + * @n: the cpu prior to the place to search (i.e. search starts from @n +1)
>   * @src1p: the first cpumask pointer
>   * @src2p: the second cpumask pointer
>   *
> @@ -306,9 +306,9 @@ unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
>  }
>  
>  /**
> - * cpumask_next_wrap - get the next cpu in *src, starting from @n+1. If nothing
> + * cpumask_next_wrap - get the next cpu in *@src, starting from @n +1. If nothing
>   *                    found, wrap around and start from the beginning
> - * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
> + * @n: the cpu prior to the place to search (i.e. search starts from @n +1)
>   * @src: cpumask pointer
>   *
>   * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src is empty.

How did you find these ? I only looked for build warnings / errors earlier (with
make htmldocs). Anything else I should be doing to find these issues ?

Thanks for your help Akira.

-- 
viresh


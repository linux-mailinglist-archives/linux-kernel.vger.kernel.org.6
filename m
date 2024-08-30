Return-Path: <linux-kernel+bounces-308165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F99965817
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29DB1F24DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87881531F9;
	Fri, 30 Aug 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VrQSqSkr"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798B13E40F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001707; cv=none; b=lbwH+d5ORM8jnI7TDrSUGiEXORFTNBQJ6qk7/GujTP5WY7JSi5dWb39PEnwv/SGrSTiblM/xwhb671ismoNuuDcucrAIBwG5+VIqcoa58k6Q0Otj1oG3yFs/Mr2cOstTnTG+CYdV4Io5j7aHwcG07Ohxiik7f97mfgDbDEdScqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001707; c=relaxed/simple;
	bh=4GUSPODpLpXIBM/udMA/qJLR/gJRdsYqioWTQ9RvzxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NADz+eilEQy+LTaRf2oF19WDYeBCvnhbK0Fxe7c4kX3M1rck7nwQMq0XE3jy5fcbMs1K2MTyNFHBM3tMv0Uit3H2z5Got4bxkD51Ut5ag4VEWHYT3jnjbSU0htAzFf5RG0qSPwVHp8SU4UJTg302rmnX4hIeNFTp2E/z3U6l1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VrQSqSkr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37196681d3bso924667f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725001703; x=1725606503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCS5TEESTr5e9Lr43y0GfLDajqqNRmNFbDHOZayEVCE=;
        b=VrQSqSkr7JXQrzp15ot4o71inst6+sXv5vuMgWh+HHGcBlMRM4rnV7NrVwpH4UnX3z
         GgA7WmkAisAlQ2/g8YWYQByQ+6yTLC5Ppypv6mvw3f5gqAjykvclbQ2CQO654d6NAugw
         U+T0DETF79++OHx616ncjnU58i33KSbUgPVuEzpm1SVP33FlHQU6vTjAmOPv1MageDD7
         X4VPIL05iZKRSzUgcJ3nTwHS6LTNCB0MiQcONtYWfABYb3wh3eePlUpg7mGLFL2t1NBF
         9INnWJ4AF1L+0/Js+alWRlKDeG94ftnB0o7d/O0K7zaVzPm8Yh7hwll/zx2jPVsePgJk
         uOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725001703; x=1725606503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCS5TEESTr5e9Lr43y0GfLDajqqNRmNFbDHOZayEVCE=;
        b=FXoRgUPQFE7n3rU/dkLcYI7BP6ZDVgH9Be0AIYhPUkAV561lAs10MBsRIwVvBEbLDH
         M7r+KUbJ+tDGibobnUBXRda3thDwU/eL+tN/RSKhExTCO+i78sytj4JY4bEGuAec9mWY
         TmHdUg35GSWHsjA9RC0GOn+UzWsjpUf/Nt2AiNbg0nGIryhuyecxeDDIlB6luBrF8a46
         7rL1bGS1XYfyRXFKthyNHM5bWEPAXxgW3nDCpVgGABViWvW922Zc6Elzmq6NE5pEpLbC
         dRfOFtWjp7PFYRCuc548VPnL2GRap6Lr+Ar/dcs9Fv0SzvKC0bUSzGl82LmtkBl8NKyD
         bntQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuw/3mt/TCxJSE8CXuN5+eaXlLZZl1p+V3nR/bot6YfV7SddMA31qlGYdZVAv92SqK2pxQBwfEWnIiY94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1t/chIs/QU8TqQPHWr/83VX8ASuPjKjyVW706vdb9Te3UHuO
	yDLMmqfCzT2B/9mzlDWK1vvy2Bkx3CcSqQArTtLLMohvBpatvkQ2wS9YMSKNsvY=
X-Google-Smtp-Source: AGHT+IGPcYfQC61zTRVDY+JEAqWSvbxDngClQz+OhhcqpV9NC9cBnCGp6fIjWo7d72IwzsuKFzR4EQ==
X-Received: by 2002:a5d:628b:0:b0:36b:a3c7:b9fd with SMTP id ffacd0b85a97d-3749b5868a2mr3322544f8f.56.1725001703449;
        Fri, 30 Aug 2024 00:08:23 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9c188sm3158578f8f.55.2024.08.30.00.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:08:23 -0700 (PDT)
Date: Fri, 30 Aug 2024 09:08:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: The percpu memory used by memcg cannot be cleared
Message-ID: <ZtFv5jDx3Y3NMPrH@tiehlicka>
References: <20240829170644.15588-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829170644.15588-1-liujing@cmss.chinamobile.com>

On Fri 30-08-24 01:06:44, Liu Jing wrote:
> hello，linux boss
> 
>         I found a problem in the process of using linux memcg，When I turned swap off, the memcg memory I created with the following script could not be deleted with echo 0 > memory.force_empty, as explained below。
> 
> ----------------------------------------------------------------------------------------------------------
> step1：swapoff -a
> 
> 
> step2：use this script to create memcg
> 
> #!/bin/bash
> mkdir -p /tmp/test
> for i in 'seq 2000'
> do
>         sudo mkdir -p /sys/fs/cgroup/memory/user.slice/user-0.slice/test$ {i}
>         sudo echo $$ > /sys/fs/cgroup/memory/user.slice/user-0.slice/test$ {i}/tasks
>         sudo echo 'data' > /tmp/test/test$ {i}
>         sudo echo $$ > /sys/fs/cgroup/memory/user.slice/user-0.slice/tasks
>         sudo rmdir /sys/fs/cgroup/memory/user.slice/user-0.slice/test$ {i}
> done
[...]

I assume you /tmp is tmpfs backed.

> Therefore, I want to know why swap affects memcg memory reclamation,
> echo 0 > memory.force_empty this interface should force the memory
> used by the cgroup to be reclaimed. 

If the above is true then you simply do not have any backing storage to
reclaim to. You need swap to reclaim tmpfs/shmem memory.

-- 
Michal Hocko
SUSE Labs


Return-Path: <linux-kernel+bounces-249743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B3A92EF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4481C2261D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0716EB7B;
	Thu, 11 Jul 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl5uupV0"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1116EB4F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724271; cv=none; b=gbzXC3E5CtmrdOdL4Hc1pKu67+oaBb09cnjgKV+CHu/Ljtpck6h3y840VgYoA6j3fdIXXAFPH8vN5caKhpFtgtjjZ1nY9YD7OiuBJFq5W977zqVusT42xr565mU8CRI+s9ZHbbVi9DNFiijA/dfl/4qp7+9qezQOQk5OHGivKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724271; c=relaxed/simple;
	bh=w1p7DLj2ajZeWCIL1A/Toflabc+ShmJoycyuFbQIuJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVW+0vNSr7NrnB5NxuA7SUgUz3EFwACrP8dFlVhrrb67V1uIT+l49HOsBflTF170HVQn7aQCL4iIJ4VJTKwkBM1LtvW1HaoSjhkaqc4WJnhhRhV/X9q4gtaZ6ARcfFei0A78Ih93SDxTJasIiAbMiswJZVet7Ddeyy7poIN8L1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl5uupV0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb64d627b0so8182875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720724269; x=1721329069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtuyBw2dMReN+VUaJ64hh0OUXeS/xLFmm5PYezET7JY=;
        b=Jl5uupV0SJWueMj/VM/ZRFPfR4NpReKnps6bgSPrRdU/rRlnWQ8syvNMQVmMaXSsIy
         IBTB0xT1qvYjzqgM1ri+5pI6V4qJjQHwOLI2xEJB/zT4j6VXIIXVI9nF01xVcoI4iyAC
         wUSdRFz/bQOATQUW/QH71GWQBGqzKwiiPCVFGZkgRYdcaO533EWTcqzn385/ZSyOfe+3
         8MqGaKBSeIMiqRE/I2ubkMKrGRJU7t9oH2tehIYCV0eAfQCFjxNX9SDbI0YjpijcgiO1
         +FpSmCcJpvoK2YPnPzdyttP93cNluo7UUg6RzUD07dq22LUoP5Xy1ZcWrMo13y4wYqjl
         7YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720724269; x=1721329069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtuyBw2dMReN+VUaJ64hh0OUXeS/xLFmm5PYezET7JY=;
        b=bDrnsdWgLaIqioh4jo8MyewI0l2ci5T+lOAqjxN7vGMcMDybdElt9uGfOPuno/urxk
         xHZMOitWvHXJAFb5r0Xz3xhPbDNo3yPuX4YrJBMuQyfEJjVcwC8ssO48T6N4PxXQG16f
         STbQXP9LG0f3NchyAb1ljtvbCTCNz3BgMSrNJExdrZgypMcp1vL44OSJx8QC9BPL8mfm
         x0CTcKEUMvIdWexRvnIsGdrbWD6bs72AQplSZ6rvUVpnf6klpbtEvr6e5dBCBCpJO9u7
         vLjjMFDaA9WujC0vNkaZyp5/curY81aye5pRqxYBU0Nk1ShatePzDJlaGx0kOcQT7bYd
         Mfdw==
X-Forwarded-Encrypted: i=1; AJvYcCVZiEFmTxc9HftPUXbFTVGbWytHW1x6OtoftL23dPLyPNw/hJEB/Cdl0zIiY9K43y3NGYcW7xbNnpG9Cn/LegllaEEvGVBXCoOfia3P
X-Gm-Message-State: AOJu0YzCR5vkOAqg734omXcE4UWNUmxk+b2wQuHAQlnv0yAqQuiRfQU6
	nT7Idwt4lz0MVNxO7WIt+0YpWBLH7wTPjUKE/Gz8oYjWF6gKCYmw
X-Google-Smtp-Source: AGHT+IEaSUzKWwZAWDyi2ZWLTWrIP9pwlvHAcHaHCJQlOO79uwNdKnaoeXfbgBMeb0ucQ0IbB3/JnQ==
X-Received: by 2002:a17:902:fc83:b0:1fb:9280:c96e with SMTP id d9443c01a7336-1fbb6ecf61dmr58527665ad.62.1720724269239;
        Thu, 11 Jul 2024 11:57:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7fb8sm53676325ad.139.2024.07.11.11.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 11:57:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 08:57:47 -1000
From: Tejun Heo <tj@kernel.org>
To: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Reverting @p->sched_class
 if @p->disallow is set
Message-ID: <ZpArK0qxZZI-0ykt@slm.duckdns.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711110720.1285-1-zhangqiao22@huawei.com>

Hello,

On Thu, Jul 11, 2024 at 07:07:20PM +0800, Zhangqiao (2012 lab) wrote:
...
>  		if (p->policy == SCHED_EXT) {
>  			p->policy = SCHED_NORMAL;
> +			p->sched_class = &fair_sched_class;
>  			atomic_long_inc(&scx_nr_rejected);

Did you see any issues with the existing implementation? The policy is set
before the task is attached, so it should work fine. Also, you can't change
sched_class by just assigning to it.

Thanks.

-- 
tejun


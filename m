Return-Path: <linux-kernel+bounces-275326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9C948375
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61A9283C54
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA814A09C;
	Mon,  5 Aug 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae5ktNio"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DF13E881
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889906; cv=none; b=YrwDFWK6mzwsKeb3Qk/n2nTIknMvw89ONEzYaK2BqOmPToWRIMzGb6MoU9RVr13CANEnc828sY1xsRg/0Rjdq/xSPk9/A1fSRVmzreK+b7dtw9h8mH/JBemOVmkchRDiPNA/xD4qEhmFbhPD8I+NnpyBLjb3SrUZ/N8QetmUI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889906; c=relaxed/simple;
	bh=M8KkOCDhEXJ/3vSgTeoL4V15q0H8qEYsaVvWdYaq6M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8KyrBa+aP/OVC1Hso0xgU8jjmPym2/rz7kIJGmnB/S8M69obaIsWtaM1E01aKjx8IE0XhwYqEH4cwhmRggSe7Kh6JEKXFPkZatqxBekMm7i1tiJJw+u1g8U0dmMfY4HLRwlT/XmMWJfE5yaaQurNhTszxJgfOIxQhx0kyUyZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae5ktNio; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39ae90034bdso49358155ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722889904; x=1723494704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOlTqxLWLbKGjTBh2uxG+rbky8NYemJBFJn9NN40h0I=;
        b=ae5ktNioXsT02I09zV0J/RxHxp3UPNi2VPJKA5EPdxSLGvnyHZHKcEzH4OUaR07/3c
         EE8QG8hDq9hTK26Gxnpg4gzPz9aWSXJY9eMQAISCPJ1TrBQ65fIRRU/aN7hIzfTlOUHm
         KqxxVdZ6ZxlQ7FbbZTAYX7cca5XE2mTBRwWU7hFXkUNrzDW9Mjl1ekDeN4z5iaPTJ7tL
         auSg/Q1Do9XeaBdiW6p4HGMlVD9ofT5zEmog80x5ws+a/VPwuRTfhjAt1WKTUl5lVRHJ
         oXN2GBWNZyVqtJPOebGffvbeC6DNgSXIInaigBd2gGll3VAVIf/gqcmCEw95kEz41YLC
         kdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722889904; x=1723494704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOlTqxLWLbKGjTBh2uxG+rbky8NYemJBFJn9NN40h0I=;
        b=Klbztws3u6IsKjkSFCq439PnyhFfmRNWNFAGl9kAFeXoSMbBO2/ApNvM+tE7QJdNNe
         LtOtC9TjXlumUCQhQyv3A2s9gESZM1yuKds8MM1aH0+JhGoj4FZmjWBHOOQ8hLoWIPXo
         zcI8zTEOUg53ryN4NK5Zr7D43XoPob4+AHVP6ibouGC9T8gGmLFTsdbi46goisAtd3CC
         yZesSRXffoPMylZCBPFf5RNuJXFN2Z7HC1NAEAKgB/zzd4O8rF/ZKnwpc+6pmTvBQhLu
         Jnbsi4MTpli5va+vAQqGnfX7qtYO5e2dwldjCB4C/bu1fq9z9Om7oX69gpSQbGxOnpup
         XgxQ==
X-Gm-Message-State: AOJu0YwdGUUpPUtJ3Dj+YlZa4cg1L7BnCh2j08OfDRojRQVgnroy91OO
	KkUHAga/Uz2zirS//Tjuuh7se3nZ7nAcvRXDKsSG6nDFe/yZvi25UbgefA==
X-Google-Smtp-Source: AGHT+IG0FQ/2RG3rxtPUAWtX5KXrlp8XttiNR5GEjl5Lojj0YB4+A1Ql0y7aUJSR4bdfN2g15Lnkgg==
X-Received: by 2002:a05:6e02:2193:b0:375:9e3f:5f6 with SMTP id e9e14a558f8ab-39b1fb53459mr172332865ab.6.1722889904180;
        Mon, 05 Aug 2024 13:31:44 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7655bad91sm5657332a12.92.2024.08.05.13.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 13:31:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Aug 2024 10:31:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Correct declaration of cpu_pwq in struct
 workqueue_struct
Message-ID: <ZrE2rpXmGQ-P4kYE@slm.duckdns.org>
References: <20240805073037.60238-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805073037.60238-1-ubizjak@gmail.com>

On Mon, Aug 05, 2024 at 09:30:29AM +0200, Uros Bizjak wrote:
> cpu_pwq is used in various percpu functions that expect variable in
> __percpu address space. Correct the declaration of cpu_pwq to
> 
> struct pool_workqueue __rcu * __percpu *cpu_pwq
> 
> to declare the variable as __percpu pointer.
> 
> The patch also fixes following sparse errors:
> 
> workqueue.c:380:37: warning: duplicate [noderef]
> workqueue.c:380:37: error: multiple address spaces given: __rcu & __percpu
> workqueue.c:2271:15: error: incompatible types in comparison expression (different address spaces):
> workqueue.c:2271:15:    struct pool_workqueue [noderef] __rcu *
> workqueue.c:2271:15:    struct pool_workqueue [noderef] __percpu *
> 
> and uncovers a couple of exisiting "incorrect type in assignment"
> warnings (from __rcu address space), which this patch does not address.
> 
> Found by GCC's named address space checks.
> 
> There were no changes in the resulting object files.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Applied to wq/for-6.11-fixes.

Thanks.

-- 
tejun


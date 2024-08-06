Return-Path: <linux-kernel+bounces-276435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64C949397
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2908E1F21739
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6F1EA0D7;
	Tue,  6 Aug 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tAGxrv3I"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43651EA0BD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955679; cv=none; b=STy29Q29TsCGxaEU0efFKplCwheMkYEBjST7ytm2sm7xBb47JNsZFWK9iUHOOsw8RylO5DRn4K5ZeTtRaBsVHyN4xSHzEnnBw/HksbyfDMDgr1bVGehsKVcjVss+/zg0+iqPKllcwU5JP95QhIi9B67gGXgfpWrpGcGmSrGkFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955679; c=relaxed/simple;
	bh=P84ht4lM1hKD8ka15HNJQscH6KfXgkhBdMbBd4XqVRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DImrsucAqWdFc6VI4X/4RUZAl8HpHB6p8/BIqV1l61TZ8aczguoT+S70pFTxpv9Vkq7VucsmK/G5ZCOJ7HX9EKw+OsieIy8sEVPatrs6uIyxh/2RaMyIDKYFp8LeJFmFpYbjOTyXdHh9PVchILAlgzl27ZDDt3hWdMUU0MNcrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tAGxrv3I; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fdd6d81812so5797815ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722955677; x=1723560477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0FVWvoz1QUY/grQ4BL5jJHVun2pt0keNTCh/XLZ6lU=;
        b=tAGxrv3IZC4FUV0HqOxaMerkI/lyM1roeEppwATGOdt/eyowX78g0bLIDQ0bCM3hLZ
         KgCcMq1ovQR7Gjd4mwgsE5afC8ejbtwfcicdpuemNgijYIvOdfUjGQcxz9TLcolMLx8K
         vG9fF48gWbMUtLirJasBpv5uLViayjQ5qECpKqYTXP1332JEfGpxPm7VGpMKk60dgMO9
         NGMw+XbolLk3wVaRUr4179lBtTbtZZ1r+qxm7rvMW5ILEwSmbgGJeuyyMP87ZSQWN0A6
         YagF5v899O3gaB2zvgoHAFwNgotJB2Bd3qae40zh7t62jdtHHaTJSNKmCUPteEIUhqnA
         VH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955677; x=1723560477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0FVWvoz1QUY/grQ4BL5jJHVun2pt0keNTCh/XLZ6lU=;
        b=r40zpc0nashSEGPbOCn9rBjZz6NPT+dydAs6vg4zdoc4SJlFIzIf+5F1toGfT3ZkZL
         gNX8d3YNH/j6OpDLjZOvotA1Yc1TFWZRYyrXay6vC2sb0nbLYQ2TMoyuUJmYDyTTeOJF
         HNu14eJoTyC+8StFX93nLkA93GJllpQ6Gpe5/Lz2eGg8hq2JYZVG5p4ZGfcYNkjj/evx
         lyIhh7djVLLK8T7Yn0sYc4nc3RSxi35SX+vujmLtFvDFQgxfVtFAGDwj6DWMb6vs9fR0
         h9wLTvx6xWoGknlksENT6vlM24YPHQ7tym9FYh12uUN2gtyfEKHOMXWCnhvJnKLmjNil
         vt+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKZei8OLkl/U8n0HGApZsOAB007p3Rkr2Pxujqw1Auq+zEerd7eSoidVsUixh/uL04FrzwTF+AaBLX3Nd0SvnAHUOvD2mWjjM+AHHd
X-Gm-Message-State: AOJu0YzYFCOTbiSZD8dLqY6vP6auPIW4n3ln/nO7qn/8uHtWVYPpbShb
	dCWZZMYd6BpSQu71EMfNgV9BUxZaVzske9G14rQDn2rbooVj0jWL/VRNggx8hg==
X-Google-Smtp-Source: AGHT+IFK1etyM36kJD9DFASKxiSDU8wfB9q8aS7bjKKbnqiTJI4CZ1zq0vJZobueP05vaTaKoH06Kg==
X-Received: by 2002:a17:903:120c:b0:1fa:2e45:bcb8 with SMTP id d9443c01a7336-1ff5722dec9mr199214505ad.2.1722955676500;
        Tue, 06 Aug 2024 07:47:56 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29e18sm89049615ad.11.2024.08.06.07.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:47:56 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:47:52 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
Message-ID: <ZrI3mFLUwDyEMRIB@google.com>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-3-cmllamas@google.com>
 <218314e9-7c7c-490c-bb2e-9611243cade3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218314e9-7c7c-490c-bb2e-9611243cade3@redhat.com>

On Mon, Aug 05, 2024 at 09:36:43PM -0400, Waiman Long wrote:
> 
> Many kernel developers understand that BITS refers to a size of 2^n. Besides
> LOCKDEP, there are also many instances of such use in other kconfig entries.
> It can be a bit odd to explicitly state that just for LOCKDEP.
> 
> Cheers,
> Longman

Right, and similar to BITS there is SHIFT, which is also a common way to
specify the 2^n values. I'd point out though, that it is also common to
clarify the "power of two" explicitly. To name a few examples that are
doing so: SECURITY_SELINUX_SIDTAB_HASH_BITS, NODES_SHIFT, CMA_ALIGNMENT,
IP_VS_SH_TAB_BITS, LOG_BUF_SHIFT but there is more.

Perhaps this is because the audience for these configs is not always a
kernel developer?

Anyway, this is pretty much a trivial patch to address Andrew's comment
below. But let me know if you think I should drop it, it seems to me it
can be helpful.

  [...]
  btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
  bitsize?  Maybe "bit shift count for..." or such.

Thanks,
--
Carlos Llamas


Return-Path: <linux-kernel+bounces-376705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAF59AB511
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C791F22CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1EB1BD01D;
	Tue, 22 Oct 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/7si74k"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF21BDA9F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618141; cv=none; b=SLbE0KRdszlYwIqcoB39tiV1aQCcwqEp6piiUqJYB5/CmyjMOPlSob0L2KquDg+w78Lc2f26PQHbJnAw/5fJwwPx9BJscidsLoU950+FCtbb+tsp9CzHxo+Kfon3srqVqncjuuUXkU4ulLT/nIhXptGh7Hu3W3zD8QnW1lRDTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618141; c=relaxed/simple;
	bh=VV6QKVF0gjjf8hHfaPPcTEmbDgUc5yY0WnBeyT5UWGA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kSQ1EU+lLjy7DXHwDXFKjrPyRzRB8CYEBnZzp1UJTkRrmQQnZZqMQxV+6grUgb6+P7nBzRhl4bGR8lT6Vn3stvWyVn6K0RhuYqyN+ToNND9xkcgvQazVA+/hkp4U9YX2HvPb9lwBhzCiMNyjZMdznxnysfbj5mQy0vHuLIj0+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2/7si74k; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e390b164c7so97391147b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618139; x=1730222939; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=88wx3+4q+1K9X5I+DhSnOFWj6qOcMcVFHAzwKhzigV8=;
        b=2/7si74kIY3740fNvV1DbkcLvqWlTXXGImhs8uAAX8zZl13EuTBmCLXhB4nws4jzN5
         nquV1R/OAK6lDOqbupq4sJ1vWvSuSol1Na4eCZM4426bIfz0La7t4Uly7R83HB5eC2w2
         teLGrS283bw5ru37dc0xbQb4DDberkEHjV1unv6RkiCdUM4aC4y8xOHUZp1eMOjxSvo1
         HBqdAD995dwWqpAUBZwWyI0M6mBfKL4NFVZ0CMkkA1GRVXVF2n51Pjrd5N2LnPloVCRw
         60G4gI30k7dxWKJuJSeGQckCieZs0spDM9ymjqFuWb2C/wKC/6rlOyLbr5ti3gaChyBl
         w9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618139; x=1730222939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88wx3+4q+1K9X5I+DhSnOFWj6qOcMcVFHAzwKhzigV8=;
        b=cZfcdayXtL3+O3LmPSnl+84MT3pq1oQGxaV5ay0C9QA66FD0Hju1rWwvB0+TRY8tub
         VjthjL5+xzfirofJmn5ksb+E9sG/WeOO8LUf1vz4TLHnItajQOXl7a1idlo8vDdfCDUM
         Uc3T1LRc2NItF9FQHBWLzdKTRYTYjnxPYs3bzLBXkwKmcN+4eoMC1cSE8kHlwo1Y804d
         a8cvL6bJPP8SttQAcx3Ip6hcUzrEH0GJMAZOx/gs4WsqlDzCo/J9jT9gflTsTf9Jr71Y
         r0XwTbZr7qHH/Wapa3gXmAg9EEreinTBYNNWKdl7Xoal6CPdA5VXXRxXrLq8/JNMXqn3
         GWpA==
X-Forwarded-Encrypted: i=1; AJvYcCXCZzD+5J7uKGy4mffe3fHEGmScdWp/EI4t4gs3BZGZcvC7/hQw/SdZ1LuRCs97tGWLvbUj9v05niy6YnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5VS27FCj959iPEIdh0xBAUwVn8rXn5ufZx6HXEyDcHKMAdJx
	MEU5dWVCe4+ThsgOKOg/Pomoly4cWVwq8VAeefyl7KA7WYJFxt6XfKDsNc+Jiyj1I5uBAlI7Ju8
	uOA==
X-Google-Smtp-Source: AGHT+IFdc0ZQv7mh7e81tsPtMekWG2+yIBem7weGPBwgYcNYPCIjb5/j3ncVZ+x2Nweve08TuyHo7YHd8LQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:23c6:b0:6de:19f:34d7 with SMTP id
 00721157ae682-6e5bfbd6b2cmr1234057b3.2.1729618138968; Tue, 22 Oct 2024
 10:28:58 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:28:57 -0700
In-Reply-To: <148feb5b-cdd8-4065-8570-d0304383cc62@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <148feb5b-cdd8-4065-8570-d0304383cc62@stanley.mountain>
Message-ID: <Zxfg2bTkTgObpexL@google.com>
Subject: Re: arch/x86/kvm/svm/sev.c:454 __sev_guest_init() warn: missing error
 code 'ret'
From: Sean Christopherson <seanjc@google.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Brijesh Singh <brijesh.singh@amd.com>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Liam Merwick <liam.merwick@oracle.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 21, 2024, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
> commit: 88caf544c9305313e1c48ac1a437faa5df8fff06 KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event
> config: x86_64-randconfig-161-20241016 (https://download.01.org/0day-ci/archive/20241019/202410192220.MeTyHPxI-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410192220.MeTyHPxI-lkp@intel.com/
> 
> New smatch warnings:
> arch/x86/kvm/svm/sev.c:454 __sev_guest_init() warn: missing error code 'ret'
> 
> 88caf544c93053 Brijesh Singh         2024-07-01  452  	/* This needs to happen after SEV/SNP firmware initialization. */
> 88caf544c93053 Brijesh Singh         2024-07-01  453  	if (vm_type == KVM_X86_SNP_VM && snp_guest_req_init(kvm))
> 88caf544c93053 Brijesh Singh         2024-07-01 @454  		goto e_free;
> 
> Hard to tell if this is an error path or not.

It's an error path.  Luckily, the fallout is only that userspace will be confused,
e.g. KVM doesn't continue configuring state thinking that pervious steps succeeded.

I'll send a patch.

Thanks!


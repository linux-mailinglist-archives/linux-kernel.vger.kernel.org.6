Return-Path: <linux-kernel+bounces-570084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE70A6ABD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3349189B872
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043E62236F6;
	Thu, 20 Mar 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHgsKRfP"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F31E883A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491098; cv=none; b=USAtP1Zwvb1pPkWdP9N6/1MQkAsak2QG9aMDrT+UnTFAZfK09KNs9gGwwUaZ9Ps0XSYoKoiNNoxH28X0CZ88CeWhYB9yux2zudVsfduJGujfo86PSbbYIZBfQN7O7O0CR+8RGzmvRU/e/JqHJ7F+wWSkOOon0l0fnan/zg5IPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491098; c=relaxed/simple;
	bh=88p1w7uEcFSCHYKOCDuBHPZGg/x3AAPkfIOOrr6qmRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LP3vVndu6WDu3H6+x+86pXn262G58PLLnVIC0blsKXKraZtuPjxvWCA53SP9wQjqQ07amP69c1yr5tslv08cUpBXsriTmDvn+sKZhudG8vqBfQECpPtct4FAZylqid5bKiW25chytxJBopRiITeeGaxSIHivroTNRKf8K6Ud+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHgsKRfP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so1480167a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742491096; x=1743095896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=88p1w7uEcFSCHYKOCDuBHPZGg/x3AAPkfIOOrr6qmRE=;
        b=YHgsKRfPf2/nBiD260ANuo5qn3IAPdiMNnoxnuLCprv9Owqxk5Kkyo2SoDWa0RKRol
         iYMIEdX4+eG2ZvmRhzvtBhrl1gmZYGhSpNf/vEAUhBK0Tw7zHng1MqpbWWQ0gFfi6pxi
         /6OJkbLTti8JDeCXHBxE836tbZjU8J1WurYsSEKnCUV0dGmm1dVrsuvEAQw/0gsT1rHz
         xrqNSOY/MDRaul1Gi2uPBL8SH+zeyMa1J8KqHa1PZTKTN8WJTaIwUXHk4Wlz++7DyqQD
         1YSBxXLUNKdZdpp4Vm319W5pi7CadEuoygSUsLKjeq2reBB4BwSGpKokHYshcLLJ2fzE
         jeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742491096; x=1743095896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88p1w7uEcFSCHYKOCDuBHPZGg/x3AAPkfIOOrr6qmRE=;
        b=uKh6hwsSxkMakrE/IUQ3yGZmIMtlDGdSSH76ggTwOAP6rXP3jlJ90fzWQ9UWhf2nOG
         iftE9nHLv1vJPoNTPrI5YDNOf8FBeZ2bfV8vvy7NHY3wibV16XDkLb8Zd9t6wBY7g1l5
         L3HjIycoAF+uVIK49uQ5Lq6Vb3IPRBS9MQNv3ePnK1yN+IpFBo2ktO74dATzkB0gF9NT
         tkwpULJRAgr3M3EwClfHkC19BZHn695ycMDkgWdft6k0HYu++jpVMN1myg4g2q8Kz6kR
         iKSJ1IbImtiDUmCkCgI6g2mykJU61xNsy3umW5CVyc/5exgy+ZE26C4fYkyqanGAfwrC
         2GUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV100Vx/TydzQ8e8Buf/V8jiNOIsLzfgL5lNQqV7Ltms/EqMVnfOAeOwDP/VJaAvjSndUwLbSaoCYrmM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZsvOECIKJeOKXpiTy9sN6+VrHVVWraEse6OK79S1KcrR2j5h
	Ib3oP/uQ4Uz/nK08zCIc7BOualjejPNAUUX1l6cpGinO114EEk9x1mCM2YDhMmVJxmHDmiIBVCP
	vCHSP1e/r8K85qNI3Lg==
X-Google-Smtp-Source: AGHT+IGpaoCewgRhvYW5fa+HpkkDxI6GYIKVShvL+72MGW8IdbGecEsEYFRFVCnEraF7VtF/dPJ/f4MPXZFrOdbn
X-Received: from pjbpq9.prod.google.com ([2002:a17:90b:3d89:b0:2fa:a101:755])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2707:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-3030fefe3e4mr5163a91.29.1742491096376;
 Thu, 20 Mar 2025 10:18:16 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:18:02 -0700
In-Reply-To: <d5f7379c-c66b-47f5-bc97-eab90ab34346@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <d5f7379c-c66b-47f5-bc97-eab90ab34346@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320171802.2325561-1-changyuanl@google.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: krzk@kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, Mar 20, 2025 at 08:10:37 +0100, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 20/03/2025 02:55, Changyuan Lyu wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > We have all generic code in place now to support Kexec with KHO. This
> > patch adds a config option that depends on architecture support to
> > enable KHO support.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> What did you exactly co-develop here? Few changes does not mean you are
> a co-developer.

I proposed and implemented the hashtable-based state tree API in the
previous patch "kexec: add Kexec HandOver (KHO) generation helpers" [1]
and then added `select XXHASH` here. If one line of change is not
qualified for "Co-developed-by", I will remove it from the commit message
in the next version.

[1] https://lore.kernel.org/all/20250320015551.2157511-8-changyuanl@google.com/

Best,
Changyuan


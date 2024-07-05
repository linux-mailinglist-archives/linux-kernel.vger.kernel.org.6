Return-Path: <linux-kernel+bounces-242766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C482E928CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799A41F25DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8FB16D4F7;
	Fri,  5 Jul 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="GHmQyCk+"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CA16D4F6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199137; cv=none; b=Z7feUKCiXDno9IkZzy5u0p4FKcVUSGyfjgAPtlmcnNz/GyYz0+CHyRggZzYJwJ4HhZZiP9wDWQnbrtA7X6lZoW0nydqlGKJlzYRmIxERZGv3P4eRi6c8TOG60ui26b7oNx9063uPHH2b8wnw1lUy+lDqvM4rePBK6ZekfrT0m3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199137; c=relaxed/simple;
	bh=ZvybLxeM7mlLFuok+9RNlvm7TphlKyJaJfrLNZyphYY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z4N+AbMBx/Kko/wjuN3wcMB2EKcLpJbQ1KUc8ZGw1AqLGunKVkbYqQ2tJGa+sKGVhbAohVehs6S0aPthteYc8KDsXDjUDiOiJaOEZwQ/1wFAp1Bc7KwUWVk0TdlFeSp8ATOydc5UFnwEYK//FzHkzz9191/c+MvRlJyoGL7w/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=GHmQyCk+; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1720199129;
	bh=ZvybLxeM7mlLFuok+9RNlvm7TphlKyJaJfrLNZyphYY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GHmQyCk+ttuDtMStSb1i+eQifCLa2e5dVQVmcfgJn9vSgtggIiu32kaOyaKb6O6LQ
	 J02L+rkWF/2rROLC8PZfLeeMWEVivj8ICD89TnFqntXqZfVaF5f4HbZSt1ZEh5370+
	 ZeiVzYU00G7wCvpne8BHQ+QJemDH+fb1p6peFyBA=
Received: by gentwo.org (Postfix, from userid 1003)
	id 166524035D; Fri,  5 Jul 2024 10:05:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 15130401E2;
	Fri,  5 Jul 2024 10:05:29 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:05:29 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org, 
    anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
In-Reply-To: <ZoZzhf9gGQxADLFM@arm.com>
Message-ID: <b0315df9-b122-46cd-12b2-7704d4a4392e@gentwo.org>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com> <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org> <Zn7xs6OYZz4dyA8a@arm.com> <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com> <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com> <ZoZzhf9gGQxADLFM@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 4 Jul 2024, Catalin Marinas wrote:

> It could be worked around with a new flavour of get_user() that uses the
> non-T LDR instruction and the user mapping is readable by the kernel
> (that's the case with EPAN, prior to PIE and I think we can change this
> for PIE configurations as well). But it adds to the complexity of this
> patch when the kernel already offers a MADV_POPULATE_WRITE solution.

The use of MADV_POPULATE_WRITE here is arch specific and not a general 
solution. It requires specialized knowledge and research before someone 
can figure out that this particular trick is required on Linux ARM64 
processors. The builders need to detect this special situation in the 
build process and activate this workaround.

It would be much simpler to just merge the patch and be done with it. 
Otherwise this issue will continue to cause uncountably many hours of 
anguish for sysadmins and developers all over the Linux ecosystem trying 
to figure out what in the world is going on with ARM.




Return-Path: <linux-kernel+bounces-325107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94F975512
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B909C1F23786
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86F18FDC5;
	Wed, 11 Sep 2024 14:15:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E107155747
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064101; cv=none; b=HHTwWuqasNWw1/YCV+4o4gon3A6sTs/QmEf47u6VHjn06ZuaGla8D+OUiV9NuygAfUPRBkt5ORp7erpU6+rskHVrZIpo2SCJj7TxZybFTZbdqXZZqcYwJ4JY9WNQUPxBoqYZylydfmB0b5Szr/B/71H06EZItlspK+d0ryli/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064101; c=relaxed/simple;
	bh=6zMtsXVTcgFC3FHf7dXOGo/FZsdrFHeaU64XO3BDDBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEvCs2fejqoYbO2u0IijpRQyIT08Upb4tVzn3g/rerXhpX2oGUi2QLwZdfXslfSKYDRc7cBiQxb8Jc5yWQglqhm1Fon9ZuEsV3oYUYIvIPEJEpGs83d68xnHceLgutyTUxC59nNrdJcQiR487e9ImV5QHK3p+Atf5YXMNOzr4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 050A11007;
	Wed, 11 Sep 2024 07:15:28 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 982BB3F73B;
	Wed, 11 Sep 2024 07:14:57 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:14:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: avoid string-fortify warningn in
 export_uuid()
Message-ID: <ZuGl3v0y4SYR1np7@bogus>
References: <20240909110938.247976-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909110938.247976-1-arnd@kernel.org>

On Mon, Sep 09, 2024 at 11:09:24AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Copying to a 16 byte structure into an 8-byte struct member
> causes a compile-time warning:
> 
> In file included from drivers/firmware/arm_ffa/driver.c:25:
> In function 'fortify_memcpy_chk',
>     inlined from 'export_uuid' at include/linux/uuid.h:88:2,
>     inlined from 'ffa_msg_send_direct_req2' at drivers/firmware/arm_ffa/driver.c:488:2:
> include/linux/fortify-string.h:571:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   571 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Use a union for the conversion instead and make sure the byte order
> is fixed in the process.
> 

Thanks for spotting and fixing the issue. I tested enabling
CONFIG_FORTIFY_SOURCE but couldn't hit this with gcc 13 and clang 20

Also do you want this sent as fix on top of my FF-A PR now or after -rc1 ?

--
Regards,
Sudeep


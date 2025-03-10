Return-Path: <linux-kernel+bounces-554344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169CA5967C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C601A7A4F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B022A4D1;
	Mon, 10 Mar 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iNwI8Mrq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229F22154C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613936; cv=none; b=aa7NzKefNgvBb9+8UUvS6kJ1Qoc8shLF984w/488r4fpUgW/TgLNVbjWeyYg8QA0c2ntAc8N6ocJ8TooVhZHDBpJF7ssmr6mGvgm32sfDWCsRiYQ7B46wDNPtChk4YnMN8svRgnbjr8WVNdG+jucF9pVg/KRfx6H3IPzUs2RsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613936; c=relaxed/simple;
	bh=n0QR94b1ACqHO7qz1/g1NVjlox0kbGrQGKI5IkM6s1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj2/dMKU+ZJT5S6NsABrjKFCAUOWOAzubj9rKbWsL4tCx51iFt3s5HNLXXMnlzOeo5pTEcc2gP+AYlZoLQu+BrkdmsXbFrQ8o/ZGXnlKevRYtQ7fj6vI2DKt/ZRvUCdcEvCaN3nWgbsam68x/HG7Od+wiuZKgOGu/qnm2QFil90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iNwI8Mrq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DDE6940E0218;
	Mon, 10 Mar 2025 13:38:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A5yFdn3_9Qn6; Mon, 10 Mar 2025 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741613928; bh=yz9qRKIWQjHoRou4yomeKKijPLVARfKK56eOb5EDQyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNwI8MrqTnUbG7sFMNfzAXa231YunK/F612DnEFLb/Wej8PsxzY4T14Nv0ajjk5vB
	 rlXosLOsVZDdBfhp1SAlVNkpoW19uiA/wxiJ6IST1tE1jJ/TNW44+mA4an+Dq17i8m
	 7UE9qDW9dglsU+3BiXpbRpOCZMQH8RJe7H2Fiivvtwj8xjvKjACR/vuOhGrLu5AAhw
	 ezK2fNcqU0STDMLo1l4w3ryECkCIybufhgZNJ43b4wWqUG5fNCVjTHGWNTqLIjICwb
	 WIk0Sr7BJi68OEQlXqFyFUWNTP+O9rGJdZNdiMxmGveSz5lLXzNf52OiNDtTVVpCIt
	 nl8wF+9C2da+mSfTwZIJyie8MWQbUssJUsvngrC+lZNaQx3wwySW2UeV9WBmvmgTJF
	 9b3h9QEIlPMutHEfdgnQMMdLC8MJyDcyFIEOA0ajbyJ/Voy18HmgsThZTqOJTUrUFD
	 VvV9I4VBoN7is+Vtv8O3BUq92OXUyaXXMf5cdtwAMBjqXfInVKiuKNF50akV+gup4k
	 q/TkWl0U1CmlcHqXcIGm4JlObrup7t2zXtUvOxWWPJOY5oPcDBL0uHxw+tblJ8GesQ
	 hBR69Kiu1J1mpLZ0dR1YXwuRAPI994ab5oM+Ar6Bt/IhX/QOL0H9aYPwS52VdQPZd8
	 F6DXFgTcuBXAQhhKd9ZESLn8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61F5A40E0214;
	Mon, 10 Mar 2025 13:38:34 +0000 (UTC)
Date: Mon, 10 Mar 2025 14:38:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: Joerg Roedel <joro@8bytes.org>, Alexey Gladkov <legion@kernel.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
References: <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>

On Mon, Mar 10, 2025 at 01:49:46PM +0100, Juergen Gross wrote:
> 1. Only name the hypervisor nearest to the guest (similar to running Xen on
>    top of another hypervisor in nested virtualization, which would still
>    say "xen").
> 
> 2. Add another entry for naming the outer hypervisor(s) (if possible).
> 
> 3. Name all known hypervisor levels, like "kvm,svsm" or "svsm,kvm").

/sys/guest it is then.

Let's just keep /sys/hypervisor alone and as Joerg said, we can link to it
from /sys/guest.

I guess that sounds ok...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


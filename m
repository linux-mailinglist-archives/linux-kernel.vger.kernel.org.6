Return-Path: <linux-kernel+bounces-440337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BE79EBBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822BD167EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80E1237A3A;
	Tue, 10 Dec 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ak3mOsth"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD4237A29
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866611; cv=none; b=WfO2rMxDel3i/FS5ii+BBfE7DhMLOfsdTjGRxCa3PPCt5jFA3RxTYyo7iu/In7NH+fRrzugmpwJN8T3D8OSf39pbhTDLA0nZ6nUteQ+uzQGY7oa0GMHhTgeA4ddPWyAz7GNI6h/hWFv5Mlfns2D0yKVxN9HpdB6qY5EFYKf8JOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866611; c=relaxed/simple;
	bh=2I+ND1d2xH8uFsX4um5nkwbgWijKrtsYgoHqxt7DJVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz4znZn/dS4VciTgrC/bS9yghXSI1LnDJDyhSWB3Q8ZzF1Coc2mDDCXR6Y1UBgURPkLtPlYsKZm/+qw+TFK7KF63MXYkkX/Vtl7KD7SFyjEYElfHdku0VMjhi65wcJIsD97iCXogZ8dntNg4qvH+gUrmS6HPYhNymenKWXFD4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ak3mOsth; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91DE040E02B9;
	Tue, 10 Dec 2024 21:36:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 13g9h-XBNyVP; Tue, 10 Dec 2024 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733866602; bh=XKzUfQE34WL2x8M4wqZap9+LUgzvltPeYIKDzMVxDPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ak3mOsthRucOCcdrGNQBU+E61VlwHqwrFPYUhEn6phYSSlX1vorv02GeSSls8+wyP
	 u5GqRqJqloeLQcJPZqNpm2c4jXn3RUllgKNlBP1MNQhWMF+xJSRP7SD4RzX0qIkAEG
	 dEhoTWQgMxVRH2KrTEpH51wop1NEblxPOE4ySTiXG74rHiLhV8AIlMDn2RaD5p/M2N
	 3NYnGt1nOU7oG5G/OblibITdSoXuG8cJcVDLuuD90fUV6IkoYH9KDiFnwBzVBdG+l+
	 DEN7CYask4pJ3NE3jaFCkC+pTRAOpjIgxMq+MkKhXdWiTqcynz3bJwFgNXm3Pn8vHY
	 giSnuLrKvHa/bZdqYkXY6UjvSUmC56E+niQu8X95n8nXsARWwr9VxJjmalnwT5TBfm
	 E1b816sKNF3rn4q7uKSGB/Orvgss6Ka3WnKwqhb3uN7Iu29xRQswrf7x6Seh5Zwg9e
	 6VCcO/MAGFAa/QQ9RZt183/Bol7qp5K8L37UXBTRXk/wS8rIEbpR0KUrj53GDsctug
	 5Hd9hWkg9NoqB36gTZFHBhGD4s4O2AYeHNuyQv2xmudaoII6Wmo04+5TDzobZdO2yC
	 IUu8PxSFERtv8tY6UWdmOrSakTFLCATcT6s+dHw3z0gEAPyJshW8O+BLBkzIkb/t9w
	 OcSqtcdS70KGZxApJwiAkgMU=
Received: from zn.tnic (p200300eA971f930c329C23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:930c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0034040E0266;
	Tue, 10 Dec 2024 21:36:32 +0000 (UTC)
Date: Tue, 10 Dec 2024 22:36:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
	dave.hansen@linux.intel.com, david@redhat.com, jane.chu@oracle.com,
	osalvador@suse.de, tglx@linutronix.de
Subject: Re: [PATCH 1/4] x86/smp: Explicitly include <linux/thread_info.h>
Message-ID: <20241210213626.GNZ1i0WsS0XCoaoEY1@fat_crate.local>
References: <20241210184610.2080727-1-kevin.brodsky@arm.com>
 <20241210184610.2080727-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210184610.2080727-2-kevin.brodsky@arm.com>

On Tue, Dec 10, 2024 at 06:46:07PM +0000, Kevin Brodsky wrote:
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index ca073f40698f..88e72b414bfa 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -6,7 +6,7 @@
>  
>  #include <asm/cpumask.h>
>  #include <asm/current.h>
> -#include <asm/thread_info.h>
> +#include <linux/thread_info.h>

linux/ namespace headers come before asm/ ones, I'd say.

But, more importantly, why is this 4 patches instead of 2:

1. Remove unused __set_memory_prot
2. Fixup include hell

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


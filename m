Return-Path: <linux-kernel+bounces-550502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 422DCA5607C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85A818956B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5F199FDE;
	Fri,  7 Mar 2025 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaDFXWdV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B7198E6D;
	Fri,  7 Mar 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326928; cv=none; b=kxv7OmE253Ezxtyv2eLZfn8siAlYAb4qWA7cBUAXF94jHitLpqg7Q/Kn/1FgjK5r5leSwQsINQCOHfUpwBaP4Ml+rjJChdd3gDA7NoaZeZHmcG15RVnGLtG03pxDwSzhf2wHomE3yxszERatZsUs3PfK6DSdbNHghQJp8X2Pw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326928; c=relaxed/simple;
	bh=MhiyITzafn+oL8EbKVQjdW6/i3/2fPQ6p6JW0xN59M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT8X+pqL9YQNG/Ua5KZMCrdFPUkFtSdueTjd7O+xBWzHxQ+3KsG0gEAxJDQDvsdLnxMuIlnbByJCdcUtmZPuh08A84QBVoUIliSJj+oudjTWYI2/Tb1LeNk0VN2NNoHmXCqlJwEkKWQoAY+stbSzXT37A+6Ckjfgw9SaGJdaxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaDFXWdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CAAC4CED1;
	Fri,  7 Mar 2025 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741326927;
	bh=MhiyITzafn+oL8EbKVQjdW6/i3/2fPQ6p6JW0xN59M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaDFXWdVefRVlF5I4F1zLj0PsGHZOmZnbvI96wxh0Xru+rB5XamCaShyRZr+njJNo
	 6beP32EjV5Miai+UIKcynMRVboeVl50qr9uvuBsAgMz0TyzwKZaA/CuUs1EIglKhm7
	 xyA4/Cmf9tzK82NDZb8Z4PQCYYHl9L3Efz+MrmFlLmUHydkN4elrX79KF0jcZ6K+fI
	 2rpxKN+IRtce1ECwZOrARfO72hPMemqhOp6R870ixSN2Yc4afGtllk/cj5BjkKHC63
	 7jv55UfYx5LBPNQQbzMHkwY8fua7xVfJ0FNBEdf5+KuxF881aSdAM4tG5BC4O8Dhg9
	 VTdrcK4FruVww==
Date: Fri, 7 Mar 2025 07:55:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 07/19] x86/msr: Add variable MTRR base/mask and
 x2apic ID registers
Message-ID: <Z8qKStnfCBvSw_yI@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-8-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-8-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:04AM -0800, Ross Philipson wrote:
> These values are needed by Secure Launch to locate particular CPUs
> during AP startup and to restore the MTRR state after a TXT launch.

Hmm... does the first part with like locating particular CPU cores?

I'd start also the sentence with the action taken except assuring
why the undefined action is taken.

"Add the MSR values required by Secure Launch (SL) to locate particular
CPU cores during application processor (AP) startup, and restore the
MTRR state after a Intel TXT launch."

Along the lines would be more informative...

BR, Jarkko


Return-Path: <linux-kernel+bounces-569288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8FA6A100
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A360179581
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0A20AF69;
	Thu, 20 Mar 2025 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Y8+LbB2g"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D61F03F2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458541; cv=none; b=INVKJkxbFam7zWQKg8QHvfVSMTlptO0ncI3vUHse+nlrvnMYHeu1V7k5Vgg+3MXVJyhJt407ZGSq8DKftDVITuZdZXBplP+/p7oNwXFpx1gGJ5rR12YBWh8eYEd6na8Kq9tsmWPEPVULRT178mWSRYZhcPCQv86VpER47r5UkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458541; c=relaxed/simple;
	bh=gTiLS5RnCyKhXEQL9Ompt2vF9ys4CK0tcDaCtj8LER4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKJFkucHT60Zin7fDECizV5zDvFR30KdMjGSIrRtWpRrEFmznsqwPKN6qyS6UAzqi9viHEw/9EViVJL6oYyhAtckkkghMgc3ojtYWJHnuykeJY5EkyOTeYb68tB7aNBHLN1Uv5whxm6kjxOXxUACaSpzHHD9QEmiPms9cOvsF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Y8+LbB2g; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CF97146435;
	Thu, 20 Mar 2025 09:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1742458538;
	bh=gTiLS5RnCyKhXEQL9Ompt2vF9ys4CK0tcDaCtj8LER4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8+LbB2gEvup6RSKlno4yb9Nfy9c0L7pMHCAupasn2oMvFDwaL3bi3GuyYJ8YWT0s
	 Ip3TBuzmuJXA3dkaovK6gRnWW1KM2zDL+zw+Dh+MjTVgUVRu0vZ70L6iQMNAIlv0xd
	 fxQgR0yB9lv0R19v6beS0xZzDbwkqe/XJ3Xrbq6ZiVwuwsGpPZ2URH2djSl1kHjrnf
	 +Ad1CCOr2jbXOTWQY1F0HH7vAL/jUcGK1DI5oDW9q96rZLyM3h43lqiGo0vuy2beja
	 eFewOvUtBM8HNC67Bs5cMT+XHjrEdh91gE1oPIbEImF0/zJql5K1FS6OWONpMtP/mV
	 3Jrf0qqXXXy9A==
Date: Thu, 20 Mar 2025 09:15:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Rolf Eike Beer <eb@emlix.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH 4/4] iommu: make inclusion of riscv directory conditional
Message-ID: <Z9vOqabp0GwimC1J@8bytes.org>
References: <2301497.iZASKD2KPV@devpool47.emlix.com>
 <3536592.QJadu78ljV@devpool47.emlix.com>
 <Z9vMwUQ679SdSwhG@8bytes.org>
 <2365431.ElGaqSPkdT@devpool47.emlix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2365431.ElGaqSPkdT@devpool47.emlix.com>

On Thu, Mar 20, 2025 at 09:10:34AM +0100, Rolf Eike Beer wrote:
> Yes, and I can send those cleanups as a followup if you like. But for the first 
> step I wanted to keep this as less invasive as it could be. And to be honest I 
> didn't want to invest time to do this cleanups if it's unclear if they would 
> be rejected anyway because these things are this way on purpose.

I am fine with these cleanups and they are contained enough to also take
care of the vendor-specific Makefiles in the same series.

Regards,

	Joerg


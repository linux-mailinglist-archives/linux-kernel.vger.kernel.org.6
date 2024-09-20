Return-Path: <linux-kernel+bounces-334175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EB97D37E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307E41C22623
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FE13A265;
	Fri, 20 Sep 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Kq1TVKFE"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26AB1CD2C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823799; cv=none; b=SFQP23dAC7+MuMvF9E9bsC07Dw44oIvokQjR8tZ8YVsdKRkUwTbG7KOb+BI8qL6lG2TWPgPOUG1hl1BXc8IbpbjwLZXDc/xjxRD0LHbRrnOHPluuAl7w2FV3RAiRz+V7OJu9TugbB330+7QbE7sCnxVm81wC1ZY8MO+YiBEBquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823799; c=relaxed/simple;
	bh=H5vO6Wc0mKC3lqWkfyiq3NTWwDenfmeBA7g2i3+29gY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K275eNrG6H3yngWEdtS2V+hWNbr+foLd2CXw7/+nbixgu7A7A48KGl4g7Hgv/dSjeXZ9i5Ko/BJ4kRt3bCRMVd/PF7vyMygbDF8RZD7PmFjFxFPIh0OzNnxA/LhV6t1OTOd31nIBt+Fyhz1/h9MbtpaP3jQFbpjXn6Fe19RwtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Kq1TVKFE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726823795;
	bh=K8jwiabrK5D6Hs2uR3+hfrDgJNW3a1V7tWBTVvI9Zbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kq1TVKFEXns6vVegA3r5F46NFcgALudM+YJWUOFehfYvdBIFVnscKuaQl/LbziWEM
	 wYtE+xBrdMDZdw6/PJHFOktD15LB5sEGEJoGzLFOvXX3kD/lp5KT6kelcM0eT2e7Zx
	 gprbw50+S6tIZth+ThcMVVI0qBP03MbpJ5ypmVbp6ASjAyoxnfaUDTO7S5wTJ2GPUe
	 6azJC28M167vKNxGW9HJHfGQ5y+2j9kU+GFaJbB1aOEY/p1Ba5hLh0PdaxUZgfvwHl
	 IuZJMbpl0EhbXoPuIOd4iZTv54Wd8MMlkxGpCwjt2s8QSkH5xPm03VhqvR8qJEHaP8
	 A8SpmVHn1P1VQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X96Fv4gW5z4x9D;
	Fri, 20 Sep 2024 19:16:35 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
In-Reply-To: <20240917132445.3868016-1-nnmlinux@linux.ibm.com>
References: <20240917132445.3868016-1-nnmlinux@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/eeh: move pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block
Message-Id: <172682376261.64942.12479934341616104313.b4-ty@ellerman.id.au>
Date: Fri, 20 Sep 2024 19:16:02 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 09:24:45 -0400, Narayana Murty N wrote:
> Makes pseries_eeh_err_inject() available even when debugfs
> is disabled (CONFIG_DEBUG_FS=n). It moves eeh_debugfs_break_device()
> and eeh_pe_inject_mmio_error() out of the CONFIG_DEBUG_FS block
> and renames it as eeh_break_device().
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pseries/eeh: move pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block
      https://git.kernel.org/powerpc/c/3af2e2f68cc6baf0a11f662d30b0bf981f77bfea

cheers


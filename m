Return-Path: <linux-kernel+bounces-302752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65A9602D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6EE1C20F27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5C19D8BC;
	Tue, 27 Aug 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UDVxsNos"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62D15AAD9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742922; cv=none; b=g0xa6cWdQZhMgOZVvSaU0dGy7mcTgUNOFhgMPynGOF2hRqa8BW550D7SSrHTSYIzMRmBjB8KVYQ2PBUrOHP222NqHBp9m4GdOSFNWuxQv9w+kLagzjYcYYTUncnxxp2ECfWp+7jvtATMQ6+k5HaohzFB11hp8DgfPXEIIq36ElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742922; c=relaxed/simple;
	bh=n+fQ0Pp2MpZeWxg130YnUhjrxXFUYV+M+lo0UWouAIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eZQ8nwfipKACaSxdw0Z3MOwiYQLCc3GkfgiqFPbNtSXyc6Y/iYDy8Y/G+lF8Tm5iyXhngVnK7++5YrCgVrWrl3KI7ZVDlwCj5gG0MgyuATexSYD/ebGSnWZDlHSdMaNnD8Tm8tMZBLxG/4lctHxMaEqMhMovxCAOfbPlzrMOEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UDVxsNos; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724742919;
	bh=vV422L4mnpf+hOkJJ5Z0peDj4WQZoCKVdxmLvkpZwrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UDVxsNosUCVKE+chsQQm8obg19tSKk/5jpFDuz95nAGSVLypK10durKnqxmMALoBP
	 6p+/LlJ0q6VP9BOMFMCMoQuHgID+6xQASVHT6bHHi13MGNa6Pmx7a0ztdGM7p4MB77
	 uasb1tNM6sh57wKtbvA/V7LM59fD5hRLS4ClkuXtoQJY3z48Ve6Vc6+GhWfuXJzqdi
	 bzhvJV6E1z8TB4E2RGHCX23v1ykNQIT8EpHSgOkF2w+oMX28gRN0BAhM3WTGHLglEm
	 aeCCRHTH3vL7YIdrpNMpoXXjP4Omx1Z0BGt2GFk6UEZvh7y/X3BKaw5Vcu3pcsjrxV
	 uBHpl2ZWBUSNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtJj30MJ6z4x6l;
	Tue, 27 Aug 2024 17:15:19 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
In-Reply-To: <beb30d280eaa5d857c38a0834b147dffd6b28aa9.1724157750.git.christophe.leroy@csgroup.eu>
References: <beb30d280eaa5d857c38a0834b147dffd6b28aa9.1724157750.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/64e: Define mmu_pte_psize static
Message-Id: <172474289342.32718.7307817190802798616.b4-ty@ellerman.id.au>
Date: Tue, 27 Aug 2024 17:14:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 14:42:38 +0200, Christophe Leroy wrote:
> mmu_pte_psize is only used in the tlb_64e.c, define it static.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/64e: Define mmu_pte_psize static
      https://git.kernel.org/powerpc/c/d92b5cc29c792f1d3f0aaa3b29dddfe816c03e88

cheers


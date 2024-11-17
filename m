Return-Path: <linux-kernel+bounces-412094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F019D03CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4076CB26CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA21BBBC4;
	Sun, 17 Nov 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pOO/s//2"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF51B0F10
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846340; cv=none; b=kq/1k9DzdFtk/m0nW3uoQqQqPWpMILfe5rLJajCvYDb8Ac0vf2SRSvrCIliWo+l6RoBUKmK02a8r71gWNvWLeIrQZH8ZKtamghTElsEPSeuPo2JW8N7QxLqobyz62fL1nsjN8ePqmvnKrfb8V/GnHIA9IqzmvrLi3vjwyEXBVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846340; c=relaxed/simple;
	bh=rlOkLdWnpMfSFS97C/BxUeazHNedy3xYD70FV00yTv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gFpC+IKkEED+CzfLYMDeVcLvv3EizPbmPLKproe9F4SSu7MAgiCd7mfpotffG8PUxe4i8syZblaok6fL57sbBIhTHSnlNUz7eJFUW6dEuLZvOvliof/UgHAuilFLWmDxeiDRqK1nIlmfMD/1wpDJ61y1uW3oyLT9Kq/nz6ULFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=pOO/s//2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846335;
	bh=EjOLBTm8qIVwqFQ5mRUKY4dTcr0ZMFt3/mFMTBHvnF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pOO/s//2bzWDv6KajHsDX2odFSy+UCz6LHeHejry3vt6e8Ccit3FEXYVrYLNiVqio
	 pNqFnR97xO0zWo9yaR/nhrjojsdYZis4BxdNR5NkfhjeqXUZhi6ysXyT6Mnk6jCr4a
	 VlXCewU4YR3QYHmc0qjYLXP+s1Wfw+B0Mnw8uoN4krz8uY65ZnXrhSr/pisVnMGDMw
	 RPe8hnbFDUYDE1xvOkqbMcjZxwaKX8DXfmDjBTUyW9OJyKr8XjD5PAo+f639tpPT1U
	 muvzkay4HYDVJ3rup7aoIf8VKBxiNxvOReN+xgmc+xFohgrsf56jX+z0TUxjk5TOPz
	 htZ35Z5Rp13qw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XrqjC4zv0z4xfh;
	Sun, 17 Nov 2024 23:25:35 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Rob Herring <robh@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241027222219.1173-2-thorsten.blum@linux.dev>
References: <20241027222219.1173-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] powerpc: Use str_enabled_disabled() helper function
Message-Id: <173184539744.890800.16412147962073098528.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 23:22:17 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Use str_enabled_disabled() helper function
      https://git.kernel.org/powerpc/c/19e0a70e6c3c1bf800b8ce9eb45864aa9e1e2781

cheers


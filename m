Return-Path: <linux-kernel+bounces-412077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3179D0389
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592FEB22BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C32B18B47E;
	Sun, 17 Nov 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SZ+D9dqR"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76095148827
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846317; cv=none; b=kyPrG0zWXgR9HiYAZ5tSowBr3uIirRBglaYSdG6/jeJYFF5vqemPXGF5Dg7TnxF/mTDe85zu6J+HQW+yZuwCK9XXptEAqjpxSGFEg5M9JeelSzE6ftc0Q4AE8fUtJk4QYLryjzXv+fdgJKiVhL2qtO/1sYZVZIDwFXIvDl3EBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846317; c=relaxed/simple;
	bh=RhVeKnaFZWN+kO5+RJ6yvsva1hm9d6T49KWJuHW9p0w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iDzqe/TM5BQpdZrh/WISv2xnsrI1yTM2gwFaSgs9Y5VtzDGQq6BLNZeZ5AcX+yfU61wh7RElOahfULCixFyWHu5TSqoeYLbnw0IXBjnjCBhr/961lw386bE4EffEI5VcC362X5nYiAgUkArXYcFVYJPOEba63xngdrbhdXHs0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SZ+D9dqR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846310;
	bh=6YkDsmqGi/hDbdsOuh5XqzzF7DZLsS/qORhMUcP9Eyk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=SZ+D9dqRPFNFDqEnlmPDb73O6ByGIla3lmIAPXvdXd3nk8YJb6Hr9l9dqBbfC5l6n
	 7Q6rqXwRHneHEjiBm02F/ksBc4QEPlnBmdAR496ZnUYRFipt+6HOkfZ12NqlcqU9Rv
	 U74DCDiPZT80b3ckHa0/0YrsQmM3H6Ur+kLrZEfnFzzneQcADOfFdvhamyJPiuiCLy
	 25cCnVWDJSGzpHHRpyQ0CYSqJNa248w06Oz9aECfiavee3m2jUXaaFW6fh8eA6/DYe
	 zJASxwyEHvnOIi+pwj1sC2wAuXOnwFQfp1oTYReNPNSs0f/npgc73LKXIGM3Hikrh4
	 +4x5oUosj/xhw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqhk2Yrgz4xD9;
	Sun, 17 Nov 2024 23:25:10 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Costa Shulyupin <costa.shul@redhat.com>
In-Reply-To: <20240926092623.399577-2-costa.shul@redhat.com>
References: <20240926092623.399577-2-costa.shul@redhat.com>
Subject: Re: [PATCH v2] powerpc/xive: Use cpumask_intersects()
Message-Id: <173184539764.890800.12646623251156657066.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 12:26:22 +0300, Costa Shulyupin wrote:
> Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
> with the more readable `!cpumask_intersects(a, b)`.
> 
> Comparison between cpumask_any_and() and cpumask_intersects()
> 
> The cpumask_any_and() function expands using FIND_FIRST_BIT(),
> resulting in a loop that iterates through each bit of the bitmask:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/xive: Use cpumask_intersects()
      https://git.kernel.org/powerpc/c/6da1cab4f5f8eb778fd61f0eb6ca5b0a011dd44d

cheers


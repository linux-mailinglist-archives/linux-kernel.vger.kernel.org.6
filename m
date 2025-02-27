Return-Path: <linux-kernel+bounces-537119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB59A48835
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA63A3DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B226A0BF;
	Thu, 27 Feb 2025 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZWG+Jsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C4258CF1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682235; cv=none; b=jVhijRof0ThsomKUJys6sNL6heCu+IXp/zWWOH3VDKsa+IL2l81F+mrxUC6e7Gx7AZ6ar3XFpRLh8Iq3XV5pKk3zHSfmjAeEhYP8zUBiNmpughJWcZz9ps21j9mAmjV1a3BV6jLTBPfpOdp4sSAVZFJHOb0QZ2Fq4UnF9quhHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682235; c=relaxed/simple;
	bh=PdhWZy9D7TCGdHdbg75DVHTX/1icTJe90dYyzL4iqgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYMODeo+U58bkagB7IgrjQCEsGnHZGpwCHcdx0JdSM8oGjAFRlspRDa5s01KFVvqIxX3+iJpFbERSnXfyCKdJ9h1iUJxyjIJHdAvo62TxTbU/I/oO6zeh5+cy86x7gyYyt93F9ZmSO4GuSWbo1u8ND/n7DNhcdlGRRrJu3pzr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZWG+Jsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A3AC4CEDD;
	Thu, 27 Feb 2025 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682234;
	bh=PdhWZy9D7TCGdHdbg75DVHTX/1icTJe90dYyzL4iqgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZWG+Jsm30Kz3TKsQv7Kk64q1Eq/a0DAcMQXm1ViLfsEQCLc8d562FIccbXB9lk+y
	 5NxDDvNRAhFSFweXFQU485yHjFoP8UoVgf0XSR6lU2Lajq0kaoZUmXinvaOohznvN3
	 5k7vfPb6XjdACvyyZNPFFMYD/jtMRXMwC24P0YAlz31uKP0y5ReRZzMSmiA+GGUDPr
	 xLYp5L91cfWEwc1hIfkBWp7kRrfpcH2XQS83LN1BRHeDlOabq/WdEqueCSu6z9ULTj
	 uisn0lGGG3WFDv7oI8E3ScPSjJZs+RNmiXMXkcgxeU5LglxD/2xruyc/whFo09j4ae
	 CKAVKsb1mb1hQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luiz Capitulino <luizcap@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
Date: Thu, 27 Feb 2025 18:50:27 +0000
Message-Id: <174052227763.2420464.2784848656225511807.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250225114638.2038006-1-ryan.roberts@arm.com>
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 25 Feb 2025 11:46:36 +0000, Ryan Roberts wrote:
> When the range of present physical memory is sufficiently small enough
> and the reserved address space for the linear map is sufficiently large
> enough, The linear map base address is randomized in
> arm64_memblock_init().
> 
> Prior to commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and
> use it consistently"), we decided if the sizes were suitable with the
> help of the raw mmfr0.parange. But the commit changed this to use the
> sanitized version instead. But the function runs before the register has
> been sanitized so this returns 0, interpreted as a parange of 32 bits.
> Some fun wrapping occurs and the logic concludes that there is enough
> room to randomize the linear map base address, when really there isn't.
> So the top of the linear map ends up outside the reserved address space.
> 
> [...]

Applied the reduced version to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: Fix Boot panic on Ampere Altra
      https://git.kernel.org/arm64/c/2b1283e1ea9b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


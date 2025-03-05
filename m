Return-Path: <linux-kernel+bounces-547603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA130A50B87
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750457A7FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD762512F5;
	Wed,  5 Mar 2025 19:33:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC71624D9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203180; cv=none; b=ojt5aGZj6QcVJlQ9OAkTJ+Wj9lJxDwlwPLEPrpJqNo1cZqu/HDoop/mCP0TwI9NUTPGlbXnNWNHZdLBC9uiDX8w/6yPdFxxBDh7I6nWWVU6X38brLQM9BcNktXDa5Ot1eDAKbZPR8fbqltV2eSvDfrt1H9CGzKAOh288oWgZsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203180; c=relaxed/simple;
	bh=G2vPXSToeMncXRDGl/u/exrERLzCza7pxTEl2V+0Qtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alqlNnn3PgsxZaoka2u1wKRo0cskEfYhhaKbPnj9psvsoQGWk0lg5qJ1PDNrj4c6em7Yf48rBYtK+8TBtjCBOOpwUDstjoWmTbT9hl+qhB30j2kqIC2QghlaSv+0QgwGYWfayQyq2JcJ117CsLt+XGMlDxV2xADJkJPInJL0PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC989C4CED1;
	Wed,  5 Mar 2025 19:32:58 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Convert __pte_to_phys() and __phys_to_pte_val() as functions
Date: Wed,  5 Mar 2025 19:32:56 +0000
Message-Id: <174120317313.1423488.2871713663228556221.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227022412.2015835-1-anshuman.khandual@arm.com>
References: <20250227022412.2015835-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 07:54:12 +0530, Anshuman Khandual wrote:
> When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
> and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
> respectively as expected. But otherwise without this config being enabled,
> they are defined as macros and their return types are implicit.
> 
> Until now this has worked out correctly as both pte_t and phys_addr_t data
> types have been 64 bits. But with the introduction of 128 bit page tables,
> pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
> conversions, which leads to compiler warnings.
> 
> [...]

Applied to arm64 (for-next/pgtable-cleanups), thanks!

[1/1] arm64/mm: Convert __pte_to_phys() and __phys_to_pte_val() as functions
      https://git.kernel.org/arm64/c/2d7872f3ae3b

-- 
Catalin



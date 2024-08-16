Return-Path: <linux-kernel+bounces-289930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737B954D71
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8191F2313A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2821BDA9F;
	Fri, 16 Aug 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fro6VY66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAB1BDA8D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821374; cv=none; b=TOCkthEx8Mv2eeKZKVOxy2dkXHIJ0si8Uw7MAdnoN9EpDP5yXYY0XOtCSpfEOHTe0UY4HyqQ6XMGsbwJljhfqkMfwQIPqJttXXw17ygT8zPv+7OhCt+Rqa9EdnBKTHM/5yXYljRCcjqUIolwBNuZXGM5Zd2uPVxtQ4vWpt3XcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821374; c=relaxed/simple;
	bh=Xsn/3V8HAsaSr8+jJTpvmwUPP1YaWFhuA3vlnt3b5JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/TrQ3NJcDvuDQVoCZMrjxnsZgQm1sENTaMdd9a6NdbqyJYdR/1NaMZGqq+I7TALQw5lD2c2CppGV0S+TsfwodshOM78RDA6IDFLBcLaaRwrLjH0A1GHdhzBzZM130VEvlGpDfTsXk/w6MmW8c4pPkJtklyAY8IS7p4iTpVqxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fro6VY66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B498C4AF0C;
	Fri, 16 Aug 2024 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821373;
	bh=Xsn/3V8HAsaSr8+jJTpvmwUPP1YaWFhuA3vlnt3b5JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fro6VY66JOAvZZWN/ack5RhT8lSuzmI62uQrlePh4uxCwLenfSu1HrOoSWmHtC4ig
	 V7lpQqgdganaO5jsrRnb1+fhIRVOytpesUb7avfMDa7UmODMJck82XR538t1mxMNKh
	 6GLhu6zIKUmLyvNQ2IM07eIu0QaWqfhlKVZ5alDDFoEls8r5aRUfJ+KPvA88U/HLVf
	 3eyGJvfMc/3IGVWQSEL4+gmoJes/goPOm89YZe+jj9UR5z4BrCaRrkRrMvMeEL8QaL
	 9qLmywmdE++yk9Z788cYI5rontbkZVKAqR8A/3Wb72843Gg/CrlfyR6EJSXkGjZ/Mu
	 XVNH/t7LusSAQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop PMD_SECT_VALID
Date: Fri, 16 Aug 2024 16:15:51 +0100
Message-Id: <172380381358.1159450.414153868649059752.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240724044712.602210-1-anshuman.khandual@arm.com>
References: <20240724044712.602210-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jul 2024 10:17:12 +0530, Anshuman Khandual wrote:
> This just drops off the macro PMD_SECT_VALID which remains unused. Because
> macro PMD_TYPE_SECT with same value (_AT(pmdval_t, 1) << 0), gets used for
> creating or updating given block mappings.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Drop PMD_SECT_VALID
      https://git.kernel.org/arm64/c/4b6049b643f4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


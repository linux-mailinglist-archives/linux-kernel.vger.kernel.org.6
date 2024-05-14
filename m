Return-Path: <linux-kernel+bounces-178582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016258C510E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E23F1F2213E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C855C0A;
	Tue, 14 May 2024 10:53:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0C12F384
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684020; cv=none; b=iM8FyKVXs1XNTY7WJTq/8AA8CXCoPRoetf64PlT9SFr11o25PslAQviklCHOyVTWVgvcLdJL0Ral2023ixoDBNY+vNqqL+FV8oxFkt4P4qnFA9J8lU89HI2r2b8a+nwx6GPnWa4PyTGFpw9iCZyd1SmV4VYvhk5+mX+SOHmrWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684020; c=relaxed/simple;
	bh=EdSoPuNL/ZHfLKbZlYhh8ep6nO2cbQb3toaneVwtv8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/WhKAseYyrMvpzxW+cze5q7sEj0Tj10yviKwd85PycMTOc7fBzUGjQ/jDsTMc1lZ/dRDvWKuUKvp7EL32jJUhBPXGnn/DL4IaHa+EgkIcF0X0WfXiNl1CyqHR5mJFeip0M8j1XL2V5sePUPQUmd+QpqHPIduDVIv2GHaq1EzyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EF2C2BD10;
	Tue, 14 May 2024 10:53:39 +0000 (UTC)
Date: Tue, 14 May 2024 11:53:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
Message-ID: <ZkNCsT0dGwOyap7M@arm.com>
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
 <f1049f13-53e4-470e-89e5-d99d7e171d39@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1049f13-53e4-470e-89e5-d99d7e171d39@os.amperecomputing.com>

On Mon, May 13, 2024 at 09:19:39PM -0600, Yang Shi wrote:
> > That said, I'm not keen on this kernel workaround. If openjdk decides to
> > improve some security and goes for PROT_EXEC-only mappings of its text
> > sections, the above trick will no longer work.
> 
> I noticed futex does replace insns. IIUC, the below sequence should
> can do the trick for exec-only, right?
> 
> disable privileged
> read insn with ldxr
> enable privileged

Do you mean not using the unprivileged LDTR as in get_user()? You don't
even need an LDXR, just plain LDR but with the extable entry etc.

However, with PIE we got proper execute-only permission (not the kind of
fake one where we disabled the PTE_USER bit while keeping PTE_UXN as 0).
So the futex-style approach won't work unless we changed the PIE_E1
entry for _PAGE_EXECONLY to be PIE_R by the kernel.

-- 
Catalin


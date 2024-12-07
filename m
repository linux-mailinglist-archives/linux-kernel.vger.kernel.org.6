Return-Path: <linux-kernel+bounces-435906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0919E7E74
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D480A2828FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7305B1FB;
	Sat,  7 Dec 2024 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z95DUuXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8D4A24
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733551239; cv=none; b=LVEkyqOAuruYd0ov206o0OB8bR4ElXsS2Fa2+klrNrzTALRKfhoTxToW6mksUKzR0H/GEy92U9n1BfvpfH85cdmpN9TX09P28EMEDQ8H5uq3Hqs9onzBH5EVYP4zv/1M3Rn7axe729TaqflNjaEbS8VvB+KHHq9PFNmmCI7qzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733551239; c=relaxed/simple;
	bh=dxb0Zy9wKWNA7XqTg0/T1rddBsXo4s7NLdfNncQkqz4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M93CECsakcnJ2qgjUQj5lcvAj529YeQoi4ttcxu74V89vf7dgTwkDcMrQblXg9GXBbhdVOXxdEHCerZz2Z87mba4Czqbp7rFxvDKNtB+5BPysCfxy3TxFCkb2klF8mKwoxM+fpJaTwofwbdbVtCT1mUOkUtEpfrZhnXLck625Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=z95DUuXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E5C4CECD;
	Sat,  7 Dec 2024 06:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733551238;
	bh=dxb0Zy9wKWNA7XqTg0/T1rddBsXo4s7NLdfNncQkqz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z95DUuXfwVbMM1mrsFfe3WoC/fhTpjLd0At8oG7fapXuuqv88Xrcwr1fHm+1yWoqt
	 AeoPncQ2vy4saVAqL/J7AlPO27kTOBTy3RKuof5IhlDOnp0aM8ZsEmOCEqkXt2tuns
	 ck5X03VIz+1AH3EHqqLAIqdyz5RWNzi3xBB6xCOI=
Date: Fri, 6 Dec 2024 22:00:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Junjie Fu <fujunjie1@qq.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 mhocko@suse.com, gourry@gourry.net
Subject: Re: [PATCH] mempolicy.h: Remove unnecessary header file inclusions
Message-Id: <20241206220037.5c0cd212d3269dd8a6f36e4d@linux-foundation.org>
In-Reply-To: <tencent_08B979048FE091821B290B18AE97E70DC507@qq.com>
References: <tencent_08B979048FE091821B290B18AE97E70DC507@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 23:53:49 +0800 Junjie Fu <fujunjie1@qq.com> wrote:

> Originally, linux/mempolicy.h included linux/pagemap.h because vma_migratable()
> was implemented inline within the header, requiring mapping_gfp_mask()
> function to implement vma_migratable(). Now that vma_migratable() is only
> declared in linux/mempolicy.h and its implementation has been moved to mempolicy.c,
> the inclusion of linux/pagemap.h in the header is no longer necessary.
> 
> Additionally, since mempolicy.c includes internal.h, and internal.h already
> includes linux/pagemap.h, so there is no need to modify mempolicy.c after
> removing the direct inclusion of linux/pagemap.h from linux/mempolicy.h

If mempolicy.c uses things whcih are defined in pagemap.h then
mempolicy.c should include pagemap.h directly, and not rely upon such
nested includes.  It's simpler, directer, expresses what's actually
happening and avoids build breakage due to ongoing header untanglings.




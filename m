Return-Path: <linux-kernel+bounces-402451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8969C27B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C901F2318C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306B1F582B;
	Fri,  8 Nov 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJlgnrr4"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933F1E25E9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105823; cv=none; b=fdSqGBAWAPSoc30yCQcUTF3RucI55dChGFrh28jrpes8gFZUkioWM2w7bDL3TZffzkIh5gAXPTdEcKTXE9fP/yfbh1mPRFJKfWoDGp6CxpkPOZE9GTn/oRIVgum8Ej/vwPqyuI64iR7Dd/+VCWbPiv9oU6l+5xRAJbxaWL9k+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105823; c=relaxed/simple;
	bh=fdO20mnsmYoU6bcvS2geqF02xmrxFCXHrknNtl15ffk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbsYkKNapHsMriFBkkzYUJdDSW1B7qkkC5XjGeYc5UDpAUnfqU/myg1XDbkEGsiAYG0dJrkfEvOuB00G9JO5foXpBxilVwtzdaIiBKjChKNmz3ept6NnVNPR9/XXMMY8OvrN716rDZUvOsjGLIrHcfphQhnBdDKBhGZKhsoczFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJlgnrr4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Nov 2024 14:43:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731105817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/Q01bCC7wDkXPJq5Hd7irfKDBUqptGE+aJzyUue8zE=;
	b=BJlgnrr4BnIzl7BJguy8C7welTEKc4b4bOylVojP0t33ICRsK6v3OG6qRaeqQGF0sOQX1K
	w+jBEE0gcHWl4qU9i3s/bpUj1NBn2AWoQ4KsgkZU1ZWB3ihw0xbptgTOgGTueijgNbJ6u+
	ZgTyXaE7SR/fCbtp5gtnmDvqOD3LoM0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/3] memcg/hugetlb: Deprecate memcg hugetlb
 try-commit-cancel protocol
Message-ID: <jwrg3r7qwrfir24udehcs3rtg6xnqybxj3pfh2dd2slpsmitza@n6wsbuimbi3l>
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-4-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108212946.2642085-4-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 08, 2024 at 01:29:46PM -0800, Joshua Hahn wrote:
> This patch fully deprecates the mem_cgroup_{try, commit, cancel} charge
> functions, as well as their hugetlb variants. Please note that this
> patch relies on [1], which removes the last references (from memcg-v1)
> to some of these functions.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>



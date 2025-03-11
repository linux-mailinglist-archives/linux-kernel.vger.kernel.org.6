Return-Path: <linux-kernel+bounces-556906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58183A5D069
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E787A5F49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B72641C3;
	Tue, 11 Mar 2025 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TtSKNgWT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD32620DD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723610; cv=none; b=GnsGY0BKeQVy+BlCWbjshsbg6ovRCougr8HxVEKriaEYBoKFNTCCUz8hW5HEXmBKIci2cd0g63RnVx7lEWFh+wB01e9Xrvn7FBC5qDEqDi4ccYFINh6k7rhoacTWovjTM0icL4lTE7/StKxtqmcuTe25nuYBgsvWVZPDHk+jKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723610; c=relaxed/simple;
	bh=bQbYwDJCi4XfA8SvA2wX26olRhEGgMXvp7T5YMum8Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhCQQiz/zWAY7idCvikyaaLYE3vCmS1T7RRTy9KawRKKxlpA4jY1IabNEt4OFM1tCznsFR2z7G9bgiVLE0n8eJiELH/AowmgWIpNT7e5zAQ4gmVVdSwfLKgfU84B3b9Ymu1BIRORygqU+DJTKk5DxfP8Fd0R6GiSspPTSd5gxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TtSKNgWT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CEF1540E020E;
	Tue, 11 Mar 2025 20:06:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x7eXLGRS2_jy; Tue, 11 Mar 2025 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741723595; bh=KrBk3abp9uHjNMQdxfz1gauQ7wGylV3yre/BW6WYd0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtSKNgWTd/4jy1NRUBrO0qbKv9J9xfSBxcfwED0sWuKNh890QRoz/mhZzPn2ZY9W8
	 l7xLL1NutrQy8wtPnx42ekRDeGU19U6bMPYBQpC8gVB0gOVwVbxbWPHBEsvEA8/37q
	 +aeVNyDwARXdA9y3+GSAk5w/eEXvSrLV7hsyrPqT2/cs1A4IvR/FqRgyd55Bqn9/HP
	 9DyG9b26BWFe8TAFWADpzt+0Kv0BmNIlXThhubOvFnxmGHMs5rt9lBPD59DXVml+S9
	 ubh/O4RqvWxZaarISY/dDtZNqwrQZVLloE8Kg4vee0OyYNay8D3jIh5dtCH34zAgrB
	 sLv2F3VuavO6fF0Oy33KWbpZFX53ZbHijllGLFPgo4QUUt4h4NT1PnH7PCyiMY7Fm7
	 UYG6FY7FUyuHuxbSsk9BovtCWpO8FwXwzu7DZn9X5KV6q0bfvle/l4kYFOp8qbIwoC
	 eokGLcFK5A17/uJyuDD5cfoLoYZ1jgdmriw7aEQz5fDYpN8ojVJjN/n9JilYhuQxPJ
	 DzRv+5Ik590yxCkmlgUUHXYc3tDU/g+zetAPWhv0DUdp0ppUcq6A4FXWJYnUiS8UKe
	 5tfiu3PRTeQV3LdczWox3Wfc5w7Gr0ewTawqOx7OJUB/SNvFBhZfD4vYPtPqWwZ3rd
	 3EVNewNOmzgl876nXpPLZrlQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3AC240E01A5;
	Tue, 11 Mar 2025 20:06:08 +0000 (UTC)
Date: Tue, 11 Mar 2025 21:06:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <20250311200603.GKZ9CXq9B_lqLUqSH5@fat_crate.local>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250310190915.GAZ8842wfIn043W56k@fat_crate.local>
 <09b9d760-0c9f-46f5-9784-5229e9023583@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09b9d760-0c9f-46f5-9784-5229e9023583@arm.com>

On Tue, Mar 11, 2025 at 06:38:44PM +0000, James Morse wrote:
> Thanks - look out for a 'v8:for_boris'.

Got it, working through it slowly.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


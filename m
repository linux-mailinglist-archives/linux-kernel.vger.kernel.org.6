Return-Path: <linux-kernel+bounces-438380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA729EA06E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92F318822AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728FD199EA3;
	Mon,  9 Dec 2024 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXRhbEVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A41531EF;
	Mon,  9 Dec 2024 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776774; cv=none; b=BnY97A0VfrQrpYB3aeDmhq6GjymcAMllqVLJ6QJpA/Q21yWO2dg7jwpdzk4HTk6HE1bnUjdIg2oLUmPD/kM8I5xZPF9DAAmQrIIydFPF1JmibYyFKeL49nDtL/3TTkjrrOhlwYEuTFKk1Olc70qu69TVEUiU3bhMRMCXS0VpBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776774; c=relaxed/simple;
	bh=v7ImQdTS4OAIGy/8P9zFYvNfNEKgDJ6iUMMf5VUciN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRrO3dlJ69AK9/lmMNnG7/uepXW4pHUWXZrt65Q8Woq0c/vesx5wzC/or5cEt7BmJFG5xINfBsMU89RNxHBeTvGJqkzeIpymMzjgPWxyHB21eCE6TpKeZUJQJPs4LhxVs7OMnDZkyDKnsu2Y/KgHSTsC2xo5cBKlswxr/CHwEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXRhbEVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBF1C4CED1;
	Mon,  9 Dec 2024 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776774;
	bh=v7ImQdTS4OAIGy/8P9zFYvNfNEKgDJ6iUMMf5VUciN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXRhbEVwl5SDMvDM28UMmvrUkj/ERj7E6acCEDD8fAbX9/M4UuZHaXrU+djKa12hz
	 KohlfSrh0vuFkIb2kHRUy0MfDueqLHfDZETkqHXYtEKiLsrHZCG2y/k8vaQM3+Fx2/
	 stI/18HFRY27oiYuql49DdZKwGXs/cTt2R2RqBuEzybhdgv1ciEb9z0soNATVHGsyP
	 86EXTvPCH5ZKvqiWoRIT6YbCGOj+lpmVHq4aFzF74Msskit8AhHBhQF1THRpz2QLg6
	 MS1JpKUnOzjMY8K5tigIi5iLIa1mr7ALk+3N2HNh03pO2aNWS2e0szGGL31qBQ/UkH
	 yeFp7SVLDJvCA==
Date: Mon, 9 Dec 2024 12:39:32 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] objtool/LoongArch: Add support for switch table
Message-ID: <20241209203932.a55zmvjehc27hqjy@jpoimboe>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-6-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241207015915.1159-6-yangtiezhu@loongson.cn>

On Sat, Dec 07, 2024 at 09:59:10AM +0800, Tiezhu Yang wrote:
>  struct reloc *arch_find_switch_table(struct objtool_file *file,
>  				     struct instruction *insn,
>  				     unsigned long *table_size)
>  {

This seems to be a partial implementation as it doesn't set
'table_size', resulting in undefined behavior when the size gets used by
objtool later.   I suppose this patch should be squashed with the next
one?

-- 
Josh


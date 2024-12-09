Return-Path: <linux-kernel+bounces-438374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F127A9EA056
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB4C1665F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45921990BD;
	Mon,  9 Dec 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOFwHQDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A023315A;
	Mon,  9 Dec 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776546; cv=none; b=sl5wBI+SopaizeRw0FK1SBhtjnJF/pu6ey6g4rgaH6D2qPsHi1AIoQwfqmvvJH57s5shUD5GrFebq8WOElmfvCd5hXyC8RG4k6bDBT4vsfqGDbw1YKV+K0N9UoKkQuJ+P7K/ESnTrEvDsZq54tbBn+RN94pIEbLgfqZ02e7iSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776546; c=relaxed/simple;
	bh=R+kdjcvmUIPoFjoDb4mLaEXNjYnz7/GMThAiOLaPkDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQwjPJUut/PyfGX7DuLnE7If1lO6aepwfZTbkjpV3BmVfiGKZ+NlnoccMiIPKiYgZZmM4ILNU8FjbqURa1vx3J6AQ3nnm6V9+/Yx+iyZg2tzdLJiFiPrcHTFkWDeYwAj9v/c+tdyCRCHJ+vLR5NFsR1Pqsr6Xe00bfHykQRxMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOFwHQDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE8EC4CED1;
	Mon,  9 Dec 2024 20:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776545;
	bh=R+kdjcvmUIPoFjoDb4mLaEXNjYnz7/GMThAiOLaPkDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOFwHQDav0VlZwgxxqBOKxIXIB2as0Tn99mJ797QfvvHVbp3sd+TPtwfJVNF2Sou3
	 d873IwirefxyXEFWoR6B6EYO9NtL9QtAaX5IgaXcqqcwbTkXyEJQzqUzguNGZIcq7+
	 dL/dDHcG1cYkARxHggKYyIa5BitKKA8iVr7/stgbCkdZkUOLSe9xci+YFy6DPTsaW0
	 Ezfe/6PKjwgOb38Mi0tBRwTcBYSoRvdNpgasjy6N4pC2z7OCTZrJrpFW0YOXTG8yu9
	 Y3QzSvDu6Vt8xLKyQmvv7YbYgFMbFyr0ND5+BDamaR6H6zID7sAbbSesLrRHeVqVSI
	 sf9h3T29QYKqw==
Date: Mon, 9 Dec 2024 12:35:44 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] objtool: Handle PC relative relocation type
Message-ID: <20241209203544.axetpzva7vg3hsc5@jpoimboe>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241207015915.1159-4-yangtiezhu@loongson.cn>

On Sat, Dec 07, 2024 at 09:59:08AM +0800, Tiezhu Yang wrote:
> +unsigned long arch_adjust_offset(struct reloc *reloc, struct reloc *table)
> +{
> +	switch (reloc_type(reloc)) {
> +	case R_LARCH_32_PCREL:
> +	case R_LARCH_64_PCREL:
> +		if (reloc->sym->type == STT_SECTION)
> +			return reloc->sym->offset + reloc_addend(reloc) -
> +			       (reloc_offset(reloc) - reloc_offset(table));

How does this even work?  i.e., why does the reloc offset (basically the
jump table index) have anything to do with calculating the location of
the instruction it's referencing?

> +		else
> +			return reloc->sym->offset;

This also seems odd.  Why is the addend being ignored?  Shouldn't it
point to the instruction's offset?

-- 
Josh


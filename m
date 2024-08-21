Return-Path: <linux-kernel+bounces-295054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28708959628
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537951C2042B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A077F1A2863;
	Wed, 21 Aug 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dna5SMld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F4188A39
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225496; cv=none; b=WjEQnPPFdWncKQayRLpyrFzTeliT/cszBGndNPsXx60F5z9Ttoeez0Rvftft0a90sQVZzQlsw6kpA+F3ZNfZVIsIymxAwXf1a16l1Emnm1u63VcuHgdJcltRoUkzATT7GUaONNxnGlFiGl1met/tlRDbhS1JocciRRIH89PsfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225496; c=relaxed/simple;
	bh=wv4IF+TY93P6mNy/d/y2Xz8LknDgO6XpCpGt4D+55DU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZYDrc9+PwDu0oQM2jfGPk4imADXMB36KcHUVlulh2tQK7HKuevyswO1a5v6YVd3MFJ/yyhksQ440Gh6kr6nTvqMVoVfA6QudCahsfDx0foKY2OvWMVCJAvXU7D2L8r82zIOdHjLF1VoQPy1awE73uO9xez1xirsqLoVv7xW82Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dna5SMld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBD6C32782;
	Wed, 21 Aug 2024 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724225495;
	bh=wv4IF+TY93P6mNy/d/y2Xz8LknDgO6XpCpGt4D+55DU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Dna5SMld9jNvmLqYwoRwHvmTLWTFuKjAo3Maii8Q/5oqbNBCAwEXAFCOIUIAwH60t
	 iFqcs89xJHb6yT7e5Z0ja9zVX8d3KP6a6kONAIvrWFZo+Qw2ypp7QPpZR/m2am3etR
	 31f/x+IR4/SZt365O0nYCRyYrNdjtR5wOsqqAjpn/z+JWqpvpjjpUgzr+8tIbUIEZv
	 0Wav7Jl4lPqBJ6C/kEL9f7uaM8Val/hHytoGonXjfpt3MIgYQtMKSTkmVSsRgLB7e+
	 //SGWAFuNj5eeh0q7SmtGqpkbWfz4LonOz50v0lUQf/y2gT3JpMQCGkxh5w9CXPcbv
	 DGSAWz3ZYy3VQ==
Message-ID: <dfcfb276-1502-45da-b65d-e7ce5297d6ae@kernel.org>
Date: Wed, 21 Aug 2024 15:31:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2 1/8] f2fs: convert f2fs_write_begin() to use
 folio
From: Chao Yu <chao@kernel.org>
To: Li Zetao <lizetao1@huawei.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240820034654.698236-1-chao@kernel.org>
 <a36db618-e7df-4c15-ad6f-876d8cc2bde5@huawei.com>
 <a16d5083-5e24-43e1-b245-12152cac5947@kernel.org>
Content-Language: en-US
In-Reply-To: <a16d5083-5e24-43e1-b245-12152cac5947@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/20 14:58, Chao Yu wrote:
> On 2024/8/20 12:38, Li Zetao wrote:
>>> I want to apply your patch set for testing, but there is a conflict on 
>> the master branch of linux-next. Maybe it depends on a certain pre-patch. Please let me know, thank you.
>>
>>    Applying: f2fs: convert f2fs_write_begin() to use folio
>>    error: patch failed: fs/f2fs/data.c:3566
>>    error: fs/f2fs/data.c: patch does not apply
>>    Patch failed at 0001 f2fs: convert f2fs_write_begin() to use folio
> 
> We should apply this patchset on top of dev-test branch?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

Oh, I missed one patch...

Can you please check

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=folio

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>> Li Zetao.
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



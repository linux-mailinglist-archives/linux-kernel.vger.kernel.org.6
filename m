Return-Path: <linux-kernel+bounces-201780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80D8FC311
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EDC2871FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46116938F;
	Wed,  5 Jun 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUfICDbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144A2941B;
	Wed,  5 Jun 2024 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566212; cv=none; b=DaJpcw0w2ShZVvMMeGxutHMn47wQzjISUvnkqx1WsODFK9K0QTugJImq86TUEHbCqRn5APd53RHUdU0jQg+FnCw/Q3wuMFe17u2HnLSVrTu6+LrLijv3pvvF3xgM9UlFmJm4XzEeQwRI7WLu20NGbOU/ma4dvOhT7UIOwCwxHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566212; c=relaxed/simple;
	bh=dtX8g48MWq+k12U7A9BZ9A3hLXeoqnuptOtFwcRXT6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltY+nv1/Y7LvoN9jKkAakNibZ01Gq1m9kf/1oXDlj5AwOKUyHlSdhkgeeNFmtz5OXv9eb5nn/PwbjblMGtRhIeCLzmD7srL6mk00JOautXwgsys01YGHuTpSGsCj7ZF3rgLMeZvgI1Zc6VvlVaujP9F7nla1K+UCkjHSKFXajv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUfICDbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4184FC32781;
	Wed,  5 Jun 2024 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717566211;
	bh=dtX8g48MWq+k12U7A9BZ9A3hLXeoqnuptOtFwcRXT6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUfICDbxSMPfhIg2kmdAwBk1CHPhpsculazhaKZoVMAv2CgV8lTH0Bq2HTUUG6q6s
	 AahgCYeqzzXtPBTMmyuO5QePPEn6iNIh3Udg4VxK8k6QDawoYtxWj9Oc/KSRlPNZa2
	 FFeN8oOumPN15S8/BkppG830Jlk0E/uqaJmhmFZOygOi9WVufuumMTgWorITSz7Xpb
	 6z5YfGspWfKsamln5VOr6axbMSVhOG/8S1C8ZH9OVv3lE7/OWQLOP+OpiN+3tsF6ME
	 hIKgJLwubMQS6qPVxAHrl8r+txckmkBqQpOD7jQmW36DzSqyvN5XzfYbUJE/hmVV/X
	 923v5iGU/B+wg==
Date: Tue, 4 Jun 2024 22:43:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Youling Tang <tangyouling@kylinos.cn>,
	Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn,
	luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>,
	Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
Message-ID: <20240605054328.GA279426@thelio-3990X>
References: <20240604150741.30252-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604150741.30252-1-xry111@xry111.site>

On Tue, Jun 04, 2024 at 11:07:41PM +0800, Xi Ruoyao wrote:
> GAS <= 2.41 does not support generating R_LARCH_{32,64}_PCREL for
> "label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead.
> objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
> (static key implementation) and etc. so it will produce some warnings.
> This is causing the kernel CI systems to complain everywhere.
> 
> For GAS we can check if -mthin-add-sub option is available to know if
> R_LARCH_{32,64}_PCREL are supported.
> 
> For Clang, we require Clang >= 18 and Clang >= 17 already supports
> R_LARCH_{32,64}_PCREL, so we can always assume Clang is fine for
> objtool.

For what it's worth, I have noticed some warnings with clang that I
don't see with GCC but I only filed an issue on our GitHub and never
followed up on the mailing list, so sorry about that.

https://github.com/ClangBuiltLinux/linux/issues/2024

Might be tangential to this patch though but I felt it was worth
mentioning.

Cheers,
Nathan


Return-Path: <linux-kernel+bounces-549064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365ECA54CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C19188C26A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C111311AC;
	Thu,  6 Mar 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i8r37sqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21D13AD1C;
	Thu,  6 Mar 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269528; cv=none; b=TvGFsspnJjeG/V3dtKS1H/uH3wI5p8StNV/Mssd4meZPCshyBUZWiEpziclHHNdDjMC6hAY4/yFrL3zJpXSlQhqlGxieahuEfob88H1MJwPvbSiJ6UiehuB845K12/XujXSLVpYCzk45dRMbDHCstCpktBT7acEpxVMoLk3uoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269528; c=relaxed/simple;
	bh=jatPw5qkQLpLnJrGDfLee0Gmk1ORHHAVtQ+cqS8pADs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctOlTAKnP3WK3jezlS1q7qEtyHZNrmJfUqR+YDuueo/RiTDA5Of/lbUl5At0Kr/tBn7l1k/IcVXB/pbe8P/WGq+KlhdTDm+0toD6pfYEEw3zyBbqQO6pqvalI6uuDauhpLxcG3B0JkSJOYnnRNk6zL5nQFJH9hLlg8A9s82hsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i8r37sqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CA1C4CEE0;
	Thu,  6 Mar 2025 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741269528;
	bh=jatPw5qkQLpLnJrGDfLee0Gmk1ORHHAVtQ+cqS8pADs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8r37sqp1RFEQsctbeH+SpqUUUqkHtnXZenIXn7A5fL5g3gETZxvsJvEbYyrJW9Qk
	 UOOwHrfuZFzF/sOCPTKzT9q18k/Rg6hg7AK8dUKRyHo4wfV2eMAviRC7pH+YwOmaUq
	 u0WJhPxnknXDCnQljm+7HMFfiAI+XiwXEPqGNVWA=
Date: Thu, 6 Mar 2025 14:58:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "zhangjianhua (E)" <chris.zjh@huawei.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org, "youbowen (A)" <youbowen2@huawei.com>
Subject: Re: CVE-2022-49623: powerpc/xive/spapr: correct bitmap allocation
 size
Message-ID: <2025030618-opal-chomp-5731@gregkh>
References: <0af1c796-aa08-4284-ae6b-470fa75799b5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0af1c796-aa08-4284-ae6b-470fa75799b5@huawei.com>

On Thu, Mar 06, 2025 at 09:41:41PM +0800, zhangjianhua (E) wrote:
> Hi Greg，
> 
> The commit message of this patch show that it occurs out-of-bounds of
> xibm->bitmap，the reason is that the allocated object can be smaller than
> sizeof(long) while bits is small.
> 
> However, it is incorrect.  The kzalloc interface allocates memory in the
> unit of byte while bitmap_zalloc does based on the number of bits after
> rounded up, the space allocated by the kzalloc is not less than that
> allocated by the bitmap_zalloc. Therefore, replacing the kzalloc with the
> bitmap_zalloc does not solve the problem. In fact, the problem of
> out-of-bounds access does not exist. For instance the xibm->count is
> 3，kzalloc and bitmap_zalloc both return 8 bytes，it's enough for all
> bitmap. Although using the kzalloc wastes some memory, it does not create
> any real problems.
> 
> Maybe this CVE should be rejected?

We will be glad to reject this if you think this does not actually fix
anything at all.  If so, just let us know.

thanks,

greg k-h


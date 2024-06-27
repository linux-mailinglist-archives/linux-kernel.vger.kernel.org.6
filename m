Return-Path: <linux-kernel+bounces-232709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F691AD59
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559FF2823D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77629199225;
	Thu, 27 Jun 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp3cOTZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC118040
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507672; cv=none; b=qxYqggzooSzYSobcUCKL7zwYaV3AIb5v7NMArWQPdr0sQpLHQ1sUbCMGKBn6WlqEbbaT6LrYa7Z0zz+40WfvFbmAh4dmMPwrYsmWWWpPQQya226tQFttR3XS+bwL8nxB16qdg8lQauPAshU+y/wh22yZ4N90RITiBA7Uk4P171E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507672; c=relaxed/simple;
	bh=jTzItkcA+UmCUZyaIYRFkOjQJgj1YeLgLA50ynTvyPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhTlNpR2wm94igVmpXAb87ucexxmFZWyjpcO0g7yFcqk14mS+crR1xOEwL9vO+hdJnnEMGzlvWY08Uqd7UFTUYpAIgrOadCAk0yYnetdGguZIpMhg/mxUCCASKFJRqxnUzuiwFq7x561VTZfhdhHjGNOw2/4iqTU29jvKhAV38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp3cOTZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB95C2BBFC;
	Thu, 27 Jun 2024 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719507672;
	bh=jTzItkcA+UmCUZyaIYRFkOjQJgj1YeLgLA50ynTvyPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kp3cOTZ4cjNRhGPXGy1PPjYXiydX/5MMiCGFbF1LaZGVu4HvUEHDKCr50WuuqzWb+
	 MvAUD8qU80yrbAVhK0yc7mKf67qSdodlTwWJh9dIFvRSUoNPn0+n8vYOudBfKYEijQ
	 7Wj/wmtx6oOygUZUMAHc7nalnXdQh7CQSWeh5Iyf6/+azSbYCmN6oPaAD9ZEY9WYdG
	 SLh4RbXofIykBi6ce0F5onA+CvmUXlOEFcsJNKa7Sq8F28hNHutHDl0vRGaHEtiqbq
	 ANcScJAHmc7tdADLTJprHIhk892JT5nf37m8gX44rzYanQDXJuA/oTD0psmhNFNZ9o
	 zKrd2ZQdwgkNA==
Date: Thu, 27 Jun 2024 10:01:11 -0700
From: Kees Cook <kees@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de,
	ardb@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
	rick.p.edgecombe@intel.com, leobras@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: entry: Convert to generic entry
Message-ID: <202406270958.D73912B@keescook>
References: <20240627081209.3511918-1-ruanjinjie@huawei.com>
 <20240627081209.3511918-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627081209.3511918-4-ruanjinjie@huawei.com>

On Thu, Jun 27, 2024 at 04:12:09PM +0800, Jinjie Ruan wrote:
> Tested ok with following test cases on Qemu cortex-a53 and HiSilicon
> Kunpeng-920:
>  - Run `perf top` command
>  - Switch between different `dynamic preempt` mode
>  - Use `pseudo nmi`
>  - stress-ng CPU stress test.

I think two other things to test would be the MTE functionality
(especially async mode), and kasan in general.

I've really struggled to get MTE working with qemu, so likely real
hardware would be needed for that... I'm hoping the ARM folks have
access to something that would work well for this. :)

-Kees

-- 
Kees Cook


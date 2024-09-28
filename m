Return-Path: <linux-kernel+bounces-342283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDE988D15
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1031F21FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18974BA42;
	Sat, 28 Sep 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D34cNR4s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFDB641
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727481887; cv=none; b=Zy9MI0qcej9IT3YbpOvojuUo1j4hsMPkuOQwM7P90iWuDNYN2H4jW+87rQgPpnva8acE94GYMDTjzZPGAXFuYt8sADNPeKDOaZkUVXNu5hxXsBkdINolzgNCB8rUefesTGL8UkQgWdRxj53DyjvIrZaWv7Dvex40sXhPob3fSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727481887; c=relaxed/simple;
	bh=qPSr+bYFOiKJ4gHsMYwbYDfuwX5ijfbCguA7R/0Wv5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La4apmRrHi+OV/ZsedjI1hHy48Hnd1k9XQZT+n/oPV7XCl9reNe9uEuRKHiUTQZ2gZrfbVgbkF2KkA1DqXpCLHTDWcgqjYuYPVc/FPXJnNP/Y6yb+C/h7EZmWgq6c+YzYxRKaFOfgkFrLEW0BRJB41xoQ8rWu6R97PC0X8OvnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D34cNR4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC7DC4CEC4;
	Sat, 28 Sep 2024 00:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727481887;
	bh=qPSr+bYFOiKJ4gHsMYwbYDfuwX5ijfbCguA7R/0Wv5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D34cNR4sf4UwJknHseHjhLyoV0kwhoggoQqLHUVHAFtH032CCLmGCpKL0ra9tGwZ7
	 3EsvFCfFZHEmox0hpTCjxe2zBUcS1T1R1FyBci7bcGJ5bQlkmhmkd2g3JkTfajAcOB
	 MKz8Vb0Fkwn6ixAo2uQZp3SArxNJGVyparG83at8A8kP1QtNrad+SsfnLd4Hq7F/Xg
	 iM7fkI9UwmlB4bAXz1EWGrBb8+aUWgZkZIO/LObn9IFpD8jtm46QBiK0rYbNWrngYE
	 r8Eqsk4VQDZrGDUhLq44w4W99ODPBMZ1zpgSNN6EPAk88FRNQhBsUz7m2raHAegLeh
	 oiqtCMNc+45WQ==
Date: Fri, 27 Sep 2024 17:04:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 07/14] x86/ibt: Clean up is_endbr()
Message-ID: <20240928000444.grd3jxltzoiihsz3@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.069013308@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194925.069013308@infradead.org>

On Fri, Sep 27, 2024 at 09:49:03PM +0200, Peter Zijlstra wrote:
> Pretty much every caller of is_endbr() actually wants to test something at an
> address and ends up doing get_kernel_nofault(). Fold the lot into a more
> convenient helper.
> 
> Note: this effectively reverts commit a8497506cd2c ("bpf: Avoid
> get_kernel_nofault() to fetch kprobe entry IP") which was entirely the
> wrong way to go about doing things. The right solution is to optimize
> get_kernel_nofault() itself, it really doesn't need STAC/CLAC nor the
> speculation barrier. Using __get_user is a historical hack, not a
> requirement.

But these patches don't actually optimize get_kernel_nofault()?

-- 
Josh


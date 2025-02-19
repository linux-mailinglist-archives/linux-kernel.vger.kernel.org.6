Return-Path: <linux-kernel+bounces-522153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B017EA3C6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4FA3B67C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1942147EE;
	Wed, 19 Feb 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrm3ZVYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4792144D4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987509; cv=none; b=ijUkxLWYhU9nwgET343xMAsKO671DfiGrE57gRbXYdZvD30N/jtxH8CFI2n64yv2jCQXBknWr3vSUb21hAmJ6jXTsCY/aVi2MsXXbJK0GE6N2Qbv+MvY2al/GBV5GtIrbylJQtb7TZg3QTFYvATzwV3g3Utp8joqV8hTLO7Rlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987509; c=relaxed/simple;
	bh=/ff/0UXg38aLKctMxnvl4lnVr5VfBll5+fjnRPFJIaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVB3yTUxXPojldRJvYUVTD9K7drb1VjdpV73pj2jw0dBGP+48UL8F066asyqQiLriMajnbcKylpjs+aaaxZd9ZD/oJ1hTULJoV72tIzpXIEdw3oGRqlnVUY3Gw+xjqiu+OqOArdaWoVPDYuH5s4nRERFmnK+K1P04gb2ZoDUIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrm3ZVYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAB9C4CEE0;
	Wed, 19 Feb 2025 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987508;
	bh=/ff/0UXg38aLKctMxnvl4lnVr5VfBll5+fjnRPFJIaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xrm3ZVYwqo9lWjAu1UeDN/ZPOARWANfqIiLsNRgQjzigWtrX53M8XXYbBf7LVRUvq
	 /p1a8beL96o7lRI38FrZEdcg39tcOegeeKZtVkXvux6n3+7T/SqbAq2E89/1hcstF8
	 TMFbQ0Vl6KGZM9l92uKB3WpTQH8FauXfkPU2HiPUceR+uQh/e0EIcqnDeyCyRjWXdv
	 86gRVUTdhzRktYct0gjh2ZSzoGPQ6VwpW9aETXCTzDUNAzMqjDQmuVn3XKm+Qp3Udn
	 R6lC+QvKr1hL93hDUY+QOCTjeswChuCcZyGzg0Wp9+p0HVF8IAQQLgHHP5LgYJ+32p
	 2Cpo5TCpo4oEQ==
Date: Wed, 19 Feb 2025 09:51:45 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 02/10] x86/ibt: Add exact_endbr() helper
Message-ID: <202502190951.8772BC254@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.475718637@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163514.475718637@infradead.org>

On Wed, Feb 19, 2025 at 05:21:09PM +0100, Peter Zijlstra wrote:
> For when we want to exactly match ENDBR, and not everything that we
> can scribble it with.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


Return-Path: <linux-kernel+bounces-522155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FFA3C6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC55A188E00F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF971B4F25;
	Wed, 19 Feb 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXUpHwFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB9214219
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987544; cv=none; b=smyhPqWoeIraVYNhosQ02X7ZTqZvoaBbWIbvHMWKOBFZiBNm08zXQEENSMy2JC/NJ42QfW+QC0+bXdao0GvOlxEm7chFptUWBB0mnOZybogOOMDKdBUP6iTcOtZTKjOLHibstPXmKUeGCN8Tqe1KiPxmz6Uj/AkbH39/HVlLnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987544; c=relaxed/simple;
	bh=T8kCvy+6tAgvsXxoAHr+ecyRGya1XAgh3KXwqLc911Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlvacE3J+apm9torab03qnDvKOVVW2u/0Xxa9D7tZBzFeog8KCIJkG2b5OQMMXPU/iGsJIRSmOgC2oWbYXmsYmCNYvrvtGHLoJo7EI+VFsMsb3C5ARlMmXb2B7AvKAtkvxhodBKoZTUmLNyI7dOa041e+xgBRtHW9Do8M+C83Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXUpHwFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE21C4CED1;
	Wed, 19 Feb 2025 17:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987543;
	bh=T8kCvy+6tAgvsXxoAHr+ecyRGya1XAgh3KXwqLc911Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXUpHwFhHnV8qAfMGJhFOKWOIK3LVNIICUM6P9tQETe2ee5gk+TGkxN2yQjD2lfAx
	 ZTXku5DXk6OWICNZ+P4OH3YEE6kNZaXFUN7fp+RrHOiTx42dg8ZnD7rXhgi9FspdQ7
	 rmRToJAr7k/ZHiVSdMJsI3diGZRgYnG1iavYW1AI2xJm2D3WoiCHINm4Fi4A3+9/yE
	 5HkRLQP/0SspxRItBxevENe1DXs2N3PIiMIxQ5cu/Nv5xx/SeY1rkmkcqnccfg4Hmv
	 c7vVPPJOHSDn8TTf3PZqHSyocRRoBmOQZg6CADPYKpEAeZGKyskDDBKKcYRQEOaV31
	 AhLfhPSqpN2Ag==
Date: Wed, 19 Feb 2025 09:52:20 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 03/10] x86/traps: Decode 0xEA #UD
Message-ID: <202502190952.2F7E63C0C@keescook>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.581527735@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219163514.581527735@infradead.org>

On Wed, Feb 19, 2025 at 05:21:10PM +0100, Peter Zijlstra wrote:
> FineIBT will start using 0xEA as #UD
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


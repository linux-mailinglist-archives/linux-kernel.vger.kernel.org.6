Return-Path: <linux-kernel+bounces-522120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88469A3C64B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959D4189A2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEED21420A;
	Wed, 19 Feb 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJP43vzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EF1B415B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986598; cv=none; b=U9CXbG9jrejUr6JBQAfyOIOFtN0P0l4nPr1OiDm0/EpcONDt1UOR/v05JS9rI/C07ATE1jL+yT/yxQgW8OM+fQPuDwaTHraigdDm8G9qxLrnbWsDbe0cJYFpzYwHRGEdbButPffUWtAeGlslG3RysWAvIYJHowtWYfIbyGTBsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986598; c=relaxed/simple;
	bh=N+qUOpNRVu6oRklpzQJqR+44U2yrPvBdb73H8aSu8zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2GB6azvkK4sC0c/nlHSwDf0rh0jZ9WiemIgxO2EKo9Q//44YXJX1Db22RWCFi9SgjoHIbmaFahcviwFypJYtRW1MXP5wVxNxa3WZHyMxHOwiBA7AYoVpQxCIzjiptS1Rsc12CygkULikZRHoGeKFO1cUuX2bc0i/EI31sgZHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJP43vzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DB1C4CED1;
	Wed, 19 Feb 2025 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739986598;
	bh=N+qUOpNRVu6oRklpzQJqR+44U2yrPvBdb73H8aSu8zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJP43vzR6GTi7o28Hob6T3Ou0NTHez/UUlIa8SAjQaZqRz2vkLMij/hrmeAeSpt8M
	 gZqX09B+paH+IMwBGDPEUe5pnpCGlsz8QGM+GRsdlQJ5iytfh7z3P1PHMUMG4nixXZ
	 wJhvzV5VvZAvC8iubd2MceZ/m58IXFnfwI5+QD+9Bc4I8JS79dMrfz0J6EGiMZTihZ
	 ZbNDb33nssLyjaMuG66wf7ScHy1X7y+Nu7kRI+LZeF+SQTqO+6aLrioZejQVKI395W
	 /zy7yO4xnWZrbN0dGu6sBoPgsu5/Pr7TU+EIk7BZ9FkpiZN6DSrhpOAqZDkkuDe0jL
	 QcwMI6ZOQIgTw==
Date: Wed, 19 Feb 2025 09:36:34 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 00/10] x86/ibt: FineIBT-BHI
Message-ID: <202502190935.FCA10236C8@keescook>
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219162107.880673196@infradead.org>

On Wed, Feb 19, 2025 at 05:21:07PM +0100, Peter Zijlstra wrote:
> Also note that LKDTM's CFI_FORWARD_PROTO test will do a double splat for
> paranoid in warn/permissive mode, since both the caller and callee hash check
> will fail.

Hah! I will declare that as Working As Intended, though I guess it is a
bit noisy. But given permissive is mainly a debugging feature, I think
this is fine.

-- 
Kees Cook


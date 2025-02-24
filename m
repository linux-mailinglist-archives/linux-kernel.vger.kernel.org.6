Return-Path: <linux-kernel+bounces-529880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48231A42C21
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87A43AB3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE4266590;
	Mon, 24 Feb 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbpINjw4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4C263C85
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423448; cv=none; b=df2+tn2Je0ChiVqUpi+7OxCcoC3gO3vnBDD9BDodTZGJpBFauGqVopaDrm1ZsOErsPgqaxdBOajChJbXSOE/FXS9ujZB9TKCdDI27pF6PIMDpcZnsBdxCn7QkSdWoN20sy63ZR65ka6sttzbLiej0c0QSlImBYw/6/D3aIpRoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423448; c=relaxed/simple;
	bh=t9mPDKkDP3Ii8BUvnj5o99mIEmgWPH8nX2vw+nFU9kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHOPzGHKkSfi8F96hwQuH6wpdO0jQnqN3IO/eisjRcTlZeDMPKM7+O6KE3yIOy2/jBoKjX33+R/hDdEkMYT7iy24YkL6FAkTTow9S65FN/7vM/uBXVRLJ4Oe/06zPErTGdvKjVqYhYX9yY5/YZuJjlUSLfcK1FkuAVJRWh9acR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbpINjw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AB2C4CED6;
	Mon, 24 Feb 2025 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423448;
	bh=t9mPDKkDP3Ii8BUvnj5o99mIEmgWPH8nX2vw+nFU9kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbpINjw4vSKqypwmv0EJVpVg6OcSlesgDs67Fe4g1ltWYcXyEkl18uxBYErGTdexk
	 mIMw5C3ktIvbKm8ylzAX2SFRMGUa+iL1FyASDsmNeMBgCLBn+Oa6WrmfmlRmiKxhwJ
	 m3cAtys2Bq+cv/4x79RZU0VKHQQdsuHupTgacbJwtMsLxbyt6t+USSy+70C31z+9jz
	 dzbFVeWDRcwbFS6D4hxpT2UO/eeXXj61YFPVIZFNuS0XmTHLg9wGDEhcn/blSRKTG4
	 IlXLrC5POqfCoDBCli0K5CEwpxZ89xUPykseEL24/kmpgEBAFlgJ+vpW//x/X508Yg
	 jsRR94vp95HbA==
Date: Mon, 24 Feb 2025 10:57:23 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 01/10] x86/cfi: Add warn option
Message-ID: <202502241057.F1CE482@keescook>
References: <20250224123703.843199044@infradead.org>
 <20250224124159.924496481@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124159.924496481@infradead.org>

On Mon, Feb 24, 2025 at 01:37:04PM +0100, Peter Zijlstra wrote:
> Rebuilding with CFI_PERMISSIVE toggled is such a pain, esp. since
> clang is so slow.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Lovely :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


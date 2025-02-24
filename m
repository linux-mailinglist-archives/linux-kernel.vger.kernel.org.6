Return-Path: <linux-kernel+bounces-529891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85AA42C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB69D18944A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88913B5B6;
	Mon, 24 Feb 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwldJuis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776F18C01D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423636; cv=none; b=ANrAcJoAjOzq46R1EOpHWSQeCwfjF2n52Rdjok+a9Q9TNt+aunMhw8WqUPMFKypcicUTHu0lYwrcMQFCCP0Qk9dRbrFmJdZVLHhLVj0Z9f8b2+eNSfMROyBjpr7Z4Q6oxh/kP/cMmnuR+jOIEtepolETSDLzFcrrizcBYqYzGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423636; c=relaxed/simple;
	bh=8tul4V2GOV+Fz/0AzktR4Lcq4AR8qrqogxT3Ut9jVes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su3lW1QWPA6uMwM4sglhoBrjQHQbL0M8P7Sd1d5kvc/tXDoBeqYkjgTdjwFPSEhIot0kWWqfIw5ny8mpC2NeqzzltvzsKA+tBLI4Mv5o0kfZZQf1v/MVeQSyvUo7rwTiBHIuSaAsUM6qmHXO2+U+zDtRVbHI0p3FqTbjhk3m6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwldJuis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B88FC4CED6;
	Mon, 24 Feb 2025 19:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423635;
	bh=8tul4V2GOV+Fz/0AzktR4Lcq4AR8qrqogxT3Ut9jVes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SwldJuis5jUi7E+CGMj2U/21yKbkLEoGffDSy8TeATrcpChBKKsSpvh0br7ZzBLcg
	 JiQv7z90CtJCOw+JpnJvIVTfBNe4xznnb1ta/SMaeMQ1WtQqt88rPZq93s14YBNqGK
	 zC48bC1xAziY7LtKkqcTCgKYV/SLQn6q4t1DJAcDrgEe/2bllYl/0N/EZ0GD/Z1BSD
	 3rfqtQMzUkl+Z40aKnbcAyI1QGmEs16HnxOFgr8T+BuWoyKbKIiYv2N3VY3lNmod0F
	 JYrZ+zZTSRWgFsZOBS83RIUYpNHssyOeScrUBouSakpVnvLO6tT4cXH3/vA8qtwdhm
	 PH6KShGqpMLwA==
Date: Mon, 24 Feb 2025 11:00:32 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 07/10] x86/ibt: Add paranoid FineIBT mode
Message-ID: <202502241100.2F2F320F07@keescook>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.598033084@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224124200.598033084@infradead.org>

On Mon, Feb 24, 2025 at 01:37:10PM +0100, Peter Zijlstra wrote:
> Due to concerns about circumvention attacks against FineIBT on 'naked'
> ENDBR, add an additional caller side hash check to FineIBT. This
> should make it impossible to pivot over such a 'naked' ENDBR
> instruction at the cost of an additional load.
> 
> The specific pivot reported was against the SYSCALL entry site and
> FRED will have all those holes fixed up.
> 
>   https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/
> 
> This specific fineibt_paranoid_start[] sequence was concocted by
> Scott.
> 
> Reported-by: Jennifer Miller <jmill@asu.edu>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Great! I'm happy to see the pre-call checking. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


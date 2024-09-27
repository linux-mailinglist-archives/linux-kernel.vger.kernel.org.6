Return-Path: <linux-kernel+bounces-342273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666B988D00
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30F1282D26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563918B475;
	Fri, 27 Sep 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnJ4t1MP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40E1FB3
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727479670; cv=none; b=PRwbKHNem08K4OIQSuwdYMbuz9JwqKFRZy1bbnBLbClXDmJzUwB+ZLQMiFJBfw1ocu0Nn710HjJ7+s3fwir4Hb3RgvVmt4f94+DdBGT+IskXHMUoTFvg9pdzU0eEizpWJEG3iSTcFBDeaIMOl0GfyQo3trXD6hBbfgwDBluYYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727479670; c=relaxed/simple;
	bh=c532xcn0E6+t0IqMIXYFeF1PfUk7PBKFyy/CT8muD+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htO8omeTG1rARBkz2rLtEOfBd8AqPrrDHHtR0QTxlWbbtBk/NpmhoHXavSD+sgesgPNLCxmL5MmZwbk9eEOsGNJ/TISutxXIWGzvATH7yzlO8yX0e8VH8fbU3RqFq4hjVhoMd1z9bmyV2MYlTA9dpsATVi5dePaP0o0MKsuGb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnJ4t1MP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B965C4CEC4;
	Fri, 27 Sep 2024 23:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727479669;
	bh=c532xcn0E6+t0IqMIXYFeF1PfUk7PBKFyy/CT8muD+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnJ4t1MPwBnYHC6pN/TqfQNh3V9asN4XeXIa/MV1sFLH6clTrgCGt39s6UIVHypaa
	 1U9xhWppV/uCAjfQPyN/aYltapdX7r5vUFZwQoq6atfPybbYKA5KjVdgRiuQ2AOb7S
	 5ZktEIq2kTC0cp6kJaQK7/9u6D50DaHU2i0sa2ESIMbq3pCVKipDigtgopaqLIlSAH
	 wGjyQWqtZVx0HJa3EiIbm30PDLnOzR+YopuThyEdfnBBvYYYBma2mh5VrPApX/POFy
	 8cmrqQSR/sdKsQbnWPxEBbSImCK+LPqNHkg9DHoP1Ix6rJ/Og+l+N7cSRTTxy+XD7V
	 wpYjq8jjIT5lw==
Date: Fri, 27 Sep 2024 16:27:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 03/14] x86/alternative: Simplify callthunk patching
Message-ID: <20240927232747.q3vcou7c2ueimr32@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194924.617641991@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194924.617641991@infradead.org>

On Fri, Sep 27, 2024 at 09:48:59PM +0200, Peter Zijlstra wrote:
> -	 * Now all calls are established. Apply the call thunks if
> -	 * required.
> +	 * Adjust call CALL instructions to point to func()-10, including those
> +	 * in .altinstr_replacement.

A couple of tweaks:

"Adjust all CALL instructions to point to func()-0x10..."

-- 
Josh


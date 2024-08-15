Return-Path: <linux-kernel+bounces-288249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CA9537E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9C8283C23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E41B1437;
	Thu, 15 Aug 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkormY1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A414C69
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738022; cv=none; b=tpKJj8XKpaTFMfxPUBnDoPBs3KE4p7jbq6WcjAU/GeWwmYaveBAL7j8WDk8zXw/d7jr+WV2yVPUaRmU3nNN9QgBauwi+32dSykiZSL6AHelpBHGuFjOlHWv2w0qCnLutUnOGPh94+PML+UuTMSY3+K9OyjW5WF8Osw1oB08JDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738022; c=relaxed/simple;
	bh=qqxyCTA5TmWr5/A46fa7vWod1K1SOVf9QMKqUeF+GaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGAz1pL7anavAegvV/9mDMKr2viaUulusnfx53xXRn4GB+MO9jF+ZLY6vPI9OXaQ3SkMzuMBClWVcsSwQQvpXaEP3M5p1wHAMq4KYYdMZjREbTqZzXGSIiK3oB4yervtQTdx/ETMycFGDPbIK0Eeq+8h82aa3Tboxrc9Gl6kRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkormY1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF3C32786;
	Thu, 15 Aug 2024 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723738022;
	bh=qqxyCTA5TmWr5/A46fa7vWod1K1SOVf9QMKqUeF+GaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkormY1/pTUeSX2KTR4sj/oWRFGWUu885mMvanjRamSt68is7jAqCFNr0P6+FtEvk
	 rGVsSCI8EM+mb+pZrSsp08gy/U8s+gUMEJgPjzrv5bRh0FgfWb+wCuwCRmD61HWxY9
	 m2fuuDxyL4ZJN6fmvWhwdqDEU8GVk4Mc6DnIGrA8PvGM0GNT+lfMhqIu2efO8hSWSD
	 A7jfF0a7nNwAaGQ9EnxGFenW3Rmlg/DlHSVUCQ4vKW2M/Ua/9UdTgXfvH8jfzHEfwB
	 itLzq+3Dkc4W8DQJMg/AQ/NnN3EuU8JBqrTPyGzG1DtCEhkCEXTsWW5VzhaD1oZuI3
	 iVRzsccxccwBg==
Date: Thu, 15 Aug 2024 09:07:01 -0700
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/2] string: add mem_is_zero() helper to check if
 memory area is all zeros
Message-ID: <202408150906.28A920F62@keescook>
References: <20240814100035.3100852-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814100035.3100852-1-jani.nikula@intel.com>

On Wed, Aug 14, 2024 at 01:00:34PM +0300, Jani Nikula wrote:
> Almost two thirds of the memchr_inv() usages check if the memory area is
> all zeros, with no interest in where in the buffer the first non-zero
> byte is located. Checking for !memchr_inv(s, 0, n) is also not very
> intuitive or discoverable. Add an explicit mem_is_zero() helper for this
> use case.
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook


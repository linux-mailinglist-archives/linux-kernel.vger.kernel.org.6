Return-Path: <linux-kernel+bounces-547732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DDA50CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFFC3ADA61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865AB255252;
	Wed,  5 Mar 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QitL76PM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DF18DF73
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208081; cv=none; b=G9LmAoRVUI3TBbf61/GzQJH+E9ZyrRY3CqaNUiq4yuMsMy6+33H1AaEV6+C3Nv+D5eKB5mjir5Mv2MiLvybUkPAP1UmuuKTPHyxNLerdTVfu4GkgWiHkiglAVz+nE6ENydTEmljQz5qs05hMMRfZxuAvdpRlUbbe/1oJf5ejXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208081; c=relaxed/simple;
	bh=YyuXUIRo7eQwbVGMLMKoGd9lxL5wkWbKIXDe91spKNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fChVQOozplX9sLRM+lfSUlQg2xc2ka/UuXsrZDxnrs3lXZZSEP2oMDTfAbbv2kBZYnzzfYmuldYr2oNw8REkj7RAu//0YekUCexDCLoKT4bUp/ydJ2npGyWqdmmPd/AllC0aNjgiAue28McHQz1XXVkXLOw3+szjguWu4B7YCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QitL76PM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E696C4CED1;
	Wed,  5 Mar 2025 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741208080;
	bh=YyuXUIRo7eQwbVGMLMKoGd9lxL5wkWbKIXDe91spKNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QitL76PMK7C0VxUGyFxSTQjM3FciRX+1lslaoXjqlA9dbKauD30wA3my86vPlgosb
	 AvRCCF9aW/eo2fD6EOHXTNobhCSZ58SXlNRzkRl7F5tZi7U3dapBum35+Qc93Rt30X
	 CHYNRDZxNGEz7mj9t+fq1ZTkGs9RUO5rU+Mze/YElkHHwAAz3GBo0KpbOD2V61i23H
	 AAHe3VvF1ufV0t9nZFIh673YaMS7pogUYATCMV5j9yXLixQUx4HUNcuUH4czjfBGUU
	 GvLlzMuKD+A6ASVIyk7/aZxhMdDv/06W/VbZICKiFnCRUG9vWB3gWaMtBqRWK2vQUp
	 OpsdlznIBhZjQ==
Date: Wed, 5 Mar 2025 21:54:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 02/17] posix-timers: Add cond_resched() to
 posix_timer_add() search loop
Message-ID: <Z8i6DafohTLE_Zoj@pavilion.home>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.037768273@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193627.037768273@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:46PM +0100, Thomas Gleixner a écrit :
> From: Eric Dumazet <edumazet@google.com>
> 
> With a large number of POSIX timers the search for a valid ID might cause a
> soft lockup on PREEMPT_NONE/VOLUNTARY kernels.
> 
> Add cond_resched() to the loop to prevent that.
> 
> [ tglx: Split out from Eric's series ]
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20250214135911.2037402-2-edumazet@google.com

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


Return-Path: <linux-kernel+bounces-318931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DFE96F54A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20127286132
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8341E1CE6FA;
	Fri,  6 Sep 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5aA/IIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66241CDFBB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629154; cv=none; b=PMJ+ADZYOL8khSpAKo6rMVOaYakREj3zR2AeC8OsGye7UIQf7e5ArDAL3Sc0I5f2QUtEP32iH3F6KPf6LQkHZtJ/T/msDSZu2YejqXt3QA/LuA7yveN1DgAw/kOLd90Z1HG9LxB02PUqjYof/YR9P2oshjVVF1KjmvTWvbAwiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629154; c=relaxed/simple;
	bh=vttPD8slAEXGNsOubSu2/EDeAoufYpQTQpp06Y84EuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsKsKFfC2oLVyMfBseLPU1EJwJ66EDp8LO3AZYiRl17VpSKHIIIuE8z3Bg9lhi9JoGycpjLUM/wtRZLpqwder27RX1AVlap8jj0HCmwbWYtPQv5uruliJod7f5SsiHy1xwpBMUpIYROJHQl+GlvIcVuBzES7CeKY+3VGpo8jEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5aA/IIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294E1C4CEC4;
	Fri,  6 Sep 2024 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725629153;
	bh=vttPD8slAEXGNsOubSu2/EDeAoufYpQTQpp06Y84EuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5aA/IIc7h/WtAETbVrNJ4qMlptFQMjiueJELiXCtVILhSYEAeoYKIz/yEkKZ4I3i
	 AsmlUnRZMJEVxHxHZImdrkSBFljTG93AVTWe4tXEA8Qa+kvY/NfnUMWRlR9h2sk1IN
	 GjZrfSH2WFWmsgH0neidy2oeYuyKCzu68KVIaUtgw3QlZLPIen1at8Wi8FZKa8sxj/
	 5vD00Tm/OILAXrAJHq4jMTECVGAChJz04c5Fie04n/FrsGWmOJcbgiCmNutraDOZVM
	 GMIMfQNV75m0qDqbV+ZkXVZe6KvRgOvDva/u4LjndRPxbnO7P+LpWYt6JWGmtc6XRe
	 oFk1pAmArLhfA==
Date: Fri, 6 Sep 2024 15:25:50 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 01/15] timers: Rename next_expiry_recalc() to be unique
Message-ID: <ZtsC3iwDBrm46nCs@pavilion.home>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-1-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-1-e98760256370@linutronix.de>

Le Wed, Sep 04, 2024 at 03:04:51PM +0200, Anna-Maria Behnsen a écrit :
> next_expiry_recalc is the name of a function as well as the name of a
> struct member of struct timer_base. This might lead to confusion.
> 
> Rename next_expiry_recalc() to timer_recalc_next_expiry(). No functional
> change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


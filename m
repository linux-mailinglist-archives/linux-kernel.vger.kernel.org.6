Return-Path: <linux-kernel+bounces-357140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 656FA996C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7F6B24C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC371991D3;
	Wed,  9 Oct 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8qsbq8d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF104198E86
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481053; cv=none; b=KcqA6scZVxLcj+np63k+Ll8R/SHND7XeaW2MerIhILFP9f1bLTgiHCZAKSR3ENB6xYDVCpTqaiRnJazoKdhPohvKXASaz4qFc3biC4pYWwCGMr/pj4KNGz08ztn5/j03eveXK29RxVIzCOgIuuCCWdm1qvd/RcQxXiKvJU4FJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481053; c=relaxed/simple;
	bh=TXvaZhDlsmJn+4Pd4Fgmr8fAWFhUCywRYgjrA1ZOGbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNo8B4l9yv4Nnrj14TYN76T2bzq1W7UYPobJbxz8AH/D8/T+qZge8eFTR59+mO9qguUIaetVikfodnSBasSW04bg4WevdzY6kFawnak+pPRIRoQ/eq5ZGQ+bNo6Gkt4l7sOW8J7sqbrbNeZWRuIym/AHY3jejb4UqqyKAc39LOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8qsbq8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7710BC4CEC5;
	Wed,  9 Oct 2024 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728481052;
	bh=TXvaZhDlsmJn+4Pd4Fgmr8fAWFhUCywRYgjrA1ZOGbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8qsbq8d/7+jq/TZGJHfG5mZq41VfrWJRUTXP7l4ky+nbU4KxEbSqGatCpk+L1CUp
	 5gnrrYsXPYUS3adlS44ygpoF+nyTCHzmIXudGx0tl2p/ZyXiUL3XD7UAjJSemC5rlO
	 MxeXOBO897D5UEBQNcBdFJoPuMfL8QdL9QopdUpj7kzLIrsIVkd5/Q6f2W96PbGfNv
	 CpHQCXTNd60YgYHtK1E7GtXsTrDLbVONH1IIHI9oFJGN6PEhjzN0ILiMEZrE3n6zfD
	 SVf5qCRNH991QCKfUk1OS8Xac2Lken8XPqU8kjuvZ2jCY3q4Ey2fJ5lT1MxUxuEZ6o
	 0rLEcPcaVSP4g==
Date: Wed, 9 Oct 2024 15:37:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/15] regulator: core: Use fsleep() to get best sleep
 mechanism
Message-ID: <ZwaHGmXUGRSRLKlo@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-11-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-11-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:37AM +0200, Anna-Maria Behnsen a écrit :
> _regulator_delay_helper() implements the recommondation of the outdated
> documentation which sleep mechanism should be used. There is already a
> function in place which does everything and also maps to reality called
> fsleep().
> 
> Use fsleep() directly.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


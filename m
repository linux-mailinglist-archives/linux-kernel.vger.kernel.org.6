Return-Path: <linux-kernel+bounces-237065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880691EA8C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8934A1C21134
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA5417167A;
	Mon,  1 Jul 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em6QcVy4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ADC171655
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871050; cv=none; b=kz3l3tDZs5Wgd0FzTZZ0k6jbJ9GGK39Py0FDM+W5YiTMOHhL1hmuC9WWprzop4FdS7oHnQnzJNXYxjQZypPtZJyjoKGAp+zdYZCSc4f58+xcbDBJe33KOR0xuxl7/q6JsvNJisCSKNjoW/LiuFFT1YCdMO1xNdY/AnAzh/TpS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871050; c=relaxed/simple;
	bh=pSGWvNOY40zzOY6u2tpBgLY5iHODWKDLaTLzGz27Lzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab0veLbJrD6AjZ5psw648z8eCULdaS9hQhOH5khSWwxFCe0xDwsy9ZvIngkWO8xo3P1tRI+PhMiYei88aM68v7mWZeXQ9/CRt1n4Amaw1ZqZlM0QdJruaOOvmtrWbmWUW/mcep/bSTbLl6oLEPtjmRIPUE642ZNb/9Xi85h+M7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em6QcVy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EB2C116B1;
	Mon,  1 Jul 2024 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719871050;
	bh=pSGWvNOY40zzOY6u2tpBgLY5iHODWKDLaTLzGz27Lzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Em6QcVy4PHYeQQCrs2InG/kHfFsDkQO6qTlreLy4HeDp6gs/wTULEw3WkJQvow+WL
	 wCUzScwczGBLMH58O2OjA9zlwBs8dkXLHeDhfC3Cd68hrPRVFERihlQof9IInkvovY
	 3ss2HGOLyl7kD6mlIYWRze0hxT3s1O8LuQPXqyr1CV7xMsQTEi1fzdcKXZbd8Exr02
	 8mhqLR9md2althFKV7Wn6dSRtmzQtptIy4p8oznJkaEkb2pzkNNYy0dp7yMXn0WHts
	 p4sOTctd0A5ZVUGyQb5vpZl7FoHetnCTBHcjHLW/X+3Apb02Xd+owq2UU6aiV2REnZ
	 rKr39dk2lmSsQ==
Date: Mon, 1 Jul 2024 23:57:27 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] timers/tick_sched: combine WARN_ON_ONCE and print_once
Message-ID: <ZoMmRy_CPVszLHx5@pavilion.home>
References: <20240610103552.25252-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610103552.25252-1-anna-maria@linutronix.de>

Le Mon, Jun 10, 2024 at 12:35:52PM +0200, Anna-Maria Behnsen a écrit :
> When the WARN_ON_ONCE() triggers, the printk of the additional information
> related to the warning will not happen in print level "warn". When reading
> the dmesg with a restriction to level "warn", the information published by
> the printk_once() will not show up there.
> 
> Transform WARN_ON_ONCE() and printk_once() into a WARN_ONCE().
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


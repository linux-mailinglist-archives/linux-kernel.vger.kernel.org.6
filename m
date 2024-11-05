Return-Path: <linux-kernel+bounces-396591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C69BCF37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2F41F23B44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D01D8E05;
	Tue,  5 Nov 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiEnDZGQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522E1D2716
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816766; cv=none; b=LbGZscQ/pDx4nLrMyWHZRcthMCg9htKU6UGk0xKzTFnu5Tbq7WkpJPeXKXqwiiSaN0/fMazbS7U/M6WDPlrC4MrPLMOMvYlSZBu3v862Qyi9HQuCaAY9FL+vVYBEdQlUq3OaISjFGJnoXY6aw+xrM2LuzAaafYwN/xxfKICKmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816766; c=relaxed/simple;
	bh=RRB4S6oaCkWDGjowVs3OMVRc494gB+uLM8BscN42BXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9sEhk/xt9B980aWpHxpgDyqgm3WX0CnGBBCP/IG1kMJJqmLdQkG+s/lZ2Yywk8gzXLA1IS41HWCe0I5z8EIjt7e3uHBeZz6ZeNvEPL0m9U1DB9zryfrKNnGkVWq49vMSoYKtNo3EPB+IF6kG8DUYMUi9aAVHkY7sqM2bHaGO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiEnDZGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFBFC4CECF;
	Tue,  5 Nov 2024 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816766;
	bh=RRB4S6oaCkWDGjowVs3OMVRc494gB+uLM8BscN42BXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiEnDZGQmUQLVLLuKOIJEEXBkzv7/CQKMd/UxphXfNrVj9JJfEti8/eUrudQ1+M0y
	 5cDS1RBjLdOEPu4uaXdsG+HrTd/2UqnPSU6uFh2FV3f87Zx2efRh+Wi0G123rZW4IP
	 x6BoD4tDIKsfDTv5skHysc1Dbg0TCnzIH+SxwjF5fpD1oMw1LZm6Wykkc8G3x258Sx
	 i0EKS3tFgT9iQpSyLx4DM3RyBefgRVLDcgyVH3fOBCtWRUE/UU0vVM26O1gkwz+lyj
	 1dPiXuUdMTdCUyCh3Pjp6ANnajZTtM4aTVlS1t7Td2/VwGDUsu8XE1jBkisqTOG7Pi
	 i29W6dLF4f0UA==
Date: Tue, 5 Nov 2024 15:26:02 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V7 19/21] posix-timers: Cleanup SIG_IGN workaround
 leftovers
Message-ID: <Zyoq-sc1_ihk-N2k@2a01cb09803abb1ce3ad97aed0fef98f.ipv6.abo.wanadoo.fr>
References: <20241105063544.565410398@linutronix.de>
 <20241105064214.187239060@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105064214.187239060@linutronix.de>

Le Tue, Nov 05, 2024 at 09:14:55AM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Now that ignored posix timer signals are requeued and the timers are
> rearmed on signal delivery the workaround to keep such timers alive and
> self rearm them is not longer required.
> 
> Remove the relevant hacks and the not longer required return values from
> the related functions. The alarm timer workarounds will be cleaned up in a
> separate step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


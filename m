Return-Path: <linux-kernel+bounces-374294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB59A6811
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B8F1F25096
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222E1F473A;
	Mon, 21 Oct 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWr8kBRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7651F4719
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513231; cv=none; b=ufRR/E0Ssvfz4Ynjo6MEzfyyBsHmqVSa+MRmxR1aQ2G5aOUFzF1nv4JiAQhhntTS4eN8k5Q+nOyeNSJ68ZpeIENRT+4sax8hbHDbrRmpxveVi3iEqCIYfnEWttXTG0uRt1xVD67cfS/qRvGwkNGXYDAjqtJpp+HlLNueNOJ2mRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513231; c=relaxed/simple;
	bh=k2TLFrsIIzBcrPM8/G0lFJK8t/xbBoRNJjGIH8lR6zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbrzk6auRRnUYTdsS47XJuQTRScdVaBrvvMF4IWwEsb8nn1ca53oogpsxESsSg18gnWlN+TQRr0NGL5M0jNHDc31hdz+vMPiGNBSRd6kZkAbuheNi23eoIYqHL8MS11MucMqWGRWi8otThm94ozRnVN/XuNmmthIFIcc7mG3mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWr8kBRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D66C4CEC3;
	Mon, 21 Oct 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513231;
	bh=k2TLFrsIIzBcrPM8/G0lFJK8t/xbBoRNJjGIH8lR6zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWr8kBRVkTWTtNDc0u9KVYlfc3vccYj92Q82XIRupwvzwTfgLBtPzgJkSNzUY4al/
	 pIjMfMpKyu3YAIS9/7UWnEC/wwyfICxpZ8qlWp68NvnS/2WdEShA5riE3ninLkOp/m
	 ArLNar3CKPb3/Fhfrj7Buh6U2w3QuWxO4k6fCPUObQds0HjaIU50rutZYey1ORo93u
	 UXcEJmhgEIVx4/G4798f1BuQsvzUZRrCpQDaa+MFOURJAfEJWfRhVMlZspdRvoFJZs
	 pM0r/UAaETpksPM1fvhfFnBRbydyWEKQiRhJdK42qbuU6o2jN/mAiZlKT53j0zd5by
	 Xzg4+eAg6cHrw==
Date: Mon, 21 Oct 2024 14:20:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 04/26] signal: Allow POSIX timer signals to be dropped
Message-ID: <ZxZHDK2fSjnS3SLi@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.494416923@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.494416923@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:04AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In case that a timer was reprogrammed or deleted an already pending signal
> is obsolete. Right now such signals are kept around and eventually
> delivered. While POSIX is blury about this:
> 
>  - "The effect of disarming or resetting a timer with pending expiration
>     notifications is unspecified."
> 
>  - "The disposition of pending signals for the deleted timer is
>     unspecified."
> 
> it is reasonable in both cases to expect that pending signals are discarded
> as they have no meaning anymore.
> 
> Prepare the signal code to allow dropping posix timer signals.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


Return-Path: <linux-kernel+bounces-226413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A57913E09
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA20B213C7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134D18412F;
	Sun, 23 Jun 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRgT9aqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550F1CD25
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719174242; cv=none; b=H6S6zv8e2Pl0OwmNAsVfJO1HJ/xagHbY0pRElUEcvTNV5Rp6M2zDUK5S3+kvPWvrTflnOVtUpx1TRAEklR5dSyFf2bKubn67qwv+npprCg8VtBFX3Us4SESR/cj8OwCOV6LldaMuK+HMdHLLF778Ck3Qy9HhgqdJlWQnOttS4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719174242; c=relaxed/simple;
	bh=yoUw5NrJoK/+yM5jqNYsUVHWR6VGSZKezBDJYEFD5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP9pLAWRzbWJre6T07hHZgxU3y1oWshOTMheD3ZpyXXMunPT1Y8MyCVFVA7+k0hm84szlrMiD+OACXF1wZlJAHHPDXu0ur8CLdS1Z9wAHsWeAOiINJTbwDYUSGziN1o1jixpvCDYtE6cQ+PR+2O2nxEFnacwBJ7ZHsd2bG+7EeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRgT9aqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68AAC2BD10;
	Sun, 23 Jun 2024 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719174242;
	bh=yoUw5NrJoK/+yM5jqNYsUVHWR6VGSZKezBDJYEFD5Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRgT9aqZ6kGNyNGtX9PLd/lm2Lo6gBzhOfO8P/ckhM0duFF+ub56rCrjbBl8th9Kv
	 f9Mqf8qNeW6y/tVRWL2qC8dwD8BPPBWDIfhjfq1NYVdHMqIxRmoFbefspmdtuXsQhI
	 UP36mviNBhu8KZZZYlZ/n2Wud7T13hc5tMhIBX7U8Z4OBRFJmN9rCn8lQbMQMPwbyD
	 idOAulzM2l/wBPYQKPbJUEG58S38momzmvlq/SVGtvgAlD4pBz2KKF7w5G8TE9xqOO
	 lBB2kKOco3yQHP6avkR0vnZBnqP1Dbwu9ZMqN+M0IVdsKy9F/T/Dj5M5e2+TVJN3nn
	 cqLEb3nTW1gHg==
Date: Sun, 23 Jun 2024 22:23:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3-2 12/51] posix-cpu-timers: Replace old expiry
 retrieval in posix_cpu_timer_set()
Message-ID: <ZniEWiiZvfuwRfrd@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.225762087@linutronix.de>
 <87tthjykln.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tthjykln.ffs@tglx>

Le Sun, Jun 23, 2024 at 01:17:08PM +0200, Thomas Gleixner a écrit :
> Reuse the split out __posix_cpu_timer_get() function which does already the
> right thing.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


Return-Path: <linux-kernel+bounces-226388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF5913DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7AD2831AF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44959184118;
	Sun, 23 Jun 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtJNHj3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810B17C69
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719169969; cv=none; b=EcKUIeZ1eXZYkVYODHAZwPnwhrMTsMYKq5vySA5eQxNpisns3vhbBOEriMw5kK34nsg+Drn1GIqn4eqEK983hUhBg6GhnXs+ERDKVoex7kTI5Xloz7D37KPWl4S83oLs34DM9VK9z0loYnUc9pBV65PluK9Kai/VNHFh63m/pfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719169969; c=relaxed/simple;
	bh=WwHJAyX1p02rf7M9QGqMF9eVDgg16vpA+KGhEsuoco0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGFO49Had9GY3KKE15ip4oFE46YPZNC37d2UDE56tEGhr15lGg/oNIxn8s1eakZUtvLXWljT+GLgNmofHU6+TFqkUYg/Dtb8Drh0ylEpQXWKZTGokQFrwhEX7SOJAb7/78cGTd/XLg3VFP+fdK1272Fv3PFkVQ4cbYV7Cqu6Jp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtJNHj3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A948BC2BD10;
	Sun, 23 Jun 2024 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719169969;
	bh=WwHJAyX1p02rf7M9QGqMF9eVDgg16vpA+KGhEsuoco0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtJNHj3R0IylDAz95otpbTuA3TjqxR+tDpuD0Lid5l30qF9YCEvAN/KypOvqk8AYo
	 2mYwGqbrBzDb+66nA8zRPl0X3b+/Y2oHHDzHwyOWH4aQBZVCpeSIznvHG9MedhQqJV
	 gzeSnHrU4LWaL5ko2qvwbTR6OvYi3t5HNeZ4f6fg+YF8Rw+nis4Aad7vCOmepxZXN8
	 szxOC+JVlLkUNEHyGNEu2amezQCl19dxzOCzcXYIeC0+lrZYmx7gKiB/ngsRHTP16b
	 CIjPTvoh4cOlokOiK9XvCsdknfUcauzLChVMwJg0bC1seizuo3KEpnQj6UWKzoOHfY
	 0LGhGMUnrrd4w==
Date: Sun, 23 Jun 2024 21:12:46 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3-2 11/51] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
Message-ID: <ZnhzrjczTBGbO6uU@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.162380808@linutronix.de>
 <87wmmfyknh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmmfyknh.ffs@tglx>

Le Sun, Jun 23, 2024 at 01:16:02PM +0200, Thomas Gleixner a écrit :
> Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
> timer_get(), but the posix CPU timer implementation returns 1 nsec.
> 
> Add the missing conditional.
> 
> This will be cleaned up in a follow up patch.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


Return-Path: <linux-kernel+bounces-388558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B0C9B6134
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BA81F22BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA81E47B2;
	Wed, 30 Oct 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9OrkQxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3CA1CF7DE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287009; cv=none; b=KoMN3n7gbXqPVf6ixsSFZkkIc99TvXbpbZvqXyEtOJ2dpfC9VCbI/szQ7/I01f/MLTEzRzDrNjxjPzN71B/D1VDymvctX4VNfpJup95NSYAJ56NPfPStaM6JN2/ANaL/FJDO+bLzE1li8beduUNMDf7wtIxYmV5bdBXTLIjSD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287009; c=relaxed/simple;
	bh=CrTKs/PgnusP+ItjAesPGATDP1uOydqzrTWerpGCjhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjhaTDUPp6S00X94dG3itopjp9jYl+eZJucS79l+G8nyDpegXQzn9UwzCYURYcHf0KeCJmcNFiRqNNjMZeSiNMogJn3kMwFrCvfk2+W4zKOtFmAG4OUmGpxM1c6kGo1pLUQH+4JuzauvB9D54S4gEIs2FYYklPQq8BIrHZIPemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9OrkQxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00C9C4CEE3;
	Wed, 30 Oct 2024 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730287009;
	bh=CrTKs/PgnusP+ItjAesPGATDP1uOydqzrTWerpGCjhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9OrkQxR8VYw++8Ifwb1fkehxaV4DDZRJCCm8wj4If6vVSFQFhIYo9hGtBMSUsU2A
	 LbzZszcDCSslQhDp5jStwJCd3N0tEkQiUkh5UhGjQRj++A/Qh9C8q6626QzLUOdhpT
	 o1l6xTIP7G+lS1o4Ew1Ak0HR1FhwVqITVtJvjGnGHXBkWI63WeQAAXE0Kn7eVySeie
	 R/L85twmjsvtVVB6edZfdJ4ndAVxahALjXf7TczDqIqLdBS2zA8I9A3M36zSWsILL0
	 zqGrBn/0ae3H5vPl/ksBLfiQKFOBlAPHPLJYJvrKRju45NokhbnsUR7FLol1b+gJqg
	 Cg2V0NKgJmjAQ==
Date: Wed, 30 Oct 2024 12:16:46 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 18/26] signal: Cleanup unused posix-timer leftovers
Message-ID: <ZyIVnpqpNiLths5_@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.337735372@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.337735372@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:24AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Remove the leftovers of sigqueue preallocation as it's not longer used.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


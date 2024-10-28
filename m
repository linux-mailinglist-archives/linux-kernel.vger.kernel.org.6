Return-Path: <linux-kernel+bounces-384627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCED39B2C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3601C21F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E41A1CB9E0;
	Mon, 28 Oct 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f56RSobF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80A18C910
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110602; cv=none; b=oMd5upZiBg1u3U6soAjekaETcyMd0XHw2LZR7ap0WwBlrDylRbPvcT0cPHtGIF26By1hvTesnCgzbA1GuqkOd5CBDAdcSPWxWHWWzdx6X+Ze9toa88DqKBj4FXZhXPuy1ThtUJagvTmGEjzuzQrWLhVNpaokIOFMBPyLFJu/SUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110602; c=relaxed/simple;
	bh=pZkcm+KV+yjm9a2ASWvSYVQ57m9OBeAd5fup9Y303XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7YPezNwlV3RQ+iG363Pk7cshZqiEhmj5QI3dx0R0+RoONxwuqWld5V+kJDcwpvp1Q+LQSIFsnAncEJfyn/dAPlt/BVSiuiscQjCVVnVzHZvMRXXSJI/UJYe7kbgR3GMUaRPKgyvtJ0hjCN0e2EZ6cYGsqGpDNQBT7rh0bH3vNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f56RSobF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0C8KesZBo9hE0DFXc72TfXvQTFF0Y2Df9m8IM9xFT0c=; b=f56RSobFwX3qTSzjA3QUkVe1yj
	tLEcJb/wKjzjLRjxUbflcajLdZM8BPny4XRJlJbsMx22eQy+uEA+qpn/pYUvKdsCvOfaYCpzl76cN
	U2qQy2nYg+HQ/qXD6wZiRNS64Nj3deDgUt/nYzOzMBtTckKqeEHP/bHLbmLClQ3ylNxZu5ZxprxBu
	o0atp8Xek9+ZJ7stcQNzyLx+a0NvSvhcdPT8C04ixsZltWUj3jVqJ12UjAd2aXYSSygdsK/e3y+4+
	gsIyW9feC56+KnCxb8pI/gUDkJ0z7UqpvPeYYSwWJ6Fnt8TsIczljgCE3jFrRPBktw1DjB2pQBwe3
	vaz0UDqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Mna-00000008FLk-16Ra;
	Mon, 28 Oct 2024 10:16:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C7AF30083E; Mon, 28 Oct 2024 11:16:34 +0100 (CET)
Date: Mon, 28 Oct 2024 11:16:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 2/3] futex: Add basic infrastructure for local task
 local hash.
Message-ID: <20241028101633.GM9767@noisy.programming.kicks-ass.net>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
 <20241026224306.982896-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026224306.982896-3-bigeasy@linutronix.de>

On Sun, Oct 27, 2024 at 12:34:51AM +0200, Sebastian Andrzej Siewior wrote:

> Introduce a task local hash map. The hashmap can be allocated via
> 	prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_ALLOCATE, 0)

Per process, per task is useless and will make things malfunction.

Things missing in this patch are CLONE_THREAD / CLONE_VM, and create
must be absolutely forbidden once mm_users != 1.


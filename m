Return-Path: <linux-kernel+bounces-353285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A5992B93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CE6B24CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622D71D26EA;
	Mon,  7 Oct 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x4XbRX7t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UafGP65S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8131547D4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303757; cv=none; b=iOf0idN54ibfNJRjDw+x1D46v2+0wv8tkjoOLBsi+JaOH1W51gRGDjThvFormvNWXfLiw11+JkaYVv5hlNChdUaLMkCXYQ0SS9zEsoPsdguRAleq+hv/mpvvPSgOUrKca1qZMBFVEQyRURoZJeh1Wxh39NUFLV4TEvs9TiVH0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303757; c=relaxed/simple;
	bh=KmBfDE3jSHei81HU4wI3oQTEhTYqF/rMqI04GpxpFh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ1YdpygQFOxFiTfsE04diOGFlhkfNNBQNqP4u6UUiPkjTgQUc0mrh1rrWPFpYqaxLdNz9zTJNAAspqAUjQgSErVjOVPlOmPJ914K5pVGmpfJwvBqb6Vz+PJG5EX7ELVYHOodP9xPVggMM15HzJIOY5PPBc20nMdUlGSAEXBIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x4XbRX7t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UafGP65S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Oct 2024 14:22:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728303754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gc5sxsFXS9AkNUtlJrahR+dBqQ97Y0rDZ8W7qUX5v6s=;
	b=x4XbRX7tvM8a2bMIWMS7rokOvEVrzr0chJvuw4ZXLtky+WUxyu8LaL2EkEyh1zqhFpjIUj
	Z2cjQ1sSWgKDz38teYShFLdboRAT5bjxTSMXsfUkhFSzBzBRFkwJ3xz/1V8i3K4SeZem0B
	5sfg3obW7NngF8RjGmSgko6//0jZH2WdeuzoJFCuRAhc7gJNsZI4V12ME6Q1oB78kyAEn5
	S27w2P8fdxbZMMfto5t6Ca4E9szkR41c900qg8nOD/qAJUs0f2oab5tuMIgn606JgaybJ+
	ITfjD6YT2wYnjliBu5dbv0iI7AFdjRfNcmCik0oTRFqoq4a4WTSjp3fLCvqYhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728303754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gc5sxsFXS9AkNUtlJrahR+dBqQ97Y0rDZ8W7qUX5v6s=;
	b=UafGP65SDdjrTREjlB5ron7y6Abv0ahTkrnhiyzajpUQzRN798j4utolN0TaHJiIiY7rA8
	XI07IfSt0H2wejCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Hou Tao <houtao1@huawei.com>, Jan Kara <jack@suse.cz>,
	Jianhui Zhou <912460177@qq.com>, Yury Norov <yury.norov@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt_rt: increase PERCPU_DYNAMIC_SIZE_SHIFT for slab
 randomization
Message-ID: <20241007122233.egDhzjYH@linutronix.de>
References: <20241004095702.637528-1-arnd@kernel.org>
 <20241007104348.ImJPXDl9@linutronix.de>
 <98957f9e-aa9b-4d8c-8254-968905e85023@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98957f9e-aa9b-4d8c-8254-968905e85023@app.fastmail.com>

On 2024-10-07 10:59:36 [+0000], Arnd Bergmann wrote:
> 
> Can you pick that up for rt fixes (if you already have a tree)
> or send it to Andrew for the mm tree? Feel free to take my
> changelog text.

I make a patch send it to mm so akpm/ Vlastimil can pick it up.
Thanks Arnd.

>      Arnd

Sebastian


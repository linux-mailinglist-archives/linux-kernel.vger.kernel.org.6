Return-Path: <linux-kernel+bounces-193111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389D8D26F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D294F28289B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1DD17B439;
	Tue, 28 May 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Za29AP1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6A224D1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931171; cv=none; b=AN+hpxymQbEtUoJ0MvpZMHq2BnbIO8r5YZOUr7h0wLYOGPDQQ077H0WgpZAWx73aJeac+m285S99AmliWjyLOqxBW5gKSvjG1p/vhcoIGq5sGhT5OrMN/6kyHerI9pyDWhBfpIuHJO1D8s/ek7fBatne1g+MZnNrfQgeaHINudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931171; c=relaxed/simple;
	bh=nCPQZUaiGU8yooptwQKJbLWLOSOPw8tw5d5i6lCZR5Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GoCYWAErrcj9Sr6VrQqdF6wfPJqbVbczFlOMgIEM642BPv5BuhtIQuwah9LpWxOB6nxxox3x6k43jtK2Br5GZhdP9bqLqi/8tzSGl6MGiqMvxFaeNfJOdR7gKdZCykhQwpmOunuUkQi/qeTRi/C7Mik1uIA7yYojE1sym45xVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Za29AP1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7221CC3277B;
	Tue, 28 May 2024 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716931170;
	bh=nCPQZUaiGU8yooptwQKJbLWLOSOPw8tw5d5i6lCZR5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Za29AP1S9bUjtNk7kMjcS3LvKc7td6j6CIq2V1pdqN0TwCVVptBkNlGnbhnRbab76
	 xEPnIZwJH9eIFUBKwr4I8vZbt3qrkr+8Ot7LBV6TzI9iKGZl+gdq6HJxXqiPdMEn/g
	 YWvI+MSCEVQkT4kxDhoYBMYn1dh6WmvMv2Upsijk=
Date: Tue, 28 May 2024 14:19:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dennis Zhou <dennis@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, tj@kernel.org, hughd@google.com,
 vbabka@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] percpu_counter: add a cmpxchg-based _add_batch
 variant
Message-Id: <20240528141929.ba7e59e4cae89eec01631306@linux-foundation.org>
In-Reply-To: <ZlZFGmBiBE1VGQIt@snowbird>
References: <20240528204257.434817-1-mjguzik@gmail.com>
	<ZlZFGmBiBE1VGQIt@snowbird>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 13:56:58 -0700 Dennis Zhou <dennis@kernel.org> wrote:

> >  EXPORT_SYMBOL(percpu_counter_add_batch);
> >  
> >  /*
> > -- 
> > 2.39.2
> > 
> 
> Andrew you picked up the __this_cpu_try_cmpxchg() patches. At this point
> you might as well pick up this too. The cpumask clean ups are likely
> going to give me trouble later this week when I rebase so I'll probably
> have to base my percpuh hotplug branch on your mm-unstable now.

Well, if it makes more sense to carry these in a different tree, let's
do that.


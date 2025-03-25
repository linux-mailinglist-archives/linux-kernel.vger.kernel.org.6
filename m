Return-Path: <linux-kernel+bounces-575002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DAA6EC71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC92B1896D86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E21D619F;
	Tue, 25 Mar 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imYMh2zA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DE19AD70
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894740; cv=none; b=jDjYZlYsRcAeAsXgOo/qY3Yink+qnbw+otXQnnYVzUGTYC5g3AasmrvXYmkcZoENJ+8nqCkEzty9Czx0mcKdLbE6EX+xPRRdbksXVR5tJ9IxkeFvXZVsCgx6lJ7xD9wfycr6gA/BC2GfuCPWUaV1lI9GbrvotA4mugFeFlYfkkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894740; c=relaxed/simple;
	bh=ORedKVNMvJujf4fY9ELrK1+wNTciQ68DLXxqZ/MVKpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L60MC1QyhmZVqAroFDFK3dfWB7MGPI/BoawdHvpwasgjGDVewDLAbMaMJUeuNUcx4WH+qnwXU9siMNnU6niMLYisEgP//74ibXUwk6CWU0s23buNpRR9JRYBBA2HZbYmuytMZ9xJwwYxO7iJG7fLcyOqJlmHyFG0KZOl6BM4zn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imYMh2zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB95C4CEE8;
	Tue, 25 Mar 2025 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742894739;
	bh=ORedKVNMvJujf4fY9ELrK1+wNTciQ68DLXxqZ/MVKpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imYMh2zASfsHB6hGaKyJtjxmItNWdZLFzFnfInLfZGen4HZP6PoPunebUYpgP8RKL
	 bfihGOVg5Mc/2okk8VFg+dqu3l12l+JTS7RiVyxHzYbry9AyyosC8P8m7DOJXMyQ9s
	 y9/xUnBn0taRJUm1K0lVf+AfvDO0AicOJPsvtcMbaVC7kPH9qtjSqbtswods5ZXni+
	 ZU3HRmgIpizABtmUOI0pM4QlBHYn9Atlo4FS+T/5gIUc/3wNoKpn33LC1lXH/Th9eC
	 s9xHc4zQnitHFGbfiDz0czuZzzYaga/fjiZeKPtCeQXDlkDNwJTrvT4eWrd9SHuPQC
	 UoO9LT+5SnmbA==
Date: Tue, 25 Mar 2025 10:25:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	den-plotnikov@yandex-team.ru, gpiccoli@igalia.com, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, tglx@linutronix.de,
	hpa@zytor.com
Subject: Re: [PATCH] x86/split_lock: simplify reenabling
Message-ID: <Z-J2jnHK6_ltAdfR@gmail.com>
References: <20250325085807.171885-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325085807.171885-1-davydov-max@yandex-team.ru>


* Maksim Davydov <davydov-max@yandex-team.ru> wrote:

> sld_setup() is called before setup_per_cpu_areas(), thus it can't be 
> used for this purpose. Another way is to implement independent 
> initcall for the initialization, that's what has been done.

> + * Per-CPU delayed_work can't be statically initialized properly because
> + * the struct address is unknown. Thus per-CPU delayed_work structures
> + * have to be initialized during kernel initialization and after calling
> + * setup_per_cpu_areas().
> + */
> +static int __init setup_split_lock_delayed_work(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct delayed_work *work = per_cpu_ptr(&sl_reenable, cpu);
> +
> +		INIT_DELAYED_WORK(work, __split_lock_reenable);
> +	}
> +
> +	return 0;
> +}
> +pure_initcall(setup_split_lock_delayed_work);

Oh, I didn't realize sld_setup() couldn't be used for this - thx for 
the followup!

	Ingo


Return-Path: <linux-kernel+bounces-206668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386ED900C82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4193E1C22170
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E21914D70E;
	Fri,  7 Jun 2024 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VIHXZStj"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62F33EE;
	Fri,  7 Jun 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788992; cv=none; b=F36TgTVAbYZZbsd6niBB1LbzmAkO3gl5EtHHzkiuGwFkvJFzZEBtBt480lWwv7BK2hO7/cwTnoevQFthR+Zee1Lgtw0+NhXUPlrCLEvfvUyCjbHBf0d3w23BzMpNXup5mfYy4ZZMltT+3TB43no31rNodCAl7S1hDuWdLfQxp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788992; c=relaxed/simple;
	bh=zG5qDqIut2YPKzOXUzbtTHPzm7s79FX8DqiBGlzF1cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meyNf4kUq4kO0QzAwoJHOU1uqR0613eFNzmkR5E1mpOjexxPgU2bOJLxbMWIE5zI6WrUh8aySELF43UvrjAvQtIA+hRyfAQCRNeVyZsBTM5PR2zdwT4SZhcs4eMZFTGVWW2riN8ih05KtIwxhkey4dJYw+teAWlj8XINYLqOMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VIHXZStj; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zu1ZBxNv57bpE9Use4oXfVWpCn5+Wvtvp0w80A7iIPs=; b=VIHXZStjS7kU9eFQIqDC3lMeVW
	86rBHkG8Egbh2q0zQ0qw8h3oMaIIPuVJLqEUdH1Tg9ZOPq3iCI5zwK6k2mINRgwEwjtk34GVpxatf
	m8zuPTORwUv3B0S21w8p5XwBm+cQtbWGc485UhSaou/E7/RZt3oo+HzeBdW4ohjToTYmAsfG3B1r/
	dKQlxcUqzN7ZGPVm0s7vyiZ5Enl2dcpIAhpRV8+ldBYGoCriapn1lubufMK7/p7v0EX7T5mFtOvT+
	QlmAtB1ylZnv9/faiy1iQoLYK2hx59aUu8IyIeP4zxziyBcE/C7BClDar9TboR27AQ2yE9gZsrqVE
	P5xdpP2g==;
Received: from [191.205.188.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sFfNa-000e7M-9Y; Fri, 07 Jun 2024 21:36:02 +0200
Message-ID: <2093d20d-23e1-1c22-f3ad-8b7413b5a60f@igalia.com>
Date: Fri, 7 Jun 2024 16:35:50 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-trace-kernel@vger.kernel.org
References: <20240606150143.876469296@goodmis.org>
 <20240606150316.751642266@goodmis.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240606150316.751642266@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steve, thanks for the patch! Some suggestions/fixes below, inline.


On 06/06/2024 12:01, Steven Rostedt wrote:
> [...]
> +
> +			The format is size:align:label for example, to request
> +			12 megabytes of 4096 alignment for ramoops:
> +
> +			reserver_mem=12M:4096:oops ramoops.mem_name=oops

s/reserver/reserve


> [...]
> + * reserve_mem_find_by_name - Find reserved memory region with a given name
> + * @name: The name that is attached to a reserved memory region
> + * @start: If found, holds the start address
> + * @size: If found, holds the size of the address.
> + *
> + * Returns: 1 if found or 0 if not found.
> + */
> +int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size)
> +{
> +	struct reserve_mem_table *map;
> +	int i;
> +
> +	for (i = 0; i < reserved_mem_count; i++) {
> +		map = &reserved_mem_table[i];
> +		if (!map->size)
> +			continue;
> +		if (strcmp(name, map->name) == 0) {
> +			*start = map->start;
> +			*size = map->size;
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
An EXPORT_SYMBOL_GPL(reserve_mem_find_by_name) is needed here, or else
ramoops fails to build as module - at least it worked with this
exporting in my build of 6.10.0-rc2 =)

Cheers,


Guilherme


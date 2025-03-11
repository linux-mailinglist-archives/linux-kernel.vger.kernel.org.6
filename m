Return-Path: <linux-kernel+bounces-556984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68CA5D1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C3E3B11B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EDB264A89;
	Tue, 11 Mar 2025 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te4cWT2k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727F14F117
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729369; cv=none; b=UycEtG/o6bB2pifp61NnA0iNsIAkfrk+7R5V3YqWLY/3B4NbIql7nvkhual1uUQkURocwMffFqCDoOlrwNjYwZIqI7UHi6SyybJhVsILfojBviunaNlGqcHRe9uvzWr0rWjCYVW2TegqySzEKaNZkTkBS5PsFhlpPBn3drvaXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729369; c=relaxed/simple;
	bh=xdPaaKYTBfBuQXU7Iw4F1+lRlibcD4hFIGVc8SxD9rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXYKnisFgmgQqNDt7oGFHrD/coSFSedmlaqHqkPCjsYVqgH2t8RKCl/WN0nMjg8ewffa0pVeoSnH+iiLvk0Ke+/Hx3q3vGDoFgCZNLrn5JB6Cm0L9bwJdrg7IZQjU55M8AL0NCTnJ6WHzdoyKjomA9ZNidfZwj0fDOUdFox5ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te4cWT2k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741729367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/U9mOUKdfokgD0lQh/RII5JjLxKNIsIlpLNnxtSbPU=;
	b=Te4cWT2kjwWe5GI0Jhcuf0H8GPD0ygDLbVz8BBwGYLFyrYox2hco8A5xMXKG1C/XixhMq5
	SQtzRuoJbk2bzwMydx3n9rH+AyF6e75Clb3ebdfgh1KJT1Uh+k061EW2LtoQc7HDtvCNM1
	h91A+RiCYzd7JK6hMRH3mWadP9AfCbg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-V6JmDY0pMce2v4gjmJBt-A-1; Tue,
 11 Mar 2025 17:42:43 -0400
X-MC-Unique: V6JmDY0pMce2v4gjmJBt-A-1
X-Mimecast-MFC-AGG-ID: V6JmDY0pMce2v4gjmJBt-A_1741729362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19BAF180AF78;
	Tue, 11 Mar 2025 21:42:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B2DCB1828B37;
	Tue, 11 Mar 2025 21:42:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 22:42:07 +0100 (CET)
Date: Tue, 11 Mar 2025 22:42:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250311214159.GH3493@redhat.com>
References: <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
 <20250311143724.GE3493@redhat.com>
 <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
 <20250311181056.GF3493@redhat.com>
 <20250311190159.GIZ9CIp81bEg1Ny5gn@fat_crate.local>
 <20250311192405.GG3493@redhat.com>
 <CAMzpN2hb7uD6Z410YFPYiGQvsV6-9b8iMXXCtfJYJ7ATwO-L5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2hb7uD6Z410YFPYiGQvsV6-9b8iMXXCtfJYJ7ATwO-L5g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/11, Brian Gerst wrote:
>
> On Tue, Mar 11, 2025 at 3:24 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > OK. I'll update the subject/changelog to explain that this is only
> > needed for the older binutils and send V2.
>
> With it conditional on CONFIG_STACKPROTECTOR, you can also drop PROVIDES().

Sorry Brian, I don't understand this magic even remotely...

Do you mean

	-/* needed for Clang - see arch/x86/entry/entry.S */
	-PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
	+#ifdef CONFIG_STACKPROTECTOR
	+__ref_stack_chk_guard = __stack_chk_guard;
	+#endif

?

Oleg.



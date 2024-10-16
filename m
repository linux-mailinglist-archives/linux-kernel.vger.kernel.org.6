Return-Path: <linux-kernel+bounces-368546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD699A1119
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1302F1C224FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F6210195;
	Wed, 16 Oct 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCGZuu2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503514A09E;
	Wed, 16 Oct 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101754; cv=none; b=ltvNDOsJUkTWu+NErXEHQ5zMJXOnDovIQ8vJ+UbT4DuD9USVRXkWSVNWIhBIKimk3rURpY2Hjw20AzB4gLpAs3POC0Khl9Q/6m7hV3iJKMOpO/sLXUEV+B1+LSJRsKuhLk344hI92T6aq1htoTH4G9fy0X9Ft4wW7jzRuxMHPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101754; c=relaxed/simple;
	bh=TcPyZdTnaIYXAuUmmvyj7ZWwq0e+jb+mIokAQ7+7r5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxV8ZlQC9ACJDUSy5kq2JjT21D5qrQxxON3ahU/wH+a8j1REIFo2LZQJq/4ngQRyI0MzCP0NTXc3iYHIrvwJJkROzS+O/emhxF2FrIsgE1s4n4yJj+eQFQRLE1x4tqlUUtgLDA/+RgkxYvcr3p0YBgM3iTislyhXEIvKpcpWdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCGZuu2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBF1C4CECE;
	Wed, 16 Oct 2024 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729101754;
	bh=TcPyZdTnaIYXAuUmmvyj7ZWwq0e+jb+mIokAQ7+7r5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCGZuu2J5ZYLOtEnuByMoAXHN/mMto+o0Yu0y2Sq15NBhiwGb9YZC3p0nHMNRm6mU
	 OfqgRK5Jx+1BFku0DvEThgaj96BP9dLqM18A7P2zDxQCDbdzoAHcewo0FoWYqUNc7d
	 r1gcK3qDhYzG62Ggv7P2MYC4W/RxzsvxQU67Mp+slxtEDxLB8tEVtbwp9Vlqsta09C
	 NlNnfTRef7v5dth38dKZkcxDFBtA9jhdWYUZC+3Hvu7Tu/dlV09oFqfvmxGOWAuV1s
	 U8g26tX633+ZtgtHHOr+PhVWQyRldFmDk+0DWSCN5ay98ymTDWxpGJPX6vTinYaiAw
	 r7SSeBfiQgNKQ==
Date: Wed, 16 Oct 2024 11:02:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Aleksei Vetrov <vvvvvv@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Message-ID: <20241016180231.GA2939437@thelio-3990X>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
 <ZwRA9SOcOjjLJcpi@google.com>
 <20241008005136.GA241099@thelio-3990X>
 <ZwevGZHiXOBqoslA@google.com>
 <a2e8a76a-9fad-4e3e-bce1-bf8a9d180464@app.fastmail.com>
 <20241015084714.GA1546610@thelio-3990X>
 <Zw6ee6PAz-kZzRAG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6ee6PAz-kZzRAG@google.com>

On Tue, Oct 15, 2024 at 04:55:23PM +0000, Aleksei Vetrov wrote:
> On Tue, Oct 15, 2024 at 01:47:14AM -0700, Nathan Chancellor wrote:
> > We should be able to disable -Wenum-enum-conversion without impacting
> > the ability to catch the cases that you mentioned above. It also helps
> > that GCC supports -Wenum-conversion, but it does not seem like they have
> > an equivalent for -Wenum-enum-conversion.
> 
> Could you please create and send a patch to disable
> -Wenum-enum-conversion?

Sure, I have sent
https://lore.kernel.org/20241016-disable-two-clang-enum-warnings-v1-1-ae886d7a0269@kernel.org/
now, we can continue discussion over there.

Cheers,
Nathan


Return-Path: <linux-kernel+bounces-190214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168188CFB5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26BAB20B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DDA54657;
	Mon, 27 May 2024 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLy/Ohb6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50153389
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798386; cv=none; b=o3Ied7DBv2i0CbZeE6VoIf/yRVxQmeARmgVoazmDv96dkmMT8sWoGWCPhlYO/cYidbjJ81CWEwXbw325ssYOYHU0A6wEiZPIxTVHXDbOzsu7iX5CDqw1TRXIMfayyBzGtiSTUtX4kaZc0C5PrwZN9iUcuFaxx/btzDHUPMM7G1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798386; c=relaxed/simple;
	bh=N2rkjmod0V5TSK3iX6HgNEPfqUf5A0L9NW1ww3l73+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5pHAOkn2A6ZxgoYIAFAi4chNlhbta6mgZIcqWRocwiMFNQEObOzgI2Rl2xv8xvLW6FQoNyUVG/5h1sF1bpkbTvGMsEoTsymtAs6Y0JLrTuCqnRBvrrE27Dw4rcrrvvwgqaL0ZrrYI4YnaVOOvimASXZGChQ92iVAiZ0UKjpvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLy/Ohb6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716798382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WBAQ3/gOi1m5yeV6rqPAsHdgTfEnytLD8rdeXruMhpE=;
	b=hLy/Ohb6b6pqpCYJQkwugTppxDf9C+F7qvZBNCTJk31rsopopCYovd867P/cQ1AGJAjdcU
	VB4Jt74KCKhwujbXQmprnbpRg++5cTc4YOdJvSaeNptZ+TTinkW54GvLQMXnqpzlBmt59D
	ItX5BlZ2Ezz6Eue6IXJ2Yto05IJmOpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-F4qUzjGDP1OyWAPoLHzvfQ-1; Mon, 27 May 2024 04:26:15 -0400
X-MC-Unique: F4qUzjGDP1OyWAPoLHzvfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14AE7800CAC;
	Mon, 27 May 2024 08:26:15 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD88540C6CB2;
	Mon, 27 May 2024 08:26:13 +0000 (UTC)
Date: Mon, 27 May 2024 10:26:11 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ntp: remove accidental integer wrap-around
Message-ID: <ZlRDoyJk2Erzje_z@localhost>
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
 <87ed9re7i4.ffs@tglx>
 <87bk4ve5wc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk4ve5wc.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Fri, May 24, 2024 at 02:44:19PM +0200, Thomas Gleixner wrote:
> On Fri, May 24 2024 at 14:09, Thomas Gleixner wrote:
> > So instead of turning the clock back, we might be better off to actually
> > put the normalization in place at the assignment:
> >
> >     time_maxerror = min(max(0, txc->maxerror), NTP_PHASE_LIMIT);
> >
> > or something like that.

Yes, I think that's a better approach. Failing the system call could
break existing applications, e.g. ntpd can be configured to accept a
large root distance and it doesn't clamp the maxerror value, while
updating the PLL offset in the same adjtimex() call.

> So that commit also removed the sanity check for time_esterror, but
> that's not doing anything in the kernel other than being reset in
> clear_ntp() and being handed back to user space. No idea what this is
> actually used for.

It's a lower-bound estimate of the clock error, which applications can
check if it's acceptable for them. I think it should be clamped too.
It doesn't make much sense for it to be larger than the maximum error.

Another possible improvement of adjtimex() would be to set the UNSYNC
flag immediately in the call if maxerror >= 16s to avoid the delay of
up to 1 second for applications which check only that flag instead of
the maxerror value.

-- 
Miroslav Lichvar



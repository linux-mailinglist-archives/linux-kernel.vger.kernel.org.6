Return-Path: <linux-kernel+bounces-195693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F088D5061
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B66B20E16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1BF3F9FB;
	Thu, 30 May 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JffzGdbL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4642E620
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088488; cv=none; b=EDflmDlTSqvQxdbvbNGFM9SjiT7VR2ZzfyxbFemWp6khceqRA/pQX0PdGNsYVObByOAvbeVQwH6wFUQVsMJamj8fP1Gxam+tGvASLM9DFZ+9+UKsGpRg0WOLnB4P8mOmwOeY3Xs5XyNCHgMrRPSF2jmWN5HzsM/GEIOcXzGx/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088488; c=relaxed/simple;
	bh=4ZRb5QcsUZly9r2lBK0l4VbJCqK2xQtX2LOCg/b9BBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOFR1RBr+sjgKOjrfN1g1w/jkwF1lHkTJwaVCeQLO387MpGnZ6Xsc2kTXqknevMZZiTLyBR7xJKNLi4//L4S3kp1IIDNb5d7y0EpRhPYXzbr6TeNDmG9LnI7EEuhbRcxxJpi5LnEI7g2BJz9O+CgwBu3jFXCpd/wnHeq40GNpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JffzGdbL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717088486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZRb5QcsUZly9r2lBK0l4VbJCqK2xQtX2LOCg/b9BBY=;
	b=JffzGdbLxg9UiIve4qz7xW4grUE1GpAwykXaxQbfa/d4rT1VoZ1+0RSuyQ586Yss9CPBzX
	YrgqP4IUYfQqdmHRUUZ4VCzi45evvO+NXVFqbgXS7zrzmUZ3Ix7gKj2qycLI653V7iR67Z
	8Lvq3xgxJovKyuB92ZmGlvClCHfV2GU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-cAx2fVLPOHGgX7RwXtIWlw-1; Thu,
 30 May 2024 13:01:22 -0400
X-MC-Unique: cAx2fVLPOHGgX7RwXtIWlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C15631C0512A;
	Thu, 30 May 2024 17:01:21 +0000 (UTC)
Received: from fedora (unknown [10.45.224.55])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5F935C15BB9;
	Thu, 30 May 2024 17:01:19 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 May 2024 13:01:21 -0400 (EDT)
Date: Thu, 30 May 2024 13:01:18 -0400
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <Zliw3phiMCdGYwxq@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <ZliSt-RDyxf1bZ_t@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZliSt-RDyxf1bZ_t@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 05/30, Frederic Weisbecker wrote:
>
> Looks good, but can we have a WARN_ONCE(tick_do_timer_cpu != tick_do_timer_boot_cpu)
> right before that, just to make sure our assumptions above are right forever and
> the boot CPU hasn't stopped the tick up to that point?

Sure, I thought about the additional sanity checks too. Although I had something
different in mind.

Frederic, et al, I am on private trip again without my working laptop, can't read
the code. I'll reply on Saturday, OK?

Thanks for review!

Oleg.



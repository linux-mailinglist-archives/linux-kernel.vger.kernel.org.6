Return-Path: <linux-kernel+bounces-271025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DA944898
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479EF2814D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE016F8EB;
	Thu,  1 Aug 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AtZrTeRN"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4B13D53A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505016; cv=none; b=QKjZ3mmB7okx5iVKKjaKTLeAAQG9RJb/oTkcKMeXpoVgii9aFwid2HrpoKzzIlw7mlKByNUO/xnLvhrI0xkBkvHB5QAOb/Vlg/7GsSpAHhF57FSnyIWt0SU0kkT8zCXkYBNxfT7mHYwxd09kqaXmZrBeQQGr/EOVdePlsX3M/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505016; c=relaxed/simple;
	bh=2pFSZePm5imeViEcMGI7WlPjZ1zbEj/0iCfEhR5qquk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SERUPSIxSvm6fYb1IG6Hx+sE3A2PnCN422T8XkkgDsM0WYVD4S03C+nmVwtQAe5ULgMM9gCndPi4VdOyuWtQhvUbQizV1xq0uDorstBWgyidqP4dBI85HhOkE8svYoiESuUwWffFcF5aRdXpvgIl3OrMd/b1x2hnjmE9T50JZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AtZrTeRN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efbb55d24so10173104e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722505012; x=1723109812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s85JscaV+aZDXIp1yykm1ORhzd3iUt3SkG/vQrR0vt0=;
        b=AtZrTeRNH/QC3V63Z1ZOv6b7Qop1QQPmB8N/EDMntjc4VbQwvURiBxdFZYyexWLyUy
         QK+UX9gXr13dVhC9HHijhs2Flqpj8DYGOjrjhzShT0z93lkaormW5U5JXl2Al3stZQEr
         Tj0L6buLm9ImJVDjIGixF+7WztPnbOBE57ifkrb7wSI2Wpgnvj/CsGZ7yUzJdRVGgqor
         fNPh+AW3zrSu0Ac2kIFeENohAk3EF00RSpPzH69gWRLL7GhhL8Za3+84szvYWaOnm83g
         bz7fWbOR5qo0bsseNd5JPnzPi7IQSaMOJpJhNsRY6C2h4vYlgfSp34k5ePNEP2eOAqQX
         NOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505012; x=1723109812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s85JscaV+aZDXIp1yykm1ORhzd3iUt3SkG/vQrR0vt0=;
        b=SWqlhNxgCnkTD5YrgDEUKVyirkDbk/JJXhxZbN9rz7wtGIsHhvageBCLqA1kpOQzxR
         cR+y4BaO0FZUoOgn1FiVXr+T1PjI5TXKbaW455KBE+/8VAwq0aJIJKYqdlwAoTOsxMCW
         zYmCdtWhHScWw3FdGTdJC21zCHJm7sVMJ5Uz4s5rCGrImLkwat35xy8Gr1aE6+DEhxUz
         HMU0ltMc6P+YhypHsGzply2AW03nLloxtRHUKVwvTwrjpKzVH6t8I/fhtRrIEJfdRLg2
         YddH2vgparKrrobEVjkHsjqglTIkaxBBgMoDGIhJRuBDDp9+7hXi4EMqIh4CLk6BD/xk
         kpWg==
X-Forwarded-Encrypted: i=1; AJvYcCUxJQEILbrgMim35LCSZ9JzGfV4RGNKynvxH0m5PFB/RNJqze9fHiTAr0HmfdynNS5R/p9cqAWbLjuSjnHhv1SNNMGlL/dIgaTIsQSV
X-Gm-Message-State: AOJu0Yxf5h+8VeilD1m4X0bIPFwS4RYJ03Ntwua5pWhQ7gI8H+jYOawu
	uC0bgwAa38AUOS5T0/W5Y4Ed7uNHkkme0kqz5xIPTYti2ZDTOplSVv3EsOXHsuw=
X-Google-Smtp-Source: AGHT+IFrpthAL9+o4cMO4mKYhvRY/c7Brmc22WN19QVDffvfdAbkmj/BUMfyB0GTp/9nlO4d3EVHzw==
X-Received: by 2002:a05:6512:2521:b0:530:ae35:be42 with SMTP id 2adb3069b0e04-530b61aaf4dmr1670824e87.7.1722505012166;
        Thu, 01 Aug 2024 02:36:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad92fd8sm863512866b.159.2024.08.01.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:36:51 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:36:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for
 normal operation
Message-ID: <ZqtXMiv0ES5r91ua@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
 <ZqpE9urpKZxv4Ks3@pathway.suse.cz>
 <87plqtlh2p.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plqtlh2p.fsf@jogness.linutronix.de>

On Wed 2024-07-31 17:31:02, John Ogness wrote:
> On 2024-07-31, Petr Mladek <pmladek@suse.com> wrote:
> >> @@ -4102,8 +4139,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >>  			 * that they make forward progress, so only increment
> >>  			 * @diff for usable consoles.
> >>  			 */
> >> -			if (!console_is_usable(c, flags, true))
> >> +			if (!console_is_usable(c, flags, true) &&
> >> +			    !console_is_usable(c, flags, false)) {
> >
> > This looks weird. nbcon console can't make progress when
> > "write_atomic" is not implemented and the kthreads are not
> > running.
> >
> > I should be:
> >
> > 			if (!((console_is_usable(c, flags, true)) ||
> > 			      (console_is_usable(c, flags, false) && printk_kthreads_running))) {
> 
> I would prefer to have the printk_kthreads_running check within
> console_is_usable() for the !use_atomic case.

Makes sense.

> > That said. Do we really want to support nbcon consoles without
> > @write_atomic() callback?
> 
> We must. Graphic consoles will not be able to implement
> write_atomic(). Network and USB consoles probably will not be able to
> implement it either.

I see.

Best Regards,
Petr


Return-Path: <linux-kernel+bounces-351815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74C99167C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA291C21F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4714A60C;
	Sat,  5 Oct 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAe3PSSG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCF132103
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127793; cv=none; b=CcHtcNJ0lwg7eOPvtzcA9XKiyEH7xvL/v1jXM/BjHtQ+z3EcdvfIGIcF6znQ6cp+jFVYAWj/iCZ0MVaG+/eGqKdktGpc78mVfd7FkQTRv9rJ2jZy+TXS/PFm1qk/ZhC/T4yToXJf6S1iYKtN5tdDy6aaBetrFS126DsOue0CyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127793; c=relaxed/simple;
	bh=H3gJOBEhKV3hH0xXZ0LSqXKayhs6Juf9evTT1CuS0TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAujsnNU4DeEbBFdl9DBVsb632acIKKxBb8JF6iAQesifIa4zbtkMoE6j4n3twl+mWR0Vqcy8b1Y6TX1u8MuTV+sIgVGVeWvc3BjdhGLfh/EevxwuqiZA1Gx39qEYsGKNnrmLTURY2eaejbayBESNslF7/Bjvhp4I+AaOT7emTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAe3PSSG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728127790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHETXvLrrh4dL5doL/kbVtAAMHPfV8QYEzlH6ARMCNA=;
	b=eAe3PSSG/MISTxJ5L7sRaw/2LLMh++PSjLK+vwmJ0o6W67tdBynbRMIC46fd6w1GutxzWz
	nXelKgGxuGaIvOuyly6pEgOLFUoOZbTgyxRJwOsUxhNAzU348NGZ4G+gBA+lRVgUkjIPLa
	js5lAsTkIYikUyzGWYrcRRuoBYzC7EI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-wKFeT59nPXOrT7M57q9Czg-1; Sat,
 05 Oct 2024 07:29:49 -0400
X-MC-Unique: wKFeT59nPXOrT7M57q9Czg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27B9A1954AE4;
	Sat,  5 Oct 2024 11:29:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2E82B3000198;
	Sat,  5 Oct 2024 11:29:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  5 Oct 2024 13:29:33 +0200 (CEST)
Date: Sat, 5 Oct 2024 13:29:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
Message-ID: <20241005112929.GA24386@redhat.com>
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <20241004-signal-erfolg-c76d6fdeee1c@brauner>
 <CAMw=ZnRt3Zvmf9Nt0sDHGPUn06HP3NE3at=x+infO=Ms4gYDGA@mail.gmail.com>
 <20241004192958.GA28441@redhat.com>
 <CAMw=ZnRp5N6tU=4T5VTbk-jx58fFUM=1YdkWc2MsmrDqkO2BZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnRp5N6tU=4T5VTbk-jx58fFUM=1YdkWc2MsmrDqkO2BZA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/04, Luca Boccassi wrote:
>
> On Fri, 4 Oct 2024 at 20:30, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I guess Christian meant you should simply use
> >
> >                 info.pid = task_pid_vnr(task);
> >
> > task_pid_vnr(task) returns the task's pid in the caller's namespace.
>
> Ah I see, I didn't realize there was a difference, sent v3 with the
> suggested change just now, thanks.

I didn't get v3, I guess I wasn't cc'ed again.

So, just in case, let me add that task_pid_vnr(task) can return 0 if
this task exits after get_pid_task().

Perhaps this is fine, I do not know. But perhaps you should actually
use pid_vnr(pid).

Oleg.



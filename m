Return-Path: <linux-kernel+bounces-336068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C227697EEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F320A1C20370
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B933419CC3D;
	Mon, 23 Sep 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBKdHHeX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470947F4A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107232; cv=none; b=sOXKEvz4+mPDzwkQqC/8b0edKLZKqOa9tiEuUWtmzwW2q/tBv0klBnko+4TJt0aZ2Kh81Jh1l3U7ftZWCSyln2m2Wx15QBnGVAJWaJ8xCzm9OQgSM1W5zJaDeKkIdmWJWM1bOGB3/Gcm5uxbxZp+w6M+x2LYvSfYiL8OiA9rbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107232; c=relaxed/simple;
	bh=HnnZXl6t2SP9KFfGoCRAgd1V5dELYV1Xc0nr7ISnYko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA6151YeaVL9KPmJUVttUSAcyHcGmW1sOP7hC2f84yEYgQlEHF30IChOtNC0ZFg8EyROJiCcY70ZVafGPBzj/0Ub40j7gUaGFVBqyUlDlkK7gVCTG2SfOpWBbRj/CTLTLlcMawu2G38j1AoWvKx9c4qhMhM8ImA/v0JmemZIqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBKdHHeX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727107229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxg5RZKuwS9yIPxC79el7eGj1kEOjwEq2LIarjz7NnI=;
	b=KBKdHHeXCIYswiu92G2T6aWtsVdxtxtk5vHTsU37OyT20+HYoG7eaIBUvvCHJsu1bWbYiE
	TqzBanLLJ+6HMEEzYBLoUKMgiEqnL50eD8GzQXxIbfivizhb7+qky9vAYbn0HEOvrI2q8H
	inFmrYCZ3CU0R0+l3oPp7MM3RODRKXw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-RiOgxZ2KOO-S_GrVQacELg-1; Mon,
 23 Sep 2024 12:00:28 -0400
X-MC-Unique: RiOgxZ2KOO-S_GrVQacELg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC9E195FE2E;
	Mon, 23 Sep 2024 16:00:26 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.32.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 292311922ACC;
	Mon, 23 Sep 2024 16:00:10 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:00:07 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: andrea.righi@linux.dev, David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <20240923160007.GA313849@pauld.westford.csb>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
 <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Sep 23, 2024 at 05:32:15AM -1000 Tejun Heo wrote:
> Hello,
> 
> On Mon, Sep 23, 2024 at 12:45:48PM +0200, Phil Auld wrote:
> ...
> > It's not a per scheduler counter, though. It's global. We want to know
> 
> Yeah, the sequence is global but we can report the sequence at which a given
> scheduler is loaded on each scheduler. That way, e.g., you can tell whether
> a particular scheduler instance is the same one you looked at the last time
> too.
> 
> > that a (any) scx scheduler has been loaded at some time in the past. It's
> > really only interesting when 0 or > 0. The actual non-zero number and which
> > scheduler(s) don't matter that much.
> 
> Not necessarily. e.g. You can also detect scheduler failing or being updated
> for other reasons.

Sure, but the primary purpose is practically boolean. 

> 
> > And it needs to persist when the scheduler is unloaded (I didn't look but
> > I uspect the per scheduler attrs come and go?).
> 
> Yes, the load sequence number should stay persistent across all schedulers,
> but each scheduler should report the sequence number at which *it* was
> loaded. Note that this doesn't really change anything now. If you only care
> whether any SCX scheduler has ever been loaded, you'd always look under
> root.
>

In my testing root is not there is nothing is loaded. 

Cheers,
Phil


> Thanks.
> 
> -- 
> tejun
> 

-- 



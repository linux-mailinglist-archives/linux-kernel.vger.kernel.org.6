Return-Path: <linux-kernel+bounces-231472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85E91991C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CFE1F22948
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE413192B9A;
	Wed, 26 Jun 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvTuY3qT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FE192B69
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433756; cv=none; b=H8Xmsn4Neyykv+NgaeRS2IypChkJ0FKJzjm8alaMAxRBFMs2CGtenOZ2Qoz2kTnrh2x/HVYCXT9xp3hxhR9RXBXHVy2xdCx4htx0p0OZyrVJhGpNoYAc8ZPvPlDaEi1PqEV8u5oLbdOe4xHVshymnlDObQA79AcPhb2+YRzwC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433756; c=relaxed/simple;
	bh=taEkLkE2ggwiv3qxaEcFYeaXl5UzazSzd+1ljLfAKbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6prYJ/ysHS54NiiYzKe4VYCothiCRGiDiOsdfWiPsFIrsEyj3JtzfZn5zdnmiVQbvmBgDBelPXttJvEn16ShvRezJTffHeBVe0dngGR5mN+sOBkDBafj7+mDVSRlbPML7gCOoI9VSY8GhqUCwZOxrFskIp44VtoIdxFp4/8k/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvTuY3qT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719433753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=taEkLkE2ggwiv3qxaEcFYeaXl5UzazSzd+1ljLfAKbA=;
	b=DvTuY3qT3delskblorcmrRW0ZWp/me1bSMRFd6lFXkcg65Y7JRtCcKJU0ocga4a5K8MgK1
	jAGQbV/73BP1NXEj9rmOeYD3JablrUr/kBjYlQ0d9qL/Ha6ko7Eu27PFkwMEfkS0Sj9Ypi
	PRNEj7bSG9hQ8HzwzwwCb36yKMkVH5k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-gwfAjrLZNgyzVarpp2lFQQ-1; Wed,
 26 Jun 2024 16:29:09 -0400
X-MC-Unique: gwfAjrLZNgyzVarpp2lFQQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1599519560B2;
	Wed, 26 Jun 2024 20:29:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.94])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 70EB819560AB;
	Wed, 26 Jun 2024 20:29:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Jun 2024 22:27:33 +0200 (CEST)
Date: Wed, 26 Jun 2024 22:27:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 0/2] memcg: deuglify mm_update_next_owner()
Message-ID: <20240626202727.GA17320@redhat.com>
References: <20240626152835.GA17910@redhat.com>
 <20240626122456.a9eb021e4ccbfbb1b6b93d1c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626122456.a9eb021e4ccbfbb1b6b93d1c@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/26, Andrew Morton wrote:
>
> On Wed, 26 Jun 2024 17:28:35 +0200 Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On top of mm-optimize-the-redundant-loop-of-mm_update_owner_next.patch
>
> What should we do with
> mm-optimize-the-redundant-loop-of-mm_update_owner_next.patch?

Well, if you ask me (although you shoudn't ;) I think this patch makes
sense even if it can't fix all the problems.

> Further improvements (this series) can be made in the
> normal fashion?

Yes, yes. And just in case, this series mostly tries to cleanup this code
and it doesn't really depend on that patch from Jinliang.

Oleg.



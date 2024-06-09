Return-Path: <linux-kernel+bounces-207480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C309017DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 20:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BE3281950
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8CD47A60;
	Sun,  9 Jun 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbztCnC5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD264CE04
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957795; cv=none; b=A2pg8v7c83r6GbeqC8euZAdoo9SewRKGUPn3JAhYEFOgNdJL3HxtBbe56qGWTK07xpjwcl8WYbyKtKTXd9rgZnyw/G/8puqhC6zIZRsz7+iMATm2vBmNlDJxCVVSRY81PVzPEwBd7eeF623OrZ8h+wDwY/pgSbVxi1IFp6Q0Vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957795; c=relaxed/simple;
	bh=uEJNvYVVaNntIggMGXVBxh9+1kgmUPxGMleX6TQXWhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM68FdPAFCgzkIQec5a7zRMWA0W/uDdHpTGzE0Q78yjYojf0Mi1UZZgRtcG0mvhr9to/nXKj92udlJ9PSmZKFXlfSeNjtXEKbKjxcJoI0oIE/xPTkE8bpJ1s1BNnm8rduRw1Kw0YtQ886OXo2RIqUkHIod2/QpzRDDsI3DBuszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbztCnC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717957792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uEJNvYVVaNntIggMGXVBxh9+1kgmUPxGMleX6TQXWhc=;
	b=bbztCnC5N8CuPDJkLiq01hjGGbmGVTDmXwD0MGARn46gxJVZKQaT/D6HfrZjGM//SEdXja
	jUbXuf5sXao6CJ9a3mCiqvyu7UjF/5vEm4dpXkq7uGF5qs9cJAYA9bWjhZhBRbrKS+hRj5
	+KluphkQCxsL7sxnokHYzeSkXffYn9k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-b_u1TsIzNjSD3cBtNI32uQ-1; Sun, 09 Jun 2024 14:29:51 -0400
X-MC-Unique: b_u1TsIzNjSD3cBtNI32uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3502811E79;
	Sun,  9 Jun 2024 18:29:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.58])
	by smtp.corp.redhat.com (Postfix) with SMTP id 75E9C1121337;
	Sun,  9 Jun 2024 18:29:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Jun 2024 20:28:21 +0200 (CEST)
Date: Sun, 9 Jun 2024 20:28:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] exit: kill signal_struct->quick_threads
Message-ID: <20240609182819.GA15903@redhat.com>
References: <20240609142342.GA11165@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609142342.GA11165@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 06/09, Oleg Nesterov wrote:
>
> Tejun, could you check the note about css_task_iter_advance() in
> the changelog?

Yes,

> And can't it use thread_group_empty() instead?

Please forget. I'll write another email.

Oleg.



Return-Path: <linux-kernel+bounces-575420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1AA70233
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739E6178958
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0919F471;
	Tue, 25 Mar 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkqP2rO4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F902E337A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909305; cv=none; b=Jxkp3nWoALoAtwQlJinWmC5zfXz6wes5YYQVIbZrBNp9HlN2I362oBWwlyansgFsHFWm4d/Jedo/Kf7u7cmSxuusaaUWu7KNm2SqHkJ0277CnVk5Xgcp7iRLX85dvp6mr7svgYzXH1TOLLTnf+MXS3vQP+ppk4OyTQDvkCUuX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909305; c=relaxed/simple;
	bh=NX6xGz0ZPXempBmJNyBVwlMRbqbHwrZ0+d8Sb+xtseE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuOV7v3P9wN7tQ6ubgmMfil4CeNdtedJm0xrX2fK+YejvQZkZ+fZaLMMuRYJ2LeVoxDcOmMdqarRy4E27CD/dvQFzcVi0gu6ZWPSeViyg/sMr3ScrreUbB/BD2jVx4leZUzikjJA5cCoP7mM0fXgXU1/NcWXWCn1cGV0xzHKYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkqP2rO4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742909303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NX6xGz0ZPXempBmJNyBVwlMRbqbHwrZ0+d8Sb+xtseE=;
	b=XkqP2rO44+IhiSxoQL+kDlamUZDpGg2Zw2S8Icdh5dtZYfGTmP/V9xJ1GysDgfqF1EY2J4
	oCbF3bbBI3DXzaFIOHI/4YkYuguy+jFi1qsR39TOXRV6bJ+8CGh/aPrd9wEsvsrre2t0BH
	cSCTVhdGJPCDZ4aChuFgSZrVYAUATBk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-eOK4d6VyPUK_idYhul5Iqg-1; Tue,
 25 Mar 2025 09:28:16 -0400
X-MC-Unique: eOK4d6VyPUK_idYhul5Iqg-1
X-Mimecast-MFC-AGG-ID: eOK4d6VyPUK_idYhul5Iqg_1742909295
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DC97180AB16;
	Tue, 25 Mar 2025 13:28:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AC53E1954B04;
	Tue, 25 Mar 2025 13:28:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Mar 2025 14:27:41 +0100 (CET)
Date: Tue, 25 Mar 2025 14:27:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jann Horn <jannh@google.com>
Cc: x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Ingo Molnar <mingo@kernel.org>,
	Vernon Lovejoy <vlovejoy@redhat.com>
Subject: Re: [PATCH 2/2] x86/dumpstack: Fix broken unwinding from exception
 stacks
Message-ID: <20250325132735.GC7904@redhat.com>
References: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com>
 <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 03/25, Jann Horn wrote:
>
> Commit 2e4be0d011f2 ("x86/show_trace_log_lvl: Ensure stack pointer is
> aligned, again") was intended to ensure alignment of the stack pointer; but
> it also moved the initialization of the "stack" variable down into the loop
> header. This was likely intended as a no-op cleanup, since the commit
> message does not mention it;

Yes... initial version didn't do this, this was requested during review
and I didn't realize this adds another problem.

Thanks Jann!

Oleg.



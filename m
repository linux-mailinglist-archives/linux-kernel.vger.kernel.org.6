Return-Path: <linux-kernel+bounces-321823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743B2971FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06CF1C2347E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE94170A16;
	Mon,  9 Sep 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8En3dO+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05A16EBEC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901558; cv=none; b=pJyxZ2XzYiNXuMpjUt+wrDT6UjBxj5hf/TeoBXjzkOL0lHZJtFZNx7csmDvtZNdD8IDVPm8QjZgFwBtVT0yXTO06RyOHK/s5rO/GLpHLAB20UO3Y3GZzmo+zqJEBiVfM/kazYpKDkwvSZVNuXGlk2Mg7yjj0RB5fa9C3lowhbdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901558; c=relaxed/simple;
	bh=6kQ3JvaFS9hvCUg6LnR8HGaf5xa+WyNzPdLMPLg91uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRsJK1BII29aVyV/t+3hHF7VuNRBOR6G1IjHgEbTgcUZaAoq0J6Opq+sKX9OUM4pauUtZfS/6jZ5PwP3uQBrpraqz/EiiN45bznD+3aUjX7kJ0MVcY6MFO4VBFGLXhRcJtYETf19iVMCUKEGlNic8wBGWgYdpsyqnHHWaqwfC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8En3dO+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725901555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kQ3JvaFS9hvCUg6LnR8HGaf5xa+WyNzPdLMPLg91uM=;
	b=c8En3dO+Fg3jC3rIqCMu+bK5QDCRebafZ4w/EPPRTjkIdyPxgcwLv8hBmM3AQNy3gGEeEW
	24ueQddnZ+ZBti/x7vs+M6Hr1oNsNEhnly07pWpoXVAX2F/SSMuq7ZE1PQrqIVtkT/Sz6w
	WA4rWye9RnYVW7EoYOErwFuSZVR1Doc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-e1_T39_QPUKhGkS3PRiZfw-1; Mon,
 09 Sep 2024 13:05:49 -0400
X-MC-Unique: e1_T39_QPUKhGkS3PRiZfw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1491955F45;
	Mon,  9 Sep 2024 17:05:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D780C1956048;
	Mon,  9 Sep 2024 17:05:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  9 Sep 2024 19:05:36 +0200 (CEST)
Date: Mon, 9 Sep 2024 19:05:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240909170529.GB14058@redhat.com>
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
 <20240906112345.GA17874@redhat.com>
 <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
 <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
 <CAHk-=wiSN1NWzG2W1KCQKoG7mM+RmP+dZ0nWNfEagTwPPiDxXQ@mail.gmail.com>
 <61713c72-bd86-4694-9c06-49579a33d8f3@linux.microsoft.com>
 <87ed5ser6i.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed5ser6i.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/09, Eric W. Biederman wrote:
>
> I suspect the best way to support breakpoint_if_debugging (in the
> general case) is to make them nop functions,

or may be make it call a single function which can be used as a
breakpoint placeholder.

Either way, at least the program with breakpoint_if_debugging() will
survive under /usr/bin/strace.

Oleg.



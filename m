Return-Path: <linux-kernel+bounces-320252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657D9707FF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE22B212C6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A416170849;
	Sun,  8 Sep 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQYAMH3/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2F613D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804543; cv=none; b=ZglQONUzbeofTMVUsM+W9uVkp4C3vtZqU5vjFGhXqV27/0g7UBiTojQazgPmuwXEfBqp7WoSCP3BaXZ5sEM1GN+k/npg8IXE1UzL5v2R2BlL8w7gGRf8S8HXFR4+PgOp1hqh45ZSIWq0s4Iz+tpqVyhu35Rlel2utUsdZOqVXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804543; c=relaxed/simple;
	bh=hBk/SL4tpO6HfJcIpRx6T8wytp3+JBcSbb+R4nhrIPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTJPr225mx8gctHS+sBUqb1KbQs0FlwOXzTNTHFBpXJdiac9/3wQ6EgaqCOPyzEUaL/y27BOv1BpfI3fKga4y3wER2vroYJY/MsYpWY04it5TkoyK9TK66b7PQKGOqVxy6nJmxE6Ha43WkLrwBVjXrl4tlEEuvjKVY0uElEQdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQYAMH3/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725804540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1yWgQvR8tKlP3+9+N1qTzJaYgfANig+10GR3V5FEns=;
	b=PQYAMH3/neuDTWOxAanImfu4rY1u7KT/iRpv+AHt2Mhm0ehZnpI+nzN7NAVt83a3vppnW5
	yZN48Q+VP4x71+0cKW+vxURoQj5u3f93kYEsGUWfxmPGTdYvzZJPDljM4pO0Yx4glHjZ3N
	sFGcfQ+hVBC//nU+IOe/Y1whgv+O4ws=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-qUxeiRUnOGW5_eakoL_q4g-1; Sun,
 08 Sep 2024 10:08:56 -0400
X-MC-Unique: qUxeiRUnOGW5_eakoL_q4g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A745195608B;
	Sun,  8 Sep 2024 14:08:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7015A19560AA;
	Sun,  8 Sep 2024 14:08:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  8 Sep 2024 16:08:43 +0200 (CEST)
Date: Sun, 8 Sep 2024 16:08:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240908140838.GB21236@redhat.com>
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
 <20240906112345.GA17874@redhat.com>
 <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
 <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
 <20240906205436.GA2417@redhat.com>
 <7cabfc9f-398a-41c2-898b-296e53a048de@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cabfc9f-398a-41c2-898b-296e53a048de@linux.microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/06, Roman Kisel wrote:
>
> On 9/6/2024 1:55 PM, Oleg Nesterov wrote:
> >
> >Not that I think this is a good idea, but std::breakpoint_if_debugging()
> >looks even more strange to me...
> Can't speak for everyone obviously, I've found that convenient
> when making sense of large (unknown) codebases instead of setting
> up breakpoints and adding prints/logs, and when the process
> can't/doesn't fault when it encounters a fatal error.

Sorry, I don't understand.

I fail to understand how/why people can use std::breakpoint_if_debugging().
To me it doesn't look useful at all.

But you can safely ignore me, I do not pretend I understand the userspace's
needs.

And I guess people will use it anyway, so I won't argue with, say, a trivial
patch which just adds

	case PR_GET_PTRACED:
		error = !!current->ptrace;
		break;

into sys_prctl(), even if I agree that this probably just makes bad behavior
easier.

But you need to convince Linus.

Oleg.



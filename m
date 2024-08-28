Return-Path: <linux-kernel+bounces-305582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28949630D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894022868CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF6B1A7AF6;
	Wed, 28 Aug 2024 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gX79BgzM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA471ABEB8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872506; cv=none; b=CPxZnKKirBeuouMwlFBCveoXsQ5WkML0jeEMGUY3JOag/Z7ycVzQuiRj7zZadmgedsMEO2wDmU2k+F5oUfdtLGvEeV/yEeEOcCOpJjnQHg5SnTSx7w1pgY0uX40+UAsRB3bsjvQ1x9pFVkQRzJZjPJHBjfvkJkXZUF4mIOC6pUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872506; c=relaxed/simple;
	bh=LbQZQ/vVDRJDmBbeVufxWeOTUlxLOSsNWpUr0EkBfCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow7YSblPE7AkXubbkTXVdNca+WDwE9Ufitk7P5bcLWTXbE83KfxB96fQAQeS2tFg50isnMU73eyonygeeuJULgUM8Gd0u/+W3I3hNOedu+/D6fsEWXnQksD6OgYRY5uTtnGjFsjJaBmC5mDSGcg1Jw92PZoPMzQSqi+izseY4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gX79BgzM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724872504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1UnXvwzw9mLNwzHOV1gSoNN+qWpQMXD0QiKEQ3cstw=;
	b=gX79BgzMk/cq0INVfDasChWlSm1Zkvjp9jRSdUOc5thR2UUB5DIL/AvAcMVe3at9eAw2P0
	l/6ruBdM+RQOSRI42wB3vOp1rnzO8NnCmXvnwvhMAywq0GMOlT/BrHAuXU7PtALiXzPWg7
	zsXq8GsuuiveLYs1GttkOAyU1ZGgi7k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-XThQpjJ8PEibi0dnCnwzZg-1; Wed,
 28 Aug 2024 15:14:59 -0400
X-MC-Unique: XThQpjJ8PEibi0dnCnwzZg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59D6A1955D58;
	Wed, 28 Aug 2024 19:14:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 449AE1955BF1;
	Wed, 28 Aug 2024 19:14:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 28 Aug 2024 21:14:49 +0200 (CEST)
Date: Wed, 28 Aug 2024 21:14:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v3] bpf: Remove custom build rule
Message-ID: <20240828191444.GA3806@redhat.com>
References: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
 <20240828181028.4166334-1-legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828181028.4166334-1-legion@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I know nothing about Kbuild, I can only confirm that this patch fixes the
problem I encountered in practice.

On 08/28, Alexey Gladkov wrote:
>
> $ touch kernel/bpf/core.c
> $ make C=2 CHECK=true kernel/bpf/core.o
>
> Outputs:
>
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      kernel/bpf/core.o
>
> As can be seen the compilation is done, but CHECK is not executed.

And after that

	$ make C=2 CHECK=true kernel/bpf/core.o
	  CHECK   scripts/mod/empty.c
	  CALL    scripts/checksyscalls.sh
	  DESCEND objtool
	  INSTALL libsubcmd_headers

CHECK is also not executed.

compare with, for example,

	$ touch kernel/trace/trace.c
	$ make C=2 CHECK=true kernel/trace/trace.o
	  CHECK   scripts/mod/empty.c
	  CALL    scripts/checksyscalls.sh
	  DESCEND objtool
	  INSTALL libsubcmd_headers
	  CC      kernel/trace/trace.o
	  CHECK   kernel/trace/trace.c
	$ make C=2 CHECK=true kernel/trace/trace.o
	  CHECK   scripts/mod/empty.c
	  CALL    scripts/checksyscalls.sh
	  DESCEND objtool
	  INSTALL libsubcmd_headers
	  CHECK   kernel/trace/trace.c

Tested-by: Oleg Nesterov <oleg@redhat.com>



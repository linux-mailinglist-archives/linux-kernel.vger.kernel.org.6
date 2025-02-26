Return-Path: <linux-kernel+bounces-533658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6345FA45D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FAB7A4611
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A7215769;
	Wed, 26 Feb 2025 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjxhp7RE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319021517F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569969; cv=none; b=AuGc/p4wzTaVR9r8NlV145yk7AqU6WM6Pp46SiUZEZnqR67SQPy/okElY+RuNpzIbBak20kZhwzGspuk2uNW+fTMsmGJQDUMMtCRQo+tVPz9cRqxd7d8WM2mayRqMCTyeZmZkq9RhBPpd8v/E8EdqD5RJeRVl9Dwi3NYCllQt7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569969; c=relaxed/simple;
	bh=91HyT0xAPvt5kzPtlkf3c0T76XPdPOpKrD6w5BJb1OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMWEs3zeUDZiqexdnAuhPBX2OafL6mxSc80Sf717BAPTxC5G5byjqSYxDRuadzKSucY9Wa2Lf+YbMSbM0MSHDNOGoumb8J4nPcVGte0UOoyqg7EHM8IBxXmkq+d9+iESpX2hI41G2YQq2oUOJNOYvI9dZOU6coMpVFOz05ododI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjxhp7RE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740569966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrReGGAl/vB7YRDV5AmH0LImtmenH6zPTsYUBs/1CmQ=;
	b=gjxhp7REDIJVCvPFvdNwJmtbrSGbxwuJp01HrKDbFH1qRCJGSvT1JFjd7FQ3y1ENIaZlJb
	aEu6LGjfKgvxybkMLYbGzuNlTIQKwPw8T2M6bswuXgKaw/N2uOgxRjkG0Kcm4CgisxFcgV
	V+e1YzPAEul16sU0TNg2vZ1YMlF0s70=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-zm6XF-TgPMuFUWQr_L91gQ-1; Wed,
 26 Feb 2025 06:39:23 -0500
X-MC-Unique: zm6XF-TgPMuFUWQr_L91gQ-1
X-Mimecast-MFC-AGG-ID: zm6XF-TgPMuFUWQr_L91gQ_1740569961
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28D3F1801A18;
	Wed, 26 Feb 2025 11:39:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0A1F2300018D;
	Wed, 26 Feb 2025 11:39:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 12:38:51 +0100 (CET)
Date: Wed, 26 Feb 2025 12:38:45 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250226113845.GB8995@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <20250225115736.GA18523@redhat.com>
 <2a0a8e1e-1c37-4655-8a82-54681b2a83ae@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0a8e1e-1c37-4655-8a82-54681b2a83ae@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Thanks Sapkal!

I'll try to think. Meanwhile,

On 02/26, Sapkal, Swapnil wrote:
>
> Exact command with parameters is
>
> 	/usr/bin/hackbench -g 16 -f 20 --threads --pipe -l 100000 -s 100

Can you reproduce with "--process" rather than "--threads" ?

Oleg.



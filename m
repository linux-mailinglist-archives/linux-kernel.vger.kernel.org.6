Return-Path: <linux-kernel+bounces-531291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12CDA43EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498383AB36E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFBC267F63;
	Tue, 25 Feb 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deO5mD1n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A85267B14
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484704; cv=none; b=j24TIkrZFlSksDM81ZcDV7Xy8TaNG13oh1cbCJsTrk6LesxvOC0FERxrAm09iSMvFUTq8Cmad+XjcX2EPH8pPgI7/vk8JJJumSzIgx9rlalrJMBBR8HHs7RR/UAUDC7utIeIkpzi/hy0pXHOHOxBInpnv9HR6Y3XCYO5dzVSirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484704; c=relaxed/simple;
	bh=ZML+M6SNb254B3okUsOvmT/4Q3X+djWXrWToFKbLH/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sznb2lBwQiqNlXfwsyXI0I4mvbSl1Y4ub098Wq6vLXzs9oTNlzPiGgTOtQ9d/JQjrlxc28bb8cnW6jqY+ORE+CUGNSKuoMii4jFvvvv3gs0BgXIHePPz7NOZcKbLwAsVOBZjvU/oFRFRYoTnF9wE75J1kJN0cgdKFSAsx4yBOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deO5mD1n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740484700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCyJOCDY4s4V1OSV5l5wvh4COV+tZP6Tfm0smlf+8X4=;
	b=deO5mD1ne3YXzOTAXRJTevVLpdydrfbuBRYXHg5fIAN2vW3q92xDahbTu4tPcrqEVmXObJ
	dc+4LqR2tW5gzhPyvnOZt0FyTcEWGaV2MrLdSVPEiUyj1arCbL3B2wYGPNcEx3DJrUpdQG
	YIusBAhuJZjrQT16esoSvgEQ3EU2s50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-LiOX7p_OP_qs-CkJIUfpJQ-1; Tue,
 25 Feb 2025 06:58:15 -0500
X-MC-Unique: LiOX7p_OP_qs-CkJIUfpJQ-1
X-Mimecast-MFC-AGG-ID: LiOX7p_OP_qs-CkJIUfpJQ_1740484693
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49A9A1800879;
	Tue, 25 Feb 2025 11:58:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.211])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EE376180035E;
	Tue, 25 Feb 2025 11:58:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Feb 2025 12:57:43 +0100 (CET)
Date: Tue, 25 Feb 2025 12:57:37 +0100
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
Message-ID: <20250225115736.GA18523@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224142329.GA19016@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/24, Oleg Nesterov wrote:
>
> Just in case, did you use
>
> 	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c
>
> ?

Or did you use another version?

Exactly what parameters did you use?

If possible, please reproduce the hang again. How many threads/processes
sleeping in pipe_read() or pipe_write() do you see? (you can look at
/proc/$pid/stack).

Please pick one sleeping writer, and do

	$ strace -p pidof_that_write

this should wake this writer up. If a missed wakeup is the only problem,
hackbench should continue.

The more info you can provide the better ;)

Oleg.



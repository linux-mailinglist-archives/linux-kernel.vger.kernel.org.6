Return-Path: <linux-kernel+bounces-249436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9492EBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C371F281340
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D67916C438;
	Thu, 11 Jul 2024 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZAvT1MB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877ABAD39
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711667; cv=none; b=cozRnTIG54uzI9zB3hHCEFI8SbkvQ30L10LIPJSnRxR4G1W7wwdpbE2kdL7QFXPs+uJV8CCdMxJfOkcI6CJ54n4gkBI7vUyVDbuLQembhuHhqSfUrnHgnL9R9aiUsqTGPZ9k2bXxRXsAEK8ipmL3dXtthPuzOQ09B1UuWQBLWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711667; c=relaxed/simple;
	bh=FkthSM/wruzJ4iJDQ99aWsAReIDM9v+tn+P+o+cTYsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9KAPBPLkSumvEe0zFuVAEJRzxdhvG+Q+9TJkwaT4IJcTT2LgoA/zVt3z9FBHIp0QWMz2GkMLAvv1rZMcX01eBhYk6KNI7cX0RyJX3Mi4oR6zkzqD389X3YN+Gis81FZlrAp4URFMoAYWcHrahr33SJCCvqyl3NqMjJhQspUz7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZAvT1MB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720711665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2He1EUw1EuI9K4QaGiPAc9usxK88BGStjULexw0a+A0=;
	b=QZAvT1MBuqp5jhpzheXgbGxUGD5YCJ35kb4Di3Hxa9wmlbKC6K3HTnIuDE4+RmeuxdPbv7
	oygu+H4JCHtuLbckgYcDJ4M8HKoWOokAFdwWYLNEZL7N5VIIniejdhEdDcHOxqaIf5oPjF
	GrmXEYDGUj88S3+g37rVdV0deb/vtLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-F1J2ksA3N4ORQeU2u10iYg-1; Thu,
 11 Jul 2024 11:27:39 -0400
X-MC-Unique: F1J2ksA3N4ORQeU2u10iYg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F273196CE3E;
	Thu, 11 Jul 2024 15:27:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 034901955F40;
	Thu, 11 Jul 2024 15:27:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 17:26:00 +0200 (CEST)
Date: Thu, 11 Jul 2024 17:25:56 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: andrii@kernel.org, peterz@infradead.org, clm@meta.com, jolsa@kernel.org,
	mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uprobes: document the usage of mm->mmap_lock
Message-ID: <20240711152555.GD16902@redhat.com>
References: <20240710140017.GA1074@redhat.com>
 <20240710140045.GA1084@redhat.com>
 <20240710235159.23b8bc0f5247c358ccea699d@kernel.org>
 <20240710151006.GB9228@redhat.com>
 <20240711090704.556216a0bca595ad44ee9dbf@kernel.org>
 <20240711094940.GB16902@redhat.com>
 <20240711231954.b84844bd4b329791ba4c643e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711231954.b84844bd4b329791ba4c643e@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/11, Masami Hiramatsu wrote:
>
> What about this?
>
> 	 * We take mmap_lock for writing to avoid the race with
> 	 * find_active_uprobe(), which takes mmap_lock for reading.
> 	 * Thus this install_breakpoint() must not make
> 	 * is_trap_at_addr() true right after find_uprobe()
> 	 * returns NULL in find_active_uprobe().

Thanks! will change.

Oleg.



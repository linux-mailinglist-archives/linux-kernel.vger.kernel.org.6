Return-Path: <linux-kernel+bounces-568605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB9A6983A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE93172027
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CD2116FE;
	Wed, 19 Mar 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcqIk3n/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4F20FA8B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409723; cv=none; b=GOoNWZvMv4+revYpwREsTScSPwhplwYCGPMCmRU+PgQLMV7MYT+NRPKm31kA4Y+G24UojJ88l42jbgDjsyPrAkwNIT2e4tVRDTTsh27CQPtGPFywLsyX/9AMyDEvvxEvlepimbC1ic2Zcr+lFPhZmHFBOsSqW3vMIDIB1RJxvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409723; c=relaxed/simple;
	bh=NODBjEX3S3n69qaMczuRkc73LOnwmpGTEJXuzLOSR+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWu1iEiL+sBjYC/ooWzUsWilWvkIJg3FIuEHGTdd5qRT+XV4RxP7WCnpPe0XhSLBY366O1pmVNJ0nDG7azjWIPV+qSmoUDg4OszGTsp9M/sYvSQ1UpEqcqu3DUcoIWRbtOGbHcFAbV7rafXzGJWAs+1IpZuXqpGxXzugHATWryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcqIk3n/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742409720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NODBjEX3S3n69qaMczuRkc73LOnwmpGTEJXuzLOSR+0=;
	b=BcqIk3n/P8GFlZNUq4e+riUsfEtnKfixY1Jd87J3M/w2g+Bgc0apVGJcJe95zUXvdzdM8c
	Jy3j6bXET6IjF/nsnBRLIMrcBuurL70m1mApqE15ayra6gfNAy8cB3NS414QQfsnDugmjV
	vxjEkg0WQSV/RZZIG/UHylohhavzRkk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-Y-pqWdqTNG-i9GDfqkM77Q-1; Wed,
 19 Mar 2025 14:41:57 -0400
X-MC-Unique: Y-pqWdqTNG-i9GDfqkM77Q-1
X-Mimecast-MFC-AGG-ID: Y-pqWdqTNG-i9GDfqkM77Q_1742409716
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0DB119560B9;
	Wed, 19 Mar 2025 18:41:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3C4643001D15;
	Wed, 19 Mar 2025 18:41:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 19:41:23 +0100 (CET)
Date: Wed, 19 Mar 2025 19:41:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: combine work under lock in
 synchronize_group_exit() and coredump_task_exit()
Message-ID: <20250319184119.GE26879@redhat.com>
References: <20250319175824.1852420-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319175824.1852420-1-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 03/19, Mateusz Guzik wrote:
>
> This happens to test to for coredumping prior to handling kcov and
> kmsan, which afaics is harmless.
>
> I however was not comfortable lifting dumping prior to it, so it still
> happens after.

Well, I'd really prefer to move synchronize_group_exit(tsk, code) down,
after kmsan_task_exit() for the start.

Then the patch and resulting code will be simpler, coredump_task_exit()
can be even folded into synchronize_group_exit().

Oleg.



Return-Path: <linux-kernel+bounces-235301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1663291D345
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63531F21251
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAA39FCF;
	Sun, 30 Jun 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkTPwoy7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117E2C859
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719773399; cv=none; b=SK/yFe3jBMAm9D4NHhKjmvZJ3qYXggvtJZmrYB9O3ikBqleOemZIW8F4JgSq+CRKtvy3EXNBwNRO+4bVChdhSX7vJOqUZo2hBDIhOw5aQO2a73my0qoQWX4La0bh4QCuZUYgGXn5YTfHfhfF5ct8D0k1aQOOjFlpkruJciqLQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719773399; c=relaxed/simple;
	bh=XckN4piaZGW9K+qDvvSQdiRq2r0ehpUmoM63R0fGpIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e8rsK7y3sDwUrt8f28TWPua9EItogD24ajBzOdROX0mVeg0/70hLaWul6efxixPbDSym8aeT/K1wY4CEzUGg7xt9L+7jM50mChRiZibVT8eUXs4xpQIyynfo24KMUR6o8vpeJea009KzWyTsd7819s70QVGaTJ3Uyzb/fMSWmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkTPwoy7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719773396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ne4KVkGSAYovr9Qj1+LYo2cxLoShDZ5iROjYCU+Sv/c=;
	b=PkTPwoy71MsW2TLkOVsNG5FVHKNKzg7O2dUUj4BulEoM8ZeaUqGU/IAtpcZ65jipbs2SF7
	pBd8YlqCuN4ZgrJRjISppvwDHPzcvxkcguSZvuK4GnZJP4A5xMM0fHcs0ZuCPgbNnAIMF8
	EwvZv2rARx/wCkljivnaeMu9MOljDbE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-VLBHcHCyNqmL5AW4p2Q6LQ-1; Sun,
 30 Jun 2024 14:49:52 -0400
X-MC-Unique: VLBHcHCyNqmL5AW4p2Q6LQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9773719560A7;
	Sun, 30 Jun 2024 18:49:50 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B7DB19560AA;
	Sun, 30 Jun 2024 18:49:49 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 4EA8D30C1C14; Sun, 30 Jun 2024 18:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 4B74B3E309;
	Sun, 30 Jun 2024 20:49:48 +0200 (CEST)
Date: Sun, 30 Jun 2024 20:49:48 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Tejun Heo <tj@kernel.org>
cc: Lai Jiangshan <jiangshanlai@gmail.com>, Waiman Long <longman@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Laurence Oberman <loberman@redhat.com>, 
    Jonathan Brassow <jbrassow@redhat.com>, Ming Lei <minlei@redhat.com>, 
    Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
    linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
    users@lists.libvirt.org
Subject: Re: dm-crypt performance regression due to workqueue changes
In-Reply-To: <ZoGSJWMD9v1BxUDb@slm.duckdns.org>
Message-ID: <e64c112-4fa9-74da-68ce-c1eec19460f2@redhat.com>
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com> <ZoGSJWMD9v1BxUDb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Sun, 30 Jun 2024, Tejun Heo wrote:

> Hello,
> 
> On Sat, Jun 29, 2024 at 08:15:56PM +0200, Mikulas Patocka wrote:
> 
> > With 6.5, we get 3600MiB/s; with 6.6 we get 1400MiB/s.
> > 
> > The reason is that virt-manager by default sets up a topology where we 
> > have 16 sockets, 1 core per socket, 1 thread per core. And that workqueue 
> > patch avoids moving work items across sockets, so it processes all 
> > encryption work only on one virtual CPU.
> > 
> > The performance degradation may be fixed with "echo 'system'
> > >/sys/module/workqueue/parameters/default_affinity_scope" - but it is 
> > regression anyway, as many users don't know about this option.
> > 
> > How should we fix it? There are several options:
> > 1. revert back to 'numa' affinity
> > 2. revert to 'numa' affinity only if we are in a virtual machine
> > 3. hack dm-crypt to set the 'numa' affinity for the affected workqueues
> > 4. any other solution?
> 
> Do you happen to know why libvirt is doing that? There are many other
> implications to configuring the system that way and I don't think we want to
> design kernel behaviors to suit topology information fed to VMs which can be
> arbitrary.
> 
> Thanks.

I don't know why. I added users@lists.libvirt.org to the CC.

How should libvirt properly advertise "we have 16 threads that are 
dynamically scheduled by the host kernel, so the latencies between them 
are changing and unpredictable"?

Mikulas



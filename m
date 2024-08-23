Return-Path: <linux-kernel+bounces-299489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE395D573
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45864284699
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DE136982;
	Fri, 23 Aug 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkvHCequ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC41EA73
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438750; cv=none; b=iL42CM4D3DM3VspQ6XgyAUgv6fNkf4NDHlkLAQDJjaZ4QA5ChVAdZ/ofvLo+XEMCehd5Le+Jz7Yh0g0QF+qzfXbOqlly+XUYAvEwSdy16tJOQbplYxSlvPoG3GCUe+u6iCb0AxqPkuNFCMXPgSAvKKALd7IZZv+Sslf7dbuAhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438750; c=relaxed/simple;
	bh=E7roMvgCtPrLWt67E7RytzzGv17ZLPLswDnIxEfsVWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOmBiqNjCXM9lqydFRiRvRtpbVx4DBCPf4KO18ILht7h9HS1Ti+tlZMCtRHW7UnHdTygneUBRyJbIMtM63dELQvi/2BUndYukr919z62DmYC16asDYOz6Sgxp5wT0hUUJuAIRssXpmsrAU4WJyM7FHECX3nICVlVjoFFviNajmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkvHCequ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724438747;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=9An+1E8Iv+yoL+xvG+CcZrCc2W40lzOawPuXEp7JUww=;
	b=LkvHCequFNhv/zH5dB5Z/kndvIJsTeT7WbVWtNIr/eKSWfGXYAaqAJ5Z0e9NLbLZqP+jib
	sZdJsB9o+XLsOAm7L4sHY4wHOkhOKKSRRqZosxgTSmd8qgEBM8rJJ4VpGoB7NshweWfBBp
	lk5aN2LZeYMRTTiqYERYscjiPxlNroA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-t_Idx-VzNq-4R4zy4654aw-1; Fri,
 23 Aug 2024 14:45:44 -0400
X-MC-Unique: t_Idx-VzNq-4R4zy4654aw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D28051955D4A;
	Fri, 23 Aug 2024 18:45:42 +0000 (UTC)
Received: from debarbos-thinkpadt14sgen2i.remote.csb (unknown [10.22.16.64])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1822B19560AA;
	Fri, 23 Aug 2024 18:45:40 +0000 (UTC)
Date: Fri, 23 Aug 2024 14:45:38 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: A Comparison of printk between upstream and linux-rt-devel
Message-ID: <ZsjY0puWXKOoq2ed@debarbos-thinkpadt14sgen2i.remote.csb>
Reply-To: debarbos@redhat.com
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240823070908.D0GYffCS@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070908.D0GYffCS@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi,

> > For the stock kernel, we observed an average of about 14,263 messages printed
> > within 30 seconds. The standard deviation here hovers at around 1.52 messages,
> > with a variance of 2.3 messages.
> > 
> > For the "new printk" kernel, we observed an average of about 12,693 messages
> > printed within 30 seconds. The standard devation here hovers at about 131.2  
> > messages, with a variance of 17211 messages. 
> > 
> > We observe a rough 12-13 percent overall delta between new printk and the
> > stock kernel in this test case, with a larger disparity in standard
> > deviation/variance.
> 
> I am a bit confused. You write here ~14k messages within 30secs for
> "stock" aka 6.11.0-0.rc3 and then ~12k messages for "new printk" aka
> from the latest RT tree. At the top you write "6.11.0-0.rc3 is slower on
> flush". This means something else I guess.

You are correct.

In the aforementioned test, I am purely measuring the amount of messages that
are printed out to the serial console (and are visible from monitoring said
ttyS0 console) within these parameters:

---- BEGIN test_script.sh ----

echo "Inserted at $(date +%m:%d:%T)" | tee -a /dev/ttyS0 && insmod ./kmod/kthread-noise.ko
sleep 30
echo "Removed at $(date +%m:%d:%T)" | tee - /dev/ttyS0 && rmmod kthread-noise

---- END test_script.sh ----

For the "stock" 6.11.0-0.rc3 kernel, we see 14k messages printed.

For the "new printk" aka Latest RT Tree kernel, we see 12k messages printed.

This measurement is different from the time elapsed from invoking rmmod, and
confirmation from the serial console that the worker test has finished with the
"Finishing worker test" message. I erroneously refered to this as "flushing."

To clarify, Test 3: "Pending Message Speed", is a measurement of total time
elapsed from insertion to confirmation, additionally, there is the quantitative
analysis of how long we take to print pending messages, and print the worker
confirmation message from the invocation of rmmod. 

This is where the stock (aka 6.11.0-0.rc3) kernel is slower, as mentioned in the
TLDR. While we do print around ~12-15% more messages in sheer throughput during
that inital 30 second window, the removal overhead, which comes from printing 
any pending messages, is much higher.

If you'd like, you can try the test and potentially garner a better
understanding of the behavior observed on the serial console. You will notice
that after fully saturating the buffers (which takes approximately 30 seconds),
invoking rmmod does not immediately stop the workers from printing. In the case
of the stock (aka 6.11.0-0.rc3) kernel, the command line will hang, and wait for
the remaining messages to be printed.

> Regarding your RCU stall: You stuff a _lot_ into the printk buffer. And
> then printk is forced print everything out in a single sitting. The
> whole printing job is done within a preempt_disable region so RCU has to
> wait until it is done. If printing of the whole buffer takes >60sec then
> you see your RCU stall.
> The current RT tree will do the printing from a kthread which remains
> preemptible because your printing threads don't print any errors/ panics
> for 30seconds. So RCU gets its turn.
> 
> Sebastian

This makes a lot more sense to me now. I figured I would raise this concern out
of sheer curiosity. Thanks for answering that question!

I hope my ramblings made some sense.

Cheers,



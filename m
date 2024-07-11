Return-Path: <linux-kernel+bounces-248457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD692DD61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574921F226B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F364436;
	Thu, 11 Jul 2024 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGnILLkt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506481F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720658240; cv=none; b=XwS7ToV6BLi98pDkmy2DkEyHR8+RFmq136mdlowLtiJquxkH81pZk8u8SVTXgb9GIEv0qJyKKfxHmyB8+bPQQkRAfv6fYFufKaioGkR7w13hP3Xdsb9UNj0w/nO+TGWoM2oW4ZxmDOtsffrFdPBsvDQoklaEidXu3o0mJmsCK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720658240; c=relaxed/simple;
	bh=Pwt6HpDzF04SqtWTpzLP4Kb9ajlmJjE/x8qFxKKdrWk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Rbg7FukteMHs8J2JsVoHeeUVLZHmOz8wKmSjZsgXkZquIdznYVlFhRFMFaa+XbAI1P4OU5NTFa9BHT8YKxDfBWVZ7uUUXPve0MnVdSTafyNdEGJ10h24aWWUxnFX9Ab18j1BBF0m9RKMq6CCA/u67+/jJAP6WMXbEXrjW/A5a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGnILLkt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720658237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=pmG1I3rDWsEemreYYSLcpqwv1JF6UKierrIURxVUb3o=;
	b=KGnILLkt8LUQ0kC0jFHZdZAQtYzl6PPteBYli7IDPZZYlD3DTuH6W2i3DMkB86rQXDjiOG
	Dq4w4zYC80/p0H5C02RSSUKL5tpQkI5ZSILy+8e83RD0TZ3RSNRZspZ6ZuXWG19G2vbeMz
	PoEpvqZAgd05IpcqOLvQnjciU1emHn4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-kCCU5OcyNn6jfGeg_E5EmA-1; Wed,
 10 Jul 2024 20:37:12 -0400
X-MC-Unique: kCCU5OcyNn6jfGeg_E5EmA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A40D2195608B;
	Thu, 11 Jul 2024 00:37:09 +0000 (UTC)
Received: from localhost (unknown [10.22.32.84])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3E3919560AA;
	Thu, 11 Jul 2024 00:37:07 +0000 (UTC)
Date: Wed, 10 Jul 2024 21:37:06 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.220-rt112
Message-ID: <Zo8pMpNo972JHYIs@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello RT-list!

I'm pleased to announce the 5.10.220-rt112 stable release.

This release is just an update to the new stable 5.10.220
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: b7364cea19a02eda9039a2d34c5f105d77f4697a

Or to build 5.10.220-rt112 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.220.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.220-rt112.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis



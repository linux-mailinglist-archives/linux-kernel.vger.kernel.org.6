Return-Path: <linux-kernel+bounces-278398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDFF94AFB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F51C1C219F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8683E13D262;
	Wed,  7 Aug 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfBypa4c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F963CB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055383; cv=none; b=RnVjdbJS56INdw1LkNCAEYiX6HCqXNtKvUILccmKr2bDY8Llb6GKMnTAnKQd8cc+KD37nu2UpzSR9Kn/66TxzclJkZ/Twd/sTqQcsnjhOa/zxMRQ+Wk8x20k/zvp9OLJPDzGGYXpGObC8zMNb9b5SKnQG7IGB5ZS5fl63Apn1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055383; c=relaxed/simple;
	bh=x0Gh5dUsX+OKIN85uHpwP2suPY7Lk0xxfxy9XFiU05A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i7vHIfBZpwPUf+Lt3DvMhi1FDHnYWgmGz+HSZ/K641SVRRx/v35jFDvy1vqztwwOHgS+jiuuk00faquz0zMO8cPNsssDMMUA47tJOzsEVABNjVaSUg/LHpK0o2ubVE+E8qWLkCC2H7OSLoS6wR9gH3ij/sA21wpH/PyUdC4hZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfBypa4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723055381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=iuEaMCr3ZjxEalj9opHIoSUEzllr1XxNMoFfZ/TmzCw=;
	b=ZfBypa4cwhlRiFE08QqxmAbK+N7F1+PB7s0cy52b5iEXJr8Y1SQWwi6L44KxCVTxH4J2P0
	IUNvRvyC11m4kjW9rhhKN6i4e8iFRELHXIn5oKgSIwHzUvxBmrenQkg5svOskLIehj8W/L
	ipjcOqz9E2Z7fQXi2mrYNEE4h8QbX5g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-QkwZ5qnCORuhPJNyCio-rg-1; Wed,
 07 Aug 2024 14:29:39 -0400
X-MC-Unique: QkwZ5qnCORuhPJNyCio-rg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D77B51955F0D;
	Wed,  7 Aug 2024 18:29:36 +0000 (UTC)
Received: from localhost (unknown [10.22.32.137])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75B9A19560A3;
	Wed,  7 Aug 2024 18:29:35 +0000 (UTC)
Date: Wed, 7 Aug 2024 15:29:34 -0300
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
Subject: [ANNOUNCE] 5.10.223-rt115
Message-ID: <ZrO9DhtFiajWqT5w@uudg.org>
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

I'm pleased to announce the 5.10.223-rt115 stable release.

This release is just an update to the new stable 5.10.223
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 8f0c430ef27fe8f996d85ae3ddfc71f643fd5a8a

Or to build 5.10.223-rt115 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.223.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.223-rt115.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis



Return-Path: <linux-kernel+bounces-203444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709958FDB3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C858B23509
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1CE1FB4;
	Thu,  6 Jun 2024 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLmko2Ju"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98233D5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632860; cv=none; b=L7+HSkmY/g38RpwoZczU9msnZGnN61yvzj5Fj4VBF+19isDV8IjW6d3qpOncdBwEXRyonccWa1+2t4Ec/lf/6IAOgyaqh2XCoiMIVxTvEDkjsZoIPhgR57Hn8Atae8PcaR/RX0dTE756ptzZlw2kR4Q2HxPRUyhKtJivStaMcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632860; c=relaxed/simple;
	bh=9oilFO9XvKQ0soB/XBPahH+BkUnkL8w4eEhMNAyVLVU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E0R+MAvGnXniVA9da4MgrbURcnkfujdKYhVRft/RdWtL3naJLD8qABlUxbYHscv8tTCLHrRJQvHEYeImhwd2deOhY6bQt+pinBiqxcFUE5XQp9KgI8Drd+iZDme6xbmzIVxle74D6DP1V3gLv/0QvuGZHKcRDQ7j2olHm01ez24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLmko2Ju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717632857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=nwN6uMAn75ChYmb2SOmpqq53pJQzzZ8ezCFBMNW6xIU=;
	b=QLmko2Jux0B5aL3TxKxLaHafoLHOqgFtHpPD8h5VFhFV4iF3FL/hxOavrC5ZjwklKJtr6B
	MOhJ7DgENAtu47V5RQodSEeGUmo6oJTRbAoj0zW3NY4mBuN53NP/+LqLsCZtLRrPlQrTYo
	c2FzB9e3Xybq50srtTOOv4Y7bgnF8Ik=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-IQcB3DXONW29sJYIOvi6Kg-1; Wed,
 05 Jun 2024 20:14:14 -0400
X-MC-Unique: IQcB3DXONW29sJYIOvi6Kg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E5071955D60;
	Thu,  6 Jun 2024 00:14:11 +0000 (UTC)
Received: from localhost (unknown [10.22.10.168])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6EC11956086;
	Thu,  6 Jun 2024 00:14:09 +0000 (UTC)
Date: Wed, 5 Jun 2024 21:14:08 -0300
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
Subject: [ANNOUNCE] 5.10.218-rt110
Message-ID: <ZmD_UOS57HO5_mu-@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello RT-list!

I'm pleased to announce the 5.10.218-rt110 stable release.

This release is just an update to the new stable 5.10.218 version and no
other changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: a14dc67650dd6f821532b44f0d7b2dbeffd242f5

Or to build 5.10.218-rt110 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.218.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.218-rt110.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis



Return-Path: <linux-kernel+bounces-413634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E59D1C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A04B212FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 00:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9981AAC4;
	Tue, 19 Nov 2024 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ytew/8Q2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB5AD4B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976664; cv=none; b=Bcdqat5hX5GtudMtlNMkdwq0a8dCCDWJOnog/7RmtSe2ZJmf5ZPjFXb9Rbel/1JC3yYXJdxTRmUsWwg1ZZp+uvH2EVUXXuEp2WVgfIOSGgjktx6huLwfeXslOKk6ey6Wvu9IhCr5qU+9/DFSUdoXygsqbYdDw8+4mB6UHl1ikUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976664; c=relaxed/simple;
	bh=3N+bdJY7GZj3/EyWNT7JRQ0Hf204zkwFkIagTRqw4DQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=haNPPO9wfQBLqELo/dmvtRGmxb3yeW4hbpEcuQObPK123ZGeYd8L7zNLxu2Nc5dsDOGMVLisQZdqWqwl714bBbicI5kpJgVL4xVj/W6D4zke+TRQcO99tO9xRqMDoTgQQKE5KczsoWJyC24lZok+YOspLLd35zlijrDajC9p4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ytew/8Q2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731976660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=iOzcg2tuyK5nhV5b0FwNpGbAHCWNZenn65xZEc+Od7k=;
	b=Ytew/8Q2/s5Iq9p4J605lsLrxHZn5TZbNSerxGS8u7flblYvaLKSQmqMbt/Mxx5e4yKKsD
	vatsABU2lvazEimMJl8S9cXCp4JXqI0dQxCDGKxJ2ptwf4V8Z6iblwe4FK6ZhbyyUNdm5F
	60fAg3fJ0qxgUtUt6ySiOLC+t36WOo8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-2RNXJpZVPlGPadZddkWY4g-1; Mon,
 18 Nov 2024 19:37:37 -0500
X-MC-Unique: 2RNXJpZVPlGPadZddkWY4g-1
X-Mimecast-MFC-AGG-ID: 2RNXJpZVPlGPadZddkWY4g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 399ED19560BD;
	Tue, 19 Nov 2024 00:37:35 +0000 (UTC)
Received: from localhost (unknown [10.22.81.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C14B1956054;
	Tue, 19 Nov 2024 00:37:33 +0000 (UTC)
Date: Mon, 18 Nov 2024 21:37:32 -0300
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
Subject: [ANNOUNCE] 5.10.226-rt118
Message-ID: <ZzvdzOqtzPNXUq9a@uudg.org>
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

I'm pleased to announce the 5.10.226-rt118 stable release.

This release is just an update to the new stable 5.10.226 version and no
RT changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: c806384c036dee40c091cb27c6db50967146b4cf

Or to build 5.10.226-rt118 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.226.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.226-rt118.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis



Return-Path: <linux-kernel+bounces-267197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C4940E44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C693B28822D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB91974FA;
	Tue, 30 Jul 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="wIE5fzZR"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86F195FFC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333087; cv=none; b=Hjqrj3GMBzaUZ/ESWUhv82Zg8m4Dxnw2UlNHnu4H2y8Z+7y0nYmUknu5tGA7ww0E6926/QeYioa8cvgb8cKhs/2r2TJfACbBMKNi5nI3vJPhodWrzVmHDe7eHCEHaEt9YXDhiJPBiLIt+gPGXm0XVqStAKT2MKrPDaff+egbTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333087; c=relaxed/simple;
	bh=zUSek93ozFjn3WUtBqVGG782w3YjeJWyyAnebjlhrWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJMrFAY1nYTI1f3zFSkD7o4yCtuH2I9ES19axETCJZczuq4mDt4ElxcqMjoouJlYlLILKO5e8PISwk720jpglInweED0wTb8BPVbYN93Qg5GCl9WJexLUFvVgyglfifXmNFMOCVt8KuyHBOSCFF8NIe8UlMCbJUEwMsTjODP4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=wIE5fzZR; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1722333087; x=1753869087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hbE0e/AsuYDQGa4T5/BMWE+LGzRmYVIQCtqF6yrNWXc=;
  b=wIE5fzZRTSJFVj/OKJ54DxigEI2UhOv/W1rrwWnGL9jOMVedRakOt0eM
   lyaKyU2KaW0c9Grrm6iEi4fKu5cndaysBrdaTdi0EVe4zCEMGcqhJughF
   cKBY2QXqsQVYuO0OLK3AGiXC+zccFHM5iDxmcOZ3LdIUOfmQD3PoDcyBp
   M=;
X-IronPort-AV: E=Sophos;i="6.09,248,1716249600"; 
   d="scan'208";a="316477028"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 09:51:23 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:29537]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.142:2525] with esmtp (Farcaster)
 id a9fb3a4c-c570-4e70-8534-8d954eb6d78d; Tue, 30 Jul 2024 09:51:21 +0000 (UTC)
X-Farcaster-Flow-ID: a9fb3a4c-c570-4e70-8534-8d954eb6d78d
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 09:51:21 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D030EUC004.ant.amazon.com (10.252.61.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 09:51:20 +0000
Received: from u46b330cbefe15e.ant.amazon.com.com (10.13.247.161) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 30 Jul 2024 09:51:18 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <mzxreary@0pointer.de>, <xmarcalx@amazon.co.uk>,
	<gregkh@linuxfoundation.org>, Babis Chalios <bchalios@amazon.es>
Subject: [PATCH 0/1] Notify system services about VM clones
Date: Tue, 30 Jul 2024 11:48:30 +0200
Message-ID: <20240730094831.882166-1-bchalios@amazon.es>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi Jason,

This is a rebase of the previous patch[1] that enabled VMGenID to send a
uevent notification to user space. I have rebased it on top of current
Linus's master branch, which includes the changes to add DT support to
VMGenID, and fixed the conflicts.

The simple problem this solves is sending a notification to user space
services, like networkd et al, chrony, etc., that they are now working
on a new VM. The former would do things like refresh DHCP leases, the
latter would reset the system's clock to current date and time. This is
a problem quite common in the VM world. Apart from us, systemd folks
have chimed in the past with their use-cases[2][3].

Previously, you have mentioned that you envision this being handled by
random.c due to the fact that it receives such events from a variety of
devices[4][5], hence it should be the one dispatching the notification
to user space.

I am resending this because I believe the above rationale is conflating
two different events, i.e. "you have stale entropy" and "your VM has
been cloned". The latter implies the former, but there are use cases
other than reseeding PRNGs; some of them I mentioned earlier in this
cover letter. In practical terms, we should not regenerate MAC addresses
whenever we need to reseed our PRNGs. And I simply cannot think of any
other device that could trigger an effect on networkd, chrony, etc,
similar to the one VMGenID updates do.

I am really interested in your thoughts on this and, ultimately, I hope
we can have a technical discussion on the arguments above and try to
find the best solution for the problem at hand.

Cheers,
Babis

[1] https://lore.kernel.org/lkml/20230531095119.11202-1-bchalios@amazon.es/
[2] https://lore.kernel.org/lkml/ZieoRxn-On0gD-H2@gardel-login/
[3] https://lore.kernel.org/lkml/ZJGNREN4tLzQXOJr@gardel-login/
[4] https://lore.kernel.org/lkml/CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com/
[5] https://lore.kernel.org/lkml/Ziujox51oPzZmwzA@zx2c4.com/

Babis Chalios (1):
  vmgenid: emit uevent with new generation ID

 drivers/virt/vmgenid.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1



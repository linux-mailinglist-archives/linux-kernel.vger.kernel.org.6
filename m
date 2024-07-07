Return-Path: <linux-kernel+bounces-243650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D235D9298CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD6F1F234CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C26841C89;
	Sun,  7 Jul 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="Pdxrv9e5"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F11BDDB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720369047; cv=none; b=htBlPc6gM+5WmURuLfWPF7NjmK2N8noywxBY58VzcKqKSpVvl6oHW3hLpxzShPNc7jG3KDVRdvrj7qtZ65HvTjjUKfSn0E+EmV18rEjTFz5r1iDJWFyMvLuaMVLcSvkYOn7z3dnpD9MrZtJIocw8FZI2eFN4JZTfuRx6VKvdaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720369047; c=relaxed/simple;
	bh=8LHfo1rOAaQlxdS3v/jalYjcSDAndZe5MOazuNAN9xo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oWWCiZwZEXdVYQUQdqEkvwzUhgMdsliIkdh6SFyEjh2l5updioaFAXvwFN7oXPzsDVnvgh6ggKcRJOhwcSINW34S+2Fc+YO7W9nzzc0vtSmbzw/djrPmElPwrEa2ZmOqqu1l5mzxsS7rwlztF8G+CAb20qhoiShUC6OaaAh1Vj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=Pdxrv9e5; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 5204 invoked from network); 7 Jul 2024 18:17:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720369041; bh=CCkAjOCiFaYK53JrnmxFZ2Ne9oZgyxcNpzrxjvr891M=;
          h=From:To:Subject;
          b=Pdxrv9e5fNeSSFAVSKZ1ah9Hx09tmDmTPjr7cmhD99wvwK88Hdw442LX0E+36TUnM
           DX6sY/2saZYAlOKja9k2jolVOL/hWWAqujmpTzfxWXYt1k/dMs25sKqrOI7SDrB8Ys
           G9nyx9wCX+dNJhwkR5viUQUipajBij90kxb/AFHo=
Received: from 83.5.245.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.245.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 7 Jul 2024 18:17:20 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	u.kleine-koenig@pengutronix.de,
	olek2@wp.pl,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH [net] v2 0/1] net: ethernet: lantiq_etop: fix double free in detach
Date: Sun,  7 Jul 2024 18:17:12 +0200
Message-Id: <20240707161713.1936393-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: dcc5dc2a3b3bc3e7b28cde8500ac2682
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [oQMk]                               

Changes in v2:
- Wrap line around 80 characters

Aleksander Jan Bajkowski (1):
  net: ethernet: lantiq_etop: fix double free in detach

 drivers/net/ethernet/lantiq_etop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.39.2



Return-Path: <linux-kernel+bounces-336328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D973983935
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F8C28235A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2983A09;
	Mon, 23 Sep 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="LVYAl0i7"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984E82877
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128197; cv=none; b=Toawkph2HmXRrlB3gUxuES3dT+5JgCKzlouYdn8g/aOIFTlS4bsmgfd6TwYSlT3moIWCA3TO7glKZCQWXtxxZ0XRYe4jCs8cvmO6DvfIxBHq0288PJEQ07aaI94iAc0/VV7BpI51SJGiMAV7ovLQsiSDL4RBMRAG/Y15T/GcqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128197; c=relaxed/simple;
	bh=z/eR6ZEr6qVhLx/ZIxviz3H1/uYAycw6Adywjx3BU0U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=cx+L9Qeh40xh3/u3CZomhFxz5Oi9XnCzcnkBbyLrc00B+2mhvWIn0xt2f5Qkyi0ISvy8imiugobpCZ/svZ/ljuHHlE3mYfKLLufw+xXHq3JxIGamIZsSbZAI0KYy+QzX0xxmB7YHfCzaYmpE+zbq4jPvxGFQTBYsM2Dx1XeN5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=LVYAl0i7; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36371 invoked from network); 23 Sep 2024 23:49:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727128192; bh=g3dTl+Q/XMqPb/RqbE9qwPxfrW7zoD7gEyQacxzuKB8=;
          h=From:To:Subject;
          b=LVYAl0i7G1OjRxJ/jlBax55l3p8br0EtZJExotB/dJS53ocI5YfR/AvoM5qMyutTP
           kP6dNXQ/AnAeenwjUWrEZmXAdjq2b92YUjccTW+nPjhOu/gnlBt4rRgoQK2jFOVHO5
           52cNiCLE70zKrOEkPqq82lxq4DdFV4xmHq8sMUrE=
Received: from 83.24.122.130.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.122.130])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 23 Sep 2024 23:49:51 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	john@phrozen.org,
	ralf@linux-mips.org,
	ralph.hempel@lantiq.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/1] net: ethernet: lantiq_etop: fix memory disclosure
Date: Mon, 23 Sep 2024 23:49:48 +0200
Message-Id: <20240923214949.231511-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 211e50a305106f4f09a30342836ac5ae
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [UfNU]                               

Changes in v3:
 - back to the use of the temporary 'len' variable

Changes in v2:
 - clarified questions about statistics in the commit description
 - rebased on current master

Aleksander Jan Bajkowski (1):
  net: ethernet: lantiq_etop: fix memory disclosure

 drivers/net/ethernet/lantiq_etop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.39.5



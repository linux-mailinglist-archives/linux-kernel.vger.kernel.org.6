Return-Path: <linux-kernel+bounces-421762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9AE9D8FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C10228A516
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4DDDA9;
	Tue, 26 Nov 2024 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wBV4du77"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9346B5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732583116; cv=none; b=sPJQfek4bE9td3wub3keuGw0vVp3k/jc4AHgE9yvNgObjg2vRRjjsuvopN7SE5WniC/V5/MeZ+PMDTckPFQ8EdmeDUaUNxSvqJ0gTrsyMLD8fPgrCvslOYKHIbvAO0ZF86hDnB750EPVko5F5WRu/0aVi4pTz/QuLBARI4YHgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732583116; c=relaxed/simple;
	bh=kmgZdnlGhiKKa3LZuGYMXNOPtHoR3rH2P9LCumPFaPA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FC6Ceg6fMC4r09NiAlS0HwP6+Q64L5sshMLBUX/tAWAYPknU8MhKZu7ls06gMZSMMmPZvK2IswWMnrcILvlKj9ucHkxCNRdjhiWoAmtQvIzYcUVZOhmLitnMZ9AsMPdoGaEiOmQRhfr8c7zWhoMiqrSCBapbXvQWOWmKxtUhIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wBV4du77; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732582809; bh=kmgZdnlGhiKKa3LZuGYMXNOPtHoR3rH2P9LCumPFaPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wBV4du77Xa0mq5ov3FUfIvZ1u0KSPkHsXhkzdRCcWYsy+hqMIi2t4T1c4MWyNubvM
	 f7c0HkcArtzU7AVzk79EsY7uMvvqK8OIJf0RtJwfR2GGDqXSEeZX7/4U+mEeV2ry0C
	 iY1FrXsQoGLtK8bGEwVaqUdp+kmlr1zLhgGiIxRI=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 81A091; Tue, 26 Nov 2024 09:00:08 +0800
X-QQ-mid: xmsmtpt1732582808tivbks40y
Message-ID: <tencent_5ED3752374297923ADA44E776F777CC6C005@qq.com>
X-QQ-XMAILINFO: MmAB1QhttJoEytvf+oUeLkgeGmReXOVuznSZQUcj/h13ycBBJ1214e6A8xV/nG
	 FBlupd4E2IBv67a0W5eMc5WDr8HgweiASvFcCWpfkAbxWhmYSA+bTI7uuNv2HdTYDBHR3bEH7kqt
	 Vtp9AnxhX/eVpX++ez+b73kXOVkjKEu14fUNbDeyxj94Y95jw/gyvil9aU1gKaqMyYmkeIWOtNgZ
	 eiqLk35/HbrR+Yp8q46cAAT6DbkeQMl8lpGMYHomVfL7kvqpz2pugzmxFy0LNJ+BpfHjRZyvnaJ1
	 KYdHv3LIYjXFQyf+q8GfC13jibVAbvnqwSDdyHQzvOnhIPIlPNhFM1i0VKFBDSsp+MJ2hn9y9qcB
	 w30qCKBamcUaibmcY1dzmH+OmW0WDhiRQPzKUHdxP9w+95K+x1bUuY09j5MfY8W44eUJrZFXXLcJ
	 r+XI8iYthMRgnNBmGUm1iEIwWZzAkM/oTegmFFQ9zCVlr7r2ICEojgDENIXKpL1z1zoWqNIQiiDV
	 2vkC7uKdT+adXccaFlfUriDZ6GQwIDgus52X7gmuD7AFbwcKMIlJuaRAOE68pQreTSQL3OQ41qj2
	 r9uModkmxPv0nZBR9kQnAg+fQtmetuEcPDevRNdRQB43lkER++NL4RMG23dFVZAj0XHnPRx+YQis
	 97JUtWnruFyRNdEbtLO58f1lheMRm+/yvz023rqWjoTHRgFaX52+Xy0sOPzbnwO6sJoYJuCFbXGA
	 /U8rL1DHd9mHb/3f85pCaL4EKMbveLA9HvJuSG1ljmGrK8VkO3gp8+yTk0QKa6qusGx0ltY1w/0k
	 3vyXEzht/1E2x/+3vHX5gVhef6qXtPVRaHtmDp8dHaO/tEGeQOdvBYdt8K8zumsJ5N910t+8b/u+
	 l37bO1tVW8ASNvFsS8RzFnjAyrZaHHtQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] KASAN: slab-out-of-bounds Read in ovl_inode_upper
Date: Tue, 26 Nov 2024 09:00:08 +0800
X-OQ-MSGID: <20241126010007.3977710-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67447b3c.050a0220.1cc393.0085.GAE@google.com>
References: <67447b3c.050a0220.1cc393.0085.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


#syz test: upstream master



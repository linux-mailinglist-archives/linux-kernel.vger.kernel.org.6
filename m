Return-Path: <linux-kernel+bounces-436246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F39E832D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 03:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C03281A6F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 02:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB522EE4;
	Sun,  8 Dec 2024 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s3P9Lctg"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04818E1F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625835; cv=none; b=PTIr4KNEs2IVaL9RU9MnBttAVkdyTZ8IBVGsPVK8HEQ75IuDPrFX4pu52xfMXMIqWgwc589dUVDY8KEsVEdI3MuJLi/Tt15a8b5+8FyEM2MHQ4eqDwqJE12daYAqYBh6zK/Bvl7jCG7bI2UNIa6SFfZndfBWZuhxjVHfo03IKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625835; c=relaxed/simple;
	bh=MY0irfQG6/kHWfYduUu0Fzg1zEn5ablP2eAtDpb8+kw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=G9mjXom5XBpO6kTB8Z5HJgWh7czf+uRw7Vm4R51UKfDZxIrEqT8p5BuJeN5jA7jCqHVEduw/ikBxMSZQX1JtpQRuk0tzrD7rtWEeniACSsAlLHn0Z1W/oIy68IX9VfMUm8gm15M4xUgMfFeHsUjLLyEkxLAZu9ki0Cso8e6P89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s3P9Lctg; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733625520; bh=MY0irfQG6/kHWfYduUu0Fzg1zEn5ablP2eAtDpb8+kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s3P9LctgOZjXPx1aXkFjvHXLomGn+AAkqJ/W1MEUaxvnie7Uf0+7XYX1X+5Q8vc/4
	 hXIJ34B5+TxP4BdFu4yI5vNFtjvXzEK2J6rxITViDhtjWLJM2R6QwWUuQgBO4832tS
	 /hjD+Pm/le8MOWX6QvsP+wJDZpV+3XRfn8WatG+Q=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 9A68EC43; Sun, 08 Dec 2024 10:38:38 +0800
X-QQ-mid: xmsmtpt1733625518t8fq3iwxh
Message-ID: <tencent_33BB8D919274DD80DDA299114FC60DD02507@qq.com>
X-QQ-XMAILINFO: MmCmH9jyqHC2cSsFKzQ/6a4GJe6Z65O+9eiSimbDb4jKkzOPU4KkI+H4bPi+kD
	 m/kKYqRL/sCJlkNc5UV1X93Y/TU1uWpSclCQNd1ZZqfgMjHDnNH0jI8XGZBkpvBMQ3FAB4gBCJ+/
	 Y/yUZyaYy5zBKl3csau4bm99G6ump9TcKnhvJaMqoBPcF6cLrPy+RPtgMKK0NN+48mSSt36EqYL/
	 83rz1m/bBmkHHwM2eerdzdBeb/UqHPX4/PXqlkLZMa+nSv5IWWmOTe2W5/OqcHojPEMqdaE3kpI2
	 zGs7K++nB4yqGDwc1r4UuG52Nq4uJurS6spM58OS7o/zn5P9L1mCUWHH9IYjFHGrMNkKaJ8nE/U0
	 VhyyNw7qTOcVaDMaGHQPDD1EjFXvcKUDFphyFHZlEnM4FtdRyQskF1cjzRJsmZ2RnRFb2t3VuFjT
	 uY/ZuNXtcM6Pe/DkwCpcCkSXOXYb51MlUHNtmNEFBwVha91/qpS3k5oJajuezEiWrsp0H8rjvVft
	 xduylZUYciPQ9YjGfgpdfOX4cyynLEwy1Sdoj7z9ofzUuiHbBOXsmtCL4dF7AtG6cWpLPvv8nqh2
	 f0+bSYGS1ndl7fqhRjulTUDbnEl7JMgnoyGqMWTkkKFfPjG2cR++QyGTZmeYcXgjMhkU7THZcvUZ
	 aqrWny2lDDDlZETbEfkLgUR9rpFKxJHvFr9c69ra0J7RYdpxp6lUKRzrfRlr5Gtq2m1a3hwyYsZZ
	 HEQPxEjMlkDmk+iJRnTEy7bDc0O4+FqqQ76eTt/mzLpsCxeb6vWt1A6oe1YAtswtGLcJu6m8hoED
	 LYVT5C8pEQkn436iRZqG7I9jlKmOmjmF0zEvYFBCB3NLL9i6BwV+aKpbPFlwK30nbnxwpehN3i73
	 5tUloPvz+VpJIRY/irP5g=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
Date: Sun,  8 Dec 2024 10:38:39 +0800
X-OQ-MSGID: <20241208023838.2175358-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <673e20ae.050a0220.3c9d61.0163.GAE@google.com>
References: <673e20ae.050a0220.3c9d61.0163.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/ea1davis/linux nilfs/syz_0163_v4



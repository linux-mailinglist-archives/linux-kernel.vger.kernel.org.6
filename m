Return-Path: <linux-kernel+bounces-428924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FBA9E150A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A41164E2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3371DFDBF;
	Tue,  3 Dec 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nETTQsoS"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672851DFDB7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212919; cv=none; b=qiq7IX2mDEhPnHR8HWQN327gdmKHJOzCZJxo7atEV4K3FJ7OII7PLR6dlTI4De07DmUD/BhOxQRGwfPwe0YYGhYu7sbsmw2kiu1ZK2xDk5T9WiHIewxMHLXjlaQ3A705yTCZgjxzgX1rpBLWHdL7ql9qDpE0SHATcRqZckhkcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212919; c=relaxed/simple;
	bh=lUDr/kgn8NhMkuvetV00PM+Gi6jKllNLnC+GCYFx/m4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AwauHN5cl8v+dOUCsFt9KFwaSh+O2mHygQsVjKt9339aBhAHH1smOjavHzQsG73gJNKV0C4HG3A+4QekiDMMJChEUtUTSgdj5ZdpztkLa3JUWQgZuoQUY88aZT51oSkOZleD2PoO747ty5sfo0gdZCJqTREzbK+jJnPOw0N7gu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nETTQsoS; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733212599; bh=lUDr/kgn8NhMkuvetV00PM+Gi6jKllNLnC+GCYFx/m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nETTQsoSWRJHveN+I9prCfS62RnMjG9LVR4xic8lWiZUUwAWdVYlh9kNfI5X2SfV2
	 7R6nDZhy15ZSBJteHifvtOyOwYqH6cDRuhWOaaj5OWyTZSyXgIxB3w5ZLbVO6zR3V4
	 ooMQhNVOKTNe+6v192z9nhy1llZ0Jp+NHjSqIsPA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id E25168DB; Tue, 03 Dec 2024 15:56:37 +0800
X-QQ-mid: xmsmtpt1733212597ty8edgzhk
Message-ID: <tencent_A26C496423B3445C97605771C6C67369C305@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmafjFSjz6rUYqRqzBhNfCGwx0mia677GsH59qvIolZYKNUjA/jR/
	 GfiPBDjVxLSOzcqf0Pb0daaeuM4/ud8uhcNFuA8sl3eruR1rPCE8JlJoCwaY/9JyYDsEUB/h8VRa
	 +XmlTIDDDokFv62rVbOK5+urQjKnWNGSzofouoNGDhtTnuLfLsIt8KmigROerbILPH1CcANrAT1v
	 ve278WGHukH8ri4/sovNacMGlnrmuoeMBX5/EplYzeUVUkvTyhUh4KOMbJa+3uu4KfSb5cJX1eqZ
	 7uGsH7CDj52hQxa3g1BouIgrGlWDai5aXiSTxc8TT48/lNmI2pHkZ6eZJgTsqzXNPwt/dHpd/DSI
	 odvLZz1OG8zD4k2XrM9s33hYFdif3sY9xv/mqU4OvVU7gOW7fNi3CTjtrRmhLSZJTtoun6Li/p6N
	 btBlgTq2ohmI5J4jspFOYunE3iYRRhT+1XOIeBiGe7jwWLfz5uScZYWmvDvDWZy7jQNAJmA7PapL
	 bUoo6lP4p+gb97ZU8dABA7UxuOaE/U75imPbFSXVR35/Z+Ubmr/whbGgp69VKuy0HSQttZrXC2bD
	 oyO//QMp+zfyx5goU+GRp7y1+u/oCEl7OLFctoS3qlsbx/oZh1Gg3jaBkmiekHZ/Hm2lWi8pUs7r
	 N3wrY5RGPW6ewwK394J6GxcZ+ZgSRotLpFI0MM2s3r9eqKMjGdONmNy9/oj/drGrAu81cfB6c9GA
	 QYMXF4xxgXgd70lCsgUy6lM75kyittQSXv5HWiijZWjwdR9TMIh9l5rrECy8bQPpOQtFIH+Rj6Dz
	 fVl+VouElyxSJCwMmMtkd6Ojhc2pT5gvQ8XUHWI3Xt9Oe4NFUC4C7DnArUawlRbmLeQNiTGsFyJX
	 CGVn0PR9C3
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] divide error in dbAllocAG
Date: Tue,  3 Dec 2024 15:56:38 +0800
X-OQ-MSGID: <20241203075637.453942-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
References: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/ea1davis/linux jfs/syz



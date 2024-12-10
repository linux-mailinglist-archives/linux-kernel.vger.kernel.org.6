Return-Path: <linux-kernel+bounces-439461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13079EAF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A73E28E8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5872153F1;
	Tue, 10 Dec 2024 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iYRwEKE3"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07133210F4A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829302; cv=none; b=TbluSjbtp6ky5XIuJV8MVmhn3ZOVCEndwxXic1kG4XMzBeTsQnSVXNwP1dp2RP344biq099hGCLp9J4XUonMe2TJYWejyvHR+IUqDJ9lEprKHW10ajwT/U+m2ToTnT74lFvxpAAKDtOSGBlW5PwaqbSpn8cHzXgD5C5tgo4szvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829302; c=relaxed/simple;
	bh=HpoR7yvwxjfK3Bad3gpIZWhf8Q0NzlqXU2TNJfG1WF4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wh6MO2Zzy+JjbqSMlXgx2OFx8yhJ2cE1PadT2yC1Fzc+vXpEr1LQdDSlgLhABZqPsR89ulIMid6HW7lrnCqWf1xGqqoA41I+WB4kGo8+3Eb+nMzuqRUJd1zyoRYlYmg0styLJ2cK7oVwf4+Y9JP7a2xwavMKuOqVTGTyo1iJpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iYRwEKE3; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733829287; bh=HpoR7yvwxjfK3Bad3gpIZWhf8Q0NzlqXU2TNJfG1WF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iYRwEKE3okbeWvzgje344I+DahNqT8qIsA6tad1JKCVabiYDrZWNQgJMRm5vc7c8y
	 cSYg7TsgSjCB1UDbUZDq2YmcF4RKX2Vx/t8kkA6k4adIYlCOjZgye1TqANq6kxLNRi
	 VBX9qpMFK91PoRGv6IES9LNV+mtA6wRapn8dL/18=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 9089835; Tue, 10 Dec 2024 19:02:16 +0800
X-QQ-mid: xmsmtpt1733828536tkp2gk4q7
Message-ID: <tencent_E4D7465C09A9AEDF6EEE4C9AA7C386F1D206@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jtisOisQp5psoRAfz8bBg9VmsfQ7nIWocmUZtunE69DJ1TCXujU
	 6J9rbddjwjXA6MrD1gJBED93f2fulQDQBdJmNziE7Z9c/IJHC8IRHgz/amVXSifMSwvFt7zSpfPb
	 QDQg9uxX0GjfFxYs+pHKLoPvS01+eFnGLx+xCOpjua67UEqHaNHus3EnZUvQ93+ni6gEE3OsbHRP
	 vGiZIT3nlcorapCiuSyr6ehZD/7WLvtqxb1JMlQ7H7rGLEOPARgmOVxATqv7mzMC7CaqBHIZ4+4s
	 zrSopNIU08CLnY6cn14cwCg4oXRbasr2SfJpAzw/YgBsmnDcIPlOjAa9mmReyOq3vOO7Bp06D/C2
	 ruyQS6IX++mamwehItdTdT09fwSWggKQzrPFGbfTSJ4wxsr4Y8KAMqyhgt0IVr+0iXJN8uhl4Sgk
	 LWz274gfEIKzl9pU9etpUvw9t0ew2XUzna25Lz/4XBSO7eC42d6fuqW9zykJPjEioVDoENa6pJT2
	 3jFM5CAsiTi0/Gox6UBaVhshrjCIflMYrc0gbxOi1Yg2mmpb3b4TRKKX0BZ+Ba32KM7wgTUhKWWr
	 pT092L+V2cXkLj1Uq/hmfKFsv7ppNM1zxef9oBzGak94/VwnVwmM0F1Ja6BkzegiwufYMkiPu7mi
	 POQg49Fs5uMVRF1PMW/07HoVV6czgYNtbMvR3cdHqrP0bFV1CA6/+4GFA6EEuTr2kTiiTzYQeQuK
	 unlGRsT+Cqc7DGjtzvCWvng6PmQDBDCpGhsb1RFaCSML4F1PBLnJ31Qu2VOkWFoCj+ZhTfaef2lL
	 ZN/mnWtCLrvnqnEmM5oxqMUiY+D7nGCAb8A13RtCOIv6wDYh/8ODmJUmfVpcO2QX9+uVNiX9+8Wf
	 zDsv1ODZKTQWQhiHJDV9g=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_search_extent_list
Date: Tue, 10 Dec 2024 19:02:17 +0800
X-OQ-MSGID: <20241210110216.3635515-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67577778.050a0220.a30f1.01bc.GAE@google.com>
References: <67577778.050a0220.a30f1.01bc.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/ea1davis/linux ocfs2/syz



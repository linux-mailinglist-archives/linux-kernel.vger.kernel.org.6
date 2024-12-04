Return-Path: <linux-kernel+bounces-431281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91BB9E3B7E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CFF164C85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB0E8827;
	Wed,  4 Dec 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aAJuxGpf"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913911B0F1D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319735; cv=none; b=gZVM6LDLFB/7kmB8hJB22cb3CIGasPjD+wOxkWt/2AZ5DYZg9I/urQjGw5i4AdaGMPtduHCpHA/CHWyVWCXztgSZvmqP/O87zl9t2aomXPjEuMW7hE9xdbAgq5X9AT75CmcSLVYFimIVW0Orsi9B0Hl/AvpYTKDbNvaFkBpeuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319735; c=relaxed/simple;
	bh=Z9n1fDvCez+yZTQheVfI3v1faTIsx7W2110k8lCsF0U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=of+ZM5n6dVddpMQ4HzzAQRRnBko6APm/feKTq72iQrc6kZY54zkALhLCie1HKHKEeJqGVhADqgwxqGXgYngE5ZO2yHE9tfZWNm+2dGprsOoS6WOGOwKbptrzIpLwGSVDOmXDYzIhHWSxP9TXv+WXnrQMpXFzV8SNEEZ8+LKvUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aAJuxGpf; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733319726; bh=Z9n1fDvCez+yZTQheVfI3v1faTIsx7W2110k8lCsF0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAJuxGpfBGfQMC12KmswUerKkkT9Ke2/5v+WYa/4YNsAxJsun1Xh3AZAUzjTdVaQ+
	 yOylgToGSdWkbFNgGIQ7EBXkGYgGUm8N92iHJR4r+t/5OPhR/TW5vtQPILA8V0fITw
	 GD7cZWZNEy4wV8awnrNkNv080eMCAEm11dbO36jk=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A842A807; Wed, 04 Dec 2024 21:42:04 +0800
X-QQ-mid: xmsmtpt1733319724t4yskokyl
Message-ID: <tencent_001B704B941B65254DBA10BB92337F9E7508@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2mLy08Q5A+xGAIiXdsRUWyYiQEY6Zltz8t/VMdti1UpQhtW9Qza
	 lAX3040rvxWfQMjAtMSPPLTY/14LDG7SwRYqwUxN1xFFfjYgpfrzGE2rnmVt6NcSiBi67nQ9WHHN
	 xJg9+2ArUmom9WtQ3D1oVRA8px7XvCPzCTN3PzQ56840SuJsl+67Jq6pZmKPhs/jgS5QkqFrZM5u
	 nx6ahLQJcVnhmDCKS+ZLr1qnuqmrzGx5np2yMQBkis+eu9ATnORmhivp0tlxZypxua91CCnBGTqL
	 dvwvFVD9eLf0s0kL2myGGq+VCFcE4Y++6z2IKvkJHxqjPpFQOQxpsAOdB2a07Te9O64SkaumddOF
	 6TEkgHEH+Uo/kc90JdfXYak2pC4ueUwXSNVslgDIOytpD3ANhD4AE4bhwyqAaOGJdSbvh7vGM9f1
	 VOJkKi4G+JJhfIo9Ciul4ky/szSgxxHzwStGEI6BKRjkUZ5kpWmYR3NIi2QDxfkpX9SaBtLtI3vd
	 S4EpP5fdmcIAqRFvOAWAeVviT0NuFrtqy01i+K4sF7v4DgT24tq3xyvHpTxXEBtGaxHVCdNSG5tm
	 g5UvVBCfW28FRqclK/STwVc10RX4GQtXQKfz5yT3rfCNrqVrtJUK6ukaqBD4wDrg3eH/usng6yZv
	 maiqNeJrBJAxkceqwedVrqHJKxYi3m152QMp5lqfe34TBFyfJLNCO9vbFnkrbM1zr8v3c3fsB4xP
	 inP9jpROdGYizpp45dFcdilZGG6Z/XrmPfhQIDq+66fCvYKis4OcKy/PPeaykeGrP8es5N9aYDML
	 V8yMqGbokCifoM1ObBq1GR40uNe1Bzu5o/4ZYu29FHI9mGGduCv/y1ozit4+9NqbpBX2G7Fcs7Gm
	 LgiuIuxljOXN+vA8LcMLqayHMDHob3AjMd13NdkWlLQiju5RSPlWo0meKFeugOo0VnBLexa+5N
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
Date: Wed,  4 Dec 2024 21:42:04 +0800
X-OQ-MSGID: <20241204134203.939289-2-eadavis@qq.com>
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

#syz test: https://github.com/ea1davis/linux nilfs/syz_0163_v2



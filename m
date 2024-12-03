Return-Path: <linux-kernel+bounces-429190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6549E184D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0050E165CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064D1DFE3D;
	Tue,  3 Dec 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eARyjVy8"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE001DFD9E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219547; cv=none; b=OXW4mwTgvTbcWdVHrlhIXUwIvpsdrvvpC1av2j+aOiZThOLDkUSQehnDVf8oOM6b8CFF6ajdObHQVchRxDZDoB+USi+uFHt2JbeUWFYcNuedIqByTwfhpTpklCS9a8mH7gvpmraxWqRjUIfgFYLfXwqgxlnPggsq3TjVc9zgWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219547; c=relaxed/simple;
	bh=AaA57oEFW2rBavuziENezGbvMs6+ns0l0CTlILca9rM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m1/D9m61DWwhX+mD4Bxt7OpY3L0evLPOtfsTxzr+LTcSksWyCNHIjjFp16A5RRrLNH30YAfvO1EhPwMOvWtvfMU2nsTK1oMm4OcSHGtU/G1UkM+rRDIm+U0oWEUNx2m1igJF7M+ICMCXvlxYvWjOq5i57U8FoMmq47EiDRV4RyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eARyjVy8; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733219234; bh=AaA57oEFW2rBavuziENezGbvMs6+ns0l0CTlILca9rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eARyjVy8mEHkfwOOMXIVHdjMwHDQfdfVr0xs9uBk0Ni31q6nz7CEp/0LDpMnT94Q7
	 Uzn02xlyCDPPTaR9mrUxU03rDBygCKum88vVOO6/JGWPG3cfUANhIzeMPgxJTRIxOV
	 LoMY4BQhEXctRSFSTFKaMJS1ENBF3csHt8ep9XSU=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id BCCADA56; Tue, 03 Dec 2024 17:47:12 +0800
X-QQ-mid: xmsmtpt1733219232t6xrn7gii
Message-ID: <tencent_DF670373896E43A6E4491760F77BA6CBB305@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCA+ZJZEDV4LFTNvv5VEjgufhy7I5evWa5DE+T6cze0futQAIE9G
	 R3oCpZQyo9/kGMkmSGekRceBtDAnfFFa77mFWq7ZK3PxB9dcp6X7lwuWWjid9D+Yb54aDf5G/Fet
	 Buc9pRdcX9Ia0qWHSA/lkXz2g+WNTqAjPjpzXdOKMHXQNRK3eY1xA/86HtocGUBIRiWG50uYr1u/
	 bXivSSp1cnie4N3RhXB0RM798neaEIS2dqQvAecPEKZt43ejDycSrgi7grCoqSEQDptV3PrlRZaO
	 5LBaO+4E7Ct8VMVs13Gk7tIWBBJoG6Ew0UjJMdHzsPtlQMTC6CnnU1pxkO8WI79HQSrPPPGwucKv
	 OPJzuacYD+WRoI8lJPbwY3brztmwdFG5yJRqdbs2Sdj5VacUSoRMumRnAvEZ/xJYqHg+GGxNR/Vb
	 U8hDqi0cbwgw3Ph68bzIQTbJjwXgjwIBkkYD8/1kMJAf403YAXmCBOfLoEfxd2FpMCyvjtfAzlN7
	 u6qTFvpoMCoPJE3cMP+9jklaqN0WSANHY7gia2AgywLON1YNBhM+DpqVRCW/lqrsg59H36lHo9nA
	 IZDfdTrk6VAvrHeJmcIK8S1U7DsA4/vwEK7HWivh+oRwRLc9OZUSEwBdHcDgrLMyLJTMaG7R6MN+
	 LaMQTqkoS+sMD/KO1SzTaeaEOXn+fypKrzP4e9f4lu7MJv3MvPZgLPye33B9etnfHN+fzh8JWbiW
	 IucUuIZ9prVDg+GfzJf7cLXerdHV4JRtS12fGAtDzn80vlF8LqjAGzGvgyhgafxdGIDT9kVEiMi6
	 wKjeQ81nrekoasfeb4hnyVpiKbv1Isj23X0I8F0M+s+GUPeTDoh7P6dbWw03KCT9pf526UEAqrZu
	 kjo6Gq6bbLsqXvyMuNrGHzLyU/0uReuA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] divide error in dbAllocAG
Date: Tue,  3 Dec 2024 17:47:13 +0800
X-OQ-MSGID: <20241203094712.564975-2-eadavis@qq.com>
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

#syz test: https://github.com/ea1davis/linux jfs/syzv3



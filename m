Return-Path: <linux-kernel+bounces-431140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A79E3A05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11877B392F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15AA1B414E;
	Wed,  4 Dec 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CocFbLfr"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DE1B3950
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313511; cv=none; b=aNsVOadY15FSICLf32SvLB3Hf2iHC7tMTOGNJCnQ/F72TCyR0zHDnpXG8WWBPb4YwljtuiYCLrCkSKBk6Rxkfh5IBXDZezP0pAV1iAfLaKOEDptQoDiaE8fSPj+yXmFisS87e5Gk9YKSVuLnBBqWfRECgrfKTCK9l4pFPdPhUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313511; c=relaxed/simple;
	bh=65x1lAuW8rOCPtGaQkpsB2RV59pMNbYydkCS/cLDLrk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mIEEDhFn1e0ntCW7CdlmKWXeLms3Vq9wsXDVAa54kdXeAfxdqeh/MreflL3MmwunFsw+P+J6kzo3qf8HkhydSIuHiUv+qwyGuENIhNfFttUyZ5zd8nn7uDGkeMJbrNgkX5jwQlNS5mdOjLBwzfYKphgP3B1d4Q9uVY5v+MBW+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CocFbLfr; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733313194; bh=65x1lAuW8rOCPtGaQkpsB2RV59pMNbYydkCS/cLDLrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CocFbLfrSj6A3Fo5lEq/8uCg9oUGM97e9WmNi0BMkKYSikylRJ/zaoYvbTBKlbRz3
	 Xd2uVx3Xosk16WKye5c4tSCzCIfoNNPQG8P2jWXThQdmRtbbB4/ng+7JgjXNxMmFfV
	 DTVbSpoZ9IjOQNOTz3+VEcuEFnkgplfTYIcdJcgk=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id D4C8BCDC; Wed, 04 Dec 2024 19:53:12 +0800
X-QQ-mid: xmsmtpt1733313192tdbgji9kc
Message-ID: <tencent_D17D8971A3AD2454377A176446C8B37B8305@qq.com>
X-QQ-XMAILINFO: NSTsyPg8kQQYYUZeoaZ/TjQweXFCbEvXpfYndYa9oKvg+iB8c6q26O8wXuFucA
	 /TprwWPVbFNXb6j/ZbCbsF/YCZrstM88kDg3YW0QoR5mTu+7L2MvM4vI0h6BQqIzdvfM49xoddS/
	 2S/B1W3hRBsL9eeO7q49CnokCiAjMw98KdgDPox6O97cPGZNc4ZLgw0N9Y94InsY4HAASi728L3Z
	 vnqonIX2fuRGHV492calxp932j7ml9Fe9n757WYiBQ0N9NXt7EkaFNqqMUOEGQ8I2IX9LXFBnGTD
	 0wFU8tYKiIg1tPBMgn6o4Q/2vrPbGALmyIhBt9bMz4RHxlto+nVndaSBSRYsuAnftgftpeBpfkDI
	 GTD5m9WzOj9rVxCq6cAOXfrcsJyuc61x67lcKNRibwKO7fsXZ3h0Z0LFzBcJkX7GDe1jyqh1aGed
	 wTBI9XXDTfc98LqbVDtiSoWCU0OMOnPO6dnfWP85/EuM42CK9IQosvYHWiLCnO72T1oTHeIxRyo2
	 eg8gPeCVEyokXynN6bpJDWBCUN+fU31duD8g32iFnmkopPwfmsa0liyh7HFGoB76IKkBTaUidHzB
	 wxBbOvQyrK7XzdFwjsesxiyMPSI3RIjdvDnafr5VxYlZRt9lzF39AoZqO6M3yZwtDZYMGBQwKxec
	 d8rQ3u7yOC1bDZ+HWEc+64P84D37r9tFWBIR1uhkj79nhJXCQWV7rGyczUKaLHJZEk6F8faJ8GEV
	 O+1wJ8U/HKA5UWd0MuPYp5yZPCutBpbV+qQNKNKsNXClbSLWWHMO5EiDQoTNU5DJXHR9AWIyiisk
	 cQi3DY7xIGFaVkPxaxljbCwQlOl/P54Ei5XEafPLmTPMhtmwG8WaeupO/NPzJZu51e6e4IJuH6Fg
	 3Ni3oR8SqyEHrNF/HTEWs=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
Date: Wed,  4 Dec 2024 19:53:11 +0800
X-OQ-MSGID: <20241204115310.833376-2-eadavis@qq.com>
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

#syz test: https://github.com/ea1davis/linux nilfs/syz_0163



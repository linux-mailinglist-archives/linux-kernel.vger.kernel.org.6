Return-Path: <linux-kernel+bounces-263962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7DD93DD35
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805C2B22D57
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573004A0C;
	Sat, 27 Jul 2024 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D6H3/mrB"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1211FC4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722053777; cv=none; b=gHuTqwD16QY2gXJH90fEsxiLVr5Oc4QzmLLNM7aJDHqJdsDr8PsiniLBgAMKwuiuuNI2085E+ZHPIEtS4TiOKBiOmVH3UTcyong1geCBzo0MjTnHHM1ka0fy8KB14JdaQRTFwrU2YMnBOeajx0uonCDCU1ZFcI57/cZJCesJw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722053777; c=relaxed/simple;
	bh=P47ujR+IvPGh1ywT5LQFxhJH0j9637LMj2cRbXuAVmw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hiSbrlMBtv48in8m7J6V2xrqyVZ9R1P1Yd8VYAO5fRqBhz6ftKSN3pkw7rwSObyJ9z1GFHGb3SjDMA2uNYI28Gl01Y5TTnpMsSoFKjlQ8tq8xPYcZ4CSLicz8x2S5/D6Hmdg5riDAhQ6wic0z0S2EH4vLAokQvQfZK8eS3cdo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D6H3/mrB; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722053764; bh=A5NGvnnbDTgn/xYbDpN8E/LU/I7JB5OKeRFG4z95sto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D6H3/mrBz38C9eXym2a+R6hfOOAaOUHWRF4k0LxlkIeZqHxB5kSpz1gF1PZjOX5ym
	 0c1s3jGB4yTMXnE7Yhm8CN1FcyooH/XpUc16Z/jqZMFBK5le/YcrW9UnIEd+x/EYEn
	 FznNTC7SKjD4Bnu25tGSSS8phkX1D3HNLLjOCnW0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 1F19C658; Sat, 27 Jul 2024 12:07:49 +0800
X-QQ-mid: xmsmtpt1722053269t83o3orrx
Message-ID: <tencent_411BA74B731B5425C2BA5ABB2C33119EE808@qq.com>
X-QQ-XMAILINFO: M3vv73qU6a4uQdSPJw5pT7ncb0docvTySqnHTc30O9LQ9DSAc2FYicNGXQ/GuT
	 a8nj9S+G9MZkJqEev5MykEVk3M83+EJycCHaeCHUb1uvONadZ3BLA2GQUfQ6MKMge0yhYxi7Phhr
	 WpAXBvZzue4xRV8g+aRqFFdmX2MyNpgPkf5CNHZogUn2pNON11koMnR0psEVQb33vVbqhpEvDbw5
	 qY9DkkPce2flOgHwDDSZ3Wjt8EHcPynF2YqYmWcToL5dKIfDBQyqa31X7Vemeq58aG8tSXfhP31N
	 GT+6AYwHmo+vt9NacimJRI5JVuXPwjx2di0na+0IMZzTyyHbfSrL30ngpTriQrB3o+1ptr4XqeFT
	 BtblTlmJwZXaE7ADeaKv8MLxZoeW6xT6NKiFsq5t5/tLjQRSLO4wmg1cDiN0x3QwV0+7S0B4NYsj
	 Ih8syyEGweUt2VFZV2sfV3yIlSczokrH9zzer5IloOyoHexS69ic9qzJ3zLuObYzzqDFHyDU5340
	 PHP2dEttOp4a23UrFW4i9cI4uBdVBjjuq1TC01bucxH9UxscwsWE+TbRdwCF0zuOWShtPnA3qjX3
	 pWSaYVFNsV+5lzM1PWkHT5Zs6tFu+uLHZXkL0b4bBOA0hS0cyqP2xuriaUcfQbYRgheTGUITvLUs
	 UsDfcnQ5dTYYkdM1zKmG0FEIjDNTgRWBV4jXCSrd91yT7RB/CLcSQjZ3AZc+gIRE08SwDmdPtBIo
	 5lfSNTsH3hNGO3UeVHTj0kt8R6u4yeMqsemfCULFhDPxg57yAkXo+hHj84VHYv1+IrR69uL7XwdS
	 c2SFzLfvC5wGl7U+o9yeKHKKT7N7Kwz60ncvkVaae3b2ZSSs++q3mvc9TM/7hLwy0KA7SGfqNrM5
	 uX4JMhoK4dLHlcNyMUNuTJk8/AMdMIMK+uoIqVaVVE+SgALT4yAkI=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
Date: Sat, 27 Jul 2024 12:07:50 +0800
X-OQ-MSGID: <20240727040749.2600289-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
References: <0000000000005c7ccb061e032b9b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use s_umount read lock sync remount and shutdown

#syz test: upstream 2c9b3512402e

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c1ad9b278c47..3940c0b11868 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2280,7 +2280,9 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	if (readonly)
 		goto out;
 
+	down_read(&sb->s_umount);
 	f2fs_stop_gc_thread(sbi);
+	up_read(&sb->s_umount);
 	f2fs_stop_discard_thread(sbi);
 
 	f2fs_drop_discard_cmd(sbi);



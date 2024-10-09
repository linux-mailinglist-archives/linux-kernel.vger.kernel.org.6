Return-Path: <linux-kernel+bounces-357239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E952996E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEF81C21B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED613D890;
	Wed,  9 Oct 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w1EHEvxY"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F7126C16
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484846; cv=none; b=Sw6ha8r4iyA+9PenLQRjROdlCibQuuSipJtz/VmzjT39Ndkv+DNp94xKK88ENyR94g3VbwIYdjnF9jtAIgJeWhpxLYAP0m3d5ROFMTlAWuy/Hxo3AKCyJLnDgLFg63vN4GFTPWn6xGxWBrfXZOQnpRPlEaG1bG4CSHJWKBrP6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484846; c=relaxed/simple;
	bh=RbIBLasxXyTzzir1KNgBy499z0WfcI2uuPCp4oDmmkM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=D8yf2/jYjnVv/vF1vu7ifEj0MEdRXBHPRTc4mrXk6htiddoWZfVK2a1eZK5RI/hvCpnMCGIp8dCuS4cSIsSJKdZDXNeNZUdsW5cXDkqMwlYTSPx2I+eN9l1MCjN7Q3r2LKZqm7o5BHiHaZJGnugGw7yTLGoi4g+D72YF8YN4gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w1EHEvxY; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728484833; bh=U4abxGh40g/T8r56klUKiyluJ7RsIX4rNTGWJlHPVWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w1EHEvxYUrbarOErrjXArWVce1qn8eAdBgo4ul7gWC5qqpSuhHPmS43lWx4BTsZO5
	 2QoJ27GsESEFehh9fhW/iq5md2mnW2e3jIaw9KcFm79i1r5WtyCF/+2hzFPQgmBtiL
	 kKPRCZqjil3Ice/L55jZ1joZQH6V/eDjqZpLP2t4=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 840898CA; Wed, 09 Oct 2024 22:33:00 +0800
X-QQ-mid: xmsmtpt1728484380tpozpo6o3
Message-ID: <tencent_71B14BCF1B112524BA87BB2B339C9E6F1B08@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcr57mK58a1uu0qP0sDQVoTy0bE6AAhDxryqVkR3vXqe85Jtnw+IH
	 HZ8VhUYpIxiEvFKHCF0MIKr+wuKXH3LSLZdz+gtngqriyfT0eG8+pTgA/yr1lphJdTajVDKkcdKx
	 pM13Oj3Ra8gswTZ8kowCnXNssM3M+kYlu8mvfjnYJhoE7yCMT9G89uTQ2hUtsl/lfiEUrpdHTkB4
	 ajAD67NkmPCpXNObo7VYJDTADFLsp+tuxndTGeNNnOczjL6s3m08usyp44W4ZaLQmBbUWqQmTUhZ
	 nYMpl2A0eJn1M2aPShvG30YQYiWr+KNHsGlD5n6z5yic01CQmJslabbHiq6MUWh8LmUORWPC6Ow/
	 hBtwPq4oBBA6G/dp0RindrzCaV2MsnNRQ7yKml2ThvhAnnomjZs8jE/84MBDk2hsiwBRuy+IL0+g
	 P1oCKPW8WsMg8ROhoHvaPtobE3slnArgjFFYhej5K2wqFtkJT4Nbc+Bpcm/XlR7wyN+Qb+ZTSg80
	 OGTRXXXlTjg/UIMKZ20JRsYcWxcTTc06zQKlltbsNjHU8GZH6AEBz08Hd9PCzJxpPHnnHMeBAfkS
	 kB+q2XK8dwDAq01gqJ0xReKBfskm3QzLgnWQrmEX/gQhGqlkobFKITWXR6o+16jDxO8jiNHwPtKr
	 Yh70lRGrAaWFJ2mYe8d6QUK0hIcfLShswz67CzoGOj0KgSg3wTXxraap7m3CPMCR8sMnwjbhmO7Q
	 hKU97j4MRbncuzVG49CW4rZj0myL+dktnYjZROOpPCvLUUzW+Irz4SZwZBUJRqqPbUSKF2YyCR/N
	 f4Lz4kW5aqAm9euf8cUUuECODp5gbmUDdaSbw2/HAesDVzIRAKGIWByQqFlsBrJ9SD71VEEwhfFc
	 2nmN1G00JMpXTTecf3f2zmJjtwnpxC9Yf5OVEdn/lmgfMHGl///QEt9Yiem+TsKZSi1eMZtWuQ
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [btrfs?] general protection fault in getname_kernel (2)
Date: Wed,  9 Oct 2024 22:33:01 +0800
X-OQ-MSGID: <20241009143300.1553450-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <670689a8.050a0220.67064.0046.GAE@google.com>
References: <670689a8.050a0220.67064.0046.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The origin fc's source is NULL

#syz test

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 692f81f1e23e..06bdf0cf7b88 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2148,6 +2148,8 @@ static int btrfs_dup_fs_context(struct fs_context *fc, struct fs_context *src_fc
 	 * mounting, and then once we free the dup it'll free ->source, so we
 	 * need to make sure we're only pointing to it in one fc.
 	 */
+	if (!src_fc->source)
+		return -EINVAL;
 	refcount_inc(&ctx->refs);
 	fc->fs_private = ctx;
 	fc->source = src_fc->source;



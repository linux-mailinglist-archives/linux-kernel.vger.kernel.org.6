Return-Path: <linux-kernel+bounces-253632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CEC932413
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B4628447D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE519A29C;
	Tue, 16 Jul 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GWyqT/vW"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F78199E83
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125852; cv=none; b=WMEQiZ4AgipxjNuf0birLgIxPQdTvUgPToES3uV/R7oeG0oEAkhwZLgVOweCOqGQTHVvvQyoI18xKa83EjmQ/mdj2fEMwgTZZIyGEK+kquRgMYR3M8bxLc/NYyTUJQH9Ef/sS1nvK3ThKC9pekrKYTdpnLYGEXLEPNFyAM0CMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125852; c=relaxed/simple;
	bh=g9/gVNxpx+7t2o8PmFGwzhgSGmNVeRe29Vhrb1wQwcw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mw8zQ6So5lyn97UORuCoPmKT0DjFa9wT+ZFUoOKcmNKBEMz+6VVXGqMiBoNC3TmhJ2gWbIwIkf43D41blugd1kaHM5xSTGMVyryKxUFH/YBDAqLG7U5ukagIqb13AiaEppKZmZS2DdMQEIuvkhM/qPZ4z8qxOP7CvYwe0EXEP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GWyqT/vW; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721125840; bh=o+BNYnMQrUCLxfU5llips2j6mfC0NAa8rtMrfluuLg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWyqT/vWaoEp2zuHVd3o9p1dyLEksvL6MoUYHDrTPMFSjlUCcjTJDzv/QYiMbdDpP
	 fr0gRcqF0ViIFN3Jvwi/sLOvCq+gYWriW8QIDArJSvCexdJjvjznMb9FtW3Q5w+mPB
	 nAv3n1XrVuMg82hJQOSTSyMZhl8iUw2YJyX0uoHE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 62530A82; Tue, 16 Jul 2024 18:24:37 +0800
X-QQ-mid: xmsmtpt1721125477tdjzbkjo0
Message-ID: <tencent_5FFE6CF02F716D549514EB16EC6ACC3C780A@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwr6nIzfYme0iGaJnDN/14xU2kEyPpgPnCOZR/hdjivbPfBphZbD
	 BVwRzZTCldhOgF7/bhREq3r0nlao4h+lpJUmHdsF0spXH9D8/CknU7anUIoXGPH6/nXmv2PSUOk2
	 8oRFtoIjfoENyukVIbr/6QXMVbFt0MB7LaJjzdS7frECrxOdya5E+U19M5omXmmtJYMGvygiWWm4
	 JKrgkxWWSDWN1r7I5Wvz2Yq/ycOjr4wLVccwN6jOfiVtxaYn9uSZZ16JjaIB6Ef9+GqaJLW38wRM
	 GzVfA2pTjFFbSelgT/HrmZV9Wp7iWx5OiOiL+vNN4IR7j79hPAxDBHoNp/sN6K8LxutC2yX8T2Rr
	 R8iQ8y/KpP/BwlgcJZnGRTnJ9RQQ043aq6d8CVVb3kBjhZ48DTDSxdK5sLxWkDj8AwXl4yLxVINa
	 Uf32HI32qw0nqPS91czBdgEmwScPe2IEucLebMGpx59xbScMactXWQAQEy9EkWZb5l/IigFEm9BA
	 B4CADbtBUzmdsU7XfhN1CrVkF2bryiTNInYk9CcRbi51eHwVNN5051oR1Quev9VX0psjVzehGtcv
	 avt4OnmysBKG3TncRngK6UADqQvPqnSMUQCA/hm6eN+/9fF8qvDhFQBgAU86lAiH12GNl600NAet
	 vmhfQEUKBz562xkt/fPrtu5Lre1gZauv6nioWLB6o4tSv3XAgOKYv5dx2DN8LSMNhvxTyoBT3owW
	 L9cXHCo3JR5bXTES61DRnY5aQZXt7abOpYkiowpKtO69fqll5hclycEDEF/spZW9yP6ZYAzNesjO
	 cXTMP1+Zk1h4496ov/C/I2EnNjfUMI1anpat5TX/WotwFslWlA0N299sFI5iSC/mjiXmMKo1KeC+
	 E5eSZMIoN0bMSBVY8p4xntTqd0slRm4rX22NBF6kZg0f938awy6iJkE8zgEyXeFxVPI/ogE9+bNz
	 w7SJ8rk5kjwe6nAncR8maLsjsumpnR
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] UBSAN: shift-out-of-bounds in parse_audio_unit
Date: Tue, 16 Jul 2024 18:24:37 +0800
X-OQ-MSGID: <20240716102436.1438568-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000000adac5061d3c7355@google.com>
References: <0000000000000adac5061d3c7355@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

invalid bControlSize and bLength make channels too large

#syz test: upstream a19ea421490d

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 409fc1164694..17081ada6802 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2000,6 +2000,8 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 	if (state->mixer->protocol == UAC_VERSION_1) {
 		csize = hdr->bControlSize;
 		channels = (hdr->bLength - 7) / csize - 1;
+		if (channels > 32)
+			return -EINVAL;
 		bmaControls = hdr->bmaControls;
 	} else if (state->mixer->protocol == UAC_VERSION_2) {
 		struct uac2_feature_unit_descriptor *ftr = _ftr;



Return-Path: <linux-kernel+bounces-253621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C819323E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098881C21FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0E13CFAA;
	Tue, 16 Jul 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K8XGer6s"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476DED8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125557; cv=none; b=MRTxwql5+SjF4hHzYzV5CLRHvPjctoxU2AVe7S3Srfv8mgdZjoX5y9bJBlP40z+fK5KEWl+6lRkdNiHy+3WfbLZfxiTFmi/LnFoq+JZv0XPu0K9/2K8BS5SBm1er6xRAq9jUJuxYMCuMuHB+oqiMfnGe6QWBj+amlS39fkeKnEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125557; c=relaxed/simple;
	bh=IMMynmaMZD5UoVOHpFjtuEI+M7W+IqhZ5HU7zB8vXf4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eAjIEopbBzaNq5Zbqh1B1st7NqqxcfKsfvmgmku5xJaKLpLehiTawjtVWi1A/cjtdHuDI7UIB0CbeKVsfFEUtNsBGIvA3t8ncbcf0lTxQn0DXkDthHPaj18HLNnPFhywO9pWRmRoycAchgaYXshVpygUdHBU8cH1lVq8ryD5oaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K8XGer6s; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721125246; bh=v7Uk2iaHLkkzFkor0GP0IJH0WvpC+ouYp8z5mwVIBPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K8XGer6suxZPORJyUFo5Ty0v8yeggRJ0N9hGQnTU4yqAaCFCyO3AWsq4oUqCGnciI
	 uy9xlu3A9FdKZPSiIypHBrhmFxK+3W84PSbmB9ctoPQHeM1t+66OlbNPj7KlVQBCUF
	 VSpxyk3htVsvm9FQENUTFR25y7VYyPaH9PTOXvIs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 52CA8004; Tue, 16 Jul 2024 18:20:44 +0800
X-QQ-mid: xmsmtpt1721125244tnqmbunug
Message-ID: <tencent_432CC56D1097C8EA26EC0ECDCC787E6CEC0A@qq.com>
X-QQ-XMAILINFO: M1kpU1YLBkcQf6nu3PODoiru+ClEVLn7+itmDirQSXF0eOARw1NxFZL2DfCFTu
	 U+CAk8MvlCR3uebPfhwF0Yzrx+6DyRk3sDH26JHQ60PsR7k2Kl4Pibl/D0HB3SlE3iHbHPDrj5Hf
	 oP/mxCvB0QTY8KBsTFbgv/qCmgw7lwCEboVQL0zRemJ+OhhJp7JH+HGPPPYOj29POa46rnXN/iSR
	 Ow4Y+Vp4aB0OChhP935BQGhk5ffpccO1LbChTo3JyM4TK+ulWffjTbGzROr4d5STi06VhbEOGbpB
	 s+Cl21ax9oe/PC+0T1Te9YUV9ojeBsAqkThAS5qqT7w9NnKJrlQP8KTg3SZY15yivj0ewDTEVde6
	 5OLLkGkRlDGiYA1Nigw3e8gTSfMbormnWbEQU2VE6CaiEoQ+U3CLeIcot0Fo89MUCx2VMaXnzX59
	 OVgICxAKMaVvcOjrbgmx7hQiwH/xRtyY2uKoumYilQ9Bp7Qj4EJyD0ySSHPildrlzsFWbe7JE+Kj
	 gZma6eofKVoQKkZgok5ArT6EcpFCHG99pDpDJo3UL6zcs2/sACyZhDppVB0ul3OnRtJ7n33hhXbu
	 8Xd/h4CQ7BBI9kEYiA2UrlVOZkLmo8f7OIzuwMePa6O3PlsmuLe3J+8M71JTruTmWHxoLel8RDtD
	 GwOuIZDC0GZgq9PnSVRaRFeO1X6NjFQeASpDeTeH5SWwUfDzxrfBO53+HRRGXf9kP5UeJnvJj6BC
	 1afsrT3NyUOC5Y1R58xcmlMI8uu/gPDyL4mBoJ9uh22hlFs/qtxhkcE7NJ2bWPiBxRsbV0i5XCiz
	 nCpxN+DkmBHpB2vtcWXr5vmn8aTbxUKaoFxqYYIVwKh95nX/+Qt4Qz5BBxX23+w0Yq90UHd7qilb
	 PzwK+N76poqcyqlqDiBbtuunyicqzpsXaDkPDMXV0r22zgVaSSjw6yRSIaEeGpfan1LolpQd4PVQ
	 sG+K5Wo74qFCIDrq0/317aJaglxzab
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] UBSAN: shift-out-of-bounds in parse_audio_unit
Date: Tue, 16 Jul 2024 18:20:45 +0800
X-OQ-MSGID: <20240716102044.1434498-2-eadavis@qq.com>
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

csize is 0 ?

#syz test: upstream a19ea421490d

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 409fc1164694..8e596af23bee 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1999,6 +1999,9 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
 		csize = hdr->bControlSize;
+		printk("c: %d, bLen: %d, %d, \n", channels, hdr->bLength, csize, __func__);
+		if (hdr->bLength < 7 || csize < 1)
+			return -EINVAL;
 		channels = (hdr->bLength - 7) / csize - 1;
 		bmaControls = hdr->bmaControls;
 	} else if (state->mixer->protocol == UAC_VERSION_2) {



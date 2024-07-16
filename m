Return-Path: <linux-kernel+bounces-253409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8607E9320E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6391F22D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D81DE556;
	Tue, 16 Jul 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j9Ua4R4f"
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C71CD2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113545; cv=none; b=rC5utTZry7pjTFsgWtUYph8CeOw3D4b/b7RSb0M+Q3ZTAGiue8I2Gnn/+3tVsGgAbhbWIbNlGS9bmZ2WTk+dpl4VsTXM5KjFovNU5BRaNKikSmkcwTY3U/O5dmLPCL/+yqEI4cfhy9gpzYEjzKirJbcj3jaC+yTBPfZEjWH+nVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113545; c=relaxed/simple;
	bh=Yh2CmY3N3+OjfK5RwxyGTIiHTrCDpXj/R20kLhl6bS4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rfauZpCUplB3yBUtKEUaWCG3QvuxuwDBY/hDFtoRj8kk90naX92YHAt07lDMy8z5jND2lDuiy1I1ApFqT3on4FuWtkqM3oOaRoau80TqViEDSGtkWhCFbXz1QUzl/aDSMtJxzpT4f0v9oVGbg0gG4s7YnOjqqzEXUeUAEcainFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j9Ua4R4f; arc=none smtp.client-ip=203.205.251.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721113534; bh=NSayFqacRMBUWDJVZ0as8txNYyLVDeedURN3J1azUc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j9Ua4R4ffzHFus68cRNjlOo6sS90BzC2oUW1wxvvW/foWzCBIiX/+OXgK9U0KDshs
	 mFCS+nt1nAKwRb1RTeRBFVRhhSVl7ddTPgbfCa8GTBu0QIq68ROy7SOiS1CxH8O4ku
	 UmlpvRYoqmVikQNg8p9l9O01ugMMmpcvOmc+Jh+U=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 1609DAE6; Tue, 16 Jul 2024 15:05:32 +0800
X-QQ-mid: xmsmtpt1721113532t1ve8cdpj
Message-ID: <tencent_9FA26F1C2CBD6D889734E986EDE6CDC47A0A@qq.com>
X-QQ-XMAILINFO: Mf8g04NPjwMMyyKErrPucDSQ2VlnEOuc3er+1G0Zmh5trhuDZVyqiHmxBa+ejG
	 E6cSYy9qFy2jCoTWwTCV2NQ9d23scabajUTXwoPMl7VAmha/5lbYalzN/RIhv5AneRDpDAPie444
	 cA2LwQ6mLvCZGZETX3bHhiPPpY9AQ3AkjR97bsBrdZwFHOo9iELD3SvwoxIJGJ9BN8uzdri11PXR
	 n9ZOoFz2AGTDfMq2osNfLgIwhORF1h4McVS6NrNjAqTmxg+cCMZFk+s26EpNDUw7j5G+r9BBqeFc
	 lyGD3zHBTON+RuFtQnsfKJZZF+OdWLafguNMAwSVSU54NDcgcBVa8OfgLbSaeNm2T2YUcI6fmi55
	 DbOnGXL9Y2aJFX3zH47qFeaSdY7gSZX7rimJDTcXMCrJV9xiojKRypj6xxdD636Khw8sQi8vCLnu
	 RirjzKeQPTAAeaEkPBypjLI3zaFxWyrQyW4CHvYzPptw2nhN8F4VyQD0mxH2l8OnEib7XKYnTS+j
	 QX3C9iNNkFZsdmDO6Aks/D2uG8+9q3CcQ/CWeRm+el1qMEA2SyvwgDveBnEuHDJ5GOYegm0rcoC9
	 75siRmII6fMH8+npf7aBrOppdF/25EqomB3oYy1cfN5kWTUIzCYlvYC8Edd7RM4mwocCkp+BfrC2
	 8Kh7bwx/j5hLc8uRUDsxeYd7C3rlYAYa14khc5jHKBzKLSMz8hUZdwCxF0ohEiKyVJuuXueK8eVu
	 kVIlmtyZaR6T0TlAtDEU/2qJVUVwDv9s2Hzsf21fhu8H8xWyBysXmIQWbkkPQxMbSjDCUp0WUhSF
	 PCtDi8TnsxLjPbm2WWXeva+ymB6GhMzXn0udMchBPuAnCBYel+kLFDi6LZsnfrYeknBKwhEioQeV
	 5IhOmeIz278cNQ7ygn6Nm0lEkWeO/5Tg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] UBSAN: shift-out-of-bounds in parse_audio_unit
Date: Tue, 16 Jul 2024 15:05:33 +0800
X-OQ-MSGID: <20240716070532.1246135-2-eadavis@qq.com>
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

bLength too small ?

#syz test: upstream a19ea421490d

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 409fc1164694..cc92c989a772 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1999,6 +1999,9 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
 		csize = hdr->bControlSize;
+		printk("c: %d, bLen: %d, %c, \n", channels, hdr->bLength, hdr->bLength, __func__ );
+		if (hdr->bLength < 7)
+			return -EINVAL;
 		channels = (hdr->bLength - 7) / csize - 1;
 		bmaControls = hdr->bmaControls;
 	} else if (state->mixer->protocol == UAC_VERSION_2) {



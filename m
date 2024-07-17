Return-Path: <linux-kernel+bounces-255218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E9933D95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1A28243C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072351802D1;
	Wed, 17 Jul 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="whz6U+uB"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1517E8FA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222832; cv=none; b=TZLAugPzf1T9sXHHiuIjBN64nExQy/BIXdYDwR6KbZ1nZGYs2VJFCM7IV9PwGuv7X2elwtAqXrIkpCRCNiBlgztFFjDOEzt5Z91j/gC6iANFPZEF/XbEQA6GcqHWxE9eXzKAkn3ZBadz7bz2EnB9Om8qvNK+5Ag22fCE0MCt6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222832; c=relaxed/simple;
	bh=y3T94ik4vqnfJFhwAd4PUtX/+7F1AFSGrkqfGE08IaU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ja+fUOBP4wRtIQoA0kBzhmfQAowgrhRaICIu6arws+iHsKqWAcNXtlHszQIQH7sfhQOgohTJOJgq4spQsppf2CJGx9R2a7KwQZwETzujUvcSJ/PIXtiuiGigFBfVkClmJaglWoCO9r0L7LPBRYdFkxHlrQRw3TVC4qxUnZdYAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=whz6U+uB; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721222820; bh=NLnF55HcNXw8HA4AznZe6/4kQcVrpT6k2AhIIhEB65A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=whz6U+uBWefaO/L6oU1x93kIzPPz4zNX9JkdZA/KtbxPF/m+5WGBPnNRGnpv2NRnK
	 b43FkyZkgO9/YXuS24PPPTZ6ADxh0O/24eY8t6zd8bL+5IqSdO4YpWaR8LZva+DOtn
	 Vsg1xgrWGAVkxqm9ZOZSfD4m92h9G2ibCOSd1E9Q=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 4D10063E; Wed, 17 Jul 2024 21:19:17 +0800
X-QQ-mid: xmsmtpt1721222357thyof4kmc
Message-ID: <tencent_B8E916EE96CCEC783A6F182C756C2094800A@qq.com>
X-QQ-XMAILINFO: NZuv37oEiaZl37t+TI8o+BBxuef2lNvk4/CGwKtFusTjau+oitqy4JuMZSQkaz
	 kIPQm5wfnkx9A4O4sPZePCv2mrYtz5p2FJ22y7XlLEDfGEd6Sb9wToLPodrwwnkNzkynd93sEymT
	 TkgAGZG50/J9pQuQ13jGaiY7/8IoNQzwVEDP8PM4Ni0jZbpsvAcGW1Z501VPIRR4VYekgcE8hEoF
	 kGuTX1HvJEV11muZbetR+9n1pjfH/xkgPFFSR3H2j5ubifm4kRI9BPE7o5aRoLaWQIg/ZbPLEe9N
	 uAZ7KUECHEtWgNAhUDMZKcjyBasFUYwKZO7o9cpc7KmGMQ5YXiaHC3lcqJnZYBIfkOWcif1um19x
	 3HmazutEJPcjeyJqfnYl0VB+cWKJogNjywFFCzuJXC8rj12dBJdAxPiFZxfd31G+fDto0oAQRx11
	 3mjBah04cfjcXQMiE4GTCIVWCXtHzRusZtAvSot1ymXtezCi2ZV/FsLxXoCTBxyx8l8Tvy3cABfy
	 erT5UxwenhzHES3K4/z+tpuG9AkSWDcgxqp/pabBfFeDlmimNt3OaLMS5uroszDue2wXRJlhrrUx
	 bkEGGxZby4DYk8LqI9NZ7VKjUX7JJOIbaVFZTuhyz8OTUst5ZS1ymG0EJk+mbcbt58XGGHQdUm1b
	 xbQlfSQ8FKKW/ciclxVDINXPgsgq67UIwnmTbYBfAoXNoVNjdcCkYEE+kqpkWWVYpYdDKZn5p/UG
	 9dNTW7dt6saetWtC7WUfIrQr/En/RwF09TxEbUWiq04Diw5uvBJa0X/n8B441IxPYaJqtG/C/m9L
	 F/dlVaQv0QWe67FO4qCTyG7a6Aa18WMxFUHSuBU1QOYNYr0ZRFYBHlP8wddlj3H0JyZM8gQIsEOz
	 Uua2JwHkNcMw7MSzrK1sozKKkXipJLa2+ZWq5dpCWUkEqPKPrhnGyB9pVT37gEbg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
Date: Wed, 17 Jul 2024 21:19:02 +0800
X-OQ-MSGID: <20240717131901.717031-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c6453061d53bc0f@google.com>
References: <0000000000005c6453061d53bc0f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

before remove debugfs_dir set reference pointer to NULL

#syz test: linux-next 58f9416d413a

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..6d807c3abcb6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1473,7 +1473,8 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 	cfg80211_del_sta_sinfo(sdata->dev, sta->sta.addr, sinfo, GFP_KERNEL);
 	kfree(sinfo);
 
-	ieee80211_sta_debugfs_remove(sta);
+	if (sdata->flags & IEEE80211_SDATA_IN_DRIVER)
+		ieee80211_sta_debugfs_remove(sta);
 
 	ieee80211_destroy_frag_cache(&sta->frags);
 



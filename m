Return-Path: <linux-kernel+bounces-401638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0039C1D37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312541F24223
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E51E8858;
	Fri,  8 Nov 2024 12:43:56 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77C1E572F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069836; cv=none; b=flgsDfUocrKRZS5CGBAuNl9qsNcGwJBd/Tnk1LY1HopWsvgA6rpvjcCl/nxeqzutvhrD8wveknlytItUpWdkL4CVvS9VzNWUqKeGG1B5tx0fmfQxsgxZ0g0ynYRsnG1kT0ba75kKO5pJgu9zTbh5uVV5/+Gjlw7yNsJf6IQIJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069836; c=relaxed/simple;
	bh=O1Z2X1bvmbG8sma464C+xGq2dK0yZZUwVzeSi5naq5U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jdi8x6DLixXvcyFS1FYhrHIAhtsjEMGnFf29nM7PGo3BZgphHB4cDZQ/AvApW1d4TsynEcv6ON7WtXrYb0VpE9RsCYBS/vLrw9vZbYTZfCyNaLEfwkuVzFIjvmeRrQWdl6XRX4iKkvI5OpJ/B/YTWfk3CTzSQOOoT2HTUnbyGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6f3a08573so5894095ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 04:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731069834; x=1731674634;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eeJAjAmfv9sTsTGdiWb4zBDLz9iJ4UF+QDkia1dsKU=;
        b=hv3Tg2MuBEXfBQuZrAfA2LlzxmV7vwtVT3wf2s0duBa9XHM0pH4TFad+2lasT6ff11
         5pNTQMCN7sbPX9nxnVCITMRviw6sgvqgVkPxgNPtj9I3SsXLnjyHn8Vt6kd1oi3FYgqo
         206Uds8SVJtaAXXB+rh7yEnWMOpltBBN/1BLOYfTagoBFxfqB+wQZh367Xnjp3ZEsWSF
         zZgk00fBMx9Z75odcCa6fshtXHSr9RqV6z2Aa1T03LgXtJBN8auzCpTBwjJhhF4RbjRI
         vqMvKaWlGZjLsUSREN3SxURYpgOSvQNaS5mZpwlQ8dIp5Jzpdbkug8Jnz7xWB7suUOZr
         J6Vg==
X-Gm-Message-State: AOJu0Yy3T+7XlAeK6MzU6q+yfBv6FjL2Sv1McdSLw19d02cxlHPVE7zt
	GdMgO5MmZWSRK5OBybpkzkRVjrSXe/SJtIiXVNx3JUej5c6EHiJyCWGr5LIK/rrwnI8qcz8Fuds
	C0p0+sWkRVX2EvPXBKe9ihxH9ui8bujsReZMlMkFyH5ilgIxyipIAwis=
X-Google-Smtp-Source: AGHT+IEPyvfY1kXvlIbkMmuK3MitVukZrcm5lakwJE+7Gkox7Yu6X+MjDIm/Jo60kr+XgPy7tjbOYGlbqk1YNVSS/PpWCq7GbK5e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:3a6:c472:765e with SMTP id
 e9e14a558f8ab-3a6f19c9f3bmr35213325ab.11.1731069833816; Fri, 08 Nov 2024
 04:43:53 -0800 (PST)
Date: Fri, 08 Nov 2024 04:43:53 -0800
In-Reply-To: <672b9f03.050a0220.350062.0276.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e0789.050a0220.69fce.0014.GAE@google.com>
Subject: Re: [syzbot] Re: BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: BUG: corrupted list in ieee802154_if_remove
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 906bd684e4b1e517dd424a354744c5b0aebef8af

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 08dd521a51a5..7afcea3447c1 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -40,9 +40,8 @@ struct ieee802154_local {
 	int open_count;
 
 	/* As in mac80211 slaves list is modified:
-	 * 1) under the RTNL
-	 * 2) protected by slaves_mtx;
-	 * 3) in an RCU manner
+	 * 1) under the RTNL;
+	 * 2) protected by iflist_mtx.
 	 *
 	 * So atomic readers can use any of this protection methods.
 	 */
@@ -101,6 +100,7 @@ enum {
 
 enum ieee802154_sdata_state_bits {
 	SDATA_STATE_RUNNING,
+	SDATA_STATE_REMOVED,
 };
 
 /* Slave interface definition.
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..700c80e94bb2 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -669,7 +669,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 		goto err;
 
 	mutex_lock(&local->iflist_mtx);
-	list_add_tail_rcu(&sdata->list, &local->interfaces);
+	list_add_tail(&sdata->list, &local->interfaces);
 	mutex_unlock(&local->iflist_mtx);
 
 	return ndev;
@@ -683,11 +683,13 @@ void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata)
 {
 	ASSERT_RTNL();
 
+	if (test_and_set_bit(SDATA_STATE_REMOVED, &sdata->state))
+		return;
+
 	mutex_lock(&sdata->local->iflist_mtx);
-	list_del_rcu(&sdata->list);
+	list_del(&sdata->list);
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-	synchronize_rcu();
 	unregister_netdevice(sdata->dev);
 }
 
@@ -697,6 +699,8 @@ void ieee802154_remove_interfaces(struct ieee802154_local *local)
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
+		if (test_and_set_bit(SDATA_STATE_REMOVED, &sdata->state))
+			continue;
 		list_del(&sdata->list);
 
 		unregister_netdevice(sdata->dev);
-- 
2.47.0



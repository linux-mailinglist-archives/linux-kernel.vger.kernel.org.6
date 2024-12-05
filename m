Return-Path: <linux-kernel+bounces-432840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5F9E50F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12A31648CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F311DB356;
	Thu,  5 Dec 2024 09:11:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC951DACA8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389864; cv=none; b=TMkq3VaneluhVW+xWT8PEtz6Pbp4Bjqj6WkyE8e0qH7dL4kiia48XHyHlj2+Li0Dum1GlSJ3MgVr7M6vhoKqDgQ1U6w5ajHn4EvA5GfjQGKRymM71jMFq6y8g1LV4mp8W+IMft89pZF0F0kSPf0AoB34bMwiITaKEs6X6F8b9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389864; c=relaxed/simple;
	bh=TlCoupkFkvQPlX70dPVoOzhDW1wHsqHgJMRWHEJPujk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WtDxGMAdvKpInE/gcBLhKG7pFB0XjKU9/gvFwLDotSJcucBXy64uKW9rZxHrqXVzy1M4eP2v71UHXbID14RLjrJTnmEABQ24pXaCkZ34DHZnPNXLXwwLBqR4E7zt3Xg6C7WFbT6ER/c5IM2mpMvkZGfM8DWj512f4oF0CDtqNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77085a3d7so7196625ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389862; x=1733994662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNsU+830Ay9pksXAK3MyA90qMDviLMmJurZcS1tT2aA=;
        b=h8Zj+aPv98Gq7neYsR2YpGR2ePDPDGLo6lYjFkkzF64d5Bp5HK/qnPwiA87KQ87xC2
         Dmrufvz6FSrmJhi82w+QvjbMm6QpYrAn6r6xt7frhHayRVlBeArwxzRICidWjo/v65T2
         Wp7AqdEa78/IPDTZAa9CDkds/SdWjOK45lR0JD13Qg8V2OJ/bezIB4lfrwbrMqkc1QQu
         OHji0S5h/lIQlG8mGjBi2w02Kgw+aenw8iiYM3rXvwLHtWOY+Dhew/v+RNrCF7yAKE75
         Q8GXnf5bjiYp2f0/NZ0b1nMT6AU60fxK2WygWztEwkScKwUzNoM4MVcX40TpZa9IZwMC
         4O7w==
X-Gm-Message-State: AOJu0Yz1POwEWbu9Nid8ESl2/AQBVh5Y2SJoY8/xXMVTereHf6oVA1fk
	I4f1y4JoyVXrAYkXWj67ZJ/pRr5eSgOwJgIrsJwJIoqMLo9pF9+YAgV9x3JilsmyagqxKr3TCxN
	+IzxAsaTyjQ7Bq8gPdzZePX6U6XVgHWIMuNOQmtvw6A9ZKCJ0k9liOws=
X-Google-Smtp-Source: AGHT+IGP/CH4p4EeXJCEFyvCYAJU/EtAB0mfI93Vr1chP+Gwi7nmVFzgzqZ+RE16xjjAWTvVg7CPH3ul3imY7a3EcKFMP5hJcug4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1888:b0:3a7:e1c3:11f5 with SMTP id
 e9e14a558f8ab-3a807592ca1mr27847785ab.6.1733389862306; Thu, 05 Dec 2024
 01:11:02 -0800 (PST)
Date: Thu, 05 Dec 2024 01:11:02 -0800
In-Reply-To: <00000000000069859c061dfa7e91@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516e26.050a0220.17bd51.0093.GAE@google.com>
Subject: Re: [syzbot] [PATCH] TEST
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] TEST
Author: xiaopei01@kylinos.cn

#syz test

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b31192d473d0..bbc86b7dce07 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5519,8 +5519,12 @@ static void 
mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
  {
  	struct mgmt_rp_remove_adv_monitor rp;
  	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
+	struct mgmt_cp_remove_adv_monitor *cp;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;

+	cp = cmd->param;
  	hci_dev_lock(hdev);

  	rp.monitor_handle = cp->monitor_handle;
@@ -5540,8 +5544,14 @@ static void 
mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
  static int mgmt_remove_adv_monitor_sync(struct hci_dev *hdev, void *data)
  {
  	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_remove_adv_monitor *cp = cmd->param;
-	u16 handle = __le16_to_cpu(cp->monitor_handle);
+	struct mgmt_cp_remove_adv_monitor *cp;
+	u16 handle;
+
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		return -ECANCELED;
+
+	cp = cmd->param;
+	handle = __le16_to_cpu(cp->monitor_handle);

  	if (!handle)
  		return hci_remove_all_adv_monitor(hdev);


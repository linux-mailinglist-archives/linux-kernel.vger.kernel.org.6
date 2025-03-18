Return-Path: <linux-kernel+bounces-565336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F3A66617
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4454E3B3FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C710158DAC;
	Tue, 18 Mar 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SCP7gDZK"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E830100
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742264071; cv=none; b=nFUuAHn8Bei3kkN7ENqWBjMi2Q/qUDhBp6yR4gQmZhZnjz/fm+WZ6AosRvqXy0D2u+taS6kNmLJIQYYv7Oe7pwO4uAkBXoVbfuWiqThOpXTibQALjl4qEmOLgvMlVKloSqH31IVf+o2TwWQ6bkRcXy9107BxTBISwMMWYbeWfPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742264071; c=relaxed/simple;
	bh=OdWJ8tAZiudWlId/DUd+EtEq63ShFRHxzmA+Z7yEBX4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Otvjs0Vd5JFrfDDQuB//aweWabIt6Wzczf3lkf80YB9RGx/Mhk8jx4TgnZzQAV59h0W0Q5rZG98rxoaW42gvfnH+W/IW0IA1c6TdnFQLyv+PD/WjkiEFiII16asXHudSJ4iU8a36mDw9qqerwzQnsxX0GrsxNKsLirxU/54Z+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SCP7gDZK; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742263761; bh=t1mV0qZFdu8S4xqXrWIv3+ZKFldyuxpZVrVHUBZjzek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SCP7gDZKvjBnLJHafI01ImqYQwefxGHcJD4edBsaYXUsd54wd8w9iTvbmqSeG+A0y
	 wilrnilhpEYFZmHBC6NB7st+JpRmSGZ5bE2/D9TuBFRLK355EcFONf5s7USEw41oC1
	 9LWyNMsURFoql5QpmInb2wq42uC5h7Q/UOO0ooWw=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id C994055; Tue, 18 Mar 2025 10:03:09 +0800
X-QQ-mid: xmsmtpt1742263389tzbx60142
Message-ID: <tencent_DEB361637AE96D43A8C447D77D577626C705@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u8GpKjpXsHsULpQapvn4bCc7/+FpnpDeqildDScpEAMeerISAUX
	 azq6mbYJMvM8DRHILISs+NaL94MawUCWfwl0NBF/fxpx5arH/Ff2oT51f/PVtmwB1xRJF43oYGO1
	 LG2zFSchfYscXWQlWd9Doztje4A8YkX51E2Zx4gG0nQRRdfLvLIei0dCuBHtzNfbvG2lhWOQW/AT
	 qLrEVCKoCghm0cjBlcYXTqdW6fRSQ7PMffcD9k6GPzDM+puURxy0bWT1cy68ecYfDnBMedLA+amE
	 caBqa6g+I0wo7jZy8Z5L+d0EDQhFlVPxRKqAHmyv1fhaCDjBlKi2n74oy9kDtNiGrkBaPpSbOlk5
	 2lw1Rj3+vjKIhUUusuLTupdhaQ7b7Lc8k1TNH6qGy8vsg2X87+cdFgl1rkYLMmOlbyxpoT9aUz8Z
	 2mOmCkj3aQmWhnmzmHwW+5FvK3xXmJqjq0wXa3RjPRqkStKcZX9EA4+nYPvis/89ksr90mwtVnSn
	 J8KhRQhIHIA6WAdqsEhoJIgrm6EWpqIhMOg3Ppm19ofbdtXSV/Qul5P1OJEA+mw3chpdtPyma1uu
	 bFS2CU73F3Zgv+dBd6EU5hH8hOgzY/8FlA4700+8j4TCX8AKuaotlZqWNjn+XAPHlptAno7rrZuf
	 t2YumqBDVdkYjuLWfYJUtAXwGnZoX2CjcRcF1zoMkbVPJ9i1d9n7No7aikwllxZYo+cXGqAItavB
	 2vclFcGwK1av0iSvwleqDpL9muhKzpFqrqBxUpSMOIRM4oXKaI5FgSgL40N5KjzWQKd8qUfiTTAr
	 QBj4oAyJpBfl8gZRvK0ul4ucbgP9ZvxIEwHiyT19i8ZIuOrhQvYLxB4y7IMX2JcAbwiUTSMAeJj7
	 C5/7U8fvEBu3SWgOcrNDoruJg3NzA6321pZpoQaz40fXoNP3J/QuwTR2Y2ceTGk1LfxjlownicCX
	 Y1x77tXQlWTEkrlbGKUpykEold9VRO681GmR8YPKw=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in cfg80211_dev_free
Date: Tue, 18 Mar 2025 10:03:10 +0800
X-OQ-MSGID: <20250318020309.3042770-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d8804b.050a0220.2ca2c6.006b.GAE@google.com>
References: <67d8804b.050a0220.2ca2c6.006b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 828e29872633..df3ea9ee3ee9 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1193,10 +1193,12 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 	struct cfg80211_beacon_registration *reg, *treg;
 	unsigned long flags;
 
-	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
-	WARN_ON(!list_empty(&rdev->wiphy_work_list));
-	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
-	cancel_work_sync(&rdev->wiphy_work);
+	if (rdev->wiphy.rfkill) {
+		spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+		WARN_ON(!list_empty(&rdev->wiphy_work_list));
+		spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+		cancel_work_sync(&rdev->wiphy_work);
+	}
 
 	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {



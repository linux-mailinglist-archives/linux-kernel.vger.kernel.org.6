Return-Path: <linux-kernel+bounces-563886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9FA64A18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211AA1897035
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22294226CF0;
	Mon, 17 Mar 2025 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="kVRyhvY9"
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690222257F;
	Mon, 17 Mar 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207526; cv=none; b=Suh+E+aGUWGwccMUtZ6PY1eARhaNdQABh+aVdVW75Z1GeOlQrz06IT9fihNcfYTGeat42qO0+AJqR1q1blrUmdAsoNM45F5D3zt7OOZQVEgZj6tjqL6ZGduLntAsTbMrPcajEGzippGjtdZ53wmLTTjCOuMRY1vLhStcLHrfsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207526; c=relaxed/simple;
	bh=jET+Zyh1y8nrRIS3OXbjRZuZGNjL5oCFgBMDHxziibQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pC0Z2/J28q7wMauzv4BZM2a3zFhaVKo82J0xJnhvb9QowT4IiTUElLJ1y2t1Mri++t7Zl78IYgLVqP498sQR5mgVGYQOW4EEHAyC8mkGDV7d7/6oP0CviZu830c9duCzIKXj7MZ7wyzaSsvVLv+jv3pZDFcMXeDdFmfI+8KmJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=kVRyhvY9; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id DBE6B63C27;
	Mon, 17 Mar 2025 13:31:50 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1197:0:640:483c:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id ADAA960D7F;
	Mon, 17 Mar 2025 13:31:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id fVEFdrTLmCg0-Elyelz8t;
	Mon, 17 Mar 2025 13:31:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1742207502; bh=BMnk+T7PyZ+YAEEVJakHyC7Oto5jKGTwpp7qVFsesHU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=kVRyhvY9di75KJ+gGbP/RlmdrvxsBo+RByiEIUXoOE2EUMtlOQGwgqAUi1A7npHNg
	 4Jlw8LDpMRWemNBfRCzc2bFM+EqMAL6hUP9omH66zwXJmu8mcDWsvv9eNCQlQ51K2E
	 w6veXbyuQLv1SzdPo5OYxrbV7hhdwC+Rn6A6whuI=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v4] wifi: mac80211: check basic rates validity in sta_link_apply_parameters
Date: Mon, 17 Mar 2025 13:31:37 +0300
Message-ID: <20250317103139.17625-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When userspace sets supported rates for a new station via
NL80211_CMD_NEW_STATION, it might send a list that's empty
or contains only invalid values. Currently, we process these
values in sta_link_apply_parameters() without checking the result of
ieee80211_parse_bitrates(), which can lead to an empty rates bitmap.

A similar issue was addressed for NL80211_CMD_SET_BSS in commit
ce04abc3fcc6 ("wifi: mac80211: check basic rates validity").
This patch applies the same approach in sta_link_apply_parameters()
for NL80211_CMD_NEW_STATION, ensuring there is at least one valid
rate by inspecting the result of ieee80211_parse_bitrates().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from station params")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
v2: Fixed the patch subject to provide a complete description.
v3: added the missing if as Christophe Jaillet (christophe.jaillet@wanadoo.fr) noticed.
v4: put all braces into a single if statement as Johannes Berg (johannes@sipsolutions.net) noticed.

 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9351c64608a9..b766472703b1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1908,12 +1908,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	}
 
 	if (params->supported_rates &&
-	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &link_sta->pub->supp_rates[sband->band]);
-	}
+	    params->supported_rates_len &&
+	    !ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
+				      sband, params->supported_rates,
+				      params->supported_rates_len,
+				      &link_sta->pub->supp_rates[sband->band]))
+		return -EINVAL;
 
 	if (params->ht_capa)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-- 
2.47.2



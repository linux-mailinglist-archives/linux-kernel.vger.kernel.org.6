Return-Path: <linux-kernel+bounces-301464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D317E95F14D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8AF28499A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B216F288;
	Mon, 26 Aug 2024 12:26:39 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325C13BACE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675199; cv=none; b=pxvxDFsjrW3IUjeXP1vo561MJX094JS5tYeWh6BgoxREbED79m6Pc9keo6InxLNsP69VIuixSpJtyQPmUJHIqBtH1A0u3zxAanfAKy+jIYYoTNpSAsdT11nkTV66NK+oHHfAEksWi57qgpX3x3JFPXj6IWRBc0utsNoMNYYPh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675199; c=relaxed/simple;
	bh=ILLJM6RT4q4jfjH8YX//u+2bOf4UsQTUbUTS+FE2PpU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qDgG9zLh0SHYwFzq8HtGXVRSYBKNqkO+FC3ElgNiw0PHv2qPvkvj12r8jCFl2OxHIuiCZVCzLPqY8QYm+zsXlZK6bjgGpbMUx1xc/9unPPq/trkt1G8JQftbmFSEcnTWnpNT2eauaxic5ypR2euwmO9snt7FSpLglD8A3kf/Qdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8e43f0c1so461995439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675197; x=1725279997;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CloXOlj+hd1++BXstG2AGBsVU2CUEZ3qs2JRLwsutf4=;
        b=fbGxbt91p7zyPh5IfyzS54UIaMNK03i4Ybgez0KYtX1LJPfcWtGcH/vtxz4vpqf0fO
         u8BIejMZzKf4DF/njCMa1WOb/XmPYu52XsHoG+OPB9J6cKfAlvjMtXRdNzfwnaA4svtK
         hrl/mKRkNmN8fZs3voelN5I9DT24A14liGdQZ9KSr84csgqS3yVODZFC2K7KNi9uG+P3
         xy/g/S4jbCGsxXmzW+FG5wf+H57ZFozImubEEYeEaQpEyN7+gtfU/llHMRgtfPwva8Xm
         HXn/CIE2+mn4dSBP43yabNe/CoxAgOYW4hLqMUbsboowEbJN003rAEpzGJ1oQpXvrQTu
         i31Q==
X-Gm-Message-State: AOJu0Yz9E96VdtbQc6SRbRSJpoLim/YRMgf8pX5s/+UUmGIa9YyFi41O
	tX5vxzyDGcoqvtF0Kl1nUwvvkHVvWiNOhj7D4nv5bTqF0TlM4virflcccdptA3KIrp0GGQaYbsM
	HLBZWGkZeUD0QnZp9W4c9fZkdffP6oOii+67bwKxy1DbzSGYPU3BEBtc=
X-Google-Smtp-Source: AGHT+IECyzVyDX/yEFbpUGYyX+XlqBDrvtZt7iKrIUeaG+oUBHan2n7bT8U/yN6ZsyFpNMyNhd7ZqnA5CazfB8BhZmutyws5PIAc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3782:b0:4c2:8a0c:3815 with SMTP id
 8926c6da1cb9f-4ce8286180fmr429437173.2.1724675197129; Mon, 26 Aug 2024
 05:26:37 -0700 (PDT)
Date: Mon, 26 Aug 2024 05:26:37 -0700
In-Reply-To: <0000000000004168390620923787@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a6a700620953c66@google.com>
Subject: Re: [syzbot] WARNING in ethnl_req_get_phydev
From: syzbot <syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ethnl_req_get_phydev
Author: djahchankoike@gmail.com

#syz test

ethnl_req_get_phydev should be called with the rtnl lock
held.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 net/ethtool/pse-pd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 507cb21d6bf0..290edbfd47d2 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -226,17 +226,21 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
+	int ret = 1;
 
+	rtnl_lock();
 	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 
 	if (!phydev->psec) {
 		NL_SET_ERR_MSG(info->extack, "No PSE is attached");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 
 	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
@@ -244,17 +248,21 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
 				    "setting PoDL PSE admin control not supported");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
 	    !pse_has_c33(phydev->psec)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL],
 				    "setting C33 PSE admin control not supported");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 
-	return 1;
+out:
+	rtnl_unlock();
+	return ret;
 }
 
 static int
-- 
2.43.0



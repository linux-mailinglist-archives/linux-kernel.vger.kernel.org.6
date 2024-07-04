Return-Path: <linux-kernel+bounces-240915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF2927483
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C627328150F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B413C1AB51F;
	Thu,  4 Jul 2024 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTVUNL1P"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D9F187567
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090980; cv=none; b=ednZ/iGO1bzkkgdBxBh6oykhhnvTWHkuIz0Uyd+HJc0emnO7ltjzUjAT0dtol2yX3N9H9yuwV1Agx1EDDhEyrmlMSELwX7RLuQ7o8+TF9KYjqkEf9/aW6RJw1BGZzRJgsuSM4MTtyHPIllMI6Q4w69wB/5GhDEW2Sq4usjyxQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090980; c=relaxed/simple;
	bh=bZkylEs+91rx3tNmRN/nojKjDtDHx9LKGC6bJk+imnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxMwNxQs4oQXHSLpdRJJCbKlVgiQN2MDZO7sW2OxnJhBN2UsgbtjchM5JUwMJihX/HDu7EnPPreWaqlo6RfpvJ/qxNuoElmfay4f5LRXp/zE7zzki/D4U1eHIcrb8jhg3Bi0uVJV0eG7egsla/WHI5kpscQYeCWUPXQZzg29W44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTVUNL1P; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so292308a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 04:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720090978; x=1720695778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twD9wiCIJqk+ukbAomHl+LI0ZM5B5rgJ2OHvePUcXFA=;
        b=fTVUNL1P38R+J3C5yT1JusXZifvQEN76MbIOrwjFAoGmWGm9G38aBqaidrMLYY9m2M
         CpKGoHKGyN5Fwr1jAAQ6Px23hydrRjGw9RHBSZWHtn514XEozOZFqujrOj3lTvaPJdwB
         aP/DCzH+Xk7DwNgDncCcgi4r8WbT6gGULixe53si/TUCXjiGEGtcNwa/gAoPa6LMjdXp
         QPN0RVPKRnuN6AzxZzwq1g+2ImHcAd3MpHVtj4DMwvDIBcNrQfr1RvsfOS+DdLiwAHdT
         1WyfjUWVBnetzz1XXUol43hvEjelgCxy8HfujEsEnG3jCtIr+7tX6S+Q+AodDkKhhcjz
         1KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720090978; x=1720695778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twD9wiCIJqk+ukbAomHl+LI0ZM5B5rgJ2OHvePUcXFA=;
        b=c53XUNXtQ6g/GxwUgpw/Kra4zk5VxjMVJ3LFzWJRaeWY9QQ1egE+LlnGB0+dDNmVST
         j7PEpxQnCPV+z77cuigc0d6dTDhZsT5XBAPNTYCw8ImzB01o03AxxSrws/Y7v2R23fmG
         dIIumgdiBiOrQ9Gy5srxxlyaeY/YOb+9NqkjT25Hlr7XrJOyVHhloQxdt0TzE++XW8Am
         fzqJ+SINsG8LqjxaFra4/d1bkFcKyA0uaDCwLYXs2xwWafidIKNIK7Ctp9rpDboZpRsK
         aiEfjqEYmecqY2FKLFDn48MrXUcA925PDicnjdFRhDRntWyetb8iLsKRdQX/eR74uL5e
         7TJg==
X-Gm-Message-State: AOJu0YxHix6wy4L3ZGVSMnBq3/6MRG7nrY2Sr5Ara61NJhmhabBqHdEi
	/lMRwcxSnbfDRYnN8qKeNp+00Gd+RRv+fnngn0X4K+o/O173ogXJ
X-Google-Smtp-Source: AGHT+IFq5ZELS6j7UkpBjKYuHauiye6ErTLxzzyxmXx/ZC1v70DV1DKKB5w+yZ0BDGImPaNY5olY8w==
X-Received: by 2002:a05:6a20:3ca9:b0:1be:d45:6eb with SMTP id adf61e73a8af0-1c0cc66a2a0mr1293833637.0.1720090978004;
        Thu, 04 Jul 2024 04:02:58 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9977cfsm1190793a91.34.2024.07.04.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:02:57 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Thu,  4 Jul 2024 20:02:54 +0900
Message-Id: <20240704110254.91612-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: <000000000000ffc5d80616fea23d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/team/team_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..245566a1875d 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1213,7 +1213,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_port_enter;
 	}
 
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
--


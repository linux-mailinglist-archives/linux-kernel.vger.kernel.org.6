Return-Path: <linux-kernel+bounces-558428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B138A5E5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7284117B86B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11161F03ED;
	Wed, 12 Mar 2025 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OX0/8abk"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0381EEA49
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812874; cv=none; b=BY6612eRGiXGGf5e/59PBDs0B3OaIa2eTTs3zVnWPooR5tcKqZ88flUVZO0qXrNXYsrkX5+sV3hDNEoI1tsC/mtU3CILCpQ4U34dUqcDfr/+50YwtmjyOhsC5/oIIs+MMyL6vezNukdyuDoaQW/1EGeg7896OzDR1rAoOygTSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812874; c=relaxed/simple;
	bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk2ClPXZkoqgPVYTkoobdo7ZAWT9SIwnPrAfpsJBiD3MC/QOWu1YudTwsOQmP4cD0czVxELCc0SZaHf0uriU8FI1RaDFmdxkiBjgGeSStSWmo3axNqdzDtYdOSv0LzmrGGdQqN7q3Svb6k6Q+dLFrc9ncSa5HHTGvQEimbQ1mlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OX0/8abk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913cf69784so227461f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812870; x=1742417670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=OX0/8abk5VtgJx0xIfEdTviBefsTGMegjClgoLwv12W3LfNnM5kJrTr6fARygOvFcv
         G8asesORvHdz2BIqVquqQ5s/AbCJN3dbtRzDGmwDPVRX0Cy9MLSRPhIjmGd4wKjqFUza
         XQFhlGtmhnkMvDKWzdgfvm+6qmSOBDGdxMGH1JFwymfbA15WQOTqk6eVvETEstYahWvf
         pJq4lxl1SyIc2J2bJnzw2hSbxajE5D4NO1XWWgeIblAczqzeQ/Fc9CVOHfgl7v4NMCxn
         FbHfedlNSitS0+kYJqET7hCNajUeNF1/touXqN2YjnA7CR9hNzYy9R2u+atBC28vNJtr
         0eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812870; x=1742417670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1eyDA70luy030ManbvwItVlUHe7jfQdxQkjt6FQ5RE=;
        b=LMDgR15ecTrhlRltF0FiY737uLUU0R6f1l4FKZZ5zC4lbdZgoDSQ44hPxNe7bMfgDS
         iVI6X2bi/O0p0iZaFB0aYw6Uax0Tbd2lFGPS0rzzxb5AWummDzbvp4HttUK7SOfSZuJ4
         rLvyimT0coA1pG0B1b6qxU15UdSMxENKWpFDacowVlwx7DHk8I1VS7SMUp9HC9a43IMe
         PA0Q9IRd1igtq6u7HooP4xUjQWqfh6AZIV5yNutzhvCN8iYqcz/wTg0vu/qWaGbeZpx9
         l9Oe7bgjKkQ35KMBE8AJKPyyD9Y1CmZ7bqoxdJKMHvhdnfBUFn1z5mIrmyHkKx22ai4M
         LAOg==
X-Forwarded-Encrypted: i=1; AJvYcCVxNk0TkAPDQCbCuCQJPq1AzXmyus5VW72hD2pm26/g8GPp7+UC91bLGgofDJdX4EBk8kndMsv7puerNpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDE8lkgaQFUHBa+bJkrUy+i1P4VwwLHRGMZeOpBksK0EvbelXX
	LHexe1QdPxzS3+7g5t/eYhLYPE/pMg+r+iyN+fGoE0ALTCUEG9DXJFp+GqwPd0w=
X-Gm-Gg: ASbGncuCeV4ru1h7nOt6p2yH3B8WWoXyG3tfImRrNgkk1AL7hxpO6e/fQN0Ut4DCt9E
	HcskLMkarO/IHpbxSFlk/y31iU9QtcD1LrKrYXSLinXmDbuYGXJP4g6mfsUo4vyI+SasOxNdTde
	xNuom4STH2L6N2hYwfErJ3dshodMxX+hAS7lEnxTmbcjqamjsP27nIT9t56hKKnezD3M373skVd
	Z+rrv+pVlh6FZW9YguVKJ04XA/fOpMpgP6ADzia1Yosq1rxE0CXbdl7VXrWSRg+cPkHR88S6Zbr
	iIQDAi5W9pHjVzk2xnwkAhYI9AeWbydxCxa96EOH6P6ZxiNc0EgX
X-Google-Smtp-Source: AGHT+IFn9XKbA93e7BiCzXzwzWgDYS06r1RE5lYZJPnFo1YWffmvHTw8AB8U2H1zm2LIhUons2recA==
X-Received: by 2002:a5d:6d83:0:b0:390:e9b5:d69c with SMTP id ffacd0b85a97d-39132d5670bmr24432111f8f.25.1741812869668;
        Wed, 12 Mar 2025 13:54:29 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:13 +0100
Subject: [PATCH net-next v23 04/23] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-4-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=nC6lwDPb3zbItVdYhexRf+7PoutRMPw8aLJAIMgqJRQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR7TuAOuQwpbA7wiXPSYho5YDAWVs5A6/djU
 GMLf/ub1MmJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0ewAKCRALcOU6oDjV
 h6/AB/9PEEz/xZPMposrtUqAnifKhJ4ydKe03q5K2SVgk0vgiwoihZwmZCAUzHXiVZQLwRdmzA7
 ksixxTC3HMCbSRZuqIiT8sw4zhIEZmU/xSgPLrRKjXBS4+vMMJsDR7ZSFdAq2NnQoSLY3ClWbtL
 mMwW10nLZE6CaQPFhTdEeTWnwV3OmFaG5+pV2ExP7BBqsjU5IBndmnSB3UdOn8ONH6hmfrgZiG+
 sF+b6brsibQHzCoEw3CzqDZGvh2thjZBIEI8DgkQqy+LOoh8pHOzvp5kFg294/rZIKL4mMLGnEp
 8Z/mQp6CFHwvUSyBjlTqmlliiDSoF82eFqsIhjL4PRNnkr1S
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index e71183e6f42cd801861caaec9eb0f6828b64cda9..c5e75108b8da5eabde25426c6d6668fb14491986 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.48.1



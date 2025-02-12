Return-Path: <linux-kernel+bounces-511515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197BA32C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10881886487
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051E2505B3;
	Wed, 12 Feb 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjV59ihk"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026C21D59F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378438; cv=none; b=a4vZ7ScuoRSXZPStBfHao/TF0K3cdWjO5Mo05x/AosQJjn9zqB1/vJjk4TRVT0KuFOL3Fxg+2h0NUacnlFJZzbtvSac4T652pEK7HleJElkAyjNkG+uFMgx2fAErxfhSxlHtyyWy6CA16e9Snh/o8D9YnyDjBbm7aF5s2l0ZM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378438; c=relaxed/simple;
	bh=fIvihShcE39cxMOgvzvAE4sHjptoKE7mi4lhmy0B4f0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rcx5sfzCWr5S1lsPWVh3KgghtPi/4SMZA0cFkQ1QP5v2SgI2ZuIceyTRkh5xn38kvCB50PfHp6sUMT7uZ/6gY6vfpmr/Eqylurv7PIZi6ak0f96RMRh0WSe1Sb+c79pYDQCQLh/6h4cEiDFMdzdpXrdwDhQck/ImVk6eD25ezsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MjV59ihk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso8821864a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739378434; x=1739983234; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypsXxYmlUDNAgS7vll0CP7szhdB/OHfZFzs1nsbbuTk=;
        b=MjV59ihkdzLi+A18alBCA9M/pl8qcWykYSoTS/yohdfWRFby4TGv7imNQVrw/S6Rl+
         DwMfxZKoJOU7ZHiise1pEN8+nNXH1iv8i4IUuiRGBJfjSnE2Tz3I0mUIsQEryR2fIPek
         DMAoN+Jfywkb///gIf6AzMhkRg/EoS/+FZpD8V8JE/iCqvVP82q5CXZ7xybyvmdkZm52
         KDVtR7dD95CW6mFjeUV6IBLPvdaaDHbIWgY6t4rbbPdU/Ox4GipKs0GwrCq7d43s/DVU
         RHGk+DZFagmT5ACeud3MSOQF8PTo5TWSArVCSJL0u4XSxOvRCzke0Nw52HAL5SLodmpr
         gC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378434; x=1739983234;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypsXxYmlUDNAgS7vll0CP7szhdB/OHfZFzs1nsbbuTk=;
        b=LfXnNdESdX2IUXM9QaEIWZ22gJ6oPrhGtrb+Yl10kNs/S4z97X0NkflxG9cFtsalWx
         TQyoUt1SuJvQ24Wybh771wavqDGeMrEEbcrUloErBNlW26E5GNzLTqvQ+nEoFS7Itemq
         0uPDolJEOxXWWhwYvtmdzW3PBUmSclwmp675PIzB1uhHFbK9WCynZhWolvhacTClgM3e
         dOEx0JdHtCVDuHXM+nnwBBDn+rfBu7rCvf5MWoBDKK/V71VWaR/EeVAJtFcbOu9Z1WZu
         Jo5T0qK8Mw0PdKzub99wwa2g65SMPl0Z3oKK+Ms8lCVJhHaENHrQCw8qbBYbR6qUnlJy
         jhWA==
X-Forwarded-Encrypted: i=1; AJvYcCUq2gXFHUJpb7N4276vBW7ZSOqQyi7KhotwO39K2EhEbMxhwAqqzBvhJ0wsSVhlvR2/V9lvVJKtcyoPRyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGev9JjErFnQgjk/7ETgdqtCrw3ZT1l8N+F/pZxCXILkPpPhx8
	HBvignkGP2m9l9Z0e2c+Rq/DvBp2OB1xwcOYORhsebGyVBqwHpTnNQnpyslupMoFnp5eDFYP3ft
	M
X-Gm-Gg: ASbGncvhWq7Xopf0P6rMOexkmH8Qd+T2hTItSV2jCDnA6loH2ElmR9T43x7ca9gvo9F
	xCre+O4BE45jEbVjQDGtUfYd2knK4Rb1kLV6GvL3CBs+iKLalmpksUfO0hYnx3iYB5TjnogVuNb
	3NtU2XBaaPWn5Z6kcNFT4dNvvxhcM3aw1HUsBmxWjYqf3CfjHCZJJGlwvexs/HbvLC6pfBp1MU2
	mU+ZQMxNLXKPKpPNk/wZA/8gBrAfYnsBtuUk1l1PMa6br5LfZbemX8Dtfrn/K+Xy3RsfL701cK5
	IoU1BpBXpRHp30D6Du6E
X-Google-Smtp-Source: AGHT+IEMax/OSHUJltNQhKyJlOjabg9OH0ij65Z9dSRbXrh3omUujr+vpFNHmyS95enTpRBK7kAIBg==
X-Received: by 2002:a05:6402:2688:b0:5dc:d913:f896 with SMTP id 4fb4d7f45d1cf-5deadd75028mr3104581a12.4.1739378434362;
        Wed, 12 Feb 2025 08:40:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de4cbdb434sm10348391a12.20.2025.02.12.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:40:34 -0800 (PST)
Date: Wed, 12 Feb 2025 19:40:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] Bluetooth: L2CAP: Fix NULL dereference in
 l2cap_recv_acldata()
Message-ID: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "conn" pointer is NULL so this "goto drop;" will lead to a NULL
dereference when we call mutex_unlock(&conn->lock). Free the skb and
return directly instead.

Fixes: dd6367916d2d ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6cdc1dc3a7f9..fec11e576f31 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7456,8 +7456,10 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 	hci_dev_unlock(hcon->hdev);
 
-	if (!conn)
-		goto drop;
+	if (!conn) {
+		kfree_skb(skb);
+		return;
+	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
-- 
2.47.2



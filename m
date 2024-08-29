Return-Path: <linux-kernel+bounces-307538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48955964EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33411F23945
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311BB1B8EA3;
	Thu, 29 Aug 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsKlCMUy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59171B86EF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959362; cv=none; b=RgGYOHv/x7a8SgRt8Acbe7Iqbw/lin/639zGnQAbGji9eZn4Pt6Rub4jZCsVRR3cFrZWSRseHXkSOap74a1YBHq604UteRN/BQNv3926UAEQE57qVV8kKsBMwS6Ty3DaogMLbQquTvZDlX7YqUsnh1+PghhtytV0q6cEOthrf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959362; c=relaxed/simple;
	bh=qm19Gvoz82XJIblwayPtkbMrwDBs9ju0c2xYk5h7T9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LW2UEFmMU3T/pbNhec0GJVsnUikMBN9WWCbMRJ59Q/ZkeNcfMIKJBMUOkWG+qQrl9DanbQxcZjuuqMbrQ4SLeqMPuCGARExW/EbuAbSWntP8CRfl1D654igd1AQ19hURT3s+CzFhvxEFh9hWWfa9SsF1VUOMOXb7g3VYLMB2Fh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JsKlCMUy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb8cf8a5bso5439615e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724959359; x=1725564159; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hIZjb11n3DqyAA9+P4eJZLp72biRJ3AAbi9kWILsZ0=;
        b=JsKlCMUyICUC04SoUZs2LyYmTJ7lryHd95jPzMWyQXhaCeWQlVwBDVaPuCNMoixJZU
         71Ka2Gs9JqMwCTL1T+DhhBFEo5UZAyUNZ8vQAVDwpl7thB6PHlz3gYo1cMW9u6yTq0dQ
         VngGxCHTmVP2aDr6eM//PLJ2TkIplXhHDv4DFJSrddAWQ8G7Zu7Ej2JzL15+mqAZCl4B
         GlA8xf0vIaQ3A0IqPQUtTw5S+qbEqcXHRN8xvgAmFzL67eUhJHdE7kMuooq7aHSrqsXS
         Vwn8vwaZ9vIKHfwifhQhKSLd0sRsohDnuj10aXka6WZACyahQrQtnHs+K/WvKE8MU/1R
         sWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959359; x=1725564159;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hIZjb11n3DqyAA9+P4eJZLp72biRJ3AAbi9kWILsZ0=;
        b=Du5nJBJCDaewVC+2B+RYIQT6xTlGlEFPPrC4o6YpiAs3dvNLknSkD01I70G1FdQbtf
         fPiy6BXgkCxzN+ox5GmXAVJKr4Hns5T0+w3csUX37FmpWMSOEZ85EBZ0yhz9jIbMoV0B
         NrqG3nGFO+zac5qHShtfi9+B5fHBI6Czk9IGdICNzWGjQVJq+NN3wqsgwcKTuF1Olf+4
         QMduIlKj1V0rS43D3vXbGIZ5lvsL1gjc5salc2hqofI1LF9EdZMNJO8qK9sagFZ/KKkD
         Hk0oN3sFnfdvFYSrdydvnGARpcq7LRAQoLRUcT6pvlqvl+rlmt+KT8CCDejYQmNF0wms
         gpRw==
X-Forwarded-Encrypted: i=1; AJvYcCWnD0hJgVkLkGyk2F932jrvD7RfqUOei9Yt2Bh3NvuZtyMt5SJY1I7GwDhZ60UsScCO8LO0BsBH/G/rlaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCG+46wK8/6mPLWro/LpzbypXYaY9FkYFteoVgmRkkMuAya2dk
	j/EdoT6TzaxjbIpLVnhZri8q18GhVstcEYLFb/wNDnjQsJrXcF1s3qnSLnnf0wk=
X-Google-Smtp-Source: AGHT+IGTymteNaS4QWlAktRpMUvs68NdpmgcKtVmjCHiVHP/sCFsHOFzLywZcr2xcxkbNPQRnu+rOg==
X-Received: by 2002:a05:600c:3596:b0:426:629f:154e with SMTP id 5b1f17b1804b1-42bb02d970dmr25349155e9.30.1724959359098;
        Thu, 29 Aug 2024 12:22:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642593asm59424265e9.39.2024.08.29.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:22:38 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:22:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ksmbd: Unlock on in ksmbd_tcp_set_interfaces()
Message-ID: <89c440a9-27bd-45d9-9d5b-5b4bf51ec950@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Unlock before returning an error code if this allocation fails.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/server/transport_tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index a84788396daa..aaed9e293b2e 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -624,8 +624,10 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 		for_each_netdev(&init_net, netdev) {
 			if (netif_is_bridge_port(netdev))
 				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
+			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
+				rtnl_unlock();
 				return -ENOMEM;
+			}
 		}
 		rtnl_unlock();
 		bind_additional_ifaces = 1;
-- 
2.45.2



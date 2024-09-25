Return-Path: <linux-kernel+bounces-339407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB39864C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B93D1F25821
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0266A357;
	Wed, 25 Sep 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hET3XnAM"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17C44C86
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281519; cv=none; b=DOj3uq45OwkyKWbc0KpYRvQvXDmzXqsmZRUJP9DLCdAINsOIHI7dcavTQNZ6IxEl+cARZXcbwVd3iIO6ZI7cnTw4C1vQRdHiuyVXEBQ6CIwyNdf5FehjuxK7O3Y+FtvoF6RGFtj1Bfc2AS5YLQeqsrwo0TzjMF7VROwCiH3YXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281519; c=relaxed/simple;
	bh=+2FSnKyNki+fw/fhnexvjl1DNdJwIpxfKSde39h02Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b99QxA6TfVrVNPzfIn3z0qd+EhOocWX2svxcpFCk92PSUhi7m9A6S92ov2+KEnb+X0b0NQkJIBvUBKogiRzTPjiHANAHhYL76UKkQWT1iE9stJrdJevbpABIMTeDlx1w+hBd2nVKmLOCX68ZNTRewCounuy7HmeeNshyhxdsZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hET3XnAM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e08a0679b1so68342a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281517; x=1727886317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mQegUT00US8bGAhFrzBaDDODW/YQTCJrsGeC6HyUig=;
        b=hET3XnAMejBpTEn7kA7S66NEHupBV8vQRoNFZgUNsve5JoLvTRyb/XNf+CsjuNTHvI
         5j3Lu83rgRbPo0vuviKn3otCHyE0cK2N6MRQGscPsOj2aTlTnB4dts9YHyirG6hddJD/
         3WiuRlQxoveqmfCPVARDq4eUzcFJd5l4P7rS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281517; x=1727886317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mQegUT00US8bGAhFrzBaDDODW/YQTCJrsGeC6HyUig=;
        b=LUoiK7sHLg5MvEG8SfY6Qs6U6ZRCGzLLdEwbSnY2KPvDVXWyQPYu4vFtPpXBpjSpm2
         FcQAxT4qpk+I6iiBNlciWwdynAPtqB2j8JTVk1rjzUtdaATZa3RjP6E0mmK5LElXwQWB
         ixpVqViyYfBHToDh4FGNL1PTaoE5JKP8iB/Siz3vq7skYvunzhkEGI2Hm2pMn7Yh4AkY
         CfhTSHsuaegfFQX4JcbldWE4XzG21iKEOvuit1WxChGXIUDnPnRfiUpupmArVEqICW0G
         KcUiHx0AVKdhG/2XwXG4TsKORtbMPoQadYxlpUEMOZ+shp0E2GekoojDWrbnCo4FHtXS
         +0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB/WM9Ox9fuH7k/nJe1qJosHRT7mT3/cdmKYURvnBcMd9By9CIw1/nlrDYM0zAH/d3ehGfDW4u1Epe0zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE1lYoLrjIkwhhnYicxZ/izkQ9vHFwTrlH48jSuCi1x533UHG8
	x3ALRLRLgvSBQ649T88e5rMDrtAStmuCNhuj/fxjZU1CkvS+LbMf7Vc6rU/8lQ==
X-Google-Smtp-Source: AGHT+IGPeP9YvzCBtyDelDQm+zN1EEUMTA4n09WeOUuCb+QBT8Nn/5HPs5f7loDRRi7Ku1Gj6nZnTQ==
X-Received: by 2002:a17:90b:17c6:b0:2cf:fe5d:ea12 with SMTP id 98e67ed59e1d1-2e06ae7b726mr4165481a91.24.1727281517224;
        Wed, 25 Sep 2024 09:25:17 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e06e31477fsm1705449a91.54.2024.09.25.09.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:16 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 2/8] usb: typec: altmode_match should handle TYPEC_ANY_MODE
Date: Wed, 25 Sep 2024 09:25:03 -0700
Message-ID: <20240925092505.2.Ie0d37646f18461234777d88b4c3e21faed92ed4f@changeid>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925162513.435177-1-abhishekpandit@chromium.org>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

altmode_match is used when searching for the first port altmode that
matches the partner or plug altmode. If the port registered with mode
set to TYPEC_ANY_MODE, it should always match if the SVID matches.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/usb/typec/class.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9262fcd4144f..179856503d5d 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -230,7 +230,8 @@ static int altmode_match(struct device *dev, void *data)
 	if (!is_typec_altmode(dev))
 		return 0;
 
-	return ((adev->svid == id->svid) && (adev->mode == id->mode));
+	return ((adev->svid == id->svid) &&
+		(adev->mode == id->mode || adev->mode == TYPEC_ANY_MODE));
 }
 
 static void typec_altmode_set_partner(struct altmode *altmode)
-- 
2.46.0.792.g87dc391469-goog



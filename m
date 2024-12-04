Return-Path: <linux-kernel+bounces-430913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5009E371A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A64D161C6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707D1AF4EF;
	Wed,  4 Dec 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FCxDLHga"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D51AC435
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306503; cv=none; b=DDUulzKtlDxNP81QEDFn+zgANJKb/g4iwMgj86h4x3a9YTyfZDihtwO1rxAacGNSburM3NFmvcFqgGapamZmbebMhaRw6qJRloot/8MDjUNctGeeCyu6Ni6vYB4GXDHhRlHzftBXmGHBy4pg//M9abNJ5SO3Xa6FGvPkoMLOt5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306503; c=relaxed/simple;
	bh=8VrY87kaZE6gJKUjQ5DzijJJdpboYwfqA0a67+e3vOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LS11GyxayE1FIkuDHsWD1Ks8Zqc3801GnSP7nWpPl2zCKltIp9uktq0Bnh055Hr9lhFMPrb3ow2H3QhJd4xXvVIIxdthRxBV/l0oz0KcIBRU7NPqOOfexlkJzlQpsrCSfMfZ7IWkhzRUjAXNAqFOZLPRuJHx9iJLU3a6etKXf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FCxDLHga; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e3621518so3471798f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733306500; x=1733911300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwD75of58f/xbTaahHqt3gTZtblT5HhO4XUnFYljnPE=;
        b=FCxDLHgaDua5vaGT53PaKKtQkIZm8PSSHN0EYcx73a0V2Vm6QDKRp+2JTM3lnCDamK
         KhY9pbM82KIfiUQ8cS5NfgbMGdN6V4PpNjG++eWdHPOe3L3NAP3Sd3baXa6jeTxhOHCx
         8JjsWQpyU0rLWyNTtd99O6fUPX5m/ZTUbRW5hyzQX9pWkkeFUmT7/r2ga+hfNrNfgcYh
         sKlPybdH6+ZJ8SStXodxwilLtWd32MCFARvpvGhSsGbe7yjFBeWJrCFzOQf3JRHszh90
         65CQ+U5NTO5zn17BNDQ9jyvgkzCf7ghbqsBMLWbFJuqg6pzv7V5oWctPEbv0ok3R4CjH
         PzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306500; x=1733911300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwD75of58f/xbTaahHqt3gTZtblT5HhO4XUnFYljnPE=;
        b=S6HDyY4KVlKYVi6cXCtjqEy1uQmNj1Nkuas3K+ZIWCD4osOMTzqbgu1TAmW9/m4cs+
         21ICShpT5gEOgHl3g+gVmCOedPGvHVUrtQwA1/T6sywsVu4RwslfskX+Ki1aIXExtG2j
         VEuKKj6uNVuMVevgieylAFR8fiZzYL7/81miwd5wT5RAbDOEOReW0VYMP3BiC7vOY5x/
         KgpX0dutMXFJiWjmrogrT+f5uNcAmHaJ64gLiJ0Qlk8ijr7iiYAqdTUAJJHiTv+zOMdM
         m6ipPjEnpSPnH/ZPTxtHTuzcmphbj6JnbPYljes6HW/fDww1/ZgDaCKfS9Rs+braUZHZ
         tF6w==
X-Forwarded-Encrypted: i=1; AJvYcCXauYWWXNk1W9nRq3koZ084+zqWkn2SE5/cyOjHhBJ/TehOqMvyNCagHafAVZI6lJRM5nffdGur74mBhEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ENAhtFBNHrWNAkSgos7DUMKOby1uW04QrjsxgSrQUF7XUo9s
	u0MUDj+df3jeNBYrVmvXzro13CXdvRJN4ZAyIZinfieFPUenJkR8wjNrEF+gnKY=
X-Gm-Gg: ASbGncvt/aZcPZ8N9bHN3RkAHuwV+jxf+/zCrDhUDZOR9jBpbtpTBvM1hNXVOd5iQR0
	uTzYfw4I7nYsbxPtjjQ1EZ6qGClR7XeCb/QCWn0ZAScdbGXqTZe7O1VG3bkj4jG1erAjIGX7+sk
	hZIhI9Tg9siF0qA1dmNCvCMvU8KgWAjvgpSomT/mA3dNDdX/PRoT7TMZIsPMu/DV3Wvz3jMqSr3
	enerEbJN2d9nxSGj5lgeh6pHkD7404yScAGYdRhX364yRp9Q4iO+UspHFwOy23C2ng6pZpFmaIo
	B6Cq
X-Google-Smtp-Source: AGHT+IG/YvLq7nYqCEITmZdzn/4d8y+5k/oTP3J9cmazuQsqONwHRLmailN0uzFyh6kEOQRKDYEURA==
X-Received: by 2002:a05:6000:785:b0:385:eda9:a8eb with SMTP id ffacd0b85a97d-385fd40ad81mr4464842f8f.29.1733306499872;
        Wed, 04 Dec 2024 02:01:39 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df63255bsm15109376f8f.86.2024.12.04.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:01:39 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] doc: module: Fix documented type of namespace
Date: Wed,  4 Dec 2024 11:01:10 +0100
Message-ID:  <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733305665.git.ukleinek@kernel.org>
References: <cover.1733305665.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8VrY87kaZE6gJKUjQ5DzijJJdpboYwfqA0a67+e3vOE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnUCh0ZpDGC2l2mL7F4uGQckIRiKDkafyoMwrdo NZYgRpM0gaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ1AodAAKCRCPgPtYfRL+ TtHTB/9nnQ3O59ERJh1bSIYOdK5mXU+swmbA+4bbbosuyd34OnvVQDEyKr7ZDIQVopEN3VNwQIO gL+sYTAP/0G3i7kszC24prQFd1bx2j3oVhjOp5nyUYdDuak7R5tx//lgfdx2F8dzprDBZ4CgNOp Z38JnXIyCp/zWAIQ311DpcqDZbsNxFzIBGf36ApwPLSWUW59oh9N7Qh9nwZlSvOjyAB1i/HmDej E2Rn1XiRVuwSOrgouzervkSPPlm74LIf0iKMQeg7iHIziqUhDhOJl0hU5CA55wy3LBzKXjWikKD 9HW92qeqpt+CtO5nHcnCEh0yi9yhm+uLO3fKhcez4nSFaubM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
literal") the namespace has to be a string. Fix accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Documentation/core-api/symbol-namespaces.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 27a9cccc792c..a08a3448cbad 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -41,9 +41,8 @@ entries.
 In addition to the macros EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(), that allow
 exporting of kernel symbols to the kernel symbol table, variants of these are
 available to export symbols into a certain namespace: EXPORT_SYMBOL_NS() and
-EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace.
-Please note that due to macro expansion that argument needs to be a
-preprocessor symbol. E.g. to export the symbol ``usb_stor_suspend`` into the
+EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespace as a
+C-string. E.g. to export the symbol ``usb_stor_suspend`` into the
 namespace ``USB_STORAGE``, use::
 
 	EXPORT_SYMBOL_NS(usb_stor_suspend, "USB_STORAGE");
-- 
2.45.2



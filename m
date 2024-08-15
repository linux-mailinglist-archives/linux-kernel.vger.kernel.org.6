Return-Path: <linux-kernel+bounces-287802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2F952CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5E328254A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D01C233F;
	Thu, 15 Aug 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzJzdAU4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6801C0DF7;
	Thu, 15 Aug 2024 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717893; cv=none; b=IsQhq4KPpblMVo7O6fuz/rTx+FwbFUZmKoTyIB3/wqcNKVNwDCLN2CnpED0wOd5b99JczAULvh/pYhdI2lShs4cXmLnFNXEvL7IUiGJCxxtYK2JHqpjUXmrSS2Sy3MgbRedq8Ey7ZpIFgO4sYcBi+WKWfmY8R70AVkzd8cMrzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717893; c=relaxed/simple;
	bh=B1zbU9K4JBV+Y+++fLZNnEr24U7Z6B1vwPpEWdvE6iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKv7vrSVQxHZXYO3SB65fYseWTRZ2/jrddASFh2+fGqH45SpKv2hbzIGZ/0SZGLNV7b4jQIrokC3dg5cInu6l6bPb1jPBTAjXXmmhc76CK54ilg7IkdKC182Eso0YFUmirhGsJ9jxVYzIDUa2fjJzsX5gwYEyDXUUVzEU6BxELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzJzdAU4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc569440e1so7314975ad.3;
        Thu, 15 Aug 2024 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723717890; x=1724322690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/+XfRXPXj8w6EXHeOGa4iFRQXkETj6uUNo6qQuywIE=;
        b=MzJzdAU4GLIgiNM0i28RPWutMT/Ox6bVX52CT+rHOHpyLyan94Ift05fViA1lp5aCd
         bBOAkHwCgfNjSl8bIAO77QtHTkE9Z+yOdckQvws9nu9xxSj5RRW7yAcFHyxcv9eYWSre
         ukcwiyr8WcqvNysTB66OhfMgOKQBZA0cCOW73+X7rR9ppyyz58x8TnmfdF3BtBfcpn+/
         htcckc3nGhEortdwBAIIjb8Xg3tK9e43jQWgWlnEZSs5rbM+pinPLo7UWkDUfzJ3K//5
         jkudX1MCOklNFF3eFFXpdxP9LdjTB66NkWA0IXFTne0Wm8IjLBVLjqir4bxTvnx8eYUV
         SOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717890; x=1724322690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/+XfRXPXj8w6EXHeOGa4iFRQXkETj6uUNo6qQuywIE=;
        b=gYWfHdjtU4fKkEAzuI7R+L8Aez97iqe4syD4dvZounR7omciZYHAWrnAstmmHxYy6M
         8fv4XstmMTZ+kp4Scq4R0vZdynin1Pd35Fr47NNLeJ2tz9JxyxeNOrFxkd38FH+QSJqw
         MxGYReDODzwdMeCmolGX1ECcKznO6TvW3RNn6WbTuHxJs5EPmatUzSrwfhS83bVK+e0+
         TC6xDib3XaR3458BNrbjnYE3gGH9Pf8n4tgyW0026Z31i2h5GVnBHTv08p64DbvtfcbY
         14WGi7kZPNS+QlUn6pWtZC4OxNmHSmXtEGBPZ8dDMDCog3K32If1W2Z3RHooLfzeQm8L
         Xq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqNGFQVHdrPI7vtAzbvPVU2uEowlhqNKc8Mp5KO5r/sPBhjTALFwY6DNudcb/gg/uHMOaAJRt5WKiAr+LqwfalbEL9RopYXs7UCjr4avtxida7fCpXdeOBjm48QrMlo97t/c4bSzsm
X-Gm-Message-State: AOJu0YwFTxh0OJSrTkE4F0g2EmWqeXMOmCpcsNX7IUecoEFYMMf069vi
	eZQptPwyWge4/pe2sz653Xy18y5Xg5vKkcIYz0UG81EeEkNO9Q4w
X-Google-Smtp-Source: AGHT+IE2tPcYmqo5mobOND+l+zGWw1MEU6GWcTocYYS8xFwMoz29IfTBC0wr5z7+LHZ1OnnytgfsBQ==
X-Received: by 2002:a17:902:da8b:b0:201:f83e:c267 with SMTP id d9443c01a7336-201f83ec51emr8253085ad.5.1723717889158;
        Thu, 15 Aug 2024 03:31:29 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. (126-84.iitb.ac.in. [103.21.126.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa4a7sm8043655ad.38.2024.08.15.03.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:31:28 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: linux@leemhuis.info
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH] docs: Fix grammar and phrasing errors in reporting-issues.rst
Date: Thu, 15 Aug 2024 16:01:14 +0530
Message-Id: <20240815103114.10461-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects some grammatical errors in the `reporting-issues.rst` 
documentation file. These changes improve the readability and accuracy of 
the instructions provided in the documentation.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 Documentation/admin-guide/reporting-issues.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 2fd5a0302..61de4454b 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -56,7 +56,7 @@ developers. It might be all that's needed for people already familiar with
 reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
 everyone else there is this section. It is more detailed and uses a
 step-by-step approach. It still tries to be brief for readability and leaves
-out a lot of details; those are described below the step-by-step guide in a
+out a lot of details; those are described below in the step-by-step guide in a
 reference section, which explains each of the steps in more detail.
 
 Note: this section covers a few more aspects than the TL;DR and does things in
@@ -299,7 +299,7 @@ face, even if they look small or totally unrelated. That's why you should report
 issues with these kernels to the vendor. Its developers should look into the
 report and, in case it turns out to be an upstream issue, fix it directly
 upstream or forward the report there. In practice that often does not work out
-or might not what you want. You thus might want to consider circumventing the
+or might not be what you want. You thus might want to consider circumventing the
 vendor by installing the very latest Linux kernel core yourself. If that's an
 option for you move ahead in this process, as a later step in this guide will
 explain how to do that once it rules out other potential causes for your issue.
-- 
2.34.1


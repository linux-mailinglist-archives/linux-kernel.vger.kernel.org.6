Return-Path: <linux-kernel+bounces-318379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD29696EC95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C82C2817AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67114B96E;
	Fri,  6 Sep 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra0jT37T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AE14A629
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609213; cv=none; b=mGRlzPulZomONNoZqWLNl2MXF/zc2KIcskg/rfphEQqXlXCXXeXqul1bziFGVyZtMOpYafucD47dnjH5b0zcC+AAeo92YMFnv13v/+FFGCdpgkmHgfcnUofOw2ZcluZvwMevwUaX8bk8G7egaDBNcIKDGkyscw0MST7f2bxEf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609213; c=relaxed/simple;
	bh=pDoHJPiqr2uHxsG5WH6Q4c/4CQBkbqkQjiVwGn4FLVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QESC1xNdQIE7mDcbAezjmsF6fN2Bcp8cVeRD9jUwEwWFTniRgumKYSjxuX4Bco6mroWsCPvtu44zRm/egRtUdmC8kEgY9WEZwSOiPapXXg+SAjXbDLaRKf4nIl0HdoFDgZ6r7OiojLFY48gn7ErX/X7SX86mwirO7TIjTuWP8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ra0jT37T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725609209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FLWAMf4F16Cm/iVBIMV8eWypdRb0d5qIVCKf1JBr3N4=;
	b=Ra0jT37TX+rzKjMsfXtCs2K1RvbvCOUJWNGIoRl3c+TuM7AE/RMxVTeQkKlsMJve2ikh8y
	0dkOYNcYeZ4LbJgD+TyVsyFqDTQ8xQPe8H2+X9h40sfIe7WVbwOmiN6hr4lZ6h8PJdia3I
	EpEbEsRw9nxwqrlQjCmohKkJxrHSngc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-7T9EALPkP_a9U570dBlpvA-1; Fri, 06 Sep 2024 03:53:28 -0400
X-MC-Unique: 7T9EALPkP_a9U570dBlpvA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a8e19833cso31883266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725609207; x=1726214007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLWAMf4F16Cm/iVBIMV8eWypdRb0d5qIVCKf1JBr3N4=;
        b=gqoudwpzfOVI71a73gfAt5cu6lN4WJ7nrAheDLj1KYqNULX0R29MZbGIHaIXRYmjWB
         uP2667F9stWqCOzYmOzEG9xcYfNzuWmvc/8z34ZfpKULp3YHRclXBYwpuJPHVzAZgGol
         zuRjKdYhezf0fkQ889Y8iqSuWvsir5oNk/WXgnRt8F2iX3wFiJlyR7Olc7hzv8WQNt/x
         7fUNpKkrBFDSXJWHrv4LAEng8JiIn3/jTqm3ydgDXeW7qVbXJy5v9sKTmkMwP6B+aUbZ
         gDuGzRj6QXb+zrAqSAIPwzBf9Zopd4/XfLx6BIID6UQiS5nlO8yc5xoNwYQ6CulCnnNN
         n7EA==
X-Forwarded-Encrypted: i=1; AJvYcCWhV8YE6m38eM/5FVzdEwwx13dqKDo+wajcCqhll6S7G4vLQD5s44FrbIi59p3++XTN6IvawYdClI3Kk+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYf+JtxvKU44yMxxW5dKwX/vPhlXzEq0CQJCGsWCnnJJJNGWfT
	rzlykbZFt/G/zyxIgknxHzu7+v6EwvHJS3myxWds5OFYeRYIRuknrT1m79EMr5SNBEBYh/woZPH
	xT38xGlfB07gQhJoD20bw7kTFCE4VSuqoNooeqyXghhBTAiQSoBVFXb5UMCwUlw==
X-Received: by 2002:a17:907:96a1:b0:a86:a7ef:5c9e with SMTP id a640c23a62f3a-a8a888d048fmr94572066b.59.1725609207047;
        Fri, 06 Sep 2024 00:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC4LXTl7rqt8bWyFmvt87c820Tjb3KUs14y5WiuLk422+QPG/y6q18RItWc+sk62ze6W26+A==
X-Received: by 2002:a17:907:96a1:b0:a86:a7ef:5c9e with SMTP id a640c23a62f3a-a8a888d048fmr94569666b.59.1725609206522;
        Fri, 06 Sep 2024 00:53:26 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a8a141a46sm61126166b.22.2024.09.06.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:53:25 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in U-BOOT ENVIRONMENT VARIABLES
Date: Fri,  6 Sep 2024 09:53:15 +0200
Message-ID: <20240906075321.51507-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 2fcea44e1ba1 ("dt-bindings: nvmem: convert U-Boot env to a layout")
moves u-boot,env.yaml, but does not adjust the file entry in the U-BOOT
ENVIRONMENT VARIABLES section referring to this file. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

Adjust the file entry after the device-tree binding has been moved.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c28f04234ad1..b4ed239518ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23563,7 +23563,7 @@ F:	drivers/media/pci/tw686x/
 U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
-F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
 F:	drivers/nvmem/u-boot-env.c
 
 UACCE ACCELERATOR FRAMEWORK
-- 
2.46.0



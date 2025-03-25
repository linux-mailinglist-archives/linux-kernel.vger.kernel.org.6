Return-Path: <linux-kernel+bounces-574998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109BA6EC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212C13B3B02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B960253F04;
	Tue, 25 Mar 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0x1/fXT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85519066D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894531; cv=none; b=qXxlA8XeFVUh36SrmFYA3iKXCuVFuvo43xn0oJ0PU53kjmw3+H11IrlTlQejeLg830glN5JVN7TC1XNmbmdkzLdUNzqXbBuE7Z3EG0JYsA+f51ERdnSjKeUIzIrBJf3rBpw7FvoEqOX9l0OLKlQDGzesMz02X3sB456bKcgcS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894531; c=relaxed/simple;
	bh=xaWwfXPFRfECFLckVObq454sJfCkJQ61bDemiqaexqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2VIGcDQUpbgfbGhHs8Bo0fmo0hy2w2j6liX5sP27lOkCGXskSbP861ZSQKpIhfh1ZBTHnpZZGvU40SnLDF0Y9P+j76xxorzRoB7g8Sj45RrhM46Rc/F0CosR6cF632XtpdmLWznTIuFTkcceAEf7wjKg8iV7VGsz8AV/QHBdnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0x1/fXT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742894529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P9IKeqJUU7xfsmBL2lNiXrAlhz1JyfP8xtACFJ20okg=;
	b=F0x1/fXTrU0F5/qUDcF6VKCm9gNrX1KNs9zbkHc9E25d3+maoxoFQTS3KYQ08i/8M/r2q2
	h7D70JG8ga7yshRSdQx4kJn7DKIrvaq+Lw7lANjqwA19sfQT6l8o/sIdWUTLDp03+GEMob
	Ooys3XivmLX0aB4R+CuKQfiFBNwkLfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-2bZQu_yWNAyrknpXwPWqKg-1; Tue, 25 Mar 2025 05:22:07 -0400
X-MC-Unique: 2bZQu_yWNAyrknpXwPWqKg-1
X-Mimecast-MFC-AGG-ID: 2bZQu_yWNAyrknpXwPWqKg_1742894526
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d733063cdso464965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742894526; x=1743499326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9IKeqJUU7xfsmBL2lNiXrAlhz1JyfP8xtACFJ20okg=;
        b=dq9kuW4gsxJKf7IilMnquun+76Dq5SsN+Oc5Ra7zkWEuwR2+BVH3lFRjDrA7YGBZIb
         39TMBP6KeR49aLOA+dmNx6yGISbV8B7Fs1xJ1EeFwoePsy+b+a+f9SNS+8GD3VVnU+pP
         F3MhQLsJMUwieL7me8YRs6m4YB6Ai4EP0L8pXdGbzdJ0tNwIGfgDPxS0OkhJMZlafe10
         khEHNPPIHnFNnRmge8GfXSBibiRF6WV1wrqAqe7C9XOgqOwLm4FXdRzCykF7lDH2yil3
         8w0/3MS+scTBNoNbILWvh7bvhLddW5mGIu8Cp+mjwAOoKQRxNfStLYw8fChaIZQrS6w3
         HuVA==
X-Forwarded-Encrypted: i=1; AJvYcCWlDrg9YbmQacb1WKf8LrYLkytuQSMTOlGg73TfR3J5vOJzGZPDzmt+7ZW+fX2Z2qJTPDyPCSYk/S5ggNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1BeWvg8p6zqHR9zZk0az3M50NrOY4C++cmO+1k0rB8c4j0mP
	oMVyBLPCHFqJpoO9I1abJQwnAklhdqPFnXSlNRYpidWtK/xSDXr0wRblqFrGnGvuU/gS9AbUmDf
	8EgXoihiVobe8yON0zC2H4V1Sor5N/rSQa0u11XacAVgQT4NGltgULEK0sx3qZQ==
X-Gm-Gg: ASbGncs2bajcy3bH3D0QRGz+hpGfYK8goswxhjgFFDTNxBZZ5mAcJcD3I6G0/ibHyvC
	aETLsPKZFq3MaVR4oVm2VvcS41X1XEzi4yukx73iCJWk6k2XOzRuJ5pI7dTRwKWNfaco/jwFwdk
	JFZOTiX8wbD1gVhPDBq+Ih842O6aE99iTNPvQnkOUvFY5o3ZF0t+XP01EkOjyN5WzHPMNsMaJBe
	ip2LJ3QxNCg9+7F3ptdnrNype0Th5qmAo/ifDqLaXNPI8kis3zS9Xjrm0tnyEfK544Mb5Jli4gV
	8Om4AlFTOB1E5Efz+ntt08LBtlItqotWY1T7BXvF5u5+u4F++uqqYtnVQJ8WWg==
X-Received: by 2002:a05:600c:1d92:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-43d509e3facmr158369935e9.4.1742894525943;
        Tue, 25 Mar 2025 02:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgB3O6gG9DIBwRaHL0X31Mvb/WLhRUK8r9nnr/FWmU8azB5KhfTf5kSGnz61tuuks4tGk/sQ==
X-Received: by 2002:a05:600c:1d92:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-43d509e3facmr158369595e9.4.1742894525528;
        Tue, 25 Mar 2025 02:22:05 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9ec29sm144070755e9.30.2025.03.25.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:22:04 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Bao Cheng Su <baocheng.su@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust the file entry in SIEMENS IPC LED DRIVERS
Date: Tue, 25 Mar 2025 10:21:59 +0100
Message-ID: <20250325092159.213463-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 835a0c10d33b ("leds: Rename simple directory to simatic") renames
the driver's directory to drivers/leds/simatic, but misses to adjust the
SIEMENS IPC LED DRIVERS section in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference. Adjust the file entry to this renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6454e171c4b..7a4408512381 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22040,7 +22040,7 @@ M:	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
 M:	Tobias Schaffner <tobias.schaffner@siemens.com>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
-F:	drivers/leds/simple/
+F:	drivers/leds/simatic/
 
 SIEMENS IPC PLATFORM DRIVERS
 M:	Bao Cheng Su <baocheng.su@siemens.com>
-- 
2.48.1



Return-Path: <linux-kernel+bounces-301351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2850195EF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551581C231CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271C155314;
	Mon, 26 Aug 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhmuvRG/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB2155306
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670152; cv=none; b=mbwJtOvqAbwkn4uPLDDEPe+ImyDTYNVB59ZJjmfGy+X2b2XCxL/RpL1NdRoNeD4niZb/3F2slmMIwg5TE65orF6NFUmUgFk4QO4aWWw/0bQWAwR9kiMBXIQpeUuONrZwq8DN/qji46Nl07aOs607zWL1jzHBhK+/spcrENNH7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670152; c=relaxed/simple;
	bh=48zlpe5eFHm/ZiSeAQ9sEmp91Iwec4F8M0gsPdR6/3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjdfS+6ki9cJ8EuHotE4sdTPe0FSLZY/nwzt8bbI1Z7O+nBFvapc49Vavlxc+mrkYinogJlaBnP2CQLSn4qWCFVKMKibWluVfMAZXvMP83ni6Cd5uY7JjpKxp+pp4JwB/Pvj8yEZSFtc6jrvfs5lXYrPO4va4n/OsBd7KUCp32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhmuvRG/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724670149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pvr+QrG/pgMP2il+VVReD+O1xbfry5Yc87wG9Nb6Jew=;
	b=OhmuvRG/G2kWn2ndX1Zkpk8nllEUnNXs/EVirLEBJpCDKpd46V4+GFlTS9C5YsrPlhW8tH
	HmBiVFCJAc+85IdOcIZ9nmlg1dm9Qu7sfXrg9LJCtfQ1eGp8YbWSfgW6xYh2AGgDD7HAOJ
	RechtfxbHuAPYCE/1ZIp4kQFChLI2Ds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-5ndp6OlQP9u6TXvxj6Xgtw-1; Mon, 26 Aug 2024 07:02:26 -0400
X-MC-Unique: 5ndp6OlQP9u6TXvxj6Xgtw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-371b28fc739so2105117f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724670145; x=1725274945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvr+QrG/pgMP2il+VVReD+O1xbfry5Yc87wG9Nb6Jew=;
        b=SzyB7ldVYX0MbQK9vCvlMD9/SXSYQkUCLd8DIkEs7UjamCjeH+2fyFQ6vD/z3Y35QH
         wIgAb2owIXA+f8vmyrZr+CCNWgPB18x8NQ7WtQtyxjh0X6xFKFp6vxjPYsb4e4mwbeHt
         VEvm/r5el1su1IDD/JbIyJoB92HCgEq1NX2DgrrpRPzd3pjzL3bNa7/kXxNClSliCHKi
         9+/BufSjS6WfgGqwJDyRNmrA3rEw9YzmuIsm9Eucx+WBS0YaVVCw0vTpHAAwHETV/TG/
         olXqTnYVILLUD2ihx8544s12TVpDX1S4QS3P6ecEXdHV9gnorcn2mWLM+suLxvNZtc2U
         9UFA==
X-Forwarded-Encrypted: i=1; AJvYcCXf6YnjrdWoK5kScAVVZOLUhrAk8129xGW6AnO/YThXvbJhgG8QRJbNzCOVZtlLVvpKNV+m/VMDXeop+Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmF9oQ1ffpCOmYwpvwJKCzmib1kvObvHGfs6T9rOlx7v2mameQ
	z4bVluqXxGxCjzPiLlFm1EkUpd79O/a/1I6pykAemR2UytyISLceGft+vFtk9egdgkraXEreDUa
	Xwrx7EvPMq3DyNl+8IjJK/I/Eg6xmR3pgKNOwvLiq/Ombv6G47tV3KaZ2o/9tVQ==
X-Received: by 2002:a05:6000:1802:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-37310eb38d4mr6677369f8f.3.1724670144708;
        Mon, 26 Aug 2024 04:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkqciHYg56U090Duq/luQEyfQ7Qmal4dWjb8RsXPZ5dzvrj8LsBmXWoWLxusuMHSs98fNeuw==
X-Received: by 2002:a05:6000:1802:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-37310eb38d4mr6677337f8f.3.1724670144187;
        Mon, 26 Aug 2024 04:02:24 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:833c:88f3:25a9:d641])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ffb40sm10478776f8f.76.2024.08.26.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:02:23 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in MAPLE TREE
Date: Mon, 26 Aug 2024 13:02:15 +0200
Message-ID: <20240826110215.19894-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 0f3b602e1bad ("tools: separate out shared radix-tree components")
moves files from radix-tree/linux to shared/linux in the
./tools/testing/ directory, but misses to adjust a file entry in MAPLE
TREE. Hence, ./scripts/get_maintainer.pl --self-test=patterns complains
about a broken reference.

Adjust the file entry in MAPLE TREE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6aa85a43d8c1..2af37835c735 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13572,8 +13572,8 @@ F:	include/linux/maple_tree.h
 F:	include/trace/events/maple_tree.h
 F:	lib/maple_tree.c
 F:	lib/test_maple_tree.c
-F:	tools/testing/radix-tree/linux/maple_tree.h
 F:	tools/testing/radix-tree/maple.c
+F:	tools/testing/shared/linux/maple_tree.h
 
 MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
 M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
-- 
2.45.2



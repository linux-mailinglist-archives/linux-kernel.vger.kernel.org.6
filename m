Return-Path: <linux-kernel+bounces-362483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D6699B57B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9091C210CC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271AA1946C4;
	Sat, 12 Oct 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIxO+UAn"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411ED1E892;
	Sat, 12 Oct 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743129; cv=none; b=l7fvrn6wL0+CpETt1wC6/x7APvkqEDKeQdnQxZuuK1pISniNCtd2dgmpaSXayCKwAvwS0nZR4voKzK1eTWniZ5GcqF3ewVAtzFfAqbKLaJOhI2ThYnXtVJmApuvxbVxTziWnUjt1Ui21pd0QHvMAD6kaJe5tTEwaeppUkL1md/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743129; c=relaxed/simple;
	bh=6s4+dR6F8h+e6rFroGl/EsRq5g/Wtl+duEVvAzC3/js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AxsfBfYE/iD6UUUA/rm2h8AFIXQ8iiUQwrjNvYhqA+d04Z43gVRQ5pOQKzro1S+toopRXGf+k1DkcpDke/R6JdMsomVsdAPTcT/FkelfpyY/XanD5xR0Eu18i000naZeGAbw+70MFW9rlPpCPRPe15t0iw/kKDRMwjZYPr3ggEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIxO+UAn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea64af4bbbso123661a12.1;
        Sat, 12 Oct 2024 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728743127; x=1729347927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K2nX2QwjAQ13tayvjTv+QasYt7kFsy2YDA8StTcMPVk=;
        b=jIxO+UAnVem6UpNlB5ud3fXeKfawMZtC0AtGu4/QOp0iJbfONSbWv8ktK6RMb5ky93
         XIF8uxgow/q5xQ87jOZ/7/1gYB5k57Qpq2GW7E0bRX376gBI2UbVVq/5iNw3fbkyLrJ2
         85XA7C0O91iDEqBvWRVSMvjxeiQSLzpVK1rcZ5IzdOoIxKvaLn0ggnA3i2CNkmY4ZAu+
         znPHrwQbgw+kq7cJ4x4eD2mN57g9hd+5HFrQ2L8JCvij8yKZaTd1jJ35o5pyEcNTmDI8
         ZjPUWuEZR1L/nTZohTQGATdrlDkjXUp7CRRVtwpkQKlNq0AeZiO4EO1sg9HoNlbWwseY
         7v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728743127; x=1729347927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2nX2QwjAQ13tayvjTv+QasYt7kFsy2YDA8StTcMPVk=;
        b=ZwhqpR0GRUaHTixcHFyOn6Y5BdZLLutZtiQBRPveyHQmNFj9A9eir0m6vTosUFGW5A
         6L40eHkt/1MowgzIbdeagiBQAUdqfLTUV0ZvXwWdjs8XDq83vcoz8e64ACPQ2mXtT3Bl
         2X94yI5UBSNr8X+gwDq5rBEQZkFV8GTJkIzCjzHOVAnaxHv/MAh+bAmDpg1E5/LBPobp
         jVrO4p401tdtEqNlXz6x7fvyTgJ/T2eYzrc4cjbzyP3MUeJPL77MabKqYh14emKn9IUO
         72dJHWaRL+QZu8tgzEmXMHaQm8lziDlqRx15xRARnneXpisNzE9Nk2UBCLOGRAInRJJH
         I2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5LQxwletbeLN0r1Ixfj1ZMQ39bK+PDHS5tgLU+rIixubQjlrPmeDerS75+z7oRWid0e5FlcPODi4=@vger.kernel.org, AJvYcCW8NdV9MAm2QrbpkceM68x3OjANmbdGhS3nvtPA7EY2IOeTYZB3bibVlSfXHtEoos20kYKlDvQ1APwWQbg1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2xT/bUwwoaL717Oo8bw9Az5mkpNee/Zmzv1ngWqhy6lgvxHQ
	SPX8tXyw+kUl2jQya5BJAyFl54Cufdp3cZb/7nxn6FMPWZPOCAfQcEhlYu8pBbw=
X-Google-Smtp-Source: AGHT+IHv+vHrBtdpveO9ZnYW27upHTDCr/ovYCldf0BlIuPbzgrXjgySGiUZ3ouPGeCiKQnVNotpfQ==
X-Received: by 2002:a05:6a00:3e1d:b0:714:2051:89ea with SMTP id d2e1a72fcca58-71e37e25dedmr4098848b3a.1.1728743127353;
        Sat, 12 Oct 2024 07:25:27 -0700 (PDT)
Received: from ice.. ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa9394csm4192999b3a.123.2024.10.12.07.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 07:25:27 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH] docs:process:changes: fix version command for btrfs-progs
Date: Sat, 12 Oct 2024 19:44:28 +0530
Message-Id: <20241012141425.11852-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command given in the changes.rst document to check the version of
btrfs-progs is:
-> btrfsck
which does not output the version, and according to manual page of the
btrfs-progs the command to check the version of btrfs-progs is:
-> btrfs --version

Add a fix changing the command to check the version of btrfs-progs.

Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
 Documentation/process/changes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 00f1ed7c59c3..82b5e378eebf 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -46,7 +46,7 @@ jfsutils               1.1.3            fsck.jfs -V
 reiserfsprogs          3.6.3            reiserfsck -V
 xfsprogs               2.6.0            xfs_db -V
 squashfs-tools         4.0              mksquashfs -version
-btrfs-progs            0.18             btrfsck
+btrfs-progs            0.18             btrfs --version
 pcmciautils            004              pccardctl -V
 quota-tools            3.09             quota -V
 PPP                    2.4.0            pppd --version
-- 
2.34.1



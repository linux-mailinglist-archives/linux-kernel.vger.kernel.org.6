Return-Path: <linux-kernel+bounces-347308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A300798D0CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4359AB223D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2275D1E5006;
	Wed,  2 Oct 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNXFKZZm"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF371FA5;
	Wed,  2 Oct 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863665; cv=none; b=u2J+5LQK29NG14+3GCsvOkmPMEGVquJoFp4tLHzrBHbvA93rZtT61h1Ek+LG5eGQphQY9gtRnAXkn9JVCsfjrASNpz6Npz/tMxa/CtF/goa/rBWkVG43M+Cj+JD7OG/BFGvaR4/6BpGCAylPGT2FPlRFXncjsjN8z8umYf4fcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863665; c=relaxed/simple;
	bh=j1I29XQ8mXrLSwswCRIlUi6uUMyhxI1n2Cui9kEsm+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3ucjY2pIbq+9byQHqQKsCs4KS0gXLESjzWf03DXj0ZppKGdgK9l//sgylWAacXRQ2F21LML5FB14tZG62DnL2lBla6mOiN13JG8C6lYQtHJpfvTmsYr2knaE3ZOGtJk7dVqN5IJmNk9ChTgQzg1jRCPeZDydzp3ABqVUL8eB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNXFKZZm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b6c311f62so34656705ad.0;
        Wed, 02 Oct 2024 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727863663; x=1728468463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tV/C9A6z+okmZCmhIOCu3MepEGocH+yz/Qm3k36Y6aY=;
        b=FNXFKZZmH1pxvzjj5QYgr8e8yhZTfhzsfeyt5RXl1CjjEhjdAlekyyKxSxVOi43C0s
         7tPJtjyEzJlIGjDh6XZGwRgtFscCNUcbbEG+EN7+sQANyPQi9wWraRHHMzftyJChQawq
         4vVz842GA09COxMVcd6AqSyPqaUb6XLJTaf9RgAhWV1ynDv5poesnx+stSpd7RfOd3j9
         NPUpBJILz5cljnQDSNMaJ+HwAr3kavOSJ4lHot94qMlEibmgUAFxHgw/pEjyJaex4VGx
         8TUELbLRobrURr63KQHXT+QKy5XrDjCZaJI676KhJJEkf8mXvjkUknUBFCbQ0tGfhcfI
         w/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727863663; x=1728468463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV/C9A6z+okmZCmhIOCu3MepEGocH+yz/Qm3k36Y6aY=;
        b=q/BZeo949/p/HcIXqDt2hMLWetzGhGdaNDF3wCiCSdHsEROm+3iL1jaQWPEXc0NFz9
         XAFfWE16Q0RHky+FZ2kmydWTYimApyq341HB0oo/SwGp3LzWBHon/KOyv5rVZIgpXqpZ
         uS3AEBzOGAs3z+y82lQLKfgtCPDK55x6sDz8idNtv45jn+QTYlmDbzz2TCHgJxBEigii
         fUkn7g89+87QM34/iVwanLw748i9vJdkAspkqyGMVfPBsluQClcL2ngWp9wznfbqpP4p
         XIjRq+QX0QgXOXOM8ij+e45LbNpLwAbCMvorXB2I5L9gUlIeJBsi3I+3+wB8esTjWUnT
         YOAw==
X-Forwarded-Encrypted: i=1; AJvYcCV16N2w6a+e+6XevuACRAUQsaYYKX/x4BmrS/fZp6XYpfKVBy2WUcNYIupvurTrGnGIvhAFSF4cZA5hrHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshQJK3dJbvZy9a/Y8zL4oAeCMpLg5JcGubfnpDwjHU5PnfhSi
	mBmIP/J+NvGcIkePnkB8XEvoL9rQuCOHirIud+fKNe3M18SB7Jz3
X-Google-Smtp-Source: AGHT+IE5Kvmwza7olRXzEfcv+X1n3I+DHqFDY3LHvPeK72dCi+s3ObJ4AaksRTd9efXF/RtFJbH4Ag==
X-Received: by 2002:a17:903:230f:b0:20b:6d47:a3b1 with SMTP id d9443c01a7336-20bc59ebbc3mr35489505ad.21.1727863663554;
        Wed, 02 Oct 2024 03:07:43 -0700 (PDT)
Received: from vishnu-pc ([210.212.232.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa0506dsm1159908a91.46.2024.10.02.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:07:43 -0700 (PDT)
From: Vishnu Sanal T <t.v.s10123@gmail.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: [PATCH] fix grammar on false-sharing.rst
Date: Wed,  2 Oct 2024 15:38:53 +0530
Message-ID: <20241002100852.70982-2-t.v.s10123@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix the grammar mistakes on kernel-hacking/false-sharing.rst

Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
---
 Documentation/kernel-hacking/false-sharing.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
index 122b0e124656..ad7cb60bef29 100644
--- a/Documentation/kernel-hacking/false-sharing.rst
+++ b/Documentation/kernel-hacking/false-sharing.rst
@@ -196,9 +196,9 @@ the hotspot switches to a new place.
 
 Miscellaneous
 =============
-One open issue is that kernel has an optional data structure
-randomization mechanism, which also randomizes the situation of cache
-line sharing of data members.
+One open issue is that the kernel has an optional data structure
+randomization mechanism, which also randomize the situation of cache
+line sharing among data members.
 
 
 .. [1] https://en.wikipedia.org/wiki/False_sharing
-- 
2.46.2



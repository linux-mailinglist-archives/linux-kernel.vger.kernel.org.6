Return-Path: <linux-kernel+bounces-517332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6393CA37F54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DD43A43D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56221660F;
	Mon, 17 Feb 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcyc1gzw"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268262260C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786739; cv=none; b=WQC5MA9ik8hATnIStAqPrUTyzgPcsDQBVEq6lKfVXHGrr9m5ZsjiS4F7ruxctWEW993lE59rINYBI3VBb2ywEpIl3X76Sk+UpJGdWgdvLPX+KKsya9hn+9fARckFpYC9oPQsB+CiLBMpVTorB/Gw4eBjGP1yU64BaZmmzYmWeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786739; c=relaxed/simple;
	bh=3jgBOSa3D+X0g/hAdlexzK+wA0bCemdDQBe6UWljxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bFBwx7RUVtv1VCN/5OBhm3Gc9Q0IZeiRdfC18cx2oz9sk3gGsUtlABQBEVCN+GDOXDaVIvSq530xJ4+cQgsGDHJsjXK5XBn2NYL0olfL2hcVPdL+B7PDOUHUZ6ERKNFJhERZEOhPC5DSaKEqEGzB3V1xbHlxB/RhW0FlJ3dNpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcyc1gzw; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-220c2a87378so57347915ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786737; x=1740391537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=har9C3q0z1JARfPuvDnkQ85Yn9EDW13OUXY77oUlYjc=;
        b=bcyc1gzwib6YSsPYoy+yifqbtVoJSBPxNg8p0JOb3xWtzPxIHGvmT084+Pg9qu/Ict
         78mnN8RzFvaEmcOHDnFVjVTsG1Dru8WEgbIYet2nrj41tCczPknKUcaej5k8tBd425cU
         4H+gqtpmvmgat15pafqukti504AiToBNd+8s50Ix+7Jjhr9/PXblU+iRS7mYVXdq8T4r
         LG7VTglrC10ncPR+uGLjIYtlJA/GriAzDjGPdDhymIskCNq2f0fT1LMf6c9jI+xiayi+
         PTTth51cTjmUhqVKYxy4o/PVX0lMjywTA7nJAo0iHkDYYKr9kQOyihksHj8dVJuB5gkQ
         3WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786737; x=1740391537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=har9C3q0z1JARfPuvDnkQ85Yn9EDW13OUXY77oUlYjc=;
        b=YI8ClAx+smF0vEPKtwwTUrTLXk+NZvRdxq2MXftepeLfDVZDD9/LcrmfFt4D92aopG
         ygYxVJJ7l5G+2kC8HH2yrR+W3cgS0qj0b0YHjgRhNSC9DYBWGM0b8R67fvCErxwLTX1V
         PbPdtpym/gu5RFvSCk4O6fFcr7Dk4ocGzrhNNQcgftqDm8TFLQ7tgRVPb1dTxH7UhdNK
         UsmaC3BYIWqN06QXosRXGiGQLVak8SPRyZEJj05LnmpUkXf/fSHPMETCQFo5U++f2pj4
         1dxXABWa/xIJdPCzXcojJ581CTucObuzYk6euV+8oxqBF4oqOvys2iEdGjwhht80mfDB
         W4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCURxASM1d5+ttMR8yLm1QC/ggX/xBH2KVIAPCUDUQW1AEeVrZPH3+5HQ0h+EJ0HqsU1zMxDRGTNVImfD3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnElatcsn6tLD8VOW6abFSPz1OotLo2Jt9RmS7jz+qexBL0fos
	flQzY0FCwU1WQQmc0vB5fB6WX+MRVPvhtnE4jlwpp23EI6Hmk9NY
X-Gm-Gg: ASbGncsRZySMzIrP3/eCyzcX12uNeEYthZuoGa3zZ6KLUOVoe1ZFiBR6LDaZOnUBJd4
	Fi5P6OiPe3dOMb5KQg9DOuzaqo81s8tp0/V+h5aHNX+5BFP3WRgKbYXbytg6ctrNbh88/4zx/RO
	s++jodsxRoQHPc3uYPm2p5G21qDfexXNCMI26xNV5+/yZ9BBrxrPxsRPkAbRMELdA5h9vrd0JzH
	158oF+9qyYujQZ2DJEnI7In6kx3TPTiTEKh6QJ0L1B89dYpy7AM4ObjpByDi/qbyEWZ1zGFV+up
	wSwexjueJ9CErQpttbd1
X-Google-Smtp-Source: AGHT+IGU0+B1gfHA4wYrcfYnjnFpOKwnU9J+GSI5umSPco+CyZ7+Mefz0snJ8m0beCN0Mpz9nRU0ig==
X-Received: by 2002:a17:902:f54e:b0:220:c63b:d93c with SMTP id d9443c01a7336-221040d75a0mr156557235ad.44.1739786737260;
        Mon, 17 Feb 2025 02:05:37 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53668d1sm68311605ad.75.2025.02.17.02.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:05:36 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	dan.carpenter@linaro.org,
	rmk+kernel@armlinux.org.uk,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 0/4] staging:gpib:agilent_82350b:Cleanup and spelling fixes
Date: Mon, 17 Feb 2025 15:35:09 +0530
Message-ID: <20250217100526.49495-1-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

1. Fixing spelling mistakes such as "havn't" → "haven't"
2. Removing unnecessary commented-out code
3. Cleaning up whitespace and formatting inconsistencies
4. Removing a empty line in if{} which was casuing it be read as single
line

These are minor changes aimed at improving code readability and maintainability.

I appreciate your time in reviewing this series.

Thanks,  
Ravi Kumar Kairi

Ravi Kumar Kairi (4):
  staging:gpib:agilent_82350b: Fixed spelling error
  staging:gpib:agilent_82350b: Removed commented out code
  staging:gpib:agilent_82350b:Removed blank line
  staging:gpib:agilent_82350b: Fix Indent issue with block

 .../staging/gpib/agilent_82350b/agilent_82350b.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

-- 
2.48.1



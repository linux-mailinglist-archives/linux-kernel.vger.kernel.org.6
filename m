Return-Path: <linux-kernel+bounces-381062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACFD9AF9C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFBD1C220FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CF1AF0C5;
	Fri, 25 Oct 2024 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFnRCFou"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FE18BC1C;
	Fri, 25 Oct 2024 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837095; cv=none; b=l3yOUdqtYYAeBNhRxleeV7Q5iXgj77q9kdL6Ny7PyQi+LdRPpS/Vqj8DuHZU0hpnPv0p32j9kjzSJPkLgtWFro4q9wBW7rdfYgg4l59vPJoZGXh6s2WwsoIBSMmmhfxN+HVLfkc1UIieIMSQOIC9RGxn5fQ5s5IWCF8xZL3Lk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837095; c=relaxed/simple;
	bh=JkVxwSDcENFPZn6K/Zydj5utJ9l/HWBLCiLZGioBY8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SzZCYhPQhIfXkBvPPW1Z6wEg3n8tW2/spBXvt59AxKvrLtJ2Drog61EP8mKxUqb4kGzNpgBzk1JjkJ9e6gbsXUe8wnUZ/nOOh06gyA+xCux6a9qKeD7ZC6mQpJzf+rhrLSFgYjksfQ7Na91vaYhZQDP8XEQVDIYt9tVG4FmFS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFnRCFou; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7204dff188eso749922b3a.1;
        Thu, 24 Oct 2024 23:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837093; x=1730441893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK5Duui3kASIa3spQTKNW2Jk5UI33TuOf9RbloI8uF8=;
        b=eFnRCFouB3cgWKzMdg1kJo9qIte0znbVJ1Bk59Q9yVlx6MPJ/1cCywlW/bOHbyt9VM
         P28iF9kMusbiCj8dJn556bsExEWeCLdznrYc93c3YCFnzZcM0yI9SlPzTLhxPGwb3NQ7
         XA0dfzbdZdYSmLvygNMsK6tDInWRmLB49zKplTPFtRyrUfL7mcfNNAg+LT/UZNSNkDVN
         NbimdUtoYHeAMOXJxzjWdEcAsxcWjh79u+NdVRhIuL31DXgxcydHcTA2bT6UTsVSFSPH
         7sLspPL7/3F/09BIQr6ZxSODrRe6aZ7/yWUui8HJ6Zc35EkcxAchhOrMarOhuodqoxnm
         RA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837093; x=1730441893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK5Duui3kASIa3spQTKNW2Jk5UI33TuOf9RbloI8uF8=;
        b=l2vdu0I2pGXoB/5GwdJ8YlkIFO4sYwuEXGMFlYTgg4X6ZoiOjsR+p5ghQGE210T4Y+
         Q9gvGcXxMu5K8p+7V6Dx7hUIdr0Ub11K+xWTgeqPEL2dkV8tcXNlzZck8/AWEA9cGb+z
         nnWfmFdwJIjo9tgIDnoBv0N9ideH++Ll7FHhal+ApeX103Q8CNirhTodnlQvHZj5UMFb
         SFExPsM/TrSTmQdf3HupyEo8YEfzB/WzLDGf6kSqdXV2oBkmgUnuJfDEhLHaGnm7u5MX
         mQ8DDRximvHNfB4Lfjten6l45zhq6ETuatXDth+A+JqddsqI0M9X+U+pHIO8zzUeqYvd
         mxpA==
X-Forwarded-Encrypted: i=1; AJvYcCX3j4pCglw1GeJMb6chy/GjzgJlVrlrQ5UI2p6y4cY+vblfWp013n5gfVFHbZryq27FDpI4IUJpNqAcXS8=@vger.kernel.org, AJvYcCXCWLrijfAOR4e4Z0a9i62rk8cOR8ORjf2gs11muFTX9K316z7P74CJKWSq3CMzrH20tsM6n0mHaUHJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNRUtqdWZNz9teJqkg/iEWv4V91E9VPdqmWOOJHFj1u9cv7+Z
	JsjJVlLq36zIRkbItJ4jcpfHy1sEKpAspnnPmlIUISBAlWv3f+Mm
X-Google-Smtp-Source: AGHT+IGClwPG64o4YQmzYjwcEeV5Myw0rkXK2XjZWq9Wyfrdf2P7deYzyVIYwf9Wx2RwqVh2DIHrrQ==
X-Received: by 2002:a05:6a21:9d91:b0:1d9:18b7:48c with SMTP id adf61e73a8af0-1d978aebd41mr10693971637.6.1729837093014;
        Thu, 24 Oct 2024 23:18:13 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:550b:d387:a102:1511:5e8b:8a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm2566697a91.43.2024.10.24.23.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:18:12 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH v2 0/6] usb: serial: mos7840: Fix coding style warnings
Date: Fri, 25 Oct 2024 14:17:06 +0800
Message-Id: <20241025061711.198933-1-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202410250141.AEkzzW60-lkp@intel.com>
References: <202410250141.AEkzzW60-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fix all the coding style warnings shown by checkpatch.pl

I have tested Patch v2 and it has no driver build warnings.
Please have a look and let me know if something is wrong. Thanks.

Tony Chung (6):
  driver: usb: serial: mos7840: fix warnings "no space before tabs"
  drivers: usb: serial: mos7840: Fix Block comments coding style
    warnings
  drivers: usb: serial: mos7840: fix coding style warnings
  drivers: usb: serial: mos7840: using '__func__' to replace function
    name in dbg message
  drivers: usb: serial: mos7840: replace 'unsigned' w/ 'unsigned int'
  drivers: usb: serial: mos7840: fix the quoted string split across
    lines

 drivers/usb/serial/mos7840.c | 49 +++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

-- 
2.34.1



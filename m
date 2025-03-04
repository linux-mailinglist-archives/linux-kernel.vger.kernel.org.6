Return-Path: <linux-kernel+bounces-545447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10469A4ED47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B43016B636
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CE259CA0;
	Tue,  4 Mar 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXV04OoR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110F255244
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116378; cv=none; b=LvyHTMnr66aO43JywwHtDLiyRIbPcb1oYRK6uosqtHvH5Xc4hRbwfvKNMXpNgKpx/jqNqN0sDHtaN/LT2mCMU0daBc1mm/Kg7J+pkq2QvqAyh9xr8cn199WCoUHvhGygbf3QWSyU2JGHXxCwXK7/1V9augUwrL/tdGTMPMBDxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116378; c=relaxed/simple;
	bh=ctMz1e2CGC4DkzZBkLf4JtpwG8U/L4qitQ9Gn5V9CVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ael0jVK0OeBTEK81qRVDXts0BmBlIrS84R+vM5LR5Ig4ruVSLh7/JiPAWdqg4pNSxgd/YH+Oya9H1jKIW73GuUQXwu04mROx3tH9iU663ke3Via8kCrediFLkCN1zK1b8dlxDj53xo0DjU9aT3A4JMktIZ23VLOl1ye3ir+jmvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXV04OoR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f8f3bd828so12543335ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116377; x=1741721177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy8V4gjtpPMBJ5TaQITNkgOEfjsL8exmFfrxFWgLLqc=;
        b=lXV04OoRE3XSstj2sGAnZHWPE3EkSvSjb+vlWMb9tpaLq5NrjSOS/Gqh11J3dAj15g
         JLxdYG172cSfgl9MRbT3tOVJ3CkTe8tLzbea3befCuo/IRlU8ogm0M99eVvseUCivIqz
         no8LqGvA5WZf9I/hKEV3W2rNTTBdyeHhIEwS1MAb6F666jxg4mVqndkDaRxctFQ+k2BN
         W1ggX5gWZYp/GmemBLUk8wSEYV3nC+DACw53UTMWuc6nomXCD7LwSLHProWZGCm4RHg4
         5ajas5hive+O+tYO1TeUeXkwiBlDkEajCOduYhmmAIBHpCTTNydJ1KZW+trcBOVo2+OU
         rIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116377; x=1741721177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dy8V4gjtpPMBJ5TaQITNkgOEfjsL8exmFfrxFWgLLqc=;
        b=SYh0hd3ElT2meiEPr91wezee8go72TH2HYgQsL+YSI9+7ZPT0RQObh7T62xlkbHS9/
         6LAAQGvN7C83Zuj68b05mW3nP9YJ+DYCLlFaVx2vl8oc+LW5pD8WmPQJmVBsMAPTd89W
         DZ3YA+iLHLYexFp0pUqkaJ9Jvn7/KM8Ya9upLXLDZjKBfssw1r/EpAflFx1zQ5bmpH2c
         FHGFxotU4JvRoMS1ODJ/w6bXOwuYqyNg4Kbb9eBI93qfu3LvvnTa9HMpQFWO2PbLL8jj
         /L73RDKoBz3nkUdp+1Pax8wx1GzC28x3RSIjdm7pG4HZ3fGuM1kNz1qbBnCVAeVkPZnO
         +I6A==
X-Forwarded-Encrypted: i=1; AJvYcCWa+mjriosIUB/AlOg76Mk4JOw3Cbdj2Q4G3BqpMG76InrrrQrqysnOncGVw/GaEcUnWluijtXnarz28LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DewloMB8Ha3p199Cqssl1qsd4xhSHlGkHS5v1/Vzw8qJ+DUR
	xI2gQ7p5dAK9n8anxvmhy+h1OTF0tNTt1cZhv0o03mSNomGYlC/k
X-Gm-Gg: ASbGncudYa3m/HElbNxmz4HH62uol1FjfyW8ApsxXzq+Y0dbDpkUCafdGf8q4LusC/7
	cAamzOeJELRtrnNydUdaNfg3FcTfazlIkwcJUJHld+nUEzAl+or3j4CHXKPYxPKIgVAH1W7yoW9
	vQk4Vx4ID5+xi3dkeFm+ZwvFOpUbeuE/LzQqtI/TaKoj+4YSF/4ZSBpMnM0+TZ8hbFxFbwCel4c
	H/0b4y+aJkPV6GJPuB3k/SX1hh8AODxQ3MsesYuLDIdrCdblcKlmcO1kCspHNTavGrbxAXoEyHs
	HslZmUrKzWoxFHrDApa0UF7JaLRqI2SZYdnNfkpZLijjLc7zlyuVG/SLkw==
X-Google-Smtp-Source: AGHT+IEuEdk79yHkkrNDMvuEPkBCk96IopRp4oy1rlhPhqXw3QwUgWZiPYT5dvgCxIo6wTTUMae/qA==
X-Received: by 2002:a05:6a00:9a3:b0:736:3326:2bc with SMTP id d2e1a72fcca58-73682cda4f3mr39951b3a.5.1741116376754;
        Tue, 04 Mar 2025 11:26:16 -0800 (PST)
Received: from localhost.localdomain ([2802:8012:1f:3200:f1d1:c186:ba5b:8f06])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm9341920b3a.60.2025.03.04.11.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:26:16 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH 0/4] staging: gpib: some cleanups in lpvo_usb_gpib.c
Date: Tue,  4 Mar 2025 16:25:35 -0300
Message-ID: <20250304192603.40565-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series comprises three kernel-doc comments fixes and one commented-out code
cleanup.

Gaston Gonzalez (4):
  staging: gpib: fix kernel-doc section for write_loop() function
  staging: gpib: fix kernel-doc section for function
    usb_gpib_interface_clear()
  staging: gpib: fix kernel-doc section for usb_gpib_line_status()
    function
  staging: gpib: remove commented-out lines

 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

-- 
2.49.0.rc0



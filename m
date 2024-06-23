Return-Path: <linux-kernel+bounces-226361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB6913D73
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51A71C21056
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2409184107;
	Sun, 23 Jun 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHJSq4tU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680931836F5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165408; cv=none; b=bjzNGnYduZNpUO0uAUgc+q2QG/8o6nsflTwXViG92JrJOd7IkxE/J0bXnG5Nc/RPzfMW0PmZ9EopuV2BJiXLju+4rkkzLHw5Y51laYMO3WOY2EcblVXt28LAGxfgkXbSnvl2LWAj3LIyYhWxdBQg3UMB0ZnkKZ8b6Da0FkmYP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165408; c=relaxed/simple;
	bh=NEQg9KRmaj4GejKWuVZdgxcCeAn9W3kFUEPyebIC/Ds=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e+ONpKFW5F+2TfORVuapwqUmw/NYPwC9Jyk+sPCalkLQKxjPf3kQXiTWJsB+BGYGxB8rN4E9p97J9U1f99kgcHsR2diNQotQQVAtVFBh2BN9uuwQiy0Xga+m29ub4cCLlEfrsJnBv0UswrddENE4SXJdFGarNoZ3+HXUCU+3ISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHJSq4tU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6266de87cfso25076366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165405; x=1719770205; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaVixSxnpxz/zXU0Xcv1P6HLSmHwk5egXTqsZJWQOvU=;
        b=hHJSq4tUmu577KGONmj+EKEfidCNJpnFOwt4FDHWexBflVlBSAhrOz7MLpGeRq9TFa
         ZgOiTIen64nG64QEyR80LKL5bXu+3OZrekgdzJAvdXeK0r6w4ZhTPG/9qum74Ht6W9Ln
         ZWlBBM8OlhNmQwJBYQtH/5TKeaJJs0CVioPypjk93NDQVkxfp+3b+WRXB7oCoiE3jbvM
         egTQnTdRaS/H0V5VKITpfOVm7IIArnZ0EpJfzLwfYcuX3+99nf6JYLyp1s6jqCp+H0nt
         kNW+H2UZ8hCfghpK2zWrOkTqL7F2zBLd/CNON3VDhj25s7iOM+rXmcMIAkXZTkbAm1AF
         4z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165405; x=1719770205;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaVixSxnpxz/zXU0Xcv1P6HLSmHwk5egXTqsZJWQOvU=;
        b=b4uaESs7+D5uKOfsRHSLRPhpKpflTyVfsVg8BvgPbsN4TIladF+Cv4NpPsM5g1KbR7
         +56Hf7XOzgEyUXI1rp8mXBXlhpOFcDBuziDYe/cmCZWwK8FAIV2NX4EALJwupjA85PmY
         svVa6PILYhTiBZ4SD/gkLf5Qz02sCM7qjQfWzNuYKhsiuAoeARxtEDXV8/THLisJt3Lj
         VA5m/w0RYWFuTTXxCqqnEIuHim6Jw6W5gdNvvNu9mUSmN4aI2DgmJhQRDPLTyb00H0d/
         qKzQS/CNx5c0IgVsRbpd25UKW7mKeDinrtXgXeCo+CuzE7o2lM9oQA8LI3g84ZlqYRUn
         omNw==
X-Forwarded-Encrypted: i=1; AJvYcCXG9bPcWvrb4b7CGj/EcJlN/k+uM+MSUMfH99FoTIoZkkX8O63EzuesYpZLocDBdKoLIuUbQmFwlhXvZvwtPEbj6egRS4ulnvUqF//c
X-Gm-Message-State: AOJu0YxinrSK4Wy0mp6kZKg1IArxdBapeYGk6V1gf00MzZSjErofUIwP
	HI56mxetHEVQJsiJQ87pWighxsJQnN/azy3YGiGHZVU/VH8rZxxale4rBg==
X-Google-Smtp-Source: AGHT+IGPfFkaWRZ0vgLS+A/4aPe0Y/gdQxHN1r0qn7N9nwEXQgKaNd0Yw3z8U28XxClPdrv+eMixpg==
X-Received: by 2002:a17:906:2a14:b0:a6f:bbfd:39d1 with SMTP id a640c23a62f3a-a6fe087be90mr271133066b.2.1719165404319;
        Sun, 23 Jun 2024 10:56:44 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe5e27995sm201392366b.0.2024.06.23.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:56:44 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:56:42 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] staging: rtl8723bs: Remove unused macros in wifi.h
Message-ID: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unused macros, structs and function declarations.  

Tested with rtl8723bs in ODYS Trenbook Next 14

Philipp Hortmann (14):
  staging: rtl8723bs: Remove unused structs starting with profile_info
  staging: rtl8723bs: Remove switch(type) as type is constant
  staging: rtl8723bs: Remove unused declarations start with
    sd_hal_bus_init
  staging: rtl8723bs: Remove empty file sdio_osintf.h
  staging: rtl8723bs: Remove unused macros in wifi.h
  staging: rtl8723bs: Remove unused macros in sta_info.h
  staging: rtl8723bs: Remove unused macros in rtw_xmit.h
  staging: rtl8723bs: Remove unused macros in rtw_security.h
  staging: rtl8723bs: Remove unused macros in rtw_recv.h
  staging: rtl8723bs: Remove unused macros in rtw_pwrctrl.h
  staging: rtl8723bs: Remove unused macros in rtw_mp.h
  staging: rtl8723bs: Remove unused macros in rtw_mlme.h
  staging: rtl8723bs: Remove unused macros in rtw_io.h
  staging: rtl8723bs: Remove unused macro in ioctl_cfg80211.c

 drivers/staging/rtl8723bs/include/drv_types.h |   1 -
 drivers/staging/rtl8723bs/include/rtw_io.h    |  57 ----
 drivers/staging/rtl8723bs/include/rtw_mlme.h  | 156 ---------
 drivers/staging/rtl8723bs/include/rtw_mp.h    |  29 --
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  38 ---
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  16 -
 .../staging/rtl8723bs/include/rtw_security.h  |   5 -
 drivers/staging/rtl8723bs/include/rtw_xmit.h  |  10 -
 drivers/staging/rtl8723bs/include/sdio_hal.h  |   4 -
 .../staging/rtl8723bs/include/sdio_osintf.h   |  16 -
 drivers/staging/rtl8723bs/include/sta_info.h  |  44 ---
 drivers/staging/rtl8723bs/include/wifi.h      | 299 ------------------
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  15 -
 13 files changed, 690 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/sdio_osintf.h

-- 
2.45.2



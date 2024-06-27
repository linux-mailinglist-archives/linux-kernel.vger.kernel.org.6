Return-Path: <linux-kernel+bounces-232257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06491A5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB96FB26CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C71581F9;
	Thu, 27 Jun 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="3ExhrygD"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53514F12C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489366; cv=none; b=hEB67XF2qwaaHEVGSxNcL4rJgrUYlRp81iFu/52r4PgrezAHxR4zxH8sR2VjhcPugdGspfvNSCFN1O8wkeh/9yUeGrI2G873ZV6z2+iRa+1isiuXBD7ShAoB35Ghrh3Lhz4Yj+rhyQZwR1+Hc5ySQBgN8Mp6FQP304DOKfpdq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489366; c=relaxed/simple;
	bh=FYwN9+WXxNL0s8JGZrDOOlC0+Oy/VpiVqU6F01gXKwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu8RVZHIZJ7utm8sEJN5oMkUkV1lrllQf8jyDL5g27YclhesiSnIgDppIrr3jSs2MxYwQWv2OgbJ1I4gUYS0IrEZxvUSLNVMmJpMRMmvZVACW/3RCiDm4xw0aaJ7t8I06MCY2g4pvT6u53DDX5t0fPoiwfi6iIbmyad7fx1x464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=3ExhrygD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ce6c93103so5780764e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1719489360; x=1720094160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYwN9+WXxNL0s8JGZrDOOlC0+Oy/VpiVqU6F01gXKwY=;
        b=3ExhrygDHAe3ZViPQGR8GKO/CNpSx7vvhN6oSw4yhzEFiBAvglmdNhd3tEr4Zyp8vd
         5HJlrIVfa8yCHDae2JmFxExJ9MKwKRNv2UNCzArhzyTfF2hUoAcNKGJJ3MsJPyBq48Nn
         kiaf7KKrfwtfi3g8HPHUHYdvH3ErbxCAnq2F8AQqynbftHdtdjoqoeMRwnkIoAHm9zf8
         zk/GVeE5rzRBnxKlKjMo+nFWUwMchFCneSpVBcsF+sJbggoCrfLXOFGxAVKVdMdQMfnr
         BaGMSrihD8K5f1zgqclrEYy6Cb8Bw1w9KpoKLNJJjuePbM515qHcHtMYlx0+c3vxt2uP
         ExOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489360; x=1720094160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYwN9+WXxNL0s8JGZrDOOlC0+Oy/VpiVqU6F01gXKwY=;
        b=IpDizEMzQfzGTy2eUVqiTbPlI4G6evixbnfvfH3FF/rlRjrd1ddRPVA69ftIIcHKTn
         1nPAe2r+haXsyTBiGKr2ULWUeAWoeCRIkTSlomutR+DB0JJ14eB6R9RgpHbtJ+3JyUft
         tYhDM/OtkjZMTNGQIx4HWWldcLAq21cg5mUp4JJmErkD8TIJSIEDMnPpfGnYxPUrNGX1
         B0TufSaUw1zMk25nxvGH7bO/iwnm9qOCnfdD5r2dfZbYD5E2BM82Hzs8j+P+czdX8lVQ
         W3T8PPXagjGbebDj5ahSEb3CdmDESCQgObLS9ae/AwcecNjjXg6M7ta1Kp2uRl0c8YZo
         Tjow==
X-Forwarded-Encrypted: i=1; AJvYcCUqhNn0RA8YJOHoeyKwtE8ieeN+nnTDfRTB4sTHxt/d1XjetTlcA0W3dR4ovyh0qDozTSxd94xqMV/VffmIvWRhLZIZTbiZzEiNkejA
X-Gm-Message-State: AOJu0Yxyg2WPomCrNWDRE/aXM8mpF2Fu+cK8CSDuGq5qaPWHUltP5c9k
	6rX/ezX1RQUXbKfcKGPhyUuiqPMlYfjh3jM/Hdm8WxJ2GL7ZXxb9/A9kPu1T8fQjSsURctH1ZLl
	1
X-Google-Smtp-Source: AGHT+IE5dEqi32o555lHsYH6cLbWsYyak8HFjN733ejp92fah5sVWgpO97Hsp6G9Neyybv3KzqjyMg==
X-Received: by 2002:a05:6512:324a:b0:52c:deea:57cb with SMTP id 2adb3069b0e04-52ce182bccamr9414630e87.3.1719489360229;
        Thu, 27 Jun 2024 04:56:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a31a:e140:9480:20a0:e0ea:447a:fdd3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d779773sm52072066b.103.2024.06.27.04.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:55:59 -0700 (PDT)
From: Michal Switala <michal.switala@infogain.com>
To: kalachev@swemel.ru
Cc: davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yoshfuji@linux-ipv6.org
Subject: Progress in ticket
Date: Thu, 27 Jun 2024 13:55:44 +0200
Message-ID: <20240627115544.1090671-1-michal.switala@infogain.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZnWSHbkV6qVy1KHd@ural>
References: <ZnWSHbkV6qVy1KHd@ural>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am currently looking at this bug and checked your reproduction.
Unfortunately, it doesn's set xfrm transformations in the same way as
syz reproducer. The effect is that in xfrm_lookup_with_ifid, the packet goes to
the nopol section instead of notransform as in the original.

Regards
Michal


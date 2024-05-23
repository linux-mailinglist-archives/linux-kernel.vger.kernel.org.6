Return-Path: <linux-kernel+bounces-186870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173E8CCA35
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47F028273E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E241860;
	Thu, 23 May 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0JSkKx0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035515A8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426217; cv=none; b=h+JE6sEclWwmXyLsARrFtnn5VDCog61UpX9grfx/IWdHojkpigeUNljbibjihQNRZIdeN/Ncnj5OcYApPIMmDZ5hTgJhB/WZUK9DfwzJRqbM3BzgQWil/Cbbk4vhI1S9W8ZH5h9aDC8YN/QqKT+s9ZYNqftFK1TP3d+J2U0Ly8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426217; c=relaxed/simple;
	bh=uFhi1LYbiYEkxVyuLVKDEOWdqFUYbBtlQuarySVBmoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6UuBz3+dYeLQbDbSMxcNG/cFtH/gY3fweo/MRY5m7KREzClcSxXXNmjg4FIzyMvsCgtj7D1phyxdpCDyyOTc74LutnRWX0axwGnigsCCFIEXnGPba+noEJLeizbaaiIIuFyTwBn4JH2p7ywqxamygy1mY/PAhovr5u2dQACd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0JSkKx0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f304533064so11087905ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716426216; x=1717031016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6HItl0WzyFaHz5B2bjTt/96lgu0ggjCZjX8eItprb0=;
        b=h0JSkKx0XrtLAMdt010F4ZDSGAqwi+VBkYwxjHgnTMpd5iEhByWip382HkOcVPAxmq
         WwI845t5fKu4HZu6WcsUQRMpBQeJPGmR2r17AJLbblP69VrW16cRmeK5QZXiFSnWoQcu
         wAETD7x9nF+MBA1Gabq0TqatGlFrEjRygLm+vWNsAkHe+X+8ZMHmzBJSeTLJ5oEBCGBO
         bYWJRoVu/jf586EJbZY5lk8xmkAzlzBeaLw/Kn2AcFuAUZXdUqt/HuNh579ig86GR8Qo
         OIWxR7h9DCFUE6a2R8EqXVxZ57FTmBEkAlkb0s7S00FcwJ2PuhoHzKqGISoE8Sxj5d8q
         2JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426216; x=1717031016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6HItl0WzyFaHz5B2bjTt/96lgu0ggjCZjX8eItprb0=;
        b=FthuLsOU3vR4KWFG592FMS9LJjMjrYkQyk5CXYKLPR5B7vLk4VNTURmSdXHO8HDhLE
         1KArK5wGNWnFTeeGUibwQtdLWng03fubtneKIXmx5N+kqVb7cja055n+Jp+6ObqzbC1K
         0eZTdOSTBdEfy+u//ZWT2PJD5nIhGCcckhaxcbLY0ZAM6U023PeucgDyZy8O2NQuZuQQ
         gpVyvMhk29ODDIcF548564tSDW00iR9VW/Nqb2ThbNNV3LoAc9F5LzLBlDUODFkuIpIZ
         cRndX48Olc/UIuv9za24AP22lB2UuYFAfC9Gc8KFx4gce4jEFkLRfoV9aZjyiVNeoh+h
         p9XQ==
X-Gm-Message-State: AOJu0Yz0L3eBHKP0RHcbliRST9WCC0gUJpSbw2aGzLU0ql7LJf/XDk89
	VqFRtxAmSpjgoLKc2h7WzhEjhk64WXmyrSNr4AnZ+A0n14Y6Ibu5
X-Google-Smtp-Source: AGHT+IGy68VMWFIl6vJbvB9D7qEuijxTlLO8QZZrW8K97/AYyT505JHESS/Io/dx60OHGWweQC/HjA==
X-Received: by 2002:a17:902:e552:b0:1f3:2451:8de8 with SMTP id d9443c01a7336-1f339ef4886mr12683535ad.7.1716426215652;
        Wed, 22 May 2024 18:03:35 -0700 (PDT)
Received: from localhost.localdomain ([111.196.74.188])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d4828sm244348265ad.20.2024.05.22.18.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 18:03:35 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	Xiong Nandi <xndchn@gmail.com>
Subject: [PATCH v2 0/2] scripts/decode_stacktrace.sh: better support to ARM32
Date: Thu, 23 May 2024 09:03:16 +0800
Message-Id: <20240523010318.12934-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - Split the patch into two.

Xiong Nandi (2):
  scripts/decode_stacktrace.sh: better support to ARM32 module stack trace
  scripts/decode_stacktrace.sh: wrap nm with UTIL_PREFIX and UTIL_SUFFIX

 scripts/decode_stacktrace.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
-- 
2.25.1



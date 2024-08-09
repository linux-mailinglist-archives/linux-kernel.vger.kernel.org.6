Return-Path: <linux-kernel+bounces-281602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D709494D8AF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FFC1F23626
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006E16B3AB;
	Fri,  9 Aug 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erBBGDBI"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D81667CD;
	Fri,  9 Aug 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242022; cv=none; b=lqBhFXSJWA+b6SZRxvGTgJf71QNfhoAE+VWZSjn82TY8UK5D8Koe+lF93hz6Ncm4NL1PUQMgBmcyL/YXSY8wvGa443L8mcfNRLVxfsSlQIAnDycfTT7j2bCY7niXPcNLkcSxKEBw4wznqxeOKskjsQMrxypIKNIiXlvsdpeKqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242022; c=relaxed/simple;
	bh=l7GPouvP5ac4E6brjVKcdC3xU+ZdhTFkaSpPgJJCyoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4fPXeL+XttxmzKw56zSXV2TgmZNQ9CotLcMgvJ++H+6n32TXv2gz7h9mX0ZMbK79189yB+LqgB+TFlkYeM07qOAX07AzCFJ7qh0ne6EV5665wtIdcQ0cnPkXGI3/ZorzjmlWrcbC3VizsgkGh/rTWNTjWvt7X9DHHsNnsYm+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erBBGDBI; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso39145341fa.2;
        Fri, 09 Aug 2024 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723242019; x=1723846819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7GPouvP5ac4E6brjVKcdC3xU+ZdhTFkaSpPgJJCyoQ=;
        b=erBBGDBIn7wX1IUTJ7iyovDmIjrxk1OHiupLaL1dXSNNpVpHouMXfSlnUqTR+if7Xh
         v24hZwchWJjLDDGIRmf0oMEsO1MiFDXo2oWiobLJuvD1tkcO27DQ1PKligLNtAGMZ7Tr
         +Vx3D3R8gLs+RYozT9PuAB2IW8ecsy1wPuzGFwYEH2R5TlzHU6MP9gqApEk7ffCyDqw+
         KjOJEv/+iye4EPdqXst2L5I09fKW9Tmr4RipRXuvNAsr/0C2GYO4RZXAp+VPPyppqB0r
         whTjJ5mcc4scAM1flGk78CBTVM2oNbwUQO/8SRa1zWqCDpa2gVydxp7kI5yKpaODz5+m
         vnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723242019; x=1723846819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7GPouvP5ac4E6brjVKcdC3xU+ZdhTFkaSpPgJJCyoQ=;
        b=MiFPrP7BQm32CHErD/G2TJp/LbYZLl7OvcA+s6583nCy9BGpTYBTwd+bRc3G8QsEtZ
         V8Y4qjasfM3iRetchsR8zPKnXEgu9myCUCf7C0gEzY0GWynTp0uppMiwI5mQQy3dK+7K
         29WTJ0olYOnV3ktRoglvlF4XLn7JfAK/g0E2RqaMiCa76PoWjpLy1PB98zcQT4ssKVxH
         +GtnHP7vqQazG/Mc/wpui9Am0KjA4rXpqlWI9v6gsxGypy/cGCPzNxpdJZo2PaLkcvUq
         c1hur1FN7XWseaee+EZgK94iqVj7O0uFsOrGk287xXT//3ZZPtMPaVE39mlM9sVoQHRy
         H84Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6kJBNRU/IO7Sd4x/FJmz7gLTwm2W4UpVpT9C+sP+6mHOlR7Y6dWDwlWcxR+vKq4XqJe7oF0+nFOZiCK/dLH3b+YtcWzKaxvTZVNI=
X-Gm-Message-State: AOJu0Yy9I+TWZAdIaiYhfbwO+VRE6Irie9HXeD3iNwcrnwrMpzfLavl5
	JFZxP5VnBnC+mh74+RbNcOuy+267RwoigrE8xbU51//Bz8x1016oMevd1U5GAAhDFVVc
X-Google-Smtp-Source: AGHT+IHnAO68CJ9eQbxiqeGshtNhDQl5sxneMayzLTeayisTpiOom8lVQ1YtnUeIKbqPajPDR4JydA==
X-Received: by 2002:a2e:4609:0:b0:2f1:67de:b536 with SMTP id 38308e7fff4ca-2f1a6c6cf90mr24014421fa.24.1723242018687;
        Fri, 09 Aug 2024 15:20:18 -0700 (PDT)
Received: from localhost.localdomain ([5.208.110.105])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2f29203d822sm782821fa.100.2024.08.09.15.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 15:20:18 -0700 (PDT)
From: Parsa Poorshikhian <parsa.poorsh@gmail.com>
To: parsa.poorsh@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	kailang@realtek.com
Subject: forgot to CC all relevant maintainers
Date: Sat, 10 Aug 2024 01:47:56 +0330
Message-ID: <20240809221755.352238-2-parsa.poorsh@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809181303.9882-1-parsa.poorsh@gmail.com>
References: <20240809181303.9882-1-parsa.poorsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i forgot to CC all relevant maintainers in previous patch email, so this
reply would CC them. sorry for the inconvenience. this is my first time
doing merge request in linux.

Signed-off-by: Parsa Poorshikhian <parsa.poorsh@gmail.com>


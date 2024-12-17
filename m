Return-Path: <linux-kernel+bounces-448824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DFB9F4614
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C3A16420F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3E1DB92E;
	Tue, 17 Dec 2024 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBIXLWr3"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68E42AA1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424256; cv=none; b=iA4MN3E3izy7DLhkN//HUIeuV+apzxDi4nIjia/LtVWZMyNT9icQwbsFaouDsv5xA3IFzGnTHfoSI9HeG0O9TnrTJ7UxA630vob33Dd3vcBMwUoBAiDqgiZlV7I+MGKBrZq8jP4m40jT+jwmndD6R1uJygMWP8AXmjn7rLTDBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424256; c=relaxed/simple;
	bh=ANbHvocS0De2jFz5Ci7S4O7ZEw7An+x/6/xRKigOLGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fsgb0OqPqAh0KOCgLjugH4n/bSALPeA3ZXrJV/YJnsihXCv9rzWVjelYjhSGQtClSG1KriGJ36kppbUjA2G+9CkdTLQ4UqKAEv7huZs3PK+Vtbya/NZeZD6vh3OkaAQNXI+EiT2rW8hIOs70y8maTXNb/eCKS4qYHEWZm03Bsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBIXLWr3; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2166651f752so52685315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734424254; x=1735029054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd30tVWYoHtxQaUp8zbItFbdJ5ix/n8/w1NkV/nu/sE=;
        b=SBIXLWr3SEilDmxg0AkZbARaWPOAarJZJee2clCcgyql/lBlZXVFSG5NDZ6AEJCqUW
         K2S+k6osslczBWmBqwxRMZwuPKuOEzlpR1Kf0s8Ur9ECkNGW1hhpW/lFV2LBzXXuXXDp
         3CVwh8Q6HADjtykNL4wMQcbWglzwx0F5G5y7t90TGHWlWR5CEI/czC4M4B25DnGlK/wc
         qJfr3Qjc1XuVnpV3BcQ0CJjxT8XnkPfmBLKyXrqbXnszG2l5GRBWytpfgQEdAqtZaAEO
         5wF4SBrX7R3UTuRAV4wv7SA36xAYH1xo/NyknqPOjpy4/sSQlCyfwe7ml3przeDlm6GV
         1YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734424254; x=1735029054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd30tVWYoHtxQaUp8zbItFbdJ5ix/n8/w1NkV/nu/sE=;
        b=hTSkYzP+T4R1t1eev2gH00WIcngFyX24prmRpOllE+g3706U0Upb+JPLktjzJ0YggK
         p7zdz5FPOClyF6zUh7zg8hVD4EcvVBzjBFvNTuTZfjSHA60aLFb+3ZppRccogb7BDBQu
         cjzsXBuGXT+hntPmU0R6T1v0VjNwRWqL9hyFMt9ZOrn1C5jRIuEV2dyHV/LsWEChZSPa
         pANS82BRSYmr2SPWAmqbKWL96cN2Tc62oa1UaAP9vpneh6y9GStReAPQYqIwDR40ZxjF
         GCyOlhmeS7gVvZmt+Mis0DSdiYPvJ6fcv30plS2RNmS1por6Ez7IGUnye3pb2t9NyyOs
         stng==
X-Forwarded-Encrypted: i=1; AJvYcCUINPzHz5bcr8hb9b5tK9eTrEJN4KqOGWm4jUARIHkw9B+DcLz1Eyes/XCXLjxamSSsmfA3tZTu+gNtjuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3hgFC465fYP0z+PpOlZdzadfKYvVk4yIslDWjxPnrsN0jftV
	7cox3Yp4gvEk/NJwL6AQ9+QwOhBVk3e9Bu0LenG1Fdrm34nZSeyWJR6mn04y0fc=
X-Gm-Gg: ASbGncubtztvNrd9l9ZMVIejfY4t5VS+mWoZdNH07rwikgbU7osCA5T0QPodv5yi/ly
	rdZc8njB/1+XEBLusqO1EQCpt3yGVGMaxXByOJg1a7FA4XbSMZzNenzcN1hC2wAosoFcfMBrRt/
	xUzSJPcaHuOC+22Qhr0MX5EyEqCzsbwVCC8UueKgw5wHeuDor+99JDjUfktuVBJEf0sCITBVeha
	5f86vxNuYFf6QSgFvJOr73gjJyw8gLwQ+7YvyuuO+/atQ/+X/Ma1Jaq7sKuI8SNui0pJQi2DJcG
	0g==
X-Google-Smtp-Source: AGHT+IEZ3q8mOV01FO5bL3R8EO7xZNQ8atTdytKNqxrOkw9jgMbTPieqH1TEG7rAHfNDbABb4+gmrg==
X-Received: by 2002:a17:902:f68f:b0:216:4853:4c0b with SMTP id d9443c01a7336-21892a0b4e7mr211960605ad.33.1734424253973;
        Tue, 17 Dec 2024 00:30:53 -0800 (PST)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe2d:0:1:6253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6370csm54383395ad.224.2024.12.17.00.30.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Dec 2024 00:30:53 -0800 (PST)
From: zhouzihan30 <15645113830zzh@gmail.com>
X-Google-Original-From: zhouzihan30 <zhouzihan30@jd.com>
To: liam.howlett@oracle.com
Cc: 15645113830zzh@gmail.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yaowenchao@jd.com,
	zhouzihan30@jd.com
Subject: Re: [PATCH V1] mm: fix bug in some memory information update
Date: Tue, 17 Dec 2024 16:30:27 +0800
Message-Id: <20241217083026.29122-1-zhouzihan30@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <edigemkxkze3iicku3orrufdadevca33ndqxw2etqvustykpv6@smaext2j3bzp>
References: <edigemkxkze3iicku3orrufdadevca33ndqxw2etqvustykpv6@smaext2j3bzp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your reply. The title of this patch is indeed not good.
We are planning to rename it as "mm: page_alloc: fix missed updates of 
lowmem_reserve in adjust_managed_page_count". Is it OK?

< The subject of this patch is really poor.  "some memory information"?
< 
< considering the text below is so much more descriptive, could we have a
< meaningful subject?  You will not get the proper people looking at this
< without a decent subject.  At least make it "mm/page_alloc" ?

Regarding Signed-off-by, we are sorry that we do not have a particular
 good way. When we are on the intranet, we use jd.com email. However,
this email cannot send emails externally, so we used our own Gmail as the
 sending email. My name is Zihan Zhou, and zhouzihan30 is my internal ERP.
 I also rely on this account to submit information on the intranet. 
Do we have to prepare a new account for kernel submission?

< Who are these people, really?
< 
< https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
< 
< Also, the Signed-off-by doesn't match the sending email (gmail vs
< jd.com)?


Return-Path: <linux-kernel+bounces-349672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41298F9E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8081F2320F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37A1AB52C;
	Thu,  3 Oct 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9EkdWMT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3A147C96;
	Thu,  3 Oct 2024 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994675; cv=none; b=WEFnYx1hrg1vqQvfyBC67Sj+0r5y3JwkOqTY7JOhD/QwNF8gSWQUl6NdFnharrgvrfyK4RRAaY5cDhy4lmafVAjDtAx055EtXv+4K71Xw1tsSvLdaB8Y5JD1VHXvARNTrxPEEjHpFcEOU4P/JohoyL0BY55KMQAoagHt2hqYvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994675; c=relaxed/simple;
	bh=15tdArDIn469Z3BOe4yT9qYDCETa6H/izpo7C6nDe5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAxsmw3VANwNRfOmeJwC7PlGL23UJNsug0uBG89PeIIzY7+ZZelCa54Ul7hBW/cGSSG+5bO4PVcmJZLYkTJfQ4vgS4pB9uzcJ8D0Mv6Tjn6aZ7bnpHawBsXYJZLz2MoOrnq/QJ1lgTJJ16/+HZqXIhr3VKonleiTOQZD4yoQDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9EkdWMT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so12259175e9.0;
        Thu, 03 Oct 2024 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727994672; x=1728599472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15tdArDIn469Z3BOe4yT9qYDCETa6H/izpo7C6nDe5I=;
        b=V9EkdWMTzLm49WuKuKAllLU4sDZqLoxOL9q0RtiZiXUsZrowd053wNohMeAuNhFKfF
         NHvFcJN9UdtHOftWAFBS2ss6id1SsGIBBHDem/vuy5kW46XY9Sd8h87gKOz17ldM/QkW
         2tUGa/l6A+/QT4yy1K2tsiWIANgWO7vJDxbgBv06PWrAXjWtjledjUN8CrEHHetntTmH
         GJa66jr5BE3iWOBcs+lpJNKK8pLjU3ILeiCr8O6YiQE65cL3WfGfHZl929iJH+VnuhIf
         qYG//7sYpYJy4nadml1pZlSQ4RTRtFZQFSbuIPIBnb1BYSsaxy60HN5Kem8+pOlKfS79
         H2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994672; x=1728599472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15tdArDIn469Z3BOe4yT9qYDCETa6H/izpo7C6nDe5I=;
        b=sAS7eaTnDtUqYqABryWYYcF4dzN1xiGQfSPPgfls85KjkDvFiE1Ta3h+eo4FLcSUSb
         734+LXwixM17EfU0FRFnvVpu56eRDmSSLLY3lTYivVvTvT7aM8qCHaqAgyQzA+uKYNaZ
         MfCLxDhyZIHShIY1xusY9o/vGXo97JmePxel+Cf7K2U/8xBh9+0y7itfitxu9tryIxc/
         9H3tPW7fY2dL6G7b4JJcmsIsvJT+9q47NI8vTKcYLukQLuTPtLF34UNBEDp6V4qW8x5H
         Kx8GCarJM3OhEqR+UvET0ftZKboT3n+TpWnJt9q5cLpfgxqhJBPifjsprmLznVCCBFDj
         VU7A==
X-Forwarded-Encrypted: i=1; AJvYcCVSqTAHCzobb+Pq7iamXnxWo2v37Fx2NGPKiOXsQd30oKkfOCgORn5u11PP9jQ2yE8D6NLWHEvV1dYjVg==@vger.kernel.org, AJvYcCXUoE5lVaOiiRjZZa4x3Ksul7tLHF+Dlr1dBR1gHj5UPu/dPCb311ncCQ6Yjz7KD1nrsLaem4lXNwf9tp5E@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xVixaEzWYtTWsGdaGu+Vy7v8W7wDlMtowxBbWAUNaywbN2kr
	WqKMx8zrjoQ96N7IVAyeuAe5Ojna1q+U34ijW8y4FLxQLFrSBlZ+rcrhZDv+94Y=
X-Google-Smtp-Source: AGHT+IFlat8rup/gfKyUn61UIuFLE1wbzLTJlZKIuTgvNtw0oZO4QQSNU0czx94Cm6JIJpX9pWr+dw==
X-Received: by 2002:a05:600c:a01:b0:42c:b995:20ca with SMTP id 5b1f17b1804b1-42f85af43c7mr3090895e9.24.1727994672212;
        Thu, 03 Oct 2024 15:31:12 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:eee:1480:4de8:de53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1cfe6sm374395e9.21.2024.10.03.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:31:11 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: vassilisamir@gmail.com,
	vasileios.amoiridis@cern.ch,
	federico.vaga@cern.ch,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: hwmon: pmbus: Question about header files
Date: Fri,  4 Oct 2024 00:31:10 +0200
Message-Id: <20241003223110.17166-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello hwmon and PMBUS community,

I am currently studying how the PMBUS subsystem works because I am trying to
write a driver for a PSU and submit for review. I noticed that the subsystem is
quite intelligent and it manages to do most of the stuff in the pmbus_core.c
leaving a minimum amount of work to be done in the actual device driver!!

I have a question though, regarding the header files <include/linux/pmbus.h> and
<drivers/hwmon/pmbus/pmbus.h>. With my limited experience in kernel development,
I would expect that the drivers/hwmon/pmbus/pmbus.h file would include stuff
that are used only by the pmbus_core.c/pmbus.c while anything that could be
potentially used from the device drivers would go to the include/linux/pmbus.h.

Is my reasoning wrong? What was the reasoning behind the split between those 2
files?

Thanks a lot for your time!

Best regards,
Vasilis


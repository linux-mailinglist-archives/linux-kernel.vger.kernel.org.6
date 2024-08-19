Return-Path: <linux-kernel+bounces-291619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C89564D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354521C212BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF4157E82;
	Mon, 19 Aug 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vZbRZxZR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58E14A605
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053212; cv=none; b=PFPgvEQNyAuxtLTxrR82nU6l1h0IfwbE1HydDeoC65GDn7CwguCLTV3+NAD/ja0x3nvPTCl33EdkArUzw3G7BI3w4bnw4C9ShKUpZLOYdQ17oWjTjb0bsE57jvcMbAdw0FIcKfXsIwTiZbfKI4qEEC2hobyiZQ/qB3D4zgak7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053212; c=relaxed/simple;
	bh=puDwzCN/L71oHaxZuMzUORA55dEl5G8PsQVmRdJHX3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqdD6khJXd252NF01uhyXb62uInQo285beJ+jSJhl8b9uSENp6d+9YlSZaF+9uwoVC2BpeMdA+pX5e2HVVNqdeRuM0tfXGR8wx8V5T9gjB6SHy4mn8SOgTX0LYUVoGnq9Qsv0VP0vPUEAl5pvhAx8vgyt7jL5MWEbfzHTFh3ywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vZbRZxZR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42808071810so31748295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724053207; x=1724658007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEeJFdKCPxOnTkLX0PckWN8yl/xJg9zaGkjc6A5gNHs=;
        b=vZbRZxZRDLOzGQ/Eb/jPH9oyrpKD5FCCtsGx9SwAVpZ6E2VkQVibC6HbIVA0wjAnyd
         vWFFuBs5rVhUJYLLp0h7GtGe15NNtcKOGqk23+9f0MkJieSY2MFVayjdkyMcqRxKkJdr
         oRZXDAOGAiZfrx5u7SmtJg+40k2daICaFKm7QOKINt6zwRb++07LXYVT/9hA5gC2ny1E
         KRKiYnEeXAW2Pu7QXKSLZfyQEGO0wfp7olFxn1nv4vLQHGlot8IxzN3KPASGWjeoQKci
         +Nqngs9RtLCudw7lO1CFPdqgLfW8nAtHMOif+N0pNI4hjE1mjbNjRCz1/CsU/aPi9J8a
         OQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053207; x=1724658007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEeJFdKCPxOnTkLX0PckWN8yl/xJg9zaGkjc6A5gNHs=;
        b=POzmXjSuBlaMlN5vHMix0S3/QJah4JPGFlDN7W2TNDpo5rH95xY6MCoHEnijaS1kmm
         bKrtHMfd0QDy/07jZ8LyOpr1EcvAbsWKj4Ht136kc1grOCwK/T62+54Zon2pD+m/1y9h
         F7vDVgpwGasF5hGJJmuD3aH6CypcZlbV1klQccAzIj9hINXevgQ/yOjHVFuE2MbiA8mr
         7Tai7QX75dEWz/ey/ILxJJKEgLMXLvbACBZGiF557NmRZuS2rcAsbOIvUxlLGbmJJB0t
         onM162iw1BTKDlbdokBKS2Z56CeaWA26gUdWM3fdDLs54hq/I06PjLxAVEcsZ2nHGPvL
         XqWA==
X-Forwarded-Encrypted: i=1; AJvYcCW4/A6SqKO7Nl8tUSFHfmCD5XIvpgi8d3NTQbuxH87s3KRzAYu3fMJYQ9pDuREefLdIUuAuAp6DCslp5mGYDRX6wRcWOB0JZm9QNNpz
X-Gm-Message-State: AOJu0YyCW9GDB5dgzkUVt8vT6IU9v11QxOpXR4C+EmZHPVWF/ULh4Zo3
	7pjN2tK0vOTLxq8Q35cniOGGKgGdkfI8BqsXS5bAZp3sD6PibyOiVlpX08ldIo8=
X-Google-Smtp-Source: AGHT+IFUDZ1mDoNQb9Q5KCKgLIwW71qvlnZJG2ky9yNpHokhjVbKA1A/SYFz/D+adEHZMV/HdEsaZw==
X-Received: by 2002:a05:600c:138c:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-429ed785802mr74196665e9.8.1724053206701;
        Mon, 19 Aug 2024 00:40:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded1813dsm156222685e9.7.2024.08.19.00.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:40:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Russell King <linux@armlinux.org.uk>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: davinci: remove unused cpuidle code
Date: Mon, 19 Aug 2024 09:40:04 +0200
Message-ID: <172405320249.6859.13196040998777989436.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813082735.52402-1-brgl@bgdev.pl>
References: <20240813082735.52402-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 13 Aug 2024 10:27:35 +0200, Bartosz Golaszewski wrote:
> The cpuidle driver in mach-davinci is no longer used by anyone.
> Remove it.
> 
> 

Applied, thanks!

[1/1] ARM: davinci: remove unused cpuidle code
      commit: 973d248c43f237e53116009dec70091c8e836c11

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


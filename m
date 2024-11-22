Return-Path: <linux-kernel+bounces-417785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966A9D590B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644F3B222EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729615D5CA;
	Fri, 22 Nov 2024 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFdAxetf"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752934C62E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251863; cv=none; b=ZP01OAhaQaw5KUCVsDMIjq53vgkBxdRMtp0duoygbnqXzYgzi/WxxtXcP70u2MHBncwHRqoSDKdTQfuW5SLo+k5uWZmAI/s0zrBhwkqhHae7wLvEVkj03uC8QI2E+5lcVvn41/132P964o+NwnJ6zSx4ObcOix66W7yiDFuEHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251863; c=relaxed/simple;
	bh=A/lHaHfafAQy7OfTvmDU5OKRmJrBpX9Zmsb83aoIxoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEUR80QLB2gfkVxxDSfjJPWTLTt1uqfDqv2czSbqN/ewM7tfJPHhhP72pbPFcAG53GnijKlGz0QMzjxR7x3D3EjBziuUkkD+eIsTIP7iVv2FBVz97BMHEsVV5j2zKR5HZ/fH1cWYh9rxrjxY/uy3e1fMot4qC4+aWCTcTCRDfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zFdAxetf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5f86e59f1so1052503b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732251860; x=1732856660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIzDwcozFWCn4iWIZHsgYfF1wjH7Z9fC00bR+vHVLs8=;
        b=zFdAxetfqdy6vjgAlPnY8dcPszsTDct+6mOTzaz8OaYYhujrNWdIyDm6DWDXklwxD9
         htk6uVhmakXRcC2Fjd+gf0VKabBgujYbdZJXpGtUEjMEEtaaIRE7vqvmJ5hR+wAFI5U8
         L5I8GNSP3CIuT9SyFp6pG9PwV5p5HISLTOyaBErkch3CTIh7aqGsWYvgFPU1j1pqziiy
         uKEPXqCROjEj5IyAkIC6yldMzfaMXQ/1Z9Xuj1AZ+dwr52LyscyQch1pg5tlhHkcQpqf
         NnNm4QFDdYbsyt0pDXl38nk7FdXVag61wo0cD2DJ/VZhdCGE8Q2jpBj3wJrxcG0OJ0Lw
         5wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732251860; x=1732856660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIzDwcozFWCn4iWIZHsgYfF1wjH7Z9fC00bR+vHVLs8=;
        b=fI7iLID5DqU/nHBmIhgnmPAJ+IovmcmHkCcjAD4+aBO7ft895Hz+RjqwBZpttonCco
         miok0e1OryygApYcnZ1Vdo0dFc/hlHf4N++jB99hBemgHg0k6ghYmeyCEhQKJxu1i9E9
         SX/xiRd0FHSr0cRvdVUYctMz/1b+gRSeWh77jh7wJOermCM8eB+izJzhs8aCOGjjlGH9
         xs5GAvriJMtEg7KU1NVbIlO9PIBUWcDGJZANEX63WzZEfi8HWHOiErxbXhtMhAknvRC6
         zzhuDGCG07/iLb7PA+zf25iHKVNksr/x7ezL75UXT/F5c/rvOVEz8YimkowjBO4o/67v
         cE0A==
X-Forwarded-Encrypted: i=1; AJvYcCUXLvFYnyic3k8USpfpQWoIZpxI55pcxcBiiiEHMt5zl3+fGt4o/vYl5yaRygvrD5kkerfod8yKdU+6Gh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VkVHetOGPGUMfog2u2Vp3bcuxllWjEzVpZhJosWVGGWkeJVz
	urganPJxZpTSgrSAMheRBVA7mUQG4Q0N6PJ/PuJhOUmFsIbNhOopUmYFmFgaEC/rTC92Q5botQz
	DVSo=
X-Gm-Gg: ASbGncvehr/hiU5zBM+/O/XtnNLyOunmLax/7UjhNfq+6JryZfCqrMcuo645AbcMXXV
	9FEO5MF1IRvK7BDjLUy+NuzEAfddP9hRToKeXo2UFhFI+OmnNmfnqI3dUiWUnFm/YDzvECN6Qqc
	EThKexDreOwxogZb2oNXGbb7hGDlL06IaWktYDWUEZLBfOgxt1rm8gt8GEyoxxj7iluT4q0g7DG
	aXmzEPyTnbKsY4JBxOAmwj6Xzu2VHUJxG81Sg1lDZVmYmIaat0tYeY=
X-Google-Smtp-Source: AGHT+IGL6MagCY83L4jKNjJ+b2nvEUCxXAYn80qUw2BRxv2rEU4IPc31obmxQrilm0WF+k6fB1jevg==
X-Received: by 2002:a05:6808:1b0e:b0:3e7:9f14:26cd with SMTP id 5614622812f47-3e9157a3724mr2224346b6e.8.1732251860540;
        Thu, 21 Nov 2024 21:04:20 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0383ba69sm280935a34.61.2024.11.21.21.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 21:04:20 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: hch@lst.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
Date: Thu, 21 Nov 2024 23:04:19 -0600
Message-Id: <20241122050419.21973-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112170050.1612998-3-hch@lst.de>
References: <20241112170050.1612998-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

This patch causes a regression on E850-96 board. Specifically, there are
two noticeable time lags when booting Debian rootfs:

  1. When systemd reports this stage:

         "Reached target getty.target - Login Prompts."

     it hangs for 5 seconds or so, before going further.

  2. When I'm logging in, the system hangs for 60 seconds or so before
     the shell prompt appears.

It only seems to reproduce the first time (during the boot). My attempt to
re-start the mentioned systemd target or run "login" command again worked
fine.

Reverting commit 6975c1a486a4 ("block: remove the ioprio field from
struct request") fixes the issue for me. Do you have any ideas by chance
what might be the reason? Or maybe you have any pointers on debugging it?

Thanks!


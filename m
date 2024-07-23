Return-Path: <linux-kernel+bounces-260018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849F293A180
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066C6B2154C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841B15350B;
	Tue, 23 Jul 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3KNadlyJ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE101534E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741515; cv=none; b=RWYuR8UgTKvwAXf2VlmTzdPDDC7+truxkyt8wAhNGEmuVa85ubKkseUZWGfWsHCyr1zr/o8g+HqQzVU1ySovDY3Aa8BYcqVTiAM5gBs6+0yaXfcrk6STMD+Qp1/vFXAag1f83VoL4ypks0NjBoasCth1bvo5HIoHWn9zHYg44NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741515; c=relaxed/simple;
	bh=eoif48013Js1xtPA5lsTxzXcyJyxuAULOwKbSvcGMVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iO3D47PrHAePGHHzk79T7CRy37rtoldO4PNpUqnyBiu3ll38sAD+xygZS7/7XxyDEjnIYSAZLUpyhGYJ4m+zzuLs9LM0HLFmS+VKbCLeWTAIvzh+5do5kYlSXJpd0PmGyLkRm/20Ptj76q8x+XvrCJIyKGgHEWkqUQJasR4heeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3KNadlyJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a12bb0665eso55423a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721741513; x=1722346313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TZ5ldNvpgl0zGwq9TUJinN2tshm4DZksOkaoK0Hc9Y=;
        b=3KNadlyJQqiH37Vqb8R0SMSERCiCuav6tQ4u6/oANrskiJoIg8lVSJPOQxsEIAmskZ
         kw8jUedxUN2AQmsl5aWTj+ya6kgjNJBUtJ//LvvblIhnVZQG/oO/Xx25PgRPoNXP39G+
         M8n+NvK4uqxQ00fmkp/dYTCf2dLg+PAUqJqNHzDy3US7TJYJyF/u3YNJvCu5NrWhpCbM
         0s2/UiG4ynAN/9RgnKRMo0RoWrkXbooolSUfnuXzU90k28Zy9NuojZNDaZha0HYsFrut
         Az2IBt1W7znn588yp0LwiH3malR6WNfHhwjajIgQ5ipnhfGi3ReoZjFXBkZ6Zhowl4Oj
         KHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741513; x=1722346313;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TZ5ldNvpgl0zGwq9TUJinN2tshm4DZksOkaoK0Hc9Y=;
        b=CffaGbNpdtO6HQ3sNoUg5nCrQNcRl0No7z0IFprqzch4UNxueAD0SQsiEi6LMefWwA
         wUm1n5RWuO3NSPMxJJpVJNZmcRR2Hoh5pXtkazPmLEAECYPc/oTHQYQwF3WtoP+zEuG5
         MWpwIpijvKRx/4n7Q0Lf6nW20eNyPb3Zb8TJy2tRKJ0bBBJJQPB3xvZN6RPp68s5X9ub
         5dlCi79zKdS/oHvd5KQ75ToQEEXrkcBBkmhFr2mK1uzbE+ajCPeewEtTJvVWhabxo7kP
         JtIW1b5JSZdBf6RSbbo+QPyxAMgO4r75tVjaLQEaj+8DHWQRgHJD+vkgKZDtpzanoQ+d
         WILA==
X-Forwarded-Encrypted: i=1; AJvYcCXlPBTiW3MAEiPrrZgthUuihmaekxLCDwYMNeShsZywzOR3VNa7Q3fq2O/O9IYqlVbeJdYwEpNos0oON+gOU+VumdjGPZayiyBoXgeZ
X-Gm-Message-State: AOJu0YzHUVMg7ODVMGbkXCBljh2uXEXsRgRt5yK4DlvEaKl+R2uJ+VOS
	kW51ReiNNfTmnZIXMLBAh22c/83e4GJWhlXLtbnb9lZwaGLIWQ/1vgJCBxbg4CMI7N+6iAokA7U
	Y3ng=
X-Google-Smtp-Source: AGHT+IHxt3qJcNFhOgTmuTSf/6MAoBV2NfVh2JCWLOLA/lZ1dp8b1Zzvb8z66ap7Hc0lElinVA352w==
X-Received: by 2002:a05:6a00:391b:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70d08635b76mr7749852b3a.3.1721741512980;
        Tue, 23 Jul 2024 06:31:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d14aa33f6sm4867744b3a.65.2024.07.23.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:31:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, Simon Horman <horms@kernel.org>
Cc: Andreas Gruenbacher <agruen@kernel.org>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
References: <20240723-drbd-doc-v1-1-a04d9b7a9688@kernel.org>
Subject: Re: [PATCH] drbd: Add peer_device to Kernel doc
Message-Id: <172174151190.171540.3359811072031639762.b4-ty@kernel.dk>
Date: Tue, 23 Jul 2024 07:31:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 23 Jul 2024 10:41:52 +0100, Simon Horman wrote:
> Add missing documentation of peer_device parameter to Kernel doc.
> 
> These parameters were added in commit 8164dd6c8ae1 ("drbd: Add peer
> device parameter to whole-bitmap I/O handlers")
> 
> Flagged by W=1 builds.
> 
> [...]

Applied, thanks!

[1/1] drbd: Add peer_device to Kernel doc
      commit: b8a4518b5c2d1164f9bb2e586733a658c5239adf

Best regards,
-- 
Jens Axboe





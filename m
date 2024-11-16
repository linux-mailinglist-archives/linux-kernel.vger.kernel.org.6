Return-Path: <linux-kernel+bounces-411813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA39CFFE9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A67B23553
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496B4F9CB;
	Sat, 16 Nov 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f5W+6J6d"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471B16631C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731775165; cv=none; b=LhJmeRJZxfAkhi5rkbW29XMPwVxE11qsWbqikpV2dKYMl+frfK3fKpIym0MQZUbRTWL+jrDWqyY/pz25vgJvk9Jh69bww7a5DT18RyWW//7GUC+y72z32TrXCLVd3K6SoUEVvlrIHyDApumj/UJ4eZxo/kIoIySnngPgqoSSQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731775165; c=relaxed/simple;
	bh=Ju1vKYcXPfGrU5JtGW8xJmpGlmxzgbsR7TH8Z+s9Tmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SwJyHeuOqzhysCg0Qt/Yxg61YdwzEpLxujYP7p79AmLOz+N3voRbde4XVPSzOXDEPxZZR/45txhizsRGVjEO0jIXMPyyM/PNYWx07eIjLaOcBTT+s2njEYnvx0HB5EwzDkUmnCfAEa7D8rxm+LaYuNGLfKIB9NzMRGM2P5V0+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f5W+6J6d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2114214c63eso24327675ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731775162; x=1732379962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaS9yT+LFixmnX0w9Dji74va3CcSNWVDjKsOe6+nxZs=;
        b=f5W+6J6d4ADMKJLTSh/whH+MJNPJthCPG2XrmxfX3oucRxymxLWkEr1f7dE19SmWnl
         IKE5l2j2x904fsRCRPxNBN4gRVgAZAVLW/wH+2EBrXe2sGIay9p+FmpDmzCCtTVHAyoP
         uTJE3nWec37QTaAWyyQHciLrOWnZQrdH3zERiVrJzhowTmZUw3kinIZn9N4t3IeYXMZy
         38oos1tcnqaLYmTZEFt9fdasrAxIuUVd8p4OmFAF87UaCh895lJHEi8aqNrNJ8UMBOJT
         zub8aoDbHSN3n1iN6Sc5YCvqVMYh85X3z0uVz2wdbIV5NLCCoztEMIjosxpx3vOqulau
         Ae1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731775162; x=1732379962;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaS9yT+LFixmnX0w9Dji74va3CcSNWVDjKsOe6+nxZs=;
        b=uLdcQDd8Zh3WIOpPaVoTcF77TnRPbPgRwmxmeFnJ2EfNZcXHMhh6zVukt9ZOD4fny1
         nbgJbn4P2zdjtl3p2kAZ5iSuvQqGR8ZXOJl6hlzMBxVG1218FuRy5mXuFVPmKSALMPlX
         yAiHfveq9tNgmS6E8U7oNlfXsrNjPb/ICMTYl6vwDChiWP6im3qLqnN93pn3CP3EuWvx
         T9vj2m9MSDdUf6SCcQ/+MwokRChrYQVrFomYwzukuv2rQOMiAQgu0av/jolaWBixkVnv
         QnyAXBtRlO3tYhDidHUmu8iAMXUQTpwxNVJw3e3zcLMvCFApoNvbQp/srKxqaGB5iwxZ
         BOJg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/flkl05jUnpOweBMUesxzKSaviJA2CqaJEHA4bzwgwCWvZQLpgWM0szt/b3Mds8arMErLhFI5dQCZMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvHzHryOaTNlEYF1yz4wgDoevCDD7LGqT3DC6vAdyQJhRqhl4
	5Uoi5YO7RLuZDAts+4GiBDBLC3JZQSqrR+R6GrIXZ5CUdqUU3kMeB+c8afDEBLwcnfOJ5SK5jUw
	mVZ8=
X-Google-Smtp-Source: AGHT+IFnt0eFVI6/O62s6Ylev4hjkponIRITqAVg4CxXYJ3HTDzLRcwaBUFCsdkRrpS8TfdcrcXoAg==
X-Received: by 2002:a17:902:f548:b0:20c:bb1c:d216 with SMTP id d9443c01a7336-211d0d73ce2mr72479105ad.21.1731775162216;
        Sat, 16 Nov 2024 08:39:22 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc312csm29297245ad.27.2024.11.16.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:39:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, hexue <xue01.he@samsung.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115070013.882470-1-xue01.he@samsung.com>
References: <CGME20241115070021epcas5p4bf0dddfd2e511f43efd4587ba408e6ed@epcas5p4.samsung.com>
 <20241115070013.882470-1-xue01.he@samsung.com>
Subject: Re: [PATCH liburing v3] test: add test cases for hybrid iopoll
Message-Id: <173177516080.2575635.9204944482118823666.b4-ty@kernel.dk>
Date: Sat, 16 Nov 2024 09:39:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 15 Nov 2024 15:00:13 +0800, hexue wrote:
> Add a test file for hybrid iopoll to make sure it works safe.Test case
> include basic read/write tests, and run in normal iopoll mode and
> passthrough mode respectively.
> 
> --
> changes since v1:
> - remove iopoll-hybridpoll.c
> - test hybrid poll with exsiting iopoll and io_uring_passthrough
> - add a misconfiguration check
> 
> [...]

Applied, thanks!

[1/1] test: add test cases for hybrid iopoll
      commit: d20600d52bef100401164b28f59843c37d549ace

Best regards,
-- 
Jens Axboe





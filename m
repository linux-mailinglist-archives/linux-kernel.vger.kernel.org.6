Return-Path: <linux-kernel+bounces-361550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A899A997
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6CA1C224B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE21C3F00;
	Fri, 11 Oct 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MRsywTas"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AE1BD00A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666714; cv=none; b=MWaG1RwDrlH++aPcH6FkAvqrBbx4HqObhRxQZhNKyirsP8qgEl8m+twkVRJjiaeP7rObCikkD5fMvuTLaR132k0z6eAefPJfz51I2lR64zfsLduv4k+6OLzb8VKR+r3ZDdp8rrBZpz8Af87pN/lmXPqZ7Qd7VYffVY570hvENRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666714; c=relaxed/simple;
	bh=aiN47lzHnJWqzKP2wtzM26gAcaTIZRCbMy1ZtpHDJls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=thekxHUUcbQN2MvjajbvkehyWIuIMwPUfflzZqNyY1oGVtpI0G3WAGqCzadkKq737l93c8jpqu7q3RWzh2IaiHHOTL5DjckGWVByDw1lPn0aPMXMfqoPZpoNEtX6BH7B9nxKpQlSOFCO4uGs53S2ejyTtLVSqDohp/rS49uS2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MRsywTas; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8354599fd8aso84136039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728666712; x=1729271512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpbrnuNpT2hceRYe/VcgBMKHN+/sFFWJd7A/mmO9d/A=;
        b=MRsywTasIhIfc2p7gVl5Gq/gYjwQFJVwWvHF18P8MpU28Ju/Dze+R8yYvOUfGBfVTg
         /nIrxKaWqudYGNriKy7ZWxQeNN0t5VJyo7NJcO1MSXnbrpa67zTIHoyzLlS/0vMSBgQ8
         RuW/9X+5+VPIBzSAeCEUlcP3MdMjzIGNtcHuYbV48d+g//EspXv7ucKkkfdljlYRGs+4
         ZUvK1T7aKvMgQJUmNcLt01xD54nzzTb14D+6RFFqCC/gmjD8fp0Zma76K5jAESoWKl44
         Cv2OcRY0z6cAdyHUL7zmCvzFh4ijVZFqudD0/almuQNw6FZKh8Np0YWgPCzHmdvps7CH
         6Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666712; x=1729271512;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpbrnuNpT2hceRYe/VcgBMKHN+/sFFWJd7A/mmO9d/A=;
        b=GVZua4s518a/leqA0iYYZWft4P6XbBwWK0jIy2OegXWt+LWRw9wWteoG3rW9vpTIX3
         y31YyAGwy4ShvSNwRqZwiWpxTKjqiQUTuOtpsI7Lzqm0xZ2c1qdFXPixixBw9U/8f3Zy
         ae2W7dyGr4eElG7YoUOxqwxMsVuO9i0TSP6/50fLNLpBEtuCOrroYyXdmgcXpk2OcdvB
         /aFWVpOE89EQDR/OHHZQH3IPR5wEmKuJ5Ih9qpOk2yvTjjuq7nkL4c6OSf6KhKDG2aTD
         ugHVfaZM3WhXtJJGbcE51brh/l5mVY7xxfOcCpibWsBRRW993ZSfJ0mKiMj+lTsPNHUr
         EPfA==
X-Forwarded-Encrypted: i=1; AJvYcCUvQwq5UhWv3PL6SCHcEMYRZ4WJ65C8UpaoBRoaKN5dGTnHtVU5GZAreGU40mQmktg7jy5uqoyH9Rby8kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynpeUPiBViMu2+n31/PUW2444jxGvEs9kUr9o3ct/Zt7W2WAtd
	r6ur9JcpsUki54UnVF9qgapYYSoYe3G0XfycvJjBP1a7M94W94QRRNVeV8k0L+Q=
X-Google-Smtp-Source: AGHT+IGI6wckhy8W+1rmF8si1f4MWwmV9cm88orXihhz4HO8zA71D88m2Jd/YkHmEzs3BnLxoXNMVA==
X-Received: by 2002:a05:6602:1407:b0:82d:3c2:9118 with SMTP id ca18e2360f4ac-8379512759fmr301961139f.16.1728666712217;
        Fri, 11 Oct 2024 10:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada846dcsm713654173.89.2024.10.11.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:11:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@infradead.org, Bart Van Assche <bvanassche@acm.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241011155615.3361143-1-leitao@debian.org>
References: <20241011155615.3361143-1-leitao@debian.org>
Subject: Re: [PATCH] elevator: Remove argument from elevator_find_get
Message-Id: <172866671104.255755.3061014354205659222.b4-ty@kernel.dk>
Date: Fri, 11 Oct 2024 11:11:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 11 Oct 2024 08:56:15 -0700, Breno Leitao wrote:
> Commit e4eb37cc0f3ed ("block: Remove elevator required features")
> removed the usage of `struct request_queue` from elevator_find_get(),
> but didn't removed the argument.
> 
> Remove the "struct request_queue *q" argument from elevator_find_get()
> given it is useless.
> 
> [...]

Applied, thanks!

[1/1] elevator: Remove argument from elevator_find_get
      commit: ee7ff15bf507d4cf9a2b11b00690dfe6046ad325

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-319805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31756970274
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CD91F22836
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A835E15D5A6;
	Sat,  7 Sep 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uniWXxit"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85515C136
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716440; cv=none; b=Xby2VvaLsOAI4XA9ozijERlUhosMFo3DWBvph7amiAAayvxJjy0joYq3JrI0IrzxR8dPB+1LbsmpMsJWGEz80F8be2BPpHfzsrGg0jxvjQKOSsowbrQG0Y72R7iRbnIhtJ6/JgCYt4HxlIr443hMHmYXqzEOWtIgo78qn/0mH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716440; c=relaxed/simple;
	bh=OaqPvacqn6/a9sSDdmHkzNo3Z3URadX8+wQz0oAN53I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nnI1e6tVKALHWMnBlp6kubI1aAIgluNWO24BoUfaVvT1K9EY1N/jpQw48jKrY0yHOyj2KgpegCWYJxykHZR+qqBQIknpcSGC2VMqhN61c6SZtj7GBosb7Avhs3PJ2ZdmcLRihQSvcKYm7D8IDTDYUyN3IijI+LXaQWbF7cV+1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uniWXxit; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so2224004a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725716437; x=1726321237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z2NqKEDUroec7DxNinieI4BqCY7iLkxEiBrhdUI5is=;
        b=uniWXxitIcKWLwnLlRalerHovn2y24ZO4ovMg9d3k8POA3K2q7FAOtJReXMKOXkR0j
         29CzRcuT6c+4AUOqtl8Jz/X18WW7XQlFc2wMC665vvoJ2COW+fLmePIrFNFqA9CskTDH
         cDDuzaInRC5uSuKBW2tyrcIvAilehUqUsQTNShjtgdeinXYC9Cy6OC8NLPY8ITLNSX9q
         71kELuuBOgRFSrka1eRZ00kXhbwlzsD5dKsZiIkly8eJXT1gFBo+KolXLbeUHCUN4v9F
         QHOAonTnRlcuSBvFnkABfqQxaiVFwE8haNV2VNaaVOelffKEXtA1jPd6czgsZerFWTIp
         EAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725716437; x=1726321237;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z2NqKEDUroec7DxNinieI4BqCY7iLkxEiBrhdUI5is=;
        b=u/kAVBomjUwIGJm99FadmlaIY6vy8VDmBg8zO3jQe7lRf7KsHb0zgrfp5BHc1K3xum
         EwS7FqLepVxgagbIbgLZG30LZjawp+eB8ZIgNBMVoIprv/UclVIdH2ZFQwq+FIUBNSPH
         mIsO2uD4hMsz39x8VqsSiEZPVuiPE4xwDHkSBzlC2txfpx55Rfv8zyXDjLhqgJnu5JGM
         P+b3uNGXOEaUS7MOLVdyhTu9lAPJyuBIQKrCdIl+e4uWQSikKyb1Vu4bzGuMvlCLRFYP
         Gg6ap+E7cKGt65pRwYnRIUMHfjqd/cRMSyswdGahtINUmtdQllVyAG0opjNT2KK5S4Bw
         g53A==
X-Forwarded-Encrypted: i=1; AJvYcCV6y1yn4NZglOKevPa3IaFHGyp7lFN3E0fjM/DjITTSDsEzSdDAF6We00FRm10I6hm7mOunGrIUlp/BYD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3cY4G2HVAMBUrtVc+Ek+KJzPqffSJYsb+P30nyrlRcj5SThS
	bRiarRP2D6gQQIOKRGO9SY5ToRhKUZbub2TPV4K/M3MrfOsRZJKxsvWo8nFvNNE=
X-Google-Smtp-Source: AGHT+IEhZwbieHskPJo4Uyj4OnCXHu4QjPHSgjLqpiJL1ZTfT5B9jQR8sob0cT5Yfw2RSDaiyPHHbA==
X-Received: by 2002:a17:90a:d150:b0:2c9:6cd2:1732 with SMTP id 98e67ed59e1d1-2dad4bf1ccdmr6610025a91.0.1725716436796;
        Sat, 07 Sep 2024 06:40:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc12dfccsm3368356a91.47.2024.09.07.06.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 06:40:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com, 
 longman@redhat.com, adriaan.schmidt@siemens.com, 
 florian.bezdeka@siemens.com, stable@vger.kernel.org
In-Reply-To: <20240907100204.28609-1-felix.moessbauer@siemens.com>
References: <20240907100204.28609-1-felix.moessbauer@siemens.com>
Subject: Re: [PATCH v3 1/1] io_uring/sqpoll: inherit cpumask of creating
 process
Message-Id: <172571643542.244981.10331950852185495338.b4-ty@kernel.dk>
Date: Sat, 07 Sep 2024 07:40:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 07 Sep 2024 12:02:04 +0200, Felix Moessbauer wrote:
> The submit queue polling threads are userland threads that just never
> exit to the userland. In case the creating task is part of a cgroup
> with the cpuset controller enabled, the poller should also stay within
> that cpuset. This also holds, as the poller belongs to the same cgroup
> as the task that started it.
> 
> With the current implementation, a process can "break out" of the
> defined cpuset by creating sq pollers consuming CPU time on other CPUs,
> which is especially problematic for realtime applications.
> 
> [...]

Applied, thanks!

[1/1] io_uring/sqpoll: inherit cpumask of creating process
      commit: b7ed6d8ffd627a3de8b0e336996d0247a6535608

Best regards,
-- 
Jens Axboe





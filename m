Return-Path: <linux-kernel+bounces-429576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7999E1E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E1282256
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902061F9A88;
	Tue,  3 Dec 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LjxLmdEk"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6961F76B4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233336; cv=none; b=VZCwUN0YYcnrivKdMRzAMdOUuTzMjtIIEK6HbKkXwhL2UakrL8Hm3tityTeM8qq/nGH8JSHVr58nUDNMF8+KjoGE+DDDPAAq4oWAX4cVnzvFLSPD0NVVOdJaj5yakNGB3EBbYlNetT7C4q2+k6dCPAVhuBkJMjI9JU86xBIfBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233336; c=relaxed/simple;
	bh=BPqo/+vJ9OA99wMkdAF6vWPVOkXo/UQOziFQPIlW/1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P9NsK3qzrJ/I6iqvSdjcmc0NXHRWouELVBq3vCfgWEzYGnBi7pIWl63QvfIxXDlFxfVdanWDSlXr/Y2ooE+vAJg7OUG6n90ZtoH22es0CD6td2jtPrEtbbzT3rpQR7V03rLuZLOZ1tDMNe/m3UO71yF9Hf/tZqtNjqz/O3wm4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LjxLmdEk; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f1d1fdb328so2090702eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733233333; x=1733838133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPziSiz6FIPz1llFZL4/mtv70ocOZmo18hfdyDsh/VQ=;
        b=LjxLmdEkeOzRdv2LOy8MDnd9IqaiNPf9AwmUCLMdGor82amWTMEVsYs886T7eymnrB
         zy8yYZDY14DZBsGdWmoreADl7hEbgNxly+iMObL2qjPO96HYxRFEMFESudSPrIrCorcR
         pN+ddZMBHAZGjOilYlZu3wGLqsmLvLhmRK6B6WTWkWx+Gwg3aJwrbmEcJtGqStUMLWo4
         5rFsmQDKA5/pJyD9px7Z8bfH1jM8OQvEJy2YnJ5LT9/9tPEaVmlge6SEKDrJKq/Kp095
         LUHrm3vRacst7YQRSd4WbhxJxCrvuRECNqC0Mq45G8cYccbtqc/wCGNoMVpKdDrOAZVm
         Qs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233333; x=1733838133;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPziSiz6FIPz1llFZL4/mtv70ocOZmo18hfdyDsh/VQ=;
        b=oI390VvihAkqsjmIs71RzilrGYsUQrMO6oUdnEDyr7UBbYg3ZyEj4UrirGL8xP8TOO
         uo+RY+T1RWrhb2NjZlgJAJhBDiUgOGIsDhcnX3kxLa+70gbRVI5P0kEbM2QyhG8HWCwC
         XxjiPXj5bNZc48UafYlkLPZeQ+XTwIuQ/Td/+XckeiAfaFjE/SDsKzGlXukUiNzZFGvb
         AZ4dZVpmdLoKNOwyIpeHB0DUIDNWzeCfoz8Whs0QBiUEBhAOGfU/l/pLpeuk8sSZRqM2
         69ffMZ4ZdTDtXYrKabWwYprhR2TXfMJTRRd8wQE/M82ma/IlKqQr0VEaQsQCCkBRbaFT
         Bp7A==
X-Forwarded-Encrypted: i=1; AJvYcCUtrYQ13s0vB3ZTDW4bBDlOmtwYVSwGKs059VVc3Apiex+2gSMdm3cfyCD1hJEfSCB8GLF3oKRmzaLwh4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhz70TSo7h+UIQiuCEViVdBmPcCqiyZWJYSyqRHIYecJ+8AeMr
	LAzAuuZvYpgxI8IaEuAYnKtz4r8O60E5frmGkIWuyr7M6YUx1WXX25ALfy+mCLSCpLu8mqz3Mpd
	W
X-Gm-Gg: ASbGncvKAV2elh0Hm4ppXcvBkRABPieUkuiqdnCPwKfWEPip4ieglrrK8Uf1SD8X/Ve
	ByYhYljtYUOF9fbu0MS9HuZv4nmfAQRCiG/9XrBeqM70L49pSFjjnoqGQEl3lpNTiGu6sGyb1nH
	2u5SeIjxx2V4eodU8F0XMxXXrGwmKOjvqpcp/Z/Ues7CsEJK/mA5dhTLwcT+Id7EwM7QHznW1kC
	06XTVB+Xg/z8PN68le5NjfAF9WmmoZGTtYBWfe9Z53pRQ==
X-Google-Smtp-Source: AGHT+IF3JxViCcZr46UetkoBs9MyylLeqwOA8mylprKsogFh27HKGMF5642pWucfOY8iKk1uqQ4f1w==
X-Received: by 2002:a05:6820:50c:b0:5ee:d89f:1d2c with SMTP id 006d021491bc7-5f25ad40e71mr1942008eaf.1.1733233333038;
        Tue, 03 Dec 2024 05:42:13 -0800 (PST)
Received: from [127.0.0.1] ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f21a4cd86bsm2782124eaf.29.2024.12.03.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:42:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, colyli@suse.de, 
 kent.overstreet@linux.dev, agk@redhat.com, snitzer@kernel.org, 
 mpatocka@redhat.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org, 
 dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, hch@lst.de
In-Reply-To: <20241202111957.2311683-1-john.g.garry@oracle.com>
References: <20241202111957.2311683-1-john.g.garry@oracle.com>
Subject: Re: [PATCH 0/2] block: Delete bio_set_prio() and bio_prio()
Message-Id: <173323333147.59116.15700360793401292347.b4-ty@kernel.dk>
Date: Tue, 03 Dec 2024 06:42:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 02 Dec 2024 11:19:55 +0000, John Garry wrote:
> Macros bio_set_prio() and bio_prio() do nothing special in terms of
> setting and getting the bio io prio member, so just delete them.
> 
> Prior to commit 43b62ce3ff0a, they would actually encode and decode the
> prio in the now-deleted bi_rw member.
> 
> John Garry (2):
>   block: Delete bio_prio()
>   block: Delete bio_set_prio()
> 
> [...]

Applied, thanks!

[1/2] block: Delete bio_prio()
      commit: 099d214fc7abc3fec0f38d10bec31ac7acce8d13
[2/2] block: Delete bio_set_prio()
      commit: 77cfdf838d8467d3ca44058caff7c1727080efb2

Best regards,
-- 
Jens Axboe





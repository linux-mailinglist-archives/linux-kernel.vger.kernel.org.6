Return-Path: <linux-kernel+bounces-259408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFF939577
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA5282858
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C651E891;
	Mon, 22 Jul 2024 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v7o2+mfA"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1C2E646
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683650; cv=none; b=T9Qc8e4iTUY0b06yTTQ/ElbClj6uAVmWs7qiAzm86XH8Vk9mv1BNZ1thQmkItacGpWyeRiVc+/DsKuJUfC1nPvQinkX6V9g+GoEHnnm8hYc+Y9YG2g0GSqo387FcscVcOPSGrMvxqGJmjCPeZgVb4GsWn6g9SRbk1ai1wildYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683650; c=relaxed/simple;
	bh=KSEr02aPxS7eCpS+oLhULOf70IzaL+DIYBzgfG2U64w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xh94sm7LduJWgBqJylu1H3vfVUl5Kn+9koW/5QDMNmVbW4AOZYur8II60UxsrW9PNLiA1BQ52VtnyrIhJAikta5ek62kfMUWXx7JBtusR35LjTH0wrv3AGAnhIag1MLLUb6+Y0htIAmSCWfF9PTbEAiqcB1oqTz4Sk3IBl2RQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v7o2+mfA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d39a836ccso74918b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721683648; x=1722288448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGt3lheMt+lc1BVjdL4ueCYWnv9Mr0HaYdLgUbRMfMk=;
        b=v7o2+mfAUglR+NRMTMI8od2Dg7YgEw/ABk3p412idAxShdwtd9eYjszQL58U1Pp7ZA
         PLF2L1WJttVKrbAA5ha4dRbYWGRtgwAIDHeW7y4XUcF6pJHlsyZllijKKC8KiSh+zLec
         VNruSe6DOz9c6vTop6SZSaIyaOl6M/JLUZFknehMbZKfbvERwuPQUShjVEjWiUbvvFq9
         ftQdBuZZTfOK1F6VkPpDJ+s8OJQ9LkbETjh0mGFxfnbQ1Ciib/J5ZIwa4+W770xNx0qx
         w1fDZ1eOm6yEfqiiTlpGEt2PVxTbm/Dhs5Up3U2Gv7JAz9hMuNmh4Zk3yne2hXWrZl4p
         DtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721683648; x=1722288448;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGt3lheMt+lc1BVjdL4ueCYWnv9Mr0HaYdLgUbRMfMk=;
        b=f8vmSeYhZjkmx29Lp/2ZCwM3HduLrYhS72cwTzDzxDDhp/2smLYVSGtb8Z5bkMYKwM
         pbzhAjTyRzzRpX/DaIxcGcqwH91BJpMuFW9t/OXgHSI87H2hl2jK3ajz3tvWMXnzsA1l
         9w7w0JwYeMq9l/nXBuZo3PdwD/U/VtXfv666ejrFQ/1rWPHf9qXAG7EiWjI5wUfGPHbQ
         tjX68To4AMLWpsX//3vr0Wmj0lukkFIJ8qtZPeUvhXRcm2GA7fndO2FA6Gbrv0kT0keC
         slhZqaTo8n83tow9fYnofOfeIsCNDoEQQDJFLuVxpkgeSk+CRDQbMDGPNUQc9iT47XP7
         KvoA==
X-Forwarded-Encrypted: i=1; AJvYcCXy0Qz/i1p2KA2vdX1XF6AqG+0ySb57OLjKTrmRl0nk1JkhKm7BY89wWH/Zy9VbkldV72ddWt/sTdOFv2uhJShrOc2t58NHQL5f2uEu
X-Gm-Message-State: AOJu0YzfzA7s+tX1cQ/IqkvxBYLnjW/S4kbFmSxE8W49OXd3Skh8yup/
	gDzPDZSLebufo2NzKbMtExiJfaLoCnxkJIuvNbFxWunPpNwzEx7l9WWewfQhpZE=
X-Google-Smtp-Source: AGHT+IEDiejvIpcexU0W0F4+e8vzu49qV66LWWfHeuWIe4HWwR8f7B1+Uh0psbY5TZ2Sj/3FVCrFNw==
X-Received: by 2002:a17:903:32cf:b0:1fb:19fc:1b44 with SMTP id d9443c01a7336-1fd74555185mr74726715ad.3.1721683647814;
        Mon, 22 Jul 2024 14:27:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f457c6asm59766625ad.242.2024.07.22.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:27:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@infradead.org, bvanassche@acm.org, jack@suse.cz, tj@kernel.org, 
 josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240719071506.158075-1-yukuai1@huaweicloud.com>
References: <20240719071506.158075-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3 0/3] blk-ioprio: remove per-disk structure
Message-Id: <172168364572.147162.16825198001885724526.b4-ty@kernel.dk>
Date: Mon, 22 Jul 2024 15:27:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 19 Jul 2024 15:15:03 +0800, Yu Kuai wrote:
> Changes in v3:
>  - also fix indentation in path 1;
>  - add reviewed tag by hch;
> 
> Changes in v2:
>  - add patch 1;
> 
> [...]

Applied, thanks!

[1/3] blk-cgroup: check for pd_(alloc|free)_fn in blkcg_activate_policy()
      commit: b925680cf08356a27ab83c0b707c0fcf61ab0bb9
[2/3] blk-ioprio: remove ioprio_blkcg_from_bio()
      commit: 746af0f4f529ba40bfa474c5b7509bd52f9863d9
[3/3] blk-ioprio: remove per-disk structure
      commit: 19c8bb716c283093a355a95a4162dc6a880dbeb0

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-414082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744EA9D22C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B83A282A87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A81B6D16;
	Tue, 19 Nov 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YWBcs+Kg"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BC154BF0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009774; cv=none; b=OvbPpo2z/ZJgovluF6jdrk+IzymxIndMlI6z9i+4QXk3hJEAdnT1tOWgSRCYpYM5LwPUy+BkvVaTEl1nKLIR1iTABvEiqBifhWnL7EIo5y4S3SQuFXMGLrGBWEbRS0sNPdCPJ5V1fjPE5QMLUCab7KPzbFbdJH4aw3enaRYz2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009774; c=relaxed/simple;
	bh=lgopZdd6v9xAoh9CPgG7G6P2Rctls1aMm/4WV1OQBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjywVWSpzeyG1+lw26Rm633U7/KWdX9uAsWbLJusqhPZaarDsrOQglh9dXEoQ24hFuJnJHVtSu552/15K10cVVC2asTlBmRJlNBTVjS7IYTI9XzfFtOxoLKqulYNXGRAL0rymQIFsePioN/6FgvhGRCCP1cIc7jpaulpHIhB5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YWBcs+Kg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfba4e0231so421998a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732009771; x=1732614571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP6utXSspykskYzsNkWUBuQWYEnMFsie+2NCl6mM1/Q=;
        b=YWBcs+KgbMhR9KMQpV0aa4OmziYY/0GS+F532ii6y7hRkUH3HPSkwGs9qzRPgo4Rep
         nE44Lh1cbSL0/0GuBGtlifyiLRisJlSJ4eJU7WhNLOCobq+d4euMtYMinoS8fiL1Pjfj
         VPVWuvGeokhOqD/EAZfiXvevvOochHA2hOMHOq0N+BjQ0CaxJ1FWC/3LK/0R8+/D+ZpX
         KiyyrxJHwISIynv+6jAHrBm6V3L6L7KglW7Mskf1V5QldN3pN9z/tILI5BPx3pXyIjo/
         T2l/JvoeySpPLiF+EFumuGnAq4aYIsXtlH3xGLmkxsqPMg7m8DFdm1SCxzBHysS5R9Wo
         N4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732009771; x=1732614571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP6utXSspykskYzsNkWUBuQWYEnMFsie+2NCl6mM1/Q=;
        b=JsEp6vrk8IFcqHFfBa7EIY3o2c1c8SOqK4i/ryoorgNVrnhGFIapiKPLITzeuSnwAt
         44LE7X7T4j3AwvWfizJKTBaXdZkKrHiD0OsfIhV7eyXXQ9LaLI3QBoWtJY3yWqC4z1Ki
         FUaVvO7biN9X43QgdScQiZgZ9Hkmz60fY91qCYc3T292j2I04PhBuRE6/3rB0k+nC/Pl
         fqwKTeNOvlJBnQ8aiwSABHwesOXxVG0dc+/cS55MCKweZPbrhXTBs6lWBT+7r+HEDWFD
         IHPctpy1Mg2rD0fdu3+NG2Ncfd81JzNH76vCWvl0mqZW0YlUlVckVyxa7RiB7p+hJsNd
         WScw==
X-Gm-Message-State: AOJu0YwPnT5HLJJyshGceGbLPnv118AqwE/SdCkAWwijdgjJO1tLB5Da
	96O5rNCh1EzGeNDSZqtXuLEkszZ6T6su/UPSODX0eIUzCjdJW+DPmhAjM+Pm/IM=
X-Gm-Gg: ASbGncstHMZG7io4ZnFz52XFg9zyHDwybqRTzRSGG8gjDQNXe9QmX5cdN9/znTgXhxB
	TSldQe5uD3e4qHWEKaFMv7n4eXDJZ9fEppJP1oKYSpEfGFrGUgFYF1UyYwFhAiKYuWB8Pp07fVM
	9mza3pgyelf2zxXkkPPHamXFneszFhXKXqoK4cOmf9mfA45h7CmQyLtp8J7vJ/UyrBe7NtGapV4
	9XZrXbJT+72Tt8xtw3M7DZN8U0UtwVpJuVXYz1hVNzHQPgLdB//iLpC34wF1YAImOSbwZiis1E=
X-Google-Smtp-Source: AGHT+IFwGycoY5tmfGgoWai1RPCDaLKxzMqxyguqzfyyT8M1bLxtmfQi8zo5SFAqATNoMeg5yALTxw==
X-Received: by 2002:a05:6402:50ce:b0:5cf:7aad:bed2 with SMTP id 4fb4d7f45d1cf-5cf8fc4210cmr5229935a12.4.1732009770647;
        Tue, 19 Nov 2024 01:49:30 -0800 (PST)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:141f:2700:f5a7:4035:a697:97ab])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfaa333720sm3306563a12.61.2024.11.19.01.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:49:30 -0800 (PST)
From: Jack Wang <jinpu.wang@ionos.com>
To: yukuai1@huaweicloud.com
Cc: linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	song@kernel.org,
	xni@redhat.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	yukuai3@huawei.com
Subject: RE:  [PATCH md-6.13 4/5] md/raid5: implement pers->bitmap_sector() 
Date: Tue, 19 Nov 2024 10:49:29 +0100
Message-ID: <20241119094929.148060-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118114157.355749-6-yukuai1@huaweicloud.com>
References: <20241118114157.355749-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kuai,

Thanks for the patchset, as you mentioned both both hung problem regarding raid5
bitmap, just want to get confirmation, will this patchset fix the hung or just a
performance improvement/code cleanup?


In patch4, as you removed the set/clear bit STRIPE_BITMAP_PENDING, I think you
should also remove the test_bit line in stripe_can_batch, also the definition 
enum in raif5.h and the few lines in comments in __add_stripe_bio, same for the
line in break_stripe_batch_list.


Regards!
Jinpu Wang @ IONOS



Return-Path: <linux-kernel+bounces-409220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D827F9C891B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9181F25830
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE51F8F09;
	Thu, 14 Nov 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2yJ8ipz"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422901F8917
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584288; cv=none; b=a/I5HJL7eIA76W4hrr/iIEsUXO/U9P41KiYlY+ks5wDESxOr+BKccBd13JTc7Aa9W0/7OklsY7QpwnyA6YbHqTR15iZXTvO3pvPsMSQHLJrwRc61/ch8LiSAPa/LVbvYRAqvX090OKSfbzvxiOD60oQC5QIC1j1q16Th6mYeoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584288; c=relaxed/simple;
	bh=cUSRBOtRtEATzCnokE3CJBbNGuBru4dkIeFH9zNcMc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pFlltJ1sy9Sq+2h7KHYnFs1qpMN2bgY7hix1FcpoWSfA4+IaTnpRExEP73YiXyylgnOEjFlJxa0bq3ShnaLHuiexXVDJfr/n2LfMB1HzHV5QncwRduoTTcLIfOzGta0/8dS4t2PJjYsf3sLCfG1Pf1OxF4mQnKnJGnEkaIhdXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2yJ8ipz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso4129855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731584285; x=1732189085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UOuG5Zwz3TO8LLif2nDNcChNKIJvAuTVAxlwC2o73I=;
        b=X2yJ8ipzd+LdQBAw0a3Imhsbf3LtpxGhkpxEb+g145Q1zD6V6efxkqmIwymeZolbCU
         rmK2DrZ2RL9C/Wu7wlnVaWZfWDwnFJtaOT/N5suLhorImVOUvzambQddEnSp5xolDHP6
         3sEnvTZmewPfySFX3h99NqztSiOv952RckfYx0YKWB350pA4i2HBlLYOFEgak6aWXFpk
         /ZQbZWmRc4aNKw+Jm1juJcZe6ydrbvQKEUj3v12RwSC/Cnv8qk1CUsTkIR1bCsB1UxyD
         3lsBWLsH+wlEM81q1EU3C+7z0twEVjz3hbqkiKJgMPiKoJeL37qdhh4JGhmxGdIY0rTt
         2L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731584285; x=1732189085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UOuG5Zwz3TO8LLif2nDNcChNKIJvAuTVAxlwC2o73I=;
        b=wwLGQyM7f8MeZp/yP5qcTnM4L9We3sGF0/IDoK1RMjLkavSd4EpBdiAn4Qxbicj34u
         wdCH8o2mS1fsmkb+ZNSpB+M8lLFpIqDri1dPhoHl8PZIYTBAAtkJmlKCyH3TtBDRGWMw
         A6ducY92b6pYi6d6XOZa+Pt6Osm6hP9C43qOHOjul9jmH1Xz+PrcuoBV+CXcl7C2xhAP
         5JtlLS+2bmdd3uqkqrHAfIBZsjKALiB+JsM3OPdyhW4Oi1qWCEDWSX/2G1XwREawgTvL
         0LuTYAlkcCIzJgCxyONSV35o52mFZLhM9ezpDFpgmwRUbUhuaVPeIWgwt+Uz7rT4xpBJ
         olsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiPAZAO7qx4d7EUjkIcGj8U2nGwErtL4+AH1xmSFEsTpY7FncfwxOyD+UIUIHsPab9+64PnAufticFcQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyR0pwHl47s1mJyduOg+8G4Nn2FJYmEKtmJN2Rj/OJxBdA+Ek
	x6HzT/00dSBRw0lTR8cHonV5R6C2zYL+KhzasjRaNssC/4QA7vdu5AoCk6gb23UqOov9Bwh/M8f
	aQOrEnYqmmQ==
X-Google-Smtp-Source: AGHT+IFFuS3vadEpxbm9rE3t6WRaBQwyUrb+92pbfldDrubUMoJSwgzEUU8T5UR1u6/5/h9itok/LJf9zGPJ7w==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:3ca0:b0:430:57f2:5b0c with SMTP
 id 5b1f17b1804b1-432d4a98b02mr347995e9.2.1731584285504; Thu, 14 Nov 2024
 03:38:05 -0800 (PST)
Date: Thu, 14 Nov 2024 11:38:03 +0000
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241114113803.3571128-1-panikiel@google.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: bob.beckett@collabora.com
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've been tracking down an issue that seems to be related (identical?) to
this one, and I would like to propose a different fix.

I have a device with the aforementioned NVMe-eMMC bridge, and I was
experiencing nvme read timeouts after updating the kernel from 5.15 to
6.6. Doing a kernel bisect, I arrived at the same dma pool commit as
Robert in the original thread.

After trying out some changes in the nvme-pci driver, I came up with the
same fix as in this thread: change the alignment of the small pool to
512. However, I wanted to get a deeper understanding of what's going on.

After a lot of analysis, I found out why the nvme timeouts were happening:
The bridge incorrectly implements PRP list chaining.

When doing a read of exactly 264 sectors, and allocating a PRP list with
offset 0xf00, the last PRP entry in that list lies right before a page
boundary.  The bridge incorrectly (?) assumes that it's a pointer to a
chained PRP list, tries to do a DMA to address 0x0, gets a bus error,
and crashes.

When doing a write of 264 sectors with PRP list offset of 0xf00,
the bridge treats data as a pointer, and writes incorrect data to
the drive. This might be why Robert is experiencing fs corruption.

So if my findings are right, the correct quirk would be "don't make PRP
lists ending on a page boundary".

Changing the small dma pool alignment to 512 happens to fix the issue
because it never allocates a PRP list with offset 0xf00. Theoretically,
the issue could still happen with the page pool, but this bridge has
a max transfer size of 64 pages, which is not enough to fill an entire
page-sized PRP list.

Robert, could you check that the fs corruption happens only after
transfers of size 257-264 and PRP list offset of 0xf00? This would
confirm my theory.


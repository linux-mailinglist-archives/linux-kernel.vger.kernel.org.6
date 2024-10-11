Return-Path: <linux-kernel+bounces-361549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00C99A994
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC4EB2491D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025E1BE856;
	Fri, 11 Oct 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1yOUQ1E8"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D819F41A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666713; cv=none; b=h8viGnLIe/rI6DoE6qLK05zqlvHo8+h9Ssae+cMmtJDxFCSQRY2ksUwZFvZDdExxJM866HvQ4EBKoOdWIGCA8m+2zh7Ta+xamSfBF0kGP1AGWDiNBO4Df0ynhaxp17XgthVkmntuNtJqwgB3JzLokRZSOjlCW+HR0bO6HHWo9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666713; c=relaxed/simple;
	bh=8dDA8zUCA0ufN6YZTUcwbyZZD9nq429HiprCNeDaAes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtHKGoG5aWjMxAD5mWzM0l6PaD+Nb/RxAqnD5IpOq2zQzTwr0tHb4/+rfMiwDAWp3S9JjTSopl/4eAiIn8SUIYEB2qIGBjpjwfmHHrY/TfbPwa56KKe5CUiMYp2bPnfTvTx61nYuFeVL9qsc0bgw3zXuudNmqSnuI23N+UdmfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1yOUQ1E8; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a39cabb9b8so7418635ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728666711; x=1729271511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl1i78brjGAuvA9ZnmYYUqyA41KtOxW10zwshpfXTuw=;
        b=1yOUQ1E8VaMunbMkHorpGpgShRb0elV/cmDOQRIO3/i/HIo+sWFqnTIRAvNuwU3reI
         liq/tklUbAvJqS5aUvibP69tORMTP6swIxdCoVbErlUrR6iltDG9gGYGD5SAAkqaid+Y
         nUeNMP1JKTud1uLzfNgGAWyp5j9m4nmiO1uGGRPoRISmDjumk5xXO7e/0I5NmE+ADdTT
         V6L2yVdBPX2Wu1mRt9Jy6hCmkLcHdrDuXqh67LtNO6IQ34tCYrOvTC7QQq+N+iruktuk
         Xxo2uw/wObtowoF5K6Hc9YAI0Nabrhs/0Xb/xvnjQ9F5qUvZJRgbTQZnjw+TsND/zqJl
         gspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666711; x=1729271511;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zl1i78brjGAuvA9ZnmYYUqyA41KtOxW10zwshpfXTuw=;
        b=qZwJ37OlvYfW+775F2isDKe3pFz6RK678Y2VM0RLQvvZaWO9UzhfIvHAdvEjJRNxLo
         Mv5oWWDjWVXzNRJjQpyn1DGXHc5aYc+B6mC6HhEzzp8Vm6jXWbmN6+GdR76vuqyhdbG4
         KTx32HDHG/eis2Sn+8wjmT3RA5nHVnQBemFxHkgZN1Q3zic2epeEr4jizUwea1i47ZTD
         Jnw+DVrCovdNAkgGaZYI2WPKOXIK2Uu3+WUprbBd3XdKWrIRWXmd3WrFVTnEE29ZJrDT
         SzyTWJyo0WKgSiFDgDhgo4kD8hUACeW6j2+/ehikoSc7bGD3x8B0FHFpf87JSpH2449z
         W/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Yw0WXDaxUltw2rPkJwvVL9WGpKlCnlCj3h8pKugkZ545hXVz6k13Nxv0lU55a5Y+oEd25t6qcQ+wY20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJYGLMhIxOslh7y6jF2uHFin6yE4TqmWNcYddW0pemt1LE08O
	VnYUUPEPxnxd3nvPSjYzQytBPeo3TgOCB5DsPr8sseLdVrPbpdt7vP8LHM9vIh4=
X-Google-Smtp-Source: AGHT+IEZWvr7qBTTjS/tuenU1bjvPDfbBSeZfkqk0imNClzLRq7tKeY/fBnJcfKDU9r03JNOKR3aTA==
X-Received: by 2002:a05:6e02:1809:b0:3a3:b593:83a4 with SMTP id e9e14a558f8ab-3a3b5f9e4e3mr26348695ab.14.1728666710924;
        Fri, 11 Oct 2024 10:11:50 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada846dcsm713654173.89.2024.10.11.10.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:11:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@infradead.org, Damien Le Moal <dlemoal@kernel.org>, 
 Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241011170122.3880087-1-leitao@debian.org>
References: <20241011170122.3880087-1-leitao@debian.org>
Subject: Re: [PATCH v3] elevator: do not request_module if elevator exists
Message-Id: <172866670924.255755.8635464713478237933.b4-ty@kernel.dk>
Date: Fri, 11 Oct 2024 11:11:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 11 Oct 2024 10:01:21 -0700, Breno Leitao wrote:
> Whenever an I/O elevator is changed, the system attempts to load a
> module for the new elevator. This occurs regardless of whether the
> elevator is already loaded or built directly into the kernel. This
> behavior introduces unnecessary overhead and potential issues.
> 
> This makes the operation slower, and more error-prone. For instance,
> making the problem fixed by [1] visible for users that doesn't even rely
> on modules being available through modules.
> 
> [...]

Applied, thanks!

[1/1] elevator: do not request_module if elevator exists
      commit: b4ff6e93bfd0093ce3ffc7322e89fbaa8300488f

Best regards,
-- 
Jens Axboe





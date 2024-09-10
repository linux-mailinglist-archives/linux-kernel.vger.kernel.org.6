Return-Path: <linux-kernel+bounces-322273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44708972695
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05145285BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5842136643;
	Tue, 10 Sep 2024 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MRStBg3m"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4527345B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931297; cv=none; b=d402+UfZlKvWyfzK3/3+QV1Sof8AdqiIcWSdzedwIIsM8+YhfbuOYoogXOnZGuwY0SRcB9n972A5Rzogadk4u4MPlEn3OkvQzEUPfS7f5AcQaEoN7mQtLxNVoldNHIvxDlxKLK3+h+cFchs4I56lBoos9xiXKXsqrKsfVlkBiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931297; c=relaxed/simple;
	bh=LbvpkixmVT7St4fCI6yGGQAnAo0U7oJSCnjSVHAkbRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z+eIPaPIReQw/hFLZe70CxvWuT7y9P8EThqyJDP33V6sSKavogc8PMbbr6ik4O3dEt9mpyaKGSevIOcNB8UNVXj6xuttOh43SCqnE0fFvpIbhmeLZIniTQpgtKNYYttGfklFCXeSqBF2+G40Jr/x8dzGmy0dpzb7PfVTrYq2OBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MRStBg3m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20570b42f24so2140305ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725931294; x=1726536094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbHezFl/yia2I+g8JEPGnuA0HdRe8qPShzuc/dAam7o=;
        b=MRStBg3mHE36aEzGRUKgl8wKBv37glNrXIU46gxoq/+Fvh7cge7tY4OUm+oKtKW3jM
         1zuv3TrP5UoK0kahd/gOeoVeNQ1/HJd1aQpyn+xOeI7mQP1ezPvCslufbMC16Gm7EaQi
         AtuKz1HI4aZtz2oc11en9WHTvivGGxP6DZoDfL/nYHf8IuexyAVPnj+7DFZDFQropMLg
         HQt/MoMZ/EYANvjaK69DZxObCp4vlZ7GzH0KYp8IT77QLt1wvR1jOwQ3EtIXEz1sTMzu
         ewf0QQ6rmX+GyJFesmbfsQnOdT4JHX0hO2NZ/AHDI9dNRVcCzbz+Uj5yUZ9QrKjAg4Og
         CXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725931294; x=1726536094;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbHezFl/yia2I+g8JEPGnuA0HdRe8qPShzuc/dAam7o=;
        b=JvRoUJTWEyEZnPDXjVvdLfDqLUdb+aNyOY0SZnPkQZe4T/OmKUAOZRHw2omH0zR9zQ
         ALZzRwJYfgjvm5/wb9PHE3JRPxcDoM7ux7pcu3VZsJTXIWJq2ZX2cJ5eMmYtKPDn13au
         g3jV/emtaTyo3sfCDhqFkH/ZgXtETGMdX5iwjNEBxGXvwXhUVuPbSgcuKFzMvkGVVFoW
         Mlt5okrxgvksigxhX6UK9RqNhQ1diTYeXESGsyaePQ1EOV6boLkFKOfqxq6zBPZFIEvV
         d9vQKkNnG1qNBzbg7wRnOnG/OyZUteUG1prYNobGxfEwR9Q1BKkySa8O/5KsF9QpjRmt
         kUqg==
X-Forwarded-Encrypted: i=1; AJvYcCUP7cQxrxQxEWKKUEAEs8Cns6ndHImoIPnlBGNDR/1apJrCROVvbl+XwX0+SkDaHlk9OmKlPW0iCo/nLpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyn5CYUW54Lrd3gxYrVqgtTQah9J8VLQQv/K+Jzx+qLQxkhmYW
	wC/q7fIR2SYe27bGJ23DQO5V0ilq418OoFiYvmF7SlEHbPp0LNnnKM4f2cE4wdE=
X-Google-Smtp-Source: AGHT+IFa+VZ81ocWMaBa2mFn46xb84Mt6PsKyBjpAI0MI3gvqZzTycK0AEdo/AX/35uwZXb4OrHhvg==
X-Received: by 2002:a17:902:dacc:b0:205:7c76:4b2c with SMTP id d9443c01a7336-206f05f6924mr132506985ad.48.1725931293861;
        Mon, 09 Sep 2024 18:21:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b09bsm39335845ad.56.2024.09.09.18.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 18:21:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20240909133740.84297-1-m.lobanov@rosalinux.ru>
References: <20240909133740.84297-1-m.lobanov@rosalinux.ru>
Subject: Re: [PATCH] drbd: Add NULL check for net_conf to prevent
 dereference in state validation
Message-Id: <172593129267.13781.9847171739560045999.b4-ty@kernel.dk>
Date: Mon, 09 Sep 2024 19:21:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 09 Sep 2024 09:37:36 -0400, Mikhail Lobanov wrote:
> If the net_conf pointer is NULL and the code attempts to access its
> fields without a check, it will lead to a null pointer dereference.
> Add a NULL check before dereferencing the pointer.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied, thanks!

[1/1] drbd: Add NULL check for net_conf to prevent dereference in state validation
      commit: de068f4741781bbba0568b44b41d51da0feef6f9

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-392441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4D9B9434
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078E328291B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1881C0DD6;
	Fri,  1 Nov 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gj7UqalH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A14778E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474284; cv=none; b=WftP3K7nI8kPWTwlyDySyvJjTNvojVwLG/xmQF/WwPBp85WyJSxLp/Ropqvtp0P9fJe5liDgXQfcikrLS8u6FxWT0IRcSf1zvItYaq8j9DkhGmO59VnTO8hiofRzG2bUtamxr0k57M1rpmLthQALMeD206mNt3kLtP57YdGrMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474284; c=relaxed/simple;
	bh=lkf5T6VDGyK+AxefNOE21mzu9AeD2d3DO0OV8fJLP+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dsz1ziNRQaEE2Ds7IhfagVnzeD/L7TPw9xnVD2Q4EadAVbnRlJZ1Hi62z8jdQqSJTXhyQAkP9dTwoj7PXkyaTx5p80Gmp//emCKFhs9G8ODiQivwcFrHYw0iouGyFdxsP5yHoYT+PA8PcB5l+oqytbTrRggm9gGe1D7PwQ67Cv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Gj7UqalH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cb47387ceso21486865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730474282; x=1731079082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z76tNBW7IiSXlnUlkX8YEl3RTDQ10RA/5zOtclJTWHM=;
        b=Gj7UqalHVi11YwDmtH+oQ+hNgPm/7lz26qP76ymyEAyGigHKce/sJ2R0W3M9dI12St
         ga8zfKGhRSwC2w1fRJY3uHhoNLsfJNsB9mwdOftcX1bUq+PH20zxWcxlJ05bZt2YOirV
         61zaDb0m77rJwkkHsSTpx29stgTPK1drgNFLX0/ZmJF3H5sbWZS+Nc3wjRgxzE7LIyOD
         fj4ksTF1XN71YX3ZuJb38Nf14e34bqx+mn5ZgoE62VgeuPrhVqBp5DwPOKyjpvpTlN1w
         xmoYN6heP4UEvSU9cUdyffS6VcE0o5agtGPIitLnyceh7w2BdgIP4/DgjzssbwTokTrd
         MJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730474282; x=1731079082;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z76tNBW7IiSXlnUlkX8YEl3RTDQ10RA/5zOtclJTWHM=;
        b=IuuGpq7WG2pdhekgVZb2AU++PjzNG1IFfacqIRs6RgprRZHNx9xXmZsq7tBb7wLuEo
         z40IlBXFucrVUBcPuT5AgGskpLeO0LT/B+BQtNQCo8EdfEE9ar7f8JpYqjMoCvLYXKAP
         mHz8fki0whf9lP+wXj4ul3IWiwjilHqwa9meuHTrRcCkRf+CrmEMdQFN7Lka7mjKCdT+
         sszEJYxsx9of6nKjlLUD4RkCHM64FV76GoijvnE+3nN3cj3YU2Gd93RzOaDHcfxTMsuX
         c4aVzAIW1A5LP0syRmC7k53bndblDQtwRpZDGG3fWcdE3wgLW8qsIxW0zMDaVycCaGma
         tp0g==
X-Forwarded-Encrypted: i=1; AJvYcCXh5a+iAzIpQycVnygUgusuTjk+aIt4oqy6jYyY0ByKgFula2uRq8CQ7VvYZmNWziBU1/ZhP2vZY7FwBMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67Tk1/hX40N6zK+JLrvGb4xya1Yybb0ddiq6emJfCeduoZ+0n
	LtNuGa+zq22bx08d6VsB8MqCkBrqvRsRt4qFU1YZRm3t2008so4leCYaawgAhFfEy+oKBXxS6oQ
	VgyU=
X-Google-Smtp-Source: AGHT+IFeNQdAJMdFu2eVkBAD+wHxFyp+YiN4W9Y8wYMbUNxprY5tnH5CjMhX/v4HkmIVX6xStac7eA==
X-Received: by 2002:a17:903:40cc:b0:20c:b0c7:7f0d with SMTP id d9443c01a7336-210c68db595mr292711025ad.25.1730474281550;
        Fri, 01 Nov 2024 08:18:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057069e7sm22762955ad.95.2024.11.01.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:18:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, hexue <xue01.he@samsung.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241101091957.564220-1-xue01.he@samsung.com>
References: <CGME20241101092007epcas5p29e0c6a6c7a732642cba600bb1c1faff0@epcas5p2.samsung.com>
 <20241101091957.564220-1-xue01.he@samsung.com>
Subject: Re: [PATCH v9 0/1] io_uring: releasing CPU resources when polling
Message-Id: <173047428059.527059.2484497150578119081.b4-ty@kernel.dk>
Date: Fri, 01 Nov 2024 09:18:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 01 Nov 2024 17:19:56 +0800, hexue wrote:
> This patch add a new hybrid poll at io_uring level, it also set a signal
> "IORING_SETUP_HYBRID_IOPOLL" to application, aim to provide a interface for
> users to enable hybrid polling.
> 
> Hybrid poll may appropriate for some performance bottlenecks due to CPU
> resource constraints, such as some database applications. In a
> high-concurrency state, not only polling takes up a lot of CPU time, but
> also operations like calculation and processing also need to compete for
> CPU time.
> 
> [...]

Applied, thanks!

[1/1] io_uring: releasing CPU resources when polling
      commit: 71b51c2fb200c502626e433ac7e22bcb8a3ae00c

Best regards,
-- 
Jens Axboe





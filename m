Return-Path: <linux-kernel+bounces-519986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB81A3A467
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF6166457
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D1263F36;
	Tue, 18 Feb 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RJdkFugk"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E126B2D2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899968; cv=none; b=tDV3Dk6g7YRH3VEOArZyIhCzGBotQIULAl2fb6Fks5ZeLlaFDe3jXjz1GyZ5PqYIoVtYgRwVR5dLO7uhogoNAoS8FBrAs3R8deWj5sBkqQcLrAjwAWxPPX6CVRzxsf8fv6sHNAweEKFL7rd04zmuCAkzLaCE9QHnhQgeQRlPRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899968; c=relaxed/simple;
	bh=D0ME5XaLOrs7wUb/QjajO5/u0moqQYqCk7WFNUIhpK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J4FMQGnuqpdfGUq6sLenD39ynjOhWaraG+BY1Ywwtq1iRqoSN1yfTBJ/g3VK/7/gPqDh13Q8cVnCJhOYsw5wvFdROFmvqvbdtLuz26rawydFNVQcpWQxQhQyNUjfnUTGfM7KmUNlpOjEousN2axVgt1JOKSUDcFReai7pHEjK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RJdkFugk; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-855b09fca35so28662939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739899965; x=1740504765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05XE+f2WQD6y8a665mMfd+nbls9jrN0OOQ0kqF/7mts=;
        b=RJdkFugk5r4OMCTxbMqaCbk5OUUOJXq3ZEYERc+CeV5a0pNQ+YUYVTeTwiPquL74Sl
         A5ng9rFHZzdwvJmTt/3yNCyLage0SCnyIJ1NowbCjB2GCJCGIWVRHTixLJ9lGvHl9hcG
         KlmSbtkj2Q0Yr0ppNl1Jk0euoka4drsUInH4EyObHEQKmsGTYrwSb0IHedYAsVr6ybFO
         410GxLSVeokPoynW3Vvwqi6rzxyRdctRf4ghKWqKgFtoF3KKIlmkW/NUF/j4FPGqHeS7
         cbaWMgA1BVF03Ff8pBoHSoosdFnbwJdrlBUX2SnQB/zAu++atiCqTrlPkSACNuvm8QCk
         WxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899965; x=1740504765;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05XE+f2WQD6y8a665mMfd+nbls9jrN0OOQ0kqF/7mts=;
        b=P2safBNcNfkpYHq7bNgzyc85LJO0FBg3443JUeFYvdb2UiYUomH1Glluq48LC3kh6w
         8nvz2PIMb4MYHBPUxkiRYysVwCJcNVJ1m6No5624QcXyCOOGsJtmHargffgA4lDqov1k
         nOQ+H+YGYg+CgytaDVGtTJZD/PckFpG9j0mA++1BFQTkq2vS2B7CL89Ed/Q9i7BZg39U
         0UiwX0SXXvJtl0D/vkDvbCIiCEhiRMLI8uPcwS8fdynDIStNv34vUmK8JJR/FJsq9M9D
         mwV4KCiTrCGDhdwoEcU8t3gwemyDOW8SgPZzUAqF8ynIf8MCfrETofrxC0oTn9C9YH1z
         hUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFBsQv80DeskhferfHtUyjVB1uFXrRAC2kxHj7yB4O43GvzN6Fa4XVSaQDaoy7Fooax23KE2hI/siR7PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnQsElQbx6dMT/goO5bMwfPb21i1Q3IOtEyoTyL5AeSRpAIZ6
	q9CWGvoM3wvUUGLYR+ZgMKEzMbRgevu8BvYkWhpT4pSIPczHaFMNszRRDMvGYovt7PP3+pVrL2K
	R
X-Gm-Gg: ASbGncuLsCl0THiFu5W2tI+tmqQkkmvXZGyJ2ee0/sDGO+Tu133yCFlvFS/N7kvSrar
	aAlmCMQ1/agzwYe2ae6eAHOJQrxEA54D/FbNH6ytRx+1HPGCmuvjMf4nbkyjxBbmRIvDyBTJlSt
	d9S3zMn4pUEkUXqBgfRnzSvywy+R9uDM7MOWFmaR4jfggqe4it9AbSSxpafSxw+Ea4N3LTdhaUj
	W2QM2WfQ4SFgwmiKwHsEGql7jlg/Jy7SxC25Yc8xem0LM+vtWOV/mFeAhw9UdLBox6qn1s+x09Q
	Y8P442o=
X-Google-Smtp-Source: AGHT+IFofXvSaEl35Mmei2TpiA2vEBnBzeUtOtW7FrKzKpWBWviuOWFTZQ5Xp77XjS7Cbjpuib3taQ==
X-Received: by 2002:a05:6602:158f:b0:855:78b1:8c29 with SMTP id ca18e2360f4ac-8557a0ce31dmr1252063939f.5.1739899964865;
        Tue, 18 Feb 2025 09:32:44 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8559d52bcacsm65489339f.25.2025.02.18.09.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:32:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250212005119.3433005-1-csander@purestorage.com>
References: <20250212005119.3433005-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring: use lockless_cq flag in
 io_req_complete_post()
Message-Id: <173989996383.1462475.17339377843072880185.b4-ty@kernel.dk>
Date: Tue, 18 Feb 2025 10:32:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 11 Feb 2025 17:51:18 -0700, Caleb Sander Mateos wrote:
> io_uring_create() computes ctx->lockless_cq as:
> ctx->task_complete || (ctx->flags & IORING_SETUP_IOPOLL)
> 
> So use it to simplify that expression in io_req_complete_post().
> 
> 

Applied, thanks!

[1/1] io_uring: use lockless_cq flag in io_req_complete_post()
      commit: 62aa9805d123165102273eb277f776aaca908e0e

Best regards,
-- 
Jens Axboe





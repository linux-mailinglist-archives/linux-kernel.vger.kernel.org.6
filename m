Return-Path: <linux-kernel+bounces-523955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF9A3DD55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A11174F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E71CB332;
	Thu, 20 Feb 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AwcfAU70"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957E18A6CF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063097; cv=none; b=u2K1t7NHY4gZCPJZF+uNPx2Yib8/lzLLE+JnBdyIIyKXvMGfStBC9rpxWFcVbgtpqXfJ+I5Zl3X0i1XEosmfKwZD4Wv1yRFMamWwa/fA4JZC/7vYlyto94Moz5KYVvOYluW7zYvy3EUUbwQHaJ3n/RT8eeWyoPsqUp/AorcQRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063097; c=relaxed/simple;
	bh=3G1aWoHZCBKxjsr/eEd6Lg2OmBOk8NsGZmoz2Ik3DU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GZUxgndEdi95nSzRLvuPXPalZN+C1IBfN7Jod422bULGBQx3FMOX+OM7bSkA6HfC7Yd7UgmIhO2pvw6leF87ZD6DQrCdlKHnnCzXSQPyPH7XZuPPgA+vSre/AoQ/0lHsXEduhfZZAZKxgvur5HWeLygWeCh9oJTNg9Mb45KLjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AwcfAU70; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-855a7e3be0eso27160839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740063093; x=1740667893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8x+B4TU1R/TaOWmXY1vZ9LdmepwMb1xawtC/WEbMOlI=;
        b=AwcfAU70c0WSRfH7dWmFWAoSIjWPRoAHifzuO6EiGhcxD23BejWxn/LlNMElihnmyq
         9hsWnf2w7Z9/uNWSSX8nGzszWXvC8Fi5alXJHIgFRVNm2A/LL/43J/XlrkuhHZNqp/tm
         xadZpi426RrV/FLJ4WEYwblAyj7SpUKGNggyLtV4rM0s8zx5iVY9a/TWEvWWr7Ur9h4i
         51PxLqGcUSGc1V+ov+Dp0s6GqybcPRAp+WcvRtp4miAqb2SdOxkMZHbRQW8KdaBecIw5
         T3fDa9am20FPNvTwxltLbdmHC38Gi053My0a2pUD1xUihUIgrqE7/6DS0g4t/gG9N//T
         In9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063093; x=1740667893;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8x+B4TU1R/TaOWmXY1vZ9LdmepwMb1xawtC/WEbMOlI=;
        b=nr30MBXHA5oOCcmsMLNTMILJeKlwFrL2QKbNuWCkevbujoElFtrZ2ZMEM5Y+GLJpfR
         mZnSZBix5TX29qOa/Ie7jBOkr9bwlQFFHdo8stcvxWQWPor39qfCJ9l6HBFzd21DYk3f
         WXfyaq+eU4r07JWHvnLAluiIERxjVvUagIpDXQfsTWhUr5R+5QBddSQLTrvVLniQo8UO
         GJvndM6uqNUKapSx1DbZds7m3wLvQbZl4umobQdRAArnpZRtKA9lPHIjpT66s1zNL21g
         BF07r+dYn4GhHcDrkBaM2TsWdUyKK7bP4WpbuH5CQwmbXGM7xRIDaM2Bl9Dang+eNfcH
         vxQw==
X-Forwarded-Encrypted: i=1; AJvYcCWCp9IuOLsZf9ZUrK49iBXLufElYqySsQ91vPI6PTjN2loD8Qgwrl8nJs/j9C4E8bCg/YHxpO8Twt3RjZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNLAhb8Amw/MNDObW86Yv0YvJFGLPm74dl3ZoFTaN87sbpTTy
	X5eWnn2o1+VZYxRB/d1XfslVjjTKIvjD2fxSZ0BzrKbGDX0JpKJOzL/dVx3IbCAOJu7u3S8kRg1
	6
X-Gm-Gg: ASbGncvTDgID6KX4FPG0u2fDWBUnjkBfybtdrF15bO7W6nfAtVsOE5Qa+8NgErWSnkw
	KhuQJuQEhmfEpxdugwYIphp3reiSBoTSEgp4+wpOln6G03SY3uW2UJM4GJ3Cx9b25BxwRYQVU6D
	juZsZzf0XKaMCEFpHIt0k/YsxRZESFqqTvkC96h+xZNTlplaR7NFVhGxVMPL6ZxJ0/pGLVUbeBv
	90FFjGxTvxTNKbRPF3WJBY3dL+j4QeCb0LfeVjiIZspdjeJ8fBJIqEJp5+m5sVKKE+IGG2uldgH
	DKMk7Hg=
X-Google-Smtp-Source: AGHT+IEYYi1lQn/B+HL15BpZFo+i19+r8C+N661N0XWhxq/TtpuIkLpqZt1StiRfiPzIhrJPwPPndw==
X-Received: by 2002:a05:6e02:1b09:b0:3cf:c7d3:e4b with SMTP id e9e14a558f8ab-3d280919df3mr261797085ab.21.1740063093591;
        Thu, 20 Feb 2025 06:51:33 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18f9a89a9sm33784445ab.10.2025.02.20.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:51:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>, 
 io-uring Mailing List <io-uring@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
In-Reply-To: <20250220143422.3597245-1-ammarfaizi2@gnuweeb.org>
References: <20250220143422.3597245-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH liburing v1 0/3] Fix Compilation Error on Android and
 Some Cleanup
Message-Id: <174006309264.1672035.6610273505554694557.b4-ty@kernel.dk>
Date: Thu, 20 Feb 2025 07:51:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Thu, 20 Feb 2025 21:34:19 +0700, Ammar Faizi wrote:
> Another day in the thrilling world of cross-platform compatibility...
> 
> Alviro discovered that some Android versions are missing `aligned_alloc()`
> in `<stdlib.h>`, leading to a compilation error on Termux 0.118.0:
> 
> ```
> cmd-discard.c:383:11: warning: call to undeclared library function \
> 'aligned_alloc' with type 'void *(unsigned long, unsigned long)'; ISO \
> C99 and later do not support implicit function declarations \
> [-Wimplicit-function-declaration]
> 
> [...]

Applied, thanks!

[1/3] liburing.h: Remove redundant double negation
      commit: 1d11475301931478bb35f2573e1741f5d9088132
[2/3] liburing.h: Explain the history of `io_uring_get_sqe()`
      commit: d1c100351ffb3483f5d3fc661b2d41d48062bec1
[3/3] Fix missing `aligned_alloc()` on some Android devices
      commit: 5c788d514b9ed6d1a3624150de8aa6db403c1c65

Best regards,
-- 
Jens Axboe





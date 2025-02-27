Return-Path: <linux-kernel+bounces-536641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8EA48269
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24DB189E677
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FF25F7BF;
	Thu, 27 Feb 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xjkB67m1"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696F25EFB7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668259; cv=none; b=lEoGkMeU5ZGLxj4HQha+JgB4lgD8oXzS9kKZlxrSdaD+3E92lC1wZuKAL6w7GWnPKBmKaYnSAZfaYN+msC+WYPwZIB3VKcDCQBv/tvN3+X0c3DglIZf39NtzKHY7ffzUrOznXN6on3p816+52zKc4S0fk7Y+r/q+emzJYKFP1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668259; c=relaxed/simple;
	bh=tZaT0Zj5QAhJbLmAkDnK4TyAUYj8HZf2s6d5FLh1JMI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h2/yUn9F28ybwwGnSL5RUW/7XYhuD4djIEzJD+Nc6FvYushYx/7b+ug9hYxFiT4rM11zEEReYOZiGuZm0PDSSh3/9DxopA5ySPwsDvIbdITB/ijtqIgJqz6w2TZpHEzmpqQXa6TEK6ecH64WloLtfx8UOiEDTwvI5vGVUq5Ua0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xjkB67m1; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-855a5aa9360so74772439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740668256; x=1741273056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvehVzeKkIphPFqeGIU7tN9oKpOYBtTWjoy4djcKaCY=;
        b=xjkB67m1WeQ72ZSGaD8hCufBunuvaYg0AvXX9R6mVDAxnRmViYK5lADDpEQzf41jdr
         x/3lnnkQTrG9kOckXWkRyfdCXBqOeCCdeK/s7y56Y0q4eaSdvaGLXBPvbSIhT+Y24tVG
         8yCYOk5k2dFeSGccGuq/u/+8cYBbB8OOZ1RXXUkdkeqkYCBPD6eANBxmkL4FdpHOtnc+
         xlT+rA5dYsgAa7v4UVo3v0yz1UQ2ya8Wf48/4PgcykmUx94UpnQi8dQ04NzPesQcw1YS
         CEZQH7+gyglCAmY+BXiit9LOswmFnjfcf4rt2wZcEHt5SSmalXq3HM8gfw3yyyZLI4Iz
         DvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668256; x=1741273056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvehVzeKkIphPFqeGIU7tN9oKpOYBtTWjoy4djcKaCY=;
        b=n4UFvNE8MsHhE40JKcgB6kzoanEjOeeBv4/bEfI+w9VX/SUgun00xFKG3hksmIoQpf
         kMJiqJnTIDpQaJGvgNioCa4bdViL0WptXk7yIKWyLMX5zw2RX7T5ZL720losjJqbj7sM
         ici/Iuk0s6h+ZW2JytK0Si3mYKBumq/tnikYRVCsKWKTNrZjfwoLAaU6Fe01kI5efpru
         iMJutw0x2+KzSFJHkE2eAQsX62QHzcB2a5S0rXEEYfDitfSSPGwNUOdgbey8ZKpSwtVq
         VlgDw65vvQegyeIlrTmK06CAPDkghPUQv7Xs3rYfqjqB8Mr6sCI3xNfcMiBFUCwkfKsL
         R+hg==
X-Forwarded-Encrypted: i=1; AJvYcCU19OlTt1QoqVD4KvIPq5JlGC5Qv1tCT973ZjYINtwKMphn0/X9Iksq530RTm9RkDg0O89ukMgYGAGhgF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+synOhrlOIDtZkh3mzq0cseE4zvGzaqAJkKs9CEGlCyOCRuJS
	HRgaLRQy7qJBnbhUz1XvTemkrVqTuVwud33KjDVEEpZvcaatssGMIebgCr96sps=
X-Gm-Gg: ASbGncs9eZPUfisE3YhLudKQ+QWerl1QsMxU+KHhygAVnvNJwPQjjI8bsKi8g96ZmPA
	H4bbjX/j2+GaoLZLlMrmmiLIOCz3uyifuAVMUyVNi+ENJ95bX60QK229Si58Vm+d+IBaLPOCul/
	k0jWa7zHloO2Woj1u/W7lYxUThgBM4PAjk16eLkkPAPyM4lKgb4padOmdBbhFnyFYHe9xnR2lqb
	ljlJPjihhbtUMo6uggIZZEqIWD4QiQk2g1oIUEBXSZFLnsajwGo3mCzK3SPeuzLyNeM6FJIDN4W
	2l2DO/I+PBgKhaC4
X-Google-Smtp-Source: AGHT+IG5JkAqegx0ZeMLyNqVGpCwsaoLZ+LfxM2FEBqUJ0YGRH/m4CUfZaxxbTUZb0rM5nn1Gv82HQ==
X-Received: by 2002:a05:6602:154c:b0:855:c7a0:1e33 with SMTP id ca18e2360f4ac-8562014a579mr1351845039f.2.1740668255864;
        Thu, 27 Feb 2025 06:57:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f7c580sm378883173.130.2025.02.27.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:57:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Gabriel Krisman Bertazi <krisman@suse.de>, David Wei <dw@davidwei.uk>, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250227132018.1111094-1-arnd@kernel.org>
References: <20250227132018.1111094-1-arnd@kernel.org>
Subject: Re: [PATCH] io_uring/net: fix build warning for !CONFIG_COMPAT
Message-Id: <174066825461.2448424.2288181673828962428.b4-ty@kernel.dk>
Date: Thu, 27 Feb 2025 07:57:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Thu, 27 Feb 2025 14:20:09 +0100, Arnd Bergmann wrote:
> A code rework resulted in an uninitialized return code when COMPAT
> mode is disabled:
> 
> io_uring/net.c:722:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>   722 |         if (io_is_compat(req->ctx)) {
>       |             ^~~~~~~~~~~~~~~~~~~~~~
> io_uring/net.c:736:15: note: uninitialized use occurs here
>   736 |         if (unlikely(ret))
>       |                      ^~~
> 
> [...]

Applied, thanks!

[1/1] io_uring/net: fix build warning for !CONFIG_COMPAT
      commit: 4afc332bc86c34b74f1211650f748feb6942a9cc

Best regards,
-- 
Jens Axboe





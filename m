Return-Path: <linux-kernel+bounces-513670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71CA34D43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769B4169083
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00F241698;
	Thu, 13 Feb 2025 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3WxjNp/L"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9481204C21
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470440; cv=none; b=hH0hqK9Sy4bhnBO10vZWCV0irSjo/v1yUiJfcwxbL4Sjq5H83s0u9NZmXL+UsJvFmdow5VmdLqapVi2cdqph/NurUDYRgpnN/f52bpxZ8Anas38JYLNE7TNVz2zjzx9jGVUkFECuCX2cDg5rkOcCWqs1t7p019om4j+7R1xihQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470440; c=relaxed/simple;
	bh=4dWR8UdjuRomTttxX5/xYUqN4ypScstE9Rpra2ITGqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ei+8ddqrJni8ajg8IcQMmFTx6yRSE0JpEYyvt69Abv5IatEj1k4k205YyNEK4V4rrXwyV/AgL0r/Le9lth8KIN50+fZfgyznfLyOnIHgsUEeDT4Q/kITg77OT4rAl7W9qQaEQDyeHaoZCqeFwsCc+Qi0Fy3CPh7UmJ007P0ie3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3WxjNp/L; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8553108e7a2so88343039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739470437; x=1740075237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZKuV6ztpfHStLdKgp7ewzwh+eJbHdQt839HlnoCPTI=;
        b=3WxjNp/Laf2a6DITw4tqwrPXN0vQhDpzKWb+PlJoB2lRGPA0E5cgpzQM0qmQRgIwp1
         /rlJ9yHs4TfsiEWbcZVnEIPdpCZyH0BBp6VriQZhrkPZocnN4idyADpi6MBDKduFrYzj
         Nm16EgL4DmoRUqngz8WbBY7b1iM29Wbz/aEl2ksU2xCQRzt9Ag/1QJTijfbS2nxL7dDO
         lrbzFKKhL5UPN+WbIvNVEqFJ8b1Yzzxjlzu6S8EzpizuZATtrFy1R5EWtuYCeqbEIYbx
         YHKe/2rF+fi573weKezz2O1eagUDeU4DX09i4Bdl3hhU97IhRTeCxDDtu2iabGpy1EkN
         dc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470437; x=1740075237;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZKuV6ztpfHStLdKgp7ewzwh+eJbHdQt839HlnoCPTI=;
        b=LegXVz3pXymuS33grHzaIoVU/94+lIcvhxqDoaxbV67Xdv75agAcZCoSYD5Bxf64pc
         4ngl93ax6O0SRo15TtYDUb/X+MI7nvUCB2gBR4Rg2LY2UK/wpDh09zDfV1nST3th9Nqz
         AxBhPB3YWYKQ7FeAkAV1uoZuNM/vLSiM0A6P8HHnLQcQjbIWuM7ET3bg9DvnPXPuoInV
         Od3y8iYSgUgW1nXcdqZpCZUA288EZ14ywVe3VYWx2YWsDjlPeSEuWsmErgZAJlUdpXoD
         tDbZzMNAfCBeHKiJ51Ba+j0BGqbV7r99+nnfdvtYC0XpZDRT3rVGD3Tz/JFHliNOj60p
         dSbg==
X-Forwarded-Encrypted: i=1; AJvYcCVUx552A4AkbqQqJfVqnlPKo/wrS1HggqSXK2uEIgBxclBqmtV9/6oEQC1t1QDyaG7AwHaF27ugQ9jHgYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDzheaBLtP+OoV4dPUn+oFFfwQQWphZagynFGoDaVoxbpvLk6
	0+gntDzIva9wC6znRM99mA4q0VUfYfll0RGujiGoGQeCOACbtRj+W9OrrnwtaaO3MCWfn8hd54h
	u
X-Gm-Gg: ASbGnct3S7mU809yo8NEdpIwgJi1aiYLUj0ldwxd024nEvVd4omlu/wL4U9/SXKqRDk
	g7jJUdHuM/JKd5ic+++R8nt3uBnbZshSy0Q2mUzTBFcpbBQA8dFwKwZX1UoBkYRA0a0qBEe739y
	IcKIOOpOE53ASfUBkbnp6qJypo/xuaDK9CpHv4KYKj8pW+4hWsMrd54cN2eKY/cewXQwMdCQI1u
	MRyf4M60zuVte+2BnOXxm19YKR6MWYVEk/XTQJ11rsw1k/iwbcKBodGemlWgnF4obXTh2t0OqI+
	HTNw9Q==
X-Google-Smtp-Source: AGHT+IFYqnWk5f0JES3hQ9n3Q+ta35+zi5h2D5I/p/pXrnxXfRVQsXBcfq9k1oAj0aQWJrFL0cryGA==
X-Received: by 2002:a05:6602:1687:b0:849:c82e:c03a with SMTP id ca18e2360f4ac-85555d72cb5mr698388039f.10.1739470436769;
        Thu, 13 Feb 2025 10:13:56 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282dd0ecsm420764173.125.2025.02.13.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:13:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Riley Thomasson <riley@purestorage.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212204546.3751645-1-csander@purestorage.com>
References: <20250212204546.3751645-1-csander@purestorage.com>
Subject: Re: [PATCH 0/2] uring_cmd SQE corruptions
Message-Id: <173947043564.300246.6895423669336979822.b4-ty@kernel.dk>
Date: Thu, 13 Feb 2025 11:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Wed, 12 Feb 2025 13:45:44 -0700, Caleb Sander Mateos wrote:
> In our application issuing NVMe passthru commands, we have observed
> nvme_uring_cmd fields being corrupted between when userspace initializes
> the io_uring SQE and when nvme_uring_cmd_io() processes it.
> 
> We hypothesized that the uring_cmd's were executing asynchronously after
> the io_uring_enter() syscall returned, yet were still reading the SQE in
> the userspace-mapped SQ. Since io_uring_enter() had already incremented
> the SQ head index, userspace reused the SQ slot for a new SQE once the
> SQ wrapped around to it.
> 
> [...]

Applied, thanks!

[1/2] io_uring/uring_cmd: don't assume io_uring_cmd_data layout
      commit: 34cae91215c6f65bed2a124fb9283da6ec0b8dd9
[2/2] io_uring/uring_cmd: switch sqe to async_data on EAGAIN
      commit: e663da62ba8672aaa66843f1af8b20e3bb1a0515

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-571887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F396A6C3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69827A8BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1EA22FE0D;
	Fri, 21 Mar 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yxERy65R"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693C22F392
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586828; cv=none; b=gSbXquWHXd34aHsA/jasjecJBv/3p0q4bItVn7Xeb3jRF/JGb2yCHiiV8c7ThyDY3vqAwbINLjp2+nXGUC6+OoBLSaPvzXYfdSlobqOSrkG7uJbCVwLzsI9mtPtbAZwoP9G5YnFjn83+3Q+HgfkmK7xmhTrGvRkNKei39UcERUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586828; c=relaxed/simple;
	bh=R1bFxZwTHqysjq7Q8LQpThhzLH0VTcsOTt2iO+OFDYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aG5pL7rvCTBCmIXn/YoB44cE4W0ZzYBpYH9GbEfPll74PTGdQTgz/3fVaacD0AaRS4ha3OQsXcU0sNhP3WU+/mSqUVdchpTc/ATcli61eWRM8tc7agzJXDNaZqAqwDxb+YVFp5tzM3ULF09eud+w5kT6tU0UbvOycVuHzdKSzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yxERy65R; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cf880d90bdso8560845ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742586824; x=1743191624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzesUfd46zeebs0CrPG+xIoJVH8zLtMaJo8L9ii+mr0=;
        b=yxERy65Rk7349aDhsUFGXhyYl4dTWQpcERfGYO42dUDpwhr2IOb+Piv0hdJmz8Jrc/
         eQx5ns6VS+N3w7OkLaM8Dw6VArcNuTi7klx94FWEIB98duNhlsvXJlLH5fRVvZcfoUgw
         n9729LoDEbgGHxL8jB7UsRpl1GR8WOeYuhuZiPj6IB5KM4qsAZ8Kj2ES4IsZJnCPRepf
         b4DQTh7lkMu2ujMy8waGhMwke19/dxPwCwmQVmuPfZ/age/Er916soQZxgIdPxLmQYZy
         ZCT7gufJNW0VrUM7drfNYB0qEC/0LO/T5qb6uZxpZS+8jsq/0b6UTHuj0IqNV/sO/e1f
         CfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586824; x=1743191624;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzesUfd46zeebs0CrPG+xIoJVH8zLtMaJo8L9ii+mr0=;
        b=bcYCuuYGNEIhbJgDRE2saR3r2VnbXkHVqbELSs1bCQoRNrlJ8wa8pi86lTv0HtQjT+
         8+tVxyRxUS4QGDA/37iPezl/6hwPai2NNmgMz0o6j1KEqBqD7w19wrJ670OKxFXGa7/x
         UP4q1qBKuPuhWTG9BY20uJTdspU+TvryfhSupQ94AyuKlEbR0no3t6b3v5WDLnGHkTNc
         L3k7BZvgtjdYDjbsYxeDoE6RBSHd5F46DoTlqULBprKGhhSzHt5Smqw7gvLEwhDSeVLm
         iqrWCyZqzofPhsimNL5xcIkhYb89U60q0KzX3A+mlvEY7DOex/kvPUUUqT3n0vNm+XtM
         szxw==
X-Forwarded-Encrypted: i=1; AJvYcCV8oNNqeD3oJ3Lm9N1mOQBPrBgT+/yZUf4V/GDvd2oAwT77Kpo7EZG7w0uUurfQxJ2uQdhd3Lcmc8Sa380=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQmivsYwuXFcVSYJ6PxLD32iGrrWkxQX4OIYFI8LmM7PKC0F0
	T9CojEuEyZk4r+SmVn3Uo3efkk1mJ20S2mmGNwHVEjRiHxBMW+qLPML6jkpp6Nw=
X-Gm-Gg: ASbGncvFsm6/N/glviMIFu3ovocFF9E6S7xp4Z8Ar181kzFSj8XNMlQMdV4GGtLlYea
	s2Mh3QIpyBseneeFO5rl5OPA+N+IVWT/r07VJYu8ZxsGjLNzmiWYMHhjh/g/oJDLuE8SXWfDHU7
	9+cHHJO/tKuXPf63/xyZFHfsZ/CuG+juyTfmQ9Ih/IBu8N9BQ7lNsclhTfNLxqD/TvNe9rm5uzH
	Y94XDonugxqBCauwifSpPs03opYhpuSLGW2OYPkL21aJU2Ps3PScP6gY6Cveje0xbimzDQ4n2I3
	O44VeaMQFqIwleNKXP/+jVgy3CCSCizCzYvv
X-Google-Smtp-Source: AGHT+IGn7T9SD5ve8iBciVQ/OCx5fdDy3xWn9IiJSqNMPE9sGxY4HUf5wukQHEc1lEXa/fwCOdPLkg==
X-Received: by 2002:a05:6e02:3112:b0:3d5:894b:dfc7 with SMTP id e9e14a558f8ab-3d59616b1c9mr51603165ab.16.1742586824296;
        Fri, 21 Mar 2025 12:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d59607e77dsm5694405ab.16.2025.03.21.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:53:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
References: <20250321184819.3847386-1-csander@purestorage.com>
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going
 async
Message-Id: <174258682264.742943.2572990287219952668.b4-ty@kernel.dk>
Date: Fri, 21 Mar 2025 13:53:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 21 Mar 2025 12:48:16 -0600, Caleb Sander Mateos wrote:
> To use ublk zero copy, an application submits a sequence of io_uring
> operations:
> (1) Register a ublk request's buffer into the fixed buffer table
> (2) Use the fixed buffer in some I/O operation
> (3) Unregister the buffer from the fixed buffer table
> 
> The ordering of these operations is critical; if the fixed buffer lookup
> occurs before the register or after the unregister operation, the I/O
> will fail with EFAULT or even corrupt a different ublk request's buffer.
> It is possible to guarantee the correct order by linking the operations,
> but that adds overhead and doesn't allow multiple I/O operations to
> execute in parallel using the same ublk request's buffer. Ideally, the
> application could just submit the register, I/O, and unregister SQEs in
> the desired order without links and io_uring would ensure the ordering.
> This mostly works, leveraging the fact that each io_uring SQE is prepped
> and issued non-blocking in order (barring link, drain, and force-async
> flags). But it requires the fixed buffer lookup to occur during the
> initial non-blocking issue.
> 
> [...]

Applied, thanks!

[1/3] io_uring/net: only import send_zc buffer once
      commit: 8e3100fcc5cbba03518b8b5c059624aba5c29d50
[2/3] io_uring/net: import send_zc fixed buffer before going async
      commit: 15f4c96bec5d0791904ee68c0f83ba18cab7466d
[3/3] io_uring/uring_cmd: import fixed buffer before going async
      commit: 70085217bec1eb8bbd19e661da9f1734ed8d35ca

Best regards,
-- 
Jens Axboe





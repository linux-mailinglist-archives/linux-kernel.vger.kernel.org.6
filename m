Return-Path: <linux-kernel+bounces-233078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49391B1FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEED3B2114F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7E1A2542;
	Thu, 27 Jun 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hc+5DR/9"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB11146D6D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526273; cv=none; b=SlGk/Qb4MG7+TA8nwrEuKknyQ683pVXr+D3EvFZ3EP9Z1cWYatONUttZ4xiJo3RLa8WpadCcCx526WibqTtqN7PwrkgE8PsMcTDqQTBgGpP/kCICOt2O67TJ1jZ7xlJbcPE9yWKPOGmPxHe6uXT5Bth4zytVCMj5DM3t5mgk2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526273; c=relaxed/simple;
	bh=X9E4Qk1wxYtBh5bxl/u2UGW8UBo30DycI6hdjoQ0HLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qPNECUg/otDQ7JOWDrtr6zcTMKY+818jO5EhjbUwQQzGj+8rDWUs6tBNBooiZ3++XCZqNjWqPujoE3oRcRt5KlubhG3K3dGylVuB6lMfgY39D8sZxyP1ioeB0n6JCT0d/YOvLj5hzp6HdMwJ1JnLxmZ9aTtneUjImBCLbwX5cTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hc+5DR/9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9c4ec8e04so3847585ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719526270; x=1720131070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzUeJSzA7O0i1y/5o3j5JniUi5itc+6L3iH7CyccPZ8=;
        b=hc+5DR/9ezmyFy+ezlVzhhoM9li1lzAnIqfMEb7ANQtP8TSn4Zx6TORh9zl7kPehA2
         xrWSAqq+CCjTECKAR1oLOSUEwZO93dqtvLsgj8OvQusCWgieOQtWLZ/KTY0ezG5XDBks
         fHVNlFyDHsc6JFYGsLxo/6N0K+YLyfdX6fIeS0BSFYdHF2vPK8wGxC8fFBEuMHzySdzu
         IsCorEczkAeEntbWPs0FvG7OA7WR5kvpPKojaiuqA040XIccYfwTOzuVXaDWYAWEmMQw
         lwOxRXJx3Ag5ByKz4zKLvaloLBS3duIAw9BEWpym8Ef9pzG8cvAfiv5whFZI/wo+WST4
         DYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719526270; x=1720131070;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzUeJSzA7O0i1y/5o3j5JniUi5itc+6L3iH7CyccPZ8=;
        b=wIqyCmL6z4agfEMvPyvH/j4iR0LKqy/NJL21EmvSI8eGmgzgse721fqAeEmWXvINfn
         tYWEifydCqOQG34q7d6hqJJt6lEJD+2CaJyTWdaohXW7G8oN5NnM4YZ1p1DTjQUPqRn0
         UvE1BDte19AM5VQF+l9heKw3rkF+9xkvJ4XAXUPHUzStPg+uxbYfT+beDSLMJ1HOaffk
         o/wl+eRuhRZi75fn/3VHQB9b4Xk1LRV1EvoZfjYg9IFsxV5Xhwg+P8ZRJm3zsxmC6/3u
         c/5lyUiy/oi2CeE7uoyiTqWG1mrHgGBlRZZQTRpfD49C+W1YtJMubB2USxUOFFXNGKpf
         4UTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2v/mS6FsTEx9x141OYIDGrkXB1N+InCcIE8Ee0JvpPUmdk1t+V/6wkdjZFc2u+ZzBcKiiQg4xReXSPQMv/HQWZKZkH9PCSv1yi/rB
X-Gm-Message-State: AOJu0Yw+j+vIDwMMVgLPA/SviIGoG14UgkDA0H2m0+PqD8yDJCy7AuCp
	gaB4VEG5dd20IqRvCvqW9tr49hUUg84NS2lTShH0JFSe2Kh/6XvRYNOly5PHZRc=
X-Google-Smtp-Source: AGHT+IEkdnMzrHEj0QWgi0YI2EZP5KXthKiSAx47k9DNWh0/wM03ckJYoBxjLYbIctXBLkeKN91eLA==
X-Received: by 2002:a17:903:1c7:b0:1f7:2576:7fbe with SMTP id d9443c01a7336-1fa09e8a5e7mr177124265ad.5.1719526270012;
        Thu, 27 Jun 2024 15:11:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156957fsm2513215ad.228.2024.06.27.15.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:11:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: yukuai1@huaweicloud.com, hch@lst.de
In-Reply-To: <20240618164042.343777-1-gulam.mohamed@oracle.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-Id: <171952626823.874041.3335958762310133859.b4-ty@kernel.dk>
Date: Thu, 27 Jun 2024 16:11:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 18 Jun 2024 16:40:42 +0000, Gulam Mohamed wrote:
> 1. Userspace sends the command "losetup -d" which uses the open() call
>    to open the device
> 2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
>    function loop_clr_fd()
> 3. If LOOP_CLR_FD is the first command received at the time, then the
>    AUTOCLEAR flag is not set and deletion of the
>    loop device proceeds ahead and scans the partitions (drop/add
>    partitions)
> 
> [...]

Applied, thanks!

[1/1] loop: Fix a race between loop detach and loop open
      commit: 18048c1af7836b8e31739d9eaefebc2bf76261f7

Best regards,
-- 
Jens Axboe





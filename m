Return-Path: <linux-kernel+bounces-566741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C1A67BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C42B176E83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B281DE2C8;
	Tue, 18 Mar 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rzaXjIVc"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE3183098
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322748; cv=none; b=fncyevfMjEr3BIBfORhSnynMcP9wzx/UliGJxCuzj38jp0G29VH0nOTY8qk6oBw0XncM4VQNWcMBR3SDXfVzUnSlWsMCpGew7zZTbqe44Rbv/QpfNXTIQxwi7EZiF3Yf1hCwNtvGXWRA1xZLYA7MvzRwbCbtw9iogCCvXPuLieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322748; c=relaxed/simple;
	bh=qrv+DU81gmi1ENITv/uf+Y+QCljkGvrsvRaZ1EA/ctg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sQUGVvKW4AfW0lAfVsFwpRuk27KgMn+J3ATQNCrnmp25LUA+NqAy9zImHDtggAj/yBjiTZL+hdqSq7Es609PBxeas4udl3POclzcI5EtCjsLX+H7ayn0vVwDJie7fTfpjaVAgJd0PJ8ZrjbyG2bJEMd9PxitkDpJaQktkJ6+ldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rzaXjIVc; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so69966265ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742322745; x=1742927545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn8c/8xY9hsur5GaIQZhhu6nfpmRkGa6zZ/5hcfFcwg=;
        b=rzaXjIVcQHYIjeJ3Xdgtk1GmciRjSBQ39CYSKJoazF5y19GOwh5x8hzUgCUKwc3wNz
         3tk666LGtdCTmIULCw6wuLliIJw9T6sWNc6uj3kFjohjvhTjLz1TI66V1BnNeLu6xwtc
         p6vXU8PVkUV1YV+C2JoUb/mpDixF/CaJgkWpTGXbspsRtxu2OclllK1TWWNxQdQbk9SM
         xUIrBEKNXqnYvxyxAneYdvucWbmkxP63w/aJUS3nQwz9O/UGPzmD9h2TMtezHmTw815K
         UUORKyNiWThlfskW/AK0SoY8YMyf48cFMjMFw8JvHTbMGwAamuZUpXacbn5NHGZ+rOn6
         XM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322745; x=1742927545;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn8c/8xY9hsur5GaIQZhhu6nfpmRkGa6zZ/5hcfFcwg=;
        b=HGSLgepvHaw70ZCTJ0RvD61uBck2rpGdp5Rhr3yUz0+8bvF2Iiq8jSMh7qglaTqSWg
         QH3Ld7I1NmnhE0SPp1GSHBcBqUUcFJImyHRzkEVq+EmRlnpSGipbN2clDwD/GllRH6dr
         2AkfGUNCinp3hirSbsHtVBF1000NVxDUDz6UGEeZbr5KVCK5Om1PG0yrVsST8Bj0GNCj
         iWDp+swGfQ8qLjiYhrIW4MD2IB0oUntjPTIOpJXVR5eGor/95nQSl0ps5DlNF8hvs70P
         OFT6FRGeWK6yhXzeL9zjZ+Icl1vn3t36fqQoB5AJ6e7Zf+1FJbtJexnIU0BuXjfclPXu
         7k4A==
X-Forwarded-Encrypted: i=1; AJvYcCV08Zg12WouE140+GU/EX5xVbsybzlmAzUJzKXtvRVaOF+ruTlDgU75hTSfRD1SIA431iibLd8KJRZS0cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqaHBYm+DsFXuhSYtsJ5BljsVXHft7ytTrtfr1fmQpsA1F4GN9
	ugu9KJkbvz0tTF3Ivw27LQOU0fvcCyMU8xTdFl8BW4TJ+zgRopUhXj8Bc2jhwiw=
X-Gm-Gg: ASbGnct09EpJM8hyhsvHxoshSW5br313frv3G1X9fgz5/HI6KwIT88C90lbmCq5Caxk
	Kn7cyooixwfPtKOdHibF51Yj7/jyirMEBBFTFK1ScoTMrKLtfOfdHpVdpXyA6OqPBiW0KXUZNmr
	12vWUZ/HrnzwAP+LkXIfADQ3HonGrSmUGlwZgc3cO4C9QKgSFL7Cjuvws+9qZYPI/ewwGY0o4wu
	4Wilz+p2aeeqcHE9J5WfGtqiYmwQrih43WmkoYysPNBOU5Ik/Lea5NLzIPzbf8LeyUnLbFZXAew
	wDWwlCgIvfw5hBST4L3cCtUc7gF/uDyAGoPJ
X-Google-Smtp-Source: AGHT+IHgYCKrD3peKrbdSEm1B+JO8dbCq7dov1VEXaRpVsSj3E7NIaJGpVqJEmXprxOB8OJUpmk3kQ==
X-Received: by 2002:a05:6e02:1d8e:b0:3cf:bb6e:3065 with SMTP id e9e14a558f8ab-3d48397f585mr168752655ab.0.1742322745570;
        Tue, 18 Mar 2025 11:32:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a67e5besm33337665ab.31.2025.03.18.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:32:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
References: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration
 error handling
Message-Id: <174232274456.158569.739528900664075776.b4-ty@kernel.dk>
Date: Tue, 18 Mar 2025 12:32:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 17 Mar 2025 10:29:24 +0800, Chen Linxuan wrote:
> This patch improve the returned error code of blkcg_policy_register().
> 
> 1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
>    function pairs to the start of blkcg_policy_register(). This ensures
>    we immediately return -EINVAL if the function pairs are not correctly
>    provided, rather than returning -ENOSPC after locking and unlocking
>    mutexes unnecessarily.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: improve policy registration error handling
      commit: e1a0202c6bfda24002a3ae2115154fa90104c649

Best regards,
-- 
Jens Axboe





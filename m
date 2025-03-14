Return-Path: <linux-kernel+bounces-561777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFDA61601
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A63A7AA8C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86F202F88;
	Fri, 14 Mar 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w3XewBDe"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1065B201249
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968740; cv=none; b=cgWnGiK4YE+dj6CMgkS8QYro5rD7KgiPcA3090OkhWXepwUbco7kZpMNUb1K9qCz5rMn52cM9MdcSsxeI9ahyL/PayKkqbih9Fy3Spdl0j2LlhWZU4Vu0O1G3qk0EnAVHGayHnqT3yqlj1Igpt/4BruHi7WT7wSdqjTEPzOi8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968740; c=relaxed/simple;
	bh=GNGZmwPcddODPXkCRrFCIKz5PWUUxPy0cQCbahA2sYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=todY4ah7XGtTEI/K3R/XLKzLupwRCbFgOnI4aLFAUg9Icv2yWqTwGwDO1Zw3cPHZzNY46YRWP+71Nwm6odkxc163R47g/zAItcnDaywF21RA4igbZmknFFYrzvKV6yskAvTdzGAFLZDicF+oZGr7LXPUiTIq4ouDYTrevXWPhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w3XewBDe; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85db7a3da71so183600139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741968737; x=1742573537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xMzfs0jYY4csV89MSJ/OMaI03krp0RNdkDetjqic1GU=;
        b=w3XewBDeB68wgyWgCFJb1GtUxcXtSKvq8j23gYLzuMIPkhOmCqPnwp6C05k/iO2ZV2
         8FIPThD3Tl2S3Slo22fxw+V2H//xbisnZYVRtYRvEvbu5mXvYpkSSHgV2UT84oG3Dvba
         qKzRUJFwxDY7uSHdP7uSQaNzscaA8h5bMlFR/5BX5XaSIWLXJoV2GpvMMoHezkmOOveR
         gPjS11r6YlPG9Af5YcJwesMOLkQC8PbqBnP9fahTBF969Zj61//F3IQFZsIeGaITV9GT
         6WzMA4rVryLvMOhZSBddhKoMnrN8TKYpfIcZS+xbOoDrQ1TRFVCFequSPzlfs6Y/WffA
         hogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968737; x=1742573537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMzfs0jYY4csV89MSJ/OMaI03krp0RNdkDetjqic1GU=;
        b=jhUUZ8MLqu4QydoVgZiwad8FwlDOBoAHpGVtTZKbh0xYppLqAoeoNH84kT7Wb1wpOP
         kGyj0ZrpSgfyImPJXQ2oJeq8W57hlRzePhhZZDe0Mn3FyBBT4OmijozqyzSnM3Kvfcjh
         5MboaqS7WReoaV7K3PEsR22LtUCMomJ5kHtvwI7U6oYpHZTUEnqRaaQgvUV4KjEQVTLk
         zX9V8rqnS5k6Er6qHNMoJ3eX1NrRIRhOr9VK8DcjZEpGLpYCGbtDja3TEebzFtK288rF
         cFRvaGzO94gJ1GJs0SQb6t6QNZsvSAHTdr2uicl5ORz5n9SZ3nKKZsfgnPTdwAmQB52Q
         4+KA==
X-Forwarded-Encrypted: i=1; AJvYcCUZjYZMfJ/JzEVfrkWIZx0I5Q3j9f3PumVrUhb62eRaY4eA6OjLuGoZXK9AD59+6XkynopnokqkewOLhqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6v1akdxncQUyAc5OsQRXQBVnHpY3LjuPHleQZQSod5yxUOq3d
	qFmi3Iwb7o+8wEOmVbpzZ9q3nPlrVT5QC765DBQoj1sZXC4o3iFJwhJq+UfC0Tk=
X-Gm-Gg: ASbGncsnnWrB2DUwyAI9qKQgFm7BHXyy6rdQmpfzhEizwdTh+kDZaNLQZlFckjUa9QY
	OJ/zhj9peq2q1QwfbdfB/6D0F0vX2pEibYDv2jIe5zWc6WsS4YdJpkm2PHqzMxQN1LJH3UoDakS
	DQAtPqAtd52KJh8xm1/8yeAvDlyib3RNOACnID9NSk1EcOXkhuk0/479J/7z2S4lgvfPFQVYPQQ
	yuDZESmHetFPHqOW14+cjJxPzX5ULDpdJBcOtKuLJRJ3edxnJ3s7vTMrHNnHlZiaPj2WW7se31l
	Qjq1ioUWVC6qsvjpVoG1LCl3fiGV7p6tOhkj0pA5TA==
X-Google-Smtp-Source: AGHT+IEFSlMNNqYd6DH3/lMsOtUEO9WQr4nhtNK3zx0waU/c/6VX6Gx9mcQQA04Ym+gA7eGRqL+pHA==
X-Received: by 2002:a05:6602:3788:b0:85b:3b30:9aa6 with SMTP id ca18e2360f4ac-85dc4788b31mr284923939f.2.1741968737009;
        Fri, 14 Mar 2025 09:12:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f26362f34fsm921344173.0.2025.03.14.09.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 09:12:16 -0700 (PDT)
Message-ID: <7280eaea-db6a-4431-92d8-0aa5fe66768c@kernel.dk>
Date: Fri, 14 Mar 2025 10:12:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in bioset_exit
To: syzbot <syzbot+4b6dfa650582fe3f8827@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67d45312.050a0220.14e108.0046.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67d45312.050a0220.14e108.0046.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz set subsystems: bcachefs

-- 
Jens Axboe



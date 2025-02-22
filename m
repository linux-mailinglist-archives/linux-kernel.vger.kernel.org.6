Return-Path: <linux-kernel+bounces-526932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C320AA40545
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FA019E039B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF01EA7C1;
	Sat, 22 Feb 2025 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFF6v7+A"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA17E765
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740194437; cv=none; b=m9rpfV4tqBhyYY/vcab67pIP0Hs43LIc8uWt5OVytrp2rx9w6ktDZplHzvSzvS27mAkrEmP9/+On/vFGPy2DMnsdZhWPX57m3NEQ+Vwg2Q1Fa0tJIVb0g4q+vnx7ckOp9pQvjIaqavx+nBqpfrSWnmj5mqYdSrpVAakd+6ZfFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740194437; c=relaxed/simple;
	bh=8PxINupFkXLQzH9KQ4YNnlllIZhtJ4r/402cEm/Jfuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTVe7cgcAOJxh4fzlcV6U06wjxhbXCXo6jx0VgsFNrRvnbgN2Uhg0FY/aWBVhmsPdUPRTHIL4lln96s2/+LQUIgj8D0cfZmie+NsKZw784RsNpMqCXq4d7SafS0aWX3ucOyhUYFibsvwGQzZKpargdGsTypLVUO/GmhzEQ9aFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFF6v7+A; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso5597431a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740194435; x=1740799235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u1P0vtgbpIVz3dLfer3gUHcSU9SobBAe0V92OSJW+M=;
        b=BFF6v7+AHVcSeGbB/OtzJUFoMyjbPC27HZUt5yZoPWn3z/m+qlqJz76bn84ip57TR5
         /ZY/IMYyHsz6gCsSQ3rshnXr8+ZRqWpvqLjtXbD2xJiNzFxLKPGNnnr/Htjsi6BVwFe/
         p/7cdzuin3PUxS5GzDVWsHl2mVeiP51GMfbiNnJ2n/1CvOABRKW9v9O9N8+GwRRQjZV8
         8bp/lIoOWiYmJc+p7+9jBncgMwLi6HzKq/HtrqJGeTQhhzPLtctKJqcGmkG9w8GU8L8g
         jhGWZeehlM/EA8v/QmLiujXyDiI1ZcAj3Xp5pSw2SRueKecAaSrlAGrgL6WmtMIss4E2
         1mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740194435; x=1740799235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u1P0vtgbpIVz3dLfer3gUHcSU9SobBAe0V92OSJW+M=;
        b=pHQtCTWI4PCrkEHLLs6xB9ZmVsGwvaL0Ybm9+pCITjDUw3BOrLuRd7sPvuu8JN20j/
         QVSZ7wTbHdqxKMQCAp2KfoS2INO0eI2Agw/+o8HXZnnHPnqP0lg0lLqn5vne29j1CMSV
         sEPmmUZZBaBJl5rNG97wK2iIGyWEUUzn3bm1DTNeAqGhZQxpR5QVnQthfUCM1hc6QI7n
         6RnIAK29lrSl5bOqUni69wVBrP2QcHZ/JWNHp/uCjMXuXCwjN8zy6efQNBwpiPBRgEuN
         RF84pinj8cuKGdiVYXP56OhjCv7SdK+vmr3k5ItRmkpRUhy+KqKpqQBWHfc9a7i9G3Ba
         +6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkR6rz01IzBw5tRjqPe44ee5lo0zkDp/F3hJIPYB12kwl2cNTCJbVMQoNRXc+Wry48R+chvTV8HtNU/Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuLghGh43+lXp75u6fOv96r/LPOeo/bciHh3W9Ebly2741tzz
	DKfI6LNZviVs75/wU39u/VtS12N8SaH4mG77LMG8TaETyPRrGIBA
X-Gm-Gg: ASbGnct2SggnZCJG0PQeTziBZnQtDsintcO9PS19COcEsD3zG9L8UDlLFEGzi89K7Zh
	aCk/wrjbeN+7hSSDNufqb11UBcyJ829vtV7pAJKMidcp4I3WMWXMmYHQ6/TMDnvXb6+3jkXCX/4
	3axscrPApJKVK1hnNGvqXZ0EpV6L1oIMbUQwaKykYsILG69I35zkqy6VWt6UMnZRtxYT58oIUss
	gsMYe0XX77K1vk+/5Vz77/6awYX8u4vnCRmoVij/j1Be9BGrXHIhLa18j6jZ+BcOFEo0dBz496A
	De3lp9N11rwJLT2JMVVVqH0ZCdy7E4EocBG8dK9cfIxoF3I55e4w9zc=
X-Google-Smtp-Source: AGHT+IE/CRf3uhTQuGbhoi15zplnNKI7HnC9iDTMtXe2Wsuv8NtZvruo9BnyAXbYTtAaiiO5tmvxQA==
X-Received: by 2002:a17:90b:548f:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-2fce86adf6cmr9576269a91.9.1740194435570;
        Fri, 21 Feb 2025 19:20:35 -0800 (PST)
Received: from localhost.localdomain ([2408:80e0:41fc:0:fe2d:0:2:6253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5585708sm144568895ad.217.2025.02.21.19.20.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 19:20:35 -0800 (PST)
From: zihan zhou <15645113830zzh@gmail.com>
To: qyousef@layalina.io
Cc: 15645113830zzh@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks getting an extra tick
Date: Sat, 22 Feb 2025 11:19:46 +0800
Message-Id: <20250222031945.67519-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250210230500.53mybtyvzhdagot5@airbuntu>
References: <20250210230500.53mybtyvzhdagot5@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Yes. The minimum bar of modern hardware is higher now. And generally IMHO this
> value depends on workload. NR_CPUs can make an overloaded case harder, but it
> really wouldn't take much to saturate 8 CPUs compared to 2 CPUs. And from
> experience the larger the machine the larger the workload, so the worst case
> scenario of having to slice won't be in practice too much different. Especially
> many programmers look at NR_CPUs and spawn as many threads..
> 
> Besides with EAS we force packing, so we artificially force contention to save
> power.
> 
> Dynamically depending on rq->hr_nr_runnable looks attractive but I think this
> is a recipe for more confusion. We sort of had this with sched_period, the new
> fixed model is better IMHO.

Hi, It seems that I have been thinking less about things. I have been re
reading these emails recently. Can you give me the LPC links for these
discussions? I want to relearn this part seriously, such as why we don't
dynamically adjust the slice.

Thanks!


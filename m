Return-Path: <linux-kernel+bounces-257436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB83937A01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB741C21935
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591DA145A18;
	Fri, 19 Jul 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vb1ByTTP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E7714535B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403549; cv=none; b=P8F6y3zc0K//g+DYc63xo8iviRmtwb/AeemCG1cVtRZ/PXs9DIGWG/I6pptQWnJxgnjquzwxxYjndA42vs4ov3Czne3l+o2n0W4QDpLqz3ShjNS9dDkTCFw8QXFm/3jdWWwSOs9DNvCY1LkImJv0Z2eolykr+cPKyu6n5Cd8xI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403549; c=relaxed/simple;
	bh=F+8BO+nL9tUeStijZ7/zk/oJIQiMAzjjqxNdJwAMyPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J49g7blaDAvBYGigxXLT9RgvZk3+SzB4XVOK0c6jHgeWhOSpix12nZi32MAtTsGDWxKn+qe0nLqcbWHDqg1bjZTVWT/PmAPaSlFM2rrS8ZbgWAsGvISyD253VkZRStR9cu5bHM8ljeW4192wbfxQuaw42vNmNOPx1y2SEK/Nv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vb1ByTTP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3460b416so2620265ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403546; x=1722008346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y45Z0aWbIeprdMq8sDDAIFPdliCDk9r0AJWqhvLPYw=;
        b=vb1ByTTPLxKjHfH8XpgmL11fKEqFYvkc127ugyWhdLdK0VPruuRsvPvtBV09QpkweU
         cqEJaSWBnQQjvkQetqHTAB7tf4jYtI0lA3IjWkq+bCuVFYYzS3GRxKMmIeHHDqqJ35km
         nV4y++FZFo58B043HWPkOnSDso2TKPZYExicmEx18Lrl09uhLA5S1ngnwqD4FmDzuAgp
         KlifUS9miesxVMawuGAShzgszHZcAIKC1GPYyzdYEwTO5PXTRxZWOEs1cfX+k7kWuktl
         NF7qrzR2sEifkgXaO8AcyazPZ1S0J0XHArp7VPdrO5yrs5tSoYYPa4RFGySegRpQ7iqs
         cmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403546; x=1722008346;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y45Z0aWbIeprdMq8sDDAIFPdliCDk9r0AJWqhvLPYw=;
        b=Bm90OSqDUFYSqFnlbH7Fvzbk5qQ4bgzsYIlUUs0+fFhnNtQ7AxVotp1mJ00Ggzg1hC
         byFZEBr/ZocaWDuKeP7uzzRvmVnVUIEAMuTD96ZUTVc5C7+ih9acI0gjjOyKXkVj1+EY
         ZyWwC7hbpkJOn3+M+qumG6UScXBsc5jk2Y2P8ynHgolElbizDkuWGWp5PxRv/s1XoM0d
         5qr+qq+jdgFGkAuz9F70PhejODuecv00bNwSTOvv6P0vtKlX/8hUwl46LpB/HVR009LW
         Z/m3+WIjZRWQ4RtdBp/0dCvnXFo+TEpZ+RrnPWKsdCuCaIt76CvAcokd2pGX7DDubsFw
         2Pcw==
X-Forwarded-Encrypted: i=1; AJvYcCUlaWxCHBKyNW7klYolH3gyem/v6UdXZfPPJ2//Wv+JUDBCWbHis6eIHHFHemV6aBKBIsAMlN3uM+EPxbuq+13yo/kavQqnSetPvuIF
X-Gm-Message-State: AOJu0YyBrE1O7BKOYlmEmXZ5DzrBYSpeS2K+j+Lh7US5vw6vYgGs50OK
	K7F1AqcE1NsAQ9zEA8yTfYNCJnBViZNnXEv3x9BHr6s4nE+6rO4szFxWHpGqKZMmSAM2YFrJ1im
	xUqM=
X-Google-Smtp-Source: AGHT+IEjRqRmzclUos+dFxnPhen++ZHfL43eH/uNmW18o7F1OMwvwdKgrvgILJUX7PonpmivtolN8g==
X-Received: by 2002:a05:6a21:6e4b:b0:1c3:b106:d293 with SMTP id adf61e73a8af0-1c42287e800mr274401637.3.1721403545947;
        Fri, 19 Jul 2024 08:39:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77353847sm2969930a91.33.2024.07.19.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:39:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hexue <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240718070817.1031494-1-xue01.he@samsung.com>
References: <CGME20240718070823epcas5p14445a1ab8f8bf8a496405a1424ea067f@epcas5p1.samsung.com>
 <20240718070817.1031494-1-xue01.he@samsung.com>
Subject: Re: [PATCH v3] block: Avoid polling configuration errors
Message-Id: <172140354394.11595.16629364160282327340.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:39:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 18 Jul 2024 15:08:17 +0800, hexue wrote:
> This patch add a poll queue check, aims to help users to use poll tolls
> accurately.
> 
> If users do polled IO but device doesn't have poll queues, they will get
> wrong perfromance data and waste CPU resources. So here adding a poll queue
> check, if users do this misconfiguration, it will return users that device
> does not support this operation, to help users adjust their configuration
> promptly.
> --
> changes from v2:
> - move check into block layer
> - return -EOPNOTSUPP instead of print a warning in io_uring
> v2: https://lore.kernel.org/io-uring/20240711082430.609597-1-xue01.he@samsung.com/T/#u
> 
> [...]

Applied, thanks!

[1/1] block: Avoid polling configuration errors
      commit: 73e59d3eeca4feaf0814a077df8ec5edc53ccf77

Best regards,
-- 
Jens Axboe





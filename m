Return-Path: <linux-kernel+bounces-351416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C6C9910AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A641F220A2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824B231CAF;
	Fri,  4 Oct 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs2Q5TEe"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12324231CA4
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074106; cv=none; b=G721m9cqsqRUfFhKBjFz6J3w7+csVMaCv0cON2L2u6/GndlA5NpdoRnUzHzCBE9eCx9Prz9uxypMAWRfUDxL89Nts7jAvoRFejD0z+zGmeg2xnjKUaFP3CPjhzzzYseFWhZbDjfwIerO4z1vGKM1PRDvK35GF68n2jyumtynmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074106; c=relaxed/simple;
	bh=fQxqxvm/Y3nJCqrch8NSDiUYSIuSQW6jkRjUoBJgk8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqf9RHj8wUZNLIkJPZ42SkFZMZ0v0b58xGy8oRdyKI+N4h1DVNW6n+TmSrGwvvOYzThsrSyMkyGQD27smBMTMrvtLpn3mPhQ5Q51ZJCWjJiNgaBnRMOnK1qTCvqS7Nfs2b/+AVzyRcMTvg/B3jo/bxKHn/jRpDCsMPQb5/3VjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs2Q5TEe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so2169431a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 13:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728074104; x=1728678904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrWCNsFUUmGIJDuvVTawBv5vSfC+UCfzRdwYzWDV0lY=;
        b=Hs2Q5TEevwEgUTrI1T0Ko+hiTd4JOx7lJaHL8jfmjd0dnmSNVauh0RuNUuHtOBYE+8
         +R7o3TBGGgD5nrpC8jnSAc4cPG7r01Nud/cBkTYAJs3+ZyAxRei9mMHc5P/m8K44Wgwu
         A5UyducY9Db2IMQN7Q0hp9WDBejPpRlIiE2fvdQRVyW4NGzRwNunDq53sBMF51xPlZZG
         yW/LM2w2DveOcZ7jzpirHhEMtJwja7mKe3nn6TTYrZGi6Yb9exAGu3mSKFykDYlaWDe7
         319shxim+F4NKAZIZWRNcbiTd3B2GWnzABbr+fPlFmTm7VI0rW9QTETHYpab1RJ0/1K4
         DOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728074104; x=1728678904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrWCNsFUUmGIJDuvVTawBv5vSfC+UCfzRdwYzWDV0lY=;
        b=hxsuL5NdVhTWJ9lG+91WKf+GuWLhqwhdMBvLTd4OcectbFwhrCcwOtNa570Dqapw+l
         jG/1OKr5c01gI+YMuK2TTviIg3q9Qw7BcMw1YVl2lPWMm8WiNqWkaE6SDJUMpu+Fe77I
         wIIG3lru5XyEg1X0IhSJ6J+kfy2heVai6lnrRtWV/8buFfHcqZ4P6M+iSTbcvbc1J1WH
         PukCbGrql77ydwpLgErYpX4FCYXX9VQwieSb3sEv9ByGLEzt9hl+lQI9FQRIvFDY24Wy
         Gi/YYn+rA3L+xaH061b3CKuGfNVrYt7TBbG+n6oQ+jan9dH/z+x9WV6TU9SaFjo+SQ/o
         Os5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+8uRU+bZzcYU9BOatmyuLNDfsah9zIWv7kLyS3rtIX96OX3YkMeHYGbaiJp1PtCQrpUccRCm6T/rlyhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5MD4lVByO0PtTGaQh7QlCOATeM6IfHgY5R6/9yCops3wmP/S
	CaiVASXJuQ3SLtVkBvz+s6tSWmGaBxyNg3L+7FjqM4E5g3rv3ge2
X-Google-Smtp-Source: AGHT+IHfQ/2pwTboCEbbzVBeENgHAF5cgqBAe0g8mWK53+4y8p9SRKDHYfw+tbGY/s2nEoLk4myELw==
X-Received: by 2002:a17:90b:b0c:b0:2e0:99bc:6907 with SMTP id 98e67ed59e1d1-2e1e6229e93mr4694510a91.15.1728074104233;
        Fri, 04 Oct 2024 13:35:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:ca9d:8e63:76a3:a5ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20ae696aasm370905a91.1.2024.10.04.13.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 13:35:03 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: dan.carpenter@linaro.org
Cc: deanahn@gctsemi.com,
	gregkh@linuxfoundation.org,
	jonathankim@gctsemi.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: gdm724x: fix returning -1 with return equivalent errors
Date: Fri,  4 Oct 2024 17:34:58 -0300
Message-Id: <20241004203458.6497-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <47723ac6-9131-49f2-8746-1bc8845187cf@stanley.mountain>
References: <47723ac6-9131-49f2-8746-1bc8845187cf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, Tks for the response and suggestion, Dan.

> Most likely Greg will keep merging patches until the driver is removed.  It's
> up to you to decide if it's worth your time to keeps sending the patches.

That's fine, I'll submit a v2 soon.
Tks and regards.


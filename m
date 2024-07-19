Return-Path: <linux-kernel+bounces-257702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86B937DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB57B21146
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA01614885C;
	Fri, 19 Jul 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhR5aFi5"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C51474DA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427147; cv=none; b=LVCnQ++rF+hXmV0F7ISmdIhe2umcwlMwSik+I4n1TjcNQug6g7goSYSDdh7jCEzMZLsMhxogZf/jowMG0NJUN0OOJnkPnaTJIzibTcfZ3KqP/4f8W9AuIXqcrBHK9NnLVr/9b+tZKeWIc1hu+ntcHod8KsnirwwwYCwtOwOTsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427147; c=relaxed/simple;
	bh=y5sMk/zS+lIMJ7zbR6jRJyQybPNgrIopmjWz2/cBtw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJqomxSVUUvAM5Jn/7QZRimbv71FUHvpnZaT3tzTB6Pf1uGTPhUT2V+phspgTV4L47nymYiL8mZ0pN9EKuR+UFxKKJaALHfAc8xgYY3fSeHEzcZadNXwHyQjVNxqBMEcvyekcKv2FZ7xmWLVZucmM6PMUV03vdIEtZUe43DY5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhR5aFi5; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9306100b5so1376364b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721427144; x=1722031944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsrUvHcOlO3Dh/9IpJULPkmqkCFzS/qDzWwDyW1IZW0=;
        b=NhR5aFi5PNoaEylUUhr5IcJvPZY2k2LRnAx+BBMm1Yf65FxZo4mhNT/hMm6ebomAqy
         kBFPfUZvSYwJD+JAtsM4jSg7SJfpLqUZhH0WZTNutE6ddq0BdMzvqGQKamx+QHmLE3nV
         gJxiQWdtUnYc1ar74crXPqGWmN62NRQ8JGNyFmWx+M0NcD28s+bnABn1upLRM4mBzu3q
         NtkH2qhmA+fQAzbWhsfR6X5RqLgohg7b8U0YRj2ypSaKF3UH1UlOofyq6U43QY5AZbdh
         Tqc3vuEeVNBGnxhpwPzznHa3Owak2k8yjszpr2lw5wrpI7QRY08mmEavL9dhtBVZ7Vbx
         x5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721427144; x=1722031944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsrUvHcOlO3Dh/9IpJULPkmqkCFzS/qDzWwDyW1IZW0=;
        b=Xkux9XxG0wB52SXJyQs5hUF16JhYhZnzxOpIzO922u9q22Bckqsxy0vMh9rw7EyDp4
         tYGqw3n6L1LAHR2dsIXyM8XQp1VGyjtojCqesLRgFfiZDjxpv5eDcQ+jpENKg7QeU3PK
         vAyx67JhIyIy8412pLYGU3NcysX41GeG96/I3GLsWVXKiV55c4yqv50TMgbOXA2GSopf
         12BPRW9YGpvjd4CQA/macn/9w/5kejjgSJG8lVihSFZJdpP6tyRhsG9JPO7CI8FxJv/9
         GI/tEZt91RViBnOfeLXFlZMIUnK3As54IMtalvuSni8+xY/kwb/jzjmfLKjbDwHvPhqt
         Z+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU4aqvZ78FYMNQN0v4Fd6F0KAk9KVHkT6iOkGQ8O69CnTBxsE3TMry0bHa1rrhXaQYeA3qqlbv252Kor4DjOZ7XumQoZMY2N9/huwR0
X-Gm-Message-State: AOJu0Yz5ruyfaln7Hd3muEbxkqVhfBBkYeYXt8di361d2GmunNP/6+is
	7GfDVb0hFmhWAKG9M6ATkTWAL5zDSKst6efe5aUUtyojU5baDQB3rMyJRK78TcU=
X-Google-Smtp-Source: AGHT+IEACCDFljlhCVx3UC2edV2r9uCk21B/qGgoe+9pg6yRmzgbSu4fDEallSijIg8HH3qfpPW/CA==
X-Received: by 2002:a05:6808:219d:b0:3d9:2d80:2e11 with SMTP id 5614622812f47-3dae5ff9f4amr1420022b6e.40.1721427143793;
        Fri, 19 Jul 2024 15:12:23 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:4528:a9e:1eaf:80c5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60da0b3sm489970a34.42.2024.07.19.15.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:12:23 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:12:21 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Davis <goldside000@outlook.com>
Cc: gregkh@linuxfoundation.org, christian.gromm@microchip.com,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Made the error messages a tad easier to read
Message-ID: <94189c64-a8ba-48b0-972c-a9bcc378aec6@suswa.mountain>
References: <SJ2P223MB1026BF236AA81666C823E947F7AD2@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2P223MB1026BF236AA81666C823E947F7AD2@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>

On Fri, Jul 19, 2024 at 05:19:36PM -0400, Steven Davis wrote:
> Signed-off-by: Steven Davis <goldside000@outlook.com>

You need a patch prefix in you subject.  You need a commit message.
To be honest, it took me forever to notice that you changed the lower
case c to upper case.  That's the kind of thing you could mention in
the commit message.

regards,
dan carpenter



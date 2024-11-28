Return-Path: <linux-kernel+bounces-424985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA39DBC19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999D8281F39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E51B85DF;
	Thu, 28 Nov 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EEFjzt/3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5613B58E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732817900; cv=none; b=RfR/jPAnvVUmPxbxaQhuSPTpEd7gtspCuvhillIHwMM4ECI/qce+60k4AA0d+0XOQIInNpHbZNkmhvZUytzkuAt1EpfruZy/wqyNcGIg7xwo4w30wgTMQwmaPVLuam2CWGhdKKCS4M+CrwRmt6SQw3IdD5B7ii7NEO0iHQjez80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732817900; c=relaxed/simple;
	bh=PvLQicWhQLqcii2/+LeRW0W4katNa2QM/tAe64jJLA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLC4yNDG3JeE15xIM3qe0UizX+m1mfBStIWUiqkgOqqnFgP9yYkXnk2zvY5lngL1YnqH+mj44OvtsEMhgesgc4ECbR8cgo65mSgCaCR0/bly6TSU/I7ZyFaJQ8sdg6Fnb0OFmgbLbTxYDt4lU+qvZOc/Tyu5NaYSRIMH/OwXGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EEFjzt/3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfa9979cd1so1193653a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732817896; x=1733422696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OWYPygSA8U0sevMCRXoVQRbK8c6ufmDSCTRB6zqB+ts=;
        b=EEFjzt/3lH9oQSmIqRqM9jV2KdMZChJVxizoEoBJMwMB1Rj8mDe4w6Ezk4S02ngtDk
         l0wGNzUQ8BYbVNwnTG5EwNRThiYdLhL3IMUUrv+g5ISrxMULljSnUWzyY/vqOTmaDGBJ
         kWIDLkbJaaXH82Nyco8q1cvZrqIBOqc1roPgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732817896; x=1733422696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWYPygSA8U0sevMCRXoVQRbK8c6ufmDSCTRB6zqB+ts=;
        b=FyN/3kyPjiaV8wHcHzOCK4jzY+m63+lj1GkL7JtzRm8SG57J0BdTdZ+TxCbfsb8yi4
         rv15zCBD66qfeF7EApKoR7R+bLqBkxnmLTe8dipRIuUkPewjJshb7V166H4Bcaycl7wS
         OvHxxfo4ABn9NiDz2kr8oM8caU5TccAK4/kv+R9J/aasfb7OlZqnaDWDUHymt/zVeIMr
         qWFIJ1LJkT1W8oUxbsxu46FlAfm/axmb0aIXm3FmbOXZ9H0o4QBfE81iB8saGkuenUq1
         xnHNMGcLQYzKby7w8niIwjMu6ySZANCjvCpqxs9yz5t9vyhTqwtJbbodVBlMxIgtzI4o
         VPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO5sWahCGVE/yYLEh3vnIU+hhMhPVpvhB0U5Y+XvHl9ioCtUwIzJ3/FVu+fDNlefJVlaKl+oJQ9M8jghM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpRHvgEE0KXM7pQONFsXBrQ84kEDQh6pQZru2duVgOCK0S77Q
	8mfVMJwrx1byh9qzZmxX6f8V9pjZfpHBengjFL4rqJU153be13bF8lpDN700fpXb9Vv8YYBU5hN
	lwQpwjQ==
X-Gm-Gg: ASbGncvSGtSDSg8IGqtA433yoVfSEc+B1FKtH1LZDc/k67JRUths6GMgpKGeE1n7YFm
	5/3JVbcYVVOnWTi1uo4+b7Oe/lCR9gJgkKlE5Wvght3tkEn8WRAyyVMN24y98cR3xjRapiFvZpv
	GCmmXVW30R1r9f3xSucXkvdNSXmXKdM7AvtRfYWNnRO2bGAL/O58wC3KN/7UZG2+0txpHHnu1OU
	OLb4Y24mcHlnOoE6B3RJ5574MSpJZEAVU7b8OE4Ll1ukW1VwtWpnwpoEc0U0JyqhtxPXUUYahmQ
	fOR2/tNvtLEYVkoeT3cbsHh8
X-Google-Smtp-Source: AGHT+IHPhapJM9mpqd3H06+P8hMQ11Uwe9T+PeBhxPS4loJbjMT1UqzwMM0Yqfmufe5Dooj5LcmvuA==
X-Received: by 2002:a05:6402:2348:b0:5d0:9ac3:deba with SMTP id 4fb4d7f45d1cf-5d09ac3e0d1mr2816479a12.16.1732817896637;
        Thu, 28 Nov 2024 10:18:16 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8e25dsm962477a12.62.2024.11.28.10.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 10:18:15 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa55171d73cso400971266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:18:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6njxI50R77P+1l1BDnXtmO9bwAC+8bNTDLymehU/GBAwPnahXbR+aM3THYQmXr+14Z69rxmIokx/qPvo=@vger.kernel.org
X-Received: by 2002:a17:907:7615:b0:aa5:358c:73af with SMTP id
 a640c23a62f3a-aa5945075fdmr511317466b.6.1732817895101; Thu, 28 Nov 2024
 10:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128172801.157135-1-pabeni@redhat.com>
In-Reply-To: <20241128172801.157135-1-pabeni@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Nov 2024 10:17:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whuZtQD15GO6ZoU3X-V8Wq5tPm01NhpojspaMTefM5fsQ@mail.gmail.com>
Message-ID: <CAHk-=whuZtQD15GO6ZoU3X-V8Wq5tPm01NhpojspaMTefM5fsQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.13-rc1 - attempt II
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 09:28, Paolo Abeni <pabeni@redhat.com> wrote:
>
> The only difference WRT the first attempt is the fixup for the build
> issue reported by Sasha. I'm very sorry for the additional noise.

No problem, this got fixed really quickly and is much better than
finding the noise later. So I'd call this a success, nothing to be
sorry about,

              Linus


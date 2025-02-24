Return-Path: <linux-kernel+bounces-529912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010CA42C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0941892F05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2ED1EDA10;
	Mon, 24 Feb 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m6yxRP+P"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63DB674
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424316; cv=none; b=LG4HF+jatQSAeV46Zm3crhbAujp/9lcRNL9aXm5eZd69dt+/K6ujARoTk7ZFwRUcYX71xjhT2jT1AhQ957OZfWMEM1hooxnxVKeV0+qGT6WVRQsrRQfMYcPjvrWasKtn5qvso0Q7xfGSV8dENGHFlYG+nMRGY7Z6twBUPZ4Znz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424316; c=relaxed/simple;
	bh=lqITVuHjSdd5RRpvKDEPCjNX6WgnfoWxYiPz1JVma5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hP+a2jeI3JfZhQnnbUl3gISPS8I0v36M7aQQ78W9JWe3KD0p1gVuT7oa4Az+ioS9luMqbCCag1N/ZKJ0AYzYCjx3Kk1G+E+8Dvo91pLloH28dABSWM64xxSXTgo8UdZaHNOEMxaIhrllf5xQvyg2iKD11bhpFj5+AfwbTIRoX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m6yxRP+P; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce85545983so14252715ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740424312; x=1741029112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmN3KVAfNfgQLfOINQ04HTMkcolnnhRuNSGcRqyX7Zk=;
        b=m6yxRP+PvEiFr777V4ZwKdSjYp2deBUjqCmb61Eu8LOu5RScL8OxcDdUVk0c+98WiM
         3JJyyFs9mf/zrV9+AAqMwsdNyowb+kFeeap0XA6RHSEnfQV44mNpCrE5MMCJv/n+y+Xc
         IesAM+0yUPrRS9fAYyZBrBhEYtGlnn9VlBmiWEPpbyYBIOXIxh/+3i+vRldjxBBYM+F0
         3HtxhSM/8Zpmi9uCYccAEwuDhEC6FCP/3W53+f3qP6aWHhsJBGVYydP6BEXVqZocpk17
         6xveQZ7S3xmCcLenEop6KjDZnACpmWzb632Z++0dT7jZAwA8FqCBLbwINUtS6XDC++yI
         2fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424312; x=1741029112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmN3KVAfNfgQLfOINQ04HTMkcolnnhRuNSGcRqyX7Zk=;
        b=WXwP9mFAvstnFPEp27Y6XGt3n5CJmH0r0NuYKCCt0QDAn08+HgwXUTTCZcKymPqZfc
         Js8422XtczPhiOqet3lybo/dzZpcgTkQa6BNQywSxoRKExuDSbYi9D1SOwU8tU6iP54+
         tcjTAExOn2RpSL+TFR1posPHTieYaFULcH2RiDSlV0BX+6DSHQcCadXv/+52Zdg1qD/h
         GwjqwQVWcRPVLhUxvac1ZudkuypFFG9ZOVVHdjdjLvLlBGlNrhUBIo9WMysJ7WPbTRw3
         8o8Acr+GMAMvDmSWIlB8QT8dNUUoalfz36o6YFBhGd81lxZm+YcFmCKi2+3q7IEe3HVe
         qfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyGbDp5IjAZ1ULov89KyDQpPKLBw0ShG8PPgv226rQ40dz4ZiKphnkX2Jt4rf/pTrfk31XfNqaQjbLjTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtAx0TnzOuXYhGfU1+VZx3ZfwRVjCTrjY9zi4k5hhzgJc8ZLU
	suWAqFIOp7jaTmCVW9Ayz4o6SFB/eUidjDYzhOqsYsLL5cM6+QJslbMXYC0yMhI=
X-Gm-Gg: ASbGncvvoUfbktOBtqXvZuC5IiOCTVP3Ex28rEvgokSqhVmIJ4E/rSb3z2ceaOirYzH
	7gRbXSbRM4OvyztkNr72gEsGzyCLDnz1/JAr49dqqDG68SC80T2eCs1Kzo4AqBV9Wjx9mDTyu0l
	7r4wUXyWXQWesTI7IMn1xC0UEFNlMXqxgJlGb6koTbb12P2OLnpPUDC1S2bbpBfXy+xRMF8LM5k
	APGh5r1/JO12mPdZ70tNY03jfkMWBRUPrEn4ji3Uw4ZtkPioXt9M1oHp1fQt+saLCvRb/XjIMV0
	2UQVRZphEnhUyWBGbw==
X-Google-Smtp-Source: AGHT+IFv8GhjG79J3q5ecRXZdFhxhc3NK0bAEpM1VgiIaqs2Y5/ii9q53L2gwQISuhGHureqzJhrIw==
X-Received: by 2002:a05:6e02:1fc9:b0:3d1:5840:1333 with SMTP id e9e14a558f8ab-3d2c00a5ff3mr187424625ab.1.1740424312651;
        Mon, 24 Feb 2025 11:11:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18fb56f99sm52420845ab.50.2025.02.24.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:11:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224172337.2009871-1-csander@purestorage.com>
References: <20250224172337.2009871-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/waitid: remove #ifdef CONFIG_COMPAT
Message-Id: <174042431179.2039316.10674905939776007454.b4-ty@kernel.dk>
Date: Mon, 24 Feb 2025 12:11:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Mon, 24 Feb 2025 10:23:36 -0700, Caleb Sander Mateos wrote:
> io_is_compat() is already defined to return false if CONFIG_COMPAT is
> disabled. So remove the additional #ifdef CONFIG_COMPAT guards. Let the
> compiler optimize out the dead code when CONFIG_COMPAT is disabled.
> 
> 

Applied, thanks!

[1/1] io_uring/waitid: remove #ifdef CONFIG_COMPAT
      commit: 0cd64345c4ba127d27fa07a133d108ea92d38361

Best regards,
-- 
Jens Axboe





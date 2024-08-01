Return-Path: <linux-kernel+bounces-271689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDDC9451C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D021C23B58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F61B9B3D;
	Thu,  1 Aug 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="il1JUOQP"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752513699A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534341; cv=none; b=Pj2qFkDvtuZ4/fEQ/UfwA0Dt7EywUV0GQ+8F/lgUpxDiLrKvyJ2OY0M6ksPFoNpx9W/PImRkduLNOvri8f/eExPvzRkpwdM1Zrd5ldDZZnO1ySyLwT3jTEyEsT2N8p3RrGGsXI57zsV3Ilwha1C06JYnAOm3qkLuLHlFZgCLxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534341; c=relaxed/simple;
	bh=Md+tCugX0T6DBlJwjfQAImnL31p6sihip5oruYd0jwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpwHn7A7Fzi/9cfHod4i/Ih/J/gZIY+CGnATup2PNBGKr7ehHCHQ5itUvOYUxaI0ojSaQvOJJSlWziwwit3PtAxcnn6MaiKcGi6AV7eBInnarXCXe26l4bJ5KoM0EKqdRa1FnlEQlnHETMIGSpzwOurPbuYGxfodsE6B++yWWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=il1JUOQP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so2730876d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722534339; x=1723139139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Md+tCugX0T6DBlJwjfQAImnL31p6sihip5oruYd0jwI=;
        b=il1JUOQPm2e5t3jH9ynm5lAPIr4aXRRPUNbkRi6qZIStlLoaHjHANUmWVb6Kntr6Gu
         52QCf8XeTIDWtwwtuR8V+RhOT+ByYhGTGvVD/QPX3DyLltIwFzZXvkkjkxmG6KgAHN9B
         nIIzQeXEYrShVZ70Fr8e5ay4yZr9WrpqTedd5+s+sJTLFFwzbwDEpYM+PECJNJXQHbl2
         DodFjktjQHHRIxdU9brulkLudt/Wa2AECws+RlSLkBaeODs6CxuFpw+fqqg7ZFziuUfS
         qgXQM5vXUaptQMSSsr9qtHYOrXn/Zn5P6xbLSnjZCt6grDRE4CGUCLGHJY7awngiKkvS
         qNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534339; x=1723139139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md+tCugX0T6DBlJwjfQAImnL31p6sihip5oruYd0jwI=;
        b=HgqNVdWDLDJBSe5qxR6h/x7nZtfSDD93lYpwR2GKkqVAoRAiootJaP/6Mrvv+dqmiP
         nGx2uFUQeAEAxNyeoLpbEj8q8fUufOpbKnS4mj5YBiGMXZu/IPfd7MTgl1UVKw+2zLVc
         A9pFIUwYH6h2R0++ySw8yMb8Sw2Fi79HZoJMLGkWJtskkKHp9yFimNbGLM6VAOzAJ/ob
         3kreq9NUegq9EaYsLFzH0EIUwl6aBMXYf/0HaPa4wwekn2d8Y79ILohcdxcjq8edj6jR
         jTllvJd76ziCgQkC9FTd7NOa0/EMnquBVsTHzxejEwQSmEmpqX+ou56GQ3gDGTHQeb+O
         wpFg==
X-Forwarded-Encrypted: i=1; AJvYcCXhNpoJ94KtjS3SZcV6317hAXMrQtcwS5QSdpTugsoP16xUGtlKEJw7NIBSvwni9rIoc5UV3YoPw0vBonPTimTj3h73yo/QVhhWIV94
X-Gm-Message-State: AOJu0Ywgyf4l2Xydcf2dA7sSoEcQPGzz+GVLmgsDlco0dR+FcBYIbzhC
	yiisT4u/nJQbSHLBNQE8fpsseDYBeCu6WDfECqox1YsVewnWmo/ct+NK+kvb7oWtZjXd5DE0myh
	sho8OGBImBHyHsnXD7O9EHh8D2DzvQL/xZzt5
X-Google-Smtp-Source: AGHT+IHxqFWXrBnwwKA5uii4m8WRktVKp0ck40g4Sz01mi9eFCVRKd2tDwa3fcr6zENHmZS+RQTGRB9qTrhExEKmqA8=
X-Received: by 2002:a05:6214:5b85:b0:6b5:e3ba:5251 with SMTP id
 6a1803df08f44-6bb98332800mr13418176d6.8.1722534338642; Thu, 01 Aug 2024
 10:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730142802.1082627-1-arnd@kernel.org> <20240801010953.GA1835661@google.com>
In-Reply-To: <20240801010953.GA1835661@google.com>
From: Richard Fung <richardfung@google.com>
Date: Thu, 1 Aug 2024 10:45:01 -0700
Message-ID: <CAGndiTNdCGuHRmnp+G-=_PzTaLXnUZpuXAT8dK-wdoG7Mpwt4A@mail.gmail.com>
Subject: Re: [PATCH] fuse: fs-verity: aoid out-of-range comparison
To: Eric Biggers <ebiggers@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> I think this was just defensive coding to ensure that the assignment to iov_len can't overflow regardless of the type of digest_size

I agree with this. Removing it sounds good to me


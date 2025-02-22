Return-Path: <linux-kernel+bounces-527043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F979A406B5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335C33B8135
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB12066ED;
	Sat, 22 Feb 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miQR5uiL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A22AF04
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740215493; cv=none; b=VAlYNT8M+uR06J35hAj6Of+5SiDYNwY0BP+7n2X7cZqq/b5/VTwcps3DEMEI0VwAIEqmNj7Icx5CBOvw7SpHsz+uAl62fVJdwsaKDXrxaE4Nxp+JzSx1pfRKLa9N243De4lzdTMh+juNSvMRciHSqvG6OWfjbQdqiWKeJ4wNdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740215493; c=relaxed/simple;
	bh=59GDzJBfroMphg9VkJHEcXLIQd0LI8FSXrEJIp5JKbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4xNE4u13W9d9tYy2G0one1ejAgC1DcoP9//tVVLGOVJR9wyUrq7S90KDaovPjsPBVxWKGdO4kQeXDIgXuTphgVGRlTugO+MVTMUfjZoiErX6Q7cAIZtOuRyKg8YWKhlxMMtJ8g8o9HG/QCcY7wwNhwpN35TRcRbRfqfSRtwZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miQR5uiL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so17080415e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 01:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740215490; x=1740820290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQBDq2SD5cTGBo1+tH6tiJ4vZLPJjdW0fS5jULMx+5w=;
        b=miQR5uiL3rmqbgaJ5p3ilTF1zqeK2pS6JKG63cU2T50n36KfL2Gs/SH8GYi0EWf9po
         RV92IO2bFTtoYLK1OkMIB4s6QFGJKznTXOUUkX2LDBzep2W7ZtMpU6fbm9DF59sYEJ/U
         gt4QCF7uUnc3uG4ovBk2geafurKPyaPz9AoEfz6VNoo3kNC8QxFP9+LsDDg86ygKHEKK
         MBwlYz1ZFBbbu2NPIhk2//8obA/j0jyzxVWlZSgnozaoPLf5CNERl3b5cSDYTXSFs/VR
         oQ9vf9/2OOWd3D8DqhGzQ5F4951UJINggvWDvcMPj4uMXRsE7rrb3h+ibOgZd0CoiAom
         tx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740215490; x=1740820290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQBDq2SD5cTGBo1+tH6tiJ4vZLPJjdW0fS5jULMx+5w=;
        b=fGz5hu357F8/6tmYMOxGClT+wlIlqFZe3zmQxFwgcmhNm0DrSZNVPB82epEHoge84B
         mhgzWSOCT2ZRFEsAnRU3eumtXjtkOXJBKxENluOc1Cq8uCz4BF9p7YVhcWoaG8vnAUlh
         hUFqUR2fWiesYtB+sseT16lXEMQTbCLhayuw1L1SAmb0CVkFmFpPjLVGmr66IlIcl06A
         MScKy/CFoCRn9mOdnShg/DwnkPZjCb4sFj9YfOcFldvaEYv/pTwiGAp656C6mykQU1IX
         9AzWjK4x11qhadtD57/aR/PMWnle9Z+Yc74phmQSEzT00j8f6t5DNf5oJ/rcwplvMdEV
         am0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm3U8vDzhxf+zhKS5i6dtQ5/dCx3385KkYg8p3d8GgAD9jhxcFLi6tGfFRn0b29fR4/epj5RmyX8jnCcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRrkjg0D/8dgjDbm3EJAWNsnBmEta1XO66wPyrpgJ3nZE6rE2
	CHkjJ7QOzmdsHHh3tOXYOaJqAC2iyzoFQXOVg0/+ohqTw5EsKaNr
X-Gm-Gg: ASbGncsFC56Jh7+LWxxxM1U/gpgQWnweBPvd1TimxPL+EPad5K4DctZehBJNUGPxTIV
	1FP0j+C1LcbjbZpwPL9IrvVDF3pKT9k5WW2qSLEKThaNTGE5bvEkgynWxRgG0Yjt3xk5dIb4Pqr
	eX0m9BJ7hbvGib5q9P5D/eMQXFUnJn0saRGUgavOgYK7uX1yWzxxrgmXWWar6X/Qm3AUJg7gZsO
	eStRnXvzWo0LIfOounf+u/vpXUIbvYchXhEkknHuDqmfX0pHfIYGGWWY1bs0zapmrEaeOFp+ZtF
	7SpH8lwl3DaMVkL8BQRS3Uh9xUw+z5rD/2eUuAdJasn7SYToM/6/XMLGWLa/O2Gj
X-Google-Smtp-Source: AGHT+IFOzU2IKtqTZHf3Bo4MZ3F+VIOKQ2k9+oUPCnWaMRE+6WqkLdnxLhrxWy8cy+Ucq0dOmNUY6Q==
X-Received: by 2002:a05:600c:548f:b0:439:8e95:796a with SMTP id 5b1f17b1804b1-439ae32aa13mr50678225e9.13.1740215490233;
        Sat, 22 Feb 2025 01:11:30 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce65dsm41102595e9.1.2025.02.22.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 01:11:29 -0800 (PST)
Date: Sat, 22 Feb 2025 09:11:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: yury.norov@gmail.com, anshuman.khandual@arm.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 skhan@linuxfoundation.org, mka@chromium.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2] uapi: Revert "bitops: avoid integer overflow in
 GENMASK(_ULL)"
Message-ID: <20250222091128.5429f1c2@pumpkin>
In-Reply-To: <20250221074208.832153-1-richard120310@gmail.com>
References: <20250221074208.832153-1-richard120310@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:41:49 +0800
I Hsin Cheng <richard120310@gmail.com> wrote:

> This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
>  GENMASK(_ULL)")'.
> 
> The code generation can be shrink by over 1k by reverting the commit.

While you are setup for testing this (and me being lazy) does changing
the definition to be:
	(2u << hi) - (1u << lo)
make it any smaller.

(A summary of the size summary would do, no point listing lots of '-1')

That can also be written:
	((one + one) << hi) - (one << lo)
so an appropriately typed 'one' (1, 1u, 1ul, 1ull, (__uint128)1 etc) can
be passed.

	David


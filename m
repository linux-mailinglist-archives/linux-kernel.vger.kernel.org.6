Return-Path: <linux-kernel+bounces-433888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003789E5E61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E503188517C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18EF22B8D7;
	Thu,  5 Dec 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQyidbrw"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAE229B28
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424137; cv=none; b=Fv7Mgtz56vCGCbflbMlknFnThOHQOp8L9V2vyLkEgLn7f1Yt1Z4vR1V9KN9/zNecIJeNE8di3orYuyQO+nMSdDgif2qjwdWCxavT+QMAuHakSl7oD1c834vfdT1knaiE+EyTINX1m0f4UEcRe6T+3X4CxPCWntoJKjwBAMGaIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424137; c=relaxed/simple;
	bh=gA/VeNm6V5/8b09vX/49ut5uvV/G8q+I9tBmKj7pctU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoFRRyvdRa7gQaVPB5FExqo+wOo1XZBtVEAYE28ZTLYTPUYkZZOIOID0LCJoZtbvAhwO2AezJxRf0eRBOY8ZDoSZdQbwFI3cwy/PQXkD+VKVMlKS5jFtuPL6QWJmjJ6MvHNT9iyLGnf5nsAPiH3vdxOon4oLVxDj/jGBEQFCtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQyidbrw; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85b804c0157so263059241.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733424134; x=1734028934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tR8Gx4YF+iGaCMV6DuY+XQYSDcjVdzyIfn9PDc6LDOM=;
        b=xQyidbrwCeNXzAF1X+SB1F06/dklL8Z590ib2CdIKxi0mHRFXyNX8hgL3ZpkSGfk3o
         y+R+P7JO9cKow9s69jpcuRNL43GmI/BFfxNP9JBrHTtvPFkKmNV31QMzFtSnLO+Ku7j0
         vJZEHIvxB6qxPFW9Suo8TEzzebVPYnZj0jBHzKr2fV4a/6+7ZIiXOOh5Z3FO/rEjo7a5
         asLxtoXvKN324R57hkQ7Ej95nDiSAeFOOM8a80Sr5Mp1+nVnAcbKVcGCpMGgRTQHPVg2
         Oxjrea5NtO7TfWJv7uQiKtCmlrGXFBBZcd6QbEc5OXgHCt0etnyB6NSEjbk7R+uW0Esf
         XmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733424134; x=1734028934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR8Gx4YF+iGaCMV6DuY+XQYSDcjVdzyIfn9PDc6LDOM=;
        b=S9Gpa4od7Ur9aeQfhHtxw2KRToNmu8iAwDiqtcsqeRz+UUydyegSj+ez27eY43i1VK
         CMkEIjZjUn17ywDioRV9c7hk599xi3QId7zq/XJGYVYZVi8/mEOAhkCuJWr/WXd7KnVf
         GvbDt5PvAO+6PzmRSEXTv1p/DyfX9CQ++4C5aQhXck6d9x1uKun/CMfogpOQkgFliNEG
         iASo4VNcOKIRsuLUx+f0gp0XbjXV6ph1Bb5TDhZT984Fwwx6/+iEtq79Hcs+OkCbsG9X
         8HyTN8lxX2HuVt049ABBzPvyol2xPKR2gCJose8EQ3Q9m6Tv+S2r2Fg0jvKbBCP6FWph
         yQwA==
X-Forwarded-Encrypted: i=1; AJvYcCXvvXZTUSb4jROpqI58pMKXVR8Omm64wzNUzDuHAOkjG+9SC/RsRE1bmTDTXyFsQcrec/aBF81gbcQj7hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfn7QTqvsLuawkoX95YSg3OEamRQMvp5cQRQf5Q9ESxkWl4yw
	BQbJxm3rNjXHqLni4oGGGRjD4sRW3nDGZDKXX0+UBk5ISNWWHBRx3RcD/xNtQRCbrrqEPGJPCjQ
	z7Rxj2vBVhsnUy/pF7yZ3gS19Y1ZwtCDO9bGc3A==
X-Gm-Gg: ASbGncuB/HAxpOYBmz3Vryjv5+MKMbK/HFk8PNMdB5us35mcAr6GBKsZ6fnJ8fa5bVj
	sFlCCn3xXZaeOhjrG5BJbsIp5r9eX0wwp
X-Google-Smtp-Source: AGHT+IG269PkgdVPpsUfRMnNfyCTRw+6b9s1FqQamygLLFlRX39CxuzaR647OcbZrJKkKII8mvW1s/GWCnxsPXgxkTM=
X-Received: by 2002:a05:6102:3909:b0:4af:bf45:39a8 with SMTP id
 ada2fe7eead31-4afcaa4f74cmr835447137.16.1733424134670; Thu, 05 Dec 2024
 10:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3f6ke0g@mail.gmail.com>
 <8dde5a62-4ce6-4954-86c9-54d961aed6df@stanley.mountain>
In-Reply-To: <8dde5a62-4ce6-4954-86c9-54d961aed6df@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 6 Dec 2024 00:12:03 +0530
Message-ID: <CA+G9fYv5gW1gByakU1yyQ__BoAKWkCcg=vGGyNep7+5p9_2uJA@mail.gmail.com>
Subject: Re: arm64: include/linux/compiler_types.h:542:38: error: call to
 '__compiletime_assert_1050' declared with attribute error: clamp() low limit
 min greater than high limit max_avail
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Laight <David.Laight@aculab.com>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, netfilter-devel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Johannes Berg <johannes.berg@intel.com>, toke@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, kernel@jfarr.cc, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 20:46, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Add David to the CC list.

Anders bisected this reported issue and found the first bad commit as,

# first bad commit:
  [ef32b92ac605ba1b7692827330b9c60259f0af49]
  minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()


 - Naresh


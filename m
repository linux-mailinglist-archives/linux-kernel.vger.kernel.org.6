Return-Path: <linux-kernel+bounces-387927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA19B580F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149CEB23433
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1120C49D;
	Tue, 29 Oct 2024 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKgSVG4q"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32D20514A;
	Tue, 29 Oct 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245872; cv=none; b=uAn3tBg5aIr0zt/ixmPm7LUmLnjmyjp2G55QZUCyHRhhZoHVAqBcI82ZxPipfFA9WjkamRsFCTHXu2AngqaKrnx+UnUMrMKHEKN8msfz6c1xORSGmHVUgxKZmTSDrbV1mE/WFkfvQAUMmYslHGEDjobaNpWbp2w0YE5t2Fxpep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245872; c=relaxed/simple;
	bh=98MDAFRT95//lnZDjsqqK9SdEeT1q5RGfNU7+z3FIRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVy8/lFb9E4LdLxDsSmW9nwIxLnodykaJKClJHPrfkpvOGbx4QLVF85sG09tvCDDHWs7D1YDE88nFbO/FyT5rZbkvyiiiU7Qkr9aoUuCDlp8h+tGWFRllWn2e6sGue1TIkxmB9ATKNN8appPji8oSB0La4zRzgalPFly13397yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKgSVG4q; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4666668a12.3;
        Tue, 29 Oct 2024 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730245870; x=1730850670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJb6Q4obk2cZCw8XDfh6zJdRMtaT+sRkjeFy53PRPNQ=;
        b=dKgSVG4qQDDkoWVK3gHbXyy3HhEbBGZBxXdqlEPxj1bw2J3/autPntWpRUR4++Wfx6
         ALntAfNtZaj+8WqE4PB6x4pfh/5NSUkaqhWBFJJeWHK4cabtgjLnkGu9Wgzd+5JQSD9s
         mOYpNUWwLEtHCNuNzCz69wNgZagUrR8QI29diOmRv7fPLkjpO44Q25Mse+IRqfZSmlmd
         lffOtG5iWgS16Y/1Rk86FILHgqBEhWwKrX4HCymgtcTiQwwBhovMdNDa9WdAszbE/J0m
         U72iDlZw9eg2vfxRsr4Aa4SnAWqRYdJFh79YRyLPAHAeCGBFO8gA+4ZgyRRWv7tVMjDu
         Gf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245870; x=1730850670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJb6Q4obk2cZCw8XDfh6zJdRMtaT+sRkjeFy53PRPNQ=;
        b=J1puDqU8ZYOKp6O6Evk+EJuZSTXkTzg3yKjxr0JT05xLqoGp2wuMmSDFZQpjhsyPWV
         gC8N3PDkKTxtBl/LQ2Hl8p/QjxJtsC2FzHGKsl1P+LbKYhGCbzw/aIy2djVHXC50bkNt
         7hrWUsN9/pPKZUMftXoIwtUkxDCIBAKiVxBdn1p6h3N92SB9S5rdsjbyew0O3+IBbzxK
         d48dYqskO5iN79DuSmsFXrE2ocojQ9f+iDu6LKVq0M0FOcKfIRPSaSJ1yPI94JgeUWh3
         km3nhCH9l4jSz/mVyvM4nwgOKDlHZHI4Wa3Xa/IrzuSLod0w3UngfG8m1H5QghSK15u/
         hdOg==
X-Forwarded-Encrypted: i=1; AJvYcCWW6EteRdLQObvp3gh1uGoRUKqAECTqQNwjufJaVIk6qqLQICaZGF/iOfidMZY9GrnGs34OTWRDiq7sTQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+1xlGW0UToZCE32GVtgrIOVjaMMV6JHgMwpDy6maA01ZIHqd
	nEBkewHoYcI7QQ9aIIjjdgCf2oOdv4ppsFi2p7byawbEOYA/o8LA
X-Google-Smtp-Source: AGHT+IFMyx5/kI5Luwq9R2fiSNboPLpcNcmYDNW/seUuImbSg/v6eiyFkB76nFz6NUNtm7yc4cQ0Tg==
X-Received: by 2002:a17:903:41cd:b0:20b:707c:d688 with SMTP id d9443c01a7336-210c6c0d30cmr202640155ad.18.1730245869897;
        Tue, 29 Oct 2024 16:51:09 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d395sm70759565ad.91.2024.10.29.16.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 16:51:08 -0700 (PDT)
Message-ID: <83df1d71-dfbc-49c9-a6e6-05454cac2ca7@gmail.com>
Date: Wed, 30 Oct 2024 06:51:02 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mailbox: Documentation: add the latest documentation
To: anish kumar <yesanishhere@gmail.com>, jassisinghbrar@gmail.com,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241019195534.79603-1-yesanishhere@gmail.com>
 <20241019195534.79603-2-yesanishhere@gmail.com> <ZxsSvbXXiwNAHCWX@archie.me>
 <CABCoZhB62CKhCnZTCgTAhEh27td4Gw6XjJ-uYQJRqJuN9NPqmw@mail.gmail.com>
 <CABCoZhDUajW-L6LdbwDHcHcNcQGSRbzO=bqyOZfMwjoeCb+p2w@mail.gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CABCoZhDUajW-L6LdbwDHcHcNcQGSRbzO=bqyOZfMwjoeCb+p2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 01:06, anish kumar wrote:
> Hello Jassi,
> 
> Gentle reminder for the review.
> 

Reroll.



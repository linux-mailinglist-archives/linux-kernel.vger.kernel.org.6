Return-Path: <linux-kernel+bounces-306793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782D9643AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF49283AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB014193083;
	Thu, 29 Aug 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4ZR5VO6"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCA18CC02;
	Thu, 29 Aug 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932825; cv=none; b=LQgDUUAUmb6DpjfWM23AdKRGhryG0gt+MhrON55Y9GtyjsaIvlADyB2md5W5NXPby2Vr9nOJ2maSQP7YVWyZnkcmxuYtrCBP6pogLif/rS9ZtrmISmEwdLWTPKDr89nDaCuSPeGP8BIOL20yukTopxC+O7hPiyjFQdJ8tSDEDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932825; c=relaxed/simple;
	bh=+AFMsTioAXTYe+/OIC8TW55UGMedcr0nSW9NuwvwmP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrdV6Si/fGHSCBzlRdpLFFtT8MqK3NN63HVHVYJPxc0d/UkRvQj7w70daWsxK4IvUcsGkWi6LwtbY5NG0ORaP7QDO9YVaCjWle92Pt7igTwIeLvCs7Tg191LuGbuc2VYzbEk4s7A9z+NfwKFn5ZBE6zJrun2IcLg96cs/7WAxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4ZR5VO6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201fbd0d7c2so5194195ad.0;
        Thu, 29 Aug 2024 05:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724932823; x=1725537623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27LAEgYBljGGhgNMpBJC2vTKDP+IyCsrvFLq2dI8Abg=;
        b=Q4ZR5VO6ZXlnoCxF3kkcusyizhsSTFMsydl+bWSK5r94rs4OgB3K9TcCyCuJNOtaEM
         RDAerZUs5okm92pkwTFekE/vrOUUgxP6uHfTMtn2o66J9XSO/jN0Lc0Uv9VsySSDjFo4
         64jIESV5i7FidHslry6FyHZembJZQgROf/9tmDIUo93WMSLimZk3bPnzevjT6wMVJg2U
         dBINgT4pUZ9pcFnW2I49om2MlD1oLRdqGhOL1X5kyKFhmvemBlJRBJJVXEJMn0F3vAFC
         +VRBPlYMN5ojgY74rHKmSizWiByHmLVZdZRcc1USL5wQA7DDtEzfAaAZ6GtOI5jsqCNl
         H0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724932823; x=1725537623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27LAEgYBljGGhgNMpBJC2vTKDP+IyCsrvFLq2dI8Abg=;
        b=BXnos9KJ2STJ8waH8K5eCLoxYXMwpLF4neZgkDXWycq6CgOFyZc6QPKRxG0cTxbNjQ
         tcA38UkrpswjwTobAqIYabW1vKZpTF8bbSRD/BJk1AJG+aPM9eIyVzrN1EtMvEq6GZug
         pQwKp5vGqWFGj7i3k9bIbDx/SDeF84jFmprpDXaSS00e6nGBvXC6R/R8hLLNnuUVqY9f
         HMxmz8dkk/6GNYRd+Sch/NxAEANKhu1g8oKemIkzqk6qzXPZNkvh4/R4HAv6ckNCg9kX
         D/de5vbQbfBWNnhYpALgihdFgZBacPKaX9U0V4jPmkLSALi7lNjBS9BdB3PCMkv/no/r
         8lbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/oSR6sb3F2wi/WftugyoisFh2dq/EDQd99vOUTHRP9SDsDRgo6Bv6YZ25FhI7M5/+nPgj5Gas6Bdi@vger.kernel.org, AJvYcCWvzsU03Xqn0aFtNwy1zxzn/cKDK6W4/uD6J80uRq0j6Ut913XM/x8yRvH+d4TdslN49n8Ngpo74KcuQHgy@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwzGRo86+9nnZqiqIRAjwl+jPY1z/lVTaAFw+CByG3MPBQgPU
	iDd0H77jYZCxqGAIhjWXKYqWuWQmo5F/EaaZdjxpw72pk0hPd5Xw
X-Google-Smtp-Source: AGHT+IGSxZrGNk+/VLxv5dcGRLbTumgaEh9jEg3/DzzAzQRgXV7JusDx9MISGEMfgtbvbhJA7p08PQ==
X-Received: by 2002:a17:902:d48a:b0:204:f324:e7a8 with SMTP id d9443c01a7336-2050c2186bdmr27634425ad.6.1724932822870;
        Thu, 29 Aug 2024 05:00:22 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b1326sm9998545ad.35.2024.08.29.05.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:00:20 -0700 (PDT)
Message-ID: <8fb7bce8-e1bc-4ca8-8033-811ed67cc767@gmail.com>
Date: Thu, 29 Aug 2024 20:00:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/3] dt-bindings: apple,aic: Document A7-A11
 compatibles
Content-Language: en-MW
To: Krzysztof Kozlowski <krzk@kernel.org>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
References: <20240829110436.46052-1-towinchenmi@gmail.com>
 <20240829110436.46052-2-towinchenmi@gmail.com>
 <220766f0-7cbb-4b4c-a976-477ca1d89fee@kernel.org>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <220766f0-7cbb-4b4c-a976-477ca1d89fee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/8/2024 19:46, Krzysztof Kozlowski wrote:
> Please do not resend different patch. Or rather explain - is this the
> same? Looks different, so RESEND is not appropriate.
> 
> Follow submitting patches in this regard, you need v2. Just use b4 for
> this process.
Right. Since versions of patch series should not be sent too frequently,
I suppose a v2 should be sent next week. (Sorry - not super familiar
with the process)

>
> Best regards,

Nick Chan


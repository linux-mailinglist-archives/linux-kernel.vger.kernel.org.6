Return-Path: <linux-kernel+bounces-229673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685DD9172A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D81E1F22B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B317D8BE;
	Tue, 25 Jun 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmoKdpS5"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F23B7A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348327; cv=none; b=UzDgFxcF1We5Gv9u5ogL4gnNj3OAHNPS8rLH8loPWCoerBxDM7Gh98qNbb9fccjdYgZhegk6SxuSsbn20QWat2aqXK/JcaFZ25QWn9ADCbV5Jx4hlYkxvUgQiMkvDj0GLa74eKUDj5LfZXxp/u0BRdOrANM68QW6RnfG5kL7TfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348327; c=relaxed/simple;
	bh=/nsH//Z58Fd2Su+RbE5/otjnSFauqQGQOzv899HhbUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrBJRkxtfoiZ8GWEMaEP1lX/AsM0gJM31Okim5q139/VVLtU4OkElouXpmJ5FHPaDuCfkaUJrB5PrgZBQBVOhcgsrtiDBvmKKO82vCNhGwqtzDPQVdkFQ+mMlUXQlrBMH/r+KZe3qApn+r2Yzt/QzeuvnkdHDCzs5KogZxMpNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmoKdpS5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d0f84b379so898195a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719348323; x=1719953123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQ3OA/LDSmF2zaAN/8y+noIQOtUwx5jM6T2eNySOdXk=;
        b=PmoKdpS5+NB+pqorYa/RbjIihZ2XNfm0NYqJL9tmEmjmE0W6tX3FCKaFooOeAk3CGH
         C0c57EcbrIoPMIsP8EjADzXtESoLDK6REcOpt+jf+pO0VtOu0EBMY8iXapmsBa0/QRA3
         ZmNLm1obsI8jFFWLVTgZDsitct4sBZdEl2nqZltsKJ/n/YMpIoJY1dphW1B0Nmc0MmgO
         zUO19gV8Y0+iQyraQzkL6GIzdg4fsB47eQp5kjwGMK3XLGLB3NC0K2z9U5ZMaoVFC30P
         bcjLohM18V1MJ/sEbwRiYlhjhjx1xB3RUY5MAiUpA2xy2dCWnaPlN2RtOVtsEmhnFb0m
         YdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719348323; x=1719953123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ3OA/LDSmF2zaAN/8y+noIQOtUwx5jM6T2eNySOdXk=;
        b=u9KEpezdrjWWY57XkjLtZ4XNobRId1/vBtH7CrKWKotDZxAvZglxYefGh3qJeRBlby
         bO9+wIAxFC1MAxyKd/uPH2fXNkSf4WhT60puFiCKe0UTayRty0RB3A+pTJM3Xu7LMFZq
         Jm6Bnk9iPfx/T2itLHoSWqaTXkUaOpMyrGCuTmqhgQhsJ+jWvsFK+BiL4uYtFuHjOGfy
         kDPdM6r0Xvp5LlSZvHjpuUMwAA4LSMe+g7BiBKoqAmNCTXjtlJJOCk538SRazwU2YaMJ
         LPnnhge1xds4keWaTgodcjqlC4U3ZEAeBJMk/r0SG3j6igpefb4txXCa34jIGinE/C0f
         hfVA==
X-Forwarded-Encrypted: i=1; AJvYcCUsXkSYN5niELfE0eXzrxxqBK9kdqloSLwcqOTC2M8ceXCWILC43QpHwOwEzr7gzcGJCi7YHvL9ZJnKuo3cmppdIVzTQmjB2hZNv3zj
X-Gm-Message-State: AOJu0Yyxz4ayKjjosz40BQXCoQ7fdTIYJwQLfjlxzjG8D7wz+1XB1Rvd
	udhtYmJq5yQghCs7jq6fWKW8/CXn91gFeN+CIZ8KlSrjxjxm1TUh
X-Google-Smtp-Source: AGHT+IGBK4hVsbAAo4sMicnCRuHFBADiR353JtC4ouwVvbn9y9bJCYaZXXkBTyjCrp37mv2tH6tDXQ==
X-Received: by 2002:a17:906:4f0d:b0:a70:4217:5c8b with SMTP id a640c23a62f3a-a70421765b2mr661333766b.0.1719348322594;
        Tue, 25 Jun 2024 13:45:22 -0700 (PDT)
Received: from [192.168.0.103] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf4ba625sm547783766b.93.2024.06.25.13.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 13:45:22 -0700 (PDT)
Message-ID: <b3d9f694-77c4-45f4-a436-c00a7d6df61a@gmail.com>
Date: Tue, 25 Jun 2024 22:45:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
To: Yusef Aslam <yuzi54780@outlook.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CWLP265MB651697C43A8A396DE8989CD8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CWLP265MB651697C43A8A396DE8989CD8FDD52@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 17:28, Yusef Aslam wrote:
>  From 3acc0622bca28c1a00696e7abd7c305ca5ad1f72 Mon Sep 17 00:00:00 2001
> From: Yusef Aslam<YUZi54780@outlook.com>
> Date: Tue, 25 Jun 2024 15:03:08 +0100
> Subject: [PATCH] Staging: rtl8192e: rtllib_rx: fixed alignment
> 
> Fixed alignment.
> 
> Signed-off-by: Yusef Aslam<YUZi54780@outlook.com>


Hi Yusef,

OK the emailaddress of greg was wrong. But you cannot just resend. You 
need to make a change history.

If you send in a third version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Your next patch will be a v3 as this was v2.

Thanks

Bye Philipp


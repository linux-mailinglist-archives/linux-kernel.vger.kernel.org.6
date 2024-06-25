Return-Path: <linux-kernel+bounces-229371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1844916EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8D41F229B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D01176AC3;
	Tue, 25 Jun 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA6kihVL"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C616D9D5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335708; cv=none; b=n70CFkkco2Lf0zVMo8OGNsAIWQuTVAOIB4/PpqqCvuC0idceEnjCqYQGpza+gx6QPi7t3kPEWLHlRWsg6T41epd39/pJLX74hou3CQRzpBrO80nMYtnDE9rSLQyq4Yvydr3rYM8tJtNyltQlr4Qps3hjv1CNbfqK7faQysWr0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335708; c=relaxed/simple;
	bh=sdyuZuS3EAxhOTCnJs2tZdjIHedkG3Ym4GQBRUD6eCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnFRHLqqS3YGJPOL61CBJXAGsTpGTg7Ox4w04HbiiZG4eoe59lp6tV3MduQ+Ao2gh9ZSL0+qmhDbBhdnpy0l3OGLMeFBCfEV1JLguBX5vIZpthLCBIZGr3lXideYas2wd4nbUgWoW6CWNlkU+jabdZaQWih+dc6Ot0x/qJo97rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA6kihVL; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3760121ad45so24346485ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719335706; x=1719940506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnNPXe/TZazPruENmXGVPw2PuozP162/oWmHbIuI8Hk=;
        b=LA6kihVL3nr9aZGHPtmPjtOHrogL9yf6WDIU2nRaifaFHTk/xo0Q2CZfEVSoX+YJ7S
         lt0zgxiDqfj1bdXyuLbxhF+yQ5ep15KdhN4+j3odDAnJbxtnUenUynb7Wvu1JZH/byT3
         pc67u3S8WVxXiMdHgsWuoLtGkoPHUbqjchyFJ3A8UulXxbmfqjFToas0tCJq/Z5pSYzq
         yS/Ye8r1r0AeXK/E2WNy/ADP5p5L+G9gDRSGLqSYpE9tHXkPrmQo/dAqlTn6c7VBOGgF
         Gswguj4cYYc3Y4ZxAmhs9onxrOCcECjrzcVi1QiQzFjICu5mDvPSmIiCHjCrOj+Z4X5f
         GZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719335706; x=1719940506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnNPXe/TZazPruENmXGVPw2PuozP162/oWmHbIuI8Hk=;
        b=Jl2+bfE2Rh0/t1CqtCiQLDs/2LAASw0WDIZv0JQYPgh5T3m+h/wIPGmERFItmOdsPA
         skPbwj4XSW6KZO4SGlxBICEXtv6/pEpPxiR3j2n3jJMGWv8rLU+kjh6BfNWbY8wtjwnK
         vFaJEsHyUQXKA1/odv3oZIgddn80ERulIjSgJGFit+ZRHUECHCXBvV1zEIMdc9LXCB15
         qmTWacqI/vq6oS+LDM2jLsCVsA1qEybp+qtrMPDFjruglCbX2zVrmIv9N9Q5Cjpr2rd4
         RO//QGjLykkVz89kgXcHdLoCllF0ynI8mRZB2Xy1RQu9R8sym7UVxBBv+HlXV79xOBlu
         5ZSA==
X-Gm-Message-State: AOJu0YxKo1YDEioGIQgwwnaok3XhpPIQQa/IutYlJ+pnTpNiiuG2cUka
	bI4s/g1tGDbdQUaS4NNSHdhiCCC97Lhor0V8OStMhWPAffu2bOvOWJZ7XA==
X-Google-Smtp-Source: AGHT+IHYZTXIkSCEqUy/U8krwtc7A3RgMwkIIMvWpE62nGXl2nrk1CqklNRlJtJdFtn0Fqo6rTmZPg==
X-Received: by 2002:a05:6e02:1caa:b0:374:a44b:1186 with SMTP id e9e14a558f8ab-3763df8f71bmr120370755ab.12.1719335705953;
        Tue, 25 Jun 2024 10:15:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb041180sm7400632a12.80.2024.06.25.10.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:15:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 25 Jun 2024 10:15:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.10-rc5
Message-ID: <59fc40ca-3ab2-4227-948d-e18a0c713bde@roeck-us.net>
References: <CAHk-=wiMMT-2pfJZ8ckbnGTbSHy5mvvE=+-MyA_ARPUqiy_C1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMMT-2pfJZ8ckbnGTbSHy5mvvE=+-MyA_ARPUqiy_C1w@mail.gmail.com>

On Sun, Jun 23, 2024 at 05:41:18PM -0400, Linus Torvalds wrote:
> Another week, another release candidate.
> 
> So far, the 6.10 release cycle has been fairly calm, and rc5 continues
> that trend. Let's hope things stay that way.
> 

Nothing to report from my testing.

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 532 pass: 532 fail: 0
Unit test results:
	pass: 272785 fail: 0

Guenter


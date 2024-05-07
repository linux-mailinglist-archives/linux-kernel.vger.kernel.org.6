Return-Path: <linux-kernel+bounces-171634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2998BE6B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297CD1C23632
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB1160880;
	Tue,  7 May 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DN3fyCly"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42615F414
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093778; cv=none; b=VvCaxMtuGuuPDjb49H7Xbb5I5Qi30cXqhS6K+VqZGJMgCzjLI2HJUtKvT0cU6jxbSmi/xw6kmEpqxA8N6OwTsvbZn5OK0/4eVAtvKNEIBwoHiBJIo4nLZWn8CGmur82CBTChPSzu/qjb6g2JU7DGN0Lp8HvM8EyGEyfFrWWLm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093778; c=relaxed/simple;
	bh=U3aPuCdf8BbTSweuMDZBoEtz3ysiU7++KCuwqbH6O1w=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=eGEwgDcd0/g2iuhKqjUwxipHgp3oOErBGK05BUpsoXAIAMXX6iRgQcRfo3b82tv1fSrPB3xCbOE9By+XkUf9XNVEbuL2spdQhaHbg++OsEOFiCKO8pJpNT4h3/H+nCqvkrrzwZ5TpSajYDqNlYHogQFUZCzlzRa0Nud2dkddJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DN3fyCly; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7928c5cb63fso230362085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715093775; x=1715698575; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dAG7TUb5hoiO+hKAcnLS9PzWLaNdTanXbfa2plm364c=;
        b=DN3fyClytqoCR4cfD3WOtNU+djSVllhQO5tGwqPEIt0ipIqZSK+d0Y5MviA/Yp39PA
         ZI6e/YWKRN+f8o11TMzv7+6DamdydPOJ9Dg8gmiuPVLwsewKoGEME9ECawBu+0CZ0NLM
         qkyZQoCDT72LxXWdGzj/zOzf0pVjQ5qDi8mShWxTOvOROuYcHgNV63iODnNteDIj29XP
         OmNftbCk95mqCYVAYhSSPlpRHsZpajCXUuFrdF0rQTUHI1yj++J0g47QBPNnsdkl6ypR
         hsM7guqSL5/o9L2bLT9fWKiZyu3HoLc2ItlYlFjUyAJJo40nu5N7Ic7659+Mv2acIAD6
         YTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093775; x=1715698575;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAG7TUb5hoiO+hKAcnLS9PzWLaNdTanXbfa2plm364c=;
        b=A3szPeh4qaZQIHit6RNA7fGm8P6suBosmrY9FMfsJv8dyEafooNJH5UMxyhdogxLMh
         2Nqf3eSF6puRLGWJb65PM+8moqXLcPNq3FLJZg2rzKaJ98fr+Uuhie0yROYKGNtQujZt
         z95EP56E3J1x3tmKZSeVu1kIGlEn9t2MqQ4YvOpIJRur/k6tIu2N4VZ/0GtGDt+RlfON
         heI6B8JpZV4iyCLntBaNJsAzLNuBnb/y0Py6sZmS0Hw0RDiYXCzW+79XYbr7c0+547OU
         l859KmABqrWsSxtNZHxSdSmklPHOy+nGLtJ4CwiIEMcHlCcbm4ErpBcOQRbLMcN2rROT
         Yo0A==
X-Forwarded-Encrypted: i=1; AJvYcCWy4v8hotjokEHYcKFm/b+MTH8rpaBaUllnQy3HmoVFyPobIMR9lycY+Mo2SkFxbJnyFtEpKYaLhrid5qfFrxfVFgI6p22tRKM15fZ0
X-Gm-Message-State: AOJu0YzgJyhr/M2j5k1DycbtkF2my1XMRy8SNNAVnRbs98Q6TlmMTwCe
	x2wi77PLx8n62DOlI9yCqc/6870GQw5CtQNOcd6Y2Q+D5TnrJ9AVQVPquqS9sg==
X-Google-Smtp-Source: AGHT+IFJ9/XdlpsfijSJp8NgxZMyJgNfVe9RyIheVG2oMchZOjGjf2Ye6/u1d77c4EA1le1mWmQnVg==
X-Received: by 2002:ae9:f443:0:b0:792:92cc:41f6 with SMTP id af79cd13be357-792b24c8372mr3784685a.17.1715093774767;
        Tue, 07 May 2024 07:56:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a04cb00b0079293ebf935sm2562969qks.54.2024.05.07.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:56:14 -0700 (PDT)
Date: Tue, 07 May 2024 10:56:13 -0400
Message-ID: <06a6ed315cacd41043f9f9e67ea379af@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in SECURITY SUBSYSTEM
References: <20240507140122.176304-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20240507140122.176304-1-lukas.bulwahn@redhat.com>

On May  7, 2024 Lukas Bulwahn <lbulwahn@redhat.com> wrote:
> 
> Commit 67889688e05b ("MAINTAINERS: update the LSM file list") adds a few
> file entries to lsm-related header files. Among them, there is a reference
> to include/security.h. However, security.h is located in include/linux/,
> not in include/.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this new file entry in the SECURITY SUBSYSTEM section.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

My mistake, thanks for the fix Lukas; merged into lsm/dev.

--
paul-moore.com


Return-Path: <linux-kernel+bounces-546269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C09A4F894
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8973A055D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B81F5836;
	Wed,  5 Mar 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4cULYsz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FF14658D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162742; cv=none; b=ufynQhvAd/VoqW54pIIBAHUgjph5GVIK9P3D4gh09c17or/d8ZqM/e4GPyNBLb49phAj1gMLTNMYi5KkJqe0tE8a4UZZxMgWZdcnbJhe4H6/QrVc1Vti5CZmVtF4/ThTaktI4CtRA/iCLpQ2oF4G70h6RYTa5Q4FHrqfkT9l+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162742; c=relaxed/simple;
	bh=Z6mp4Zaly8u6kO+fciu10UUkutxanQtH4VyeyGy5Pdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHmnrFtgjBix5Ji2W68a1VTsjAAjIfcIGJac6gOkDtL8LBZPteFRMKbX5b2SqSduKGL1YWD18L2dI0FvD/SaDMF1h+0ScL30vqyNceDmu+/wmTJibdjsjWT9kXXjnCdPym2scd2jb9iUutPp/eQMCDSbXKY12NBz7lp9nKNvm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c4cULYsz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2235908a30aso115175545ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741162740; x=1741767540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6mp4Zaly8u6kO+fciu10UUkutxanQtH4VyeyGy5Pdg=;
        b=c4cULYszjZ1n/Q4PE18KkFU2rHPexFqkJgxmeQSj1EWgHgBOhnfhZES97knOMPx0vD
         M/9R0aYA6PRX2az77UqxYUrnWOFC8gjozGSGZyEU/AVePV9uNXsAlLD2hBYjde5Pb31f
         +5EXg0zJHry8MwI3pcguq38Je2M/wp7kk/AqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162740; x=1741767540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6mp4Zaly8u6kO+fciu10UUkutxanQtH4VyeyGy5Pdg=;
        b=AH1HxPNv7l25caBaApcLlKa57yyAtyXm3Xjmrb57CA8RU6Tm8KPEKQR2KfipMjktri
         a77ni2600s+iEhXPmaKQq5HSxz3RJcSffcByr6/6ooVH58fkWJ66gyA5eHE65YEQDOOo
         aKSjfyn+wyXlX2uvC/Fifzvaw/+TOPpPwv7ouD/F2dGxAc9jQ2DR8jMF0iKR4NvBvkeX
         BXADFnVqJhUEnyT6qUx1hjfnl5oRxvv8YLa+w5L71vd/WSpU6f2FRRHez23nJQO9E5Mg
         Uu6r40os0WFswHZ/gdsdiC8cQ3WmfqRzyEhk3qG8lQn3xyPLYkCDszmH7f7UFdtlIHXb
         Dxww==
X-Forwarded-Encrypted: i=1; AJvYcCVFmEPAgUPRQHUmjc6b72+3k/7+woh47lUPsXURE8KfQ0RjJxYydBHCjiW+XVfdgZzz39f9jjMMYoUL1D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4nw9BWlMjtPdj8RHibvSccMOgNiO7ZrsVqjSZSwfTad4ehM4
	OKa+CTQFCnuf/hLj3lwKuOZyFS1cLGW1n0qQZXZSt5b2P5J78kq6odXDKqipZA==
X-Gm-Gg: ASbGncuyWle0c28VoC1GvOyMspnGgebum2Dn6avbQbjzd/SM5BbM9Ng2jut5Q28lRtT
	OA2ox2QS+gaK+NbdSxnhjFp9A+EHuywHq2pmwR3uRv8NDXLkTwI12yVRnTIdcSImUT+keR+tR9Z
	IBAcDX24kdjwMTO/L4sEwCZLfkbb3d1lVj/wIgWC2v8NhyS9c/ukHri5nqsYqffIoPx25OBhTsD
	9jBX/gsCjTn7AHuAbRaPmhzMBUcuN4/M3551wK5kWKAApM0el1S74gnQpCpH49t9XYWwoA+iTEz
	YXqkVvmYNAyCoNbffOC7JGf59ou7k6++jH9T5jJXuLX21js=
X-Google-Smtp-Source: AGHT+IEl7oiX6+LAfRsKYU4BDDZlVQwu58gZp+1zl2ghM3W53UrIOjqAj5TObVpACgcwYJ3tTuZXww==
X-Received: by 2002:a17:902:d489:b0:220:e5be:29c7 with SMTP id d9443c01a7336-223f1cf42e6mr35406935ad.39.1741162740596;
        Wed, 05 Mar 2025 00:19:00 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5a4:b795:7bd9:7ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d35a4sm108348485ad.35.2025.03.05.00.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:19:00 -0800 (PST)
Date: Wed, 5 Mar 2025 17:18:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 0/5] Switch zswap to object read/write APIs
Message-ID: <2l3wlfwi55sm7mezjdlaj4imy7bsggjutnkbok6w53xw74i6pl@jluejgnytktk>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-1-yosry.ahmed@linux.dev>

On (25/03/05 06:11), Yosry Ahmed wrote:
> This patch series updates zswap to use the new object read/write APIs
> defined by zsmalloc in [1], and remove the old object mapping APIs and
> the related code from zpool and zsmalloc.

Thank you for working on this!


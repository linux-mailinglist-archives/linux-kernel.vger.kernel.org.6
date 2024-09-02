Return-Path: <linux-kernel+bounces-310560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81888967E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D92821A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4DE1494B3;
	Mon,  2 Sep 2024 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ats43WXn"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C8A32
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725250305; cv=none; b=sqDidCODF6+JcswhVvSEuCjNDTlf1KyAbjrRzP1vHVUsAmUdTtiBkOGDlAjIypb6FwNOp/3QtT5LFX57J/rT54Xn0OGQfi365eBRF1CbCTZJ6/sWD+QFe/nCTHaLamSmN0LX+5P7jLCYGJTURPi9YFWEPUrBaeHIoDdf4YCpCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725250305; c=relaxed/simple;
	bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3qGV9ynpOSmMG6XJOHc0ufrZKKNhcPizcJLHYuHLH87wbzrsBVm4WJR478ViQWymZzxQspqFyJ4u16w3Nea2JDJrSfj2f99OyPF6NErSAvg0K7Xg6v43/Jn1++y3NGu7wzp/JYmfMabXxSrxLBkbo9tSnVs5ZPZ1WeUYdf9qUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ats43WXn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-70b2421471aso2009349a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 21:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725250303; x=1725855103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=Ats43WXnWxyY6y17ZWFQzbdNtOKKoS2EO4g0v8E6UMD6DvM+wLrVRBty+2/4X/eLu0
         9HZrgcvywEI4IfGumSOQAQroLQYTajP4VYkPYT1dSisMokPHIBAiS04NErtBd6+CRM9M
         Bb3o3QISiUc0FtmWGAK9Hg1bCpN3PPjQgkn7fYcj3u9cAmYim4D1gFGz9TIFTWwrCRTw
         1iz01fqbw/GtN5xOG+dCc8VTkxPttlm+EKSX9023M15eQHLhITU4DXCY0wDsYeMThjmO
         ycD3FklA+iZaV7CK/B4gjxNI7yu/egOJerG4cRx3jmDfFAOzQBqjxLDmRW4GP6XHEI43
         X+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725250303; x=1725855103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=C9ZI29K2H2ff2a/JowFPgpm2zPnkWaJaaRk+xx4YZssty+EGUu594umtzfxnOHIiXX
         w7z6f+JhzUx4BA5RPtKRFcKkHUb4Gxr96jTHUsDVU0d2Q6Dd52t4peS/yDO+PCcHqEwg
         A7OaDAczW40I2vCvhJBgFmkomi7jCbywUOSTtaHdr1twIGrSgOUltn0O6CFPt7oCsczg
         BHoNBz5kg2SML9MZpxpE/SBevboAnAT5N7lOOSy6GReGXxgaAtAQrzRawwHFspZhkYUp
         vIbN+/nKG/xefkjT4W7ZKZWj7kxG/y/IS4MT1dP6sGZtignnN3ovP/vLdoslR8Bv5WKt
         8kEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUZEJGjiiYfpkZgD1d5P7W+4Tmj1oYWwgW5aAWg572XXz7HEICswNxRpsFTLCKktrKZue52d4HR8WGOA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKLqlydpZAnGLnY/q78fUf3omTn04fPOJxzTL+ij3NV/HhvBs
	NPJZFw6FxK0p72N7SHxrLklcNJJrZBJlOeiiQbK3F4Bj29ZlEUf1oFBmaoWffYEt3/vbyJ+heip
	5BU56XUznKElVdpA2E4uvgfkEoIgdGxhAoMJNQvr6wezUCLLTIb8c
X-Google-Smtp-Source: AGHT+IErP80g0TsP9SLnDEA8znXKCZFsQKgYrAPROqAoutzo7mYcs5UeyLpD1pkgx52HWZCKAIeg/oiWCN9HxbfP5uo=
X-Received: by 2002:a05:6a21:6b0a:b0:1c4:9ef6:499b with SMTP id
 adf61e73a8af0-1ced62a0dcbmr4201357637.29.1725250303019; Sun, 01 Sep 2024
 21:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Sun, 1 Sep 2024 21:11:31 -0700
Message-ID: <CAB=BE-ShG+2o88LTDi9Me47F=-qh-NptQx_H5ch+eXkT4p7B0Q@mail.gmail.com>
Subject: Re: [PATCH] erofs: clean up erofs_register_sysfs()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.


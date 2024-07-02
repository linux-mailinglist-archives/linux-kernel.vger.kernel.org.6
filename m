Return-Path: <linux-kernel+bounces-238046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D88D924299
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286AB1F23D21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4231BC07A;
	Tue,  2 Jul 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EJlo0la8"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F331BB69C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934869; cv=none; b=C34xiGRZAZeVsImDEyky3dKnWPfbh63HtkzzzPmva/z6Hne2O/Qiv/gKgnt23fVIVkh5YDsrqf2F3P90W6+7nMuMVGIH2cObBq6QZ2hE2r3MnBnSHWfoqjpLlom9dBG//Rex8BgrBtfoWzL4Izz5eDYlt2s8tL1RRDnvBf54iW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934869; c=relaxed/simple;
	bh=3iFFFMShLQ1EZrUtj0wlYgM/8EAXOVw7Zi303LuWzBQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=gaUTjr+nyQRaYJbK+Bt9L4+wsFOr/SJQJXpbqp6GBybocX1ah56T6/FkW19FiFInEaeivvqatk+myNuMn8THtQV1ht0MUqXbvXK4PGbsV/oPYgrJntpna8MI1eXPDrfp3NYpwJ35RoQXVWqtgvk3lYMY+0F7gzg1px2mTxJCjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EJlo0la8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b06e63d288so20008726d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719934865; x=1720539665; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OP/DQwYrCVrITtYRx3Ev8bw4+QSb5aJdgZyh0buQtdo=;
        b=EJlo0la8WdzZfM/rr5q9wWBfpNnie7SvB7W8xfh0TvWkSvX9zn3BZD9KgW+TkEBVfu
         TWH0Zs8pPxPkF4hEMr9irgrjMP9m6q2lUrSETtF7niI4pZla3gRd/mESGHcNrfh5Wr2A
         P/+3zqx0Ic3fKGy+oBZJ/60pNf5BvbVSv3BMTIwrQeyXIQgxlXUBb/uzp1VMU8ImlVa0
         vGolYCBKcqSd/vN88USWD7t0uzSPJOuCEB9iJV4MyeAu+BGPJucFZKMhbi/agfLWQH53
         2uyq/XcgcZho3oXl8SwzQ0kbvHN8YOvKhyNjVP63Slk2/mifWPZNJMO9HssFipNMx85J
         qCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934865; x=1720539665;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP/DQwYrCVrITtYRx3Ev8bw4+QSb5aJdgZyh0buQtdo=;
        b=lG7d3c2f0cEjYf9JuO8Ve+bbwk7JMfnUsdCKiNGGqBU8WcoEhaoN5YnIGD2Jim8XvP
         q39dlr8EC3mb/8wnnikJUxNszpVdmReoERcOb1RIY4/+e/dxJ1jpeneIBeqDx7eHHIa6
         O7LWUvZ2La9yk9yw4v/0ZScU2RneT78JVJH1WInSmc0+3evgaogtahyZxw9RzmPNZm1K
         F4XWPrU8K2KdkwNkSZLpykEuJLfUHFJXCm9RAI+Follc/d7C+2mFEsDhDPIweRtG0pPM
         uF1mTxlwa+IWen3iqwKk+PeO3ouGZlZrbtS6LtAw37rppcFR6I5kl+I5LIMWwhN67CqO
         nuwA==
X-Forwarded-Encrypted: i=1; AJvYcCX63g7Gyfby/16oumVyrbF2bbfZrqFhudGnzGAf2Q0goi3+Kye7B8uDP1xr6M6m7S1+llkDIgCkr8DDQgpJp5TFuPh37AP2ejsZ3bAR
X-Gm-Message-State: AOJu0YyRLk/g0evswqRVNzUEcafQgPZys4026XMSFUlUFprE+abOYI8T
	KWDQoNSlvNwQf9IxkMnx+W6N1wVw643AM8uM+xDuHUnqD5lt5gRiogckGJ+oDg==
X-Google-Smtp-Source: AGHT+IFo837CZWVrAhqw/4vbVYvDWAFGqECphXob0gkVGdbXPaXQhe/r6vlQz4h2Yib18TcMgO65/g==
X-Received: by 2002:a05:6214:212d:b0:6b5:26f7:76b5 with SMTP id 6a1803df08f44-6b5b704eafcmr144055546d6.7.1719934865537;
        Tue, 02 Jul 2024 08:41:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e721e9csm44805766d6.137.2024.07.02.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:41:05 -0700 (PDT)
Date: Tue, 02 Jul 2024 11:41:04 -0400
Message-ID: <d5b7485edf9a4cdbc85b6b191b00e572@paul-moore.com>
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
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH] selinux: Use 1UL for EBITMAP_BIT to match maps type
References: <20240629041012.156495-1-guocanfeng@uniontech.com>
In-Reply-To: <20240629041012.156495-1-guocanfeng@uniontech.com>

On Jun 29, 2024 Canfeng Guo <guocanfeng@uniontech.com> wrote:
> 
> This patch modifies the definition of EBITMAP_BIT in
> security/selinux/ss/ebitmap.h from 1ULL to 1UL to match the type
> of elements in the ebitmap_node maps array.
> 
> This change does not affect the functionality or correctness of
> the code but aims to enhance code quality by adhering to good
> programming practices and avoiding unnecessary type conversions.
> 
> Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> ---
>  security/selinux/ss/ebitmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this looks good to me, and it's trivial enough that I think it
is safe to merge at this point in the release cycle; merged to
selinux/dev.

--
paul-moore.com


Return-Path: <linux-kernel+bounces-405525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F719C526A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7CE282739
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A307120E021;
	Tue, 12 Nov 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsRA11WW"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C73B20A5F0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405017; cv=none; b=HBkEaxpdPzB7geSZrF6htMR1ijXSdz52fCriKR7+3frJtClL5KwVCXZYcb/Ks19ToV8CRnm+kdyfZFTovlyl4aVyvP5vFWBZrtrixug4PQAYAGkvq/iyZ3TSac+U2jHYq/RYqYLm57XVy6u31L34Lbbs+Mtft/E20rbwwm45ixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405017; c=relaxed/simple;
	bh=Y/rRZRdPGOh13wg6OGBvKJx4vURpBXh2L+2i/dPCq4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc6Ies6+cdJNm7cbp3eFBoH9i5D9zzq5ycpfHrLK2oOT4ouHktlzROcWW1e/uzvZ3q9+seuMpXeMFgwifaTAk7wL1AnogIe+Px9E7xzZV4VccxNnRR8U5sE1LWBNVvIdfAuIEbfwd7PkUdGQUg/xrQRqY2YrIfc0Yf+A5Y162cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsRA11WW; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e60966297fso2499411b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731405014; x=1732009814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/rRZRdPGOh13wg6OGBvKJx4vURpBXh2L+2i/dPCq4g=;
        b=JsRA11WWWSbr2YPtYgSpoWHJF7qT9EqVvCIOBjE9gyxof4oIHlN6FVwylDJOW6arAt
         3b8E+AlTnYzx2WCVsBXElVLlNi+5J3+7mT6bJM/YFQgklPFA7HkQ7uOac4QgBdWTq7FE
         wolnantMmCxbxwUhhcB5jjYUOQTx2jrjc6T7f8r7HeRJYcCW9WGZ4CF8sxt8Kskz4zQz
         yo4FsZ4yqubCbeM5suM82G1UPLZD0xBsBDHmx7vtYspg7WTbOc65qhBj+ZcMIXOhJsW/
         rcS4pdTeZvvjLGTVF/ufpqOQlaSMMqfJ9DeuzHVcFRtmaJy13zVYXn333nZygBzH+x3a
         0EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405014; x=1732009814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/rRZRdPGOh13wg6OGBvKJx4vURpBXh2L+2i/dPCq4g=;
        b=VxlTb7C5pL+1veRA0Dxy/XxGXMSJ8MiP0jxlcTB++KnUgkixPNxArNOAqsiKVhMuiR
         qiDMx+TZhRNLKBfKfw8KOfpOkvGkh15sPIJEKJ1jsNndL5yTtaNsz0z7Id6lfkbi5WBJ
         50tHmhOeX5gjhSv/aC77jpil2BFECIQRv5kjuF79q89W9UyiO6pSzP0yrVKkUwpbc2Ly
         lCju9LdaKzdQgTmySCDQzptvEPcu9xC5TcTC1euyctuJd4FnfCiPAeGlS3anvAfhhGPK
         ia7xVX5PhGMDQcGrRQF/Pzkfw2ESkZUuWexAW3T13PXYhn4RHR1CnbMuQqszelNlQKgv
         8ZHA==
X-Forwarded-Encrypted: i=1; AJvYcCXe817qblW7IetX/z/Ejg5swOl9d/c42LG38Daox78by0rIKVBWDOzYpbF+4djVrC0IVS7BqetBPk20Ndc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJO4+8pACk/6x4PGuar60mfXswJTJvJ9ScVo8qAnSN7wzNpFx
	3fe6hi5bfgzl4HdH4DKtHEfXFEXNm57JL7EJz+cfDNUQtBgNe9hmou+yVQU3TQETP8zu/L7AIL+
	SEPR3EmqsiBPnGpeDNfgW0XlwUAI=
X-Google-Smtp-Source: AGHT+IHR0Fz5SPsGfGwNzlXiz8bcrqKJTj5No1+v30lvCkLJutr+xVp9ib8IEp8U0j/HTcbf/wcwAsS1dlXKLo8yccE=
X-Received: by 2002:a05:6808:1456:b0:3e6:147:8bd9 with SMTP id
 5614622812f47-3e7946a525amr12693464b6e.18.1731405014606; Tue, 12 Nov 2024
 01:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112083921.283923-1-luoyifan@cmss.chinamobile.com>
In-Reply-To: <20241112083921.283923-1-luoyifan@cmss.chinamobile.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 12 Nov 2024 09:50:03 +0000
Message-ID: <CAD4GDZyJYrWt4PPAb=9JEuv8m1QOKzTC+RF1kw7iaDTy+GGTBw@mail.gmail.com>
Subject: Re: [PATCH] ynl: samples: Fix the wrong format specifier
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, edumazet@google.com, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 08:39, Luo Yifan <luoyifan@cmss.chinamobile.com> wrote:
>
> Make a minor change to eliminate a static checker warning. The type
> of s->ifc is unsigned int, so the correct format specifier should be
> %u instead of %d.

You should include netdev@vger.kernel.org on the recipient list and
the subject should name the target tree, so it should say [PATCH
net-next] unless it is a fix that you want to go to the net tree in
which case it would be [PATCH net].

That said, the patch looks good to me.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


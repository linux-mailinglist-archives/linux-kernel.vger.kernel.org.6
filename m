Return-Path: <linux-kernel+bounces-281257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63D94D4E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5DFB210BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125BD1CA94;
	Fri,  9 Aug 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HtzYKJt9"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F61CAAC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221730; cv=none; b=Mbwa3kANMqEpnXGqky100jig63j1v1vbTW50v2CaFW7MujkId/moUoxKWvK90JzEnbyqd+9e7fDe9q8QiD/4yIvE6NNWklC4slK4c38BMgXOs0cb97w76mDx2Kz8SKKJxUk3GvA+OM1GwRGfldPFJ4hC/3cILBx8414jSmao3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221730; c=relaxed/simple;
	bh=5QIavNohw/UnZ+iYVJ6jnEmILfZebfqlufkySWpOPPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tim+or48NTF89GOZ2GSTY8BljP0ISkD1y3WI+nshCV1WuS2xoeIzSKCFparCmNCPZ/Xxbh5rlIQ2R5qokknIWA+pMfZZQFQdDy+N+Xm/eehtjq2KuJrgnJPuDg+p739oDM2gYtiVAMS9SoiaOKz9VspzOnED5j5KPxnuUZz4hKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=HtzYKJt9; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db1d0fca58so1497250b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723221726; x=1723826526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzuVtB2v6flDP47Da5zBNwElSW8197o0ha4r0qeCzWA=;
        b=HtzYKJt9C7sbG4xnOcF8wKLM+VVy1kiDVyELmF/4Jpoh1+q8AtCS9A5fgisS6Dhg77
         6pvk4DU3c9ZHMBWg+Pehnjx2n8VFu5rceBdqJouVrDVlmVS3HbejqPHIC7Sy2vUb3zhh
         y6P1lCLTX5xbv4ZxM2xErVdeORhoCF4nQUndL3qJLJAZ8DT8eQ6JULKDJVEM3jIJTbKO
         06/wIlgDOpEQmwe/0lKq8DEQTbVwpd1gcl0THqeIeMfPLYbWBhS0X0JrMrh/wfdSrT1g
         Dm27GxgNhmbFLv8oTvkh41khW+m/NjuPYaHR3gmWs0lAnRmxOUWSs0efyLSiqtzGL4sv
         5wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723221726; x=1723826526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzuVtB2v6flDP47Da5zBNwElSW8197o0ha4r0qeCzWA=;
        b=G1TwpzwLfqIfTmXaYCU0NhYz9NOkBMwXDHqlz649C1yJDwfvAr9dYspCHRosUw32rc
         tuFKxoCTW9RywxiA50T478HU1TkeZN9eCrSjCtLiatRQUPiPyOMQAFjU3p/CGQELun+z
         XB9O1w/9sNl4lZj/BLp4ijE1Q9tf7srJKuae4iDTvTYnjj9awys4p6wJPyCuupd7hrf+
         fx8ncDhpo3dHi771ijvteEJzRRAsaavLVBuEV839tikRnFSz0aCx7uLkecrwTFlCN2pt
         kDcm9gNPuPv+n4pHDfGMo/QCl0ReD3kPVg3c+IkwXhOVIOwpOW68s5kPYdvcrXDUnd3R
         0wvA==
X-Forwarded-Encrypted: i=1; AJvYcCWhHbeEffW28lmzSONQTLuCMn2WnihAXPJd5AMZp8kN7uBSQXeLzIWYvfVQxFIDSGryiyWHs5nE7JdTUnSb2tzGfKaVLrFKuu4uTo2t
X-Gm-Message-State: AOJu0Yz3ykZmvVxdQBJhsp6vNyTdeYJo4BVWYq63gPZ0mCNBrPh3EOZc
	unLbWu45AHY3N+9nvz3+YcbNP37oR4I6atUgVyTnJJGfgZA39+rMTmM7HE40Cqs=
X-Google-Smtp-Source: AGHT+IHSihy3BzUjozeYZvvsK5K12DhAcqxa8bU0v3dyqc3p2o+V1bmf3nTK94hnjncm1DJo6yMPJw==
X-Received: by 2002:a05:6808:1453:b0:3d9:e22a:8fb8 with SMTP id 5614622812f47-3dc4168b248mr2480400b6e.26.1723221726620;
        Fri, 09 Aug 2024 09:42:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2ccf1esm2820658b3a.129.2024.08.09.09.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:42:06 -0700 (PDT)
Date: Fri, 9 Aug 2024 09:42:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] UAPI: net/sched: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20240809094203.378b5224@hermes.local>
In-Reply-To: <ZrY1d01+JrX/SwqB@cute>
References: <ZrY1d01+JrX/SwqB@cute>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 09:27:51 -0600
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end has been introduced in GCC-14, and we
> are getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `__struct_group()`
> helper to create a new tagged `struct tc_u32_sel_hdr`. This structure
> groups together all the members of the flexible `struct tc_u32_sel`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct tc_u32_sel` to `struct tc_u32_sel_hdr`.
> 
> This approach avoids having to implement `struct tc_u32_sel_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> So, with these changes, fix the following warning:
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h:245:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Tested this with iproute2-next and clang and no problem.

The patch might be better split into two parts?



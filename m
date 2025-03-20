Return-Path: <linux-kernel+bounces-570014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A4A6AAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21A77AC46D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811D1E9B29;
	Thu, 20 Mar 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeFA3Okk"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19B3597C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487097; cv=none; b=hml7s0nvvehE9X+d0pUNxynKgPZviz/0nU34TpZeLS72lp/911t56c+xujNKple4mXkSL1r3CYLoaQpAVcYjugD00Y0HIrRRHz95n4TEXuqeY6rz58cM7JWBYTGnx3vIEUaujr8dvMDsP9IARptvnC/J16mt5Ji9kiGSbP3VBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487097; c=relaxed/simple;
	bh=glSoqDZAzBMqg6nsMS7oRJUWUIME9ngmiokB0oK/U7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzJO6Mz+hojKJAfK8JLS2xrdWxu2XVox6xl0W3AZUTI+Jd00P28AHAVtRkU0W/xnDXjOqyIlvXZqNA8wHjku6c4QlfCvqBMBnCgPpYSCaw0We2FjrVOJd/gSUMXM//kj32nxUGcZ0euZNjftaGXVmnpfn6hCXm9dEaShYq6yjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeFA3Okk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so280675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742487095; x=1743091895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=glSoqDZAzBMqg6nsMS7oRJUWUIME9ngmiokB0oK/U7w=;
        b=GeFA3Okkuetr3XPEe8abSN0UP2XiKo6jKjTzYwU6Y4VefE/QlQsDYXBdjMXrePxIhg
         +TOYRlylB6pBcBa9NKnfPeh4RP4CASLPGpouLTX2lhTuKM06wrC8Yzg28eNwj+VtD6r0
         K2+r6LZPHT62i9b1UpsDGFc8Fb8ErD8oxZwvGp1A/d0UTWR6NsqtH4gw/sU6hb7gzwJi
         Yb4r+hBhPLo+KPsRWNXxiKxIqUczA5BdGn+j+561FARSG67opMVs9Iugz62LpXK3hA/r
         EX3gaHeWi9QC5LQmUIKMze5RS0NGJAHlEDcZuMUG1P2qIefIb64/DL/RaYtiiwGV7EF6
         tkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487095; x=1743091895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glSoqDZAzBMqg6nsMS7oRJUWUIME9ngmiokB0oK/U7w=;
        b=mdRjeet3umPcV4JVLhCnxGOzAiGs1SwDQP/SNO009/BFABaRCDiId7c3uLsUMFHwgx
         S9aweXZ0hq5+lnh5AYi8XquJzqkaoNN6+06JDcKYtKka0rZzMEfZO5G77YodQlRAH5rL
         a3vEJu5HospdmIZrYfD1mx3mxuHVRx4IMFQ22QcE3PD4cCPaPUJfdsG4nXv5GTeSFo/s
         i8Z00ya7NWVl59gZ8MGMVNeapbfVubLpSjvZcn74YXpRavX2VZQ60oPZG3a7sTKrQH5y
         q8c0/Pm2DklxeNb+7WKX1eYoPcW1Ef75fPaWzdpJ2FAzFuzB/ukJ7WjjyflWYPQYjlBS
         O6xg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFwr+yNKRjQBOcB+uPZ727TsQJtixbm6Ql6mkb12iy29/4qgTgpuxlW2YGcVT3/qd7cRkUb71IxZp8q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7L8O3qoJ9qLWFwiS0/n4tSP3JtIfNSAZ61OAeF0eNkxu0Juxo
	aL2TqdEd87X76y6/D2H6vVhUZ1GVCenIwIc+tvlJRE3bFPcCOrl/S/rM0r/K/g==
X-Gm-Gg: ASbGncsDkPUq/iN/MBwPAx+5TzzYeSudPJKPjVKNVivQfK6PwtUc0nC90yN6DCIKg+x
	Ox9/xgxsYcFeXYXCwae4VpLiHnGSCAmMyuoGBWFLatmX9SvqTdwtCXFAWv4QmsjJv56lICngzqm
	aWVqauyON9lyXS7h6qvn9CT31gtXNBqj3uz36f91zIngQrNDO6/vAKuUM2j1SZHDlzOLEJ2c/G7
	Iu6QVbqUSvgYrv9zzZh8ByMB5aYegRHQ28EB6a81Ac2EVRPLyAo3xFZhHefMCXxaLLMr5lQpCKh
	pfEJdeecDLMscZqCnqW1SFMXUn17pZLtKUi4sjZT2BG5LLshunxbbDodoC/uymTQAwR4PPA2W8R
	30MjA
X-Google-Smtp-Source: AGHT+IEfpjMfiVX2fXM+TlBxOif2fyOsNesOgkoozg3ezdu2/TiGaUrZzmgVyP8OIYgxf6XMcu7F5g==
X-Received: by 2002:a17:902:ecd1:b0:220:c905:68a2 with SMTP id d9443c01a7336-22661f4e49emr2872845ad.5.1742487094690;
        Thu, 20 Mar 2025 09:11:34 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576884sm4110029a91.1.2025.03.20.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:11:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:11:29 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "zhangxiaomeng (A)" <zhangxiaomeng13@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"J. R. Okajima" <hooanon05g@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] lockdep: Fix upper
 limit for LOCKDEP_BITS configs
Message-ID: <Z9w-MVjD4olLlKDa@google.com>
References: <20250314064729.163602-1-zhangxiaomeng13@huawei.com>
 <Z9R2a_dX4YtK4jJ9@google.com>
 <629305cc0e6b433d90354fb22d3bacf1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629305cc0e6b433d90354fb22d3bacf1@huawei.com>

On Wed, Mar 19, 2025 at 09:48:11AM +0000, zhangxiaomeng (A) wrote:
> Thank you for the response. I should clarify that the issue occurs when modifying additional config values. Specifically, when LOCKDEP_BITS is set to 24 along with setting LOCKDEP_CHAINS_BITS and LOCKDEP_STACK_TRACE_BITS to their maximum upper limits, the build fails.

Right, that's what I figured. I don't know that bumping all these values
to their limit at once makes sense. I think allowing LOCKDEP_BITS to go
higher independently might still be useful so I don't see a reason to
change that.

--
Carlos Llamas


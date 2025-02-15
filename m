Return-Path: <linux-kernel+bounces-516310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF1A36F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9563B014C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1FC1DF24E;
	Sat, 15 Feb 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjBMODwL"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0611A5BB8;
	Sat, 15 Feb 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638143; cv=none; b=mzmlYIvRxcG8u1yBnT7EbVv1QKDRC/gBqRBAKVC365sa+VmzbmdkIqM+7UDcDMrhPhlhKSER1GyQyMCISR16C/Z5XEC1unZ2hPMnBIWAXmRt/FYfMotdJYS67iBxat/yEZyyRrlB3CRoQqILY+oy8f4G3oBGWaxTrM0BBoiJHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638143; c=relaxed/simple;
	bh=HVAL9ru94puSezllFDIDCoPNctSb1ZH+rX/U8puaa/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afo5wFafz5lHHlVvtaeGmmfgZciTE5faIsozcvi1yBZpBhgvl/upjZTEoBn+KxV/YkzgUxT5ZODqIlc6IaZzZecnxz+GRHQ6H6v7OOcPr3lsmt8bZe2HyIX2JrPOeaj8CrUj8cAX6CECQ+fQGinraT9egRQLFtrIybeBWa6LZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjBMODwL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22101839807so22809135ad.3;
        Sat, 15 Feb 2025 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739638141; x=1740242941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPGJ9JBmiW7qtQ5ux5F+jqPk72bsvt4NMGySYgb6ZHU=;
        b=WjBMODwLfBv5l3Njc0+i0zUfJYd/GrWb/TGQXre8Cf+UDb4VMUVS9ARiUj5WAzYa1J
         siraPerBkEx++KXUXNbsvIMO/l8LM9Qd3GxJ8fhw6z6yb1Hh3NrRl3VvluNYlYJInFrh
         vh98DSUm1THKYl4bkoygjM7Afk/S6oQf2Csu/qdXWf377tx4JmjZKtv+UuetW65AYOis
         b3ZWJ8VAc3RgABqBBYkVgBf/nPtYxuwG4vAom191wbui5VrI6d9KkAJEUNYHtegSxIdv
         8BedSRAwFZT91WG2zj/BCA1Qxiu+BLAWStyurRvasAoA09dMcU14DHhE4CIBrNYoJXYU
         lNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739638141; x=1740242941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPGJ9JBmiW7qtQ5ux5F+jqPk72bsvt4NMGySYgb6ZHU=;
        b=Qvdsg6xvQ9Ql5G9UoBSHITYJZQ9nGDEoR6FW8hsZ/+TKiaZbNa73nUId9qkbkoKCwc
         sOS/oE3Bzhs/kc1grrUenmaGccxOz8njyOtVdMZL4uPgxflLcZ5brP4c5tREX4tE7QT0
         qqIQwhrzrbHYku+Z87D5UfF4mBOifXOc+PjSYbcD7kL6u6Rysh3FB7nqHFO7jQLoMHC2
         9nM0aHBVNn4YciExM/ojf+ZvaOgbQ2NWKYJ4sGlE2UE8Iwj8FuyaEHbDWhwB8JttZ8gU
         Ygd1sOI40eyI2z0SvKlY5ks+rh/cCevBHR4FVMc0mUnzxYpp8EUiJLzX6oQcG4kY30A/
         uoHg==
X-Forwarded-Encrypted: i=1; AJvYcCUiu1GOiOzMmQwiehtMgJrOTaHVrTvmLMh28Vtos7qQUxz9POCMe8y0e/A0mlmrkDfTpdRFpkTdWzY=@vger.kernel.org, AJvYcCWsyXtlgju7cmA8zhiVDoVwaM/ag3ovY0p881vYQFAMGv+oTeHw9UpHb2iknlAQ0I1OiFNLO8xZI5kgiR3U@vger.kernel.org
X-Gm-Message-State: AOJu0YyTiGLikfQj5t83RJEH+Ge3+rJn3nCX6rOpfdGFM76rRg7xf7x7
	gUw3q5AmMaR/fAjEBOcgZ16Wr35NxoS09Hfvv/mOxtVaaDcw0yETyGNArA==
X-Gm-Gg: ASbGnctJfIetu61aFtYJbklNHQUt5wgFS2j+RLlVXGWy5FDDxhvNFj0F7Y0OEkMb0cy
	CuwBmjOvuEJZMsaETUpYtKrEGpXUjyoGW20En89IbcsLrr5ZLKRDELvyj6VWLYRUIBPMneq+cgo
	zI1npowhYHndtFTSZ3Mn/xgWNRLCqDMV7ZcuZtNjuWVZbX86NsDKA6w9M4ifZkeRnEyXjy9jeyd
	/+WI+YEuvJ1RFgpI2hK6aQVZWk4emNfsXsPIF1RtZBk2/Pk5qmlPGnCT+6cKItba5jO8yqSMG4x
	hDmE6YE97tZEwE18v8ciXxyJqSxngHZfmXwsmjcnFfM=
X-Google-Smtp-Source: AGHT+IEj8gf3+XYJPixhJpI54JGODKeCcZ9/YJAgyLMuO6i4t/LqgX+0Kq+mg2rqlz/+Saj1yYrOTg==
X-Received: by 2002:a05:6a00:c87:b0:732:a24:7354 with SMTP id d2e1a72fcca58-7326177e6d2mr6184261b3a.4.1739638141249;
        Sat, 15 Feb 2025 08:49:01 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324277f388sm5231655b3a.174.2025.02.15.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 08:49:00 -0800 (PST)
Date: Sun, 16 Feb 2025 00:48:56 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: akpm@linux-foundation.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] Documentation/core-api: min_heap: update for variable
 types change
Message-ID: <Z7DFeLANKM1X5uXR@visitorckw-System-Product-Name>
References: <20250215155421.2010336-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215155421.2010336-1-eleanor15x@gmail.com>

On Sat, Feb 15, 2025 at 11:54:21PM +0800, Yu-Chun Lin wrote:
> Update the documentation to reflect the change in variable types of
> 'nr' and 'size' from 'int' to 'size_t', ensuring consistency with
> commit dec6c0aac4fc ("lib min_heap: Switch to size_t").
> 
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>

LGTM. Thanks for the patch.

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

This reminds me that I have a patch to change 'int' to 'size_t' for
indexes in min_heap.h, but it hasn't been merged yet. I'll find it and
resend it.

Regards,
Kuan-Wei


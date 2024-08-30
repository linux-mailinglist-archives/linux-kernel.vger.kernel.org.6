Return-Path: <linux-kernel+bounces-308982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A1966499
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888D6B23D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856891B5EA2;
	Fri, 30 Aug 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5gCEjI8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777091B4C2E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029557; cv=none; b=kDKXo6TpVkJtQV9/jUAjvOcgM97h3z2FIq+smQFxEEKsb8ycWcx3s54R2V/IVfCb759a+ibfoLXfWxqc/tY5zBplVMEU3vNYZ3WyERCq61WOqFsv3HNVZFQVyDIzTtXUpKKb2N4KHo5s3DIzAxjhN1c0nM3TSLG9pAgpjn682VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029557; c=relaxed/simple;
	bh=FuDLCEncKPaeV9pVCsEMan8OdEXT5DPU7suVJu1eIzA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZc5lKyogrXx5IhBYf7McMkQKFAI9rmwGMdbya+S8wHLkCuPdQYwAkODAuL3W9/DUF0X8nFCQT9LeMGGZZ5d8GC83C2Uqru1pNWN6AyhyEf6Jm3rP6iA2h0p7KVmttM3U0eyvipstU2U4yYIWGXDsfdFCGf0dwqcaxGcPZXd/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5gCEjI8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7142e002aceso1621864b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725029556; x=1725634356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l43nUavHxnAn2/Q+7POfa5kpXTQFK1M94W4Oz0qeZQE=;
        b=K5gCEjI80O2/aKxui21k6jeoSpYoD5SWmbqkHtSoZ5LLABh5ArswK3qXIWmmuxtCj+
         PZWq6G94Q8LnfrqSCVZW6C4kicjFSAG1GuFgKs0mWBL5DMxmxontAVh3QkiQjMlqahFN
         +AyieAzaIXb1f8kUL120zgASrvjw21h6xY+cCmN4LSltBlyiTT9mAG7n/ONSUhalnQFi
         AZK4CL2wjBwc82S1O6kddSgM87yjaC5rOOqIq9ip96igcPh2PPYLIEztbK/7s146ax3v
         w38mftMLfzuqH7833aRzKD8Fkm0Mk5Zpu5ybGte3tF4AVhbLPZnVpZKfLE5/zou5MxC6
         u7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725029556; x=1725634356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l43nUavHxnAn2/Q+7POfa5kpXTQFK1M94W4Oz0qeZQE=;
        b=v9+DV3xjCPXVyZuV3pVbEcfRZrhmb4P5lBJgqoYjB4hd4yJL5pTJMcNoFjtRACmnS9
         NmXZQI3pB/4m3auukRFi+b333h0W78PsDV0oSTS/tCLHYGPf5sE69XKRbGfwEJmoi33z
         5dVaSrHEB0XrvglU0GFOBFDsOIDm8T+tAniFxdnWuAQL7h2s5PPWlUnU8j1U612kFjhc
         FCohvwucmqe9hLI/jb9mJMwu7+y/RX3QAsd4Tl925uWZMnw9RGAe7/z4I9IcZqlYS6oO
         wx+IF0hptBLgr/l0mundGxUAASn8X2kZMroFF6pZ81pjJZu9o9S+ruDHJCWjKlgthoR9
         Imzw==
X-Forwarded-Encrypted: i=1; AJvYcCVNOQAzStBbP+lfnOyjZtV7RZV4JuX6HC2ueKbiwB2bEINMj7pMd6rFpww8gLedFFLQzY7mjSF+CJJzm5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkKPITyTFGC8FdwkwRhksWUUmR9XbDp2TqMeK5qgg9p3OM+s3
	WjcGKtvofth5Gleuh2RU9CW7t6mEibs+9ZET3qwBimCKW38/vAssDIKj1g==
X-Google-Smtp-Source: AGHT+IGxHY+6Jai4ZqwKefEHo2BiPfqhaC3jiXpWGV+/fyWdBXLOrdvc8VAZ3rrnNkBeBcUytqFPtw==
X-Received: by 2002:a05:6a20:d70f:b0:1c4:bbb8:4d02 with SMTP id adf61e73a8af0-1cce10c4d57mr5637524637.37.1725029555625;
        Fri, 30 Aug 2024 07:52:35 -0700 (PDT)
Received: from victor-IdeaPad-Gaming-3-16IAH7 ([116.68.77.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569e9bfsm2847966b3a.130.2024.08.30.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:52:35 -0700 (PDT)
From: YOUR NAME <vivek6429.ts@gmail.com>
X-Google-Original-From: YOUR NAME <username@gmail.com>
Date: Fri, 30 Aug 2024 20:22:30 +0530
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: rtl8723bs: Rename function SelectChannel()
Message-ID: <ZtHcrs3GoRZJiLjS@victor-IdeaPad-Gaming-3-16IAH7>
References: <Zs8WLkzoZe3Z0DYF@victor-IdeaPad-Gaming-3-16IAH7>
 <5cbf98cf-9b1a-455e-afcd-b0cdfcf1aaec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbf98cf-9b1a-455e-afcd-b0cdfcf1aaec@gmail.com>

On Wed, Aug 28, 2024 at 10:25:56PM +0200, Philipp Hortmann wrote:
> On 8/28/24 14:21, vivek t s wrote:
> > Rename SelectChannel() to r8723bs_select_channel() to avoid CamelCase
> > warning from checkpatch.
> > 
> > Signed-off-by: vivek t s<vivek6429.ts@gmail.com>
> 
> Hi Vivek,
> 
> the description can be improved. Please always consider that checkpatch can
> be wrong. So checkpatch is not a justification.
> 
> I propose (feel free to improve):
> Rename function SelectChannel() to r8723bs_select_channel() to avoid
> CamelCase and to improve cleanliness of the global namespace.
> 
> Thanks for your support.
> 
> Bye Philipp

okay, understood.
i shall change the description and send again.

thanks,
vivek






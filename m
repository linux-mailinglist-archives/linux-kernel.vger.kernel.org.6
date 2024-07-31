Return-Path: <linux-kernel+bounces-269637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991AD943529
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA841C216E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE338FA3;
	Wed, 31 Jul 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htwL4AhL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7A2E62C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448120; cv=none; b=tYppdbAtWDc3v6Vmy0/C2gx6FGwcLdROsywqr/LEYnJ+mJOAKVNFUSNI15nzerMX1iR8nU0pgSN2CHfQytakxwk6g+ONPh01vjIyNtPVq1m1OO3NNFaqsJUDdMycLMKoTK34qjLX1XhwYmLtaUSkVBLzcgk+ZQiJQPl15pQxiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448120; c=relaxed/simple;
	bh=UILyAZSDo3HDsvBVZCPkEUTCtBxRDbWPoUQHz+eJhcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c95kOeMZP9pk7t2xMGBmJRM5wtai/1b63oNMhqz+x15tmv1cPr2B3QDjwd5KnLTnAExijauamayNhHh9QFmiT9MvwvHVU+s/GR1rVX5JCmiaeyZj9hicU7tSLw+Xl4mnDREAKC4RZbWfjfMurVP6vMZQv4+SheS+GjGF5ZVTGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htwL4AhL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc611a0f8cso43162015ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722448118; x=1723052918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GihMA5W/EIh7iKI+MTdDSH7wqvCMGRTF+8Oe8yIC79c=;
        b=htwL4AhLK8OV6J6/HOi5qqwFBHR5UWkbB4ERHFm2fI3OeZxmdrOuoDgKhtL0BByA5c
         MErSOgnrU0l++Cz2BEUerJtn7Z+mFhYFyMHvIIw+Upz3JlSEFatWU7Io3jD2gKape3uM
         F/gAYg4kubipKeuu04hleG21GsPFCfRXzPLteBfFYjYZDanjHbBOYDb3zQbYLq6nwJd2
         Rb7RSDTK+hOAkViH4ceiiCoxW1XsoRKoPkitsWLVW+hDRCytau+jtdqA45WPfnBquh/w
         0m2ZS0JF4qJTNnR5q9CDXu8OZ/5s4VnErfqvbCqIYfJbhaeo3m/OwEmF80y0L5P/587i
         B2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722448118; x=1723052918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GihMA5W/EIh7iKI+MTdDSH7wqvCMGRTF+8Oe8yIC79c=;
        b=l5fg3VlRkPRBHkvTPhyVMEcq4rcVxIqopkP8QQSn6icTSE76JWdnHQf7AXpW2qX3xq
         JxnRi7WdwO+ZHwrTds0w5q48Oqsi56Wq8qteLnwFVz17C4F8Q2D/UDteZZ7j8yGNuVe9
         F7A0OT4Vy/bePt+burdsjFIoLLihCd6UFp3UGjQhsT7hVnx6PEJM80le3moOh24foxwd
         yoJXR0n9cEfda1pzT33V1WNZkqiyHCZiGtXErICUUKoiLP1L+axxCFONVZSUg9ntA2fh
         r2jfjrwz8u+SyaabXSoSUuMX4xjF01cPAmLGV0ZV6NhNHpi9KMNjdX42lXhASgv+0QVM
         dS7w==
X-Gm-Message-State: AOJu0YzGfBRFny/5rIv2YAmRfUKgahmoeK8Km7q7dXlNsKVPcpmWS20F
	F0XYTdZwFYIx4Pumcj+ptutj2Gh0e4/d4J2eq70Swk380F31ERkz
X-Google-Smtp-Source: AGHT+IGsSxdgeOB5gba7PbV9RQLPrwkuMDQb9D1XL/rN5/ACXuhql0tMLt6YweOwQVjLwcGua2ygbg==
X-Received: by 2002:a17:902:c40f:b0:1fd:5eab:8c76 with SMTP id d9443c01a7336-1ff4d20dfd8mr498385ad.41.1722448117789;
        Wed, 31 Jul 2024 10:48:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff622asm123191205ad.301.2024.07.31.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:48:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Jul 2024 07:48:36 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/2] scx/selftests: Verify we can call create_dsq from
 prog_run
Message-ID: <Zqp49ALnlA0ikx2a@slm.duckdns.org>
References: <20240731051437.69689-1-void@manifault.com>
 <20240731051437.69689-2-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731051437.69689-2-void@manifault.com>

On Wed, Jul 31, 2024 at 12:14:37AM -0500, David Vernet wrote:
> We already have some testcases verifying that we can call
> BPF_PROG_TYPE_SYSCALL progs and invoke scx_bpf_exit(). Let's extend that to
> also call scx_bpf_create_dsq() so we get coverage for that as well.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Applied 1-2 to sched_ext/for-6.12.

Thanks.

-- 
tejun


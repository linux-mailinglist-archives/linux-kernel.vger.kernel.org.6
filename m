Return-Path: <linux-kernel+bounces-344000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6898A260
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83352812D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBEB18E75B;
	Mon, 30 Sep 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="At/lOXAt"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E718E031
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699228; cv=none; b=jgeRCKFucgzO3uSd6Mk/rs05p4iS43ml2Q+TJN+NSYhEpN3qNVQnHoJb9APNwOmkL5v3lTg1Oi/Bqncilcyk7CamlbTIDDGjztTFBzrkh3O+PoFj5q42Mw9Zp+Sc30km73XyewVmCiNTX75Cc6Sl3fGNRksPRXbGtiwrDtqtR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699228; c=relaxed/simple;
	bh=N886qxBamW3uIi+SusvihjfN/VNlxZj/xjBq2IJNRV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7zMDNmeS0F/eGmwYZ+/wVPXAAaoNnIQbDZmZVgi7e3bj1P5blhZ5ldeZwh4uaWYrW4ad8CIYU5vpK0Jto2QCffGYoLLzAdbQX96R1mvcsI914R//fUG8AJGtWDBoxBvvdIRMUyChqKGti99vjQhac1ghZWRYgkIYYgaaV3+RYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=At/lOXAt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b5affde14so14382315ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727699225; x=1728304025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfkdT8O6nyV9YZAFq8/FGOQnu7cHl5dBNbp1cBDwutg=;
        b=At/lOXAtmdgoa+XInJ2LNmvXoIXMIL8rcPDiD0akv70RJ+DFi0E4yN1MI5VhC+2y57
         9Fm5fE7zGmlRNMOkIdnp/3ujVAKPow5TOTrO6opc52iybUc1U8w74nc/EX4KJlcaLMhF
         EsnFvmLbDrvemS/BQql134TJT1M33vt/DsTMBdK+kYhTZOyG+qEhEPwsSVkQ9nwqZkd/
         QzABmdL7XDS7LcqYDd17LsVHlYdNacH0/froYHQiuEd4Pc1H/t0VhYqsqVJyXVUBlEfm
         Gyoc8mAQzVZC3rn6xOdsmhQoYMbnoEFHGTFRsF8Z2ukl/E26o8GcjlYmST1MezttQFl/
         bSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699225; x=1728304025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfkdT8O6nyV9YZAFq8/FGOQnu7cHl5dBNbp1cBDwutg=;
        b=l+YG0wnVWZ/HBtqDh2WzCOqYd1hlAD+PasvjmgnkuxL337Iz5IY/8IxDSJA26BM/dE
         KGW0lLXcbdcW7DTYChaOKJ7hVaFux+A3dMPBa+0oP4K4JeD6DVCDh82neoZRQhFWepKM
         mObl0WKmAaUGndUJLNljnBhUd9MJIFDwbMLAvBbzy9aCaq458NHTtGUrz6l/Cwqs6AYR
         M1CDCvQRBREmrSHEUwUh13a/pAK3w4b6IvP902678GfC0dFJX9IaQTRA5arst4sqjljT
         29Y1BiBl7IIJad3o9SsMN9BsqbI5ca9KiRBacD0xBBIPCYrpqhRMDlIYjddmMJPKdp7d
         T99Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaq0nNwlHQLN5NibC+30QSuAnKIGOoTXDiAItSRLRIXxg2ti2BtSqmX0a//qQwhnpTrWAdIkKpvrw7ib8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhu/sEVAAozODFBsiyy6sCix4V036zisgd6rORKb67AHpE3HGX
	l5mRYvvZTHfikeY4InVl3kAItyX0zYjbNfbQDR6nSNb4TE+v4qPrICYQPTdtSe0=
X-Google-Smtp-Source: AGHT+IHG/wpBp/CtKceQ3qDWyrlnI+DUlP5VLVxTkPxbhjnxdWRhvjOT3cbFdqHYkCUtJlctO6FkGQ==
X-Received: by 2002:a17:903:986:b0:20b:6125:69be with SMTP id d9443c01a7336-20b61256b01mr108772115ad.49.1727699225518;
        Mon, 30 Sep 2024 05:27:05 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da03bdsm53867485ad.95.2024.09.30.05.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 05:27:04 -0700 (PDT)
Message-ID: <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
Date: Mon, 30 Sep 2024 06:27:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/24 10:43 PM, Borislav Petkov wrote:
> On Sat, Sep 28, 2024 at 05:31:36AM -0600, Jens Axboe wrote:
>> as the box is running debian testing/unstable.
> 
> Thanks, I need to go find a box like yours to try to reproduce it there,
> after I get back from vacation.
> 
> In the meantime, you can add "dis_ucode_ldr" to the kernel cmdline if
> you want to boot the box with -rc1.

Would it perhaps be an idea to revert the cleanup until then? I can't
be the only one hit by this. We obviously missed -rc1 now, but...

CC'ing the regressions list to keep track of this.

-- 
Jens Axboe



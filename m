Return-Path: <linux-kernel+bounces-376299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF279AA2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F44C1C2231A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39AB19DF5F;
	Tue, 22 Oct 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LxTLo8Id"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147219924F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602914; cv=none; b=blVlJbh5EgZo0HZs7wudwy+zXOr2dYWieLXxbecpUBoZhIEM+bstUNwEYmy3XWujadubDM8IKfubwcKJshw0RXJ4g78RpDFKHdR90ECyETOZH8orwTL4NZCOFcyBcA5RR9t/FjxdMEx0PPCihOG8GVNLD8R+xZexxCaXBcZENCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602914; c=relaxed/simple;
	bh=UoQaQnrqQ1WBGYkIx4J+4jJE/uP24fHs+WeP81kBxno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZTJxjGKJx2Sg0P4ewniHr/J22HxN1euoONouJSfruldkxYdLvBmS6sw1mGcFiQ41csOHVpa4GWz8N6OfXXTvRQLKV+OxAhlIkcBtihXEz2MFjgBZF/EfAEPVTNRZHlx0zA+UabLQbBOLqZ+fYnk4PhpHlPi/WD8V0AoM+qPwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LxTLo8Id; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so183186239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729602909; x=1730207709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HhRXZP19mzBOGCReuq+qXXrPGxMcaiU0fTOUSrQSuQ=;
        b=LxTLo8IdweEjB31L/zNMSvk+xSJm2V4URLaGN72/6AUJsQ0O5cwF/8JQtPAyQzIA+Z
         pDfZGUhE4/flST4kWXDzhJIFaRpzD2NQxU62/EPsuspPUtZfpZ2FfvUt2qbOjJKm+Gz5
         iUVBG48FFAtqFFCR/jhvsLSCzf8Y8MoBUnMMcfF646H3+qDObtnsPJAPEhJh6BzDHAeA
         f0OWhWAIc5GZLu3FjDX8V0TkHpZJp9DDphAVqYy471KlKCgP9v1lD65bvEX7mZ3Y9cSx
         FnI1lLvMaXaXGUSM8p722rfjNRT81ViHB8pJl+UYMxynxumgLGtlO9ETZY0y79GS8UXc
         pmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602909; x=1730207709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HhRXZP19mzBOGCReuq+qXXrPGxMcaiU0fTOUSrQSuQ=;
        b=LRtXG2cWGCukMH+EJb3b5mLOJiJm0s1kO+A7a4WI64uYmhWDrrjIZf6s0kywkt0io+
         Va9s3cD2v0R50UocTkE/8jdureclnmzHrEqr1A0+mG+h95KTMAGF2l09ieKZRtuTwpHe
         mEaDyM5ZRae4GnHSOAAntkP7pWU9XMzHSkX5UuanZ53HRCdQ2MbSKx+BEdyLih5hpeI6
         HYFBQKC+NLVIwpCmVzZZQ2SbcXEz4ptBBrC+gmBXv4Vcy2Mg6RM4rkVwSgIYrBVhKbhp
         GHCqtErXOGO+Ql+AeoqAObnm0kxPHwwboelCpiPqTxpyXWP9Q0/mcSOu1BwpcIJSIL1n
         3pYg==
X-Forwarded-Encrypted: i=1; AJvYcCXkovS/2uzceqrXyBKJPCcMB0PV63bXOpNNumdFWEn6vphRCgqWeIlZeWSO99HwIqkdENb/JCcqGp0X/cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMXohww2DPCZatRtVkm9+AntcTkDQhbx8HSYFrpNE5gouMyFI
	KY/xGMq2d2gC4APDvBMXvVYRV3QuXyrwoiCZ5Ph9K9cTReQpO/sb3X2Av+dvlZM=
X-Google-Smtp-Source: AGHT+IF6HTNE7SYoGoUTu6vg8Db2lhbasz38Avrn8hve9ZgM0WVlqHzOHZNeC9p/uHiiHNfqbn63zQ==
X-Received: by 2002:a05:6602:3c7:b0:82d:581:8860 with SMTP id ca18e2360f4ac-83aba64a748mr1550641339f.12.1729602909220;
        Tue, 22 Oct 2024 06:15:09 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a65c92bsm1561414173.158.2024.10.22.06.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 06:15:08 -0700 (PDT)
Message-ID: <eb6d8837-84cc-4b0b-8025-c846e24e8240@kernel.dk>
Date: Tue, 22 Oct 2024 07:15:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/microcode/AMD: Split load_microcode_amd()
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
 <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
 <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
 <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>
 <20241020121819.GAZxT1CyR_5vLLZ5e6@fat_crate.local>
 <df217737-6e2c-41fe-b558-3e2ab6dc0d9e@kernel.dk>
 <20241021073140.GAZxYDXCk02lSrG3-T@fat_crate.local>
 <daa98312-cc66-4c2f-8e64-01358ee99305@kernel.dk>
 <20241022120531.GDZxeVC0WeUPhInkYh@fat_crate.local>
 <20241022120836.GFZxeVxGQ6vWIScFWo@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241022120836.GFZxeVxGQ6vWIScFWo@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested 1+2 together only, but for those two:

Tested-by: Jens Axboe <axboe@kernel.dk>

Thanks Boris!

-- 
Jens Axboe


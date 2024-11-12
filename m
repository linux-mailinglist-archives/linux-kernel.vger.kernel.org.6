Return-Path: <linux-kernel+bounces-405016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48E9C4BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D17B2A96D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3D209685;
	Tue, 12 Nov 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fk0xFeY6"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72862204F75
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375107; cv=none; b=rsT8cN3fsB3V8pmvV4Xqf6e4TSZFaB8xfnn8jlp6EDjidAyPPXmU4v30NPmbLx4uS5svPlvlsP43dFS3vO46wCs1nWliWciEBKx7nBDnPXU6iGM8zOXrntLJGVGC/6baQur3qjyLU7BTotbTBmk2RnbolFswIKi1kIkZrI6MEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375107; c=relaxed/simple;
	bh=IpmcEo62gy/fO5HtpCeApmyIz2PfIn6pOC2cdQ4GHCw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iGDqTZcXwcSwZ3ZMXN4wnFXnD3OkUdc6akMapW7Z3vMP1pVMnMVZmuvINlYp5NQL6NcpYmu7oK7B1AQmY7UBPRLFYw5F2iuSlNdA24sUG/Q7cvN4DzfEe5Q5c9WQQ+YCtJJiWJsp2GMhcUzN97cIyXaZnwqAsXr4CJ8vOcREbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fk0xFeY6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so4099838a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731375105; x=1731979905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSfHWTqMzn0W64gOgi4COTx84X58NA2lJ4II/9gIMKs=;
        b=fk0xFeY6gtktU2cKAq0ApNA2Om+VG6icM8HW/NSp4HJFYfokmi1i6hDb4aiItvta1n
         7mcJFCXcJPADONGRaYrPW+jWrxeK+noSdnuKeEB50sbgKWo1sTi3umfD++jNuRrLL+GJ
         KtdktOSMUcMUpIVWkpDB3fVAWcU9RNvupqUK1M86Z8S0SGGIieqD7aveURpch2nnu8+Y
         tIIbLiONsjxrnhAIleWnTED3AcC+WuO3GCaB1lji8efZ2zC7832Y+etv7s9nWGsa4YcY
         nAV+Lrdo6vlH7hExClQhpCrOt50KS91yqjOwhoM96b1iHbGB+fwTmZhf9KMXz9EOtJcd
         fR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731375105; x=1731979905;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSfHWTqMzn0W64gOgi4COTx84X58NA2lJ4II/9gIMKs=;
        b=mfdOWf9OKIlg4W4BKlAZon9C08+TqL64bg168Z+16KE/PyhF6S26sgLUUZJQUl2x0X
         Q2svMhmK39bHP/avty5eSJ10ZWEtFo785NI+bKtHAkUmkcm8lrOJX12shJ6KLUdTeA2i
         8Axnk3WOy7usAn9gOfEWTo1XSaUFIuJsGPVCS/uwwoBbGUildEcoIKknGaY/p5q7yM7w
         HLIzKkO1rXMWiYinNwKr3dtVm7qfzGDHI9+PXn0BRFRF1pPjrrSIOWtzYI82x0g+C9fL
         IgvjDs0UhGC2FSDDoqUbUQ2hZCGT9yL/xiHQ320DnqfuActYkkwNcq7T5ovwJ0VbkwF7
         bJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV5U2+755QIA1nVv5XaiFfcq2gUb2h+0npV+iKAR3ce8ukoqMhREXVjDRKcCchyhG93JsYttnVdZ7TvCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4IM0iVxxNdU2PuhuimEAGdY0Xvr2jUmTA6o6u7hCuHzDXhhT
	+MwE3eAj6HqGQX/X5CptnJ1mYOmFibMveJXFnNr/E6sZMro2VBEhpTYueah3mAs=
X-Google-Smtp-Source: AGHT+IGrJ7GoBrb8g7tX8vxgASw/4ctrZN1Qqxd0Yyhht39fAFMWQ6UdTE6G8NXshyU/lP4mJ98ijw==
X-Received: by 2002:a17:90b:5105:b0:2e2:d9f5:9cf7 with SMTP id 98e67ed59e1d1-2e9b17748f2mr18818948a91.26.1731375104857;
        Mon, 11 Nov 2024 17:31:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5fd31esm11349139a91.40.2024.11.11.17.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 17:31:44 -0800 (PST)
Message-ID: <33396695-7668-404f-8908-17c5badd5920@kernel.dk>
Date: Mon, 11 Nov 2024 18:31:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v3 0/16] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 4:37 PM, Jens Axboe wrote:
> I ran this through xfstests, and it found some of the issue listed as
> fixed below. This posted version passes the whole generic suite of
> xfstests. The xfstests patch is here:

FWIW, the xfs grouping also ran to completion after that, some hours
later... At least from the "is it semi sane, at least?" perspective, the
answer should be yes.

-- 
Jens Axboe


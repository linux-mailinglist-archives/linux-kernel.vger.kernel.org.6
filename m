Return-Path: <linux-kernel+bounces-220144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4A90DD52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5581C220E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F21741CB;
	Tue, 18 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ffTN8y3u"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB739AEC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742138; cv=none; b=A8ASStjr0gPzNtTV+ABUXkscuaI2J6iYDZVH01HBIvl3aQ12hTLNDbHWTN7Rl3kDH+6cOcMpnBdyrPtStOpB/I57SkqA5vY7nc1lKizfSOBYDhCeKFCHSRjeN+78cxNyEq/eQVOZ7LzoKZ1h8PmqTJCXX82IlgNOdHzL9/BkeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742138; c=relaxed/simple;
	bh=ruEwwY0sCQgIx4+51Mr+KTsL/uQU36KsSPbTkDJyj4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J04Sakt74XsA0OnGAop+yyHRJQUQV2Z3AGWlvQN7WwKZ6vDX3EfNbWy9SPvcdC6AlYNf4v/EvgzsIpHVmmp8WbvY6WToLtx157ZOQIJG+Ca56lKTmX/F9lTU3morhfg+rP/pMU6TI92y/GkZkUpPeyINwYWlduKkngAQovjvuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ffTN8y3u; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375ff733262so662315ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718742134; x=1719346934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OD3hjWlOreueuZ2eKAGTshwNE/qfElO5xeeHy8WIAhQ=;
        b=ffTN8y3urhcX4LBsgrcWlZxxhNxD7pRo1Zzva4Iap1XLRTFz+v8cyZZhQeiOhSLv4g
         fW3n/Uy1MiODrBsyJs/za6CqRnqZ2S8/7Jk1htUJRksRHMjakqg2k5J/d9hxWhpFnly2
         UiqqiKdjA4QaFmwOteEgoTVf7IA2zlHoNxSdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742134; x=1719346934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OD3hjWlOreueuZ2eKAGTshwNE/qfElO5xeeHy8WIAhQ=;
        b=DZABlMjl/K22yYbBGu51J5l3rg3949tmgRFayrEGHCVTJ7+zdrnxTpvOAvxoZryi+Z
         1qPtMOYJndj1ECMxy83YzFj186scsbjotYOjWHmb1yxzQ4yPmKfmawxctRD7FLnukmfa
         WxMb40OKXzohayjJflwiosPlt44bXh5UgRRBZ5zPnEUEGcRkX1w/R6i0mgNTIVCVfC2z
         WBttKFhSYXdj1vBOnPUIdmDCXPye2JDvozdeVfjqyWOC0DVtV3/WixvjseCjvyqiuPLf
         fMT5+JxQJ+hX5psqL1xeX7p17Jk6UwXpSch3t3lP57RcAKBurTmowkMuYP39EvDR7rKY
         s3ww==
X-Forwarded-Encrypted: i=1; AJvYcCVNSr3fGBaA+HARumAvOLEQOOZ8c7hU9Po0iO1o75zHLVv4H8zouvamSoHT4XfkQwouDn/B98v5iDFzZbDCFG9PiFBcY0vgnoHF9XuE
X-Gm-Message-State: AOJu0YzmaOwgTfV1ae7IEOKCUxUURBRAmJwdCGgEU3syAiTIZ6bxTJno
	2gsE0ypTh8ZJhov+D1YsjVGdTMtrsLLEtE/CTYqsrps/sIRVzgbz2qYTuFLAQ6g=
X-Google-Smtp-Source: AGHT+IEKrbwpMAjzjfhp85KwcKFf7Fg/nY7eNZEcazaP5FLtxaCvOFmjeTpwJXw8irpidJKaiyifiA==
X-Received: by 2002:a6b:7203:0:b0:7eb:f05a:7d4d with SMTP id ca18e2360f4ac-7f13ee8b981mr94008039f.2.1718742134360;
        Tue, 18 Jun 2024 13:22:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b95696ae3asm3331249173.75.2024.06.18.13.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 13:22:13 -0700 (PDT)
Message-ID: <d47043de-628c-4f9e-8791-a2a8dbf4ed21@linuxfoundation.org>
Date: Tue, 18 Jun 2024 14:22:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Remove absent 'v' parameter from monitor man
 page
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240618-change-mon-format-v1-1-efa263a8e286@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240618-change-mon-format-v1-1-efa263a8e286@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 13:21, Roman Storozhenko wrote:
> Remove not supported '-v' parameter from the cpupower's 'monitor'
> command description.
> 

Nice find.

> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> There is a '-v' parameter described in cpupower's 'monitor' command man
> page. It isn't supported at the moment, and perhaps has never been
> supported. When I run the monitor with this parameter I get the
> following:
> 
> $ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -v
> monitor: invalid option -- 'v'
> invalid or unknown argument
> $ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -V
> monitor: invalid option -- 'V'
> invalid or unknown argument

You are burying important information in throw away text. Please
add all of the above text to commit log and send me v2.

thanks,
-- Shuah


Return-Path: <linux-kernel+bounces-385216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAFC9B341A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF87E1F22397
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D861DDC3C;
	Mon, 28 Oct 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TSei5zFp"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438171DDA1B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127332; cv=none; b=OyA9GL0cIflYEwjKrYcoqPwwgJmqldBjGx1m5erkdZvXLParX/DaRfdehn7xi/kZAF4/fpXz1XNxinhNfdYzJZxhxc7xkfxOtAXPtb8VHYoEMnXlcQE5jyP8xADpPB6lX2bPIiKaVLSsNh/vhUckT5i8RQb7isIzBZiw9Kenyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127332; c=relaxed/simple;
	bh=3I/c1iSHfDGPSB8Vg4G3/uhCl6rDJuP0ZIYONyN2iRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB7PncxuPT8lPhgDYvQOpTMH9QQ/mlXtS8yc99KucOM9nUnUnzW2z9J7GTjP4uMvPjYC7bUsmb6TzdNNrgxhTTCc0DHRoB2AERlc6fo5UbZIXw2y53BTeFuAZ71SRz45GT7PKhSfGhpQ2Dt+rpjDuwGvIyIh2kU9d/JldbQ/FQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TSei5zFp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a68480164so611235466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730127328; x=1730732128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Iun/RjX690GMZEyAyGhf0q0//IXeU/3+RYE93HP2ik=;
        b=TSei5zFp8sqO8bh52nEw+OLAqgFIDIODhUbpZUcHkY4OlFTYMoXSEf3ikqad3NkoS7
         JPz+H7vbS2Rc5LDLa41Kz+woNk/PxLuxq6UFnCD50KpnJ1TM9oibDm5lZBRYfsOT2EdP
         rzveWKRj2F+OuL31Ml3hHKIgNTCsIfrwornlIi76ak5S2jP3ABlPhYE3G5yyIu5y+3Z5
         RDw+CZKgsDahF04aCo4pa0Jw4QOPqCHRDTSt6U2t4mlJz922gzRHqVQd+cJIhoorl63f
         2xJ/vG3+Tkff6vJWNLWdzj7of8kIkXkNzntsO9b2L/G+TDbKyJpFFOM6iMz4ehiQHViV
         wQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127328; x=1730732128;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Iun/RjX690GMZEyAyGhf0q0//IXeU/3+RYE93HP2ik=;
        b=ETo6im0vbbh1TkdbROGfxKXmyJ7Zp96cPB1b6z/4Nf35piC7kiO9XZHSMHJTZWbNft
         sL08NMyoOU+Sr/kNCR3c1/Kav4nr3gfiKKYM3AgS31+W2GLDL//q61EEMFmGDRrW6yjc
         v7HW8eEVxf71+ch3/2IKvN5TLT+h05H+KCqi9oUvf/O15Rek7wsvCYeN197jTbRsXSj/
         Bb+/Ba/G1VJ5rrsgLOutP38CDG2bSKx9VARFWP2X/7mQW+pLo5WHZPCp5Lm/oVOQFsle
         M4V1Csez2LsaHlTY7lNdqt70yVryvq+7dBXwwiqx22OKumdt2p307vjElLhLfk2IBC9Q
         M8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVXYFC9xiEFjGHdUUQhRwGrj/WIvP1TM84zcuVXrmXeFc5uI4WxXS2SwsWRxtxpNr58zHCSNnY/jJPrR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZbemvQEsJmzAFgnEXxqs7r6nX6PHHy2W3SgJKCe/cUa1OhJQ
	xsCueX2cMnxVjy9kj2DMfSXDwRZ22vQmZ1fm9v5BqkdLbzw4h7PocW+Os2ChHwQ=
X-Google-Smtp-Source: AGHT+IG1u9a2TBkIJGXQu2TDn2MLnBYwYgjbkhmzFVSLRK4+krixIOTdIogv1lXP+QAyAO3JziQlPg==
X-Received: by 2002:a17:907:72c2:b0:a99:f67c:2314 with SMTP id a640c23a62f3a-a9de5ee34d7mr949087566b.35.1730127328041;
        Mon, 28 Oct 2024 07:55:28 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298bc1sm385999666b.137.2024.10.28.07.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 07:55:27 -0700 (PDT)
Message-ID: <d2185390-5967-4abf-b2f7-13a26bd4443d@suse.com>
Date: Mon, 28 Oct 2024 16:55:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] x86/virt/tdx: Switch to use auto-generated
 global metadata reading code
To: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
 peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
 dan.j.williams@intel.com, seanjc@google.com, pbonzini@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, isaku.yamahata@intel.com, adrian.hunter@intel.com
References: <cover.1730118186.git.kai.huang@intel.com>
 <7382397ef94470c8a2b074bbdf507581b1b9db7e.1730118186.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <7382397ef94470c8a2b074bbdf507581b1b9db7e.1730118186.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.10.24 г. 14:41 ч., Kai Huang wrote:
> Now the caller to read global metadata has been tweaked to be ready to
> use auto-generated metadata reading code.  Switch to use it.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


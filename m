Return-Path: <linux-kernel+bounces-303459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F00960C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916D61F22849
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFCF1BFE02;
	Tue, 27 Aug 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwolZ22I"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A71A0730
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765944; cv=none; b=M6ThWrhhalD9pH+S0wkMCeeUoDHpUY8d9lkterNaSaN/zScCkCCBxX2qHALUhnxxjDikshmBssguXo6R/c9/Y2r4pQouByeFzg6RwnS2YSG+nhhQTLgM3DztoJWGkg60a3RSnpw5hsUCL4zcrAwg67CVpg15XLSdud1VPuSc8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765944; c=relaxed/simple;
	bh=EmUgM2/ytQuJfPaiYklRwOQpvnyqCeJX2p7TWdM5moA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTk4pt9HuWKIDkpbzEvGCV55pnz/bF7hBbjC10vNTlAjuUAhT+EzwOAdZwkrU+X0CHZEuwm7CV6rt3Y954g7bWfAop3lPHEsqU4PGYcsV2PuxHJrrU0EKDHXUfbub0wYWY9hJdTMQs6iMW+dku2e2p0XmEmHTtr8B3cLLy/hkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwolZ22I; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db16129143so360680b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724765941; x=1725370741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzNFgePLd1xkOZP0EuX/y0xPFlqksOAZUan0SE77Djc=;
        b=LwolZ22Iq+2RBuR9j41sRLkXW87w7thvHreub+1+IUfhQ1W4NAFqUMPVit6wX7w/+U
         xps7QD31i8Suh/UTTYPVqXmdDyRzC2mofwe4gCd0Nv8klV2pau47PSYeb7tlXwDJcitX
         JaliUmxLm5P2VTYUKu9GbOP4qhZMrb4c6ddUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724765941; x=1725370741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzNFgePLd1xkOZP0EuX/y0xPFlqksOAZUan0SE77Djc=;
        b=duOWTITlX3LantlTBqotxiaZfkE40ee9LPZYNt43WwSeNM13xm2JoNM/SUqDZYIC8z
         a4PpPYCP1B7294xIJQtK3be5Yv+RPuiuAhWf+YiJ6dvkre7uMqSBbgRM8a4yu8z0gPGH
         p3/zkN0oJ2xL/WoWwR6n2oXA4D6DG6w/1Q4JiPZUQ1OWrzHIDQd6p+/KUbpDgqSE5Lq8
         a8gyYna8rchVxBHeogHxG3m3m++w8mGZvect+QDys6CdkK1D/mrQMQZQ8L2lBuB5kI1H
         huyL524wLHgVmjbCLje32uO72gZ4ekGeGwUzyXwXP4fvFi5UKs2xk4TfID5TVSOMFROv
         xmsg==
X-Forwarded-Encrypted: i=1; AJvYcCWQd1W4S4ANOMdaLySEdTEy5wrxfhBlMkQBDufUvG5u53IkMw95MCZOBHPegtgrQKz0BQk5lyIJa8PU4kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzruHe3ZTNFeYOp85o/TupEzFaHf/ow3be6yYfUF9Xk4m98V0V+
	lAg7Rhyknjb9HO4Z932x0t32XVrh4CtZBNtVPo/x099c7347OIScmtZeLx0ifvU=
X-Google-Smtp-Source: AGHT+IHGRL6ToaIoM39AfyW127C9/x+YWGPFSMwGHsfntziflfJyV03EUQlEF4NMjqFLP58aaTehTQ==
X-Received: by 2002:a05:6808:6489:b0:3d5:5fbe:b2fa with SMTP id 5614622812f47-3de2a8d4697mr12190240b6e.35.1724765941408;
        Tue, 27 Aug 2024 06:39:01 -0700 (PDT)
Received: from [192.168.121.153] ([218.49.71.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabccasm8007261a12.27.2024.08.27.06.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:39:01 -0700 (PDT)
Message-ID: <0a197b29-f0f4-429e-82c0-f54469f31b12@linuxfoundation.org>
Date: Tue, 27 Aug 2024 07:38:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the kunit-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Brendan Higgins <brendanhiggins@google.com>
Cc: David Gow <davidgow@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240827160631.67e121ed@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240827160631.67e121ed@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 00:06, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kunit-fixes tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> include/kunit/test.h:492: warning: Function parameter or struct member 'test' not described in 'kunit_kfree_const'
> 
> Introduced by commit
> 
>    f2c6dbd22017 ("kunit: Device wrappers should also manage driver name")
> 

Thank you Stephen.

David,

Can you send me fix for this on linux-kselftest kunit-fixes branch?

thanks,
-- Shuah


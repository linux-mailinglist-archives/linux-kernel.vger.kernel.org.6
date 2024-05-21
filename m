Return-Path: <linux-kernel+bounces-185400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB98CB482
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39491F2350F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA614831E;
	Tue, 21 May 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeJ/Bw6A"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B31DA53
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321713; cv=none; b=Y4W/artVVErbFWBsJwls0FeVj542BIiEaqiaF1UX0EkXpMgcA84+eX8ulVwrIzDCZx7gENxirWb0nuLqmYtBZBjpES+OZCBXVLDW5LeGfbqX5Q9ssqElpo0mBJqA4qCboFSKAIWgtFOD8mP/x8dLaBuXP3X+nmDxgOodsqRRsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321713; c=relaxed/simple;
	bh=jYfrh6IB/H70cLPJ13z6qCmeOQJxG2Z02ywTH8Uaon4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VglKG5NI79h57nImLryon6MZzrSCz+nzZ3IjfXw5HjwRDmMWhHte207poQZzGnZ3Mwqw0ywEt7RcdhG4pmWWvhha+YBdfImBpGvcWWP1EoOvkQPsrs7L4RvheGbNtjbarxATUC/T/d2b3vhnw3lAne0P/HD50FymOPL4LfA2640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeJ/Bw6A; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34ef40fae25so80212f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716321710; x=1716926510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4lo6fagN8cZt1RfD02V0z/UoOAxB4b8uSr30hJTpAk=;
        b=XeJ/Bw6AGUets4l7NRrL+7J/9howVi/huC5Avbo/pdw981M8mvz6M0W0YkhJwB1Ii7
         OCdG+3TZ8xTLHbnh+2bRViJ53+rqwumsA/j3gufWW39uPxZynXJrm0iR6gxC+NT+lHj/
         YvKze3DdHGJhkbJURtqmK9eSH6WHvJcejAhEeEyEP6IDZHv5DXvbfemtNn6ScMHcjKNH
         Z7DjND1oxz5lqZauq3voVBP6JQjP6/vzECb//SGS6p1bxXxDU7aFdowPu8KSlPrHRB0V
         d7Acf33liprALkLzQX/BeUUES7oVNYnHozvcuNprq4xA2gBuEXsyTNqfBo2GfKP9PqDt
         VXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716321710; x=1716926510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4lo6fagN8cZt1RfD02V0z/UoOAxB4b8uSr30hJTpAk=;
        b=SIPOnFIJydqNsNlOXDk+oQ5Lf4WzjT21bjXFtqRoKNC2JMxbFNrcU5pm56jmSwVbYF
         YJ4zF2gh1HhDcfU2OY1yZP0etJ9B1bHjrSfQDNsVzjNAzhUdYfv9HaAJpjk03xIvaw9O
         gRoxPFqgtoYoj7NkpgvvXnwbbb7Y94ca3kJUs0OJBBK0AWtcOwpdIOgNJULPKAykGH4S
         uj8vEdGn+zxp3uydKKG4Y8N4uie850u70EyuhJtnXLExWQt1NNWpo6L91F094Q/XJRwB
         zK4rI4wqIEtIZpEb7hCRtHUwcfTfmJPH8/U3x3/4ish6Z7C193Ptu8GAqAaW/gbbgwkS
         2+uw==
X-Forwarded-Encrypted: i=1; AJvYcCXrRm5Pqd15EssQ5eL+GTfVEr0LA45dZAs29/eA5nZ+qvu8qiJMsxSFvAtUh4425pD2uYlKlLGB8+Kk9N9vFhzU+MiBw1r1tojEtDR4
X-Gm-Message-State: AOJu0Ywwg9JCaLfh6srSV9i6kvG1Q6cLDJXvswLkx14wo1YJXpM4wFap
	OyVixWObkyoXfxSO3r41T5QqUM55LbA9eokpHQBBDbL7G1tdrufN
X-Google-Smtp-Source: AGHT+IFf9EV4pdgf2JoYXUwaxtj7mjO46NJ2dbIphTXFEA9mOZZTuIrx01dLF7aYH5Hz/LYaEuqYQw==
X-Received: by 2002:a5d:4312:0:b0:354:b55e:654c with SMTP id ffacd0b85a97d-354b55e675cmr9425318f8f.1.1716321710209;
        Tue, 21 May 2024 13:01:50 -0700 (PDT)
Received: from [192.168.0.102] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b1771bsm1640748366b.215.2024.05.21.13.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:01:49 -0700 (PDT)
Message-ID: <ff5e9e62-f2b0-4229-9afe-68e0ae467674@gmail.com>
Date: Tue, 21 May 2024 22:01:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/31] Staging: rtl8192e: rtllib_rx.c Rename camelcase
 variables
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/24 05:16, Tree Davies wrote:
> This is v2 of series renaming camelcase variables to meet style
> guide requirements. Thank you in advance to reviewers.
> ~ Tree
> 
> Changes:
> #16 Renamed plist to list
> #17 Renamed npadding_length to pad_len
> #19 Deleted ChkLength variable
> 
> Tree Davies (31):
>    Staging: rtl8192e: Rename variable IsPassiveChannel
>    Staging: rtl8192e: Rename variable CountryIeBuf
>    Staging: rtl8192e: Rename variable CountryIeLen
>    Staging: rtl8192e: Rename variable bWithAironetIE
>    Staging: rtl8192e: Rename variable bContainHTC
>    Staging: rtl8192e: Rename variable MBssid
>    Staging: rtl8192e: Rename variable MBssidMask
>    Staging: rtl8192e: Rename variable elementID
>    Staging: rtl8192e: Rename variable rtllib_rx_Monitor
>    Staging: rtl8192e: Rename variable rtllib_rx_InfraAdhoc
>    Staging: rtl8192e: Rename variable IsLegacyDataFrame
>    Staging: rtl8192e: Rename variable RxReorderIndicatePacket
>    Staging: rtl8192e: Rename variable RfdArray
>    Staging: rtl8192e: Rename variable Decrypted
>    Staging: rtl8192e: Rename variable AddReorderEntry
>    Staging: rtl8192e: Rename variable pList
>    Staging: rtl8192e: Rename variable nPadding_Length
>    Staging: rtl8192e: Rename variable LLCOffset
>    Staging: rtl8192e: Remove variable ChkLength
>    Staging: rtl8192e: Rename variable WinEnd
>    Staging: rtl8192e: Rename variable WinSize
>    Staging: rtl8192e: Rename variable IsDataFrame
>    Staging: rtl8192e: Rename variable bMatchWinStart
>    Staging: rtl8192e: Rename variable bMBssidValid
>    Staging: rtl8192e: Rename variable bWithCcxVerNum
>    Staging: rtl8192e: Rename variable Frame_QoSTID
>    Staging: rtl8192e: Rename variable CcxRmState
>    Staging: rtl8192e: Rename variable IsQoSDataFrame
>    Staging: rtl8192e: Rename variable RfdCnt
>    Staging: rtl8192e: Rename variable prxbIndicateArray
>    Staging: rtl8192e: Rename variable bPktInBuf
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   2 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c     |   2 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c     |   8 +-
>   drivers/staging/rtl8192e/rtllib.h             |  36 ++--
>   drivers/staging/rtl8192e/rtllib_rx.c          | 183 +++++++++---------
>   drivers/staging/rtl8192e/rtllib_tx.c          |   4 +-
>   6 files changed, 116 insertions(+), 119 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>



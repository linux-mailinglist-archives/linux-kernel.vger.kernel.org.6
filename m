Return-Path: <linux-kernel+bounces-429391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6F9E1B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDDA164AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DC01E47CA;
	Tue,  3 Dec 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IfxbmrlE"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339511E3777
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226915; cv=none; b=cDR29XgY0/yZLXntEA3rV/q9fx+nU5S7Syjl8woQen5+ZqzJ84R74L7vSUbuAzmV7wXsZ+X/0M9qPz1KGiQhxRA3b5Kl7sjDPDdNybKlwfOMB+vEboTTywKCqKRWvUTYKsj8l7jCQ8zQrTplddTVIxLstQog/FLfQkvu8gDkxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226915; c=relaxed/simple;
	bh=v8zoQZ6dwqd3xojwqV6vSH8uy1LrM8PkPp2K6MbPIqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JR/kOOi91G7KXQ/CL7eOQqa0ezCpvpN4TpwgXFD0W0rFojFPtHWSIY/y6AuL+GAJ+pG546gInYcWP5susVdk5Vrs1SHeWA2iCa5a7wl80aru2OpAtVs6HJ3FDrWmknU6I6+KGbVdzrkkxdCEg3/IYq7djxpesyTwsOpmHXNobZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IfxbmrlE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434ab938e37so35010845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733226912; x=1733831712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=on3sYEGd2/W0CVrqLqHMmcTuEZdP/rp7cfagL/Up9EA=;
        b=IfxbmrlEq/cqZnRsNzpIw3k4ZKN1AYKDms//u9Np+68kMEFfO82QqNFmCtJhIBQ9rg
         eOHHV7XJ6DaTmnVFaT/3ayaEtFDKCz1TDAVRnkICnOutUExmg90hUn7IPEK8aBlPGcjw
         nJt6YPntx1ghfjwpcXOQcLgmk08cXTcBizL712fE4CtXnwMRx2puZw7nbMgrmcTBabin
         JEmrloHTNsNTWZMG5AMOvkVPnY/+jS5rmdx6QenoxxTtZB5Yqvg7fGZ4NPQAdIF5rhyL
         BL38DQBZBZ0sRK96U09l10l5+98Doa1QouMpNKJNv6RnzwFTb1eGQaubvXyfX89LWoON
         DS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226912; x=1733831712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=on3sYEGd2/W0CVrqLqHMmcTuEZdP/rp7cfagL/Up9EA=;
        b=H+Cty09mZry8k9m2nBi2u4LGrRyae1AFOzsnHJf7XpZWJGLW0dnfIx8GMpzRe/2uLz
         f3yiWV7nfzN1EBejRuRJgFPzCz5Tu6zyKdlgeANxAXWZxlgQFL9UBaJCicIcJuyRtH1q
         gQJS/MS7L7LvwC2Qt2bNgKFIT7ikGKgG2KEaenkB4sDThQ3069oZvtaneaA+un8UIyB9
         EHoF5C713rXvMfP7ma/CcVAKAPB9wy3oxhA4N3r3lQt9X51KQV996xe7OJw1YJw1x1/9
         awWvL/48yepp0hLzwhY+uY6HP8aku9iM+HtrcLzvg3JKJdpHsTKJfIyYjSbhPHyJrKL6
         utWw==
X-Forwarded-Encrypted: i=1; AJvYcCX9B2auxypD5SnzOHGgWBO83rKEKHiRY0DYjiI+0GC+HukKODfHmdrsTyBpUAVX+34igieSSx4huITHZik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eat8oPOIKeCmh5lOhiRYeMGdYhPGC/PwGs+EptyVjWvKC2Fu
	ArE2AshQzjOleLdp3KV1frLsCcb/p7WhNV+3kzcRH+rHHly1cbNIDDiUT/ZK2v8=
X-Gm-Gg: ASbGncujLO7bdE06ZcpqtTYtDJFmXTuh3CjD1Ln2lifx+uGGuzEhc04Ny7aDawAHO4f
	u5qUWtqi6UYX/MBBQ53XtA6XoZ/Gi0riaiOKnZL/JoUcrO4HdP9JJsKmQ2RVsHOn7Hod06OnBc/
	XezYO71zmLw1y8IKM08w3J8QTwCmlDYtVgLp8qcDP9AkZo40SbyZxJTsO2IWb4pnFiX7dYepUWw
	xBTQ93frijDE0eFkM43O3f5J3/jx+8+fEgOvZ9inB1Lo2h54dqucg==
X-Google-Smtp-Source: AGHT+IEOoaKE+Jx2lB/U0/CuOwfrHNpbiVubl22ruotoapXCu3d/MzBK3IqvDfPWg35JXHbV7cl2rQ==
X-Received: by 2002:a05:6000:1ac7:b0:385:f44a:a64 with SMTP id ffacd0b85a97d-385fd3d0816mr1896449f8f.24.1733226912618;
        Tue, 03 Dec 2024 03:55:12 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36557sm15172989f8f.24.2024.12.03.03.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:55:12 -0800 (PST)
Message-ID: <ba893003-afda-4615-bf96-79b62bee51a0@suse.com>
Date: Tue, 3 Dec 2024 12:55:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/18] gendwarfksyms: Add symbol versioning
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <20241121204220.2378181-32-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241121204220.2378181-32-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 21:42, Sami Tolvanen wrote:
> Calculate symbol versions from the fully expanded type strings in
> type_map, and output the versions in a genksyms-compatible format.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr


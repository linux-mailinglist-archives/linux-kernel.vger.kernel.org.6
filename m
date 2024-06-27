Return-Path: <linux-kernel+bounces-232075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56591A2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D419FB2212E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCD713AA4C;
	Thu, 27 Jun 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYNPLjdH"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306544D8C3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480942; cv=none; b=SFDSP9jMGe1RlxDAxz6OY6omTK0zELHpnIT9ojcWidGtf/UZbXvpqhaDykOfAnzQdoM0QOv6OZi3HmfwtjC1ZS10OoiQnNbMtZiiKA773KRJgUF3Ww6wM4QIcZ9rG44lfTrpwNN31dW5H4+jyIA3aqsJBsd217nVJYswse6advw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480942; c=relaxed/simple;
	bh=xVF+/NQ6FBxRG3UMGHcJ5dkSaDe1Z1viYBqEY1PeBRk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o9pjCwRxEVu6BuN/fNF6lMjX3a5CnCE+EremJoGX+MeLuFm4vMqJXuCxuisaycW3OxnLGTOJIQRplv90oziRvoIv/YNhVma/m8Pq7YDG7mQY+OoOOSODRs1ul/k87vjt+bvbhYgkwgm6SMuyD18Z0eYVNYrjDoFpObvgSNWCutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYNPLjdH; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1faad409ca7so2557785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719480940; x=1720085740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXlkJ4byuNhY1OxdtQQCWbR2oVqHbP/kpXhyEnlbP48=;
        b=PYNPLjdHtLJuNQUFYMlfF7rASGTLiJPtMtNJtAw3vnl8FetJstRguwBakkhEZnr6DM
         SNezQ6RMAvX/XSJW2ywTAOiMKtgbc2uUvkxg9OERusHKTiIJZNsvjtsMf5sSUT+kyWay
         3eMuvVo1yuhPJcRKO9Q82ixmTkYQV6H6mqG4BTyhLoh1UUaW9+hfNafwbkycl3FOG1+1
         v1+/ISy5UmbXp5tEF6crs7gvsMXUyK+cC5vBroy492/79OfJlJAuboLgzE3PfaJvTMBp
         jrRUTwroN8AjBSp8BCU8RHr2GPHoalZoaQDszCbQWGsLvCk1mI2K9G1t/yuxs+Z4tNSQ
         rV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719480940; x=1720085740;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXlkJ4byuNhY1OxdtQQCWbR2oVqHbP/kpXhyEnlbP48=;
        b=luCwuPkvWeBozhr9Mc71ruHphcDbPjcBRew+COthMw7Ydh+pOWCvoybKnquYpW46Ai
         t0tTR8O7nMhjf/Ef6IVEtkZBjKoD0I3EXyHXfO0b4Ya6oz8iTylJiqNkeh/X+sJ5QyS7
         7PHbZj8nxJtRyCw1WMNxdoTYABtd/eIzRsM/5wADhluXMXgoFRdbQnjrebHuo6kZ8XQ5
         YhzKPmmEDDyDIT+drDbhxgCaiTH90q4Ce5XxdS3Ozn8S0FnpcQx+BEV8bEG3R/ty7FSP
         s/V+T65dCiFRj6SLqDvhFpVuOdzSvuAGBINbQPc0WuolYivEnPAPUeZg6k8knkhQq1us
         hn4g==
X-Forwarded-Encrypted: i=1; AJvYcCUo6gNsHFm0fwuMxha6UKhPHZ2jcY6mRg0DYDabowoauvbXXa6qsC8dBcFchMuqqEgY37YcMpHYyod126mXziEGZHFYcUn8nfPJ0j9a
X-Gm-Message-State: AOJu0YyGxNJZfj0qHW6D9us/0Xm4R1YQHic92wqGyuI/3tJVncEWoVpW
	dWCHkc2jiz+Y4MR/rdus3gV1ILIaZzKvMjs4qHKB3SRdHyhC3wxZDwTPzWZ9mJA=
X-Google-Smtp-Source: AGHT+IFLVCNKAo3CIqvXHbk62t3KgTprcj8Cnnpwdw3N22YyO1klv1GgNefbpUPx/KlnWsY2bqhTvQ==
X-Received: by 2002:a17:902:e889:b0:1fa:918e:ec4 with SMTP id d9443c01a7336-1fa918e1130mr51805505ad.59.1719480940219;
        Thu, 27 Jun 2024 02:35:40 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac979f54sm9033675ad.153.2024.06.27.02.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 02:35:39 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <8fb8d780-9e42-438d-88d5-8fe1495cf4d2@gmail.com>
Date: Thu, 27 Jun 2024 17:35:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Content-Language: en-GB-large
To: Andreas Schwab <schwab@suse.de>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@ACULAB.COM>, Felix Yan
 <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 "Ivan A. Melnikov" <iv@altlinux.org>
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
 <20240627071422.GA2626@altlinux.org>
 <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com> <mvmr0cin6vc.fsf@suse.de>
In-Reply-To: <mvmr0cin6vc.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-27 16:10, Andreas Schwab wrote:

> On Jun 27 2024, Celeste Liu wrote:
> 
>> suggestion and we found cast long to ulong is implementation-defined
>> behavior in C
> 
> There is nothing implementaton-defined in a long to ulong conversion.
> 

Ok, I misremembered. long to ulong is modulo arithmetic but ulong to long
is implementation-defined behavior. There is no type cast issue.


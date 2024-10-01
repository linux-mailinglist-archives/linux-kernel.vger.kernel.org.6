Return-Path: <linux-kernel+bounces-346090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F95798BF77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05567B26D55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21A1C9DFF;
	Tue,  1 Oct 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QWgh4C2D"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB61C6F5F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791967; cv=none; b=IN9dBc8VlKXCTOvP8VzTpF9VA+gb/8t8EJbRIbhbmEMiEYEqIeQDMiEh3Zl4+RqCSHORJNUjE6Kw1fjbCpN5F2LeRsX7z3E5K6eO9cgn/iX978rs9K2fdA4KijWPC8Cjm3FgBXfzeAdEpvskMevutBE6XTwpQkHZru4FUgpxRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791967; c=relaxed/simple;
	bh=zANKrDNHHPw85OVvoKNOqJRMnnY/7KTHaVV++XWrNQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVW0zAtdnTxPi+Di2pddfhfqUcUYFhgIu6Xw/XqHzg/rYVfYOmCH4eYhSOV6ApMZpIgqTNPys+CanVC3vLwvcDh/gYgnscz0hcanY+GCjENftrAhb2XYIklREPzhT0DD49upWWxboNKo4UMVcZYlkrI/Sfbzvnh8cKUwuP74WRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QWgh4C2D; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso848188366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727791963; x=1728396763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeoJTd250N86AwxT75TCft/ULiYvSUL27Dnc1hyjfJ8=;
        b=QWgh4C2DrgxG8VEkHG3EXtLpEVkP/ikONr6tZRKUxt38gI32nCdElG+xv/7OksKHVa
         jZHaw4WF7d0GXOJSP38L4e68jy5aqzHBX/r6BLSOYLKmlQhFfXe25Ko94c9EF9BcwWGh
         lXk94Tg59hzUdyee2pNLbYRSTA+5378t3VnFZP+Aap2jpuyXmZCrO10nVXiEoBLaTG+w
         Y+zSsgtXt5vihZiBpH95aXtUH0FUxiTVl1psEPBQ56Sl4ERo45HpDPp+z7fk5c2qOkug
         NqJGpyS4FkEgtQdZ6fpojR8qEqJ5dKMhUcKhyXOk/DcsTt80K/gPAiMmXwTZZ+2JYEI0
         nDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791963; x=1728396763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeoJTd250N86AwxT75TCft/ULiYvSUL27Dnc1hyjfJ8=;
        b=gs0oH22ESDkwrVFH1LifWRWixJvGQzN4yFtAv7Wpvs2a2QQJwukpKAFLagetC04Y8t
         +FxQBbHfmovLM30/tQ2RWmum8/JQl9od6lbK4CVKpBJCSaFbSJLaZSUKzMrVUODqBvsG
         w8WeeRcX3jThFRyGmtA28y+NWUG2PnsZlbTDdi/94Q3A4YDjT91M+wzW7MhvpW7Aamge
         9124L7uzBrjX1aYUTjvN+SVoAxDtSa75eb4xZI2gbMJw0I2Ymcb2pkyH/HuV1oXSSjT8
         qXEEy7Utq1At2bi3Fy38gN9VNn0beoUOqlggYk10S/qGopzCk+vWLfXAaEUEW9tfzY0Z
         1UBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrDa0vCC1iVdAkgSqnxAZWvrVQr9GGTva6OcuzhrbzLjdfm/q2OWFuCR/yk8u2cBhXAsD14IblJwI8TBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysnpkxOr506/cjzRpsdr3TxcLk8yTwocf+pV0sgyGPEIlqDot2
	AbP2Mce9Hyoov/X2+AHsvTS0QhJgB6/HB4hCF9mGLUQk4djTkb3vngaRh0bcEKc=
X-Google-Smtp-Source: AGHT+IFkBtWi40iUpXvMtDXyvuH4imak9CnOFIL9Jv+C/N0N1k9h3hOedmoIkMwXqfp0vxX1k3WfwA==
X-Received: by 2002:a17:907:d20:b0:a86:82e2:8c6d with SMTP id a640c23a62f3a-a93c4aefc0cmr1881927566b.62.1727791962932;
        Tue, 01 Oct 2024 07:12:42 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5af5sm717179766b.70.2024.10.01.07.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:12:42 -0700 (PDT)
Message-ID: <105dd859-f018-4b24-96f0-f395d53db9b9@suse.com>
Date: Tue, 1 Oct 2024 16:12:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] gendwarfksyms: Expand subroutine_type
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-30-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240923181846.549877-30-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/24 20:18, Sami Tolvanen wrote:
> Add support for expanding DW_TAG_subroutine_type and the parameters
> in DW_TAG_formal_parameter. Use this to also expand subprograms.
> 
> Example output with --dump-dies:
> 
>   subprogram (
>     formal_parameter pointer_type {
>       const_type {
>         base_type char byte_size(1) encoding(6)
>       }
>     }
>   )
>   -> base_type unsigned long byte_size(8) encoding(7)
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> [...]

Looks ok to me, feel free to add:
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr


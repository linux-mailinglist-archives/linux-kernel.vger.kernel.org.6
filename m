Return-Path: <linux-kernel+bounces-253708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6A9325AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645F9B21451
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE4199229;
	Tue, 16 Jul 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R285MnxX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814B195FD1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129523; cv=none; b=BQBDaPvxKZ2AvQZaQ/mtmWbajZRBGrQM2Ad+m5M4s0HU5q8XkV5yO0wNjua9p/j4BPu7hVb2VpGs9ylUV/KzC1r02nptNi4a6QrJPVAvuBspnBLLSvbelRyhopEc6uaCAcHBYu09I5qyRzhQUuGFo8RccaK9LcNg2OSaMtCXjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129523; c=relaxed/simple;
	bh=rlo30+owHu5Rt2jo2hgUO++4+6OM0lijE05ELQk0XLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7fgs8rj5yNgwPi1rLZp23YcIbYxrbVN6P87Jf+PU/NV+kDUzBkxXorSIywcRW7yi74ztSFbQXLwe8lArAP5CJMNHtO0Qh/SySHMqiPobkMgKRGkjHlUweF9aJaXQBpnH/Yqsomwi1Nv0eX+paGlnox5P/J7S43n7V8hOilG89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R285MnxX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721129520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wS8IhieGZEGOs6So34MinArqLEMTFaAJheWRiSUC3Ws=;
	b=R285MnxXziYg/NB4vNabpTJRmZvfRpC1J/+CUNB7rZ+gaaRMnI/NUdUWnTVWLZBrALr7e1
	uO2xBEzsIAQN+pZ9Xq53HXaQfZIxTCL2zxwtj39DYLBkBzxrj5eQ518CNxwNCDKqyLi9Gr
	C7XobAytnVKYchZwVUQ4TrUsyZcTkGc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-TQvCxFohM-iPXlCEjKWBEw-1; Tue, 16 Jul 2024 07:31:59 -0400
X-MC-Unique: TQvCxFohM-iPXlCEjKWBEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42660e2e147so10088045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129518; x=1721734318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wS8IhieGZEGOs6So34MinArqLEMTFaAJheWRiSUC3Ws=;
        b=E+E+5KlURFnZ22YTQkZlQ6zdPBfPkG28611F6/Na4sEfA6HV/P2gZys1+jWZv7E/8B
         gBrV6j3tJsM2YpEE2onWO61v8+E7sBc12+me5oHkMnLanXc+299UMkg5KGt0IuLqVARF
         /MjjM4E6FEDqeIM/Z2Z6tt3eLJ2a+FyvwjVyR+zhnjs+oIKchoRiEbkdNgBFKRRy/vyy
         RSw/bMzTa89fdBpATtK91CsaO4GE0/wOpwwk9PUnOKgaw7VF/iJHP/Jfk4fpKprF/mgX
         xDi+K2f6bCJwuTJKljVExkkzwtP7cGgJGK3VYbyjGNikapDMlkw6OHpzgv1LIPjO3YiU
         1QkA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Dk1DFsE6Ptq4I3joNZEcAVhDjlcaqybJHLpGCdwS3Yn/NkO5TcuEFm3u40QyHK4UtGiM6Fusx2TDxcS2o8ZE5CV0agJ4Qz1XTTDB
X-Gm-Message-State: AOJu0Yz5lR0xKLcV5SE1ALiZOMqzOo+PjSu/Z5F1qCyoxcXl4fMR2NVH
	Tkt6wlOoCu+DNd/2QpE2U58AXJHCsr1r7Of0BQEXa+iIiSOE1i4NXrQg5y7Phc6Hc5N7rpdD+Kh
	8/2jupKLtLwpg7Ui7ulTzohCyRa+aTr5nzcvYVXQdFLIMlp5T9JHGNXidS4Fb5Q==
X-Received: by 2002:a5d:64c5:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-368240c50b6mr1250933f8f.7.1721129517981;
        Tue, 16 Jul 2024 04:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4mlz5Eqf83dMPSKFCXM5jNJw+x1Bc4/Vh0VpL7NnFMTMQckuVWIERpgMS5Em6aSzgUuVmg==
X-Received: by 2002:a5d:64c5:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-368240c50b6mr1250920f8f.7.1721129517598;
        Tue, 16 Jul 2024 04:31:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3d4dsm8793172f8f.23.2024.07.16.04.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 04:31:57 -0700 (PDT)
Message-ID: <6d1a441d-31f9-4bc3-8856-be18620e4401@redhat.com>
Date: Tue, 16 Jul 2024 13:31:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
To: Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240714041111.it.918-kees@kernel.org>
 <20240715094107.GM8432@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240715094107.GM8432@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/24 11:41, Simon Horman wrote:
> On Sat, Jul 13, 2024 at 09:11:15PM -0700, Kees Cook wrote:
>> Replace the deprecated[1] uses of strncpy() in tcp_ca_get_name_by_key()
>> and tcp_get_default_congestion_control(). The callers use the results as
>> standard C strings (via nla_put_string() and proc handlers respectively),
>> so trailing padding is not needed.
>>
>> Since passing the destination buffer arguments decays it to a pointer,
>> the size can't be trivially determined by the compiler. ca->name is
>> the same length in both cases, so strscpy() won't fail (when ca->name
>> is NUL-terminated). Include the length explicitly instead of using the
>> 2-argument strscpy().
>>
>> Link: https://github.com/KSPP/linux/issues/90 [1]
>> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> nit: Looking at git history, the subject prefix should probably be 'tcp'.
>       And it would be best to explicitly target the patch against net-next.
> 
>       Subject: [PATCH net-next v2] tcp: ...
> 
> That notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

@Eric: I can fix the prefix when applying the patch. Please LMK if you 
prefer otherwise.

Thanks,

Paolo



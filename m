Return-Path: <linux-kernel+bounces-337187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7283998469F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E2C284BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E381A7074;
	Tue, 24 Sep 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC7vJwWu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2B1E871
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183852; cv=none; b=swVnt1KTjnNjd/spM2F8fqZhZCl4H7GuU8ZuBy3GavmRLqHXJXjdgjNa9phXFyB5KJP05SBFAx4Bb8nyFQ394x1sYwe9GB7FFFSgPkZChFp9Avy2fbXfUyJu8KB4vW27kWw7UshIQwaf/u/3LuDZVmiPTnF2R48lRWMSgYWimLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183852; c=relaxed/simple;
	bh=1in21SuDBEW74Rxiv4edWzVZdTwTeiWxyCb7NZIAj1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZUXTLf4qIDjzEcli+qbSPFqQQ2Z5E6Z/2j/s3P9C1p9YkZxP5o4KUlfID2AuAz3vh/rRtXp1dRIkxy5ZbIfKtLRD1qMgTLp9wpu37MyjH/3BMwe2cRUBHthHAv45cWKq6D7MN+yXqXIebrFGhcfghKCK8Iv9KMws3hJIZaFzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC7vJwWu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727183850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPlQ33SbBVQXStogF5r8U2TSC0bE2p7NNfiXWXG5gLg=;
	b=jC7vJwWu+y3RBlEBcZhVR7Cis+pM1hXIa6Z+iUwUn/HB85FbKHNsO64ayEOfu8gUWp2nir
	4Mc5FFNdIZ1GOyezoyGqrZot8Ldq9odw6c27Vi9ajaS0Pv3yQkeR2ypf3WXuY8XS2ezfSu
	16OAlTNm8Nv4vL/TcZY0Xb9fV/xcdR4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-v3JMaeQLMJS42xGWwiD0Eg-1; Tue, 24 Sep 2024 09:17:29 -0400
X-MC-Unique: v3JMaeQLMJS42xGWwiD0Eg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c32158d0so2955263f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727183847; x=1727788647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPlQ33SbBVQXStogF5r8U2TSC0bE2p7NNfiXWXG5gLg=;
        b=v0q+4AnDxetRN/mrWjkROPmvDsW/cGAcXp2wsPyQ2Wx/yyxyqfRr0q0gvFCYI4BQ5A
         KdiD0rhUZ1d+V++2VlMPmR6mk4v6vsgVn76Wjy/nNLUr+byf+UOJ/Xvl5bq5orq0YzPp
         rgbFvif5tLqTO8KiLty09sef88b615Kha81CP2AMABIn7k4SWCl6R0446DowzC/gdqAG
         cwpp5CE7U6kMJREi/yjF/UOUAal5kqg9Res/wrsQK7O2YuU0cNW7NAotrwIIInc6oW8K
         VbvnXRUj9QFUWM3hUTl/jxhUkeEAcRrun5s6B+ltVNQpAmLsge/vcABk4ubrIP7Tktnh
         kG0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGvXjBK91F8UUU/nShU43KnIHXOiDaLjuwyo4E3tX5SnsTxXx+DphX0beNZj3hKeGi61IthzN0+S3Xs8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSiun0U/G2Uj/Cej3fUskgGy02/0aHrMqdxYSLF1fXlcg3kxl
	k+myECVphyD1s7P7hXrNpSJddkWodKXz8faR34x4zPqopfroZdweqXEEw97UzyCsT0AdeeZv3IM
	YVjZeDV40aakwJiqUzhLOvAhso+Df/dVxg4x/uZcDjKVdL9oSwRbWabHoTn/4Zw==
X-Received: by 2002:a5d:52d2:0:b0:371:93eb:78a4 with SMTP id ffacd0b85a97d-37a42253338mr7379656f8f.9.1727183847456;
        Tue, 24 Sep 2024 06:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHalw2H/ZhllOsg2pD3AN9N0EesDvnXF5Zl23dNrjTArI5OrAQ61JSzlx3fLh6aL+0YaUxUMg==
X-Received: by 2002:a5d:52d2:0:b0:371:93eb:78a4 with SMTP id ffacd0b85a97d-37a42253338mr7379647f8f.9.1727183846970;
        Tue, 24 Sep 2024 06:17:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810::f71? ([2a0d:3341:b089:3810::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7543f3f4sm157246955e9.16.2024.09.24.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 06:17:26 -0700 (PDT)
Message-ID: <1b507e18-24a4-4705-a987-53119009ce3f@redhat.com>
Date: Tue, 24 Sep 2024 15:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Bonding: update bond device XFRM features based on
 current active slave
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jarod Wilson <jarod@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240918083533.21093-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240918083533.21093-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/24 10:35, Hangbin Liu wrote:
> XFRM offload is supported in active-backup mode. However, if the current
> active slave does not support it, we should disable it on bond device.
> Otherwise, ESP traffic may fail due to the downlink not supporting the
> feature.

Why would the excessive features exposed by the bond device will be a 
problem? later dev_queue_xmit() on the lower device should take care of 
needed xfrm offload in validate_xmit_xfrm(), no?

Let segmentation happening as late as possible is usually a win.

Cheers,

Paolo



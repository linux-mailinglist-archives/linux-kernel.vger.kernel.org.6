Return-Path: <linux-kernel+bounces-312537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5699697DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C241F22BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE01C7697;
	Tue,  3 Sep 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yMZSZH/y"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534421C767B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353531; cv=none; b=mbft34j30zGQmT64+fEQRbZAttYe1AikH1sZKn2YRXk68k8N7k2TA0Ud//UTFUiHrLBHMsrJnvyO6tp5JLyTeu2h4+yCl4wZfFXnpYFc6nJcFGGigprNk/BLtTKEBLVvC/SR+Nwf1IPdBdlz1nVmE0XC+n5qfxqq3mcIh2wWKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353531; c=relaxed/simple;
	bh=6kk5VlDisA56DTM4hfMpwZ8VjhenCqrjla/XVC0EZ5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLKA1qvcfgcpTocZ/7m31WESxSBeTmSosx+hbkM28i+UfolWu0hJj6ZZwNsMUJapUiEknHYqumZQfhckRycXJOFDcXurZTgNYOcLn+Dv3n/tIdvHrtkrFeLhtD4QIHBDoSDBzaqkC5iSQwxYaQ7kL9/3hhxFBnvm7MqYn1UVH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yMZSZH/y; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so5223238a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1725353528; x=1725958328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHMd3CmyF+UqSFpXp3YC4GWm8WtabyKorKiJxYaO3+A=;
        b=yMZSZH/ywxvJqJN8ZaDAS4Ehgkk6VOGVqZQzLDxMRPI6KcIpFZcUDlKW+UGTqycZmR
         ++NM5tBH85P4eSdL93qsl0SKbfr7+8zry6F5S1b3kUsVZcbQmDk0QZ8Kic/1+goAFGlu
         UpHbs70JnbX5V7IShap4imc67LDfcabZyLIe4TxFOdkqrnRqOMtfbM0cNDh9RPf1IN0S
         +Isl7JtCyqkcvk9g8MTWQ11yOhc16YYdIoGKgE+22k5p9mYbVwBCu5yh7xrFb2MyxH7u
         n+d6ns0d8hoU5i8HVwHY/iGoYCH6Fdl/7ZGa3z+TGsY/hxEbDjs5mmF4TGDNgrv0bbKe
         7QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353528; x=1725958328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHMd3CmyF+UqSFpXp3YC4GWm8WtabyKorKiJxYaO3+A=;
        b=Kp9nXSbh8+Gf7Gx0DW1E02l3/7a+odQcorKc6l4sOn9NBAe56wEGTzpL8xpUjdtg1C
         qdKOMhcXsFNciBfJu6SaWuFAoxnIPLENTIbMAyltO3UNug2gD64idv4Z3AzSGQAHfCRE
         sYKZxE9YMK/koSuWDh1r09GLl0GeIf/nb7aidFErEyUOqxB9RrzEPUFnc0U2u/ac+iLL
         D3l6/9mlrUtU9NvFotZppjOOK2XkobupqBqAQEzVEcZAnqTzSmeD+xe6rvnosqUdVwHA
         yqebxTjFGyc68NCun8nPGHBOc7UFL1NWibYbmh9SNw2pWvMzbtXLH4Wz36kY5kFUGGZh
         YwDg==
X-Forwarded-Encrypted: i=1; AJvYcCUUHfIZa4SsT5aLI9XuwNXrYspT8dBJQTwuwgNGRT/q/j/XQOkoN20x36PGzoYN+yHK0pV2t1P3evYn4/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxviFu4wInX5882IRR2QnbOo+XaRlQwuF+PFAbmTTXf/uJ18miX
	bb+iHmn8PaynCGx8LiT5/y/y0jBL7TopbxK6DbAIKG9/rCdzylO3r1KAr4/pk4g=
X-Google-Smtp-Source: AGHT+IFkGNoCxh3jtKQW1b/cJ+gceEuYXUIU4qroSCyryYhzcTuRXG2ufP1+eQ3YqWuMZ/KD+8npyA==
X-Received: by 2002:a17:907:9407:b0:a86:96b3:86be with SMTP id a640c23a62f3a-a89a3826268mr783881966b.63.1725353527069;
        Tue, 03 Sep 2024 01:52:07 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-30-236.comnet.bg. [109.160.30.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f6b9sm653684866b.76.2024.09.03.01.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:52:06 -0700 (PDT)
Message-ID: <56ef0a03-500a-4f0d-a231-25b1f7d58758@blackwall.org>
Date: Tue, 3 Sep 2024 11:52:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] net: bridge: br_fdb_external_learn_add(): always
 set EXT_LEARN
To: Jonas Gorski <jonas.gorski@bisdn.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@mellanox.com>, Petr Machata <petrm@mellanox.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240903081958.29951-1-jonas.gorski@bisdn.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240903081958.29951-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 11:19, Jonas Gorski wrote:
> When userspace wants to take over a fdb entry by setting it as
> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> 
> If the bridge updates the entry later because its port changed, we clear
> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
> flag set.
> 
> If userspace then wants to take over the entry again,
> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
> update.
> 
> Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
> if this was a user fdb entry or not.
> 
> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
> Changelog:
> V2:
>  * always allow setting EXT_LEARN regardless if user entry
>  * reworded the commit message a bit to match the new behavior
>  * dropped the redundant code excerpt from the commit message as it's
>    already in the context
> 
>  net/bridge/br_fdb.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c77591e63841..ad7a42b505ef 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  			modified = true;
>  		}
>  
> -		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> +		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>  			/* Refresh entry */
>  			fdb->used = jiffies;
> -		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> -			/* Take over SW learned entry */
> -			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> +		} else {
>  			modified = true;
>  		}
>  

Although the curly braces aren't needed, I don't mind in this case.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



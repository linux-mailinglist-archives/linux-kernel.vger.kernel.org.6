Return-Path: <linux-kernel+bounces-309781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830796705C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A551F22ECD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5879175D2D;
	Sat, 31 Aug 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="v4y634XV"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF329A5
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725093117; cv=none; b=u3W+Cdqq58Q4tjt/cp8/laG/JPExQgao68L3c8TMH1+eobCrlz9hbluZi4x+cP8OtTJdhAW63keNohcOH6XLyF9Q+YNqgvyehNGiaISocaXvQkjEzF6djDygw6H4RnA1YzxLF2i1F0TSzhB38k/laDZYT4X48OY6HNnwnGx3qmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725093117; c=relaxed/simple;
	bh=6QS03Af/MoBQ8a6Cs4bahqVKed0R6qgBy0cH7tmKUTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9eF9wk8XZiRApJuo5sDU+mq55iEC0pCdbdFNfpaQ8p55ggUSIMtW3OzZfpflmjKywGUm5/eLKQ0ooGf+BReK1Aospn8EB1+mY2mLBu4nR+cpIQz0NG+2fE92hZXh58T5hS7PVMHIjipsF7D1uJEbJNXqpWUNiWZQX6XlBxYokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=v4y634XV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so1380556a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1725093112; x=1725697912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOV1kiUJDRR+j9uQkiPHWDoz6/Z27FF4aCc5rgHaQD4=;
        b=v4y634XVnqVnsp2YxK+WfW8m57w96tT7aRxGZcx8z68hAOvcNplaY5y1VFQ2/OUY15
         O8atFx9uGvBpkg19U/vqaBI4Z31seMiEZ6y2ihU1yR9ni5f6cZQMCkmldm69MRIWiOrd
         9F8po+CiEk5aGPGsHv47QJd6qmYE3imfb4/ZrdmZBqfav2n1CWgMV3ZhO+jpuu9x3ll3
         9hKXmDrCQlF2R0sDUUXgn1s2eurLqXEz7222exdrPynDjj3vnMsYxflsSOkgDjuwkIYQ
         d5dqWibTQiHF9JfpqgMVW5ozOmXOIwIF+HSdfQOoVF6Ay7Xao0d2ln7pBqgEzg2OxJyz
         cYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725093112; x=1725697912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOV1kiUJDRR+j9uQkiPHWDoz6/Z27FF4aCc5rgHaQD4=;
        b=NjeHYAyeYvsgMBmBiogLmLbxXrDfSklvmCKwg4zmbCRRkYfKJORdDUcBsyGxl7I6Ah
         777drTOFOfWAuA3dX4pFSXhYcNqyjw++4EsbFymfJjXTmT+ZjOAbtS5ml3HjSmF3ThHL
         JzD3KPPhwWZ3u+DIEdgu+Q2f3ABk7p+swUCF4mCNwQdMU9MbX6j19GEvBHivmV0ICZZX
         y/Vv2chDvww9ZZo7iklnv4/xWfykRFw2YEabWfmXjq1H1cMArNSGOAs9z6Civ7p5Hu5W
         zGwa+T8/tC9SHTrSlWcCx3C/rUD0Fk7cB37M8YROyEy7rr8e8+i6ozkp3SGfBzteG6pp
         5Y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoneTzqcb2+nTg9Zgk8VLSPoXdA0ejIx/FFgTJzM5CqYWeRcHg05I5LdPLoMCQIVVYxO6EUz6/rHCphOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWMrrdhYdZ8EMziRPiSz+aBlYnL5ug/RLmNv3Yy3JWX1elp3y
	W3K3/OWsrMqJ843ByE8F5aAEhv5Li/X+c/hI2IbltT7LsCSfhA0SFi8ouVS94Jk=
X-Google-Smtp-Source: AGHT+IFNJzHWAkqlbN4tO19pqGtKh+I+2ux2PP0WqSEH/TbifvCm6opt7Enz3gSB3Aum6PuAkU7d2g==
X-Received: by 2002:a05:6402:d08:b0:5c2:1803:ac65 with SMTP id 4fb4d7f45d1cf-5c21ed54d08mr8440369a12.21.1725093112068;
        Sat, 31 Aug 2024 01:31:52 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a36fsm2731558a12.16.2024.08.31.01.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 01:31:51 -0700 (PDT)
Message-ID: <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org>
Date: Sat, 31 Aug 2024 11:31:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
To: Jonas Gorski <jonas.gorski@bisdn.de>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Petr Machata <petrm@mellanox.com>, Ido Schimmel <idosch@mellanox.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240830145356.102951-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 17:53, Jonas Gorski wrote:
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
> update:
> 
>    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>            /* Refresh entry */
>            fdb->used = jiffies;
>    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>            /* Take over SW learned entry */
>            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>            modified = true;
>    }
> 
> Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
> by also allowing it if swdev_notify is true, which it will only be for
> user initiated updates.
> 
> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
>  net/bridge/br_fdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c77591e63841..c5d9ae13a6fb 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
>  			/* Refresh entry */
>  			fdb->used = jiffies;
> -		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> +		} else if (swdev_notify ||
> +			   !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
>  			/* Take over SW learned entry */
>  			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
>  			modified = true;

This literally means if added_by_user || !added_by_user, so you can probably
rewrite that whole block to be more straight-forward with test_and_set_bit -
if it was already set then refresh, if it wasn't modified = true



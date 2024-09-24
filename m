Return-Path: <linux-kernel+bounces-337034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A44984470
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B686F1F23CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499FC1A7074;
	Tue, 24 Sep 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="I4mRZlgf"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071261A4F11
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176910; cv=none; b=o0ADnKy+YRYhJmW3+69lctiYiHAjBI7jeLC48CJ1MLKdsLkgpF9xqSXWNq4MrYr8OS+sOYS0FC9QDLkKEayA7y8WbdPz07VWvzGkRx6nw50hksc5eL0/l8v7meBKNTTzRkngnVAPIgUd2pQMSZftsXQmdg4FEoH252bceYxiTbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176910; c=relaxed/simple;
	bh=Jj2kY0s3nLvGSJk43H/8dQ6ptNHqz4lwqKkwB5lyxNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rw9ppiO4XTG4coT8HUbRXAQzRoB1nr2hH9rD28X/73x68YZC35Gb6ZGE8uKm3b4YBFcBD304oAKou6K7W1Ij6oKqnL6S9FtufJ51q8i8VU1SFqNBxipAhH6M+j4uQFA3Zj77gZapawcZdj9CUelgNMbyK1eeJ7se3HD8sZD+nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=I4mRZlgf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso69331681fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727176906; x=1727781706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3VQ/oBeOZme7i4I/7mHE4CNcL6txPF1CWfw+Th573A=;
        b=I4mRZlgfy7EdyPc2tI7OzrXslFHz5kS/x5LozXap56fdTyATrSAIORwv6Z6WdiPAvz
         sYVpTMtYlz02PsxWJXkifURYsvvw3wH7jhjwjF+bEZP0jtztKDbuPk1ZnejiRiIfDlVG
         k+Bano87Ja8rSMNvRee+bWTHBpcIljbUMBVa+MhFAgWn5jiiMeZC5KzfE16d1zhZh2xa
         t8kywtC5qUXVhWB5DvdKJaeZZeH/Zf5KaU1B2BKPzAqGkCqUOYrzVBLOTn3bI+9juau/
         fmXqZ07ANglwmHa9oUnhlRi0umw9tYlhalJG2/NlvIrMAhUQanzuGBwxs3S+184VIhGD
         wVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176906; x=1727781706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3VQ/oBeOZme7i4I/7mHE4CNcL6txPF1CWfw+Th573A=;
        b=ofmzHQNZPcxWfDkkAiyI7ufcEWwiHXmxRDv2gwneIIGN15/XTWhtcuMRWAVnOf3uSt
         ng2p45BNHwtjtKg2ZR/MFd7FgjsvH+unVxPaDsdffeeMwmUBa7XQvIjXoj2mXliplFtq
         D4K9+NupGIS5qx4fIjfqIOYXE3bK7w6MV4uqzIT6WLSczfkyDT+jLnZOv4E9i4S9PCiC
         YLRn4DS0NKwyd0ndkusLgKlEaBuGLTZOBA4+a0RXpvrOE4Co2yqFvTDUgu7l4TWA1ubP
         KmygJInUHgplsrST2oSIUVEGVyA9VxM+Xd3md7uUTAlVwq1Q7UKU9LHfK8E5I6xJE1pN
         u1GA==
X-Forwarded-Encrypted: i=1; AJvYcCXmGLC6Sw7qJhBcysV5c8uf0GZbNX0iijL5IiNUVvJjM7IAxAkHn+F0AUPWiPaNsIrfQ4v+afsr7U9bzRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAISCX4SQ4vo2TNeBi3Qk7Hwq1wGOfQ9pWN8LjK2QG5mK5qdF
	RhZ1M4SWhDhqMgqPv5e6DHukIoxrWH22eJy8OnKMgyoERkZI3JNfcNUEYblikzw=
X-Google-Smtp-Source: AGHT+IFk/otU7x9ha29AT1wwFhwBtrmwOZzPPA+MwpRBiO6fr4bhrwIYWdQcvPw2P2NZiHOtZN2UBA==
X-Received: by 2002:a05:651c:2211:b0:2f7:8d3f:11fc with SMTP id 38308e7fff4ca-2f7cb360354mr81843491fa.31.1727176905904;
        Tue, 24 Sep 2024 04:21:45 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283b661sm1905781fa.33.2024.09.24.04.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 04:21:45 -0700 (PDT)
Message-ID: <52874821-600b-4ffe-b4b4-9efbed6a3aca@blackwall.org>
Date: Tue, 24 Sep 2024 14:21:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bonding: Fix unnecessary warnings and logs from
 bond_xdp_get_xmit_slave()
To: Paolo Abeni <pabeni@redhat.com>, Jiwon Kim <jiwonaid0@gmail.com>,
 jv@jvosburgh.net, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, joamaki@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240918140602.18644-1-jiwonaid0@gmail.com>
 <29ef00f0-57dc-4332-9569-e88868a85575@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <29ef00f0-57dc-4332-9569-e88868a85575@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/24 13:20, Paolo Abeni wrote:
> On 9/18/24 16:06, Jiwon Kim wrote:
>> syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
>> this[1], one bond device (bond1) has xdpdrv, which increases
>> bpf_master_redirect_enabled_key. Another bond device (bond0) which is
>> unsupported by XDP but its slave (veth3) has xdpgeneric that returns
>> XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
>> To reduce unnecessary warnings and improve log management, we need to
>> delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().
>>
>> [1] Steps to reproduce:
>>      # Needs tx_xdp with return XDP_TX;
>>      ip l add veth0 type veth peer veth1
>>      ip l add veth3 type veth peer veth4
>>      ip l add bond0 type bond mode 6 # BOND_MODE_ALB, unsupported by XDP
>>      ip l add bond1 type bond # BOND_MODE_ROUNDROBIN by default
>>      ip l set veth0 master bond1
>>      ip l set bond1 up
>>      # Increases bpf_master_redirect_enabled_key
>>      ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
>>      ip l set veth3 master bond0
>>      ip l set bond0 up
>>      ip l set veth4 up
>>      # Triggers WARN_ON_ONCE() from the xdp_master_redirect()
>>      ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx
>>
>> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> 
> Isn't the above issue completely addressed by explicitly checking for 
> bond->prog in bond_xdp_get_xmit_slave()? Or would that broke some use-case?
> 
> Thanks,
> 
> Paolo
> 

There isn't much difference with this patch, bond_xdp_get_xmit_slave()
always returns either a slave or NULL, either way you'd return NULL.

It does have a potential to break some weird setup, but I can't
currently come up with one where bond_xdp_get_xmit_slave is used and
xdp_prog is not set, so I don't have a preference about which way
to fix it. :)

Cheers,
 Nik



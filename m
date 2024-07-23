Return-Path: <linux-kernel+bounces-259731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6611939C48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E668E1C21EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2914BF97;
	Tue, 23 Jul 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wf0uUh4R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334213D537
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722229; cv=none; b=PxW5FdppUvpJhOo5T9cYANz7FbTeCJmdrnU0dELgVctgDB1Ixxkixe4sOXylUDALqO3Ke5QpCKQpvRvBJktGEpiphyG7CH9PnZyM6Gkpw4dSWWtupnC9H0DQfag2wGlgP63XEyMKOJK6lhYe5u52LHDazcII7cjgqPOolaTb1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722229; c=relaxed/simple;
	bh=fr95nzY+lzdUkWWatT97wPFAB2Gx9SYE2jl+ZxB5dKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPgRKgVApNPUhRdKf3FXbf3872Fbag0yR8q+BbDjQNCC3BoFLrF2Rf42I9d+PrYGBfNN923Pzjg4EQUg+6NIfN+cO9ufXJZKgkbkDHJy05MNqjzgBJztS17JDNNbY6zYj0crzop7F2fhK2jEaYsBcJadr3hp+VAPWzqKg8uHDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wf0uUh4R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721722227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmxfs8F2px2yhrVgIx5UvLCzYzlb0R0xZ5URWUC/7Rg=;
	b=Wf0uUh4RIo0VmF7A7wtoPmFIHZ2h1b+5ehrOo1bVVX+DhdNI+sAS6hnF6vYojmVE0q2oNF
	3jy2Y1FyhNvl1JyZer3NXmdQ+3iLvV+JHAnR+yRT1TS37luiP2qpVqy/dY2xyzJ5GKgg3K
	g9Kf75Nr6H7c9CFVqxs6MJKm2iQMNBI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-yFXtK0m1PQWkm8E9AHyNFw-1; Tue, 23 Jul 2024 04:10:19 -0400
X-MC-Unique: yFXtK0m1PQWkm8E9AHyNFw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3684636eb06so631124f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722218; x=1722327018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmxfs8F2px2yhrVgIx5UvLCzYzlb0R0xZ5URWUC/7Rg=;
        b=iTtcDssFlDk1+s//8nVM4LU27DfMIgcaEi/TmLbPvoVorTXUTVfQM5wU29Bpi9VMYS
         CfzsVWN/RBqjJooE5zWPaaqj3kijA4YlQNoxz525V7dW0mhdN7ZAULxVLz3Ez2c4GZ2U
         ssxRujx9r3SsCBQGullri6hi+xJ0OzmlrbOnYyKvWqaGGtfAGWRkFRCQdX0xvOtQlxUe
         4nbgMxqM+L70yOy5/Boil4/pFX6XFV46sEabYEih0lBj47zQ7gOMbBjJ7T/QJGY1otNo
         /TAaCgWqp6jz+TX2F82R95yiL234ufQEpEjGxcn+DqpeWrr+4R4jQmFiJ7agbIUP1SdN
         C0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX1jXzwTbfLbnFmO0yHGlBmN/r6F031B5CddsDdgAMRy4x4ov3uI5hrEDmxnfe39T8Q+UDNfFcJbRNlvnxwkiPsY17GAk5CJbpYZJiT
X-Gm-Message-State: AOJu0Yx/rCfWQ7F/BrW/wi3O27yDhFtheUrQzzcCR0Yc5KSd2h0XzZAo
	yXcv3wWWeApLyOs4TLH20JJOra2eSuvxUT7vXY2y8fymt6chuisEi+5HbUs93MWq4F9kZuL1H9/
	S/WAAQi1Zc3IW0DnycFgunzBpJ0CJNAIRvlldTk6uvygMdXxJyEnrdscMbsICsA==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr42550135e9.5.1721722218496;
        Tue, 23 Jul 2024 01:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjCo1aNAhjviULscGaL8sACLt8gU7d795r1dvnXHXwpUiu5iTQoVlYIXQzwkKwd8V2YJAIQg==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr42550025e9.5.1721722218027;
        Tue, 23 Jul 2024 01:10:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cece3sm10602003f8f.69.2024.07.23.01.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:10:17 -0700 (PDT)
Message-ID: <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
Date: Tue, 23 Jul 2024 10:10:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] tcp: restrict crossed SYN specific actions to
 SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jerry Chu <hkchu@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 12:33, Matthieu Baerts (NGI0) wrote:
> A recent commit in TCP affects TFO and MPTCP in some cases. The first
> patch fixes that.
> 
> The second one applies the same fix to another crossed SYN specific
> action just before.
> 
> These two fixes simply restrict what should be done only for crossed SYN
> cases to packets with SYN-ACK flags.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Patch 1/2 has a simpler and generic check (Kuniyuki), and an updated
>    comment.
> - New patch 2/2: a related fix
> - Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org

Re-adding Neal for awareness. It would be great if this could go through 
some packetdrill testing,

Thanks!

Paolo



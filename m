Return-Path: <linux-kernel+bounces-252009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8A0930CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EB91F21319
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F155888;
	Mon, 15 Jul 2024 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A0W8db+8"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781AF19BBA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721014046; cv=none; b=alrSqFTjDYI8uZuX7oqfDhq+ukj1uAK5F32An0/J71gdrJG9WdG9qxUQUhyprvsD4lJpoKoqJeGpYVpBQ+lfJh+qFpBt+D6L/9/ZfDZeLLRFJOOegJFZY6Dn0asPgS3i78EqS5CfB7VB6MAz1yzhLyK0uQCvC1jClsevDp2qUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721014046; c=relaxed/simple;
	bh=kyIkJX1v7lA5+HeUdJdMHZkpUk0Nw0+NzS6JtqFZ5HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8u2nCdBfmShtvjEp65PHPmedV54XCRzK+B3BWpFK/spyY16rchfjTkRgNoLi4ntEEFSU9smH76hFjKot2Nipsa8ywZJPrpyiND6QyBVsRPFCgkwSU35AlifC4Ro9yJpXlEzsbhK4YEqLBiEZh626nwmMWahihgVGu+JR1oGkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A0W8db+8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb761b1f8bso2482135ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721014044; x=1721618844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZP/axc+gBCFSqEVCsib8cdZ4Xn37cX6cQ0DdIkRzRuM=;
        b=A0W8db+865zDt+IizYkWv1RjmzJvhIVpZuAswLiC5XDKHO0p3j8scVwGQMw+NmEnri
         GkbLl7Xifp+ugBEvSGnMR3/bfcmcgWThKamBAMsnqYvEOWFe7n6U8N+UcMJy4ToTmv34
         CiuznBhgt2BYXueoHil5bpvXz/sG+7ymA90r9VDwu38DmhU9TcRFlaeGXM+MYAQC2Qom
         TGM9xozTPloL2YsblDmblNhrZDIEh1aYcWEcbkmY5Eawd+nA+DmaOX8uYj4zJ0oNzufT
         03kmoEU56O//iklK4Jt/JD4E+8fnULpDKttM/y5pFTwbUHxCVH2a85Gqufwmgsf4zYce
         X9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721014044; x=1721618844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP/axc+gBCFSqEVCsib8cdZ4Xn37cX6cQ0DdIkRzRuM=;
        b=iUw9yPepCkxwvRhjADdsxVx+lnr3pUe2rKa4oP8cZ6z5xNP2G03kGiJsscG+tPtI0t
         espcoHu7LYnoA9T5zI4UJmjIMZqUzLi2Xc6QUxG1u3fHf91txFvxRzdNPwUgUPf19dPm
         uaq83DFCmTym2Ua4E+o2vIHId9rZnUbZl6lBYhUwhcgic88dv1zqG2AqB9/e6rrpdyaR
         YPYxq12UPpdOByBwc8+lZYG0kkfwKMvGfRjfDK5k/iHpaW7xF0HvVXA5U+ELukU9P+85
         dSBQguYAtv2ugkYk6o45Bpb//RPZ4ae8F+22/nIsZmCdPyEAvFl2G7LIhesO9V1Kwf8c
         3ktg==
X-Forwarded-Encrypted: i=1; AJvYcCUhg3KZvmNPsSlQh29v3h9XJQRmcWPAbWHYyveY45znSsWm72utdtq95yMZJztqPlb1AOtC4nxXX/9az6rU7HU6QBMNxFJrHyLQzmiy
X-Gm-Message-State: AOJu0YxEFVp6ACNeEt7uJ/Ar/DnKsfthkLM/t2rget4otbyoi4DCeXf4
	CqIgciTtDqGjz9RRzhd/gZMR+y5LVYvIwzRA/mKzeSemdidpnOGffgbvZG8+A417oM2puBs2vMl
	z
X-Google-Smtp-Source: AGHT+IHFC6k/lZB2NdoWGIoPN1nFUAspo0bJ/5A0BSU0BuzDtgM1Xc32+JlB6/n2JV/nWLjTwVvuDQ==
X-Received: by 2002:a17:902:e546:b0:1fa:ab4a:fb02 with SMTP id d9443c01a7336-1fbdc389e10mr111885745ad.0.1721014043669;
        Sun, 14 Jul 2024 20:27:23 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb9a364sm30970505ad.64.2024.07.14.20.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 20:27:23 -0700 (PDT)
Message-ID: <56a81429-4e1e-46f9-8844-acb1afd66952@bytedance.com>
Date: Mon, 15 Jul 2024 11:27:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Youling Tang <youling.tang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20240712032554.444823-1-youling.tang@linux.dev>
 <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/12 12:07, Kent Overstreet wrote:
> On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
>> to error handle the return value to avoid triggering NULL pointer
>> dereference BUG.
>>
>> The issue was triggered for discussion [1],
>> Link [1]: https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6
> 
> I see no explanation for why this is the correct fix, and I doubt it is.
> What's the real reason for the NULL lru_list_one, and why doesn't this
> come up on other filesystems?

Agree, IIRC, the list_lru_one will be pre-allocated in the allocation
path of inode/dentry etc.


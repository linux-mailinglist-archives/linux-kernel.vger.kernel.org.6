Return-Path: <linux-kernel+bounces-364813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2523F99D9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561E21C21765
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD15415855E;
	Mon, 14 Oct 2024 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TVokI9lr"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B573158538
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944676; cv=none; b=OvN/NV2z3oMBk0fBRG1WrgGZVUfHUfFpfZzkK9cn2pS1KH9m8LWzm1O/+fKs2X51cFkElcYbYOb/RfPSYmBuVs1SRR6LasDeVrGi5IvX7E3Nkd7HPnlYt3zaklw0DmzY8rg8/Rb0ypXMMTnVRrTxTnuWIJPuFc+ghYEq8sUL0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944676; c=relaxed/simple;
	bh=ktAwmyevO98oWbYObx8Tjj+HI86c/yB3aFGzDIddWJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkOiSKYAAcPS1+bsgY5/dWb2+Ii/H3Gw2ZxvSAzR8WRC0Al0h9jiDF8q7uWrvFZLIQ4Kx2XwZ/+WvwUvFGYgyk0nkaYyERRe9FA/FtWUi3n/EWNoTRnYqwgAocwHju5URknNOF42PyXEvo36dzS6Sgc4R8CFfGUumXSXfID7dTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TVokI9lr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso1333204f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728944671; x=1729549471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckgWCFQW027WKgN5jAosSmWvTt+ot1PMFeyvaWEixRU=;
        b=TVokI9lrwH41o3uvrsKVSmwAl4DziTmkL13rinV+KXYmC8OtFkMlAeMDnOWDvgG2aC
         1WSSDf2Wi/e+j/rnH3kWadxaX27psZ57VNahQRakGli/LzXNGQ+k/6nzjWg7rxCXota3
         DWRk1wGjQYPqMv33lLsWCI1tPO+psoZizb19jb38ruKBDfbz1qnL9R4mNKesjtAF1ULz
         i7LNMTetOD8uahCljsZv7OIma/GWN68VgQlbWOgyplmokopUZ3M/1eFQa+nVT2CxhCEg
         x0+sFahWQWvomJWhj6okaGSK76K2y1WW/KCKSGyCtulk33Wxy3Y1PBHrkyUdduNuMGP/
         waBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944671; x=1729549471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckgWCFQW027WKgN5jAosSmWvTt+ot1PMFeyvaWEixRU=;
        b=q/1Qz8Bcht9dLpnSEdW5t7T954n+jaRQTsCyKriv36U1w/1T/Rfdv7pW8ZbNENGwMo
         9zHmuICKsK/kHN1N3MKfhwhG5UZ1jam/tLoKJRvxfI+6xypOawc7OBZtR3AQmc5Kynpu
         AKE+nVtIhP+7ed3NfoQrBJffY6sqPGCnu4cUhTrrTiAnY567771r3oox98vARqhWOvHN
         lw0jaEMoxolidPAYoYkTcSPg3/fk07vtQKWEKI4679dANr/5s3qnH0PfKfBv/CIQijcJ
         SZO1dS4QhVVGJN1jad+NDCUnFwaxxLoBOR9L2Ug0rmdZhQuyAKKcLznwxmsMSUBBrPlG
         aWsA==
X-Forwarded-Encrypted: i=1; AJvYcCVvh5stwuMldPY23F1Dk9y7zOPhW23d3M0LkrHLlqBNyWQBrNMUEOFtQ6VTtOBVOickH/opibcXQlQZY2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0Tr1wtb/OQft3wKivpHQPmIErt0Rjzki558ZRnFvzyrZkEHS
	C4QB5T87sR65q7K5JhGSB4ZB62T6oHdLGEjjiR628vv5FRWgPqsTrxK8tn9s9Oo=
X-Google-Smtp-Source: AGHT+IEQomvdP7m32YYsQBNAvNQ8OxC5zjT2kRvDHpaaO8cZj0QxPiKr/UekWgIgfny2+pIy9TPIqw==
X-Received: by 2002:a5d:4591:0:b0:37d:4fb1:4faa with SMTP id ffacd0b85a97d-37d55313054mr8300515f8f.50.1728944671462;
        Mon, 14 Oct 2024 15:24:31 -0700 (PDT)
Received: from ?IPV6:2001:a61:139f:d001:dc4d:86d4:76a4:bf51? ([2001:a61:139f:d001:dc4d:86d4:76a4:bf51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5699fbsm524405e9.17.2024.10.14.15.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:24:31 -0700 (PDT)
Message-ID: <fd906211-7f31-4daf-8935-2be1378a75f8@suse.com>
Date: Tue, 15 Oct 2024 00:24:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] usbnet: modern method to get random MAC
To: Eric Dumazet <edumazet@google.com>, Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 John Sperbeck <jsperbeck@google.com>, Brian Vazquez <brianvv@google.com>
References: <20240829175201.670718-1-oneukum@suse.com>
 <CANn89i+m69mWQw+V6XWCzmF84s6uQV15m_YdkPDQptoxUks4=w@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CANn89i+m69mWQw+V6XWCzmF84s6uQV15m_YdkPDQptoxUks4=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 21:59, Eric Dumazet wrote:

> As diagnosed by John Sperbeck :
> 
> This patch implies all ->bind() method took care of populating net->dev_addr ?
> 
> Otherwise the following existing heuristic is no longer working
> 
> // heuristic:  "usb%d" for links we know are two-host,
> // else "eth%d" when there's reasonable doubt.  userspace
> // can rename the link if it knows better.
> if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
>      ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
>       (net->dev_addr [0] & 0x02) == 0))
> strscpy(net->name, "eth%d", sizeof(net->name));
> 

Hi,

you need to have a MAC to be an ethernet device, don't you?

	Regards
		Oliver



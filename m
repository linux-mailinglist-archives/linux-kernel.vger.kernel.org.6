Return-Path: <linux-kernel+bounces-408875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D09C8493
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C951B25935
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741FF1F6677;
	Thu, 14 Nov 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="PhCmhdkT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C11E7671
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571658; cv=none; b=m7pDaxkS0S+6tE6AIHyHKD3ioaMbyrml7NZdPXUxqUg5dbtnmVRV9xP9XIUg3l/o8xLitBb1Pe5LMD7F7mPhxop0QQGfmEqT+yynYuAchMF51H04z4oVnUHcgKlv7iZHDSqSdV1B2oaTI7q2IMv3D8LyNujk/4l4sNEUP6DkLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571658; c=relaxed/simple;
	bh=hSVg4Sg07+XwE9Y3hP3Ywg4pJOYxOfiQglazNaiSC3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHB+DzMLLBGFmGWov1GEZgva9/DhxvJwWp8Wew9QMcSJtsQ4MYtnwqpFj3CFjUFPAjVk71kLG4j/e9DgNjtRMgFHjRCMbouPlpvVxw9qzFMqqgaCoDUczh6hDfRx59KQSbFDiceh/UBa8UDzkUVNaYQ7aIwiyESOxLePJdPYpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=PhCmhdkT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720d5ada03cso263765b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731571656; x=1732176456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbZp2hSV5qfnRBrkNDRRtWA/m5PiZnh77UndzUHjNSY=;
        b=PhCmhdkTiVToVAC3A1zalcTueOHGJIFnpQXC+FsV84/x1SZBkoG7ek4JXBPiH0M+Jp
         9d+7LFGrHoaJKY23AmjfvsUIhXrB2ttOaiSSpRtkzVXftc4TdVe/Hs4EioHvvmF0q3To
         7ngBI0KRTmuhwiuXU6BK1omLg12osizbGFjhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731571656; x=1732176456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbZp2hSV5qfnRBrkNDRRtWA/m5PiZnh77UndzUHjNSY=;
        b=pwbTrPqpYejLsqpCBggSi7ezuRge4t1oQDNz3biSJFoqtNGXGpvTvbYTUY/OeU/8lo
         3V4Nsq6cdmMuVg6W1Aui7sSBujbCCrwD7asbRn4SKSq1uLKP1UzKj66calwmCvz2WcGF
         7ix6BFJTz8NsvGP3KoXe9yg3pakohKMlKhWgFEgAJXCw9CHjlgo1faV0bCu0EmoRyiqw
         Z1Pilz1ldhm6XFkcfY4CzD2NDapT1leq4N7AouHP3ocSkZ8sWHVpapZB/htHNxRw3+x3
         DHfy2amPTBMSVk/+FslBap2iPB8mBhbJ66Eg8P259TFsbgqWlLi/UFOm5HXYmYEtUnlR
         u6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXdeR46nY5+roUWViwfe28yzhY0P8c6Y/17oP/LV6ALUPqkaAMB46juZwDZ0QJZhXC3wkAYqCAzKhUNo3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrK8WAjA9YAzqzz4bU6qOeDBCBofV2v8JowRgHRZD4hdPEXp9X
	qMxXDF06Gs4JmKz/C3ZeSBXHyvn8ULkEoPOLtqhn9wkp6+4GGiWwZdhlHAKzK/I=
X-Google-Smtp-Source: AGHT+IEZ8+EwkzMjF1u7bzNUmHyWZha6bi30jiyzRwe+n6EDZ5DEy57jxaY44Un7DDtYMv+YTQkeGA==
X-Received: by 2002:a05:6a00:234b:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72457a71009mr7439292b3a.21.1731571655717;
        Thu, 14 Nov 2024 00:07:35 -0800 (PST)
Received: from fedora ([103.3.204.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a5ce647sm673336b3a.5.2024.11.14.00.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 00:07:34 -0800 (PST)
Date: Thu, 14 Nov 2024 13:37:25 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Shuah Khan <shuah@kernel.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] netlink: Add string check in netlink_ack_tlv_fill
Message-ID: <r4dex6aial4htndvoxv6wynccag2buubjimkkhenn2rjxmsacs@2sf3lieqe5ke>
References: <20241114-fix-netlink_ack_tlv_fill-v2-1-affdfb5f4c6f@iiitd.ac.in>
 <20241113182511.41960cc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20241113182511.41960cc0@kernel.org>

On 13.11.2024 18:25, Jakub Kicinski wrote:
>On Thu, 14 Nov 2024 06:15:15 +0530 Manas via B4 Relay wrote:
>> -	if (extack->bad_attr &&
>> +	if (extack->bad_attr && strlen(in_skb->data) &&
>>  	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
>>  		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
>
>that's most definitely not the right fix.
>in_skb->data points to binary data.
>
>my best idea so far is to rework this check to use nlh, because in_skb
>will be pulled at this stage for dumps
>if that makes sense to you please give it a go, otherwise I'll work on
>the fix tomorrow
Hi Jakub, thanks for reviewing this.

I'll work on this.

-- 
Manas


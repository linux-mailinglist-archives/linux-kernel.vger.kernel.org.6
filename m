Return-Path: <linux-kernel+bounces-185186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF278CB1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0438B22E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BF5147C96;
	Tue, 21 May 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SQL/+628"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031B1FBB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306759; cv=none; b=T/iMlnGMpCoIUWDtB4Trf1i+ohfUeMYtyjjpLBte+upCw4sYttrWr/w8qtC0SRZ/15DWqFo6ZD4guNQQtErSC1pHU0Z7AnuhoHnopVASBKy586GLtRWboEuXBhiZTVixS5Nufqa7TSeVWHE1JhFu18/mNph9l3cTNocFmxYYKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306759; c=relaxed/simple;
	bh=ydWfB8Ixx2WGgADol03f1VZf4M7vv9stY1thXdwwiug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZpKmGTvTbSBdVkF9lXGdjPwW3zvUkO0HMqzALYTcQXqUjnRMtPfs1k0GQCCpvEJGjERMv7v9ZXiNnOrHZ4+cvJ2mtvByRrXcK7mXnZCNaNvzzqYictPw8/tzbzaV1J3eQhEZlRytPjA+/xYoeolHk3kU0KIQWGEB9oxgsB60yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SQL/+628; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36d92f4e553so1574715ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716306755; x=1716911555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=SQL/+628XzU/iFw0p+1n/p5apKqFAR8URGHIFVH+euFdLfDLL2souMjSKPpEQYBqKv
         9hDyoN+KJqZM7d9TlKf/7Mz7Hb7IKaQAcy9gIvPnfdhavv+gKwhMafD0dFap3PM0vKXc
         Av4aDiMHRW5vGgbAU9iJ+1qVQ0/qieyrHot/fR6coa49jpoNuWMJSgzxI6Hg94c9A4Wb
         rE/nhVtAzfZabpc1OQuZMMp7kIHVSgNjbaU6NP+sCb6pfpKqdJ3pghLuQAnW5kRUjTTP
         e2qgNeP1D9hsvMj31t6ojW6cE006kOWJ8GcfFQynaMzSsp80tJB/E5MxmB0ruJAig6B7
         a6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306755; x=1716911555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lu6Cz3W/7JBafbJfSPoliRhPwzKJFkEKd4ea8AjEFNM=;
        b=salHMAa2Vx8ANgovMVMwMoWjNlIsvr1jZMAuUrBdyzZ44ZIH0nbRmwfhBx8p94BC0C
         025aANWgq2V0Hkxd18+/GbL1ebZZVkSLaikbFG7AjrPh/jjJ/80rbmoArKWDHBr8dqlc
         IbdTjoVclGDYJkk1+FkLi24ob3P/cA/2SU3ANk30+oYwReIUm89CV8sbKjleEjRuh9bD
         xnYndX+GvDmQaauHcB35KS6po9F4Y3CQbA8rF0Xt+iPXF6b3iMYSR+I1skFGjkXaHPc6
         tpSV66V4ZUI4gwSGoBvkCVotrk6mF102Cye9sPPJCUb4Ud3wtGRFZobUmgVZALm7rOIC
         R7ow==
X-Forwarded-Encrypted: i=1; AJvYcCW38O82Ojq0d6TweZD+RbKyuuxWLjt9S6I65J3K74xHymaSzFIkggZsPV9E24WgPNTzK0mfwLvXOdNAur/HLPilJVFEhJaugGELhhQe
X-Gm-Message-State: AOJu0Yxt/ZdPDXVhmhiD5hTQd+X2B7dTuIFBqFDOugJmyjLeXyaBneW7
	dLtBaZ8RTk8nw0LAKsEthUBwBdnpIjxd/VK53FoEmAqQirlwAR+B+LEUdktLA10=
X-Google-Smtp-Source: AGHT+IHa1zyl6cmZPdjySIykg2SQdYZupp88XF9rpgThrnqOxMjg4dDFQSMzR/ggbhek66vW9xxDQg==
X-Received: by 2002:a92:c988:0:b0:36c:c86b:9181 with SMTP id e9e14a558f8ab-36cc86b9470mr305103065ab.0.1716306754979;
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9e1363esm63659975ab.71.2024.05.21.08.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:52:34 -0700 (PDT)
Message-ID: <2e73c659-06a3-426c-99c0-eff896eb2323@kernel.dk>
Date: Tue, 21 May 2024 09:52:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
To: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Cc: Jeff Layton <jlayton@kernel.org>, Enzo Matsumiya <ematsumiya@suse.de>,
 Matthew Wilcox <willy@infradead.org>, Christian Brauner
 <brauner@kernel.org>, netfs@lists.linux.dev, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <316306.1716306586@warthog.procyon.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <316306.1716306586@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 9:49 AM, David Howells wrote:
> Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
> than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense of
> not waiting rather than synchronicity in the sense of not returning until
> the op is complete.
> 
> Without this, generic/590 fails on cifs in strict caching mode with a
> complaint that one of the writes fails with EAGAIN.  The test can be
> distilled down to:
> 
>         mount -t cifs /my/share /mnt -ostuff
>         xfs_io -i -c 'falloc 0 8191M -c fsync -f /mnt/file
>         xfs_io -i -c 'pwrite -b 1M -W 0 8191M' /mnt/file

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

However, I'll note that BDP_ASYNC is horribly named, it should be
BDP_NOWAIT instead. But that's a separate thing, fix looks correct
as-is.

-- 
Jens Axboe



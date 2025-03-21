Return-Path: <linux-kernel+bounces-571134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B3A6B9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982DF3B5F11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B4222580;
	Fri, 21 Mar 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0kS/I9nq"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B522171B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555602; cv=none; b=PLANhaUl5Zex8JsS6cau825IP4qQ2IxK+uzqszpSJvNAUmbnCR0mh4M1gEgxb7aV9v1dDKj2nEAMbqd7mDzv3kvdpOZPqCT8vmcpbbubgFiLInAi6EPnAvFTSbaAzh9C6NBq2NbhVMDZclpcapFzq7yu3wSIccd5tDz6pAvE07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555602; c=relaxed/simple;
	bh=Hmzep4r/qnqv6GW31fSKCsmKzGeRT4wJnCbWjxChcS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JDjMwlXl55HGQcqmoPNhwtmZ58R841aGx0JwgeUwS79k1TUyHhLMi+wlgPD1enqhy8wDzD1HcS5IZTD5nvIb4CDW0o1Pbe5j7257cskwcYkjxvSDxYLIo5sHLMeH2hGgltPvpUpgXF3C8i+9uKiopeLTckGe+ShM0FTAj980Tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0kS/I9nq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d43c972616so5160925ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742555599; x=1743160399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GU1mioN3yYu+dqCSLi0JNZys2k6P/lp2jvvl8BCayA=;
        b=0kS/I9nqO3NAUxktJG2RcocyuYVkyyP7jamU7na1KUS34OFrc8GaSI/szEztga6EAP
         WUMZRq+BL7VvkN4DFtjC2a9k44yiB6KfYDdxZu8rv33JY1EhN5kA+IhQUCO/Ya6iu5vB
         Odl3Gp/NE8Chn3uH3C0RAbVZfj1G6hX/E68jtBgyQLu1jiql1JgzugOlrn5GlPfHLZwI
         AhjMDJkL+nD9XI/7cCFryPdVZmv0SFTHevzArWOkAFLWLwqPuCul9RbE7zIvJDKPJyfq
         DkTU0KMnmLa8QGJIwqUFsxLcFyG9rG57oLxnY5tNjZIWoGoVTG5qdvp9lqqPyNoU/apq
         tfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555599; x=1743160399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GU1mioN3yYu+dqCSLi0JNZys2k6P/lp2jvvl8BCayA=;
        b=tghNo2BFD1OSlKlGn+8OIrR1D1uASMrASJOv53qK3CL36egCgFY9WfxibszXTLpA9P
         4o63GJ+M61KJtX6haKpDwFyfRsic6Tz+Dc1gl0jPsni+426FVSfh4F13PxHUtMWP0N4y
         mtPeaL1UG5AJSsbJIDXOmT0Fetxe+AisZzmWtdqBm5Wi5zcyeqd/ELmnnY7Gj+wBeOw2
         Hm3iG/ILBZweQd+QaqDowTrD77nxqqdWmKr3OvRa2r1015gB3WD/kPeVXII4updpXG8S
         RBNeZARS/MNzc/TnU9iVDs8teagxFYmzj2DbuXYXA+ox/i1aTMfrqsYJUa9/DwScEOxf
         tBnw==
X-Forwarded-Encrypted: i=1; AJvYcCV2G2ZehHrqAiyFS2fBcXI83gYrtsHiXCPhCtVF74rn/mko4Fn1W9Hb/kW/DeaQCcsm5QVgxtEqrTtqndU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ1gdDDupDYyEK9jGDkj+SGWHImXSw4LY5sPH8K2QKjrsLGZe6
	JmDJa7YPqhyiGVvRe93VHIcAZEtV0GU/Qfy0t1MvEi2nrAMRClSA16t7DDoIaS8=
X-Gm-Gg: ASbGncuVoQsU5SHuNpFIhUhOvVQ4l69+as6b/ftno56NUxlF0DtWhyXpU7KIHuhydwa
	8Ev1jS1OnsJRfsludUdf1XTfds54IRi8IcmbQiDcMS5vGD5dcqVRW5GFPNQMfBccA1ih/An+3tX
	PWBHjkNLj9rV47y43rs2GmOm1y+Kl0bSrEpPlp9/vsdHRKPdXHO17Tuf+u+pmXVTP2Vn+tC8lZy
	/b0+6M1EeQw1su3C3CeKoFaV9OpcDYUiK1RKWv2ZvRYBkPrcZh7ouITkEa+usNgzf0Z5BmLdkWy
	U/gGZsJuZEeS9n+Zqpex6E6Ie7wqIkDo+NnvhGvoLk3NOpve7hcE
X-Google-Smtp-Source: AGHT+IE4R72AbB+TfxAbg1d+CIr5rwWjI2An/4PBDvRcXhmPZW2MsPHBfXAQqwTzT2tbv7bQgxVxog==
X-Received: by 2002:a92:c042:0:b0:3d3:d08d:d526 with SMTP id e9e14a558f8ab-3d58e8f551amr57616695ab.11.1742555598985;
        Fri, 21 Mar 2025 04:13:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd15fbsm376223173.44.2025.03.21.04.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:13:18 -0700 (PDT)
Message-ID: <8e415edb-4d77-4e25-ab12-99f0e291aa60@kernel.dk>
Date: Fri, 21 Mar 2025 05:13:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9tRyeJE5uKDJAdo@LQ3V64L9R2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9tRyeJE5uKDJAdo@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:22 PM, Joe Damato wrote:
> Would you be open to the idea that sendfile could be extended to
> generate error queue completions if the network socket has
> SO_ZEROCOPY set?

I thought I was quite clear on my view of SO_ZEROCOPY and its error
queue usage, I guess I was not. No I don't think this is a good path at
all, when the whole issue is that pretending to handle two different
types of completions via two different interfaces is pretty dumb and
inefficient to begin with, particularly when we have a method of doing
exactly that where the reuse notifications arrive in the normal
completion stream.

-- 
Jens Axboe


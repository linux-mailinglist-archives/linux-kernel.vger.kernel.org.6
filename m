Return-Path: <linux-kernel+bounces-262394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412B93C680
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCCF1F219B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014019D067;
	Thu, 25 Jul 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YdpecnYi"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F21993AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921641; cv=none; b=oFIyJkDSCjo5LV98G2PQZRjWFWoHmPw4ju0grbzseuvYv658N/Xkbpk50PPDneU0doAq6TldlLDVupmfmd1BVjksjsg9ikQZEzLvKq+GmxB6+u26i2ym9HnTfy/YZqLqKVp+y2yadIuMjkZZxJ1I6gEfulnsvWFWTrVl/oqJ4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921641; c=relaxed/simple;
	bh=hcAwhUvz7Q1/dKBeCm7fGrp1f/oik+mo9ajeMqX75l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iDgxHkrHh79wjfIyASeHz48opyRWu4NLzmUEPPnAOj1/oxOavdt6YsxvJdxIG34iWt+uadTLh4MbpnuISWwmN3xWSZAXLRYjJNaZ9eyI7U32TTTeyrIPypS+lw40U/JkSfWVf2wSROsDmzmd8XAjgL2jcABF9zJOi1kVUDmFCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YdpecnYi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb80633dcfso154526a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721921638; x=1722526438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g53O1snI4oPFwCnbuNKYfO5V/N74kXxNW+Iv3dJPjrc=;
        b=YdpecnYiEy84VUoCWsyB/i/ioMQ6mIhEAKGQJYgH9JCFX9VEso4lSKXRSCVQJLh6o0
         lUHb1VhukNwhYAZ+t70oTeoUPG74nPiydOGwZ6EfkYnfSYLpZD0uqdcaYoLnHcHxKYge
         zX/578jCiOaOlXUZTgBgFDhTcnXCfmw5AhZpgn4nKHDgk+xxtaDb63z5VH7izpVB8qbU
         tU8ofttDDlFPCKtSRSHZ0YU8YKgKH0DfuQ7K3vWjATgRRWe9sZcT/uCDYwsaWSSlFkJr
         akEVoilPXrjjOOqj0tqHG9qNVZhqbUy/69FHFqUEpQiQ2yRiDPF44zp5TSGCU3PfRBGp
         zfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721921638; x=1722526438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g53O1snI4oPFwCnbuNKYfO5V/N74kXxNW+Iv3dJPjrc=;
        b=ZZnOjNRXP7auaOV2AQjGNTi6eG7JokSgCr3lIJQS+Yu1Tx9EnB4h4P/IaSRQCY+Ir9
         8/uMsQxNPz1cKWREvTycrtLo4zo/Kbh4E9DHLYP6jh7MYytKmeidAW2Zbrwrq3NiT7/s
         qjBfujRsSWRBKfS2mmcF5+bKN8y7PpwJZQfL1c7I2FAoKnKCDnj+F+4TiyU6R0cD5Ltb
         XSgQfmF8vL9LTB5zX2zyWU4X/6NbOYhPC76K1wgctZHh3fLpSB8c6YUk0sNlHpMXNdgP
         RN4opO53w8Xl3zJg9y5eOqvXLA2hBXBQ80f3k53SLluoCKVZjwMEj4KfgY9e55rH3Vrx
         kWwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/wN7fcc3NozUqF1Pj7T3NHv+P58JMvaD9yOYEASMcxJa5p6wt1rXWr/xQVRM9i6WUqHKa+UB19Ka+ThY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJg2u4CpCn5TKNVEVmg79FhXiJ2TRgVEaT5eCG8hCoQpGLUd3
	8yjGNPPd9dBy311Xxdxp96T/o6VO8S1xTURNIZhSRFgyVM2lQluYJwnWiq+d88s=
X-Google-Smtp-Source: AGHT+IEynBpKdaXa6q3tBg0iKHDslLDr5qjduvk2y2DBCWfufQXNXfHFcrhbIA8/bZdL6S308/W2HA==
X-Received: by 2002:a17:90b:f81:b0:2cd:1e0d:a4c8 with SMTP id 98e67ed59e1d1-2cf262e02f8mr1998913a91.3.1721921638031;
        Thu, 25 Jul 2024 08:33:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e8769sm3717131a91.42.2024.07.25.08.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:33:57 -0700 (PDT)
Message-ID: <5cc61aa9-0088-4bf6-8fd8-a47de626a805@kernel.dk>
Date: Thu, 25 Jul 2024 09:33:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_cqe_overflow
 (3)
To: syzbot <syzbot+e6616d0dc8ded5dc56d6@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000852fce061acaa456@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000852fce061acaa456@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: io_uring/net: assign kmsg inq/flags before buffer selection

-- 
Jens Axboe




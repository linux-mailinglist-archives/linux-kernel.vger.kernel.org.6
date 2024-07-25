Return-Path: <linux-kernel+bounces-262374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6CA93C62B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AA5282E43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283119D091;
	Thu, 25 Jul 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oyCN+ZRA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7F19D069
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920192; cv=none; b=OMbCBkRRUEagpH5dyuwqMIZibEnKDPInc1azWX35fTnxNta5lh6cFXl9WGI3ts87q4DeZT6FlU4R5D+6X8xAXHClM8pkJnf6UL70OLSb8eBbiyc5rl4U1MYah3g+0T6pMprkUP9kcWGpfer79S094v0929IknJ5BG3RA9zvhDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920192; c=relaxed/simple;
	bh=MS6Xoxn+YOJVUD4gGLD3qQML8Z0HGqpjFbs8eOGlack=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oty+ShsYR5JislQ3hpvxBKjLcpJiAOJ3P5LU9i1L3BgKKrJPBtjIILjMnNDCqHBKusQz6FHo6FzG/HI5Xvs96e1B2QRCwA7yLDhmyrfeEjBfh1OiUjsn4+PYHp1cDZWM48Qpk2n8DSCDVPrGxY75Kq4NNa1BojlqiDFclQJERWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oyCN+ZRA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2cd07869so113600b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721920189; x=1722524989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6i1BHgQZwRlv63L1Gqaq5LbuMpS4Suiadgshakn04BQ=;
        b=oyCN+ZRA+WoxVTdmFALTdw3R7wnDQbkZi+cmTDk5ntb4reAPdFNQiPARbpGLoodShc
         7DihqipdQ+a8Ez1XbX3Q7eRTxDt3yQFd0khAftaKSn9pOpYpN7jsM5qpvplLGKW/In7O
         nCFFVC5M3T+BMzYzSWC2U4IsT2JWo5HKiwNH2msaqSj70O4LNjwTJboMJllqWUNcSq4D
         ZIqUyNNHXH+VdbW50oPCSBmCLKpEycQiv5ZvNPcBUTtCX5pv6u6+KAvkI6dy2c3PWeWB
         299vQ4BXDAerxsxhG4cspgJBVbk9E3wGEPij9ciwA0Aay4qN5LTUUOPl1FPfze62HmAf
         rLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721920189; x=1722524989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6i1BHgQZwRlv63L1Gqaq5LbuMpS4Suiadgshakn04BQ=;
        b=jTd/NhmTE2FjZ0yE9n/GiI/5EwYvGs4R0KAvpALIO4E5yphKoQXttWg/g/KKKwbMXM
         os+IKWxPvWqV9htMruutqBLlFPCaDmA3kGO405Mx12Ab7E4nTAL5YtcO8qFeppqSUEPH
         ny09SHNUEby3A2itI4MCihchB+7PUP4UBfNkmhhAFxG1xcJySvF+diHrDKw/jzikHtO2
         2tsinBqAykdb2bWUHxKL5RzNmylKw4igNaar+2AtFOFyS7BCMpjZ0PVCoqntKcixl9jo
         zfzYoWgTQHOfjS251pVeNo/PzD2yt6kGZAbpSC+TRovY0Q5mpF9uQXQv514ceRoyakB2
         LAtA==
X-Forwarded-Encrypted: i=1; AJvYcCV448A3sypLrHT8IBqzm9yxFqC0w5RgHpWOM2Pz17YBcUllD3SzCFTy9GGyJPnfF9M5O8rPeuRUG2Q9vLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuQH67D8wng1JL7lruW+Qv1BrElgXbE51xFKblz7mbpwYHPxm
	OTE1iZcbjolv6foaEvU9ek6HX73TcSRISy6ACb0KwVk1kCeV9qDU9E31rTaqbWmaVMrP7ea9reg
	G
X-Google-Smtp-Source: AGHT+IHBPOYujv6C2Y/Huz1P8gfquNShnmt5LVcXeuI9I+/n4qV02EysyYv0jENLgXtTijrIgBek+Q==
X-Received: by 2002:a05:6a00:3e26:b0:70d:2289:4c55 with SMTP id d2e1a72fcca58-70eacb4ece5mr1816471b3a.5.1721920189287;
        Thu, 25 Jul 2024 08:09:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead87a372sm1231642b3a.166.2024.07.25.08.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:09:48 -0700 (PDT)
Message-ID: <d39434bc-430f-4c84-b1ca-1025f55bedb8@kernel.dk>
Date: Thu, 25 Jul 2024 09:09:46 -0600
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

#syz test: git://git.kernel.dk/linux io_uring-6.11

-- 
Jens Axboe




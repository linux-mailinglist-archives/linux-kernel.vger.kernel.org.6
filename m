Return-Path: <linux-kernel+bounces-265419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF893F0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626F3281152
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75A140378;
	Mon, 29 Jul 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Px/GhlI1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7513DDAF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244738; cv=none; b=KImdHgI5HAYypw0S6z6PwEK/auODd2XR8R1lmL3t87O9UlCAY769QpgVb22qVIre/O6p2nIwQa7beTPKyiq0d5RidiO+iglzDWcjMZGwUJ7viCYjWIqjlJjW/oxsCfZ7kaU38i9qJy+oMVtCPXygMj0eDwAh44eD5HipLyObwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244738; c=relaxed/simple;
	bh=5r3fxAG4g4laolpFoGhmEDZc6wbbuEOFScedWUPcaP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxQHHPjBkfoGspIY3VMNAhU/MbYUDH6Rqb4OlnyyaVSLFkEYqc585kX3rebD5oNexrjfTwAngM9rD7n2AJOoq6cPs0Yu/G5kak+3G8Gh3ARWT3xdIfP7wDCl6G5eGfHzpVIoEEU6fwf0ny+lNvQUZ5ZK2aHn/W20QCn2kE1KPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Px/GhlI1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70eec5f2401so616058b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1722244737; x=1722849537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdAE/yK+gUuSfcs5gVxoPZ6y5I3vp0voLS2APYoe664=;
        b=Px/GhlI1LkZkCzb2wVr9ShJdWR3OG1GFbrZUpz/LtWv1ytErZeH/b3uxsFrBjk5bKo
         KQSFmcWO7mvqQ2105L6KsYGJ7gwocq3TAvUz7qLryn263NO/L0CVNm+91zhmHzq8yzsZ
         MgDfc2bP3bjj2yYV65YGiqInIUC+epUi8DeaUZSHM6d41KlMYfDwCcMD+TkMZnreXj1g
         r6k353UoN9Pb8q5/EtLQUudBx5k9vQNX7AQe9sAvvjnnR81Lj4rvf2uAyypaCzYCku6v
         LYoAhj2tB6/9hHaBws+lKolZgSsIJ9FeNwR6qbFpe4ywCQdVZPjBE+YI1Tq4Pvfk0du1
         7sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244737; x=1722849537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdAE/yK+gUuSfcs5gVxoPZ6y5I3vp0voLS2APYoe664=;
        b=YyUyt+2ITLpb83tgvhhg0dbLW5pw+TEb8IHf3uFLuVwUD0Qeoci19ZhPiyhZMPWGJ1
         jMQzXO5OqlikrKfWYgZ9TLfDfiQIsYcX9hPc3j4BeWcfjJOqcqPjxq/ghtAZpUlkQZOZ
         QH9paxawKe0MgWLiygjpkGlrddg2Dct6R6FUWnm/0DR1A8EkU4fz0dvrxHXc81I0MBOQ
         GEhKRSGEiS1zddoL55mM9xRPosgjdcZgSfGy8vjI43pHd3GFmOe+uhant9WPg9FtQgEC
         SDwrfVioRSyaBPf2KpB4FYnmSICMveDdO/imoO1Ji9EortRVKLUiUWPHBgxhe1ToxDjn
         QWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDug40QqbNfh3B84SjNFrMypX5/shqtUJR4rO6RRDDCbkFNru2xxzs4C80pTywwvngNDDv+W3O6tAu+a27kP/XhgKdtztW8WcqKhoc
X-Gm-Message-State: AOJu0YxZOOIWTUTXzLoxYx3oJ3YU7Pju2TQHTHWKel19F2VFZGNjeGF4
	D/QJYYVITSB71h/SUMlz+p47ql6/PvBwMy4Lb4WEjwhv+8a7MtiNEurqQmjIpys=
X-Google-Smtp-Source: AGHT+IHTPQXzqz24j+2hKrgTp3s9jmn+bgbEWhbJcYhBdSFvLyYV1tgPzryl34QRsdT5NH4pnTBHvA==
X-Received: by 2002:a05:6a20:2589:b0:1c4:88ce:c996 with SMTP id adf61e73a8af0-1c4a14e6af1mr9573959637.46.1722244736766;
        Mon, 29 Jul 2024 02:18:56 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee2f21sm78016425ad.154.2024.07.29.02.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 02:18:56 -0700 (PDT)
Message-ID: <80b9a201-3417-4532-a695-98bf5313e52c@shopee.com>
Date: Mon, 29 Jul 2024 17:18:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/writeback: fix kernel-doc warnings
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, axboe@kernel.dk, tj@kernel.org, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240729020606.332894-1-haifeng.xu@shopee.com>
 <20240729-endabrechnung-proletarisch-4843dd0ea1bd@brauner>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20240729-endabrechnung-proletarisch-4843dd0ea1bd@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/7/29 17:12, Christian Brauner wrote:
> On Mon, Jul 29, 2024 at 10:06:06AM GMT, Haifeng Xu wrote:
>> The kernel test robot reported kernel-doc warnings here:
>>
>>     fs/fs-writeback.c:1144: warning: Function parameter or struct member 'sb' not described in 'cgroup_writeback_umount'
>>
>> cgroup_writeback_umount() is missing an argument description, fix it.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_oe-2Dkbuild-2Dall_202407261749.LkRbgZxK-2Dlkp-40intel.com_&d=DwIBaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=3sAi8IhB62KzbeV_8pr_6us5hrO-Gga06if2AaD4IQo4VIdWPC-0PKIGoZBqxcE1&s=8yhRcJ4dpQqgNctjFIIXg2P-2gJxFL66FZoYu5O90ho&e= 
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
> 
> Unfortunately I had already fixed that before applying. Thanks though!

OK, Thanks!


Return-Path: <linux-kernel+bounces-277183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2B949D92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01520B23A59
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFCA433C8;
	Wed,  7 Aug 2024 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRXJYRl1"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500B3207
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996258; cv=none; b=TlknCkmQA/nCSjnoaLPne7yzi78wUDykWq2mvjsY29hRMb1CqnsDlgYDrMk+re9oxLg70drLT4wHGgjHJD8Nl8zxlvzYDdYrIbqb/H+8FjEB72cWXbZKkds7Wkd3vj+LhCMzdlAEVCSVgDR4937WXVrD0VW2UHzSQZtNCyvhFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996258; c=relaxed/simple;
	bh=j1+KDmwhDT0ovp2KNt67b9uDMMYSONC26ydNlsJtJ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF20Uq2GpBt+8W5o6YzDswD7lExvhjsmKVWsPMTE+BZbL9rbaqMfxiVdV2pdNyQjpXL5VUXYbTJptn2eQH1KiTxVoFhPS7uFD2IsbbvcqFQvNKP178lontsfOi/Z1KAixM7cNHyMJADAsA9Ghzqs1es8WQC5XaZj8rsayyc4fUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRXJYRl1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a130ae7126so935027a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 19:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722996256; x=1723601056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnwtsWgIWOm7bbmjcR5dE7C77RAX1hPWkwnS8bzzLUs=;
        b=JRXJYRl1MuXQK5J8XOWKrVSVZp4D/wAogGu6kzJP3j2C0M8cFZyWC6z1LoQeipwUFR
         yNd0MLPWJRQhD+r3rb/hdOg/if8jBdbuz64ZD/sMfrr6YEeoXUQ6wu6coVPD2ZyvvmQO
         AjsMgle4kcuBtl5rxYBP/45fjfXM1MzVK9WoYPxngHQipQ7QXPoQfui2XCbKU5CN95kc
         m3kUe3kMLNIn8IF5vcSeEu/JTN9VcSa7bmQEIQC9DOrqyCZNjCa2UmY+8mmC/F5ldeOK
         /lViUO0qxG4tSgme4ksjcminXihWR7cSECEqnQIvK1UYT3Zn6yROcdAyaKiJpVRjl+HP
         c+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722996256; x=1723601056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnwtsWgIWOm7bbmjcR5dE7C77RAX1hPWkwnS8bzzLUs=;
        b=HhNNOin1e+TU+37O22SacJeUUegG9i/+/Zp8Zaf4jc0MYEP0sIddEaLaFr/t7AVYOd
         irxpxgTAcx3n0+GjhEVWtlVkuuzp1IjE03Ye/zllQuq6N/gbcQnJAnWYlBAou7Ybp6Et
         q/EAPpxTOIMqB9doyG3219A5eXq/atPPrbn1BeyXmtMbUmNosYj5A/bYfTIOnbwxkiR0
         +yzpJcEqknbzTgAtNIjpqsG7j1VbApIoOMTykvWx+cSSX4UaqrIli/Ui/fOzyl9Lfso/
         s557Ud4/HQku/s3YgNAn18u68l4X2HFNbetQcEuRr4WIwaec7ibuSZAw7qlVfQPjJY3Q
         ukjw==
X-Forwarded-Encrypted: i=1; AJvYcCVP82BmVuXhX5SMO7um8YqikiAS645ciFZ6vLfppSZM8h3/BIBnLih9kBm/7SB/6WZAG0K9ReA0bI1vc58GFQn+o4RRIFefXBR3lTFP
X-Gm-Message-State: AOJu0YyzyWAkjmsJdcVwj+iVUjWkRoX3Ae3tsa6vX1h9Z9tmOzcQvl9R
	2Nrpyu7vwVy0pEu/gGKQO9Hle5JbWc07RQlJeH8nng/70hYDrZVc
X-Google-Smtp-Source: AGHT+IExTU/Y3iyG5wPqxtTVmb4msLWD/tFRZXKZfkmX6+bNDjepUK3eO1+uwd2V4JjZDtcm4VUKGQ==
X-Received: by 2002:a05:6a21:e89:b0:1b6:d9fa:8be with SMTP id adf61e73a8af0-1c699628475mr19344795637.40.1722996256461;
        Tue, 06 Aug 2024 19:04:16 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b764fb52dasm7502510a12.60.2024.08.06.19.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 19:04:16 -0700 (PDT)
Message-ID: <c1793a38-b8d3-46f2-8f21-85e691af3275@gmail.com>
Date: Wed, 7 Aug 2024 10:04:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Matthew Wilcox <willy@infradead.org>, Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
 Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 nphamcs@gmail.com
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <ZrJ8hzC9z4NMYffr@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ZrJ8hzC9z4NMYffr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/7/24 3:41 AM, Matthew Wilcox wrote:
> On Tue, Aug 06, 2024 at 12:34:25PM -0700, Yosry Ahmed wrote:
>> Matthew asked an important question here that needs to be answered by
>> zsmalloc experts:
>> https://lore.kernel.org/lkml/Zq0zucMFsOwATsAC@casper.infradead.org/
> 
> Yes, and I said it needed to be answered before we had a v5.  So I'm
> very disappointed that not 24 hours later we're seeing a v5.

Hi Willy,

Sorry, I don't know the reply time meaning a lot here.
I tried to reply you:
https://lore.kernel.org/lkml/86e97328-a784-4320-b634-c582d5a10aff@gmail.com/
And hope for more discussion on v5.

Sorry, I will hold my horse, and slow down for version updates.

Thanks a lot!
Alex 


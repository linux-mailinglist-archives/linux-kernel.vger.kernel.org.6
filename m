Return-Path: <linux-kernel+bounces-443905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1FD9EFD50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12269287ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD161DE2AB;
	Thu, 12 Dec 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FTtJkKzc"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C71DD0D6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034776; cv=none; b=sU5auMCewVBRXOTyxSXzx4ZHz9Q3lHv2J6e098NLuaNXAYfDhJlb6TRMX0lOva/xW5nSUcI+PlegXeyomAtLAvirBHWuzb4F4voCYE7juukW4+DHb8vYAzoI8gcdOxwwDbx+Fkwr5OkgNmIkMsdRpnfU2Iy8+3bN49lauA+bKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034776; c=relaxed/simple;
	bh=bxNToVr/eEUZvLdB9CPyWXMAoqLRgngI0FOKeD8wqT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW3CELFXiqEvB1xzuAzNHaBTil3DoxaJnM6HEwiWwvDC7ztECW/VLVIyqfq7j4dKoUQjCWyjCrHjvKn+t5zyDeznomyaFZyGQOP5tQkQhvt/WV0mJqiuWCYqDWuyAeTfzLm5MhsYNTUNfhnaWkoLhFK1wSooAOXieq39jEZW+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FTtJkKzc; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a815ed5acfso3744445ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734034773; x=1734639573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amQilKkF88h59kyKbvwGPPw4Lr0cJFGcTEeJ1cmutA0=;
        b=FTtJkKzcDmaDlX65b0uV6iIotPhOKVWWNgKLqlcbJ3YC6LJfWlfcaR1cnJJd7FR7AY
         qf5i8g5N2Gb2vqKWG6IoZR11HT3J1oj68Jh6Idtq13vaFkNULlHHGEddKc7CLjpAV26l
         5OlrPJU8l1wxmkyHq/KCjfmdJ6Qkgcl1eFPpXmipkU7dG8P6pI4gb9xS48JtfMscVpQo
         Ru8oVSl22vBOSKAvI4CMLNhGzRrdL1Z6xWHgGVn3imXIkDeqQCh0si4yuO3Gl4zcUje4
         kdWn0/dYCa6fPTG4LegIQNW3IBIfY70vCF71fLRVtRkLdRACvY4i3rPLxTukvigCTaQ6
         dv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034773; x=1734639573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amQilKkF88h59kyKbvwGPPw4Lr0cJFGcTEeJ1cmutA0=;
        b=PpLHtsOTkvNo/rQd8v/pvNfaz9H5295xej3GaS5XjjHyhP5QPqSQRpjrrz8MM696P/
         YA3iQQ9wNtcwNAb9/x6gt4uupLJ+kW49d4YwovDRb8S5Hd7gkBqzjE1BMFdcjINSClEY
         Kws0CavEmyxe1NB464bLI4GXCPgcn0owXXEHdurvZa1xQjSoS9e/EsODiiWBTCZo/XU6
         EYh4QnMwB8g7WNMQO/4eFCgWjCOZ8y3vAZz7PmiKxtH+Zk1eFbmbRO4HhzaMC7CLCFhM
         +okO+UuKtkEH8DtjUqye/aBgOgQ2ourl+4mK9AE4aq3a6vrjsIg2p54lIwRmR9qi8ys+
         Ekjg==
X-Forwarded-Encrypted: i=1; AJvYcCWz4NY098UPoGifta0HVDDgRlVZPG/JBHXfKyOr9Wje426aenLHF2tJ5HYxPGFu7s7t5jFtz+JUTW/e5i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYz9WTctl4D+mOC+7ILG+W6CcMg3i89l+jtzjDPaLsO+3QpXhV
	Q0dd/FBgvRcavIxGOYRa8+6FfiyHPghLTNnk975tRJ+oobJ6we8G+l2RhMsRzj8=
X-Gm-Gg: ASbGncuIC3nMIRJOXabOW8R1BNqwZlk3xYbpmPlApHyN6ZgNWlPQvxdpy+2AA8HVqQs
	htCC5xotbCRC/CGLVbr3Pq/D3uHNND6bd+9T4i16WqQAv5uDBrwKu2Q0n2iDpOSm+lQ+TWWm1uT
	NRr11rI4uRvS1mlbcAjIy1RHfa5nJ1gbuNOxpGikE09itJVk55y5GDOWFIwhyEpotw14MSJPGbc
	0gJw7EX08ifTpjvVthFg3S1nZPci/ihBFF3g3M3ra16rizJ66NS
X-Google-Smtp-Source: AGHT+IFYch7UbRH6nqpKWr2p6Fzhmge00pAqGBgdIHbczzkzMGdbctA/OntbbR3AfoqtbufuALu+LA==
X-Received: by 2002:a05:6e02:1d03:b0:3a7:c3aa:a82b with SMTP id e9e14a558f8ab-3aff62132bcmr2335035ab.1.1734034773169;
        Thu, 12 Dec 2024 12:19:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm31018885ab.41.2024.12.12.12.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:19:32 -0800 (PST)
Message-ID: <c0fe9c00-f9da-44ce-a339-c36dbab25c46@kernel.dk>
Date: Thu, 12 Dec 2024 13:19:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-8-axboe@kernel.dk> <Z1gkNiD2wJbAdOfr@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1gkNiD2wJbAdOfr@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 4:21 AM, Christoph Hellwig wrote:
> On Tue, Dec 03, 2024 at 08:31:42AM -0700, Jens Axboe wrote:
>> Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
>> given folio. The caller must already have locked the folio. Use this
>> new helper in invalidate_inode_pages2_range(), rather than duplicate
>> the code there.
> 
> This new helper ends up the only caller of invalidate_complete_folio2,
> so you might as well merge the two instead of having yet another
> invalidate/unmap helper, which are getting impossible to track of.

Sure, missed that it's the only caller now.

> Also it is only used in mm/, so add the prototype to mm/internal.h
> insead of the public pagemap.h.  And a little comment what the function
> does would be pretty useful as well.

Good point, moved to internal.h instead.

>> In preparation for using this elsewhere as well, have it take a gfp_t
>> mask rather than assume GFP_KERNEL is the right choice. This bubbles
>> back to invalidate_complete_folio2() as well.
> 
> Looking at the callers the gfp_t looks a bit odd to me, as it is
> either GFP_KERNEL or 0 which is a valid but rather unusuable gfp_t
> value, but I guess this comes form filemap_release_folio which
> works similarly.

Indeed

-- 
Jens Axboe


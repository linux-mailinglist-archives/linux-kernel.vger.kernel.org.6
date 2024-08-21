Return-Path: <linux-kernel+bounces-294936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5595946F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A9B1F24720
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9C416E860;
	Wed, 21 Aug 2024 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JxzXcfUv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5516DEB4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220989; cv=none; b=gbjItp/unyySJfomsv2MnPBoaeW7HURRyeTHNOZwkBhPLdG3/8dmBmxUF/1SHzMXQJNZQsjqzyvqGcT7YIOpvnWmXvThZuTvMmYV44OhAXztDCOLOcjBLq6NliAuMg3f36wZUlJMg1bcgnAjuBB2wAfeZsptyP+E8+un9lsA/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220989; c=relaxed/simple;
	bh=TFCz7PQJhvKH/U686Gug3qL4/gmui/CXF+yBlr+kKtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2pXC93jXIBaSMTIniE4I5KCnnZWEGbgvuipgCuVfrk7KE08bogMUz5XDlUD3EcLctkn1JniH+gqxBF7uo7QCAEh8PvxRG/0vFvy+6aWXFjgSmHuA8FvOXMGcIOw0a9ouD4hHd1ITnQu7lGTp7FvNieeBE+HNMdDZ7+ng2NFwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JxzXcfUv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f381da27bcso492051fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724220984; x=1724825784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P4gcxzVu5ZblE5EZdgIWz1gVNiyAoJspohsbbpxAWw=;
        b=JxzXcfUv7NjW/PRdkYYIyyUID5FCAm6mBMx9Y4CboIvK83s8tbSDg0t9hV7F2VLNK+
         tmPBJ0evDubsssHiSj5qX3jGoAkCSwIEQbn4k5bbOpPG7w9q6Mr/Gq7imaXPXfYshDXT
         PXD0IzVhJeDxOcdccFy50HoKZCv01BceOg8C20I508T9pl2GbqmalhzD8RFevbeMdYEO
         p1kJU1Dsgl+Etj3mXQvwO8rovtyoIDZ9AYEtdDMBK/qKmRIP1PquOWMda7Y8cAz+F5MV
         rc+j7528KpSDB3zSpOQW/BVYprI1i2BO6j5maPMjbtFEpl7V1oQesrmg0Dplq/s+ZvIH
         h/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724220984; x=1724825784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P4gcxzVu5ZblE5EZdgIWz1gVNiyAoJspohsbbpxAWw=;
        b=ZAcwI/cN46vO5VRiyn/C0uSris23swauzfoYB1siVX5kO9FsvzKvsVUtLg1gAlQHeI
         rWuUMwuhPaHReuWFQ02wBN12h1bwx21FicdsGG4zX6pPaMisuldk5fCme/AsVFSR/0RB
         qGtO9nrdT6HfTC0PQlH5rm9n6dizAJa8MCsp4cDZE/1dlRhj1Fjc3yiSZSQrzQw95PfZ
         XtMw+yEeHfjrtImJgF/PAEBxEPnYEZwvSf5zgC849EVrnzX5pt/55HpjLgWP+tLbuZkQ
         YBuxgaJ0A6C3OFDUmkQKKfKgc0o2qElbGikBV1KAMoYVbIzuZDDv4C1nfOiJFnsyxaae
         2KyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL1kUit8+S5a0kHsIwGcsCVxx01D7oF0rxij+JFBbBkFf0QL+WUnaQfCvtLCV/rZy7ka+ks2bc1ZG1/LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPcbKvQX7ei4d3vH/jgeZFYBg30U0gKiy+/jAfhc9w4EXh/uoz
	yFSxlcSaT3b1opIubx/LnGbp+dEqOl66KUnP3d8G1d3STYFlAftKl9ffedhi/iM=
X-Google-Smtp-Source: AGHT+IEurWlDkBYCwKYc8PABk6orI+cY1w8eBbYayTY407u5x81wfTTYFYytldOAJ71ExMNirgbCdQ==
X-Received: by 2002:a2e:be9e:0:b0:2ee:e196:1486 with SMTP id 38308e7fff4ca-2f3f894c99amr5506261fa.4.1724220983530;
        Tue, 20 Aug 2024 23:16:23 -0700 (PDT)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af18899sm9182877b3a.155.2024.08.20.23.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:16:22 -0700 (PDT)
Message-ID: <1c4d5baa-0ee9-46f9-b7d1-cb69387cc0d0@suse.com>
Date: Wed, 21 Aug 2024 14:16:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Add i_size check for dir
To: Matthew Wilcox <willy@infradead.org>, joseph.qi@linux.alibaba.com,
 Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com,
 jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <0000000000005894f3062018caf1@google.com>
 <tencent_EC9ACDC0793A6F742D7D6FA094F0E96AEF0A@qq.com>
 <ZsSvbDxMtUEHEldl@casper.infradead.org>
Content-Language: en-US
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <ZsSvbDxMtUEHEldl@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/20/24 22:59, Matthew Wilcox wrote:
> On Tue, Aug 20, 2024 at 08:08:38PM +0800, Edward Adam Davis wrote:
>> When the i_size of dir is too large, it will cause limit to overflow and
>> be less than de_buf, ultimately resulting in last_de not being initialized
>> and causing uaf issue.
>>   
>> +	if (i_size_read(dir) > OCFS2_MAX_BLOCKSIZE)
>> +		return -EINVAL;
> 
> Surely directories can be more than one block in size?
> 

The key point above is that the patch uses a hard code value, but in the real world,
the blocksize can be smaller than OCFS2_MAX_BLOCKSIZE.

-Heming


Return-Path: <linux-kernel+bounces-203120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDE8FD6B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA371C251B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C5153598;
	Wed,  5 Jun 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eAmVbb/u"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EEC13A890
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616805; cv=none; b=B+det4gLQ1p7EqDvGzHqLJusfmNZ14NK7ZmBTe9Ouf4g3/Si2WczNYN+2UCB/CGfqsGsmhsARGMtepO9/BtyA1kIaevENZ+FPO2KoCUB1K187uYqqNMvnmuk1KH5izxd4lFQBVpmdsWPYoBSWup6tT8gvTAvZZ6nAVooZZ6YyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616805; c=relaxed/simple;
	bh=byixAgaiWPDCvx3+6gMlnQeEWY61IM2nOM4M0algh8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkOWLfKIPN4tnPXNeySrpPMcPW3aqFQFXA5Sqz9noqPgMNEB0c9bUblIEMWdhQFsbI82Qs28pqjZBf+G3YAwvbW3AEKWVA26CP+X6Tham7+VqO8hCfptJ3hurB5r7dabq8ZxbmT0SnSiPBX6jYLu3M0n3z8KVkSyCuMg6KGlepI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eAmVbb/u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35dceef4227so174577f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717616800; x=1718221600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=stehcdZI/Gy2nyTFG+72BIbqVjW6HF+HXyMXn/9m6NA=;
        b=eAmVbb/uZieR5W/RdimcRNCRnGGtKIaXtVTwTNt4fWo/UfaAqc7YdC8A/cOQ+Sc893
         Nqd2/AQunRApZPkmEjJ9bXdAyOg0o/FTHvUZIcc1wGcg0mPvL3gP7oibbRf1Ky/fA2R2
         SrV2IYOv+OEJKofoDMcsNhe8tAPcKX8UHDUEMuF/cKN5fiDZitGsDtvpUaTy2+syCt/J
         akAF5d9Oi7sZjqQHeV9841/zyhGt4Zkgreue29bzEin7GSqobTvngLw0gW2lHUHpbBEC
         /tJ+iXNISSndzJkj8XyvdHvsRNGsNf4hM+2V0CPUIMEGbyf3eWczLDvkdH51mGXYYQxa
         FVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616800; x=1718221600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stehcdZI/Gy2nyTFG+72BIbqVjW6HF+HXyMXn/9m6NA=;
        b=R67/OVKC4y5O5TGizNkqhPXMexPvVsgGjNCwkrCxzSmzBrERz7wzYjaZwAH7ts5Npl
         pk+JUv1IFbuvY0RRbwW10P2H9lLNV1/3sYvWGYoWM2qBMU3scxtv1OX/zdceyowQODSl
         6irmaUU1ejAmflqf8iiPc3GwoFCyX6S49HozBtye+IC5tU6ILx3O8a29X49HhkGbrKBl
         9vFEFan0e914fafQLtwc2pmw0gH9J94KX6X4YjcS2z3J44D8kRPsdH1zwzdIQH8OAQMW
         ZjUdhBJS/sXnkV+RZ2gnmFfQMOfJVZMTMGDYTAJu+Cj88AdyfRfVw87TPjC/6HjWmZiI
         Iq4A==
X-Gm-Message-State: AOJu0YzXRkW5CJQWqvhsyyJCipVqKbhonh3UDGzvCd0pca9KtH38Afbd
	EsT5sncaoSxeVYHdtGM1WAweJScrsAJo5o5kml+xZRHrfxKBKIvkPtqOl1I64w==
X-Google-Smtp-Source: AGHT+IE/Wv+E0oUSRgXqf2NyYcYZed8RbYVFvLdlchKRe+KXCE/QWMz5FQEw2UcXBwdufl5Zm/iubQ==
X-Received: by 2002:a5d:4cd1:0:b0:35e:7d29:cb6e with SMTP id ffacd0b85a97d-35e8ef5f882mr2628239f8f.54.1717616800268;
        Wed, 05 Jun 2024 12:46:40 -0700 (PDT)
Received: from [172.31.7.231] ([62.48.184.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35eee5ad98dsm1435174f8f.11.2024.06.05.12.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 12:46:40 -0700 (PDT)
Message-ID: <7d55b65e-331a-4ce2-8f72-d3c5c9e6eae0@suse.com>
Date: Wed, 5 Jun 2024 21:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86: WARNING: at mm/memblock.c:1339 memblock_set_node - Usage of
 MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
To: paulmck@kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
 <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.06.2024 21:07, Paul E. McKenney wrote:
> On Mon, Jun 03, 2024 at 07:19:21PM +0530, Naresh Kamboju wrote:
>> The following kernel warnings are noticed on x86 devices while booting
>> the Linux next-20240603 tag and looks like it is expected to warn users to
>> use NUMA_NO_NODE instead.
>>
>> Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
>>
>> The following config is enabled
>> CONFIG_NUMA=y
> 
> I am seeing this as well.  Is the following commit premature?
> 
> e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> 
> Maybe old ACPI tables and device trees need to catch up?
> 
> Left to myself, I would simply remove the WARN_ON_ONCE() from the above
> commit, but I would guess that there is a better way.

Well, the warning is issued precisely to make clear that call
sites need to change. A patch to do so for the two instances
on x86 that I'm aware of is already pending maintainer approval.

Jan


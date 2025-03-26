Return-Path: <linux-kernel+bounces-576544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D44A710C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06F73BB766
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7F18C91F;
	Wed, 26 Mar 2025 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEEJq7Mf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA642E3370
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971763; cv=none; b=gzTKBZk2ed8pkEQKIlnLDVbBTkIluN14fgVfZbCSAwNCEIZsLxhPu+EiNt01ohORAr7/QyB2A8PsS2t8lbUJIhnd6dYkj/j8dGAfWSgLnXhmkwkCE21ISf8n6Bz0+lpUFRxth++OC5d1HN/V7RC6Cxk6/8d/bUNQFhQ82H2YQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971763; c=relaxed/simple;
	bh=ExRiG87UIuriNSR8dgS2allplnnDA/O03BR7ZJJ9hzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+DjuNrGfvUfSEA7fBh3r1ngLfM8YDGQH9CLq3Jj9e8A0Nf6wVnyeoLcR1L6+L8JqbGhoyxNuVxGXU0sLEpjTIP2j4ip6SAEAr1lqwP12ytsBJ1wVNjvHqi44JC79979os5ZrO+iCvm6MOGLLTRItuNXjFgxG/IFOHQ8AP0ukKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEEJq7Mf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227a8cdd241so9591795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742971761; x=1743576561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh7lxlRUUOBOSUbl27AL3W8RZwHT1ywyp8vFcMuzW20=;
        b=QEEJq7Mf7v/ZdJliqAFj8bbH8azmVCf//O0ZKBhGyCLSudA1oig2DcL2owJ0NbdMf1
         tJiBbU6olAAU6yKwRpnRScD6WNRSI4ZdjEjoRkfBO1oRkHu9og0h8h0RzZWvIJT2kRc9
         HLTg/vxpkHC7BkCsEk7UKpqMJIxTPnuddVtBA8uuy3VXzvtJp3XZEKpwq+wpy1v6r6ZW
         vduowf+CJLJyZZJ5l1PgsWr2ymztLs8r5gDvFQSi8sCU5ehnPLHM6e3ZZDZ7nR+DEF17
         QF2jO0iwPZFEX08Z/BpdjxY9Ct7PgjZsV7vdgLeOdldo2lULjgBpXnHrplByR2/DiiLH
         0I3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742971761; x=1743576561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh7lxlRUUOBOSUbl27AL3W8RZwHT1ywyp8vFcMuzW20=;
        b=kuAdPx1KeekH5Jnkk/LttIygCDO9UxXGC2+T0fKWX6owcKm+aUFLHkkKSFQtOT/rxO
         6yEvs/DvnKaJNtoOE7CkMg+vYF3eNvk7Qcj5e9xJBEhS7V27rC1vxz0QUvio69R1XvET
         1M9to75j0sf7A7FUoc5p/DeeuOnaJOazAjxk5Ugx38RPf2yDiWbbSFe/CahUkfg3puQN
         Xl1ZxdufW5ydz6b5qaYcj8iRdpsxSscV81n3WV15u6vqcClZe2oW9zhS1Dkh2yQNvd1E
         y3Y5MNezApgWRlTT6DbPSYlKPV28ZmLb/5AcbjXF8YR0kVNNuxTJ5ZFWv56HCI+8eKs0
         CuoA==
X-Forwarded-Encrypted: i=1; AJvYcCVZQlQUi/14jmX3v8ZUMe5rrJ5jpDypgCFlFk1C0Wmt2FSK6ZSFQ0borbItpw9lEbI1bE+tVUnbpXx/jrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsqe5+CfPX6jnnZK15RPKKJVpzz8n246z9DVAAF4pWW8ALLn90
	6iGehieB0JfjHYn77KF/COzTbyowWO8Cl4UUuJaA8uRuJQVjPCJ1
X-Gm-Gg: ASbGncvW+OHwSiXNdS9ucsu8+ZudpBbrZqPjUy+XRSSj10hIIOro4eAllQ2DPIVSX2M
	kusBKmsWNjgz3CWk4uotKhxFexTE3bYUxrPJgWGCWB/6auWaEpurmYaHSOsI4Qi4eYgf/4evX6N
	ZZHdvqNj9rUxh6LlxzZ3uN04vcrTVPv0zyf8ScZzGEhTHa0ttruVIa27cVb4B9zbvs3Mn+cpKwY
	W1NZjNCsnLuYoVu/wmlj1xmooR95lAR7NFKZ7wsdQy57bpIOC2o7QeX58aVvbF+NCZWSA1B6av7
	Lw83O9tqJMV7Cevd9xuP/ColePZp5g8E5QlqC9MhGoEPMMzD8dQBiQ==
X-Google-Smtp-Source: AGHT+IFgJ+2HbBGQuEYg1ZxuSUeSMUKWIvlavb6kWqrkz+KZUW5NOYqROMfup/1GiG2FdRu6kiom2w==
X-Received: by 2002:a17:902:c406:b0:224:10a2:cad5 with SMTP id d9443c01a7336-22780c51255mr320743875ad.10.1742971760798;
        Tue, 25 Mar 2025 23:49:20 -0700 (PDT)
Received: from [192.168.0.239] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f66cdsm102246675ad.219.2025.03.25.23.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 23:49:20 -0700 (PDT)
Message-ID: <05b7ed03-60d8-49c2-9094-4f34903f8a64@gmail.com>
Date: Wed, 26 Mar 2025 12:18:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: Initialize dirty to prevent uninitialized use
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250325194920.53307-1-purvayeshi550@gmail.com>
 <CAOUHufaFz=G+0o5c+u9YY-4n1KExS6_tOFATY1TMyWWcrAQ8Ng@mail.gmail.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <CAOUHufaFz=G+0o5c+u9YY-4n1KExS6_tOFATY1TMyWWcrAQ8Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/25 02:05, Yu Zhao wrote:
> On Tue, Mar 25, 2025 at 1:49 PM Purva Yeshi <purvayeshi550@gmail.com> wrote:
>>
>> Fix Smatch-detected error:
>> mm/vmscan.c:3509 walk_pte_range() error: uninitialized symbol 'dirty'.
>> mm/vmscan.c:3522 walk_pte_range() error: uninitialized symbol 'dirty'.
>> mm/vmscan.c:3600 walk_pmd_range_locked() error: uninitialized symbol 'dirty'.
>> mm/vmscan.c:3614 walk_pmd_range_locked() error: uninitialized symbol 'dirty'.
>> mm/vmscan.c:4220 lru_gen_look_around() error: uninitialized symbol 'dirty'.
>> mm/vmscan.c:4232 lru_gen_look_around() error: uninitialized symbol 'dirty'.
>>
>> Smatch reports 'dirty' as uninitialized, leading to potential
>> undefined behavior.
> 
> Thanks -- this seems like false positives from Smatch, where the
> problem should be fixed.

Should we make modifications to address this Smatch error, or is it safe 
to ignore?

> 
>> Explicitly initialize dirty to 0 in walk_pte_range(),
>> walk_pmd_range_locked(), and lru_gen_look_around() in mm/vmscan.c
>> to fix Smatch error.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>


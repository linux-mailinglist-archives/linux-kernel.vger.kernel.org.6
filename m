Return-Path: <linux-kernel+bounces-556013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0730A5BFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C526A3A4790
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB0254B10;
	Tue, 11 Mar 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeUBodPy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CA241673
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693941; cv=none; b=K0l23846JPIeviMTeaiQqExVYQTQM0NVAzsX9I9hiZl8B8/4Q+QQJ05vpGDlB3H43E5wWIErIGVZK4PiwstHqlnWrZy2EoI8g+uORKq7gWSmXv+jz6SPidDU7N+33XjECoqCTTmDx4sxtWc6aZ6w+FdhaElg0UIa+z6KLlKfyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693941; c=relaxed/simple;
	bh=9IqtKEODNteuyBEfdYsxTudpbxaMaF4jvqN39c8GxZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUsXAnVGew/ytQM8XX/grblQwTBP6fXWe+291vGaN8HobaxrXniNdWLnV/+EJMwSvPdX0bBHpp2NtybpCfF5NOphmt2y/lxhV08CSu2ghTGY2Y16PpFT8YUMTgAV9ziXAqf8vn+3iZjqAgRFE/uxvvwfnByrHE20+tSYm3P6ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeUBodPy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741693938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9s6bJNyvpW/J0wi25GDNc/BWEItVflufjwp7UtbTuU=;
	b=GeUBodPyh4lXvQgp6ok6i1pmKG0a38VTcF4WsBVD2JPRBB3i8Dmhc8X8cRVE2DSbbvXx41
	Di+o8vJeBrIqCVHnzmQ5EY5B4EJvJLwOCBsDFUpRH6hb4NPiN1L453E2xxA7LH5gF5t2W7
	fUpsP1mpCYDhSC5s/eM8FjA217hhc+Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-9K0UEtr1MGO_fIDPqlWzpw-1; Tue, 11 Mar 2025 07:52:17 -0400
X-MC-Unique: 9K0UEtr1MGO_fIDPqlWzpw-1
X-Mimecast-MFC-AGG-ID: 9K0UEtr1MGO_fIDPqlWzpw_1741693936
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso12843277a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693936; x=1742298736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9s6bJNyvpW/J0wi25GDNc/BWEItVflufjwp7UtbTuU=;
        b=l9Yty2qHiO+wRvbrzITfPB8CzVzpxNVa1k39GUKzL8rL0OR+Vnx+HOCRATC185yWDH
         iOa3et6h66xyvxwLVBRoDsbpSxkgefloV995CA+J1bYRlFUbk1nGe/WJjPuPFxWRVBzk
         Mrpf1kCkslkKeGIrJjTUuIx3ZMTs1pBNetY3hePcDN3C/gQF+VMIM6okAFWc32cg5lFa
         qWRdc+K/vjwMMj0lUFVfzpRlFzqwkVF00yE+oqVUS5/t33RhySCQrl3Temmu4l5ekz+f
         w1lm+AmC5/TRKGEFES90B/+likHt445KHKaQWGnndlcx7BlqkQlup+MVV8DeICSODK49
         l7UA==
X-Gm-Message-State: AOJu0YwHZWpiGkVv6r3eL+Zhn51AqhjbIOnifzRXelyHic/wEZ5fLFhP
	3G0NMdIxH7bgTtPcDzLeNygEJKHYdkpun0+wuc2LaML3OVF0J9b9JZRqirHCDRM3ZorzqklFVEt
	i1qHVROxZH/d4peub3LzuXLWaD7sVN6cznES3w6svZOdx/92roBNhdr6S+yV82g==
X-Gm-Gg: ASbGncsetw3tl9KnxsvOx/suvxQmh7tZXtSBuc/oNA+hlzbFj3ZnxCLEKfLkyKPLt2C
	f/SudKF7Ovoe11qQ99XLB5KfbEy8YkslNylBzalcxP7+KzTw8d8zyGpqgwEBMkjfWBxEoTd0+Ld
	4Oc6vFSVWaM4y3ByVhYsC8UbysQFiNiCPEX4hmu1LjgmYTP/JiZPH3UC5eFDM3pCfga4Vhnpe8c
	qRmAsduw+laD0J8a9Z+dX556XjZCPFZVZngKwBkCnlQq3gbQ0zAzPn/VjVlAQwZRQl3HHYMadi/
	wLTW2QAy2xiKyvaP0Q==
X-Received: by 2002:a17:90a:d605:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2ff7cd31b16mr32752569a91.0.1741693936142;
        Tue, 11 Mar 2025 04:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBpwRD+x0zzZgEHDqEbRF1SFOUV4P6CQelhBln/hk7UmOm79yg/I6ndvZAqUjRXJjCNKh0BQ==
X-Received: by 2002:a17:90a:d605:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2ff7cd31b16mr32752537a91.0.1741693935785;
        Tue, 11 Mar 2025 04:52:15 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ffe18sm11696214a91.31.2025.03.11.04.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 04:52:15 -0700 (PDT)
Message-ID: <cb351bda-06bd-44d0-907d-9baee76c0823@redhat.com>
Date: Tue, 11 Mar 2025 21:52:09 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/sparse: Expose for_each_present_section_nr()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20250311004657.82985-1-gshan@redhat.com>
 <20250311004657.82985-2-gshan@redhat.com>
 <e36bfe8a-fbf6-46b4-9f8f-c44b7352583e@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <e36bfe8a-fbf6-46b4-9f8f-c44b7352583e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 7:31 PM, David Hildenbrand wrote:
> On 11.03.25 01:46, Gavin Shan wrote:
>> Expose for_each_present_section_nr() to be used by drivers/base/memory
>> in the next patch.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> Please squash that into the patch that uses it.
> 

Yes, but this series has been queued by Andrew Morton. Andrew, would
you mind to squash PATCH[3/1] to PATCH[2/3]? Or I can respin to do that
in v3.

Thanks,
Gavin



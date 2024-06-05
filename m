Return-Path: <linux-kernel+bounces-201728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D06C8FC241
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2151C21A48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDF87346E;
	Wed,  5 Jun 2024 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMJ19d0k"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AD2207A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559070; cv=none; b=bmOK28WODKeqlIL67zwLypJ9dBztK6KPksEKMbSkNvDkbCOkQ25+vRzg4hFlYRfjUf3+EzdprBtqQazrBOR1rLhSRpkTb22dvQuxiuY0zg8aTfj5oyWHSc70yTUF1DxK1DT2veQmntgy65NX3//HBgnEYHD5xr9tBe02hYnu6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559070; c=relaxed/simple;
	bh=XDa1ZZWfChpEvNEp16xs3nCmWlD7jDaE5vvWTP/5iBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lR0S5+nxxvrYOu2w5X/7A1fKwg+uLlAYcA+NzK/S7EAfuiMxlMQe7CvNJfNiweSInZGxuYVVOFVJ2UOBQzbojPv7l0qiUU9pHCxRubTIhntLW5b1UKWH6qPRBmxjHrhjhFj9VAJQv/zp3KNMDqwPgibl8jcPbLBNTLoHBNEeYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMJ19d0k; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso5071948a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717559069; x=1718163869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbD49E78cddouoifsf5mdpBCw/xwoRr3LLz54+H5tYg=;
        b=RMJ19d0kq+75rLEhhmS0qfxnhM1e0HUip3iUFFtWA2L+zTc0J5xht5js8Wl02PfwqQ
         fSt/riynbFvXBwZGGSLtcV25qLmiPyfHl2fqFBtnAkJNmxW0HyjOKM7+NZ5wQMmpLLDl
         rdCQuIczy+LEDSaCYBD2aEVyvjgBbIVS2A0FcX6+0+JFjDF6ePcd4WwMy24hJuReFCxW
         oeYF8nbYCUdkS1cJJCqPk7a1CMner9lnTlPPugGuN6PiFh/+fa/TcOaKw2BhBkm32FY5
         uJeJ6xglq7qsr99EktDt5neXzI9rf14Zh3cCBVZdWUtFIBvlvWir8F3ImbHB7Wlo8j7e
         i8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717559069; x=1718163869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbD49E78cddouoifsf5mdpBCw/xwoRr3LLz54+H5tYg=;
        b=wqxKrDaBV5trpX9d26Tvuc1qFyYBIPNDUuCCw9MJG1mDSIW5+9AAWgTq9dYx+ZHqMw
         I1rz4mgZnEyeL3blJt+ENO3dxniZT+Nedo4hOjSM+KYoZdm8JbA3PYtYCh7d3sOMXThY
         +bhKgZPnEzvuYSYG4h0CUV/Wy3L6JYhOj4khp7OoHdFQVbQV5R4RVfNRqpbQb9NBv0+K
         JO9+B/OKVlgk+Qo+87VM2kMuWRhKkx/l8O7STJ7iNlW2QbckailiAH26OepTInk073aC
         Xsmmziu83to7MIyZXv3pSTYARcOawH82KyThitOXjNRf2zImbwOG6GqhdnDfIUgXlHjp
         Zguw==
X-Forwarded-Encrypted: i=1; AJvYcCXl9fWHwFcD4IvP9ZKNvu1suSwk3okhut+QRSBxjDdy/DMQPyrMiLBMGiRsUwlEi1yX3KyS/1LzmE81XCIE/oe5QkVwHQ6c8NPrWqe6
X-Gm-Message-State: AOJu0YzM1OAbmQcp9v3CQerCGR+Otvm2CIF+W4gY9WofXiuUlG5e2rA7
	Nko6CyQhqVXo4RZBbZW1nimoRYBXu8+pbhhz0Ahei0vXSppSTrm9
X-Google-Smtp-Source: AGHT+IF6ouiokiVEyFL/FkVwCikSYFZ+WjrqZx3MbtO/OSdFIf0J9kZ/NtSEdTkFp9kIx9hLWh3+/A==
X-Received: by 2002:a17:90a:fe04:b0:2c1:ea2e:20b2 with SMTP id 98e67ed59e1d1-2c27db57d16mr1342743a91.30.1717559068626;
        Tue, 04 Jun 2024 20:44:28 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806d1be2sm302326a91.55.2024.06.04.20.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 20:44:28 -0700 (PDT)
Message-ID: <0a6603c4-ac05-460c-8bad-66813570b426@gmail.com>
Date: Wed, 5 Jun 2024 11:44:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mm/ksm: calc_checksum for folio
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-10-alexs@kernel.org>
 <ddb33c85-35e4-47c5-8a81-13a2012aac5e@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ddb33c85-35e4-47c5-8a81-13a2012aac5e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 9:18 PM, David Hildenbrand wrote:
>> @@ -2369,7 +2371,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>        * don't want to insert it in the unstable tree, and we don't want
>>        * to waste our time searching for something identical to it there.
>>        */
>> -    checksum = calc_checksum(page);
>> +    checksum = calc_checksum(folio);
> 
> So for a large folio you suddenly checksum more than a single page? That's wrong.
> 
> Or am I missing something?

I am not sure if this change are good too, anyway, comparing the whole folio may have it advantages on efficiency, but more splitting do save more pages.

Anyway, this change could be dropped.

Thanks!


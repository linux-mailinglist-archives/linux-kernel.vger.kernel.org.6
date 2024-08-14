Return-Path: <linux-kernel+bounces-286988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AFC95213B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC551F243AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B483F1BBBF8;
	Wed, 14 Aug 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG4s/Ity"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702541BB6AC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656735; cv=none; b=M/KAoMfUrWDB4hyRVqyIRq4c2ZsMKkoUrmvH/Vt19BsXFC08oCphZubIolO0YQgJMCgmgdp1nb6E1GbI3/wL6LlWpw1VLdCSPi4ljACVWgUtHVR00v9B5Z91ULLWBwFZYpps2c2U7ZxjKJ8A/niH6FK+wM9MWYM4Tsw836I2SgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656735; c=relaxed/simple;
	bh=tfDDVlfZL5EUl4B4FkU1KnaE0KhiAfumTEItfjNViW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ah7DDEXva1QD7opaLTR/Uka/movthtxcNJuAkMLiz+YDCXCIsZo64xp8BM2RqLYA1oIXQQSbHXxTIe3LhmMBDwo7bdSjRqQ2OraGTHGU1ycLd6nx4cXwjiKVkceeYpd1LzDCQGj6EgV79BYq12jpu5aU2/C9IoFNYhZJ9l2ALw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG4s/Ity; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723656733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ltHxr9SHWeEYcnNL0WPx5aTTtN+YRvsVtdL2IXOkN8Y=;
	b=SG4s/Itynoyj1T5TSQxSAw8/MvrKiJXKp3ZilH6XY2ZabqVb4g+ff6lKWI6x7ZJDT5MGxk
	q9lpLUC4D99QUnFegSpCbAeghRPJ3G/s5XPq9Z/CNDo5ZQhWV85US92nk+Hji1zF+Mlt9Q
	lzhRxZMiLrNIlGVCxhS1SNT1CMNlcpg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-DlCsMorhNKKukb5FkYl_BQ-1; Wed, 14 Aug 2024 13:32:11 -0400
X-MC-Unique: DlCsMorhNKKukb5FkYl_BQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso187275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656731; x=1724261531;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltHxr9SHWeEYcnNL0WPx5aTTtN+YRvsVtdL2IXOkN8Y=;
        b=nfoXbVOu1LMwccqOpsKw+Ul6TMsdVR817Bm9UiBa/tsCxTzc8vU3SXORjbuInzKeas
         m8Ik1+UP8rEcy80iN+MCSvX1T6d22QaJmD1lkNqCdBoJOtuV7CFq/x+jHVmC7TcW+fqY
         v1lJnMx27IOcYR/jqmxH/g8qravl4ez5FQj36/PV/Y/b5wkNIV+g5qvea7OX+tzzJugZ
         yU/fX92J3cb9oa4Nk33eVsbYetU+PEc2F9Jxo+jovybELkuQJhVg0YzeLY04PamZwyHd
         Us0/H7CRasSgka1Sfi1BBlV9TbYJRVa0W6Jv90Y9XOoG4j9WlB7KwxCzQphHzs1PI5FZ
         tiUA==
X-Forwarded-Encrypted: i=1; AJvYcCXmgLo+zPT4WYb+z/tDif2ZzZuq2yQhkkc0nXWvh2LQWHvkT/Q/MEu5LFayXXRvguZOPfkg134jX2HFc/ZmxVgh5VIh1kJu5od0NkUi
X-Gm-Message-State: AOJu0YwPhlVwzkV6Fw4JmoC12qWmOeGfCr6t4hXDFFkmimq3/hvPaTpq
	EvogqbONS2gNoTNDoPUekdp3ZXy+xvwiZpUZHdlSGms5ixegAMMKzyvC3bV/YoMcB1f8Ot1NTAt
	/cT8HbFBV1AytHTkV8tzaeG52fO6K40dEEShaxq+YVmOKjyaGbdHJ7bUt32fgyw==
X-Received: by 2002:a05:600c:1990:b0:426:6eb9:db07 with SMTP id 5b1f17b1804b1-429dd236c3bmr28332805e9.13.1723656730652;
        Wed, 14 Aug 2024 10:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExNmLibk6tiCLITLantQJ418VwMxTYRMIzatFYn34zKdVuSRo8pmT0JcgQ8Fl64mVXG680Jw==
X-Received: by 2002:a05:600c:1990:b0:426:6eb9:db07 with SMTP id 5b1f17b1804b1-429dd236c3bmr28332625e9.13.1723656730180;
        Wed, 14 Aug 2024 10:32:10 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded1e6d1sm26137825e9.1.2024.08.14.10.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:32:09 -0700 (PDT)
Message-ID: <2d485a6a-9665-4bb9-afdc-162b505462f9@redhat.com>
Date: Wed, 14 Aug 2024 19:32:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] KVM: x86/mmu: Replace PFERR_NESTED_GUEST_PAGE with
 a more descriptive helper
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerly Tng <ackerleytng@google.com>
References: <20240809190319.1710470-1-seanjc@google.com>
 <20240809190319.1710470-11-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240809190319.1710470-11-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 21:03, Sean Christopherson wrote:
> -	if (direct &&
> -	    (error_code & PFERR_NESTED_GUEST_PAGE) == PFERR_NESTED_GUEST_PAGE &&
> +	if (direct && (is_write_to_guest_page_table(error_code)) &&

Too many parentheses. :)

Maybe put it before patch 3 if we decide not to Cc: stable?  Or even 
squash it in there?

Paolo



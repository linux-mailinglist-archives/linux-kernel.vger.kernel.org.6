Return-Path: <linux-kernel+bounces-254697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D224933679
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9B41F234C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AC134C4;
	Wed, 17 Jul 2024 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g02wtvcn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658012E48
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721195574; cv=none; b=JYc7f7GSGqD8r0ftjspEOFXMZjkJI/UJQD5LdMPhUj5727TXzBnuf+xYt4t/EYzYgtkDYsQwIT2PL+yL6j+6vWNUTuntrAW/Vmv19quNfh5uNYEvLURB1PGhNIDtUDIwooV1Bl80wtYPok8mC4V2/OOcJfefICBx/D4RRBICL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721195574; c=relaxed/simple;
	bh=jbDv2kJBBlDkv8+4hsFO2OhPFIfc5YdqywoZKhP9VSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2AIbfC6zBhkckyPYqsuGmFKwTMh+H+XKf/qgCclwP0NXBlqfnA7E0zgPhKuxelKAWk5cLQN6uk5ryyEqoLc/Mr5JhNTbHUw67Tb3Rvgz9A6dGDcf5CGIwVeQSsVdxO139hfR2INWdrHEJvjnVuvJa1BOAbwniRY0xc+G+x7XrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g02wtvcn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721195571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dxOxLFm7ulboJzaGoeAChNA+Hm0+lI4yNZyxfRZrDdA=;
	b=g02wtvcnidpx9/gGmTQjB/vT8z4RPSxZd8hjrHhBK2dFTSOuRz3a6PZs4GnNxR7OHvZXwv
	l66WJepyLE9nBVPOKkIGXQT+y0qOqC2JQuIlzS5jTmuPaizeX/zD3YuAgUDj8yUvQf20tn
	7YQhD+XMDyVJ0RKaNsr1xUCDexQAjQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-yt1ipNn7O5ajU0JqkDCxBA-1; Wed, 17 Jul 2024 01:52:44 -0400
X-MC-Unique: yt1ipNn7O5ajU0JqkDCxBA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3678ff75122so4246968f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721195562; x=1721800362;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxOxLFm7ulboJzaGoeAChNA+Hm0+lI4yNZyxfRZrDdA=;
        b=dIi7fqr9qs8rNamnGW1CMscG8BwFiU8wK4/vxf0fGMs67f9VayWWsC+ugt/l1otCsA
         As/a4osma/UahOdDQHuUvxHR1xMME/qpx4ODKKR0b4OUuGFS6dqH00aFwtjyM6MXllQT
         yS7AC45ZIDYJhK011oztmcTEPwZA+6dqtDuQSwWjFTDR2lMupv6kJimwzO6KLjeBo1Kz
         Azm/d0YekLXa9+OaLcPoq8tutnLVdTwN3wby0oYcO6Rnfx54FFyzkXSBBMk6wihNNMO2
         g2Y9ko2sRDDOwAtJCT/ZV1rTMd7NLGc4Rd0QdlA2mVPj/Uw6B4fR9Q5z6lg7Esm04VVY
         +ULA==
X-Forwarded-Encrypted: i=1; AJvYcCXBh2pBxnCfwVyFjVLRWrL57oxLzSp1JaHWngqEOKwBxpK2GncNb1GGsQzVyClMrUID/B4pORMSOkZ0FsGOqzjfu+i73myM5XdkRVHd
X-Gm-Message-State: AOJu0Yy2oAIgCkmdHyReulujXuiu6kcinEs3VS6iazm7vG/h9DOxR2+Q
	31CkdrdSoRjUzwqBy0Yktyict5j3kA8IAJKAfrdivhIrRtT1iC1E6WxWOCfoj6kq2/mOvG18zGd
	xB/CRuSuKofDut9rbWkj4MKF4PTTCEAzSklWx5Q2TjeS56HqEciLv03i8OBCyJ/O1C7yB2A==
X-Received: by 2002:a5d:5f53:0:b0:366:eadc:6ca4 with SMTP id ffacd0b85a97d-3683165bb31mr577685f8f.29.1721195562769;
        Tue, 16 Jul 2024 22:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6iBlbfoQeF06cdSvntS53vlXJxZI2n0mbd4kjR6c99w0ly3xLz76UWy0O1r78QMYPyY1ARA==
X-Received: by 2002:a5d:5f53:0:b0:366:eadc:6ca4 with SMTP id ffacd0b85a97d-3683165bb31mr577674f8f.29.1721195562375;
        Tue, 16 Jul 2024 22:52:42 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-427a5e983e7sm155132075e9.23.2024.07.16.22.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 22:52:41 -0700 (PDT)
Message-ID: <4b0fd060-7095-46f2-840b-f5d88f94eecf@redhat.com>
Date: Wed, 17 Jul 2024 07:52:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL (sort of)] KVM: x86: Static call changes for 6.11
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240712235701.1458888-1-seanjc@google.com>
 <20240712235701.1458888-9-seanjc@google.com>
 <0f60918d-bc46-4332-ad28-c155a1990e3d@redhat.com>
 <ZpaV7kaVL1rj7MXj@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZpaV7kaVL1rj7MXj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 17:46, Sean Christopherson wrote:
> No, I think you misread the #if-#elif-#else.  It's only the !HAVE_STATIC_CALL
> case that requires use of static_call_cond().

Oh, of course - the "select HAVE_STATIC_CALL" is right above the "select 
  HAVE_STATIC_CALL_INLINE if HAVE_OBJTOOL" line.  I was definitely 
overthinking it.

Paolo



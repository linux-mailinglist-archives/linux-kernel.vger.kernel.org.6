Return-Path: <linux-kernel+bounces-547251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B281DA504E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023D516D778
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C118A6D2;
	Wed,  5 Mar 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osn/dNAs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B925333B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192059; cv=none; b=n3VtyXD8K6U+Zp9k0XlEtuNGWqGIuJWUK5FWY3cH5QcctWa+85qof0pZmoyO4QGCM5JuwllJ09mDslpHD9SdjXr6ZhKt9cWHYd9ysxVocdj4bIl3Cm7cUyDg+DhnpH+lFkNyYErpDg1GthRYbJ1jdC2xD+CHCoUQ7Z7medDQph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192059; c=relaxed/simple;
	bh=Vg7SCNGZuv6MSzX7s2TH5C/95lcIkGxtA3uOHTXdXys=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ikOCVn4ekhmT6DgMNAIuYLHdYsBO27F/aZhjBt40R9fJnl1pn0PaV04iy6syvtpHP9sKsmWKKNgk9+5FwBP7JakdlQWiaox3sXWLzmn8AYmwxqp/g6wA6zPwJ+6MbSlHFziOonCGH/mYDPZ8Z76T08Pl5FusWmXHsTdH6qRkYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Osn/dNAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741192056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFJCCrP9iOFyoLc3U4Foi0Xf76AnU3YMKrRioOVaMZc=;
	b=Osn/dNAsOlzLjGp8sTJRAyjKz9WJ95SQPAvr+70zUzIyLvCsqwPLHyK/cDdi3YrP6lG4Ez
	h2AizG1W1lfyfL2MI8CWTUAYV31ANqajcdta2g/7eHrVRTtdPwImI1NoAKmeztTgic2qGZ
	EGkyPKug//WEzY0WpFCqZLUMLJ2X7I0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-8avNakbHMG23Mh2N6RNCcw-1; Wed, 05 Mar 2025 11:27:35 -0500
X-MC-Unique: 8avNakbHMG23Mh2N6RNCcw-1
X-Mimecast-MFC-AGG-ID: 8avNakbHMG23Mh2N6RNCcw_1741192055
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8c4f5f3b4so91021916d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192055; x=1741796855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFJCCrP9iOFyoLc3U4Foi0Xf76AnU3YMKrRioOVaMZc=;
        b=MAV8FPRxtgz5ES2cmeCb02enYkaIfmNnOyBtyiD3XIp17VaJ1eOpApGjqX/Ct6+2xD
         LjQfV/Jh++RZmBvFA3+EM0IAPcYiJv5P7ITsiPxmI5kljZYnNhSBCluCgqVNCFaewSbt
         aHb0AAsaYx3yfUTMIEFblTlUTfMc6KWf+i7Ngq9iU7czNqF+DP5pAtsnT7UYJ+bliU2M
         Leo/Qxt+aSDwTd3Zm/sK9kJ5ZEPHTQCglbbdfCQ8u6tQlG3QcP30PJoB5MIaVtdZohcV
         emGKg5sYSO9tp0sEtgDF/P4Ya2rRjx5qiXDEpA/cd91aqsXTzXiPQd7z+3JDPlNz9cz3
         Sblw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Z/m45CIHDXsg7uEcOHSv6KwVAQlSMmE59QtgidF7K0dtSI1WyR6OusIs2mm08YfuIz6F/S1N+AfCfiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtnc/M7q5wWe47HzgEkye3hjGDflYoGCu8WB+/ivAqkljan6x
	BPaAsEiZpIpZIZXYez/qHsKmtl9DR3SOFTaAA2DpqD4mTkQtNI66wXl1Blv0g+Ai7OQeFKo2HR5
	yhLqIP7dJ9g2DJS716DHBkIdhsvZMYu3YE6AuoUXEiZ62+i4iKCZihNFqicWAhQ==
X-Gm-Gg: ASbGncvuoLOGGEVhPzp0ywv+FaI4NbfQ/9b7+RUAOQK857VfKYOX2OfL9ukDJD7v/+D
	p93LbU4bk6OuPeOLDChf/FSaWETNCHbESl8GjLDdsv+t2Q2lxRxjvsObHlxM43pEW/wnDfEqEqk
	dRLWFPQLUkdEcvHfDMOdjZGo//KhmXba5VOKRmmn0nUDWcCbf50xRqlIU5uTrBqQl/4Kn3n6CxC
	NcU2xSA4yJ3/PEjRYiwLgNXCti77Y+muwUeFY7KCtOAn9JSvgihbWTFgSwhco5Iuv+l6xTmTQ3t
	TWO2xG27Qv1bv7sMTdfMT8j8UQ3n8ddDBWFYX2BO4a4vcavz8RRhPzy6GjE=
X-Received: by 2002:a05:6214:21cc:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e8e6dd876emr66705556d6.38.1741192054924;
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdjGMu3Z9P5awn0k+syJ1lGAzEkIPJ7IQ68O6zR7KcCUd+jJ3LYDcgb0Pg4YRM3PptFxn4SQ==
X-Received: by 2002:a05:6214:21cc:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e8e6dd876emr66705186d6.38.1741192054692;
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f401d4bcsm395776d6.124.2025.03.05.08.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:27:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9c24f14f-c7a8-490e-9077-0d977d175d89@redhat.com>
Date: Wed, 5 Mar 2025 11:27:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-5-mkoutny@suse.com> <Z8cwZluJooqbO7uZ@slm.duckdns.org>
 <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
Content-Language: en-US
In-Reply-To: <t35nwno7wwwq43psp7cumpqco3zmi5n5y2czh3m4nj72qw2udp@ha3g6qnwkzh7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/5/25 5:17 AM, Michal Koutný wrote:
> On Tue, Mar 04, 2025 at 06:55:02AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> I'm hoping that we could deprecate /proc/cgroups entirely. Maybe we can just
>> warn whenever the file is accessed?
> I added the guard with legacy systems (i.e. make this backportable) in
> mind which start with no cgroupfs mounted at all and until they decide
> to continue either v1 or v2 way, looking at /proc/cgroups is fine.
> It should warn users that look at /proc/cgroups in cases when it bears
> no valid information.

I like the idea of warning users about using /etc/cgroups if no v1 
filesystem is mounted. It makes sense to make it backportable to older 
kernel. We can always add a follow-up patch later to always warn about it.

Acked-by: Waiman Long <longman@redhat.com>



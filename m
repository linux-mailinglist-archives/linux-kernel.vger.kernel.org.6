Return-Path: <linux-kernel+bounces-254618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262B0933586
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CA51C225F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A4524F;
	Wed, 17 Jul 2024 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5ZgUY4j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6842538A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721184551; cv=none; b=TVk2JHIiUGOOo6OzaAXj8Mr699V+i5QanXkeCTpsYm7P4xDjdWcQcAZ0sv0QDANNBKqIt5U7dfcSulWQm9yRVSWtenr4n2rrHImKDanZIe1GE/KrmQSs9R3aMLEtfQWI6uDZAkFbM4KL+IUxFVHAp4qyL7f7jNExlH2e7hB8m1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721184551; c=relaxed/simple;
	bh=j/I1SutNM+dTjzVVe/4QD8QLT1Mv1h0NTjNXCJC7I2Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=obL+cuhd24QQXtiOnkdplC0NJdam2efU8huttxeZDHqjBNGQnOEGHNUXcXv4KV2B9heyIC2el9jBLi7Z2T+MqZGv14LJdBIFTBQ0CJqJf/jRAt8OuuKVz6s7zsdzqNLrVKee+qQvIP0sWeN/tx34HFqWycSZgKCnNniynWtJZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5ZgUY4j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721184548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vni9TjBPN60/2WyNlkZNwO1ivJa78BWP+aNTmYi02o=;
	b=W5ZgUY4jkJE0CmRc60BKQYr6NSt/6mQi4og2zUeIgWh7gRjd6SeWJyNnVfFuIldj1RKTBm
	Am9f/vkwBXr0admLQfcN2Cv+lj2v7/0Z1gi4liWPPZycp2A963edQpQk3QXAdBAt8RNIC+
	GJ3bQFDFxV8FDUzBQA1A56UHcOjnDY0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-mRc-okeYPpeLQ1etq0adog-1; Tue, 16 Jul 2024 22:48:27 -0400
X-MC-Unique: mRc-okeYPpeLQ1etq0adog-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-79efed0e796so75135985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721184507; x=1721789307;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2vni9TjBPN60/2WyNlkZNwO1ivJa78BWP+aNTmYi02o=;
        b=ie3TRPuJsdEjT4b916+0sonLkRSUnANv0sGA4rqXnmuEkkWutlU3ywcTy8adkic9j9
         tW1dwVMu8+ueYOut1KEq8IzC3Snb5PwBGQHsbUGkv30+T0OVCDx2SR9t229xCIhQ72lE
         BOwJFPqDAEVKfJ1lO9Yl8X3MC6O1FwuknyzuqYbO557K7I/12++ZPIgF3o5EkuMw42f9
         TNzavNprfnIQCTJDd4PjKcw/yxyu1CWWhzRmLd1KYin3bCWximaGfNgNvZzsyXbcFqSu
         UUXL2pNsXtSJhOMsDPSCUxZ0mm74Q7AVbQpzoIwexP+Bz0maWM737+iWCiGv4nTiZq9g
         TQSg==
X-Forwarded-Encrypted: i=1; AJvYcCUGQKH0ATWfF1ziY7MTqazIErH4buqhZWaYMf7rnGKPfq/nLTAMDQnwDM1H0Z6KKFAZnc9oBibHlkaFfugbU/2w2bijYTN/6tRduhCF
X-Gm-Message-State: AOJu0YxVxjM1lNr65NeOtipBtKbdK6uqWXYwCddK0Y8FfHqvf8uIbReB
	vHUuFKbU+qMNA03PeMdDw4iNeHPv06qFEqxynkVhkx7i2hcq9paP8oT/f9tfw7QBViTiq4aA309
	D8h9yTDf0mCqt1xUeTYsUnjmEqLKl4KKs/jzMvSwZOlzewvhhv69UbnJDnQOB3A==
X-Received: by 2002:a05:620a:205d:b0:798:db85:c9ae with SMTP id af79cd13be357-7a17cca2a08mr557423785a.28.1721184506956;
        Tue, 16 Jul 2024 19:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtxVXp+2Le41TvX6SHN2R1kXrRD0KbLIlks0MIb3Zw5n7C28EfSKrYdf3UZRQJU6HWjxW7Zw==
X-Received: by 2002:a05:620a:205d:b0:798:db85:c9ae with SMTP id af79cd13be357-7a17cca2a08mr557422185a.28.1721184506598;
        Tue, 16 Jul 2024 19:48:26 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160ba82cdsm352753485a.4.2024.07.16.19.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 19:48:26 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:48:22 +0900 (JST)
Message-Id: <20240717.114822.518449716597478345.syoshida@redhat.com>
To: tung.q.nguyen@endava.com
Cc: pabeni@redhat.com, jmaloy@redhat.com, ying.xue@windriver.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Return non-zero value from
 tipc_udp_addr2str() on error
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<20240717.110353.1959442391771656779.syoshida@redhat.com>
	<AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 02:10:33 +0000, Tung Nguyen wrote:
>>How about merging this patch for bug fix and consistency, and then submitting a cleanup patch for returning -EINVAL on all addr2str()
>>functions?
>>
> I agree with this proposal.
> 
> Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>

Thanks!!

Shigeru



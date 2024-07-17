Return-Path: <linux-kernel+bounces-254600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2F933542
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212AB1F23395
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F24C8D;
	Wed, 17 Jul 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiAXh4Eg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23F1878
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181843; cv=none; b=rvplEHZ0Mo8Qo5SgmKAKDPKFGywooLI3vPkGfF7M4ee0cLO3VbJweSPcD0kfYTbQG9zOKbqERZHg6MUTjrsGQhN1P15SfzeHQ1IxiD/Flz3Kp1aZYwzNm5sX9S08VuXi7gK+KkM9lZirvUQB1e6E8CszNnqfa4/NynxNyGi7DAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181843; c=relaxed/simple;
	bh=J2TYSnXuMgmHXV55U2FUwOT5T3suOiC8VHXSd+3opFo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WCc/A7YDndImx4XeFhIudfIfaAxJlbGTtjOTQSog6XNkbQakRmqq+NUao50RJOwAv0lT8e9eTRUwtvibIpIUL0m7A8qGvBsIX5gx4NZLKaYzqPAcoXYXAYll6yQNlwP9Z+/iixAU8LB3B9Tcbrolm0BMa2AIcAbmxUA9w33Twt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZiAXh4Eg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721181840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2TYSnXuMgmHXV55U2FUwOT5T3suOiC8VHXSd+3opFo=;
	b=ZiAXh4EgUre8dlU3aNpPvHPvmihadVnMYmJJxYG7sY9FbCOAZlq5ccHEH2gTEeJaXsSUcl
	9cTv5XBrVPBNGvfTcH+SlJlqfymHVHggaHOJ5oGeESympmG6yzRhbESGLu5cUwEiJbK9/g
	4B4tefaRVZOlSnn2CbMz3FQovS6zhl0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-M7QckEzPM8KKV7ckaBTMIw-1; Tue, 16 Jul 2024 22:03:59 -0400
X-MC-Unique: M7QckEzPM8KKV7ckaBTMIw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79f1d37915dso65420385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181838; x=1721786638;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J2TYSnXuMgmHXV55U2FUwOT5T3suOiC8VHXSd+3opFo=;
        b=UXaWL7DstIF5TA0+l6VlAJTQakvSvs5fNZt9n8+KtSHl3GLSbNfyiOFCXg5cT+ELYh
         83yWjYSljIIjdrVCSEc0DGsKkoKGTbwWAd6bSwhf8pZmtdDkhiZYdFx156LZkbPavE3d
         mKbWBJOJiAWZh65WGME7QmGW3lEyURBUgDL8QFXB9jWv7PfsZqCBayAEzDaWoPQmfm73
         Xofuu6SFEwq8P9cuQCNr/2K8EsQL7o3FOGaN93v4+STfT4K5/QjoBlmSRQq1QFIKVbsJ
         vLD9jt9TCKEhwt56LwB3iGbs+XKiT1jYuUrukSRlhBxmWsqcjtj1s6FI5bX2BUC18wjA
         uFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgUZrq6SYiO312/yBRZYDhsTNevgM+BaHUx3QGcIBUYgiiuE/0TtwuQ79/IlULmibzjHsCEnj7OVdWzUH+yWxUu3DU8aZuW1N3fphz
X-Gm-Message-State: AOJu0YyO27tqk0S0tjxChaUSQ3Li73F/PJbnFTWN3rJsBpYsl6h7MIZP
	mqKSltSkyvXooNP2H876vWktsBz/9XCDfDTlHr5P0cxY6y00ADBV067Iy1zZ2ZkdBxIjWic0UHU
	KwoYqF9MfoOGYkqPb7PRQU2hR1gIO2ddbumOFfKNhjzQUuOgfai5qDZF3hVgPBg==
X-Received: by 2002:a05:620a:294e:b0:79c:ad5:cd7d with SMTP id af79cd13be357-7a186eb6d93mr58859985a.23.1721181838620;
        Tue, 16 Jul 2024 19:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcZ13hx6uL+FJZ7QUBpqM6DgtsKq91qaLvPtXzJ6FXcTNBbI3o6TNmDVvqg9/yLg3dDIqZUw==
X-Received: by 2002:a05:620a:294e:b0:79c:ad5:cd7d with SMTP id af79cd13be357-7a186eb6d93mr58856685a.23.1721181838333;
        Tue, 16 Jul 2024 19:03:58 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b84715dsm41346281cf.91.2024.07.16.19.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 19:03:57 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:03:53 +0900 (JST)
Message-Id: <20240717.110353.1959442391771656779.syoshida@redhat.com>
To: tung.q.nguyen@endava.com, pabeni@redhat.com
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Return non-zero value from
 tipc_udp_addr2str() on error
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
	<AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Tung, Paolo,

On Tue, 16 Jul 2024 13:29:08 +0000, Tung Nguyen wrote:
>>If only this one returns a negative error, modification to the function pointer callsite will become prone to errors (and stable backports
>>more
>>fragiles)
>>
> I really do not see any issue with returning a negative error which is the correct thing to do. The function pointer call returns 0 on success, non-zero on error as expected.
> I do not see "prone-to-error" when it comes to backport.
> As said, problem is returning 1 in infiniband and ethernet media that should be corrected.

Thank you for your comments.

I understand Tung's point. Returning 1 is not descriptive. But I think
addr2str() functions need consistency for the return value,
i.e. return 1 on error.

How about merging this patch for bug fix and consistency, and then
submitting a cleanup patch for returning -EINVAL on all addr2str()
functions?

Thanks,
Shigeru



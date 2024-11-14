Return-Path: <linux-kernel+bounces-409793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F49C91B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9557D283B48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA51991A9;
	Thu, 14 Nov 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHVGK9Hr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0AA3FBB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609173; cv=none; b=BgBDlG3sSVdyK7L/pPkcS1LUm9LhTRJqaxfVkLaUtQk3ZpUh6FoTh8NW1i3XVHaQtGdUowmE+0Cmja1s4rvs+eAsu2OzT4xMg+oYUyitloQ9RU+fDSWzkMu1++naLuIQQ4ZWxcV/ZB9jfHaHBIzXgsAlV2mRd6a222oSQ2vPWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609173; c=relaxed/simple;
	bh=GtoUocYxOO43x1jcxHW5REFrvehfdiJltsSWjcPgIRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2EWB4UobZlIGQlGUwMVUCBgeQFQvbTJGsV/1ry+Kdhr/silw4GmyQ2sf5LhDpyT5sudy3Xv2wBMAarYgEheYf1UOgVCYBJe3vgstEIMWKgtE3qMVh4/5Su8kzw8VN2p47E/aUZEc6Wqu1XoK5dXQ3DJSi4jX0abb/eEP1JcEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHVGK9Hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731609171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFI7tbBYGiEseQ7bvAyFPEuhxaHn8dv5eXukTVUQJvk=;
	b=ZHVGK9HrHIXoy76KAWSNxiAqjrT3sZx4XLSO7LssUETCVaj4E0E3DChx2rt3j3IijkHTR8
	9nI/ocRYfESyxEpoS6ej9KmJZTosEvzcDLc3eM2iX8UJ+1yva2uZsxZr7589FK+wnMUSVC
	Ng3l2WcECqbqCqtwyu1YUH1qhXwASYw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-NKyz8478OsqT2uajVelhoQ-1; Thu, 14 Nov 2024 13:32:50 -0500
X-MC-Unique: NKyz8478OsqT2uajVelhoQ-1
X-Mimecast-MFC-AGG-ID: NKyz8478OsqT2uajVelhoQ
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4635760799dso21193531cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609169; x=1732213969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFI7tbBYGiEseQ7bvAyFPEuhxaHn8dv5eXukTVUQJvk=;
        b=ZmwRS2bhA0PLrX8brMFP5V6Ewg90KVctDeEowSvPaIfLZU8ygw9CVQMcNZtbqp8hwo
         /7pIm3aG8Ay1PyBhM1xODvKZgD2/m8bf+oC/VyghvsLPA9ynp1x59RR4RjYvXXgSCtDh
         JY66vj1Vb5eIMCYrt//Q6gMM7PFcibCEwf7vsUsrFXhjqyKKnLpBXz4Kqn9Xwqndd48h
         1hUtRolpfmNJa0Bquzghj7nKQUaJYiOxNLDsd3/MiURQQaw1ZAyjEDi1cxHO0UHpXE07
         E2VbPKs4ogoQDS//rAX3fOA0+2nljEheoLu99Qc859hyddz4U2i93zjyHQOtw3oSA9QL
         knZA==
X-Forwarded-Encrypted: i=1; AJvYcCXaQyAeu8rzN0ERvK++1Wl/poPJe82x/CbKej3Dnp73bmRuvmQZv5666ZO/yCsSKoNByjyepwlMenSVFO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8j0FXMcv8ajl+A6KdlkQfNrMxSXt1xYY58ZlnG8Me0BKcUWZ4
	CA/H309ZiH/rOqh7v8BcWsnaivujJO8d5KoMHa14VEEE0wapKlmLIwnFnVDD2c82c/50EBhD2lm
	tTDgrJAdMP/eb2bxZDTKt4UrmC7tJFNyJVrVmTGvIcPJcIpai0wJ5stiZ5u3OXw==
X-Received: by 2002:ac8:58ca:0:b0:458:1e37:f82 with SMTP id d75a77b69052e-46356b78d6amr69904281cf.18.1731609168780;
        Thu, 14 Nov 2024 10:32:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0QtIZNLBykcxZpLOh80DvJJPMPMAFpJAL1kQs1vq2h6v1QgZ6rz33PSsG16J+HF/4i/gWqQ==
X-Received: by 2002:ac8:58ca:0:b0:458:1e37:f82 with SMTP id d75a77b69052e-46356b78d6amr69903921cf.18.1731609168445;
        Thu, 14 Nov 2024 10:32:48 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab24e39sm8729521cf.63.2024.11.14.10.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:32:48 -0800 (PST)
Message-ID: <3f967373-32b8-4e43-a180-80c94fc091d1@redhat.com>
Date: Thu, 14 Nov 2024 19:32:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
 "David S. Miller" <davem@davemloft.net>,
 open list <linux-kernel@vger.kernel.org>,
 Mina Almasry <almasrymina@google.com>, Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org> <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
 <bf14b6d4-5e95-4e53-805b-7cc3cd7e83e3@redhat.com>
 <ZzY6M_je4RODUYOP@LQ3V64L9R2>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZzY6M_je4RODUYOP@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 18:58, Joe Damato wrote:
> On Thu, Nov 14, 2024 at 10:06:02AM +0100, Paolo Abeni wrote:
>> Please send the two patch separately, patch 1 targeting (and rebased on)
>> net and patch 2 targeting (and based on) net-next.
> 
> OK, I've done that. I left the fixes tag on patch 2 despite it
> targeting net-next, but didn't CC stable since the code doesn't need
> to be backported.

Thanks! FTR the above was the right thing to do.

/P



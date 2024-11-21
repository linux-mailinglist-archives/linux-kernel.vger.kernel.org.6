Return-Path: <linux-kernel+bounces-417596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03A9D5672
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EB5282408
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE71DDC08;
	Thu, 21 Nov 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zepq4qXS"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3C1CB506
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233232; cv=none; b=bc8mqz174FtkwyLo5jykcDqs7Vjg8y9R0QnwqasIkWR0Tz+lIhIiaV/Vh1BulGgRrspT6m/o7bPQhJBd5wA+/LMpRUxbnJR7LOGLK6erfeZSlIJ4ut0tszgz9AZd3zoHsBmaazOl8GqzuofahDz0773xqACRrJdLAWd5tvfCHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233232; c=relaxed/simple;
	bh=j8HtVc2jXBan6FbqE277Xt6/3C49W0fYTo4fzxzIsb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJI7ot8t10OaXmMX16uJ3LQNzT5z6Xz+3CPERjMkxP6f9A/Y3BGVIY9nOdILeOGIIai/8B2a3nurJGBoe7W9dDIH8BJUZ9Y11wcUPN5kgV65xAVsmTFMz6KpLcxwUQ0pn4lVLPOmO0m8YooaesDOMYjf0MVswcldAjosNP3OVXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zepq4qXS; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so52674939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732233230; x=1732838030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljvFTLckgMBXyc/hCWJm3TmPmL56Vi1djSJCVHusK+0=;
        b=Zepq4qXS4bnFi4qOXhrW+Tdl6Bs9VtX8EKZEdpU8FGyHf0F/IwzVsKarg0m4q3LHCx
         rhFC2JhI5GH9RFGKa6xZWRv6Xqo9KV5LMenF7UcIodxREy6axtFlmWRzmrsa8CJ0xWWY
         q4fIhhe+FknbBqFgdtcEBOQfDpCQcP3zW9vk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233230; x=1732838030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljvFTLckgMBXyc/hCWJm3TmPmL56Vi1djSJCVHusK+0=;
        b=dC+aDnUVZHcprWv2I36Z6RBL9ZewRhc0QsR4o9x8ERBENYctk6ylHZIIhFQ3CblLqb
         4gHgjgwbD5ecU43wSlmvYNW6zOhbiVAZb5rnTT8/yxnN1Vd1AQrjPM84nqcZEbQy+2Pn
         636P6vrxUinXWvDc0NrA46MNnSK6s8FT9MJgmVUbb9ncINFcPry2kPcNYZCeAvBSGf9D
         AI8l4HpKaLBfZbg8hD7oFv6w8uTKbsfBjoVjzne2P2u/eoKISrgpksyqGz4MrFWv2sT4
         VPAxVwNMYNrTbUMfLcY4k9XdfPKd+c62f+15zEhjvFkHFSua4BFJOUrZe/F6UxgOn0Nv
         bJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXzIUC/qNZY0nwWbhmBbWwGp4uVVe2Id9ctSXUjeZINagSLJmvGf+Fums7UU98PfsN2dRp7dLZS7LUPiqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmVVzbKx7+60JZTipDXiYIS6bbysvaid9OgcAG50+eiSYsat6
	+pKXjw3IWUoDDSUHURbexnaQDRBrguzkibyDqf80XWpFDrdluwXr8ltfPaAYZlo=
X-Gm-Gg: ASbGncvMOV1wxg89dR8ctFkKRgw+INpt6YqzLZMJC+gMcdCgoyTXctDck6VuFEz0xDe
	e2Qy0cR73Cv2lMY8ZhbtNeRqWhMQTgd+aWaL8cxW1HAWrctderF+xISuPROH7r/Fbz+8Uv6W2/K
	9/1llwxNbL5fLmH1fjozaQGt/C4O71FwFQ8hjYOZnhoLpMzDNjD4CDPNlakHflRRM+pTMuEuUMQ
	lcK7yzjNckFWc1t1rlVhdrPOjjRKJXwCBRh0QurzTS0y6YdxEQ8OSKwvFWcgg==
X-Google-Smtp-Source: AGHT+IF96MGQRTP0elvAz6sBTHwpiq8D9SyOiWFimZgfz4bG069DfMpMT/a7a5sO+nbaJTtWXJBa8g==
X-Received: by 2002:a05:6602:6405:b0:837:7e21:1688 with SMTP id ca18e2360f4ac-83ecdcf315cmr96081939f.11.1732233230456;
        Thu, 21 Nov 2024 15:53:50 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe19f0fsm359847173.12.2024.11.21.15.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 15:53:49 -0800 (PST)
Message-ID: <39e8f416-d136-4307-989a-361bf729e688@linuxfoundation.org>
Date: Thu, 21 Nov 2024 16:53:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yafang Shao
 <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "conduct@kernel.org" <conduct@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <v2ur4jcqvjc4cqdbllij5gh6inlsxp3vmyswyhhjiv6m6nerxq@mrekyulqghv2>
 <20241120234759.GA3707860@mit.edu> <20241121042558.GA20176@lst.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241121042558.GA20176@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 21:25, Christoph Hellwig wrote:
> On Wed, Nov 20, 2024 at 03:47:59PM -0800, Theodore Ts'o wrote:
>> On Wed, Nov 20, 2024 at 05:55:03PM -0500, Kent Overstreet wrote:
>>> Shuah, would you be willing to entertain the notion of modifying your...
>>
>> Kent, I'd like to gently remind you that Shuah is not speaking in her
>> personal capacity, but as a representative of the Code of Conduct
>> Committee[1], as she has noted in her signature.  The Code of Conduct
>> Committee is appointed by, and reports to, the TAB[2], which is an
>> elected body composed of kernel developers and maintainers.
> 
> FYI, without taking any stance on the issue under debate here, I find the
> language used by Shuah on behalf of the Code of Conduct committee
> extremely patronising and passive aggressive.  This might be because I
> do not have an American academic class background, but I would suggest
> that the code of conduct committee should educate itself about
> communicating without projecting this implicit cultural and class bias
> so blatantly.

I tend to use formal style when I speak on behalf of the Code of Conduct
committee. I would label it as very formal bordering on pedantic.
  
Would you prefer less formal style in the CoC communication?

I am open to educating myself.

thanks,
-- Shuah




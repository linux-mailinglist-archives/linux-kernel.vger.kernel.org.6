Return-Path: <linux-kernel+bounces-262351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EBF93C4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6132828F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBA19D07F;
	Thu, 25 Jul 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WgRpXLqn"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB019D06A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918659; cv=none; b=uxMSQRNCQZ2GlB6eWyAnfl/XscJtdL3U3NZ5H5M6YPiuyK3D8S8ey377/Z3tY3SmKTCyC71DOY7xG1Vl4oMy8gumA1xiH/RiyFslUTPvqu0cAWLKiPTe1lgZXspEcR0EMgLUqj2OA4wSsCwmYcW/YAcPHDIEFbd7upQxPTEU9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918659; c=relaxed/simple;
	bh=CYeY74nWbiLhuVILJd9ZAeMxNX9FnpbfsLSv7nfzCrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4xGelbFIxlhviHwy4SEIK7TfA7Xe4t0+IyiFcpfCI8N6vxy8Gda41ZHxmdiHH0RJjdJbud7VC2+XXon/ZiT8/q+rqYrzi2f7H0S3UY3w+RxCpJTZa0oNc1r2OV0Bz+BHxiXqejZ44QOqJoar50NrWYBN7aHImA/udwXRURRVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WgRpXLqn; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f906800b4cso1541439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721918657; x=1722523457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggkJi9vdNqiqOHEKpWi9ZwmYybDVc4cKNgErtinhby0=;
        b=WgRpXLqnShuOeNutwgAQj4WgKX8ib2xJJRlK/Gw/ufkO0sevkKyTkm16wvpOq4psNF
         /cr+SWC8rrqlL05R4ZObkl9qO3KQyEOpzHZQ8sSjrVKnNhzx+xnpYP0Y6MCPI8uSBlJw
         5WXyGjuurCCwGrjtePZNWSFMTqs+lSKN9G4ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918657; x=1722523457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggkJi9vdNqiqOHEKpWi9ZwmYybDVc4cKNgErtinhby0=;
        b=qgJwxG1LPwORXWpSG95iQl4bJ7o8tptIzd2Fyt6O03EDiIEualDRA8cGyL9KLmgGt4
         2yOIaAzr1q9xNw5gu7SnUvsWIC2PDMIbkd3gTr8BD4QIT8dtfGZOsjuCDcMApRyaAmB9
         O9gSyEWg2P9NT98lHxenieYZG7FeD7YUj6xn2iuDknRkN7BoiCtGmuIQPY34SVCEdyjC
         FXv4PgvTp2Y9QL7kC9VYa/+6R1IuqZQnTD4WZYLTFpCQIJOt77NtjYedsT3qqePOh43Y
         C7LpJcfd1o6juvSM/salbjtiOKA8Z6kLr6zy67ahxypqCDizUI2KcQPLamnBewAzEAgX
         aNFw==
X-Forwarded-Encrypted: i=1; AJvYcCUFKw1aYyJrB8EjlpkX+ALxTgtJX/NwFqRAFSjJTRWSsBXZdT4J5RM5BaaqnPh8G2kEjn6uJIAbvozgrdzEakZMFMJ6vke9SpUTaSzH
X-Gm-Message-State: AOJu0YwcHHQCNQKaLq+zmGw7EjsAduCEpTEAsBd71unT28U3z0Ow/6z6
	mQW2Vik1XbbxUmVUciJEHpTNRVNzHoo68X/yvvuMnrmliTfK7vN/2MXFOP0/6E8=
X-Google-Smtp-Source: AGHT+IHnyggLyOMRhFjvc0+DU90oiUQyBNvbh4Tj/hi+1HeGK0HdT/fKi4bxgPXBR+sh404slpQsfA==
X-Received: by 2002:a6b:f702:0:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-81f7cfbf361mr193935339f.1.1721918657567;
        Thu, 25 Jul 2024 07:44:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d7243eesm47480039f.18.2024.07.25.07.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 07:44:17 -0700 (PDT)
Message-ID: <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
Date: Thu, 25 Jul 2024 08:44:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725110817.659099-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 05:08, Muhammad Usama Anjum wrote:
> The user test suite has only one test, test_user_copy which loads
> test_user_copy module for testing. But test_user_copy module has already
> been converted to kunit (see fixes). Hence remove the entire suite.
> 
> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")

Remove fixes tag - this isn't a fix and we don't want this propagating
to stable releases without kunit test for this.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Thanks,
-- Shuah



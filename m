Return-Path: <linux-kernel+bounces-430412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451439E30A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B4A2837BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF48F5E;
	Wed,  4 Dec 2024 01:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B05DU6Hq"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B1747F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274420; cv=none; b=Rpr8H+avoU7wa0+JddSOjah3qZst+ICxtbOsNyPGy+r5Z6M8zmPOMPvobqIgddhihbLk1MTeu3ub37sIz8m2XLjL7Mc4lIvuwZCOi5DuAVI/KA5xJH9tYwENrbmprafh8C4VmSDLiPQMbGNtcA9axzZp9d6/hqP5vAWRgd+Ehjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274420; c=relaxed/simple;
	bh=MC7AljCRogbPP7nv98cOsHc26oZBN/K1ecZLTmoeVsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dODCCeOej9WFV03yPyEd+A5XsiQcRUN0rGrPEWv562QlITGjOiYYnTHh90ks9WEbsH75cc603B3I+JY4YBuiEYuGoggrwaCgj9KhvUWlAWp+jW2uSlJyc070Wj2aICxKx7vda69Kmm6/AAhnPzPhf2tgZ13KGQWRDfqygjCPVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B05DU6Hq; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso1574925ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733274418; x=1733879218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+Jz/Q6nlrwZViX03mS36dj9lZ7L1D6LvW4jUlY+Okc=;
        b=B05DU6HqnqBBJLf6glsXGpUEC92uhrH7rTNlFwJfRapv3NrWeod43g/BUjrNg84P8a
         UwKM2humEP6TCRRRxAvyhDzeVMAApYgs4PWYps3vEjcATqARIqJEZgKYMw40wMz9IRqC
         0NX4n20/MnnErBNMyKCu01gLZag2vVDpdF/xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733274418; x=1733879218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+Jz/Q6nlrwZViX03mS36dj9lZ7L1D6LvW4jUlY+Okc=;
        b=kliXpymS1mmT6BpD2ArfAhARnztJYUbjQCEIMj7j0BrDFrA1nNzF0XPGMdEAyWy1I0
         8R6X0C18T879F2z+/HG35HOGwGXG7GqejquSZRiDLBSl0Zc+u4kvUxrc2txAxsZ58+1D
         Ga5mZN1ntD+L2mPMoPGMflHzhZOOZCT5MrsElVcvH20DXXcdc6PLK8TZGpYxGHt/QJxJ
         Sw2BpBUQw5Bs7bEP41zVUdvZ3JGR++21EfGsP5hn+I4gksnQvfO7dpO2p3iePluWF2rZ
         oyhJIEjYBVdLwqONELmH2q5CkYUZ+aD9VrfYCgt2tXHIJCutLVRMQzlxQS00xRdt4AHW
         03Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVRzwKzubTr97whW7AsxlVI7Mjd1XxNCRpTeREJVPJ4auQZ3y8AMn7copYu2amspnjEgJ8Zd6jOkEMzFIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWWbYyEIDnXHshXU20Ns7CRz6Lu3kHi4L30Gm3O51LuddUNbm
	s2a1rrlljcBD/E/DzC0B9/hO7LQg33PPfaaj8nS6fass3H6iXa8hZkoElgGMhto=
X-Gm-Gg: ASbGncuTGTUVYM4TBPUdu0ZSk/kA/1k+L7+29uOu1+hPUA2YZVBeHJKHc/6DkPHj7FI
	U/sPmGJt46hrD4Q/mHqyX+xefWZcFgMOjT4lvhgZFTiGuqsLeZdqabTblc97U6ktYGzJEx3JdBd
	vNprSHwny5fi8CIjW1qnZYXLIYBaf1U3SbyDxHMJziObxLzqzQZdgKdvB/rkS75XJJuSERCaPkL
	9r9VicFLrYh/EpoRVNrXLYq9vby9VcnrOck0UkqEaEVI2vT4q0BSG3LpoNicw==
X-Google-Smtp-Source: AGHT+IFF+W8l62dy02x+rstW26StonwY7Oe2+iYejLd+cAhPUZAboveR614K5+yughF75bXFV6i5tQ==
X-Received: by 2002:a05:6e02:1c2a:b0:3a7:ea2e:3992 with SMTP id e9e14a558f8ab-3a7ea2e3b09mr117670445ab.3.1733274417755;
        Tue, 03 Dec 2024 17:06:57 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230da8ea7sm2809030173.32.2024.12.03.17.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:06:56 -0800 (PST)
Message-ID: <e6b160f0-88f8-415a-9734-2ba659619688@linuxfoundation.org>
Date: Tue, 3 Dec 2024 18:06:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other
 people
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 01:14, Thorsten Leemhuis wrote:
> Point out that explicit permission is usually needed to tag other people
> in changes, but mention that implicit permission can be sufficient in
> certain cases. This fixes slight inconsistencies between Reported-by:
> and Suggested-by: and makes the usage more intuitive.
> 
> While at it, explicitly mention the dangers of our bugzilla instance, as
> it makes it easy to forget that email addresses visible there are only
> shown to logged-in users.
> 
> The latter is not a theoretical issue, as one maintainer mentioned that
> his employer received a EU GDPR (general data protection regulation)

Thank you for taking care of this.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah





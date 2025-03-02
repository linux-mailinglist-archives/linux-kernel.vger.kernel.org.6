Return-Path: <linux-kernel+bounces-540722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C05A4B435
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E821890106
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE31EB9FD;
	Sun,  2 Mar 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="OdR0dY61"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D309AD39
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941531; cv=none; b=DMnITNksmi45UfY7crENu03bgUZIIaKdCg3YOCOJGSDhSrBRf0QKx3ij6PCf7Ouvv4wjG923FD3NDJZPyGNJwzEkQHx5PgZgZl3K4AA18C0ps87BoqDrKzFsCJWY2I7B0fy8ryyLNByhym9Ox9wF5FDTUZ4pYDR7doPwvzj/fiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941531; c=relaxed/simple;
	bh=2YMARwFzpT/2fxXckH/UHsQeqc+WpNlGXz87LpMaUd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ic2ow8jCqULQp1WDZEzWh+wBb+ol5LorB6+dh+F0kj2fUJ3BvNuYJaaZCAIFnEvW9RSHCAoO6TLiWl7VReGuyKmHtoGIq2/lpE7p+xAShSmZLEJcKHj39jdhYuEx/+9piDpq7K7d/xmY5wLO2oPqUr1SrhoVAg+sZN0ZbEo/ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=OdR0dY61; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d2b3811513so14629035ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 10:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1740941528; x=1741546328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7l7zFCEphXv5rcB1xTH7E9WWTKLPr1rVfyP4hQcYq8=;
        b=OdR0dY61TX5AJXZhlonjpCk1JIgVFFxqwClSDjuHlNrLbhwDKGADhJYbTUTb7sE1+5
         TsraLkBGn5nBVt2Ozn3J1q4LdUraaoQyd6t8+HTdGAhUkQ4ZuxmbQ2QHDVwsNHqX0EV2
         /cHB8KhgnalUvlDxl2W0aC9R5R91lKzZsy4yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740941528; x=1741546328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7l7zFCEphXv5rcB1xTH7E9WWTKLPr1rVfyP4hQcYq8=;
        b=A2xhptySVDizOvfRqRkzVuCUwBYoNrUiu2RAp3ki3+IRpVDfm2xLZJeuXsmUqrRPpo
         A8Nj/+gBkZxDvifP5eK0lxeUxmrfkRctrHTuX6bCasvQ7gZSK9akG6/QwzOzPjQcE9VF
         tBn5wloZ4SlvnpLd+ZuA6mkj0rVIjaTCZsik7h1Rb1uPw5l2/dt5UtOcY4npDep8KVCV
         35nQYMWgyCo4eaNybVxZMZrAAb+8h8BC3Nn8uABv6Vq8f6xd05Rqb0chY4jd+isgNhrs
         f58eaoahDST64usyEOnMpVzp6UuzYIcB9qNvWk3xotn4u95FVJmhEo2bOiKjW0jxeEN1
         dVog==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0kYddKtCQZtGX5eXZGozlfRWf5gwmA7SYHvIc25OztjWkutB1u95NfmL6eUn9XAUQBVMDEd9rT1Yhss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkjL584nQXhSvuQ8n78HCBoqq61AKTXKGYiN/REYp+d8KvUVk
	zoXdJXNYxv2u3+rtCk+3A5Wr0TkTEbaCyREsXkRQbarOt0VYc4W47O7hJ7YseA==
X-Gm-Gg: ASbGncv1IR3yMdcbWGQ57AHnCmeh1lMpMmO3gCZagTtuSDfhZg7WkqnlxPgw7fl1WlM
	B7MvgLW4zDgKai6IyhU6Kko8QJ8B84tQFU5aZXs/rQm5TnYH3QTSQTGaH+cKYI26XwZ256ApsHM
	WsOmzEpqQn7+O1Zo283zQRX66eFznKZoDLPc7oxf4X3CatMDyZ1qo927NhCvLQrzTZkPCQlJ3Yb
	bqA4BzqjagWBjBVbUGGmDUCIGRzLz1mqdm/R9jKZFaBRsN/CfiwuS5bLsdN6e6gz/BkdfPzhr0n
	mvlgmlDTm+IsgYNX5lvS97NHUuSVeQ8ah0AeEt1SHaCiiDBPJ3iQQZBxbc3lLhYIqYsut3kaYBZ
	MqerJ0A6APdRd
X-Google-Smtp-Source: AGHT+IGaYwptaiL4qcE0O0nJBy5S6QCvEaXlN2oaucVjj+jdPUcbQMj/htRswkhfxl61JYv1Owe54A==
X-Received: by 2002:a05:6e02:1d87:b0:3d3:f72c:8fd8 with SMTP id e9e14a558f8ab-3d3f72c907bmr39999795ab.6.1740941528462;
        Sun, 02 Mar 2025 10:52:08 -0800 (PST)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d3dee70df6sm20104735ab.36.2025.03.02.10.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 10:52:06 -0800 (PST)
Message-ID: <16588001-9fac-4508-87f8-026acfee8b34@ieee.org>
Date: Sun, 2 Mar 2025 12:52:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fixes for IPA v4.7
To: Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 phone-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
 <20250228145246.7b24987e@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250228145246.7b24987e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 4:52 PM, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 11:33:39 +0100 Luca Weiss wrote:
>> couldn't be tested much back then due to missing features in tqftpserv
>> which caused the modem to not enable correctly.
>>
>> Especially the last commit is important since it makes mobile data
>> actually functional on SoCs with IPA v4.7 like SM6350 - used on the
>> Fairphone 4. Before that, you'd get an IP address on the interface but
>> then e.g. ping never got any response back.
> 
> Hi Alex, would you be able to review this?

Yes I will.  Sorry, I've been sick this week.  I'm
feeling better now.

					-Alex


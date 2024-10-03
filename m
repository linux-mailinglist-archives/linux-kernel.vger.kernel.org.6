Return-Path: <linux-kernel+bounces-349688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1D98FA0E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA4285065
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EB41CEEA0;
	Thu,  3 Oct 2024 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RFUMms5u"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B19186E3D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995673; cv=none; b=I1DttaCceM4XRqNBECw+9rnHoeoN2GpqEYW5bzfPH0DS7tTMPT5vR3MvIhgKQ1zb4L5SuO8RJnmcRZgGq5Zsm4F0o1OA7BdAuUJ7XHv4v3l6q1qb+WLuGg+vZB/iAVpvW6A0UW4e/udAglxqgl22EipW5zwjGM8H0tFLXpkxwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995673; c=relaxed/simple;
	bh=THaXy6+u051loGTDeAhA3mE4vMkJt1TVDyebfmOiy9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKW2UHCg/kPftrE8ZNrmvhvSju2gg01W7CnS0EaPKrEWBnVeqt8zUKeOIK8u55/I4VmfizpNq4IOl3h58/EDowDmCI2AJO4Egspb+XutHr/iRD0y74Z06KFilmHAjPoiy3WmtM9t3xWXDA4hk1S8FCTcUqbu3jg9yxRgIU6mRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RFUMms5u; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7ae3e3db294so86583285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727995671; x=1728600471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BmI7J28E3beeW7Za6bfO3DcDy4O3gXqVpIn/O1z49Fc=;
        b=RFUMms5urmndf3LQIB/jO8dIvql4QpgnR49Z2+3GZ2hoJY05YqFXpYqSGmlclVD+yi
         vsStoRLmzSnp0pYBMbJtWdHM6nkp2nhUXLjzo01CwfX2DEfCN12bgB8ZqHEI2BMoNWgy
         8ygp3g7wLVCiD6A65tpwdWhRaUib+7Gx9z65o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995671; x=1728600471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmI7J28E3beeW7Za6bfO3DcDy4O3gXqVpIn/O1z49Fc=;
        b=fx3iZUEJyXCuIPgOMWlxaJX7AYtkjY4lGGC1h/7ZKNUrWnK0xsnbEidulVk5phzHYC
         8jueHfSkO0XKZ0hF6Gj566ZPJyEG82mPlNYc1ZqT04DtSw5MEv4mP13rvKU+w7TJ/cSt
         Tupse68e8A0LED0s9xtG6TQMPfGOBXzi2GPvCX+aSNffVhH0oM0GjIXqrzKSEwppsFf5
         +FzbqNwQKKXTSMuZ7rAOY6+r/OZWKZKWTMQws1WvckqKAgGO2Q1kLfzdTQoh6G1Bo8XD
         r2hJbp2AniPM8QwQLJ1CstjnKT2FslL9HPPChY/iXZ/2gqWvwTsv7NDhtyoFBwYKdMvj
         6DbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp08CpQqjiQ5pdyqa2am0AAOHGSDE8yptduAV+bibUMSggymxhLQsEW90lpOJ/Rk4G+sCrgEImZiWZNi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZScgqZJGGwgVagN8+dy7hw5VkVNLy9VHtChknsjAzJ7vWgd6
	9TAdxXrN2wm6H/Js+M20Jaw1uIN34xKZpPq3z934d3Cc+zUhX6NP+m1ba5x7nA==
X-Google-Smtp-Source: AGHT+IEt7LKLogphV2L/o12c4qyB1t73zE57xNsz9cd76L1N7lwhnXI0lbod2xDOcxriUz8GrfImOQ==
X-Received: by 2002:a05:620a:1a0a:b0:7a9:d0d2:a5fd with SMTP id af79cd13be357-7ae6f4864bcmr108258785a.49.1727995670727;
        Thu, 03 Oct 2024 15:47:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3a2e71sm84421185a.55.2024.10.03.15.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:47:49 -0700 (PDT)
Message-ID: <697604f4-ea38-4cfd-a4a8-3a346d4735db@broadcom.com>
Date: Thu, 3 Oct 2024 15:47:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: usb: fix Broadcom driver table indexing error
To: Sam Edwards <cfsworks@gmail.com>, Justin Chen <justin.chen@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241003211720.1339468-1-CFSworks@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20241003211720.1339468-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 14:17, Sam Edwards wrote:
> The Broadcom USB PHY driver contains a lookup table
> (`reg_bits_map_tables`) to resolve register bitmaps unique to certain
> versions of the USB PHY as found in various Broadcom chip families.
> Historically, this table was just kept carefully in sync with the
> "selector" enum every time the latter changed to ensure consistency.
> However, a recent commit (see 'fixes' tag) introduced two new
> enumerators but did not adjust the array for BCM4908, thus breaking the
> xHCI controller (and boot process) on this platform and revealing the
> fragility of this approach.
> 
> Since these arrays are a little sparse (many elements are zero) and the
> position of the array elements is significant only insofar as they agree
> with the enumerators, designated initializers are a better fit than
> positional initializers here. Convert this table accordingly, fixing the
> boot-time crash on BCM4908 in the process.
> 
> Fixes: 4536fe9640b6 ("phy: usb: suppress OC condition for 7439b2")
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Thanks a bunch for the fix, good catch! Sorry to ask you this, but since 
this is intended to be backported to stable trees at some point, would 
you mind breaking this up in two commits:

- one which is easy to review and audit and which adjusts the BCM4908 entry
- another one which converts to using designated index constants?

Thanks!
-- 
Florian


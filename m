Return-Path: <linux-kernel+bounces-366884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF399FBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A6B1F24694
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6C1D63C7;
	Tue, 15 Oct 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WR0qLvq0"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D11B6CE8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032938; cv=none; b=av7H24LMZkb6KcIdHB6IpOzm4GzN1QJVB5GbPKjSzFKsj0LzB8dvLY7AkpG4y1RDu7Cm+W0LcY9LitcsFYa7jfPcQUCxxCHZtvEnf2TyDS7McyOv3FWht4Mnu5QbGih1Nf1Z/gd4cpMq6O+urLJoHR0zX1BFosFqPHapRoJwejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032938; c=relaxed/simple;
	bh=WQjK5FLZEEhU+dVrTCVPzYt+9HCaHPxg4Hx5JdLTVfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlF0LxSz6urObh5S1s7HTTZSwtSNZf57eEVleG0IYAYSv9xrQ9ROq5WQ+mCqtmrcvbnhnsxggiq4ujX9szC/eln3WZy2gp/yvL4MhUUcnei6MdQTFWWznpeLTeYq8UcuhlRYbhz9eGRTFOMC621YYmvlUCd1FB70nm45flkg/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WR0qLvq0; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b2499c65so15352995ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729032935; x=1729637735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k93xeOUo10oQWujiX8Ujtq4yazAve1WQxIDNWLeUB8=;
        b=WR0qLvq0bXBnk45C2/yGkRRYrWB1zVcH4arszewbGhafwuSKkRFY5lO/BNeZ2qgE0o
         xKqb7FmMLwVgBjq+iS7EtjUUaw15gHlRi6zdVkNO4RfLPRyOzgMiZwWhwtMwVL83rKdp
         Vn2rlG6/7/YLYxflybvlZJGWIeeUTdQvlqtD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032935; x=1729637735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7k93xeOUo10oQWujiX8Ujtq4yazAve1WQxIDNWLeUB8=;
        b=aUZrxCcvyV4aZt8WWEcZAAJUEoWHAsGDybA7+rrp1T3zMDpHLoUOdDJopAmUXNge96
         iZuOJP6jkSWoARLulF1SAv0897T+fHvLZToCIclIW9JX5JdjFN8i99VGhrXDiS4Ctlai
         XBOa3YWHIBvPfGlHnywGd7AaxLa6Q1x/iPNJ18Kwm16xk6XkYR+lMJN5rNaW6RmdyVBC
         2CYQCVzy4xaPEpzpgirCWXCzNhbFbzlF1FbxeWb95WpT0QEuKNFBO0MBFlhV9vu0Lg0B
         4+jJfwcXI+hBsTxeOPefcjKSg2acaIfGeR5c3m3/Rd4SZ0lc1KBkCB5GF7gxH7FpiCmq
         yDfA==
X-Forwarded-Encrypted: i=1; AJvYcCWPyp9nlI7yEZKbGleP3/BwOSROElDk8oEBP/c9LoZ5PM6md/1aWSya8mlQEaAfcJMCgSkBrryPKCKEeFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNd2D4DT2Ypyq845d6AqhfnfBD1uprf3OoxSsOLEtEDeGlHOV
	/kbv9/PqdxNzuCRH7xhpzktSVl/YB0Oxx5sQQZ04jUpw8FTtmNMnK7mD4ZgwMyI=
X-Google-Smtp-Source: AGHT+IHY99LhDm13B/TrzxEPQoDbwaPzU24insuKtvESXOJnVs45TI9UOS1EdYa68kby+poGQGvadQ==
X-Received: by 2002:a05:6e02:160c:b0:39e:6e47:814d with SMTP id e9e14a558f8ab-3a3dc49c43dmr22393615ab.2.1729032935471;
        Tue, 15 Oct 2024 15:55:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecb38c85sm535170173.89.2024.10.15.15.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:55:35 -0700 (PDT)
Message-ID: <f53523ff-1222-4fc0-9069-10ab895e1136@linuxfoundation.org>
Date: Tue, 15 Oct 2024 16:55:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: Move free after the variable use has been
 completed
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015215157.18571-1-everestkc@everestkc.com.np>
 <99056bd3-748f-42e8-a25a-131f7b194f55@linuxfoundation.org>
 <CAEO-vhEwkQKnPprdw_r=mg6KRbadY6B4A3R_sOsyH0ds78wb2g@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAEO-vhEwkQKnPprdw_r=mg6KRbadY6B4A3R_sOsyH0ds78wb2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 16:48, Everest K.C. wrote:
> On Tue, Oct 15, 2024 at 4:35 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/15/24 15:51, Everest K.C. wrote:
>>> The variable `in_data` is freed, but used later in the code.
>>> Fix it by moving the freeing the memory after it use has been
>>> completed.
>>>
>>> This issue was reported by Coverity Scan.
>>> Report:
>>> CID 1600783: (#1 of 1): Use after free (USE_AFTER_FREE)
>>> 19. pass_freed_arg: Passing freed pointer in_data as an argument to
>>> ni_usb_dump_raw_block.
>>>
>>> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
>>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>>> ---
>>>    drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
>>> index 1da263676f2a..75f39e1f3ed1 100644
>>> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
>>> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
>>> @@ -690,12 +690,12 @@ static int ni_usb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
>>>                kfree(in_data);
>>>                return parse_retval;
>>>        }
>>> -     kfree(in_data);
>>>        if (actual_length != length - status.count) {
>>>                pr_err("%s: actual_length=%i expected=%li\n",
>>>                       __func__, actual_length, (long)(length - status.count));
>>>                ni_usb_dump_raw_block(in_data, usb_bytes_read);
>>>        }
>>> +     kfree(in_data);
>>>        switch (status.error_code) {
>>>        case NIUSB_NO_ERROR:
>>>                retval = 0;
>>
>> Looks good to me. Isn't this on next though. Don't forget to
>> indicate it is against next.
> No, it was fixed in the linux-staging repo.
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>

Okay - by the way the same problem is in ni_usb_write_registers().
Did coverity catch that one?

Both problems could be fix in one patch - I will leave it up to the
maintainers to make a call on two patches or a single patch.

thanks,
-- Shuah



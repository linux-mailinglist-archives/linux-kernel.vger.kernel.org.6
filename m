Return-Path: <linux-kernel+bounces-548053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23365A53F40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2061727C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43C1CD2C;
	Thu,  6 Mar 2025 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiTd9+NC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6417C98
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221684; cv=none; b=YJMy8Td+dg8YvCeirlrlRzYVNvu10j/wY874NmA72h3OQf3IJwayU2pNoHEoSsiz1g9yLCVx2MSOcaEOI9BosaCZ13TXlX3nKk/5ZDMLyVIbnGLKqxnlP2oU6TqYr+A4ncIeqtEeg+X88/BK+4kqakSHTlgfN9JKWyDJ15Qg+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221684; c=relaxed/simple;
	bh=HPj+5xo5Q1mINKdpDnQt4YrSe6Q9acxJZ0zuuzjAtog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGnTijrUk6w2Guzk865liEeftpmTmBUdWVl7bnF/S2YblW6MG+V4FQcnZdSpEWZ/1xe9ZF6xSInoiCxkMYROrnK+3Gjh4q1/WLbiyY9gFltFEwbAsxkj7fXaQKBHZQC1Z/pxMhyQX6QJI2mrw2upWgWUGNJ08QREK/RmVVDvjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiTd9+NC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223cc017ef5so977325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 16:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741221682; x=1741826482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJS4vIme2XRYo7gYissfnQCjryFp+JUtXU/dFEi218Q=;
        b=JiTd9+NCPE/zPiiXu7rleX9zmLZ0mMPKdXIkSkRZ/93cDoMZegwOarw071aLDch/yR
         5FYnS0MP/N2JR7O+y945biPH04WJvS4m2+9WtkrI5VImPZCSX1LO8pcq3hTkbTy3KGGk
         jsXgQ657Vebb8uwB4CSMve4ZiBw5eps3JXrbr0S2iil9JjujAU49j1RCWMa2OITUHEcV
         KGy3m4JUpVp+Ex911r2TH5HwyPXbFiqmBKnZHy2kX1cKDRuu+y2Zl+H5OGaodwicnZ9p
         e9wWI0a3i2LD/mZcm71TilpJZya5/RHlOtpquo3Xz910rDCa7Dt92Vjctvpp4e0E+DNm
         G9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741221682; x=1741826482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJS4vIme2XRYo7gYissfnQCjryFp+JUtXU/dFEi218Q=;
        b=QbUc25NeQIT039jxnZmK2VEQzrvdQHU2xV8TA49BLMJzItRK8J8eIBN630vOdWIG7q
         QbxDnjV7zvRO5Ts4RUtYGKANJNdnNgbaaAf67jj09rDC7IO/JPXTlT9OA6egC9DfX17N
         m0tNiJiiv3tbl2QOQqwvDFilT0FLUvlfDTvv4zk+bpfOQfOVMNKvTVhzp+O/P4PEQX5J
         HXKyq1P1/RKIWbC9mHTKiE2qVY79CTRXoij81L0TlsitNCgSPERMQIOmVG33mnppuGtn
         WYc7NfEKRps8io4vc2Mc1ki0OU+ijlCiayXBFjKL2FQvH2gVzJ3TxkAqo01D5NCUoAlt
         0zgw==
X-Forwarded-Encrypted: i=1; AJvYcCUHTeCh3wyEOQaOzcmP8P7O8brQVQ85wNbvVsr0/mDH+LGuHm1hDOfsplFQITcEoFG+nCrOd+JuG/hWycg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0DI0s0p2Xez3DZc5AxyArsYdOgSQ8g27pxsPGAXQA+PfI4KB
	VCfrcnjXGFar3u54suaIGh9FHzmJgn+deXK2WpDQXSuCuzWPk3Bc7obNAidx
X-Gm-Gg: ASbGnct1cFBsX4iYgPI1M3GZglRocgNUP9qPhzRmsXY2mHPPv8xFVAeqq74A980F4bG
	ErzoZEyL6UED5zE+ufxoMWb4ovxdxX43tswPcaHHaIfiOLTM9LNTQT4QYvRvwUJC4AvMqQtb680
	wtqlfYV/UAkSBxmfiJt1aVWyn/IwdvThY6B5dGboVrAJ3o80Z695Du/y0YHHdm6gxXUF8MOsay/
	+2XHOvw4talE7X40GrA7GGO2wt3hXdMmsuf2wuLWwZXGlHMLliyRAOylscWpZuyyrx0C9tGyiR9
	TY6YmSUvtTv/rEBCZFn+LA8NaL+7Zc4S1WrzxBzi6SGMAV7gDsQmf3s=
X-Google-Smtp-Source: AGHT+IGestbbM3d5yblSv9oj4OnWHTUe94tkAcFNcUGU/J1qkhblIgnziBVwj+pUtT2CkF8KuEgE9Q==
X-Received: by 2002:a05:6a00:148a:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-73682bb910cmr7917355b3a.13.1741221682499;
        Wed, 05 Mar 2025 16:41:22 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698538751sm58870b3a.170.2025.03.05.16.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 16:41:21 -0800 (PST)
Message-ID: <139f9e25-160c-48da-86ae-4a14bb36dbf5@gmail.com>
Date: Thu, 6 Mar 2025 09:41:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] MMIO write access to an invalid page in
 i40e_clear_hw()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
References: <ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com>
 <aba0a368-b2cf-42bf-b2b5-eb09779fb214@intel.com>
 <SJ0PR11MB58663C4BEE68529970784114E5CB2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
In-Reply-To: <SJ0PR11MB58663C4BEE68529970784114E5CB2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25. 3. 5. 21:11, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Przemek Kitszel
>> Sent: Wednesday, March 5, 2025 11:27 AM
>> To: Kyungwook Boo <bookyungwook@gmail.com>
>> Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org; Nguyen,
>> Anthony L <anthony.l.nguyen@intel.com>
>> Subject: Re: [Intel-wired-lan] MMIO write access to an invalid page in
>> i40e_clear_hw()
>>
>> On 3/3/25 11:19, Kyungwook Boo wrote:
>>> Hello,
>>>
>>> It seems that there are invalid page MMIO write access in
>>> i40e_clear_hw()
>>
>> Hi,
>>
>> is this something that actually occurred, or just a theoretical bug?
>> (depending on that we will apply it to different tree)
>>
>> please send a proper patch anyway, as it looks legit to don't go bananas when
>> HW gives you 0
>>
>> (and CC netdev instead of generic kernel ML, perhaps that's the reason this
>> mail was tagged as spam for me)

Hi,

thank you for your response.

If you’re asking whether this happened on a physical device, it did not, but it
is something that can be triggered through virtual device with fuzzed input.

Also, I'll follow your guidance when sending the proper patch.

>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c
>>> b/drivers/net/ethernet/intel/i40e/i40e_common.c
>>> index 370b4bddee44..97ef79be39b3 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
>>> @@ -848,19 +848,25 @@ void i40e_clear_hw(struct i40e_hw *hw)
>>>   	/* stop all the interrupts */
>>>   	wr32(hw, I40E_PFINT_ICR0_ENA, 0);
>>>   	val = 0x3 << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT;
>>> -	for (i = 0; i < num_pf_int - 2; i++)
>>> -		wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
>>> +	if (num_pf_int > 1) {
>>
>> instead of adding if conditions, I would simply change the type to be signed

I’ll incorporate the suggested approach when sending the patch.

Best,
Kyungwook Boo



Return-Path: <linux-kernel+bounces-312770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A63D969B00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BF628708C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E21A42AB;
	Tue,  3 Sep 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="My3mRlVG"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D421B12CD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360989; cv=none; b=Y9c6s4ycDdaL2bZsSqV29P9ZoETKE8TeOG+zxnLC2cPDKtEgyWambDDXbOXEMgTd/2lcHPOcQCOlcT8COaH72wwmwWiBAuszVPjtaHMQSWzDLrl2O1VKBKTLV6qyxrtCw8wPSfCy0igb9oJzmIlR31FRnSsHLXh9HaTjidFGZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360989; c=relaxed/simple;
	bh=3UYJC5DIR/O2NREOaIE2+PZ6+tLYVr4tfXxGSTKr3Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbEAgoyzk1dviryX4OKAqNdMTqUPYZ+U7xqwtH6Czo5JDYy0BY1R16DZIf/tSNlwQ+DIH7R37ZUX7C/0YxERIRmHhXzJsg0YCaA0+oMmHQeBQ+cQpxIL8pE1vcOAzqKgu5Yv9/SHe0r7Cv4O1ZKLs/COrl3vvwDMWEAjJhWY7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=My3mRlVG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso65797001fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725360986; x=1725965786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDvb0WcuPHeizgGgsmrLYwvbAH11f64LB2c1bYIjiXk=;
        b=My3mRlVG98chCijkIXHBoyud9kLKruOfJsLFFfHzomVCQAScPJD1Pppmlu/Bbs4A63
         debI4mVTZf+F6xR4depKBRTLatur3j5XvRc7Cv4Z/5o8z915MQvOtpCI2/Yr84bp8jRD
         WgCn6LCWyOw3PVWoCVVin0CvC6eTwyGm66CTaLgYf2ypewxSnWhWxZvnzd9SzBPqApRG
         3m10O1cHRqnfKiYVvKRhBSX6iDcOTKScaQ4ttsmx+W/QvzRojxNo7ibPkNvyyNvdzB/B
         5uldNbzil+xEDgbf1CTfqUv8eJBJ45+i/upGKmpRZ+KVOS8QTNSWpfqtLu0MbPCg+no9
         exwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725360986; x=1725965786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDvb0WcuPHeizgGgsmrLYwvbAH11f64LB2c1bYIjiXk=;
        b=LKJzrC3atOFAlVW7O4DTbPFyAHC1f7hwplOGY97PRLk49wg6oKRZuOjtaXEV/tZ5DR
         7F6DRLtUybLCB62pAObJYOJchEn8ouQ9WSPgGsawhDHFbtzhOcSsXuy4HlEiqOr3Ut1Z
         S4fVhuqQYnS5fpg0kMgPyjK2Tl5JCxY/0vWCkOi6Kl/y7ljzoRSH9lDOjQ5Sixm/tdDM
         FP6ylII7egPmR6kdOn303LgX1jaSK3rCghmdsIiD6nGDXysgJQjRrERD2Rdy76C07ARu
         4zAbzl6nDoI+rDflSRLr0ZHX1OYrVfDMgp03N2XNbOXbCYVP2reO27frLwUmf8+UPFJr
         FJrw==
X-Gm-Message-State: AOJu0YwG8pSKqw1PX+QpRNOjYEvyqkEVmcU079FBkWW2AHewV4VUVX2r
	pAsuMlP2WAUgvGjH+jpG1fl4C7T5dbbYOUVjCADRD9ctgRYBA+HoH9whwWkWoRJbfb7SdzyXq1v
	U
X-Google-Smtp-Source: AGHT+IE2cI4NH67RfwNyzjVdcXzsvdId6Gg17wD6SGu8dgF2FWmIkcDLP8i7MYI4imgJhdqGeV5F5w==
X-Received: by 2002:a2e:b887:0:b0:2f4:fc1c:e5dc with SMTP id 38308e7fff4ca-2f6265d771bmr85954851fa.33.1725360985503;
        Tue, 03 Sep 2024 03:56:25 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c245c467e7sm4040089a12.50.2024.09.03.03.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:56:24 -0700 (PDT)
Message-ID: <90a7917f-7a7e-4904-8af2-c411c198cd80@linaro.org>
Date: Tue, 3 Sep 2024 11:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvmem: fixes for 6.11
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
 <2024090351-monument-hydrogen-f495@gregkh>
 <a326aa34-a683-4efd-af7a-f2f264c7fc4b@linaro.org>
 <2024090357-cardiac-foil-6476@gregkh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2024090357-cardiac-foil-6476@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/09/2024 11:52, Greg KH wrote:
> On Tue, Sep 03, 2024 at 11:45:59AM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 03/09/2024 11:20, Greg KH wrote:
>>> On Mon, Sep 02, 2024 at 03:25:07PM +0100, srinivas.kandagatla@linaro.org wrote:
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> Hi Greg,
>>>>
>>>> Here are few fixes in nvmem for 6.11, Could you queue
>>>> these for next possible rc.
>>>
>>> You forgot to cc: stable on all of these :(
>>>
>> Sorry Greg, Should I resend them with CC Stable?
> 
> I fixed them up by hand.
Thank you

--srini


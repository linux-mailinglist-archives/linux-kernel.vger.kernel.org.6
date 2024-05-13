Return-Path: <linux-kernel+bounces-177524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A874C8C4026
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B0B2833B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31014D704;
	Mon, 13 May 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy0aQAEt"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146914D2A4;
	Mon, 13 May 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601096; cv=none; b=pkcwc0OqRLV99XW5lEtmJ8JHGWzpRzTvOpthaIWzlefIDs0bTP3uqynxAuIKr7Y/102LDdencUuASgljPS/Xz7MpqIzqHqSpaWRZGHzyIaO8OKCdZTpbfhhbQRM6fvYMquJiZI1Ili9gCuJwhsqezt5g1oHsj5U0cpDwrSIpmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601096; c=relaxed/simple;
	bh=cuiN7VZeNudBHCC7NNrRTz1Uuo2YLNSWuQqGNFSpnrE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DKaTLt6rMQYTNgyBzryUCAfhI/8Owphe6iSaC4/zwBSS1z+XnoelpPZnwCaa9C/Tv6Y94zcJaQLmCskGPkCNUrss5gzmmPe6vk3maMdhVwJtYEl8VZ2c4bmkXzxk7laPGBJnC7OxJnPLhRmVG06QLf0xU92bafI9elyFybXlV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy0aQAEt; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ad2da2196aso2882608eaf.2;
        Mon, 13 May 2024 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715601094; x=1716205894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOCAo2YP1owERd3lcsNlFYd76qmZNOIP2lbJko76h1g=;
        b=Uy0aQAEtFuFgLBSBe+7z91KmM5QOaigLtJDspZ62xsk/Y8o+q+J1uy1gIOdl29Ekf4
         iPWaAMUcgoaC3J3VOaUuk7WhvZWtCGkvugEqEOdXRs/ZGLUhYv0fRzw3S2cjnlG/1VGE
         NiImtnJgqtNZVJktYsfLoaAczzPqhIjSXsJAZkJJiCGZwRrgTAPmyr1YvGiB+1ftSOEA
         foasTmBandexqJU3kYSzu3EKEeZe0vA2wqG2Q997pC8Nu1ApozH7+GwMHWKSPykHN4ec
         1g2CdLmeI4HbTk7ElnxwmS2CwyDirHNtlJkLyXlgQZJBWyfRB9hBn7ffkvUqBsfUJdoN
         Be0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715601094; x=1716205894;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOCAo2YP1owERd3lcsNlFYd76qmZNOIP2lbJko76h1g=;
        b=CUs84M+fbiQb/OR2NBBeSC3r2oIh6rC2DvpeeXfDKGHYODc2opy4aMulf3TC5L8+As
         S4zbTrJc/QljefbG/hOnDHL+mCGeG6Euh4OdQdZPh0tcSrPDf3UmJ3OVligOda1um+5b
         8GpqeRSeY0hXOmIhxeEaMxsF+tWFHl+8MfTOg+yFyw6AK6RxIowE44dtR3TZIxTpY8sd
         TWn9vLD3cVU+E7p1OnoY/f0rdOo++XyNdQ2GQmjI6jhucATblGiZOJZwKU89CPUatBOz
         67FMRN8H3WYPleVHnW2qJnlmN2IM7TP/mYgnkQONz+TWKTctDPjCxRUIhga9AvO7Bq2T
         AeAA==
X-Forwarded-Encrypted: i=1; AJvYcCUqLnBiUc07mnTAooxXQ93bjWPsdsWenqZhorvPONb7R2N8seJ1UY1AiyaX6mKYl9NEJJgHeujMSLday+hFr66z14wIq7o4dD5zJuxbZvAXWB04z4QdAYmubiPozekvozyQseNv6l+G
X-Gm-Message-State: AOJu0YzA5VQ5cpy1NTKnNP3uHEhrkME1oPm62Z6mltq04U8FjtHJySGM
	80B2MtdbFB0ZIyhAnKx6Zvbo4WZbiQOyPWqbzvZ0pWDdjoDJwol/1ZexLw==
X-Google-Smtp-Source: AGHT+IGMpFjXFKpbHGbcskj/jjXkjiJcqlHpFk/YgF4jtXzCXgbYXweazhnQZgKd/wyNGdJGI4V5Iw==
X-Received: by 2002:a05:6358:52c8:b0:18d:6fba:d2f8 with SMTP id e5c5f4694b2df-193bb612b95mr1275239055d.13.1715601093984;
        Mon, 13 May 2024 04:51:33 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f7130sm7548152a12.64.2024.05.13.04.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 04:51:33 -0700 (PDT)
Message-ID: <56da5a74-be65-4f36-8d78-7423e11f537d@gmail.com>
Date: Mon, 13 May 2024 20:51:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jani.nikula@linux.intel.com, didi.debian@cknow.org
Cc: corbet@lwn.net, dwaipayanray1@gmail.com, joe@perches.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 lukas.bulwahn@gmail.com, Akira Yokosawa <akiyks@gmail.com>
References: <87a5kuez97.fsf@intel.com>
Subject: Re: [PATCH] docs: dev-tools: checkpatch: Add targets for checkpatch
 tags
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87a5kuez97.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 14:18:28 +0300, Jani Nikula wrote:
> On Mon, 13 May 2024, Diederik de Haas <didi.debian@cknow.org> wrote:
>> Make the tags directly linkable by defining targets for them.
>>
>> Closes: https://lore.kernel.org/r/8090211.0vHzs8tI1a@bagend/
>> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
>> ---
>>  Documentation/dev-tools/checkpatch.rst | 216 +++++++++++++++++++++++++
>>  1 file changed, 216 insertions(+)
>>
>> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
>> index 127968995847..6499e29c3a19 100644
>> --- a/Documentation/dev-tools/checkpatch.rst
>> +++ b/Documentation/dev-tools/checkpatch.rst
>> @@ -242,6 +242,8 @@ This section contains a description of all the message types in checkpatch.
>>  Allocation style
>>  ----------------
>>  
>> +  .. _alloc-array-args:
>> +
>>    **ALLOC_ARRAY_ARGS**
> 
> Alternatively, you could just convert the definition lists into section
> titles to make them implicit hyperlink targets. The rst stays cleaner
> and there's no manual updating.
> 

+1

I misread Diederik's intention and thought he wanted that single target
he mentioned in the other thread.

I believe Jani's suggestion is the right way going forward.

        Thanks, Akira

> BR,
> Jani.
[snip]



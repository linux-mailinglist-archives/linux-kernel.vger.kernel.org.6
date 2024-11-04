Return-Path: <linux-kernel+bounces-394796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860EC9BB3FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62161C213D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43851B6CFC;
	Mon,  4 Nov 2024 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVPREdKE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4281B3949
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721456; cv=none; b=bUuTj1hnNlH/D6/n/jYWD/5Tgi9zDbhmeiMQoSw6q5CsfJ2YxMGSaQEUmE9lHly4Ezj2WdCVxR+hzHhkA62gQVFwo6q1uvrqOwRZgjndazxvK/8hagvVHbXEy+0TPD9Z3Fyb8H7LIoVY6BZW+AR3+LxoT6V7/6KjQw43sMlQWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721456; c=relaxed/simple;
	bh=ENuI8Cw+fc45b8DadsxhaxUTJ73WEwlP/Ka2eaHGpOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5er+fCbs4kJY120TVlpo03/6c2qFO+KeVgWlAgx7O4S4KHaVX5YV3R4usgxPG/1pE99SFYKMQ7bVt2zcEINTIHsPbxvBpgjdKgFNA3HEkQr39TlIovjzaoMkdzBcH3CRtHDLToBYYroMARmnXUZ1Ld4vJzdfKwD666hmc+q74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVPREdKE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730721452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOUaF/LBlXePtFdPHT2PhSoD7banoABF7wTWnj8GaP4=;
	b=NVPREdKEoyHTVQAIeuyq4KIeZDJfSogPYpSCcrtUpL6LSONf4RXlbSYB9PIT10isoJ+xY3
	r4tRhvP9SPJhb+ZNxtpl4b2BJ7fBcS6AqRv/4DLfIk9yttPxljIYJ1wOWVhQv0BT0qsWLr
	gy7M7enmeFB1puyJ1cSwlGsV6Sfe3GE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-vMfDUPL7Ni-3UAu9_y-lXw-1; Mon, 04 Nov 2024 06:57:31 -0500
X-MC-Unique: vMfDUPL7Ni-3UAu9_y-lXw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c9452d6344so2898678a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730721450; x=1731326250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOUaF/LBlXePtFdPHT2PhSoD7banoABF7wTWnj8GaP4=;
        b=OfvpBTip3xdkNfyuBY2G9JbX6c/siGiuo5RH534+duj+zywHOEWXydu0EM8hExJpbx
         DFbWjndZvG4eq4bW8TeOhHWETjdMjsgHeYGA9Uw0mdbQ4yffZshUooYGFzSLapqi1SZI
         jeGk5QU+foNE8XDW4Aajrd6is+SPHAhZteQas+F6mLpw3H63bdjMShmmelLtkal8Hs6b
         jYH2jprP517mWW40PZAKPIw9QfmCyTYYyxuIaSXxBl57OnrL0wDssvDGy33yGK1AZWhe
         aisK96qGIRtVYSnrF9Mope4GvJ3va8fZqAzkhHlDvJ8v6K2+7UmOFcHBjqqY1FPfBuDI
         CteA==
X-Forwarded-Encrypted: i=1; AJvYcCW33nbC9GiZEMHCXT9JSslaZwUWmnO7jfQHG7P5boB3EeC+aMRCI3TU2iCZyaQQ6C44wCSvDA2mogDOUQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAF/Isf+6VGfOM1lkxB2Y4JYJJbErcQNtUjuyYk0zLTAGAdsvs
	F6fxxusPTPUZLIY2opyGE56TrrHLUJkuD+XPT9bXw0Zv52N6qG1fq2Tr9DEuk7IkQzObcEhWPVL
	ZAiAYiDh6xh04ZipRBl4BaAm1Xlw8E12k9jqxw+HdlT4rB66eSGxJY0xb9vdreQ==
X-Received: by 2002:a05:6402:35c8:b0:5ce:cbce:ccc8 with SMTP id 4fb4d7f45d1cf-5cecbcecf56mr5248317a12.23.1730721449926;
        Mon, 04 Nov 2024 03:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBxV3ubhOD/t9qcuefF+ocLU88HRE6GgFgESC9OXnkrbEfTlnFFXEQQHxM3atfUKG07wwwqQ==
X-Received: by 2002:a05:6402:35c8:b0:5ce:cbce:ccc8 with SMTP id 4fb4d7f45d1cf-5cecbcecf56mr5248290a12.23.1730721449480;
        Mon, 04 Nov 2024 03:57:29 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789bf2sm4123335a12.45.2024.11.04.03.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:57:28 -0800 (PST)
Message-ID: <28958f62-9051-45a6-a26d-585508e2bd11@redhat.com>
Date: Mon, 4 Nov 2024 12:57:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] media: atomisp: Remove License information
 boilerplate
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jonathan Bergh <bergh.jonathan@gmail.com>,
 Roshan Khatri <topofeverest8848@gmail.com>,
 Dipendra Khadka <kdipendra88@gmail.com>,
 Sergio de Almeida Cipriano Junior <sergiosacj@riseup.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Kartik Kulkarni <kartik.koolks@gmail.com>,
 Kathara Sasikumar <katharasasikumar007@gmail.com>,
 Tchadel Icard <hello@tchadelicard.fr>, Kate Hsuan <hpa@redhat.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240923105539.3569110-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240923105539.3569110-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 23-Sep-24 12:53 PM, Andy Shevchenko wrote:
> We have the respective SPDX identifiers that are already being applied
> to the files in question. Remove the License information boilerplate.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch(es).

I have merged this/these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this/these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans




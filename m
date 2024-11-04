Return-Path: <linux-kernel+bounces-394866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695A9BB514
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D341C2165C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FABD1B6D04;
	Mon,  4 Nov 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZctPt4+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DBA1B21B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724714; cv=none; b=iau7eUN13JSVZh2bI09N0dBQfOreAIbPU57Xk55+88skV7IJpmeoAV/Wp41EmAGvrVREk1L6snONoc8bs0HDq6LMEahUZoKgQOjZ5sZnfR+dkYnxZHu36iWTD4rKrMxSo63F+fBwGFrVEyDbYDMNagptkEB6kWa8sDWfMeQkWTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724714; c=relaxed/simple;
	bh=lnsqveZ0+ThHsdtgF8Ous643Z9X8+Nqxx3nDvOsyHnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXKNvJ0HnpAAZs8RDazTHiTl6EcYVeIjLQrKGGgByJAUgOX5zuhE2TYzsS1LJtIvRbQVNw6VSgCUJF636ao//jTLLFKwsT+KyuKwW46PZgs/sGgnJ7RKsPWvPs6RBHYNCAtcXz4hcACGgqYnwCWcb/3ZVhqqoTXqZBbGlNAuww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZctPt4+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730724712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kay/f3QkJEzZ7UZJfgDuT/JkoWB8O0jH5vqtmG6BCFY=;
	b=RZctPt4+Dc4n8Z2AUD4QGtSXCGyY5Hzu3lL9XkvKr1PwIn+6GRJFIxJJmdQzeIqC/18oqH
	fY9rf1bP8IYmjf3WFSB3puJHmVBwPD50XKMmHwuPPhCjWZvVT5qkCmmr0djIEgel6XLp70
	z/zsi9+CVOiqJLamGkm6xQac3fjmV/4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-nUSmbfb5N6GZTiSplT7qlw-1; Mon, 04 Nov 2024 07:51:45 -0500
X-MC-Unique: nUSmbfb5N6GZTiSplT7qlw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a2a81ab82so327571166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724705; x=1731329505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kay/f3QkJEzZ7UZJfgDuT/JkoWB8O0jH5vqtmG6BCFY=;
        b=sH6J10v+w+3D0rVbyQXSPqKg9ylUO1+1QrvTCCDKLqQLLlABp7fPQNE/J8Uek2BFbC
         ynuq7g3qWhKDPN+l0EJywsWy2s8IeuyhIlbbyScu9ES7KSLyp19i3N7qDGOXfLX23ANj
         fHZOHLLpLLv16mobItnH16GbvAghOT+8LhgLBUYqrSA2kvf5BWeIlolMv/uxjOTDFx+u
         kediIfCMWXbu6kk/biWJ7AKQtXzhW/8Vb0B/763/1SXFCbqyw5pmE8UYQwLmzkOOqmty
         zshQMBRiEvkgJuOj1J/RLnubXOdUqtUTB1sriqfCxVYcbo1JzDX9Qzwt57tpUFp1nphw
         E8lA==
X-Forwarded-Encrypted: i=1; AJvYcCVOYgEx/6S23tsUoX7UMee6ReMvWzNKjqpwZGOkh4+/q+v5Syo42UU86uS/o8ZaUNNW7hsaLUu9nelzYf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2x0MZUftUZpRGV259X2os0IuTnzC3w4PTMffjO1HXGDAv0eK
	iARLZJMsWZ/jNzmllETgYr4qe00DgbE4p1X4qtzDS5SjZzTAeXCHFsePGsf6nHCf++BqAKHnnge
	GYxt+y9alV8GAgNaw554vGHdv158Z0E9F4Fmy18g98mQ53Il6SO2+/JXF4VH+PQ==
X-Received: by 2002:a17:907:940e:b0:a9a:b70:2a92 with SMTP id a640c23a62f3a-a9de5ecc46bmr3272712366b.16.1730724704658;
        Mon, 04 Nov 2024 04:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqeb1LzuRpJ7Mr3jNNDRouhRr6mOiie/34XpsMMVa+S06Kid3Nvi2/6g2auX8Xxu/q/b9OzQ==
X-Received: by 2002:a17:907:940e:b0:a9a:b70:2a92 with SMTP id a640c23a62f3a-a9de5ecc46bmr3272709166b.16.1730724704235;
        Mon, 04 Nov 2024 04:51:44 -0800 (PST)
Received: from [192.168.100.203] ([109.37.147.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56681c1asm547886666b.213.2024.11.04.04.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:51:43 -0800 (PST)
Message-ID: <c2dc7fa6-b455-4964-a1e7-555dd0c01916@redhat.com>
Date: Mon, 4 Nov 2024 13:51:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] media: atomisp: Remove License information
 boilerplate
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240923105539.3569110-1-andriy.shevchenko@linux.intel.com>
 <28958f62-9051-45a6-a26d-585508e2bd11@redhat.com>
 <CAHp75VdscXFTB+mfUgKBnut3_idT88mas20ZsohSd6nrcVOnFA@mail.gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdscXFTB+mfUgKBnut3_idT88mas20ZsohSd6nrcVOnFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 4-Nov-24 1:30 PM, Andy Shevchenko wrote:
> On Mon, Nov 4, 2024 at 1:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 23-Sep-24 12:53 PM, Andy Shevchenko wrote:
>>> We have the respective SPDX identifiers that are already being applied
>>> to the files in question. Remove the License information boilerplate.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Thank you for your patch(es).
> 
> Thank you!
> 
> There is one patch (marked rft) left in the queue. Can you, please,
> apply it locally to your branches which you use to test AtomISP with?
> I'm talking about 20240923085652.3457117-1-andriy.shevchenko@linux.intel.com.

Yes I noticed that one myself too. But atm I'm at the co-working and
I wanted to get the pull-req for 6.13 out the door (it already is
a bit late and I hope it will still make it).

I have just added this to my personal repo and I'll try to give it
a test spin soon.

Regards,

Hans





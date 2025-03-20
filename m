Return-Path: <linux-kernel+bounces-569765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323FA6A73D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90B97A9092
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18A21CA0E;
	Thu, 20 Mar 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IPqctJEv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908911C5D7E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477729; cv=none; b=kFIeQifnFOrLCG39kja9zA/9O+H7aYdxWKNvsWt2eCxZIweqvFW/GTkTUQfEj5YrSrA1W7IXCyDwYup0H4varz5BTSMnbUE6BFspeDIDkzwvAB9M+k1oqJoRjpXVC3O+GcE6HtQmxUlnX89qLyJfMlEHWJ97s4D4w32dX/ER92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477729; c=relaxed/simple;
	bh=tyb3BSyfsLVoxWPpw7pFhPtqnX9u3B36IHsuhOl39LY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OeqF4MiVq826VuUuQZCAHCwVBH74onGWQFSJe4p1zLXJ1SfKMf1+bfLm+CTp02S9i7ypfU7bldOWPoXaB8+n34OeQIwWTHJD6SpIY7m+k1bCydclgbgugbNIxljrKzBB/JonfB71MRCjFiHVltM7XgAjUIqIfPKgBushzx1iElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IPqctJEv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf848528aso6721215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742477725; x=1743082525; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uI37EnNIDJW1PlynZLhXmPNYAgRnAkW+7mg8+W9Muj4=;
        b=IPqctJEvmHHnC039+8R366jpoSeYx/2LPSziHkrNpDBOd3vq/JOqok+1hO5Xmb2wts
         Hm/g/tMhW0FADCdzMGif9batPCVgBrZ2Dzz0RbJx6VhEhw6DbK1KLrBEfykAHukkPBDo
         H/N4Ku8wMVrJq0x8Ot35+B847PR8exk3u/QexNWIk/5djHcHzBaGCnsYgRr0tHBqVjv/
         TPdeOw5K5Weq/2X9bkBXy2TF7+d7weLGcYWf8NnWkt7ujSAutabMhSBA2/kFPx8FIWx5
         0+FJ3pC6cm/IbOJf62kPdzCNkiizCbvTLlhBrAyh5HcSVx62uKMV5dyRUDvte5OiJRQf
         QGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742477725; x=1743082525;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uI37EnNIDJW1PlynZLhXmPNYAgRnAkW+7mg8+W9Muj4=;
        b=hl/IvT4i1EYbSKzZRbCHDtFDewORxbjE4vKQSzJGC2SdRr1dgBiTudApRVHqKXKhc1
         y5JxrbZOoNpSju+pgGxJ+pAH0sc37bAULRfiCKHWuV4voUOwCT6YS/UIjn9HEGlz1gMJ
         0z70Zi2oPfNqzPRhJc7Qcpirg9D2Uk+KvAmzsCLO4XWZzdt3y3orGjoGbmFSuLqaIAuN
         bHdwF9iVe8cL8Jk+0KFnuedVrSbdPcfgOi8NlgvSJPluYcGwpXPuf0QMVWhU6a1xX2yw
         FIrX7d19Q764hcqVDpJ9uu8ViqyS1Mp/0uy2lZ1tCRNi4PshRw8I1hGG3bsnBH/a7dtv
         cnJw==
X-Forwarded-Encrypted: i=1; AJvYcCUMEG5c5FUHf9Hs604IBmGMZpVcbk4CMNGadYyTF/8jrJRW/xn1qG6nkFxMyLYGOLiaJwou8WYIzAXqQ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdm4pYf60dUaPzH/HY+UaMiB5m7Q5uR+7CZtPafWzZ0CUI8Wdn
	h4t83dNUBspDjomIGbd7yAk0buleQ7J4V6t0NqvfxBBrhfuE5P6ucupwezfCFYp7tGdIbbTb13H
	7
X-Gm-Gg: ASbGncst+ox+gP+ruBUr60QP5KOyXSHLUfwEUbBePFzgqydXwvBIsxBos+T1O/YnqRE
	zre/fQmiD4SRenKjjxf69Dl0rhO1NYCPKZxRuWfau0kI6eeJXHDN8halUKUO9S3e7CP8nsry5Q1
	sV7d6eRvOyPXMycqKfkq6qSu7Okuys2nSldRlhEBS5ZPYvDTFCd21kWwrQzrkrjxYN6PbEvftGN
	yJlxiKGUCoj7qM10ERw8t69gMKVrxa1NZ96VvJiW9RN0yqeIUoJ+n0TPB1+8j8TeoS4uYPwBbEh
	80497qFoTBIsEgZQyHSXZj++oTv5K2eBLt3w9t9TxW/ObOV2EDXWAZC2akzdamfwjccPT1TD6zZ
	muXEDGUWpObUbXUHDuGY94A==
X-Google-Smtp-Source: AGHT+IH4JUukHITRQUmhMxxvC3m+ezaaNPBF2MAA+YZllIv4Sn+StoSOhopRFHWFdXJ7KQFMa1fZyQ==
X-Received: by 2002:a05:600c:354c:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-43d4378c2d9mr55676215e9.7.1742477724617;
        Thu, 20 Mar 2025 06:35:24 -0700 (PDT)
Received: from ?IPV6:2001:a61:1348:8f01:d3d3:1b29:8986:519c? ([2001:a61:1348:8f01:d3d3:1b29:8986:519c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f7460fsm48668355e9.28.2025.03.20.06.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 06:35:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------v00cVtf1YB61aEnjeVUoy6fg"
Message-ID: <62d91b68-2137-4a3a-a78a-c765402edd35@suse.com>
Date: Thu, 20 Mar 2025 14:35:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in cm109_urb_irq_callback/usb_submit_urb
To: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, syzkaller@googlegroups.com
References: <559eddf1.5c68.195b1d950ef.Coremail.baishuoran@hrbeu.edu.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <559eddf1.5c68.195b1d950ef.Coremail.baishuoran@hrbeu.edu.cn>

This is a multi-part message in MIME format.
--------------v00cVtf1YB61aEnjeVUoy6fg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20.03.25 05:39, 白烁冉 wrote:
> Dear Maintainers,
> 
> When using our customized Syzkaller to fuzz the latest Linux kernel, the following crash (94th)was triggered.
> 

Hi,

is there a way to use the syzkaller for testing a patch?

	Regards
		Oliver

--------------v00cVtf1YB61aEnjeVUoy6fg
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-USB-cm109-fix-race-between-restarting-and-close.patch"
Content-Disposition: attachment;
 filename*0="0001-USB-cm109-fix-race-between-restarting-and-close.patch"
Content-Transfer-Encoding: base64

RnJvbSAwM2Q3OGNhOGM0N2M4Yzg4OGRmN2M3YWUyYzcxMDk4MjU3OTlkMjM2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgpEYXRlOiBUaHUsIDIwIE1hciAyMDI1IDE0OjI5OjE3ICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gVVNCOiBjbTEwOTogZml4IHJhY2UgYmV0d2VlbiByZXN0YXJ0aW5nIGFuZCBjbG9zZQoK
Y20xMDlfaW5wdXRfY2xvc2UoKSBjYW4gcmFjZSB3aXRoIGNtMTA5X3Jlc3RvcmVfc3RhdGUo
KQpIZW5jZSBjbTEwOV9zdWJtaXRfYnV6el90b2dnbGUoKSBuZWVkcyB0byBjaGVjawp0aGUg
c2h1dGRvd24gZmxhZwoKU2lnbmVkLW9mZi1ieTogT2xpdmVyIE5ldWt1bSA8b25ldWt1bUBz
dXNlLmNvbT4KLS0tCiBkcml2ZXJzL2lucHV0L21pc2MvY20xMDkuYyB8IDIgKysKIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0
L21pc2MvY20xMDkuYyBiL2RyaXZlcnMvaW5wdXQvbWlzYy9jbTEwOS5jCmluZGV4IDBjZmU1
ZDRhNTczYy4uOGFlNjJiNWU0NWY2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L21pc2Mv
Y20xMDkuYworKysgYi9kcml2ZXJzL2lucHV0L21pc2MvY20xMDkuYwpAQCAtMzQ4LDYgKzM0
OCw4IEBAIHN0YXRpYyB2b2lkIGNtMTA5X3N1Ym1pdF9idXp6X3RvZ2dsZShzdHJ1Y3QgY20x
MDlfZGV2ICpkZXYpCiAJZWxzZQogCQlkZXYtPmN0bF9kYXRhLT5ieXRlW0hJRF9PUjBdICY9
IH5CVVpaRVJfT047CiAKKwlpZiAoZGV2LT5zaHV0ZG93bikKKwkJcmV0dXJuOwogCWVycm9y
ID0gdXNiX3N1Ym1pdF91cmIoZGV2LT51cmJfY3RsLCBHRlBfQVRPTUlDKTsKIAlpZiAoZXJy
b3IpCiAJCWRldl9lcnIoJmRldi0+aW50Zi0+ZGV2LAotLSAKMi40OC4xCgo=

--------------v00cVtf1YB61aEnjeVUoy6fg--


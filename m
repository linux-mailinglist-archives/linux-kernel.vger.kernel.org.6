Return-Path: <linux-kernel+bounces-408006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6859C799F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71334B2B1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B729158D93;
	Wed, 13 Nov 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3wEHLXZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECF4D8A3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515070; cv=none; b=Ysrm6n1tEX5+iPbZHoOGOQe91O3WB5tm96n3QJEA0b1cjFrYubMePbP5/hPAyksBwL69kJ0PlLRGli8C5PpRgqsQ3vlXgqPbgiVn0vi3VuHJ/gP4fbowVU1/HXIWrql1owFXQq/jxCXlFtdJ3hXbgmuEqPHazDwCHk34M0XK9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515070; c=relaxed/simple;
	bh=x4iKKTSVBJKmS65ID9sHs+BAIo7AqGlSroQDMtTug7k=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FXiv5ZFolFsW21IbmW8FixBKnrMXuiwnulNoAidltcKl4YHpjQEJ1jU/RjsLts+XGBHcKgRcY8TCDw3x79D8VSWbt9t18nlZNF54ZEK93bHfN/5X2vzQcxfvI6vOXIxTLWyJgOrcIgthhDyACRAlhtltrc77De+7l8TA3SO4nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3wEHLXZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731515067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vyEY1RG3O3QCXq6vNyfXcf5eZ7HPCu/wStHR+zSrI2o=;
	b=L3wEHLXZg9zhJGPKeJ1O378Kph0C98vGHacWGPi9xyDcr2favUh26XnLCxpzv2U57iFjia
	my98YwU7JQvfgbXEi4GoHaYRbnBkNtEfWbvjXlu0naPK2oCejktnjJZzafz5U+vV+sofbO
	lVsZQWcC0wKdBhaQ/VOjCkHdRp2JBMY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-o9GtQD_9MsiO0_4hQygKCA-1; Wed, 13 Nov 2024 11:24:26 -0500
X-MC-Unique: o9GtQD_9MsiO0_4hQygKCA-1
X-Mimecast-MFC-AGG-ID: o9GtQD_9MsiO0_4hQygKCA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso575386466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515064; x=1732119864;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vyEY1RG3O3QCXq6vNyfXcf5eZ7HPCu/wStHR+zSrI2o=;
        b=Q+nidqwfL3CHoxSjxGFxH78W+FCm8LQeuFzN0CmFPT0WMg6JjF+Cg6wFy6c1FH0TPh
         jpCMCS6h/PYuULbx62gZYScRhdGShJb3Pz2H25B0if+EiGqd9jphBrFCsJ6/JDxrURHb
         fr+7g2SK7lR0eqARFWLhBt4CKr/q3e7Py3uZXugX6c697Pt+hdouGevc3ZM/uQ7EiiL8
         Kc5joh+VlD0zyfVEV64VNqRs11D8xK+/oaFl02aWo0RAVaSfSA9iGOZTYBOpvRiEZqbS
         x2Hmy45X6fT6eM3oehcTJ2f7vYYr1k9rjNFdhcppWykOpXz5ecTiXkGjIJJg3GrRqqty
         Sr1A==
X-Forwarded-Encrypted: i=1; AJvYcCUDVWN3/WmpOUdYWHKCfSFHMogTKVUyTcQFtUS1c2SBzlVrGUc7tAhSLOEOB1n8ThJq6QLETGF3AcvPB5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4U0YzdFYhvFNH445UJOVvuMZfRDv6py2BB4sGeA0q0yP96bv
	qUQjqn+YxaRsICPQOcqYDIyW7JgS16sH3QIfhDIPTcep15s4NVIvF9CkQeiX18iI3D5iHg4xJrs
	b3X5zzHSJTvVtbYdHWzmiQu/39G8Lgx9LhVqsRfTTtoR8BVSYisTm3rGXTL9LuhglWi1rIQ==
X-Received: by 2002:a17:907:9413:b0:a99:f77f:b489 with SMTP id a640c23a62f3a-aa1f80fd790mr373954966b.43.1731515063173;
        Wed, 13 Nov 2024 08:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+09bDE3Oqp0ZcUejHqIUTWt/elqyj1S9mSR9QynyyS5TMAvpcpKO7cjMmnCxN8k3spOa5Gg==
X-Received: by 2002:a17:907:9413:b0:a99:f77f:b489 with SMTP id a640c23a62f3a-aa1f80fd790mr373952266b.43.1731515062712;
        Wed, 13 Nov 2024 08:24:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def54asm886648166b.157.2024.11.13.08.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:24:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ubLp492OSUr7WOoQYf06NmHV"
Message-ID: <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
Date: Wed, 13 Nov 2024 17:24:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?B?SWxwbyBK77+9cnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <ZzTI+biIUTvFT6NC@goliath>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZzTI+biIUTvFT6NC@goliath>

This is a multi-part message in MIME format.
--------------ubLp492OSUr7WOoQYf06NmHV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Nov-24 4:42 PM, Daniel Walker (danielwa) wrote:
> 
> Hi,
> 
> I bisected an issue of a missing pci device to commit 2841631 the commit title
> in the subject line which was included in v6.1 stable branch.
> 
> There was a later fix for a similar missing pci device commit 36c676e2 which
> appears to be for Goldmont/Apollo Lake. The hardware I'm using is
> Goldmont/Denverton. This fix did not appear to change the behavior I'm seeing.
> 
> The pci device which is disappearing is a custom gpio device.
> 
> I tested v6.12-rc5-next to see if any other changes had fixed the issue, but there was
> no change in behavior since commit 2841631 .
> 
> When booting up the device is shown in the pci boot messages but the device
> doesn't end up making it to lspci once you get to a prompt.

Please give the attached patch a try, this will hopefully fix things.

Once I have confirmation that this fixes things I'll post it to the list.

Note this will not backport to the 6.1 stable branch cleanly due to
changes in the x86_cpu_id macros in mainline. Backporting it should
be trivial. Please send a backport to stable@vger.kernel.org yourself
once this has been merged upstream.

If you backport this, please also backport 36c676e2 first.

Regards,

Hans


--------------ubLp492OSUr7WOoQYf06NmHV
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-p2sb-Cache-correct-PCI-bar-for-P2SB-on-.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-p2sb-Cache-correct-PCI-bar-for-P2SB-on-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmYTM1MWM3NjE0ZGQ5NzcxM2IyNjM0MmM5NmM2MWZjMjg2OTlkOGQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBXZWQsIDEzIE5vdiAyMDI0IDE3OjE0OjEwICswMTAwClN1YmplY3Q6IFtQ
QVRDSF0gcGxhdGZvcm0veDg2OiBwMnNiOiBDYWNoZSBjb3JyZWN0IFBDSSBiYXIgZm9yIFAy
U0Igb24KIERlbnZlcnRvbiBhbmQgR2VtaW5pIExha2UKCkRlbnZlcnRvbiBhbmQgR2VtaW5p
IExhayBhcmUgR29sZG1vbnQgZGVyaXZlZCBkZXNpZ25zIGFuZCBhcyBzdWNoIGhhdmUKdGhl
IFAyU0IgYXQgZGV2aWNlLmZ1bmN0aW9uIDEzLjAsIHJhdGhlciB0aGVuIGF0IHRoZSBkZWZh
dWx0IDMxLjEuCgpBdCBhIG1hcHBpbmcgdG8gUDJTQl9ERVZGTl9HT0xETU9OVCB0byBwMnNi
X2NwdV9pZHNbXSBmb3IgdGhlc2UgMiBHb2xkbW9udAp2YXJpYW50cyBzbyB0aGF0IHRoZSBj
b3JyZWN0IFBDSSBiYXIgZ2V0cyBjYWNoZWQuCgpUaGlzIGZpeGVzIFAyU0IgdW5oaWRpbmcg
bm90IHdvcmtpbmcgb24gdGhlc2UgZGV2aWNlcyB3aGljaCBmaXhlcwpHUElPIGFuZCBTUEkg
KEdlbWluaSBMYWtlIG9ubHkpIHN1cHBvcnQgbm90IHdvcmtpbmcgb24gZGV2aWNlcyB3aGVy
ZQp0aGVzZSB3ZXJlIGhpZGRlbiBieSB0aGUgQklPUy4KCkZpeGVzOiAyODQxNjMxYTAzNjUg
KCJwbGF0Zm9ybS94ODY6IHAyc2I6IEFsbG93IHAyc2JfYmFyKCkgY2FsbHMgZHVyaW5nIFBD
SSBkZXZpY2UgcHJvYmUiKQpSZXBvcnRlZC1ieTogRGFuaWVsIFdhbGtlciAoZGFuaWVsd2Ep
IDxkYW5pZWx3YUBjaXNjby5jb20+CkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9aelRJK2JpSVVUdkZUNk5DQGdvbGlhdGgvClNpZ25lZC1vZmYtYnk6IEhhbnMgZGUg
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYv
cDJzYi5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Ayc2IuYyBiL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L3Ayc2IuYwppbmRleCAzMWYzODMwOWIzODkuLmJlYjk0YzQ5MmVlYyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvcDJzYi5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0v
eDg2L3Ayc2IuYwpAQCAtMjUsNiArMjUsOCBAQAogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHg4
Nl9jcHVfaWQgcDJzYl9jcHVfaWRzW10gPSB7CiAJWDg2X01BVENIX1ZGTShJTlRFTF9BVE9N
X0dPTERNT05ULCBQMlNCX0RFVkZOX0dPTERNT05UKSwKKwlYODZfTUFUQ0hfVkZNKElOVEVM
X0FUT01fR09MRE1PTlRfRCwgUDJTQl9ERVZGTl9HT0xETU9OVCksCisJWDg2X01BVENIX1ZG
TShJTlRFTF9BVE9NX0dPTERNT05UX1BMVVMsIFAyU0JfREVWRk5fR09MRE1PTlQpLAogCXt9
CiB9OwogCi0tIAoyLjQ3LjAKCg==

--------------ubLp492OSUr7WOoQYf06NmHV--



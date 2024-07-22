Return-Path: <linux-kernel+bounces-258779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF0938C92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8791F220BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5C178CF6;
	Mon, 22 Jul 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok9d0vfL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8743178CC8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641525; cv=none; b=GKwZKe64fmDLMO/dEM7eP/X0FJL9COW9UrWLdT/AnfPNExKwICWCwG+mAEgzFyxRWeDyhNH1sNXgf1E9lEuYz5/u+5VIgyA2qh5oRNlvDlfiAdGzF5ACZRu1K17ohpr7pM58kkIKAK1XdLbeQVJBO/ki9cbIz8ywn4IVkjKfUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641525; c=relaxed/simple;
	bh=0QyacXfZuzgkd2INHuNyNsvBEoMl64GpHRJAspDVFY8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=mUQOlOWfe58T49KAUgU3y2Ffc+wEENuoIYY/cx139K0L6SojKQkc3HW64+tD/P8Yf/5FW/4bnpb/c5Lo7EVXM2jtUGpYNNZcRkvEA8aMy6SFlITWClOLiGWGXsp6S9ZpR1vo1L4QYKUoRgxZaBcrEgCvQ2f+iYIjyWNwL6xjySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ok9d0vfL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721641521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VNXV/RUvyCrDFaP7aL3hyAtCE5vZ5sEbXwJ5ivc7pfY=;
	b=Ok9d0vfLBuaFtmMe9Z78438hcary532PCCturR7Nlk2mYJahFDwwW3txMfd+xKKeZhDm9Y
	9gICnYlb3uQrwSPV+7IL+mZmqafp+rCC4EGh9rb93zz/fjKHq64dpS4js6nLptUV+9Sv6i
	paDYv7/k54++vh4wfryQGpphLQpAF5w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-C0xfx_Z1PmeCrtUlknC2zg-1; Mon, 22 Jul 2024 05:45:18 -0400
X-MC-Unique: C0xfx_Z1PmeCrtUlknC2zg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57c93227bbeso2054937a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721641518; x=1722246318;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VNXV/RUvyCrDFaP7aL3hyAtCE5vZ5sEbXwJ5ivc7pfY=;
        b=kRIcE76MRXbfLYzC9zuWV2A/obwgK6FyG7YBLtnyiNMXVH29x1gE3VF2k5A1YErqt3
         QEGAQhP24akeIAns1iupfVRYvO/t/frk497Eqw3zusez+xWFsMZZ8Ss0FOqKf4HI7vBZ
         upM8vR5ruINCcQ52GFzhTzAiLNp+tolq4OHNSq8KU6fu9SswgR1f6xyfQW4MtyAU3UDY
         2aT2qBMoceOtb19tdBC6jIKXIyIHH6mR/jxhRkls9Ir6klBA+R1AqbmvmWVQTBLj2Cza
         Z7lHiP72H2wc6XXG28Iy1o2eiHUGn7nDK6zRMYjrk1DbNTJLaI9NWA9kHPHn7A3dI1OQ
         Ctdw==
X-Forwarded-Encrypted: i=1; AJvYcCU6iNiqegDqfZKoGniTpqVTwQwsBQAlBI603ZWeZRdRYzPGpqA/F8VY0zG1aPKdUAW14ACX5w0R7++x+Vad3+86c+jTJd0Fwf9Usloo
X-Gm-Message-State: AOJu0Yxs4bgxm4Q0O8Mu71syu1cRW5aBWOHoqI7ZqlrRWdxdjjIlclzz
	0B1n00MOeGaRrzAFyvI4+SY6Ki78P28KKfkLYl/xKnCKkcEaZgw2T4paNO1P+QqV5o5NogauJtX
	prWToYStMOVDrXt6WXvOsTKLsYNUDswYHjoXo2Z26ysNAyW/c5nm0D9pn5fPlXQ==
X-Received: by 2002:a50:8749:0:b0:5a1:c40a:3a81 with SMTP id 4fb4d7f45d1cf-5a4f0c7724bmr2992186a12.35.1721641517633;
        Mon, 22 Jul 2024 02:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOk64YKtWCkM8QEGq4WcHsKRMDn6VSoZiA+aL7t5qc1F8mE1boIG/ZtCGQem09DjoaTJSLag==
X-Received: by 2002:a50:8749:0:b0:5a1:c40a:3a81 with SMTP id 4fb4d7f45d1cf-5a4f0c7724bmr2992169a12.35.1721641517186;
        Mon, 22 Jul 2024 02:45:17 -0700 (PDT)
Received: from [192.168.2.168] (business-90-187-152-45.pool2.vodafone-ip.de. [90.187.152.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a525712d71sm3074144a12.82.2024.07.22.02.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 02:45:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------bTR4MO0xEOT56MRCvIbHI5Fz"
Message-ID: <7b7b4d84-c4b0-4a37-ab1d-4b1266851b32@redhat.com>
Date: Mon, 22 Jul 2024 11:45:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: intel-vbtn: Support for tablet mode on Dell
 Venue 11 Pro 7140
To: En-Wei Wu <en-wei.wu@canonical.com>, acelan.kao@canonical.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kostadin Stoilov <kmstoilov@gmail.com>
References: <20240722083658.54518-1-en-wei.wu@canonical.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240722083658.54518-1-en-wei.wu@canonical.com>

This is a multi-part message in MIME format.
--------------bTR4MO0xEOT56MRCvIbHI5Fz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi En-Wei,

On 7/22/24 10:36 AM, En-Wei Wu wrote:
> On a Dell Venue 7140 tablet with the keyboard/touchpad/battery dock, when
> disconnecting the dock there is a kernel bug:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000018
> 
> And this causes the following things not to work:
> 1. Suspend to idle - the system simply hangs
> 2. Poweroff normally (the only way is forcing it via long press the power button)
> 3. USB ports: both the USB port on the tablet and also plugging in the keyboard again
> 
> The error message above (plus some crash dump) isn't so useful for debugging, but we
> have noticed that there is a debug message shown before the crash dump:
> 
> intel-vbtn INT33D6:00: Registering Intel Virtual Switches input-dev after receiving
> a switch event
> 
> The messages above is shown right after the dock is disconnected, and the message implies:
> 
> We failed to set the priv->has_switches to true in the probe function since the
> Dell Venue 11 Pro 7140 is not shown in the dmi_switches_allow_list, and this causes a problem
> that no input_register_device() on the switch device is called. Afterward, When a user
> disconnects the dock, intel-vbtn receives the ACPI event and finally find that there is a
> switch out there. So intel-vbtn starts to register the switch device, which may be a dangerous
> behavior since there might be some device-related objects/structs that has been freed (due to
> the disconnection of the dock).
> 
> To solve this problem from the root cause, simply add the Dell Venue 11 pro 7140 to the
> dmi_switches_allow_list.
> (The Dell Venue 11 Pro 7140 is a 2-in-1 model that has chassis-type "Portable".)
> 
> BugLink: https://bugs.launchpad.net/bugs/2073001
> 
> Fixes: 8169bd3e6e19 ("platform/x86: intel-vbtn: Switch to an allow-list
> for SW_TABLET_MODE reporting")
> Reported-by: Kostadin Stoilov <kmstoilov@gmail.com>
> Tested-by: Kostadin Stoilov <kmstoilov@gmail.com>
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>

Thank you for your patch. Looking at the logs from the launchpad bug I noticed that

intel-vbtn INT33D6:00: Registering Intel Virtual Switches input-dev after receiving a switch event

is reported in the logs twice. Which strongly suggests that the intel-vbtn notify_handler()
function is racing with itself.

In the past ACPI notify handlers could never run more then once (at the same time)
but since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on
all CPUs") ACPI notify handlers like the intel-vbtn notify_handler() may
run on multiple CPU cores racing with themselves.

I believe that this is the real problem here. I have attached a patch which should
fix this. Can you build a test-kernel with this patch instead of your patch and
ask the reported of: https://bugs.launchpad.net/bugs/2073001

To test a kernel with the attached patch (and without your patch) to confirm
that this fixes it in a more generic manner ?

Regards,

Hans





> ---
>  drivers/platform/x86/intel/vbtn.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
> index 9b7ce03ba085..46d07d3cd34b 100644
> --- a/drivers/platform/x86/intel/vbtn.c
> +++ b/drivers/platform/x86/intel/vbtn.c
> @@ -235,6 +235,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7140"),
> +		},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
--------------bTR4MO0xEOT56MRCvIbHI5Fz
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-platform-x86-intel-vbtn-Protect-ACPI-notify-handler-.patch"
Content-Disposition: attachment;
 filename*0="0001-platform-x86-intel-vbtn-Protect-ACPI-notify-handler-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyOWFmMzViZmJmNmNhYTBkMjc1MzAxNTBkZDBhZGJmODhlM2M2ZWFiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBNb24sIDIyIEp1bCAyMDI0IDExOjA2OjM2ICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gcGxhdGZvcm0veDg2OiBpbnRlbC12YnRuOiBQcm90ZWN0IEFDUEkgbm90aWZ5IGhh
bmRsZXIgYWdhaW5zdAogcmVjdXJzaW9uCgpTaW5jZSBjb21taXQgZTJmZmNkYTE2MjkwICgi
QUNQSTogT1NMOiBBbGxvdyBOb3RpZnkgKCkgaGFuZGxlcnMgdG8gcnVuIG9uCmFsbCBDUFVz
IikgQUNQSSBub3RpZnkgaGFuZGxlcnMgbGlrZSB0aGUgaW50ZWwtdmJ0biBub3RpZnlfaGFu
ZGxlcigpIG1heQpydW4gb24gbXVsdGlwbGUgQ1BVIGNvcmVzIHJhY2luZyB3aXRoIHRoZW1z
ZWx2ZXMuCgpUaGlzIHJhY2UgZ2V0cyBoaXQgb24gRGVsbCBWZW51ZSA3MTQwIHRhYmxldHMg
d2hlbiB1bmRvY2tpbmcgZnJvbQp0aGUga2V5Ym9hcmQsIGNhdXNpbmcgdGhlIGhhbmRsZXIg
dG8gdHJ5IGFuZCByZWdpc3RlciBwcml2LT5zd2l0Y2hlc19kZXYKdHdpY2UsIGFzIGNhbiBi
ZSBzZWVuIGZyb20gdGhlIGRldl9pbmZvKCkgbWVzc2FnZSBnZXR0aW5nIGxvZ2dlZCB0d2lj
ZToKClsgODMuODYxODAwXSBpbnRlbC12YnRuIElOVDMzRDY6MDA6IFJlZ2lzdGVyaW5nIElu
dGVsIFZpcnR1YWwgU3dpdGNoZXMgaW5wdXQtZGV2IGFmdGVyIHJlY2VpdmluZyBhIHN3aXRj
aCBldmVudApbIDgzLjg2MTg1OF0gaW5wdXQ6IEludGVsIFZpcnR1YWwgU3dpdGNoZXMgYXMg
L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFmLjAvUE5QMEMwOTowMC9JTlQzM0Q2OjAw
L2lucHV0L2lucHV0MTcKWyA4My44NjE4NjVdIGludGVsLXZidG4gSU5UMzNENjowMDogUmVn
aXN0ZXJpbmcgSW50ZWwgVmlydHVhbCBTd2l0Y2hlcyBpbnB1dC1kZXYgYWZ0ZXIgcmVjZWl2
aW5nIGEgc3dpdGNoIGV2ZW50CgpBZnRlciB3aGljaCB0aGluZ3MgZ28gc2VyaW91c2x5IHdy
b25nOgpbIDgzLjg2MTg3Ml0gc3lzZnM6IGNhbm5vdCBjcmVhdGUgZHVwbGljYXRlIGZpbGVu
YW1lICcvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMC9QTlAwQzA5OjAwL0lOVDMz
RDY6MDAvaW5wdXQvaW5wdXQxNycKLi4uClsgODMuODYxOTY3XSBrb2JqZWN0OiBrb2JqZWN0
X2FkZF9pbnRlcm5hbCBmYWlsZWQgZm9yIGlucHV0MTcgd2l0aCAtRUVYSVNULCBkb24ndCB0
cnkgdG8gcmVnaXN0ZXIgdGhpbmdzIHdpdGggdGhlIHNhbWUgbmFtZSBpbiB0aGUgc2FtZSBk
aXJlY3RvcnkuClsgODMuODc3MzM4XSBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMTgKLi4uCgpQcm90ZWN0IGludGVsLXZi
dG4gbm90aWZ5X2hhbmRsZXIoKSBmcm9tIHJhY2luZyB3aXRoIGl0c2VsZiB3aXRoIGEgbXV0
ZXgKdG8gZml4IHRoaXMuCgpGaXhlczogZTJmZmNkYTE2MjkwICgiQUNQSTogT1NMOiBBbGxv
dyBOb3RpZnkgKCkgaGFuZGxlcnMgdG8gcnVuIG9uIGFsbCBDUFVzIikKUmVwb3J0ZWQtYnk6
IEVuLVdlaSBXdSA8ZW4td2VpLnd1QGNhbm9uaWNhbC5jb20+CkNsb3NlczogaHR0cHM6Ly9i
dWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbGludXgvK2J1Zy8yMDczMDAxClNp
Z25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQog
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvdmJ0bi5jIHwgMjEgKysrKysrKysrKysrKysr
Ky0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC92YnRuLmMgYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC92YnRuLmMKaW5kZXggOWI3Y2UwM2JhMDg1Li45
M2RlZGE3ZGFhYzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3Zi
dG4uYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC92YnRuLmMKQEAgLTEyLDYg
KzEyLDcgQEAKICNpbmNsdWRlIDxsaW51eC9pbnB1dC9zcGFyc2Uta2V5bWFwLmg+CiAjaW5j
bHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5j
bHVkZSA8bGludXgvbXV0ZXguaD4KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4KICNpbmNsdWRlIDxsaW51eC9zdXNwZW5kLmg+CiAjaW5jbHVkZSAiLi4vZHVhbF9hY2Nl
bF9kZXRlY3QuaCIKQEAgLTY2LDYgKzY3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZXlf
ZW50cnkgaW50ZWxfdmJ0bl9zd2l0Y2htYXBbXSA9IHsKIH07CiAKIHN0cnVjdCBpbnRlbF92
YnRuX3ByaXYgeworCXN0cnVjdCBtdXRleCBtdXRleDsgLyogQXZvaWQgbm90aWZ5X2hhbmRs
ZXIoKSByYWNpbmcgd2l0aCBpdHNlbGYgKi8KIAlzdHJ1Y3QgaW5wdXRfZGV2ICpidXR0b25z
X2RldjsKIAlzdHJ1Y3QgaW5wdXRfZGV2ICpzd2l0Y2hlc19kZXY7CiAJYm9vbCBkdWFsX2Fj
Y2VsOwpAQCAtMTU1LDMwICsxNTcsMzIgQEAgc3RhdGljIHZvaWQgbm90aWZ5X2hhbmRsZXIo
YWNwaV9oYW5kbGUgaGFuZGxlLCB1MzIgZXZlbnQsIHZvaWQgKmNvbnRleHQpCiAJYm9vbCBh
dXRvcmVsZWFzZTsKIAlpbnQgcmV0OwogCisJbXV0ZXhfbG9jaygmcHJpdi0+bXV0ZXgpOwor
CiAJaWYgKChrZSA9IHNwYXJzZV9rZXltYXBfZW50cnlfZnJvbV9zY2FuY29kZShwcml2LT5i
dXR0b25zX2RldiwgZXZlbnQpKSkgewogCQlpZiAoIXByaXYtPmhhc19idXR0b25zKSB7CiAJ
CQlkZXZfd2FybigmZGV2aWNlLT5kZXYsICJXYXJuaW5nOiByZWNlaXZlZCAweCUwMnggYnV0
dG9uIGV2ZW50IG9uIGEgZGV2aWNlIHdpdGhvdXQgYnV0dG9ucywgcGxlYXNlIHJlcG9ydCB0
aGlzLlxuIiwKIAkJCQkgZXZlbnQpOwotCQkJcmV0dXJuOworCQkJZ290byBvdXRfdW5sb2Nr
OwogCQl9CiAJCWlucHV0X2RldiA9IHByaXYtPmJ1dHRvbnNfZGV2OwogCX0gZWxzZSBpZiAo
KGtlID0gc3BhcnNlX2tleW1hcF9lbnRyeV9mcm9tX3NjYW5jb2RlKHByaXYtPnN3aXRjaGVz
X2RldiwgZXZlbnQpKSkgewogCQlpZiAoIXByaXYtPmhhc19zd2l0Y2hlcykgewogCQkJLyog
U2VlIGR1YWxfYWNjZWxfZGV0ZWN0LmggZm9yIG1vcmUgaW5mbyAqLwogCQkJaWYgKHByaXYt
PmR1YWxfYWNjZWwpCi0JCQkJcmV0dXJuOworCQkJCWdvdG8gb3V0X3VubG9jazsKIAogCQkJ
ZGV2X2luZm8oJmRldmljZS0+ZGV2LCAiUmVnaXN0ZXJpbmcgSW50ZWwgVmlydHVhbCBTd2l0
Y2hlcyBpbnB1dC1kZXYgYWZ0ZXIgcmVjZWl2aW5nIGEgc3dpdGNoIGV2ZW50XG4iKTsKIAkJ
CXJldCA9IGlucHV0X3JlZ2lzdGVyX2RldmljZShwcml2LT5zd2l0Y2hlc19kZXYpOwogCQkJ
aWYgKHJldCkKLQkJCQlyZXR1cm47CisJCQkJZ290byBvdXRfdW5sb2NrOwogCiAJCQlwcml2
LT5oYXNfc3dpdGNoZXMgPSB0cnVlOwogCQl9CiAJCWlucHV0X2RldiA9IHByaXYtPnN3aXRj
aGVzX2RldjsKIAl9IGVsc2UgewogCQlkZXZfZGJnKCZkZXZpY2UtPmRldiwgInVua25vd24g
ZXZlbnQgaW5kZXggMHgleFxuIiwgZXZlbnQpOwotCQlyZXR1cm47CisJCWdvdG8gb3V0X3Vu
bG9jazsKIAl9CiAKIAlpZiAocHJpdi0+d2FrZXVwX21vZGUpIHsKQEAgLTE4OSw3ICsxOTMs
NyBAQCBzdGF0aWMgdm9pZCBub3RpZnlfaGFuZGxlcihhY3BpX2hhbmRsZSBoYW5kbGUsIHUz
MiBldmVudCwgdm9pZCAqY29udGV4dCkKIAkJICogbWlycm9yaW5nIGhvdyB0aGUgZHJpdmVy
cy9hY3BpL2J1dHRvbi5jIGNvZGUgc2tpcHMgdGhpcyB0b28uCiAJCSAqLwogCQlpZiAoa2Ut
PnR5cGUgPT0gS0VfS0VZKQotCQkJcmV0dXJuOworCQkJZ290byBvdXRfdW5sb2NrOwogCX0K
IAogCS8qCkBAIC0yMDAsNiArMjA0LDkgQEAgc3RhdGljIHZvaWQgbm90aWZ5X2hhbmRsZXIo
YWNwaV9oYW5kbGUgaGFuZGxlLCB1MzIgZXZlbnQsIHZvaWQgKmNvbnRleHQpCiAJYXV0b3Jl
bGVhc2UgPSB2YWwgJiYgKCFrZV9yZWwgfHwga2VfcmVsLT50eXBlID09IEtFX0lHTk9SRSk7
CiAKIAlzcGFyc2Vfa2V5bWFwX3JlcG9ydF9ldmVudChpbnB1dF9kZXYsIGV2ZW50LCB2YWws
IGF1dG9yZWxlYXNlKTsKKworb3V0X3VubG9jazoKKwltdXRleF91bmxvY2soJnByaXYtPm11
dGV4KTsKIH0KIAogLyoKQEAgLTI5MCw2ICsyOTcsMTAgQEAgc3RhdGljIGludCBpbnRlbF92
YnRuX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldmljZSkKIAkJcmV0dXJuIC1F
Tk9NRU07CiAJZGV2X3NldF9kcnZkYXRhKCZkZXZpY2UtPmRldiwgcHJpdik7CiAKKwllcnIg
PSBkZXZtX211dGV4X2luaXQoJmRldmljZS0+ZGV2LCAmcHJpdi0+bXV0ZXgpOworCWlmIChl
cnIpCisJCXJldHVybiBlcnI7CisKIAlwcml2LT5kdWFsX2FjY2VsID0gZHVhbF9hY2NlbDsK
IAlwcml2LT5oYXNfYnV0dG9ucyA9IGhhc19idXR0b25zOwogCXByaXYtPmhhc19zd2l0Y2hl
cyA9IGhhc19zd2l0Y2hlczsKLS0gCjIuNDUuMgoK

--------------bTR4MO0xEOT56MRCvIbHI5Fz--



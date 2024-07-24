Return-Path: <linux-kernel+bounces-261373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F128C93B67C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0821C216C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57116A943;
	Wed, 24 Jul 2024 18:15:24 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344FE26AF5;
	Wed, 24 Jul 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844923; cv=none; b=VXTTHwqJbNldEZWI45TzvcHqtu407kOydg1S165/Z9mTPrU8aW7WDSdp1UScE7gVnW+6QpnAeMCGzGJ5potADWszZ5XZLZcOttsXeaxeQiAQEqtIsjGgPacrTnAoZev0X9l4B/1FQWixhCBVvCdOafbrM+Qcqi2oGpga8bAurNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844923; c=relaxed/simple;
	bh=eXWx3znrPWFKC09CmXr58rKaQoRyrTploBmkc170hqs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=kqWBmMxi4iv/8O3gpJ44YvhmOgYbzcQDXCU6lNP/rQwdew/txXNY8VNN1z9lKtR28sXhmg1IHlolsBBImPqUxT7JEPmUnj+sIosLIjQXzX2AKLBlEtw+9crPpJjE3aoy8AvRdgVGbbDNbkQFaC4a11goMHy9dQvN1BBB1VMlwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af27a.dynamic.kabel-deutschland.de [95.90.242.122])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 22B9A61E5FE05;
	Wed, 24 Jul 2024 20:14:35 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------MSPmj3OIxnA5qEH4WLS7VgxJ"
Message-ID: <f1e2e2b1-b83c-4105-b62c-a053d18c2985@molgen.mpg.de>
Date: Wed, 24 Jul 2024 20:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: hub_port_reset: Remove extra 40 ms reset
 recovery time
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Brownell <david-b@pacbell.net>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
 <c7c299e7-605c-4bd6-afad-dfbfe266aa7e@rowland.harvard.edu>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <c7c299e7-605c-4bd6-afad-dfbfe266aa7e@rowland.harvard.edu>

This is a multi-part message in MIME format.
--------------MSPmj3OIxnA5qEH4WLS7VgxJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: -gregkh@suse.de]

Dear Alan,


Thank you for your reply.

Am 24.07.24 um 16:10 schrieb Alan Stern:
> On Wed, Jul 24, 2024 at 01:15:23PM +0200, Paul Menzel wrote:
>> This basically reverts commit b789696af8b4102b7cc26dec30c2c51ce51ee18b
>> ("[PATCH] USB: relax usbcore reset timings") from 2005.
>>
>> This adds unneeded 40 ms during resume from suspend on a majority of
> 
> Wrong.  It adds 40 ms to the recovery time from a port reset -- see the
> commit's title.  Suspend and resume do not in general involve port
> resets (although sometimes they do).

It looks like on my system the ports are reset:

```
$ grep suspend-240501-063619/hub_port_reset abreu_mem_ftrace.txt
  6416.257589 |   3)  kworker-9023  |               | 
hub_port_reset [usbcore]() {
  6416.387182 |   2)  kworker-9023  |   129593.0 us |                  } 
/* hub_port_reset [usbcore] */
  6416.387380 |   2)  kworker-9023  |               | 
hub_port_reset [usbcore]() {
  6416.513458 |   3)  kworker-9023  |   126078.4 us |                  } 
/* hub_port_reset [usbcore] */
  6416.537813 |   2)  kworker-9844  |               | 
hub_port_reset [usbcore]() {
  6416.666142 |   3)  kworker-9844  |   128328.5 us |                  } 
/* hub_port_reset [usbcore] */
  6416.666429 |   3)  kworker-9844  |               | 
hub_port_reset [usbcore]() {
  6416.793315 |   1)  kworker-9844  |   126885.9 us |                  } 
/* hub_port_reset [usbcore] */
  6416.813559 |   1)  kworker-9849  |               | 
hub_port_reset [usbcore]() {
  6416.941882 |   2)  kworker-9849  |   128322.4 us |                  } 
/* hub_port_reset [usbcore] */
  6416.942633 |   2)  kworker-9849  |               | 
hub_port_reset [usbcore]() {
  6417.069205 |   3)  kworker-9849  |   126572.4 us |                  } 
/* hub_port_reset [usbcore] */
```

>> devices, where it’s not needed, like the Dell XPS 13 9360/0596KF, BIOS
>> 2.21.0 06/02/2022 with
> 
>> The commit messages unfortunately does not list the devices needing this.
>> Should they surface again, these should be added to the quirk list for
>> USB_QUIRK_HUB_SLOW_RESET.
> 
> This quirk applies to hubs that need extra time when one of their ports
> gets reset.  However, it seems likely that the patch you are reverting
> was meant to help the device attached to the port, not the hub itself.
> Which would mean that the adding hubs to the quirk list won't help
> unless every hub is added -- in which case there's no point reverting
> the patch.
> 
> Furthermore, should any of these bad hubs or devices still be in use,
> your change would cause them to stop working reliably.  It would be a
> regression.
> 
> A better approach would be to add a sysfs boolean attribute to the hub
> driver to enable the 40-ms reset-recovery delay, and make it default to
> True.  Then people who don't need the delay could disable it from
> userspace, say by a udev rule.

How would you name it?


Kind regards,

Paul


>> Fixes: b789696af8b4 ("[PATCH] USB: relax usbcore reset timings")
>> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: David Brownell <david-b@pacbell.net>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   drivers/usb/core/hub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 4b93c0bd1d4b..487d5fe60f0c 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -3110,7 +3110,7 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>>   			usleep_range(10000, 12000);
>>   		else {
>>   			/* TRSTRCY = 10 ms; plus some extra */
>> -			reset_recovery_time = 10 + 40;
>> +			reset_recovery_time = 10;
>>   
>>   			/* Hub needs extra delay after resetting its port. */
>>   			if (hub->hdev->quirks & USB_QUIRK_HUB_SLOW_RESET)
--------------MSPmj3OIxnA5qEH4WLS7VgxJ
Content-Type: text/plain; charset=UTF-8; name="abreu_mem_dmesg.txt"
Content-Disposition: attachment; filename="abreu_mem_dmesg.txt"
Content-Transfer-Encoding: base64

IyBzdXNwZW5kLTA1MDEyNC0wNjM2MTkgYWJyZXUgbWVtIDYuOS4wLXJjNi0wMDA0Ni1nMThk
YWVhNzdjY2E2CiMgc3lzaW5mbyB8IG1hbjpEZWxsIEluYy4gfCBwbGF0OlhQUyAxMyA5MzYw
IHwgY3B1OkludGVsKFIpIENvcmUoVE0pIGk3LTc1MDBVIENQVSBAIDIuNzBHSHogfCBiaW9z
OjIuMjEuMCB8IGJpb3NkYXRlOjA2LzAyLzIwMjIgfCBudW1jcHU6NCB8IG1lbXN6OjE1OTM0
NzI0IHwgbWVtZnI6NjE3OTQyNCB8IG9zOkRlYmlhbiBHTlUvTGludXggdHJpeGllL3NpZAoj
IGNvbW1hbmQgfCBhbmFseXplX3N1c3BlbmQucHkgLWYKIyBmd3N1c3BlbmQgMCBmd3Jlc3Vt
ZSAxMDc4MDcyClsgNjQxMy45MzEwNjBdIFBNOiBzdXNwZW5kIGVudHJ5IChkZWVwKQpbIDY0
MTMuOTQwMjg2XSBGaWxlc3lzdGVtcyBzeW5jOiAwLjAwOSBzZWNvbmRzClsgNjQxMy45NDQ4
ODZdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzClsgNjQxMy45NjI4MjJdIEZyZWV6
aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAxNyBzZWNv
bmRzKQpbIDY0MTMuOTYyODYwXSBPT00ga2lsbGVyIGRpc2FibGVkLgpbIDY0MTMuOTYyODg4
XSBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzClsgNjQxMy45Njg2NzhdIEZy
ZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgY29tcGxldGVkIChlbGFwc2VkIDAu
MDA1IHNlY29uZHMpClsgNjQxMy45Njg4MTRdIHByaW50azogU3VzcGVuZGluZyBjb25zb2xl
KHMpICh1c2Ugbm9fY29uc29sZV9zdXNwZW5kIHRvIGRlYnVnKQpbIDY0MTMuOTg4NzA2XSB3
bHA1OHMwOiBkZWF1dGhlbnRpY2F0aW5nIGZyb20gODg6NzE6YjE6ODE6OTM6MWIgYnkgbG9j
YWwgY2hvaWNlIChSZWFzb246IDM9REVBVVRIX0xFQVZJTkcpClsgNjQxNC42NjA2MDVdIFBN
OiBzdXNwZW5kIG9mIGRldmljZXMgY29tcGxldGUgYWZ0ZXIgNjcyLjcyOCBtc2VjcwpbIDY0
MTQuNjYwNjM1XSBQTTogc3RhcnQgc3VzcGVuZCBvZiBkZXZpY2VzIGNvbXBsZXRlIGFmdGVy
IDY5MS45MzIgbXNlY3MKWyA2NDE0LjY5NjA1Nl0gUE06IGxhdGUgc3VzcGVuZCBvZiBkZXZp
Y2VzIGNvbXBsZXRlIGFmdGVyIDM1LjQxNiBtc2VjcwpbIDY0MTQuNzA3OTYzXSBBQ1BJOiBF
QzogaW50ZXJydXB0IGJsb2NrZWQKWyA2NDE0Ljc4NDEzM10gUE06IG5vaXJxIHN1c3BlbmQg
b2YgZGV2aWNlcyBjb21wbGV0ZSBhZnRlciA4Ni45MjMgbXNlY3MKWyA2NDE0Ljc4NDE3NV0g
QUNQSTogUE06IFByZXBhcmluZyB0byBlbnRlciBzeXN0ZW0gc2xlZXAgc3RhdGUgUzMKWyA2
NDE0Ljk4MjQxNF0gQUNQSTogRUM6IGV2ZW50IGJsb2NrZWQKWyA2NDE0Ljk4MjQzMl0gQUNQ
STogRUM6IEVDIHN0b3BwZWQKWyA2NDE0Ljk4MjQ0OV0gQUNQSTogUE06IFNhdmluZyBwbGF0
Zm9ybSBOVlMgbWVtb3J5ClsgNjQxNC45ODQwNjldIERpc2FibGluZyBub24tYm9vdCBDUFVz
IC4uLgpbIDY0MTQuOTg2OTk1XSBzbXBib290OiBDUFUgMSBpcyBub3cgb2ZmbGluZQpbIDY0
MTQuOTkyMzIzXSBzbXBib290OiBDUFUgMiBpcyBub3cgb2ZmbGluZQpbIDY0MTQuOTk3MzMz
XSBzbXBib290OiBDUFUgMyBpcyBub3cgb2ZmbGluZQpbIDY0MTUuMDAwMzY1XSBDaGVja2lu
ZyB3YWtldXAgaW50ZXJydXB0cwpbIDY0MTUuMDAwMzg5XSBDYWxsaW5nIGt2bV9zdXNwZW5k
KzB4MC8weDQwIFtrdm1dClsgNjQxNS4wMDA0OTJdIENhbGxpbmcgaW50ZWxfZXBiX3NhdmUr
MHgwLzB4MzAKWyA2NDE1LjAwMDUyMF0gQ2FsbGluZyBtY2Vfc3lzY29yZV9zdXNwZW5kKzB4
MC8weDIwClsgNjQxNS4wMDA1NDVdIENhbGxpbmcgbGVkdHJpZ19jcHVfc3lzY29yZV9zdXNw
ZW5kKzB4MC8weDIwClsgNjQxNS4wMDA1NzRdIENhbGxpbmcgdGltZWtlZXBpbmdfc3VzcGVu
ZCsweDAvMHgyZjAKWyA2NDE1LjAwMDc0MF0gQ2FsbGluZyBzYXZlX2lvYXBpY19lbnRyaWVz
KzB4MC8weGQwClsgNjQxNS4wMDIwMTNdIENhbGxpbmcgaTgyNTlBX3N1c3BlbmQrMHgwLzB4
MzAKWyA2NDE1LjAwMjA0Nl0gQ2FsbGluZyBmd19zdXNwZW5kKzB4MC8weDIwClsgNjQxNS4w
MDIwNzJdIENhbGxpbmcgYWNwaV9zYXZlX2JtX3JsZCsweDAvMHgzMApbIDY0MTUuMDAyMTA2
XSBDYWxsaW5nIGxhcGljX3N1c3BlbmQrMHgwLzB4MTYwClsgNjQxNS4wMDU2MjddIEFDUEk6
IFBNOiBMb3ctbGV2ZWwgcmVzdW1lIGNvbXBsZXRlClsgNjQxNS4wMDU2OTJdIEFDUEk6IEVD
OiBFQyBzdGFydGVkClsgNjQxNS4wMDU2OTZdIEFDUEk6IFBNOiBSZXN0b3JpbmcgcGxhdGZv
cm0gTlZTIG1lbW9yeQpbIDY0MTUuMDA2OTA1XSBDYWxsaW5nIGluaXRfY291bnRlcl9yZWZz
KzB4MC8weDQwClsgNjQxNS4wMDY5MzFdIENhbGxpbmcgbGFwaWNfcmVzdW1lKzB4MC8weDIy
MApbIDY0MTUuMDA3MDAzXSBDYWxsaW5nIGFjcGlfcmVzdG9yZV9ibV9ybGQrMHgwLzB4NzAK
WyA2NDE1LjAwNzAzM10gQ2FsbGluZyBpcnFyb3V0ZXJfcmVzdW1lKzB4MC8weDUwClsgNjQx
NS4wMDcwNTZdIENhbGxpbmcgaTgyNTlBX3Jlc3VtZSsweDAvMHg0MApbIDY0MTUuMDA3MjUw
XSBDYWxsaW5nIGlvYXBpY19yZXN1bWUrMHgwLzB4YzAKWyA2NDE1LjAwNzUxNl0gQ2FsbGlu
ZyBpcnFfcG1fc3lzY29yZV9yZXN1bWUrMHgwLzB4MjAKWyA2NDE1LjAwODU2MF0gQ2FsbGlu
ZyB0aW1la2VlcGluZ19yZXN1bWUrMHgwLzB4MWUwClsgNjQxNS4wMDg3MTNdIFRpbWVrZWVw
aW5nIHN1c3BlbmRlZCBmb3IgMTQuMTQxIHNlY29uZHMKWyA2NDE1LjAwODc2M10gQ2FsbGlu
ZyBsZWR0cmlnX2NwdV9zeXNjb3JlX3Jlc3VtZSsweDAvMHgyMApbIDY0MTUuMDA4Nzg3XSBD
YWxsaW5nIG1jZV9zeXNjb3JlX3Jlc3VtZSsweDAvMHgzMApbIDY0MTUuMDA4ODMwXSBDYWxs
aW5nIGludGVsX2VwYl9yZXN0b3JlKzB4MC8weDkwClsgNjQxNS4wMDg4NTJdIENhbGxpbmcg
bWljcm9jb2RlX2JzcF9yZXN1bWUrMHgwLzB4ZDAKWyA2NDE1LjAwODg3M10gQ2FsbGluZyBr
dm1fcmVzdW1lKzB4MC8weDYwIFtrdm1dClsgNjQxNS4wMDg5NjhdIFBNOiBUcmlnZ2VyaW5n
IHdha2V1cCBmcm9tIElSUSA1MQpbIDY0MTUuMDA5MDEyXSBFbmFibGluZyBub24tYm9vdCBD
UFVzIC4uLgpbIDY0MTUuMDA5MjY5XSBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNz
b3IgMSBBUElDIDB4MgpbIDY0MTUuMDEwNzYzXSBDUFUxIGlzIHVwClsgNjQxNS4wMTEwMTFd
IHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAyIEFQSUMgMHgxClsgNjQxNS4w
MTI4MTFdIENQVTIgaXMgdXAKWyA2NDE1LjAxMzA1OF0gc21wYm9vdDogQm9vdGluZyBOb2Rl
IDAgUHJvY2Vzc29yIDMgQVBJQyAweDMKWyA2NDE1LjAxNDY4N10gQ1BVMyBpcyB1cApbIDY0
MTUuMDIwNjg4XSBBQ1BJOiBQTTogV2FraW5nIHVwIGZyb20gc3lzdGVtIHNsZWVwIHN0YXRl
IFMzClsgNjQxNi4wNzY5MTBdIEFDUEk6IEVDOiBpbnRlcnJ1cHQgdW5ibG9ja2VkClsgNjQx
Ni4xMDY3MThdIFBNOiBub2lycSByZXN1bWUgb2YgZGV2aWNlcyBjb21wbGV0ZSBhZnRlciAz
MC40NTEgbXNlY3MKWyA2NDE2LjEwODUzOV0gUE06IGVhcmx5IHJlc3VtZSBvZiBkZXZpY2Vz
IGNvbXBsZXRlIGFmdGVyIDEuNTY2IG1zZWNzClsgNjQxNi4xMDg5ODhdIEFDUEk6IEVDOiBl
dmVudCB1bmJsb2NrZWQKWyA2NDE2LjEyNDcwN10gbnZtZSBudm1lMDogNC8wLzAgZGVmYXVs
dC9yZWFkL3BvbGwgcXVldWVzClsgNjQxNi4xNDIxMzRdIGk5MTUgMDAwMDowMDowMi4wOiBb
ZHJtXSBbRU5DT0RFUjo5NDpEREkgQS9QSFkgQV0gaXMgZGlzYWJsZWQvaW4gRFNJIG1vZGUg
d2l0aCBhbiB1bmdhdGVkIERESSBjbG9jaywgZ2F0ZSBpdApbIDY0MTYuMTcyMTI2XSBpOTE1
IDAwMDA6MDA6MDIuMDogW2RybV0gW0VOQ09ERVI6MTAyOkRESSBCL1BIWSBCXSBpcyBkaXNh
YmxlZC9pbiBEU0kgbW9kZSB3aXRoIGFuIHVuZ2F0ZWQgRERJIGNsb2NrLCBnYXRlIGl0Clsg
NjQxNi4yNDgxMDNdIGk5MTUgMDAwMDowMDowMi4wOiBbZHJtXSBbRU5DT0RFUjoxMTM6RERJ
IEMvUEhZIENdIGlzIGRpc2FibGVkL2luIERTSSBtb2RlIHdpdGggYW4gdW5nYXRlZCBEREkg
Y2xvY2ssIGdhdGUgaXQKWyA2NDE2LjM4NzE4N10gdXNiIDEtMzogcmVzZXQgZnVsbC1zcGVl
ZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2lfaGNkClsgNjQxNi41MTUyNDFdIEFD
UEkgRGVidWc6ICAiaUdmeCBTdXBwb3J0ZWQgRnVuY3Rpb25zIEJpdG1hcCAiClsgNjQxNi42
NjYxNDVdIHVzYiAxLTQ6IHJlc2V0IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMyB1
c2luZyB4aGNpX2hjZApbIDY0MTYuOTQxODg1XSB1c2IgMS01OiByZXNldCBoaWdoLXNwZWVk
IFVTQiBkZXZpY2UgbnVtYmVyIDQgdXNpbmcgeGhjaV9oY2QKWyA2NDE3LjE0MzIwNV0gUE06
IHJlc3VtZSBvZiBkZXZpY2VzIGNvbXBsZXRlIGFmdGVyIDEwMzUuMTQ5IG1zZWNzClsgNjQx
Ny4xNTUzODldIG1laV9oZGNwIDAwMDA6MDA6MTYuMC1iNjM4YWI3ZS05NGUyLTRlYTItYTU1
Mi1kMWM1NGI2MjdmMDQ6IGJvdW5kIDAwMDA6MDA6MDIuMCAob3BzIGk5MTVfaGRjcF9vcHMg
W2k5MTVdKQpbIDY0MTcuMTY5NDY4XSBPT00ga2lsbGVyIGVuYWJsZWQuClsgNjQxNy4xNjk1
MDBdIFJlc3RhcnRpbmcgdGFza3MgLi4uIGRvbmUuClsgNjQxNy4yMTc0MzBdIHJhbmRvbTog
Y3JuZyByZXNlZWRlZCBvbiBzeXN0ZW0gcmVzdW1wdGlvbgpbIDY0MTcuNDIzOTc2XSB3bHA1
OHMwOiBhdXRoZW50aWNhdGUgd2l0aCA4ODo3MTpiMTo4MTo5MzoxYSAobG9jYWwgYWRkcmVz
cz05YzpiNjpkMDpkMTo2YTpiMSkKWyA2NDE3LjQyNDIwNF0gd2xwNThzMDogc2VuZCBhdXRo
IHRvIDg4OjcxOmIxOjgxOjkzOjFhICh0cnkgMS8zKQpbIDY0MTcuNDI5OTAxXSB3bHA1OHMw
OiBhdXRoZW50aWNhdGVkClsgNjQxNy40MzI5NzVdIHdscDU4czA6IGFzc29jaWF0ZSB3aXRo
IDg4OjcxOmIxOjgxOjkzOjFhICh0cnkgMS8zKQpbIDY0MTcuNDc1MzA2XSB3bHA1OHMwOiBS
WCBBc3NvY1Jlc3AgZnJvbSA4ODo3MTpiMTo4MTo5MzoxYSAoY2FwYWI9MHgxNDMxIHN0YXR1
cz0wIGFpZD0xKQpbIDY0MTcuNDgwMTU0XSB3bHA1OHMwOiBhc3NvY2lhdGVkClsgNjQxNy41
NTY0MTZdIHdscDU4czA6IExpbWl0aW5nIFRYIHBvd2VyIHRvIDIwICgyMCAtIDApIGRCbSBh
cyBhZHZlcnRpc2VkIGJ5IDg4OjcxOmIxOjgxOjkzOjFhClsgNjQxOC42NDk2OTVdIFBNOiBz
dXNwZW5kIGV4aXQK

--------------MSPmj3OIxnA5qEH4WLS7VgxJ--


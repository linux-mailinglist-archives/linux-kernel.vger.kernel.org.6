Return-Path: <linux-kernel+bounces-264535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50A93E49D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2021C20D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EF739FCE;
	Sun, 28 Jul 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMdG5T6p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF082BB04
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722163038; cv=none; b=XNA2ueL8LAEHxzg4p+6UKkFP7aGRxX4vDNQY7XfmrMdHTQ+jasFA6+zSdduydrNehUaN/FNGPLlZWqgoSuYfnF4e+Yix/fVM8Ycy4IWcZoQlBKaGFR9v5a3nckUwiK+pq8GdKw1O7VnCVi/ScmI7kQGOXZzgAyzBy9UtIT4v3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722163038; c=relaxed/simple;
	bh=ciq+uo4y/Z/xqO8gI+9U0ZJ9jqpLWzBADZxUrIQPZdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT+Uno7BU+0ty30QsyZ9tUfjmGbGGi5YlOTCQRDpGu7hJLL55O85G000c6XP7YU/GUEUjEkJt5/ec+1Us8WyipuLhD3YeRKGkSLAmb9U48UpDuEPpovRybvihkShaguQPDGyMoUaQVn2gEb0Mc+7duFuPcaLYNC+vVIpNPv7gXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMdG5T6p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722163035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNEkDHnvbNPp2+ALKmKWmpG/wmJs82CfVJFyAFzqrp4=;
	b=GMdG5T6pKNgf659StMpDdDknQYoTttbZJURf1a1ywV89fc2Uqo8oGWYy0eJHiTWwkfi7MD
	JZMgGyKaFPyIog02cIb4SsXEcAnzd1X0dKdC5Zo6WkWJ5LhLYBWKWZNvYcjDrXPqRLOhWW
	lZRGx+amH9tM/25ABEO12QvXuuG0Td8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-64A1Ry2-OauaLYHbW1YNYw-1; Sun, 28 Jul 2024 06:37:13 -0400
X-MC-Unique: 64A1Ry2-OauaLYHbW1YNYw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42816096cb8so11073265e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 03:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722163032; x=1722767832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNEkDHnvbNPp2+ALKmKWmpG/wmJs82CfVJFyAFzqrp4=;
        b=a/Bmnha80fz5Lu1qWW8fGqmRd5hTPoBghoakuNtVlBWtGK5Z4npul6We7oTshvEGS8
         cKwShs7TaztSfKc58x7VRX8BU6QYlAos2+QR1/7o1XDCZUzmxuCmwisMZV78Q4IV+bRQ
         9entndwBXDWU9B1ZcrN8RctrBotJ92QMv+emlz2aw3dsHWtXwRjB1N7VJsDbGBCqPzmn
         e+VC3e7dTE2fxdOwFeEZofuPOrLmYfXwcbePEehhjaQDSzYYRQfCO3NmA4AHKZ1T1j1W
         gwzHI9RouIL6qrQNrCdpUF+2NfU9rh0qCAUmF/EPQFEt2avqiTUc36OKer8Pnu0oA/vG
         E5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUIXtNJHkDwnBkPyuAw8i2dd2erdkDchiHFe1/BqGBqppwuTMG7oFIW0L9PurUB0s3qh2/FyWgXyRBQUc0qYmhrSOtucNnNL4GLj3rf
X-Gm-Message-State: AOJu0YwUKVNViYilaLh6JHRCWhu2oVsPpCWOOzplePJ2Y+rnYY0/7laL
	CnQvF/q5BcI2al1cfRKHQPdhraDEmFMuKCGFk0jYyz1vxX4Kqfz0Y4xhhgbsjyEr0oCBu3F7Bov
	DfarEHjVfQnA1Pd4W0EXUT3PSs/Sy3inPlW1qsBCKmgMWBqMscXA00Y3Hbbb5hg==
X-Received: by 2002:a05:600c:3516:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-42811dd3c20mr36594515e9.26.1722163031692;
        Sun, 28 Jul 2024 03:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2cKOXyaw7TL4RhZif2MJdOkxcn73oBa4mUrZIKj4bWWSa0equ1t3D5E9LbDUT+fBtAEsoYw==
X-Received: by 2002:a05:600c:3516:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-42811dd3c20mr36594045e9.26.1722163030219;
        Sun, 28 Jul 2024 03:37:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f160:13e8:2edc:6ef0:6600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b645dsm140178495e9.43.2024.07.28.03.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 03:37:09 -0700 (PDT)
Date: Sun, 28 Jul 2024 06:37:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240728062521-mutt-send-email-mst@kernel.org>
References: <20240725012730-mutt-send-email-mst@kernel.org>
 <7de7da1122e61f8c64bbaab04a35af93fafac454.camel@infradead.org>
 <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240726174958.00007d10@Huawei.com>
 <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>

On Fri, Jul 26, 2024 at 07:28:28PM +0100, David Woodhouse wrote:
> On 26 July 2024 17:49:58 BST, Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >On Thu, 25 Jul 2024 14:50:50 +0100
> >David Woodhouse <dwmw2@infradead.org> wrote:
> >
> >> On Thu, 2024-07-25 at 08:33 -0400, Michael S. Tsirkin wrote:
> >> > On Thu, Jul 25, 2024 at 01:31:19PM +0100, David Woodhouse wrote:  
> >> > > On Thu, 2024-07-25 at 08:29 -0400, Michael S. Tsirkin wrote:  
> >> > > > On Thu, Jul 25, 2024 at 01:27:49PM +0100, David Woodhouse wrote:  
> >> > > > > On Thu, 2024-07-25 at 08:17 -0400, Michael S. Tsirkin wrote:  
> >> > > > > > On Thu, Jul 25, 2024 at 10:56:05AM +0100, David Woodhouse wrote:  
> >> > > > > > > > Do you want to just help complete virtio-rtc then? Would be easier than
> >> > > > > > > > trying to keep two specs in sync.  
> >> > > > > > > 
> >> > > > > > > The ACPI version is much more lightweight and doesn't take up a
> >> > > > > > > valuable PCI slot#. (I know, you can do virtio without PCI but that's
> >> > > > > > > complex in other ways).
> >> > > > > > >   
> >> > > > > > 
> >> > > > > > Hmm, should we support virtio over ACPI? Just asking.  
> >> > > > > 
> >> > > > > Given that we support virtio DT bindings, and the ACPI "PRP0001" device
> >> > > > > exists with a DSM method which literally returns DT properties,
> >> > > > > including such properties as "compatible=virtio,mmio" ... do we
> >> > > > > already?
> >> > > > > 
> >> > > > >   
> >> > > > 
> >> > > > In a sense, but you are saying that is too complex?
> >> > > > Can you elaborate?  
> >> > > 
> >> > > No, I think it's fine. I encourage the use of the PRP0001 device to
> >> > > expose DT devices through ACPI. I was just reminding you of its
> >> > > existence.  
> >> > 
> >> > Confused. You said "I know, you can do virtio without PCI but that's
> >> > complex in other ways" as the explanation why you are doing a custom
> >> > protocol.  
> >> 
> >> Ah, apologies, I wasn't thinking that far back in the conversation.
> >> 
> >> If we wanted to support virtio over ACPI, I think PRP0001 can be made
> >> to work and isn't too complex (even though it probably doesn't yet work
> >> out of the box).
> >> 
> >> But for the VMCLOCK thing, yes, the simple ACPI device is a lot simpler
> >> than virtio-rtc and much more attractive.
> >> 
> >> Even if the virtio-rtc specification were official today, and I was
> >> able to expose it via PCI, I probably wouldn't do it that way. There's
> >> just far more in virtio-rtc than we need; the simple shared memory
> >> region is perfectly sufficient for most needs, and especially ours.
> >> 
> >> I have reworked
> >> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/vmclock
> >> to take your other feedback into account.
> >> 
> >> It's now more flexible about the size handling, and explicitly checking
> >> that specific fields are present before using them. 
> >> 
> >> I think I'm going to add a method on the ACPI device to enable the
> >> precise clock information. I haven't done that in the driver yet; it
> >> still just consumes the precise clock information if it happens to be
> >> present already. The enable method can be added in a compatible fashion
> >> (the failure mode is that guests which don't invoke this method when
> >> the hypervisor needs them to will see only the disruption signal and
> >> not precise time).
> >> 
> >> For the HID I'm going to use AMZNVCLK. I had used QEMUVCLK in the QEMU
> >> patches, but I'll change that to use AMZNVCLK too when I repost the
> >> QEMU patch.
> >
> >That doesn't fit with ACPI _HID definitions.
> >Second set 4 characters need to be hex digits as this is an
> >ACPI style ID (which I assume this is given AMZN is a valid
> >vendor ID.  6.1.5 in ACPI v6.5
> >
> >Maybe I'm missing something...
> >
> >J
> >
> >
> 
> 
> 
> Hm, is the same not true for QEMUVGID and AMZNVGID, which I was using as an example?
> 
> QEMU seemed to get to 0002, and AFAICT the VMGENID patches were initially posted using QEMU0003, but what's actually in QEMU now is QEMUVGID. So I presumed that was now the preferred option.

Glad you asked :)


ACPI 1.0 indeed did not place restrictions on it:

6.1.4 _HID
This object is used to supply the OS with the device’s Plug and Play Hardware ID. When
describing a platform, use of any _HID objects is optional. However, a _HID object must
be used to describe any device that will be enumerated by the ACPI driver. The ACPI
driver only enumerates a device when no bus enumerator can detect the device ID. For
example, devices on an ISA bus are enumerated by the ACPI driver. Use the _ADR
object to describe devices enumerated by bus enumerators other than the ACPI driver.
A _HID object evaluates to either a numeric 32-bit compressed EISA type ID or a string.


Then 3.0 was very draconic:
6.1.4 _HID (Hardware ID)
This object is used to supply OSPM with the device’s Plug and Play hardware ID.8 When describing a
platform, use of any _HID objects is optional. However, a _HID object must be used to describe any device
that will be enumerated by OSPM. OSPM only enumerates a device when no bus enumerator can detect the
device ID. For example, devices on an ISA bus are enumerated by OSPM. Use the _ADR object to describe
devices enumerated by bus enumerators other than OSPM.
A _HID object evaluates to either a numeric 32-bit compressed EISA type ID or a string. If a string, the
format must be an alphanumeric PNP or ACPI ID with no asterisk or other leading characters.
A valid PNP ID must be of the form “AAA####” where A is an uppercase letter and # is a hex digit. A
valid ACPI ID must be of the form “ACPI####” where # is a hex digit.

Then 5.0 changed it to:

6.1.5 _HID (Hardware ID)
This object is used to supply OSPM with the device’s Plug and Play hardware ID.1
1.
256
A Plug and Play ID or ACPI ID can be obtained by sending e-mail to pnpid@microsoft.com.
Hewlett-Packard/Intel/Microsoft/Phoenix/ToshibaAdvanced Configuration and Power Interface Specification
When describing a platform, use of any _HID objects is optional. However, a _HID object must be
used to describe any device that will be enumerated by OSPM. OSPM only enumerates a device
when no bus enumerator can detect the device ID. For example, devices on an ISA bus are
enumerated by OSPM. Use the _ADR object to describe devices enumerated by bus enumerators
other than OSPM.
Arguments:
None
Return Value:
An Integer or String containing the HID
A _HID object evaluates to either a numeric 32-bit compressed EISA type ID or a string. If a
string, the format must be an alphanumeric PNP or ACPI ID with no asterisk or other leading
characters.
A valid PNP ID must be of the form "AAA####" where A is an uppercase letter and # is a hex
digit. A valid ACPI ID must be of the form "NNNN####" where N is an uppercase letter or a
digit ('0'-'9') and # is a hex digit. This specification reserves the string "ACPI" for use only
with devices defined herein. It further reserves all strings representing 4 HEX digits for
exclusive use with PCI-assigned Vendor IDs.



Long story short, QEMUVGID is indeed out of spec, but it works
both because of guest compatibility with ACPI 1.0, and because no one
much uses it.


-- 
MST



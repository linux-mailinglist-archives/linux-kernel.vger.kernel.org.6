Return-Path: <linux-kernel+bounces-227152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FF914921
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352AB1C20DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E713B2A9;
	Mon, 24 Jun 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpzoxzyE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C1137904
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229696; cv=none; b=KRR6Tnvat96CdQVtg2afgxTk21joY1CodK1BpoG6i/+ncwItzclTCzl9353ZAYsx1rZtn8NBX3xTC+CaNlh93spgwCu/EcXPez87al7tGDXO4L4c5JXMPMavQwCTHr/tmbAhn595Fvp8UFEfICvyUNmRg5yK8CzXjqJx2hDshH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229696; c=relaxed/simple;
	bh=xGsMt4ZMBJrDwABO0KnAkxwZA8PSWTKbV5FABWmD/aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzOkmQhUgTPYpRhIHs/9ohIPj39GzNYiDFRmest5KYzNFqbXfni9Jbpzv47Txa/aL+KlGbvdMWbJy0Jr2SQaMa97XqfEexQqvRp+SQRfkLjLhA9WzIaw68sPkkp8QIf5gPdjYgSyNZp0RV8PIZQ5SQckrj2+CzawIWx7fq7wCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpzoxzyE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719229694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcV889m9n099FSa3hGP9VdafvCoKGrReBu+wZKTWFrk=;
	b=LpzoxzyE6iXidvkscrH4Qsh/wKcVBbf1aNewg+EbPM2MQaCXPtjGoMjRDvCuVhfUKGYXyo
	2n9cWzDNx7hbEDqGRFnx2BhRyi+6QiUg492fHPsfOzzKHb2aW7ICLXl49OsrKwFMOMkm0V
	y/CKv73kN+90DdeeMd/OOjOFHGG6MdE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Gt2IBX7cOG-0zw86h6qJUQ-1; Mon, 24 Jun 2024 07:48:11 -0400
X-MC-Unique: Gt2IBX7cOG-0zw86h6qJUQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7135459efbso88257766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229690; x=1719834490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcV889m9n099FSa3hGP9VdafvCoKGrReBu+wZKTWFrk=;
        b=TiC4dSUuEGyKjmoKkYo06kZQZUWecdFrnlkc9/93fiNwyApoaM2/cLN3iSdCO6dpqC
         7BS5hACGou3gq9o0NsJysC+hr/eRdHeCpY7FRiZVtn/ozgND5LV1iz0bsByUMVJs91Sb
         LxHebBmbrKZxtZqJ8DjRSgrDBejACXx6QXgdEsQ1MQOsK9Sh4hm3afazhTdcjQFYwk0+
         xXk/8AcGVYSfvQ8+1srDsDILGcKZWi0XXfBIbRGZywYn5dn9gj+Zkhhzi7wp+1YNoAtQ
         wWkSij4I3qhxKnAklXgkhNPWNeS3AmkpSMb1WRALi4bo9RKU9/9B+nzOHTLc8op37287
         sveQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5gKGvp0kxTEMDWp0w5Ks4E2op1GVXnkkoCDbT6JxfkUUQRB6JBQm2yFR1BR9C7AaHcfykt5UKpJPJB2sub7HqAX/9tNstLzrHNQgp
X-Gm-Message-State: AOJu0YyQrDvF9WqW5nDc9SF9sZD9wsvhiKD8ovabyhKZBYjzAmALYJqw
	i3nAuZyx9cGGX8s4Vt6ZoO/EA/qfG5bI7xzHREkEzpcM5WZlx3+cG5SF6J60j6SMT8MrbP0eFfX
	2T3Wdn59yl/qkEkOPsr6dYOvrDBGOWln2xZyhDAbz7WyvHHByjfcoObkt28md7g==
X-Received: by 2002:a17:906:a8d:b0:a6f:b940:10b with SMTP id a640c23a62f3a-a7245c824admr247625266b.62.1719229689810;
        Mon, 24 Jun 2024 04:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcCsPIHseM/1ERsjsN4BH9BeJrdjRCslHDdFQUF18nXEPnqFecu9/ZrknsYtKsmjg/BSm14g==
X-Received: by 2002:a17:906:a8d:b0:a6f:b940:10b with SMTP id a640c23a62f3a-a7245c824admr247624566b.62.1719229689456;
        Mon, 24 Jun 2024 04:48:09 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725f74ee94sm33863466b.224.2024.06.24.04.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:48:09 -0700 (PDT)
Message-ID: <8a6e955e-1829-404a-a962-32dcbacd53cc@redhat.com>
Date: Mon, 24 Jun 2024 13:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: wmi: Add driver_override support
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240620194214.3071-1-W_Armin@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240620194214.3071-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/20/24 9:42 PM, Armin Wolf wrote:
> This patch series add support for using the driver_override sysfs
> attribute with WMI devices. The reason for this is that there will
> exist a couple of generic WMI drivers in the future for allowing
> driver developers to directly access the underlying WMI device.
> 
> Since those generic WMI drivers do not have an ID table, the
> driver_override mechanism is used to bind them to WMI devices.
> 
> Armin Wolf (2):
>   platform/x86: wmi: Add driver_override support
>   platform/x86: wmi: Add bus ABI documentation

Thanks, the series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

> 
>  Documentation/ABI/testing/sysfs-bus-wmi | 79 +++++++++++++++++++++++++
>  MAINTAINERS                             |  1 +
>  drivers/platform/x86/wmi.c              | 33 +++++++++++
>  include/linux/wmi.h                     |  4 ++
>  4 files changed, 117 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-wmi
> 
> --
> 2.39.2
> 



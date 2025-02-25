Return-Path: <linux-kernel+bounces-531316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E83A43EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDD53AC097
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9626869E;
	Tue, 25 Feb 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMYxddYi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A182267B98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485352; cv=none; b=hlvfDxwQdumUIVoeTmAQUS7J1TSHMhq4nhvdaqEz5YWlYE876xe11rjszUZ9ZYVQTuzk5vNZMWfWj/kP3+UXLRE+QYkQd/bAzM7qDGWFJBBiZgnpSee8BSFUhY1QZPpUCXLmiUQeEsn2xoqMrzlpcFM4l0iPzN7zyhKuXxId/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485352; c=relaxed/simple;
	bh=/bHMF+VqAm3mXiDy/c+NSnUieIygySTPgyaXzjzK+SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPLFt1WlioaTin/WzH97xC66HmyYoMUibg8NfoF62aKAOYBYI5oa3mtosbjKcl/sgt4f5Wd49mOkKQ6cU+DqpE7oktyp0wcsNxjthdCMc47cWtWnJk0FZtn0wYKM3abYl73OSReUEljs3Cv22rHC+jTDG410cxBCJhKPz5y9xdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMYxddYi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740485349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9dFANPP4pAshr+nYJnMq+hckSzRgNmjIswd4al9xQk=;
	b=cMYxddYioyxysXODhFW+i8LTgfU/0YnxUj5aMNZYVY11uVVT5rfqSygv3cz8NYKFgZjoJY
	t9hnIqBOr+Pcsjo0OOKM5E2VCtk6UETvLfXD6GVhHERT/3HnetP73EDRMimKrJkWK/bJoD
	u9v6LUQrcOE6YoG+laohrBItWQESKds=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-9KKHcL1SOEuN82WTOM3cAA-1; Tue, 25 Feb 2025 07:09:08 -0500
X-MC-Unique: 9KKHcL1SOEuN82WTOM3cAA-1
X-Mimecast-MFC-AGG-ID: 9KKHcL1SOEuN82WTOM3cAA_1740485347
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa6b904a886so519769666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485347; x=1741090147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9dFANPP4pAshr+nYJnMq+hckSzRgNmjIswd4al9xQk=;
        b=qBIxnQuZYiGKTF0BgpTismHl+oUG/iyFW7VmBBEn3PO2+B/DplQi26GmRF//JJrWb/
         bk8RpLzbuuRkKkh+cidrgIUaq7tiXVfv2oeThKSMr4gGyvJO0iFDCPc3h4OXLIPOU+tM
         QYhjZHwMSG6wjYw5UZ0Q1mCkcnsaJ7xBf8HbPD4QjeKPbLKZm69t2ut31hv7YP2H28wX
         zz5/aNyjRf0MK6sGEqHBieeAW/Neg05mNc6/AUh/vPT6L3XoVND3TiGgtwdpqeGQUBJV
         9udZw0Fg0pJYIyxKTZ962v0JkChsDaodTCSZSe/zrXCN2exiYcHzIjdtxhXP9V25OMpt
         RMuQ==
X-Gm-Message-State: AOJu0YyHL/K/+Irnqvlaoo9j9ohoUeJspQ4O+/+J+Okag8dgH2FCpg5E
	rvh2VKJv1I5z9rt5OHmEdv7LaXQ5adWg5sJxE+VO3iUsShzNWSfm4NAlB0QknX3jenKj8G7qyqR
	mDb6Dtn3Qc/s4tLtoEnZ51MxQ1B8n9Y/IvyUGAycMGOFZUhRDJmQHBtljqUQ25g==
X-Gm-Gg: ASbGncsYNf4xbx3WCFaoCmG3wkr1+ybDzERfRGw7kyY53btlj71RDLQ5dX72D6IsPti
	JqA7pEaxyDhAzKUzyYfa75H5+JLFqnWU+qaDDUB0QzorbWk3mc5yT4g3up0Z3UsheLeSzRa7nZm
	HMb70ETM8lKMcY09WF5ScFypjgJu4DQ2FcGMgTjUth7JdBNs9kO1tm67SJ6o6DFLbqc8sqFWgjN
	qGdXxPsT4mZ7MMCiaMIk5SnqzgnqL3ptAg22jcU3fuoAwN0dbPgHH67tC6RLwFnC5D7FV/nF70N
	3d7eLw5D0MyKHnaJ7ZU97dtC1IQ44JytmGX+5FTzdmlSLt1XxtISmydIh5qUnu+1BC3Iha+BkDq
	Bq4HIHS2Qd34M1E++EdKl4DIwXXyiQidYfuhpsgkkigZLssYSnGzJ0kWT6AY66tfYoA==
X-Received: by 2002:a17:907:8692:b0:abe:cde3:aae2 with SMTP id a640c23a62f3a-abecde46455mr416867266b.44.1740485344021;
        Tue, 25 Feb 2025 04:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERbNL3SiexVOR9DKHPeYekUBMbVmBKTexIXmQRAzXrRMgfAbLIL6d20GsjrH+tXJ22hRzmPQ==
X-Received: by 2002:a17:907:8692:b0:abe:cde3:aae2 with SMTP id a640c23a62f3a-abecde46455mr416864566b.44.1740485343619;
        Tue, 25 Feb 2025 04:09:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2057281sm129705766b.155.2025.02.25.04.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 04:09:02 -0800 (PST)
Message-ID: <8c7b5560-27d0-42bc-8f25-0797500fb889@redhat.com>
Date: Tue, 25 Feb 2025 13:09:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Plans for GDIX1003 Support in Goodix Touchscreen
 Driver
To: Weikang Guo <guoweikang.kernel@gmail.com>,
 Bastien Nocera <hadess@hadess.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <CAOm6qnnhR9++REgtjhZpqNXkBbBAZsGAY8Oy89cXUF9S=Vy-9Q@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAOm6qnnhR9++REgtjhZpqNXkBbBAZsGAY8Oy89cXUF9S=Vy-9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi WeiKang,

On 25-Feb-25 3:04 AM, Weikang Guo wrote:
> Hi Bastien, Hans, Dmitry,
> 
> I am currently working on the Ayaneo Flip DS device, which I installed Kali
> Linux with kernel version 6.8.11-amd. This device has two touchscreens,
> but only one is functional. After investigating, I found that the second
> touchscreen has the device ID GDIX1003(confirmed by exporting the results
> through acpidump), and upon comparing with the current driver, I noticed
> that only GDIX1001, GDIX1002, and GDX9110 are supported.
> 
> I would like to inquire about the following:
> 
> Is there any ongoing development or plans to add support for the GDIX1003
> touchscreen in the Goodix driver?
> 
> Are there any patches or workarounds currently being developed or available
> to support this device?
> 
> I have also reviewed the ACPI description and can provide the details if
> needed. Any guidance or updates on this would be greatly appreciated.

I think this might just work with the existing goodix driver, just
add the new GDIX1003 HID to the goodix_acpi_match table:

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index a3e8a51c9144..4b497540ed2d 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1519,6 +1519,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
 static const struct acpi_device_id goodix_acpi_match[] = {
 	{ "GDIX1001", 0 },
 	{ "GDIX1002", 0 },
+	{ "GDIX1003", 0 },
 	{ "GDX9110", 0 },
 	{ }
 };

Note I'm not sure this will work, but is worth a try.

Also please run:

sudo acpidump -o acpidump.txt

and send me a private (off-list) email with acpidump.txt
attached,

Regards,

Hans



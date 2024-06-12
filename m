Return-Path: <linux-kernel+bounces-211669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A7090552D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C691F232F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2665F17E466;
	Wed, 12 Jun 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDZMfXNv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5451E516
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202638; cv=none; b=Mt5/K1kvUSfwfpxBFs5HQf1xGpyJhACst+mfS/NEDC8saqaVs3vsG7yDoRyOXor/QcIQz865Rpnv/lEJn7DeQgRkWi+QkGPgPCkbhHk/IMwNW91OkR/p2eVgbQNlmZ9+How9iqHsmJaKFyI3PojYiuoRMH6qSp4lmqFY3J8VuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202638; c=relaxed/simple;
	bh=omVuMBlaT5AMCk0cexHVckQ2Ggh1LZCOqB+0UbKNKTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1oNaJdhLK3j1v69P4KPUR2fWwm1OqBCv5cu8Hkm8idmG3KPKTkwUmY07J7yseoGK4NoNT0IxQISzQK2SlE/7q+RLH5t61m+ed1bvO1cTod2HkMlJrJJ1Bl0PFEpgWAhSPEhm+CJ5/1MB9NSUF9qNjzYsQ1e6JnHPt/6faOr7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDZMfXNv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718202635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cS4ThBUI4Xo4JscUapqaa6SdJC6quegytR0DPM0irQ=;
	b=eDZMfXNv2kksnWvctBXfp1fvq+ALfdH9b6qw8ANOjxA92U8yUXPCpmY6toqTXmtz88BdaD
	iJArNG66FsGA1M/9Ybfuk/iEKTZu9JV5t/zVUwwp+O8Kt6cdU62eOD59jGP+5AO+/gzfzr
	ClW7jibaozhXNsI/ni0lCa7z1LvZjpU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-rULZdvq2OSmIoyGkZs6F5A-1; Wed, 12 Jun 2024 10:30:34 -0400
X-MC-Unique: rULZdvq2OSmIoyGkZs6F5A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f3f614e58so95837766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202632; x=1718807432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cS4ThBUI4Xo4JscUapqaa6SdJC6quegytR0DPM0irQ=;
        b=bFPjqpuwBg3odLnfhMRJrGxFI3or9NfykgBpKFazjo5pRavr2GSNn9MLgjS5h6jLJu
         k2sjngcDR3md5nRX0bdM3yJnjQv6bHQjnG8v3ulN7WULb3wlUe4OegEJIc7UqSIxlE6k
         az0WG6ZY5Umh2LT4DT0Ib5HCuUrIC0CB4NNPbrSoJhzRlySkATtkp0tPnRlF7pZaStAg
         OtJyR48jsJ3JO6noTxD27cRpivjtTBuwMGBkgUCtfWvJsnwJ6SerChc3iwA+CfI01/Z2
         nakfoBxzm2kgvkqv9+UVhFJ6xCLiFrbmnP/pSHALsk/vd/8FlwBtU3FDhyhQyMjU3far
         LktA==
X-Forwarded-Encrypted: i=1; AJvYcCU/tSPz30zuybsZRJ4VUlJIgW4aCIKFWee9/DmJqprX9oWmSkiNbGo7d6WC4XRRc9diKsTBMs/XdYLov/wtr7g5eFZfEELy0Q0ypTvL
X-Gm-Message-State: AOJu0Yy/cH9D/8NNvkOBPY96Kw/eHjSJhDHmBBDKD7BC5NkVgCl1j5cX
	wSrZJssUjnyThFZ/xo1wmdsbaUskzIFeir6/bIUeyLycTF3Isehf3OciFVNBeWZl+1IIZB/LZCN
	grNcgYKkYsCc/xGSbfbRAIpD1Z+9pIbkI50a2z17OibUWhD3Jko2++SXnAfEALA==
X-Received: by 2002:a17:906:f898:b0:a6a:ab5:6f2a with SMTP id a640c23a62f3a-a6f47d4ecd1mr158152866b.11.1718202632653;
        Wed, 12 Jun 2024 07:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJZ0eUGcRzaFsAw7u/yrIlzSPl8IzB/sOG7rf5G+apo1abS+Lllru3dk+tOiIjb63LeigqTA==
X-Received: by 2002:a17:906:f898:b0:a6a:ab5:6f2a with SMTP id a640c23a62f3a-a6f47d4ecd1mr158150466b.11.1718202632188;
        Wed, 12 Jun 2024 07:30:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1226c190sm511327466b.93.2024.06.12.07.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:30:31 -0700 (PDT)
Message-ID: <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
Date: Wed, 12 Jun 2024 16:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
 mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 laurent.pinchart@ideasonboard.com, wentong.wu@intel.com,
 linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/12/24 3:06 PM, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Wed, Jun 12, 2024 at 2:47 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
>>
>> Hi Rafael,
>>
>> On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
>>>>>>> I just hit the same problem on another Dell laptop. It seems that
>>>>>>> all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
>>>>>>> and Raptor Lake generations suffer from this problem.
>>>>>>>
>>>>>>> So instead of playing whack a mole with DMI matches we should
>>>>>>> simply disable ACPI MIPI DISCO support on all Dell laptops
>>>>>>> with those CPUs. I'm preparing a fix for this to replace
>>>>>>> the DMI matching now.
>>>>>>
>>>>>> DisCo for Imaging support shouldn't be dropped on these systems, and this
>>>>>> isn't what your patch does either. Instead the ACPI graph port nodes (as
>>>>>> per Linux specific definitions) are simply dropped, i.e. this isn't related
>>>>>> to DisCo for Imaging at all.
>>>>>
>>>>> So it looks like the changelog of that patch could be improved, right?
>>>>
>>>> Well, yes. The reason the function is in the file is that nearly all camera
>>>> related parsing is located there, not that it would be related to DisCo for
>>>> Imaging as such.
>>>
>>> So IIUC the camera graph port nodes are created by default with the
>>> help of the firmware-supplied information, but if that is defective a
>>> quirk can be added to skip the creation of those ports in which case
>>> they will be created elsewhere.
>>>
>>> Is this correct?
>>
>> Yes.
> 
> So it would be good to add a comment to this effect to
> acpi_nondev_subnode_extract() where acpi_graph_ignore_port() is
> called.
> 
> And there is a somewhat tangential question that occurred to me: If
> the nodes are created elsewhere when acpi_graph_ignore_port() is true,
> why is it necessary to consult the platform firmware for the
> information on them at all?  Wouldn't it be better to simply always
> create them elsewhere?

That is a good question. The ACPI MIPI DISCO specification is an
attempt standardize how MIPI cameras and their sensors are described
in ACPI.

But this is not actually being used by any Windows drivers atm. The windows
drivers rely on their own custom ACPI data which gets translated into
standard Linux device-properties by: drivers/media/pci/intel/ipu-bridge.c 

and so far AFAIK there are 0 laptops where there actually is 100% functional
ACPI MIPI information. I believe that some work is in place to get correct
usable ACPI MIPI information in place in the ACPI tables of some Meteor Lake
laptops. But I believe that there too it does not work yet with the BIOS
version with which current Windows models are shipping. It is being fixed
for systems which have Linux support from the vendor but I suspect that
on other models if ACPI MIPI DISCO information is there it will not
necessarily be reliable because AFAICT Windows does not actually use it.

And TBH this has me worried about camera support for Meteor Lake devices
going forward. We really need to have 1 reliable source of truth here and
using information which is ignored by Windows does not seem like the best
source to use.

Sakari I know you have been pushing for MIPI camera descriptions under
ACPI to move to a standardized format and I can see how that is a good
thing, but atm it seems to mainly cause things to break and before
the ACPI MIPI DISCO support landed in 6.8 we did not have these issues,
since the information used by the ipu-bridge code does seem to be correct.

Regards,

Hans




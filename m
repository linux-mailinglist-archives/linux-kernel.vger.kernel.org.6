Return-Path: <linux-kernel+bounces-564138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CDEA64E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A61016E787
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC73238154;
	Mon, 17 Mar 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEG+oB47"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDB1A5BB8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213341; cv=none; b=ghEIOjw/MHAMthQo0ddl2W905c2RYC4HlyhcdPCnQtwXM7wDHiObD7RF7cxVeZZRPvGJOsNfl9lMxtbkWs3ENpoA3fg413B7Ftsx7g12wYcq8xn5PuXxzNt2ebM5ter0c8K1CU1inBIi5kl0Cp0KxZ1L8uMWL2+utiE51++wEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213341; c=relaxed/simple;
	bh=fgKkev5GNis8u+sBMd7UBvRwmZ3uweOhIS9C30idRKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecP5m8hfyfk6fCCtyG/+sUk1mTkLX/xANOiFL+5BsRjbt3OX/cvenSKVoyhgS/7lVbf6e6zPBwsKNZaa178xWFIRealw3zH5kFUq2ImEm84UG7RgjJo8GW1YG/BUuNzg7zp7dlDMEkTXxAi3wtvu1dvWgd3v/4liIca8JxyVe8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEG+oB47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742213338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJPQeSME8GvdRg4e0/QcxZw7No+3gHVhzWB0lS12ve8=;
	b=YEG+oB47MywRitNJCFF7qVlCwq6yxCNcaoourI4Vpud519gPH1wM8BKwExWjGU5POxwylI
	dGQAujbl/XgjeJ7qpuaZbrqMlALeL5/k9VhRZXu33EnHoMaoC6ocQY6JwLNlx/3NaD81qC
	5wUHx53ov49kL7Qhm7D9efjVlag2TFg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-aQUrc6-rOHmmv_Lc6h99cg-1; Mon, 17 Mar 2025 08:08:57 -0400
X-MC-Unique: aQUrc6-rOHmmv_Lc6h99cg-1
X-Mimecast-MFC-AGG-ID: aQUrc6-rOHmmv_Lc6h99cg_1742213336
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac1e442740cso390711366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213335; x=1742818135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJPQeSME8GvdRg4e0/QcxZw7No+3gHVhzWB0lS12ve8=;
        b=dzw5mfFxwZBKsLUfFKdlGYPOZF7aDf0AMVib19VCYwB1dmqZWEnt0YHaf+gGTnYRGa
         aS18WY5dN+P3/MojPzk92gWlVlQ33Zf2mz6ax6BDhuSZbcVmnkiT0hNcPUG6NQH4fwcz
         nw9FH7DAOVkBiR8bzTrWrisjWYSwKtlrtnsoqAdZe6eMmeNuUeLSsky42VghbYhTK0hy
         SVC21cq1830hewLm2fDaHdV1GERkB7R7u04SKUpFpnxz3+9BxjuhTQXXQ9eWEB8QjsZb
         jq5ti15dBSMZlsgMv2Qrd4qzgiH9woDsosFK2OSWbHflDxhw2ippChinq/avQGpYz5Yr
         LCMA==
X-Forwarded-Encrypted: i=1; AJvYcCUjj3BEJ+szOkRb0WD5VNnMex6Aw2eZ8KHjklkFt/gebUNsFFQESFQ4ihvF4r9lhu3cRdIPZFuPWC+raNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXMSxdKdjSsl79SAIlCT64FAo6GrQ3LgFwGvlEyEAjrbR0B4O
	xV7zQt+RO4RxLyNAVnu89ij6FOACzcjkFg/XaHOzMVR2aUynvii2U1Vn2FvEoiQYs57tTq2AHYV
	Xdwveyeck1c0xZmwmy6eAF7fLBpbRB8GtKAfrUL36T+qhUTEMz+0XsINEs5fhuxazxjBB45+c
X-Gm-Gg: ASbGncvnVZSwWaDb/6aP2x33C8ou5N3jUsG20n62HMQDZ3BMgB6s5ohs222bNBHA6SA
	Ha7TugUuy4sRCshT7vRwHHsY6/UbRba2cNv8eVoIi62TfT9Qz0vojShKy0fuSKOH1GmB79cTJGq
	1KM4M6WIeXid1k30O8o5IBQj5QppnJbGgWM1jNuRSMXaOQqJdLL9zBRHUwe38wcdx0jNi4zNiXy
	K6XCt9fq37TnWAd6iLORBsuaIbrkroOIiDAp3LJrcetWFI1sBUKHyuhQcyiT1APKrvt4oQ1gc5U
	kuFARk0fpePdzyPKYm0=
X-Received: by 2002:a17:907:7251:b0:ac1:ecb5:7207 with SMTP id a640c23a62f3a-ac330301e93mr1164668766b.29.1742213335659;
        Mon, 17 Mar 2025 05:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEASQHm2+bhVpahCDmGzllaOZY//NhzMkpnMVSSXwheT0L/ool1AlnploYIuxInxifydvQX+Q==
X-Received: by 2002:a17:907:7251:b0:ac1:ecb5:7207 with SMTP id a640c23a62f3a-ac330301e93mr1164664766b.29.1742213335224;
        Mon, 17 Mar 2025 05:08:55 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeaa1sm652245866b.2.2025.03.17.05.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:08:54 -0700 (PDT)
Message-ID: <b59d649d-4354-4fab-91aa-865af5d747de@redhat.com>
Date: Mon, 17 Mar 2025 13:08:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] platform: toradex: Add toradex embedded
 controller
To: Andy Shevchenko <andy@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20250313144331.70591-1-francesco@dolcini.it>
 <4596db59-51fc-4497-9e94-670e9533e7aa@redhat.com>
 <20250317100856.GC17428@francesco-nb>
 <bc3144b7-23c8-4b47-bdd8-c482b1a6d81d@redhat.com>
 <Z9gQMPjjCt9Rn4lH@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z9gQMPjjCt9Rn4lH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Mar-25 13:06, Andy Shevchenko wrote:
> On Mon, Mar 17, 2025 at 11:39:14AM +0100, Hans de Goede wrote:
>> On 17-Mar-25 11:08, Francesco Dolcini wrote:
> 
> ...
> 
>> But if Andy and Ilpo are happy to take this as a more monolithic
>> driver under drivers/platform/aarch64 I'm not going to nack that
>> approach.
> 
> I'm okay with the choice as long as it's suffice the purpose.
> I agree that aarch64 maybe not a good choice after all, but
> we should start from somewhere. Later on we can move to agnostic
> folder if needed. The question here is more about MFD/not-MFD.
> If the former becomes the case, it would need to be under drivers/mfd
> as Lee asked for that (or even required).

Right if we go with MFD (which IMHO would be the cleaner approach)
then the base driver registering the regmap + cells / child devices
would live under drivers/mfd, there reboot/shutdown driver under
drivers/power/reset/ , gpio under drivers/gpio and any new
functionalities in the correct places for those functionalities.

Regards,

Hans




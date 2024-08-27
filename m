Return-Path: <linux-kernel+bounces-303411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6016960BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95128286E22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3B1BDAA6;
	Tue, 27 Aug 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="uZAqjSeK"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85A1BFDFA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764831; cv=none; b=sKzDlg7wX0hyB35L+/UV9N8Q9cV9Dty4jaFXz8ip1g22TtkiY0hcAudwpGaCfTrKQh6U9pF7oa/jXF6KE89m6b8vCCgiUmwByOFSgU8bgmZthrQfW1X06io+6bJpc/amfbzYAuQYGKWvUsFLikpWk0zy67EbFdcxqOM75K8DMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764831; c=relaxed/simple;
	bh=x0cpfx0/5rVfVHSCTr+90Z8jgl4UMvT8QfYWPfAKSZo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K1W0RFwo08yYIMqbABgwZdhhBl9MtnvGwgLV2txzZ+YARN/BTDgurb/nTostO+VrRJKoyd3Nf33OlC5RlhxWMo0s1eglXKUig6DoJJf2K43tyafCnTbW1Y2N7KHfx26R15C4jt7lpRsRZ+ZD2ci2G4X4BYywNqI6TAFBy14fQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=uZAqjSeK; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3281334a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1724764829; x=1725369629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x0uUj/47e8mFChzJDIdFx5S8S7hs7ddv58CvhBlmNJU=;
        b=uZAqjSeKeubskNpu1T5Z3tExTcB+vgySCA7ueohITgJjRsYeThEJJ/n3DIFC0nD/eg
         zYy5d4TWPHE9fUbf4vAyEt3fokY+CnmlpCOPWCohlh4Hsk6Jthftn17dnIKaRf3QJvmi
         ZWm0lJL60v2ItTt1HcEKVMo3x3iq3OAj+Tu6MEQ6PsznqEA7RrCJOk2yF25aG39GO37R
         8udwcGtSXxrZjP8sU9EK256I+twzGAQfKbUdU0vl4VGvvDz4smKEhxw4XEhINOnjg1eQ
         YGqwRDfWZP1XNc2RZsQXrRTFlOHvaR+cWGL/0tiK8yZIXWhxxUfZzegohFuGglYaYSuu
         J/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724764829; x=1725369629;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0uUj/47e8mFChzJDIdFx5S8S7hs7ddv58CvhBlmNJU=;
        b=WsiJAjeogh9XoWRwSIcOAQ/h8j3onB3019ppb58ZbvWrk3lhL1y4iagkXQ2Mb+sDjk
         4uuLqu1otqwRPtwQYWT54uLoR6U5Ex52ujIMGTJ6H2EvinbnibjL4E38TyDYWQEDPge7
         yWWTlW/sDCsJPYJLlaargB5GK8xbaclh4kItl++Lfc7uY2FlJMjCAYBIID8bw79dfImS
         XSuPhyoawwlW3MGNsZXBwF5/eIvics5Do6ISWNNvJH58xEt8LV+PqtY0iazHWTkg0RZm
         Pz2OowD179zQiv1Ailv/Tomk6K4X+ynWQj9k634WUcmR+GFiYCk9lhUj6Xm8qTVeTlpZ
         oG4A==
X-Forwarded-Encrypted: i=1; AJvYcCWW9Fnd/qJdIB20jgKwkU1oBAwp3iBL04RfehVzKRAdNzJnOmPU28sqlTszwN0SOIIExR2KLDN9++RjU0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XylwEI5sPCCE7FX7sipHWyfMU8J+bzhI/FVhzTjD9wZr+ETL
	weqYpHfPaSOt6U4jlFJOxgbl06r3y8j4v2aic7pUgA8KLPrlAsMaRUgQXtMA0g==
X-Google-Smtp-Source: AGHT+IH8mAL4gLsfIXtYZg1swL4NfYzU64FyUp6oX4T0XoqH9F7EkN7XcavWE9nsg6sYST/3kxX2Zg==
X-Received: by 2002:a05:6a21:4603:b0:1ca:da81:956c with SMTP id adf61e73a8af0-1cc8b41a39amr14271408637.5.1724764829015;
        Tue, 27 Aug 2024 06:20:29 -0700 (PDT)
Received: from [172.22.57.151] ([117.250.76.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae5003sm83264695ad.237.2024.08.27.06.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 06:20:28 -0700 (PDT)
Message-ID: <eab183e7-8e70-42af-8786-a8e7b29b72c8@beagleboard.org>
Date: Tue, 27 Aug 2024 18:50:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH RFC 0/3] Add generic Overlay for Grove Sunlight Sensor
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vaishnav M A <vaishnav@beagleboard.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Michael Walle <mwalle@kernel.org>, Jason Kridner <jkridner@beagleboard.org>,
 Robert Nelson <robertcnelson@beagleboard.org>,
 Robert Nelson <robertcnelson@gmail.com>,
 Ayush Singh <ayushdevel1325@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240702164403.29067-1-afd@ti.com>
 <28513e07-ab56-4cff-972c-64c2e3d6d9e2@beagleboard.org>
 <cb8af9ed-6200-428a-a9a8-87356af6e37d@ti.com>
Content-Language: en-US
In-Reply-To: <cb8af9ed-6200-428a-a9a8-87356af6e37d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Sorry, no I've not had time to circle back to this for the last couple 
> weeks,
> and don't expect to be able to for a couple more :(

Np, I will see what I can do.


>
> The two parts I see that are missing are:
>
> 1) The /append-property/ tag [0].

So how do you envision it? Maybe something like the following:

Base:

/ {

     node {

         prop = <0x00>;

     };

};


Overlay:

&node {

     /append-property/ prop;

     prop = <0x01>;

};


Or would it be better to append 1 element at a time, as follows:

&node {

     /append-property/ prop 0x01;

};


>
> 2) Allowing the __symbols__ table properties to be phandles, not just
> full path strings.
>
> For item 2, this will make the "adapter overlays" look much nicer, but
> more importantly allow chaining together adapters more easily.
>
> Both these changes will need to be made in the DTC project, then
> moved back into kernel. Neither change breaks any existing compatibility
> so I don't expect much resistance there. It just takes some time
> to get changes in, then have them migrated to a kernel release before
> we can make use of them.
>
> If you want to help with either of those two items (I can provide more
> details if needed), that could help keep this moving along. :)
>
> Thanks,
> Andrew
>
> [0] https://lkml.org/lkml/2024/7/5/311


I am in the process of understanding the dtc codebase. Will send patches 
to device-tree mailing list since that seems to be easier to keep track 
of with the Linux patches instead of GitHub PRs.


Ayush Singh



Return-Path: <linux-kernel+bounces-217230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AF690AD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE161C213D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E213194AF4;
	Mon, 17 Jun 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j2YIu11u"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70896194ACE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624385; cv=none; b=QHkQ9i2zLBGaIJ5OS95fGXrvSoHLVg+Gveihk1SXdM2T3MSUuayenap2YiJLwURi4sZsAK6cI2jD4BGFh5bxlOwcYsWodF52QDkTA7AJUN1Br6rEyQWK6X29vlhmr59U1Bkpww/6ryp6/cq97+HLDwk8WCfORBKzsw3p6zEjvrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624385; c=relaxed/simple;
	bh=2MVBMXKtEV+SoW1Is/b02YaJ/oeQaKdapE1m/LyMP+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3i7BRY0E3WugsB/ws2vg+Iggcpt+Me+ksImAr6ddjJo1DzSWJpi5W5U4tZawgXnCPMZDpEbQfyVLLeCq+TjCUfe2M/3zdo2l2kUrF0WvEinDM/OYkCAim7ojEARwGL/OQmziS6UtS4bz7QSRmv9yW+t/BUEKaGaLgJf1OdbeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=j2YIu11u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so26428855e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718624382; x=1719229182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vk6dtPNyyVj6zzyAjgfNu0JAJ1s5tHyI8dGBafB3rOw=;
        b=j2YIu11uCKjpvr+eeGyvX7tIhVch8RzgZ9hIrLuWLhmZMbldTjGgOveDIu6+Y27qrt
         r4s8mW2KkPtOUHNMlk37wT0V1TiYYWO+dPjsrN7xavThHgY5RaGNTIiLIwmkwrcyILCg
         mAjzjXzLHwjRvdpBiJV0m3GaeCKmvrKygjGoMlkLHrXY7N9kKK+8547UO9kAscAPM4+g
         2brdViNIlmEhJfJcaOgMQqbRzdRKCdVdcwx50zUsirTI8kv+TXxXr+Zs1kvPBwN7/nkM
         j/mGQaizjBHeGs36dksG1eVfBfeO7kitzQmYU3/UCzbEqA3CMCArzydFdJQnGVoO4xyy
         OXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718624382; x=1719229182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vk6dtPNyyVj6zzyAjgfNu0JAJ1s5tHyI8dGBafB3rOw=;
        b=PDKhRJPSOYfvu3HTmawPn0cvWcBcmg2kSJnVGbtF1KL/CH11U/15lFIX38O3deOaHT
         7VokrYNxPTFbaXaVUVsvfXzPvnqwK0eTqVnEMCtuLcDj5NOQkvd+RSS/c2yubdp1Gy/l
         M5CML0/+29u9ngTd2xTLWsBkCud+EweUQG5jy5Mm5uN0r0DlZR9rx9brRxe/ee8z0Vs9
         dCKaIegPEFYnGUIYPvPZkYPM3KHZce6o46b+UOr1+bLzE5T0CJ7FpQh47/XEgf48XO9F
         SFwrxC+l177nSHJPAyG5PM/6J+niAJFfrxTOY6sreXwycyFW4pAk0gbINJNXRhh16sPW
         U4kw==
X-Forwarded-Encrypted: i=1; AJvYcCXDnmGVunHEN7JnNDar9qIKz5X9yPOWEEUcNBB21+ST1EICqX4jVbK4vXTKYj0rVdXDqYY0MC2gX3O12SrJ7Fhr+B4Yy8pCYItuvNVo
X-Gm-Message-State: AOJu0Yxakk9k8uAQglIWjgpz7vvQMgkbC30P6GA7qWxEehtjtU5/6jvZ
	PqyG17iiKpIXW6o0F4s57615l7y9z/ZkaIjeGH18C8kWnQA4wSEm3B5k74pQOPw=
X-Google-Smtp-Source: AGHT+IFVRuTLn45QZm+qYSRfTY8AFzPm0Gs8GMkMeMyMJm8QfZBwXB8YbsDOfaj/yQR/DXrCVERX1Q==
X-Received: by 2002:a05:600c:5110:b0:421:7f07:92ce with SMTP id 5b1f17b1804b1-4230481bc6fmr93604225e9.3.1718624381698;
        Mon, 17 Jun 2024 04:39:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6419e38sm159155415e9.39.2024.06.17.04.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:39:41 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:39:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Cindy Lu <lulu@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZnAgefA1ge11bbFp@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>

Mon, Jun 17, 2024 at 11:44:53AM CEST, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, June 17, 2024 3:09 PM
>> 
>> Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
>> >
>> >
>> >> From: Jason Wang <jasowang@redhat.com>
>> >> Sent: Monday, June 17, 2024 7:18 AM
>> >>
>> >> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >
>> >> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> > >> Add new UAPI to support the mac address from vdpa tool Function
>> >> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address from
>> >> > >> the vdpa tool and then set it to the device.
>> >> > >>
>> >> > >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> >> > >
>> >> > >Why don't you use devlink?
>> >> >
>> >> > Fair question. Why does vdpa-specific uapi even exist? To have
>> >> > driver-specific uapi Does not make any sense to me :/
>> >>
>> >> It came with devlink first actually, but switched to a dedicated uAPI.
>> >>
>> >> Parav(cced) may explain more here.
>> >>
>> >Devlink configures function level mac that applies to all protocol devices
>> (vdpa, rdma, netdev) etc.
>> >Additionally, vdpa device level mac can be different (an additional one) to
>> apply to only vdpa traffic.
>> >Hence dedicated uAPI was added.
>> 
>> There is 1:1 relation between vdpa instance and devlink port, isn't it?
>> Then we have:
>>        devlink port function set DEV/PORT_INDEX hw_addr ADDR
>> 
>Above command is privilege command done by the hypervisor on the port function.
>Vpda level setting the mac is similar to a function owner driver setting the mac on the self netdev (even though devlink side has configured some mac for it).
>For example,
>$ ip link set dev wlan1 address 00:11:22:33:44:55

Hmm, under what sceratio exacly this is needed? I mean, the VM that has
VDPA device can actually do that too. That is the actual function owner.


>
>> Which does exactly what you need, configure function hw address (mac).
>> 
>> When you say VDPA traffic, do you suggest there might be VDPA instance and
>> netdev running on the same VF in parallel. If yes, do we have 2 eswitch port
>> representors to be separately used to steer the traffic?
>> If no, how is that supposed to be working?
>A eswitch may allow incoming and outgoing traffic from multiple mac addresses left to the tc rules to decide.
>It does not need two eswitch ports.

Ugh.



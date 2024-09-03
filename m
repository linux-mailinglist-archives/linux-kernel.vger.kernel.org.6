Return-Path: <linux-kernel+bounces-312594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35EE969890
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68244280F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0401A4E8B;
	Tue,  3 Sep 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EhhwXCW1"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68671A3058
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355060; cv=none; b=i7+8OGljeHpburSY4jpGz16prBIHt3f+JeVLMXt9IB9JHcJ5KWntD0rbZV2Kxz1tX/xSUV4lIq/t0QWINYHW4HFbo5+TEF7xTWV6i7EA317tNAvUSm7Xrud2mYIK2HW7pTn7jDGwk9gJeRHQlrFx7tx1vkUM6Jna3FUVC98/c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355060; c=relaxed/simple;
	bh=LkdS7OCCBAZXkA+UXUJ+Kq5JMyhgSe7KCq0sN5hnqKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQep8GUDjdQP9FRA69uVWD51/t4tGTxYq6IddDrCTR3xW6jyB5gWdrwvbGyIVCkrOf9PhDlkH18w3tpL50KCMi+Pm2qSHcH6O99Mchyb2QbLDPsC/scQbyCF2RtDJxetUde3SEjI7gwUVB974HlplCr+ToX2LjmHWpTddR3FQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EhhwXCW1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a868831216cso582191966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1725355056; x=1725959856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unYnDtIsElsDse+Va0cHUHNbjndhn2ZWY0Tb6Z5hUhk=;
        b=EhhwXCW16W8Mw97ajpkYO5RU6uUM5IwyU+IvbERWuMY9K4fXONGqPAnXtztUHnPhVg
         pwICVx+NPhCXmcg6NV4q/MmGYflrFiLZ/PfKs4WyBqHrdK1IgHt7vABXyzFHqDnsxOVU
         1xM2M9wWghyUASEwWlNFT1yqZ0xdRaiK5prZCIdyXhaP9fhVx3PR8oUniV5RL3VhTd51
         +xRjLOXpvA7YkXqvrdFIW6SMdhehRGRqYc57n7jex6N8nhrKe5PKIquljwwY4D11li+t
         8SkuCvVkq54qigrhHOAwQM5LdZknWfdjwzK2rc47fY0I/hERuRCXWPlJjdbfUspYxfVB
         1niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355056; x=1725959856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unYnDtIsElsDse+Va0cHUHNbjndhn2ZWY0Tb6Z5hUhk=;
        b=fCKRXVgrCLZOWaedvkdkafCKdd4OhRekC9hUjkJ93/wrlWn0oow8HQr1H6lNqOx82v
         g8CkYJi7Em/6Ujddx6TcRsikQekL8yLlAhdeeZJZLq0uCdrDgJ8wakU6pHj/ubI62gxI
         DxpgYutnOPCnBxuIUsAW5A9I3DwlN61WWIRGV+V1nDExVloXPpS06uZViSOJzBOngkCM
         1LPs5jBHOT7SW1RiaE1i44Sgq4FcJmqt0yPZav9QWPct9rEVeaspLjRrAMTbNllA/VHc
         uAelpPyF73FdegsQ7XKU67J2tVnFDnEvYv6TmnuRULTm2QpPDd6zzMmv6h4urwMQmLTy
         LV8A==
X-Forwarded-Encrypted: i=1; AJvYcCVMk5G91RwcyPSIB23oEWgd/QmCYb6YcTJaZBUyX7FltKDYowj23EKzpzjI3RUPusyIMUpD1IPQ+VEYu9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDysfXcJqJGxot9PTmObgj9vilpeJd6s76Yp9ZWLM0+feFGmvM
	yzjt/pbaBCOw1PrdGAQsN+pqrsY0mYWpvAVicVSAHjXlF4yuFSvoPLovAI1i++I=
X-Google-Smtp-Source: AGHT+IFG9ytyEwPybheP1Q8wR61RKVp7onDXGutB8ticYWnuOKRSaVIFRBo0r6goH77sKsY3TTGAVg==
X-Received: by 2002:a17:906:fe4b:b0:a79:82c1:a5b2 with SMTP id a640c23a62f3a-a89b93db796mr722813366b.9.1725355055846;
        Tue, 03 Sep 2024 02:17:35 -0700 (PDT)
Received: from localhost (78-80-104-44.customers.tmcz.cz. [78.80.104.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb05csm658804766b.6.2024.09.03.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:17:35 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:17:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
 representors
Message-ID: <ZtbULbRQKHUvUzYq@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
 <ZsdOMryDpkGLnjuh@nanopsycho.orion>
 <CH0PR18MB433945FE2481BF86CA5309FBCD912@CH0PR18MB4339.namprd18.prod.outlook.com>
 <ZtWiWvjlMfROMErH@nanopsycho.orion>
 <CH0PR18MB433993BD0B4FF3B1F98A7628CD922@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR18MB433993BD0B4FF3B1F98A7628CD922@CH0PR18MB4339.namprd18.prod.outlook.com>

Mon, Sep 02, 2024 at 06:37:32PM CEST, gakula@marvell.com wrote:
>
>
>>-----Original Message-----
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Monday, September 2, 2024 5:03 PM
>>To: Geethasowjanya Akula <gakula@marvell.com>
>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>>Subject: Re: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
>>representors
>>
>>Sun, Sep 01, 2024 at 12: 01: 02PM CEST, gakula@ marvell. com wrote: > > >>-----
>>Original Message----- >>From: Jiri Pirko <jiri@ resnulli. us> >>Sent: Thursday,
>>August 22, 2024 8: 12 PM >>To: Geethasowjanya Akula
>><gakula@ marvell. com
>>Sun, Sep 01, 2024 at 12:01:02PM CEST, gakula@marvell.com wrote:
>>>
>>>
>>>>-----Original Message-----
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Thursday, August 22, 2024 8:12 PM
>>>>To: Geethasowjanya Akula <gakula@marvell.com>
>>>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
>>>>edumazet@google.com; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
>>>>Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
>>>><hkelam@marvell.com>
>>>>Subject: [EXTERNAL] Re: [net-next PATCH v11 00/11] Introduce RVU
>>>>representors
>>>>
>>>>Thu, Aug 22, 2024 at 03:20:20PM CEST, gakula@marvell.com wrote:
>>>>>This series adds representor support for each rvu devices.
>>>>>When switchdev mode is enabled, representor netdev is registered for
>>>>>each rvu device. In implementation of representor model, one NIX HW
>>>>>LF with multiple SQ and RQ is reserved, where each RQ and SQ of the
>>>>>LF are mapped to a representor. A loopback channel is reserved to
>>>>>support packet path between representors and VFs.
>>>>>CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>>>>>adds representor support for both RPM and SDP MAC interfaces.
>>>>>
>>>>>- Patch 1: Refactors and exports the shared service functions.
>>>>>- Patch 2: Implements basic representor driver.
>>>>>- Patch 3: Add devlink support to create representor netdevs that
>>>>>  can be used to manage VFs.
>>>>>- Patch 4: Implements basec netdev_ndo_ops.
>>>>>- Patch 5: Installs tcam rules to route packets between representor and
>>>>>	   VFs.
>>>>>- Patch 6: Enables fetching VF stats via representor interface
>>>>>- Patch 7: Adds support to sync link state between representors and VFs .
>>>>>- Patch 8: Enables configuring VF MTU via representor netdevs.
>>>>>- Patch 9: Add representors for sdp MAC.
>>>>>- Patch 10: Add devlink port support.
>>>>
>>>>What is the fastpath? Where do you offload any configuration that
>>>>actually ensures VF<->physical_port and VF<->VF traffic? There should
>>>>be some bridge/tc/route offload.
>>>Packet between  VFs and VF -> physical ports are done based on tcam rules
>>installed by  TC only.
>>
>>Where is the code implementing that?
>We planned to submit basic RVU representor driver first followed by 
>TC HW offload support for the representors.

Would be good to describe your plans in the cover letter. At least the
once that are in near future. Without TC offload this patchset has
no meaning.


>>
>>
>>>>
>>>>Or, what I fear, do you use some implicit mac-based steering? If yes,
>>>>you
>>>No, we don’t do any mac based traffic steerring.
>>>
>>>>should not. In switchdev mode, if user does not configure representors
>>>>to forward packets, there is no packet forwarding.
>>>
>>>


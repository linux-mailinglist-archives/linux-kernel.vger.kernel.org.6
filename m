Return-Path: <linux-kernel+bounces-429995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428FC9E2D31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831F0B2F6FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288E1FC7DB;
	Tue,  3 Dec 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMujLNoO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CD1FAC5C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249468; cv=none; b=eMGe8IQ0k1FvlhG4mxp5wiEbcWb1zIpMDwnF4iaF5LrZQWfQBD7yUc2TNz5ST8oiJfaO7zE/IalGON+bXoi2ZWIiFuGSfV2jz4Fbao+utqF83MvBmR9iWghe2gL/Z3FYkSJ+shDT+iSY2HonWHC68R8DC9zIAFXCdwsLpbXY5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249468; c=relaxed/simple;
	bh=k3VzcsYJANMAGGk69XkEJ1vmKo5QHfC/+lJZ4baayBQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fx/siZlSgwTOUZ+Gcf7NsSyQtQ6umRsyKXX1Tw5J+V7KQ8RkMzaYiG0c53RaBJOdNXYCKkE5tbYrygtnj3Oi+Vl5IvDNKan24rcc6h2UhHgEuFBfkyZzbs29QaoMz9o300MXLPpvuA/r06fT0MWrSHOvBAkye557LYaGN+qdXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMujLNoO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733249465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNRcjw/KekyabOo7RK4b+13ZweRHEdK3B7dyQF8BEAk=;
	b=OMujLNoOg67IFOJP3ajh+w8QByokAI7xPmcH8crcxGc7mMsisHkXAMcXOCIblXOjCpV9it
	7wxauyhU65UeM3UHVA/VjoLNP8rTHJ+WB3iQHhVwoxcYYJJuD8krMLDs8u2G/Q6kJJYyL5
	nyzibXD7MrxbCa7pDzHbtqG3ev/GMVM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-7sMsCTAyPi2lJbctz7k7QA-1; Tue, 03 Dec 2024 13:11:04 -0500
X-MC-Unique: 7sMsCTAyPi2lJbctz7k7QA-1
X-Mimecast-MFC-AGG-ID: 7sMsCTAyPi2lJbctz7k7QA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d893f0027fso62156096d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733249464; x=1733854264;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNRcjw/KekyabOo7RK4b+13ZweRHEdK3B7dyQF8BEAk=;
        b=QwEDizMCBrX/EfqXUzUojON85iumF+duVg+/2aYcTPhn6G4D8bper2EMbucNWoNqRH
         ANEcO0GkdrHmR88Ui+3wnTTPZq69gwceVLEp56DvpGXFATcRlAhjP5AXu+gxHtPlwpkM
         9rthkJrqC9QjljgQvU7ur/N/Cta18zbEadHFAv9ei2YyW11lGM3ixjKNVRGvDaSKdjwr
         mttUPRWiNsSs4MM5ir3sQ9bqLtaPGPTBPltysV+L9+fnr1AuiGAKMQFGLdm394mdpSQx
         Iu6Ygy/rZ32LsxwUDNAbn61915xMPm5R4nW7wtw71tP6KU7lxu7eIf1KnZZDWh1jGnwK
         lxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUwI22dZ65YtGFLl6h3VkF9F2DNLmh8ptuRdd7z1RV8bIuzjir+0y4ESu2pta7bPXYwYAPCMHgPLC96H0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4uz2Elt31a/USVh7257gq8C4o3CpQROAU6nZHqAjo2E1jUYh
	9OkZL67IgYfuh3OISSVAAtI1lI9Q2VydLMqf9NIpIqZPo7QKs8IGfXSXMXJFYA6grdc+1yBsmMJ
	T30ilYB7rOVarI3BIbVYYNAtcrGeArxtYXGY+KctS0hhG4SA6abIBIeObJJbGAQ==
X-Gm-Gg: ASbGncv4q4M3/KqYzV1cFoXhn1hREkjYYJ+15sjiws2etdB4mgw7nU0P6S24tj8Z6y8
	57GChFgIod8BvvQYtDLD07FBTe03yajuvpxjEelU/EV9Bsu1MwYF02amhUiTvvpT0HZMV1COv4+
	frBpn691tUOf7LjPM8yAYTbYq27l5rKC7fG+1wMcM3CqpVvnBZea8pKUScq9Oo6Y890xhWC1Ddh
	Krze8c27UpUT9pzNngibL/cAuADpl3mtSiRdetuFtAQYk0lLzzOMpnfsS7LTHlkbT217MPXPM8j
	rq6xpD7tzl1TnpMP5A==
X-Received: by 2002:a05:6214:2683:b0:6d4:27fd:a99d with SMTP id 6a1803df08f44-6d8b736bf12mr55393936d6.19.1733249463824;
        Tue, 03 Dec 2024 10:11:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHItFz5pbgu6NiS3RK7eDf2oYnjAmEEXaSpaC5Xaf8OxQN0zjiZG2K1X0Qdl+wi3VOAPQfNrQ==
X-Received: by 2002:a05:6214:2683:b0:6d4:27fd:a99d with SMTP id 6a1803df08f44-6d8b736bf12mr55391666d6.19.1733249461923;
        Tue, 03 Dec 2024 10:11:01 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88c634940sm47830456d6.130.2024.12.03.10.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 10:11:01 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6f31fcdd-82d3-4d37-a730-607ad7ada260@redhat.com>
Date: Tue, 3 Dec 2024 13:10:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Remove stale text
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241203095414.164750-2-costa.shul@redhat.com>
 <8a50e837-a1a0-4636-802b-4573c3779aca@redhat.com>
 <hjyhaosr2c5dsldlgzzsqedxzy3xd2e74ibtpxguz6ymbzqu2g@zs436iuhlnll>
Content-Language: en-US
In-Reply-To: <hjyhaosr2c5dsldlgzzsqedxzy3xd2e74ibtpxguz6ymbzqu2g@zs436iuhlnll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/3/24 12:21 PM, Michal Koutný wrote:
> On Tue, Dec 03, 2024 at 10:43:26AM GMT, Waiman Long <llong@redhat.com> wrote:
>> Thank for noticing the stale comment. There is actually no task's cpuset
>> pointer anymore.
> Yeah, that likely evolved into task_struct.cgroup css_set pointer. The
> "guidelines" for it are in sched.h/task_struct comments + comments for
> struct cgroup_subsys_state.
> Also, users may need css_get()/css_put() if they needs subsys state for
> longer. (This info isn't actually cpuset specific.)

Yes, that is likely the case though I didn't trace back the git log to 
figure out its exact evolution. Anyway, these information are optional 
as it is not cpuset specific.

Cheers,
Longman



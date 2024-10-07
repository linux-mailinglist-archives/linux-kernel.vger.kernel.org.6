Return-Path: <linux-kernel+bounces-353386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADD992D2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6591C2274C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914CF1D31A0;
	Mon,  7 Oct 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="CBlQuJCg"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467E1D417C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307351; cv=none; b=nkOlV65ZjESp9TCicQW+z98boCgGHoP0NdVA2mgUt7A/F1HxlLlVsVjgZDGYnPMrc8mgpU57tuQuEAhyhiz/kc2s6qq1/QLZfTdJMjHjCA9w1j1o3iJf7sT58RtOMapz1P3aLKotXpkuKhV6Mink5aD6IGajf3YKbMbEu9e4WKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307351; c=relaxed/simple;
	bh=utVWN3iWLARwJ1w0i0Zp3uRtKoFb2xnAD8O1rUjwFLA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dFKI/MJD2yVOnkX5r5A3KO9Noa2uM3fciQ7c8/vt1Kzh9p/Wj76yx3CsCyvIrvhpogxbrs+DFbCVKp1Kc2kFZHovX0hbndhpOWdJ4DPFGuN3b5fBc185heKO1GFo56VEItEHSGZTpYzpCJMij7hkPARaKYp9NDIZyXc5fhtBWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=CBlQuJCg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4582c4aa2c2so33072361cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728307348; x=1728912148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stNX0CPH5IvIaCsbaIGRjS0lIiZFwjIZE9dikF6mqJU=;
        b=CBlQuJCgoIqXQwqIE3Q6kHy/rsNpxiwE92FriDw+xmkr0N4vSCRQdh0n6chS4ctSQZ
         w5S368IT80ohFd3PgPTP2b2VvGEBZGleQ8o4B+a0pGj/qfSMd1qCmGUCxcI4yFeApt34
         OkdwSP3YAGMLvoVOEgaWB3KJh/W8ABgOFvZHoy+t/upyfwzmtRhKRCM+YHD20/IuT6Sl
         amxmExr3ynLg8nxw8kXYxx0Px/USvwot1R02OdHfZg50mFcwdREzx5bmDrNoNCpDbgxH
         YbRRFi2cSHog2uNU5MFdzQljFQnBfFK36DtfGnz2NlPzLFANiMmIcpMI7M0SY7+PbprO
         ce6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307348; x=1728912148;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stNX0CPH5IvIaCsbaIGRjS0lIiZFwjIZE9dikF6mqJU=;
        b=NVNtAy9nvktuP3k7xzZCnCWP692gsHbQu8Q1hUkkq1o3hrzXt6iSC13PDPp+7qPu1C
         ZJOur349Cyh9KJAHuV+JtBanmyYoujb/DMENTiaiD9/yH+JkmcoW2+cAH/oPt0WZcEl/
         UpXELJZNfReqy5P3m6ZWy6B8Eqq0p7KcutNnsHwH3arE5C814d0H2S+98lzC8wuL8ojn
         k3M+rlVKntinpjYBxQZXChAKBPElI7Ll954yBJveRd8EEz1nFd9ZG8wSL0uNZaXXDU7j
         VBYUPQd9TM3vx3yFQ2Vq+KW2wXlegas5aBqVwQO71obIJddDdBL49/clhmx6mFTV6lx9
         POyA==
X-Forwarded-Encrypted: i=1; AJvYcCWBqOP6szVDCM0YwN3fIWXD61WDCTvHOur/ROXycj68HBAuF6bqXoRx9MqNoa80Q/6Oo9bZp365jSOe1Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWk4d5GkA/91TbLuQdUt2+Loe7UhAwY7gYWUnxfJpF+M+FW+/
	l7lVbx+UYeTopwgnBABco+0GKvzxxGR9UghigSuiSveMn/G6ZVU6JrvK/sxro2iOQwMt47e1UpM
	1uPU=
X-Google-Smtp-Source: AGHT+IGm5KDXGgiekH3egpesPDNg8awpzbf4iyWtuNkaFmOHJ2mn6HP4vwirEz7pnWjezESexrXL3A==
X-Received: by 2002:ac8:5715:0:b0:458:401e:c1f2 with SMTP id d75a77b69052e-45d9ba69ca5mr143491341cf.31.1728307348099;
        Mon, 07 Oct 2024 06:22:28 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da755647asm26379781cf.41.2024.10.07.06.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:22:27 -0700 (PDT)
Subject: Re: [PATCH] rpmsg: glink: use only lower 16-bits of param2 for
 CMD_OPEN name length
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Arun Kumar Neelakantam <quic_aneela@quicinc.com>,
 "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20241007044723.25347-1-jonathan@marek.ca>
 <rmybaobbmhmynz3or4uwvhdgqjrkahmkwz5ncct6rssnfpq4jh@ulqeqesixyhz>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <8b050bcb-640d-4443-ca31-787ec5c02a7d@marek.ca>
Date: Mon, 7 Oct 2024 09:19:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <rmybaobbmhmynz3or4uwvhdgqjrkahmkwz5ncct6rssnfpq4jh@ulqeqesixyhz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/7/24 9:16 AM, Dmitry Baryshkov wrote:
> On Mon, Oct 07, 2024 at 12:47:22AM GMT, Jonathan Marek wrote:
>> The name len field of the CMD_OPEN packet is only 16-bits and the upper
>> 16-bits of "param2" are a different field, which can be nonzero in certain
>> situations, and CMD_OPEN packets can be unexpectedly dropped because of
>> this.
> 
> Any idea about the upper 16 bits? Should we care about that data too?
> 

Its a "prio" value, it should be OK to ignore it.


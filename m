Return-Path: <linux-kernel+bounces-278451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6A94B067
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC3A283922
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863F14388F;
	Wed,  7 Aug 2024 19:20:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10A1097B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058455; cv=none; b=UkUcSsvtd7R/iE0hb7wbQeMkKfX4NWRkYit2P1qAtg1NR65BE9tWZFRX2IzdZiMNp0ANs89M7qDSO3GgnWFPsYL5v3B6XYNK+a8z6nfvBXCyjYw5eqgV7t/mEVri91BS3z/w8yicVhAJgWtARqC8WCOvseFO4fN4wlJdX8jMAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058455; c=relaxed/simple;
	bh=rZxEeRMJ7SSJdfyd6Lqv24OmJNL8pcViITRieGW6ulY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lixFigw9/0ygO2c2HILL9SwCtRFmYv15SIDoo0cCywZtP/SK0dZq34ktEix1+bYLhYTvH3GjyMrvad6x/T1Ki1/FUhLTV8vzPwsYP8B4r30sm878A4EJSBKOEUV9Edb7tRd4rNlz+C5+iMQxiexoIvwEvcpl/+X9NFx5j8Dz/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B6AFEC;
	Wed,  7 Aug 2024 12:21:16 -0700 (PDT)
Received: from [10.57.68.109] (unknown [10.57.68.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B815D3F71E;
	Wed,  7 Aug 2024 12:20:48 -0700 (PDT)
Message-ID: <d3c86965-090b-41c5-85a9-187704754072@arm.com>
Date: Wed, 7 Aug 2024 20:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 James Clark <james.clark@linaro.org>, scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
 <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/2024 5:18 PM, Ganapatrao Kulkarni wrote:

> Is below diff with force option looks good?
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..efe34f308beb 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -36,7 +36,10 @@ option_list = [
>                     help="Set path to objdump executable file"),
>         make_option("-v", "--verbose", dest="verbose",
>                     action="store_true", default=False,
> -                   help="Enable debugging log")
> +                   help="Enable debugging log"),
> +       make_option("-f", "--force", dest="force",
> +                   action="store_true", default=False,
> +                   help="Force decoder to continue")
>  ]
> 
>  parser = OptionParser(option_list=option_list)
> @@ -257,6 +260,12 @@ def process_event(param_dict):
>                 print("Stop address 0x%x is out of range [ 0x%x .. 0x%x
> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>                 return
> 
> +       if (stop_addr < start_addr):
> +               if (options.verbose == True or options.force):
> +                       print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
> +               if (options.force):
> +                       return

I struggled a bit for the code - it is confused that force mode bails out
and the non-force mode continues to run. I prefer to always bail out for
the discontinuity case, as it is pointless to continue in this case. 

          if (stop_addr <= start_addr):
              print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % \
                    (stop_addr, start_addr, dso))
              return

Thanks,
Leo


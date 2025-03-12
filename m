Return-Path: <linux-kernel+bounces-558118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC92BA5E1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646903A561F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEC1D95A9;
	Wed, 12 Mar 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUJW1ZC5"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB0189913
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797578; cv=none; b=kVY9x01Y5tDwIrsdqcullEqf0xvD/G6EWhFK98NJ8vKVqb8z/9deo9bphVSLlHxfbKG7EVwfehYe2xgVZ4OklOPUwoBTi5V4WjOG3AH233I2NHiJrCYhxBW/+0P8jN+fW0gVuIBG3nGG3vcUksbxSp6OWUyIYsoaGPi1G4hYMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797578; c=relaxed/simple;
	bh=7Dr1MDyDQsGP0fniHjRmZwi5+c+l+mR+RPtDS8prI18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjMchhCLZtdayt75IZ8JcRuI50YQUtPyRMIeIK2XKpMN+1ckoOEy7BpcYxRatx9b1NywzuiLrWKo5eNSfNtdxpFcSS4IyfdZzLQKS/vy35eHlS1ASho9CvLocLaF5IBf+hhsF669Hs9a6HSD5gkT+lB2X8jWwkUEJptUE8FlaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUJW1ZC5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso15264266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741797575; x=1742402375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Dr1MDyDQsGP0fniHjRmZwi5+c+l+mR+RPtDS8prI18=;
        b=lUJW1ZC5UYsOKowHd4OS+TqBPvNg/rRss04z1bOFVBgK9vVdErN6rqMVob17egFghQ
         4jTb3ZroPMWQAkTmFykUzD25mrEC5B5kbwsh/bfYpbeVPIOdMRR1lNtEUc+G7k6HStQG
         NlpdrsKYaozJQsxJ8rU8VDb/uw6sBv/VRT/GjssdbbbJZ0vlHq+4pGB1j+uF/nRaVPI2
         mSmbiU0NHC7llhgA/7dODuKNAizqRPJVVn+qeMWCCRVCc0W9DFSIYniCk7Qw5HOybEW/
         ZEcC8jnS3lMnfJCoCpWHfY9YqdnY1T0EcptiXsC5RdZlWDp37pDYUV6BkysmkEc8Vih9
         izpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741797575; x=1742402375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Dr1MDyDQsGP0fniHjRmZwi5+c+l+mR+RPtDS8prI18=;
        b=QgW5oLSJwPgPzLgfE0s7CIPDuK/I5hOyGDZ+le94vTNkoBJsBRtbOZHvLPM5viVeJc
         Blr8Yr6YxwRzFVwBxUyVMWBPzCPKoGOVnKea1MuhV1Jsg01qVPzsG22ts+ct+LgDHkDg
         zr1ArEnhctuCulEmk/5463OpBXOQhELq5M7lOcLO94HKTT1QnjrziNCLZvpfFFT3WHho
         6m8NBUBdqgSQFb8Di/CXORHu8WoP4oPyNHd9+6+BEWjy72DpSR52WzIgdirspm/2wWGt
         R2c/pwSz+YItf3pZuno+FyCHbluXF7OnpJ4+O11/joiqfkkKd9ax+Wr+ArF9zDcS+R35
         aHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX41HoOc3CVAc6rujH8FDbHCTlXqS/36796uIG46NtM3Wn/ObpV58vAGJhO76wgeg6vg+H4x5xpxvyKTZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1z/cc2mrLJUlpELJddA33S+lUZQXUYZANmI3ze/6PU0E3IF/g
	/Yhx+p6hptSP6XxYhhV5umgnFyb08S8AUw1YEICP6TA+Avt+TNBWiOSZZnDq
X-Gm-Gg: ASbGncv9CuhSpyaxeHVz+zMY18x7DOKW3OKStwPwsOTm1uZcFQhkzQlzVyKe//QzndS
	wGbkYSCTueDrmZRxK43wid/RX6cPKzaGa/aW51ExAmG/lqSCOLo6wg6+XjryGBj65ODW94m1OJe
	PhTVRE1LCls7vBQ3RrdV9tfEhADUJ1ey4tOWW5CkCTnyvNXvq2Nzpr5yfCG3hiFDJUJGhsMqZb9
	2h/v7A+03hSdiZn9fJBRLMFXsgqMwMPKoBz9JUd1q+uI6rWI+QpvNLm/Y8z+ZosuKehyCS0Km40
	zsA3eoeaHdhPGKS+fZigAPOXDzh0Apto0OzW8FXzFagG9fJYJ58j0xH7UsOP9CI=
X-Google-Smtp-Source: AGHT+IGqUvt93yOKWrBv3nP61FwNocObvR/pqZ3oUF8K5pMzwkKTqAD3SGHTXTu393d+wegqjHGxuA==
X-Received: by 2002:a17:906:478a:b0:ac2:f24e:1fa3 with SMTP id a640c23a62f3a-ac30b63a5famr24817866b.20.1741797574797;
        Wed, 12 Mar 2025 09:39:34 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25fae7d83sm905736966b.99.2025.03.12.09.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:39:34 -0700 (PDT)
Message-ID: <130308e4-b9c5-4e6c-97d2-c36f9edc1f43@gmail.com>
Date: Wed, 12 Mar 2025 17:39:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to
 v1.4.0
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org,
 "Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
References: <20250312111915.2970032-1-naresh.solanki@9elements.com>
 <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com>
 <CABqG17im5hO7xv-r16mFhJwcXyXt-6OKA_vTaRdc7kuQrdZyzA@mail.gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <CABqG17im5hO7xv-r16mFhJwcXyXt-6OKA_vTaRdc7kuQrdZyzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.03.25 17:03, Naresh Solanki wrote:
> Hi Gyorgy,
>
> On Wed, 12 Mar 2025 at 19:47, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
>> On 12.03.25 12:19, Naresh Solanki via lists.openembedded.org wrote:
>>> -Upstream-Status: Submitted [https://review.coreboot.org/c/flashrom/+/51960]
>>> -Signed-off-by: Khem Raj <raj.khem@gmail.com>
>>> -Change-Id: I55c4e8529d36f0850dd56441c3fb8602c5d889fd
>>> +Upstream-Status: Inactive-Upstream
>> Is that really the case? I mean it is just being updated to a new
>> version, it doesn't look that inactive. That PR seems to be abandoned by
>> the submitter at the first superficial sight, is this not the case?
> Yes. its being inactive for long time.
The last commit date in the main branch of
https://review.coreboot.org/flashrom is "Sat Mar 1 19:19:16 2025 +1100"
- less than 2 weeks ago, with last release just before Christmas. It's
not as busy as Yocto, but doesn't look abandoned.

Or am I looking at a wrong repo?
>>> +
>>> +EXTRA_OEMESON="-Dbash_completion=disabled -Dtests=disabled"
>> Nitpick: Could you please fix the whitespaces around the equal sign?
> Sure.
>
> Regards,
> Naresh


Return-Path: <linux-kernel+bounces-238091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15198924360
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4E31F23FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2711BD4EA;
	Tue,  2 Jul 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eocu5ISx"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CE1BD037
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936905; cv=none; b=N2LtnHDZaPVGpj2Hyf4LDT/FwCYls6SD8pjkrEOauqxT0c5nh8oN6sAywv4TCXFmjFw1vxgRugGQQPOBF0TVceymB7yImOXjPxFlpPdm/Plq4IwglK1p/WuHcM7IBvt6UZU25W1BmGvpr17nThZdFglzQYDH87tMVb3GUM8R79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936905; c=relaxed/simple;
	bh=vl0S7Z8DpmU2zNirDJUeMFIKfv3z94bq8ndZdBprWrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXcpT50/2YYGEg4Ogu8imStt3MmMFZmQdzfku4xy52wlmEo9l7d9yH1XrTHSQW5SZmqqZpZlrVkQg1ifSJFNZeqk2KtcuhJ0Rwj9f61mxbG5SvYl4ozJgM6kK85U3Q6B2S/6Eg/hJWFwMaD23NRjamOdIcs6fKZefQiegZbG9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eocu5ISx; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-375deacb3e1so2300025ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719936903; x=1720541703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+JnTEY5nK6WHCH03S/fnQh6gkAQjGBHi3UQYO6T6R4=;
        b=eocu5ISx3NZm4z2OqYqHenuVEDv01ODXmQR19rCfdoTms0ZeveqvUO3ctWU4D9M8ro
         H2DHI21kasar2tFK7TVV8l71kPIpkrMTLiiyUDcN2hV4yDkRR/WU3UuRjO0Yt2BoYGpB
         UhK6JfCfGgphEwiQipKrlD9Bkzlvch6SAYXEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936903; x=1720541703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+JnTEY5nK6WHCH03S/fnQh6gkAQjGBHi3UQYO6T6R4=;
        b=SMHQ+qwVIAM2RVlg6cBLOxAKfHxbRX7sDy8YaXzpJWhzP5oRB2KmlbUeNLsxEtOQ34
         scQPKpnlrV5U7JzOulRmecmycNTm2msJq8s0YoV4ELfKHJ4knL1WyTRN45W5h36Ur8tj
         uSzyaA9MW/uPG96U4L2P/tuWX/KDUvoAc25Y0L6xjMoTUiqRLxo+Eehh43YqF0qCO2rh
         ty/E15Gv5Ub+w69CHHubVCqv4LBHgb4E3q89WL7G1chLvC6JH/ZYHR8g9YAFEPe3scwm
         9zwr1o/PS6gBs+bV16icDwZBLkbPiuQWpujoZQc6FmuVcmd0ySKlDHK2KLUIWuF8bhdf
         w5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/IbiPVuRM82yoc6I60kp5H+CKisQh+f87ezuM+ftrz+VbK90fo3gJNO5m4q4A+5GIZE7KMaITnY3GSMXj+4uC88bj6I0t0AR+iPVR
X-Gm-Message-State: AOJu0Yy+QhZNDQP6svPDJo6cQnQ+kl+jiTsj3DqGNVAQSHsCOMGAXfOP
	t9/mTUBLbMrPpT2T3gfSkqrEboiwZQJMMYsIYea1jfwCA4onyFfshtwHv2T+kXg=
X-Google-Smtp-Source: AGHT+IHlIAprc4clVNBI6LajbpkwWNn6lQCN1xV4M6c0WjzXYwqzBdJE1r0JFxzSfgbla2kaNTXAoQ==
X-Received: by 2002:a5d:9b8e:0:b0:7f3:a20e:c38f with SMTP id ca18e2360f4ac-7f62ed4cf57mr825907439f.0.1719936902970;
        Tue, 02 Jul 2024 09:15:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73f910fdsm2867682173.91.2024.07.02.09.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:15:02 -0700 (PDT)
Message-ID: <42ebb5e2-66c5-4787-b934-3eeef0e9903f@linuxfoundation.org>
Date: Tue, 2 Jul 2024 10:15:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
To: David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619202511.it.861-kees@kernel.org>
 <CABVgOSk7RCMak0ZjRaTE4tYAwV5ZZ2ZHdWC7RWO0Vo6ZwORMdQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSk7RCMak0ZjRaTE4tYAwV5ZZ2ZHdWC7RWO0Vo6ZwORMdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/24 22:05, David Gow wrote:
> On Thu, 20 Jun 2024 at 04:25, Kees Cook <kees@kernel.org> wrote:
>>
>> Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
>> this test there.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@intel.com/
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>> Resending as v2 with Shuah in To:
>> ---
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: Brendan Higgins <brendan.higgins@linux.dev>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Rae Moar <rmoar@google.com>
>> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: kunit-dev@googlegroups.com
>> Cc: linux-hardening@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> ---
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David

Thank you both. Applied to linux-kselftest kunit branch for next.

thanks,
-- Shuah


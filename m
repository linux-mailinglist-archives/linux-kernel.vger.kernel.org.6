Return-Path: <linux-kernel+bounces-395644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41839BC0ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9640282D70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3771FEFA4;
	Mon,  4 Nov 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IK+qHm7v"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1C1FE11E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759299; cv=none; b=S4cB6u7AeT3mwPw0xtjtMXawac7xzGtw0zRpqGqkhe5q4RI2NTvmLUtrA/HE7qcDk5+zu8RqQ0nE3jKBJlfPlg2fC+o7KSSnYnznj95CJZrfoW247w32QunjWHG5bVSPuf3PltrSqForSl8ZLZZoKsz7fJu8gEx8uyeZG+CNaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759299; c=relaxed/simple;
	bh=dbJRgW5uebXlKtcBol1ClLLvP2/tGNM0XYC93P0716c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZcmIMSg15QmbubSuD781f15TTF4Fl5+ufgqd/YliCcriRtlIXgM6QeR/+6GPlOLU0L4Iu5tDR1/Ire8SFJws4MV0EtoX0tVu9hVuwDdSnhd8tVClg9x+M35VfSBTB7/LGfyIjGd0udmbLIkEdjURLwPC8IHmMagsAfr3wEhQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IK+qHm7v; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so187160839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 14:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730759297; x=1731364097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0PpHaAepvBwCmmRuTSYTtbzJ2tDagh2UIfBmzCGWWKk=;
        b=IK+qHm7voMcNvSYXcERGg25agZY6N2NaJo54JydavwX052wR/Z2x4zoF/o2C492GT+
         dddCGY1TuH3q2yMhlvfizRASR8ZOYUu30XyjdHFtP6fIuhvw3RrrJRSxziQ+N8NZLY2c
         XVQobCJTeVCBUe5505roPTy//dsV0b4LkJTFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759297; x=1731364097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PpHaAepvBwCmmRuTSYTtbzJ2tDagh2UIfBmzCGWWKk=;
        b=NhXqOwlo6+12RSLHqHlLLbO+TMh3w5/qAHWRBS3c13I4BwGXJ/cjDnllnzmMAUHVC3
         T1PFf7NX3KhA0hQDzUAyma8qmJLKDlsz0Tn/zVRgFaxelZXqfewCSR6hQCCalp0LwGKK
         62bDS0c2pON7QG2tPDYO9IhUt6gxD7K3Ri5m2wMXudLmE3Qr3P10w5S6K18+61PZsjQ2
         9yJAz4REFNtrMBJnD2Xk4oDRFBlT6oa0uQuAmessdja62yyR41uaJCLDSubKa7rgRYvA
         Uvr0uEsRK9tP0ZaGqpOH4KTB/LA3zQy4CCy+jHTeGss1jf/BhDDQinRJA18AfAl+RzVp
         F5kA==
X-Forwarded-Encrypted: i=1; AJvYcCWMfP5qhMPOFffSNkdfoTpCzRdQCCjE0zLkBSIeuUsFIJIfH6EraT+V8UpGRbkOP4Vt5lcSSaeiGpRDrWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOplcUwOC53WCjLdrdK3xII5RIppKGQK8LLn1sez/w0dXk/Sxh
	QAomckSVhq+JN5FDutTbXq7CgTJsluhTAkAyj9qiIF5QRsNLet9mSEyIST/pjkU=
X-Google-Smtp-Source: AGHT+IHvvadZZAWAqd0cl7rveBR/vWFq3SR2vE7sVfhYTUcxMLumTtQzoTJVjt60yl6N+DWew9ZiZQ==
X-Received: by 2002:a05:6602:29c2:b0:83a:71c6:26f4 with SMTP id ca18e2360f4ac-83b1c5ee442mr3519890339f.16.1730759297088;
        Mon, 04 Nov 2024 14:28:17 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04977c73sm2077086173.91.2024.11.04.14.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 14:28:16 -0800 (PST)
Message-ID: <3ba7cd24-a68b-4996-8b36-dbf3164db8f0@linuxfoundation.org>
Date: Mon, 4 Nov 2024 15:28:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org, tony.luck@intel.com, peternewman@google.com,
 babu.moger@amd.com, ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729804024.git.reinette.chatre@intel.com>
 <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
 <5b2b54b8-77fa-4ef9-aa08-549cab91eb32@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5b2b54b8-77fa-4ef9-aa08-549cab91eb32@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 15:16, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 10/24/24 3:36 PM, Shuah Khan wrote:
>> On 10/24/24 15:18, Reinette Chatre wrote:
>>
>> Is this patch series ready to be applied?
>>
> 
> It is now ready after receiving anticipated tags. Could you please consider it for inclusion?
> 

yes. I will apply the series for the next release.

thanks,
-- Shuah



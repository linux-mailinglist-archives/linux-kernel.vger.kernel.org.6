Return-Path: <linux-kernel+bounces-204974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF98FF5BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59E31C261A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC33573451;
	Thu,  6 Jun 2024 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd2G0q6B"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3D4087C;
	Thu,  6 Jun 2024 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705025; cv=none; b=JfCjlJ5TLXltuGXBUhBnmrVP1XMr1Jk6+cErL9dN5iSPeh4cM1QB/fG4LelKbyUpci5rF5gSXK4aH+CwasG3eArz4RDA+p7PgJ4d6RI12dAiHSiicOCmO4JWtrhShMsBji83JTIuqk8d9EjsOICanQbYB6iM1kSFu5CyycI19HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705025; c=relaxed/simple;
	bh=MojF64g3qeGzJpL9xjL9l2iCruX4eRjYEO6HiXPP3Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcGq4gPCjxPY0BhXB23lV77kDMOzQdVWntN4Lz1BVdKiV65AljnjPBp18JO1jVNIEJkCFiDaqoANQE7Z8iZ9Bz3F9I4r/nOv2vy08sEZMTmMIaVMPkSgcq2iUn9X0zpdn1mSYH+kB6/5L261CQQok9HbtNUKTZWDYbOsmrNjD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd2G0q6B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f61f775738so12650685ad.2;
        Thu, 06 Jun 2024 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717705022; x=1718309822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Vox9mTkZlXCf8sOHEn/pthk3lSwJg80jcuxQmvb7VWQ=;
        b=Cd2G0q6BVcIJWpSdP6jPllsQFmiGFn92DrHDG/TFNa97KPrmueZPtouoLB6dB8QgBu
         xl6xwziuYDM6/xkxnm86LA4/s5BLlN0LjgRSUE04rAPPmhm+or9leoM33klonwFpjXMD
         Tgpbs6V7I1esZlORidnGWFS1yXHC/8ODACrtWi4lzojroHzGPUZE7nAXF9keuZhucHD5
         iGF/E18eIy4A27lBYWcqAC3EISjmTXuNgsIRZ6nV+dUJRG6h0ZU+MBOi/7UXMgBmZyVE
         7Kvoo5EnVifQxbPDhFnKjLzFH3qe1pJR7l/r5WXd8cOLUPIVr/CxhB38c0cqSrDYemuw
         050Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705022; x=1718309822;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vox9mTkZlXCf8sOHEn/pthk3lSwJg80jcuxQmvb7VWQ=;
        b=SfE7RJEDkmf6TntuDSQ00vAcMfyk6/ky2AwpC0pibOCnv/n2SBPrvNKXvzn/MnA9N3
         a/fx0+t2bB3blHo1sfIb80xq2UvUOQLGPTXIVyy5Cyyc/BG43ABnHy9bQur3f3i63oS2
         tZGU5dYAEdBMT3giHlXnYCoaeLKrdJXk0j3l0AVIMG+ngTVlZLHrpTdHjnFFTONf4OUu
         PUewETdzumuc43rEY+LbNShsF3Ji7emzyJNlLnfHZNzINLm+K/1//+C+wMcyCTpWLWXF
         rjlx9n5TKxEsI3P8OIrv7bLBqkHWgBY9vqgRAZm7cIaxXCPkABa3hMyMMY3luydYWUab
         aAxg==
X-Forwarded-Encrypted: i=1; AJvYcCUB2VUy+AjLKZcWAxM7J8zbitK3QA/6IE3icIhfJ5YxEW5gGSJr6OOPBpP5+WHGyi7WHC1x9mrqk6k2EtEkp4sIrTTfyGvc78YjMeNOpMxBzhR9qUZHzwj9D3Zidc5SxSxsPm5N5kX1CIY=
X-Gm-Message-State: AOJu0YwmZpk36nxximM2VR9F3uuOdgYUnjm+FlzI3CAL54bX5T3cZRWp
	tVRpSWPTkRMVopXBqbpmDnG3THFRAgxbGmVGCxcK4psGlv1PKW/+
X-Google-Smtp-Source: AGHT+IHf6rnPBUoUn1KY0t+VRww4OuCl4n2+BQ3fPggdvrY50wa19m4FiRLTgJTS1ND3mLCISavfNQ==
X-Received: by 2002:a17:902:e88e:b0:1f4:bcef:e970 with SMTP id d9443c01a7336-1f6d03bc747mr5757045ad.55.1717705022438;
        Thu, 06 Jun 2024 13:17:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76be78sm19459555ad.95.2024.06.06.13.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 13:17:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9f2e2b48-f7b4-49da-ac02-1f73923fb9ef@roeck-us.net>
Date: Thu, 6 Jun 2024 13:16:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (cros-ec_hwmon) Fix access to restricted __le16
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Benson Leung <bleung@chromium.org>
References: <20240606180507.3332237-1-linux@roeck-us.net>
 <571aaac0-a397-4aa8-b9d5-2315f6a637d4@t-8ch.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <571aaac0-a397-4aa8-b9d5-2315f6a637d4@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/6/24 12:53, Thomas Weißschuh wrote:
> Thanks!
> 
> On 2024-06-06 11:05:07+0000, Guenter Roeck wrote:
>> 0-day complains:
>>
>> drivers-hwmon-cros_ec_hwmon.c:sparse:sparse:cast-to-restricted-__le16
>>
>> Fix by using a __le16 typed variable as parameter to le16_to_cpu().
>>
>> Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
>> Cc: Thomas Weißschuh <linux@weissschuh.net>
>> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Guenter, does sparse work locally for you?
> 

It does, but I use the version from git://repo.or.cz/smatch.git.

Guenter



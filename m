Return-Path: <linux-kernel+bounces-558467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D227FA5E651
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE61891D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3351EF080;
	Wed, 12 Mar 2025 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eiaw079A"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1251EE7A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814069; cv=none; b=j0JOSQYClHDkse+q39mYB2aPtvzSnWs728Shu9XatJeUyi+nl8+3aAwH1wFzEawIQdoIt7g0o5a/FWecTYV48Zz4ZRocpLbgOx5CThV2zHmQXQrQo0/SM/FbXGBQSfw5M7AFCdTCxG12pDFSuxeciObtyy8pWhpn+ywfs70Oqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814069; c=relaxed/simple;
	bh=6UF+YuU0wX+plFZORJsomemL5KK5qUeLNTxNubR9Gy0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=luBPm/3/0cFJof/1yROgqP5TxDyQM9KYcvERmEqez7KzJoaGUdFOGNvslMtx2qFZ7kbQKNfZtZM+1E3nbec6PadpLC81YpCcCZZNAiQBhvLAFG33A19hURTYR8+FV7cgA/u7c9dV6QvHE3jihUT40Dewoxk0zIvIXsajS9MhSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eiaw079A; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85ae4dc67e5so11908839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741814067; x=1742418867; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UF+YuU0wX+plFZORJsomemL5KK5qUeLNTxNubR9Gy0=;
        b=Eiaw079AJPMe4tvCbBY0TZKq/04VF4ZInCLWVtDGM36AaE8SXsYGD52vIk48Es9nGf
         6HHbCOgbpNpgAFUBnkkepjYAe5Nntcf7S0E/xlfHPLs2Jtf07t6EomuD99M9rPznCG+Q
         sFqsJ55X/aUht0Bl15/rEviceXfA9crv17Pn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814067; x=1742418867;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6UF+YuU0wX+plFZORJsomemL5KK5qUeLNTxNubR9Gy0=;
        b=QFg56kOVq0V4LEuG2/pedRRsgwx+GXOpMy+BbStLKltWnmg2YYHc8x9dlx2g1oRMUk
         L+f7elw5hMd4R3xRQA6VTJsVatbYjKtkY9QJ0SdS0hNpGffk6N2ZkP4d63LQ45zxUkkt
         7h/puIq5u2sXMxrem8RGE2mT9swVp4XR/WvC1N/uSIN+VIxVa0fr73ZCGcACp8muLYBk
         8g8oJKkZrHuGCq1csUK2iAP5iDvoxkWGeUfC6LRDLjDlC8QYznov9cDIhbm9XSlAjRZd
         xSaLHy+1KO32X9LDyH3V/LziD1MTQ7BTWxF2naKQIYtJujs4WjeNw4pve7TAFPojbmJE
         FISA==
X-Forwarded-Encrypted: i=1; AJvYcCW/wnBBM1f9JIF5kaYsX5EmBHbzwDP91XBKGHqHVKHEz9roGMJzoQDB69txmbvQQNGefZ74DL9nXcB6SQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+/rPtlqbFFyhikYaR7yveUU8imI4VZBAgC3xFP059T+etIG5
	53STRq7rI8DmqR661nqUgxqcXgdL0knvw8E3JnASHrI3WPHtERGOp2KXe3D6gOM=
X-Gm-Gg: ASbGncsMcCBLfZ19oyVDZ1w6cNY4wq2BaLixHMErYpiTzaC9uMwM8aGKYWT0519HeqW
	JuZIYS0GCaKRnOaO/zCgUCd6rPwffyAEChS9Dd1WzeBXhlJMg8ldODakbg89k5OvYRUmAJeDCbn
	TAfKw+gOXgLuZ9KDFQl1KQ9h69KHU107O6GUjj6J/P1lMlG+/KDe3ZQdLT1kqOR0NqHSOqKdCRK
	jLanHVeb31wUvVM8F4+ic/0jzb/SgNPmC7bGYLbL/bFgtyGkeLrU+1xYx7CmOyjZLgLg0Ly3jXn
	Q9xPWnrtS5q2ydcRMmmH8iaBzRrDN3hQjJyBXf6Gkun8TKMz6eaPJSs=
X-Google-Smtp-Source: AGHT+IGOWv8tETkCL7TpozFaaeobHyPBrXirDu6J30+UeEkj5+Kdc8PtxUnsQvlwjO3xwT77Ej6y0w==
X-Received: by 2002:a05:6602:4143:b0:85b:4941:3fe2 with SMTP id ca18e2360f4ac-85b494177d8mr1695652339f.7.1741814067014;
        Wed, 12 Mar 2025 14:14:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2504b11a0sm776586173.22.2025.03.12.14.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 14:14:26 -0700 (PDT)
Message-ID: <0842477c-6063-40f8-8e8e-b9ce98711f80@linuxfoundation.org>
Date: Wed, 12 Mar 2025 15:14:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Gow <davidgow@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: Error during --arch x86_64 kunit test run
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

David, Brendan, Rae,

I am seeing the following error when I run

./tools/testing/kunit/kunit.py run --arch x86_64

ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `sev_es_trampoline_start' referenced in expression

I isolated it to dependency on CONFIG_AMD_MEM_ENCRYPT

I added the option using --kconfig_add

./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_AMD_MEM_ENCRYPT=y

I see the following

RROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
This is probably due to unsatisfied dependencies.
Missing: CONFIG_AMD_MEM_ENCRYPT=y

Is there a better way to fix the dependencies? Does kunit default config
need changing for x86_64?

thanks,
-- Shuah


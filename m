Return-Path: <linux-kernel+bounces-288800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFA953EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AF3285EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6591E4AD;
	Fri, 16 Aug 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM/ECHIC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6E1AC8A7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771684; cv=none; b=YbaWQZfvZD0CZNKye8Rz6KmyVQjsVzRsw382cHvwnA0f/Ds3dFguGDAn+4XQp2khHujuyyJpzpRS47O671ZplfaL9c6FD0wDuTvhutbxhXMPl9kWTU3OrOdt9XnYIBB8kWEzuJMCjSWi0FaYkhYwPGyooBKPyxWpkMyHz/X0MOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771684; c=relaxed/simple;
	bh=Ut7lC5iFPm5Fje9rAyZCdC9bIDlMKTn3vK45pWSJSVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOPkGrWGNAYY+Nh0RgctqF0ZVTUQ4xpjI8GBaBGsh5m8ZBNkZBYbwf9tD3QIJiSMim2+NQ3kgfEBXmkwQBDaMQgXlkujfaSb/l2qIDiANWdmXvnsaMSV20EXk/Ogufs4E/0NxJbM+ym4Dvr0mxvodoAOCownEb6dBNEoA2lAoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM/ECHIC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280692835dso1704245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723771681; x=1724376481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CgEy7hfKFthFZZPBDQD7SjHIdc0mQHaJOdB41dxLuI=;
        b=HM/ECHICyTbUba5PjDaIlILtH7Ghzk0JxrrR3/jUxmEVtbLlRj9bRbM9X6RF9fwL6N
         rfZIwPIM+/LidOaiBzV3I23pNfEH2UREp25hn+QCyy924XphmFEuhevlOjBoKmr5WYhh
         19EmVMR6jTsEb5AujOFPBf9UQtyq8SGY9xszOln9c/qelpy0s0OAA32e15DtQoADyPyl
         Vy9Be+6hjAgX39XXW/LzAf2x5pSPCXtI7t0MC0M9dDKw9wwGcBgWcylM0Wub+OqKxFe1
         Mg1wYcut49TRi3tA+3r6heqtsKTL0xxIGDl56i971k0/BwUBn+jrVPpfsSgZmmBu+IBK
         Afpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723771681; x=1724376481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CgEy7hfKFthFZZPBDQD7SjHIdc0mQHaJOdB41dxLuI=;
        b=rSZr03+k/temECi4jHUOLiy4Tvf8Wf15jts7gDOImuQmm9dR6yVnNFRLuJVfTULpMJ
         mAtKoYo4niQFqTLgGD+8JXltzpI8Sn8GVODqPW73Ygop6ygz6GogneBjpJgtHtirIgmT
         65JvZY3svLaqRXpWeUZmzP4oQNMNf+pWEhBCdHAY7SogGrf1oX+FhUl0L7eWLnUYaB5+
         MCTqb7NNjWxunv10rt34OUxW/ILICyxvgMb2UsDV9H9+FOTCkqfmhJEfi8iVPmyFGRm6
         dZFFcsvkNzyNDN0Wo7XFnUoilic+n49gmBaDAWuTe3gI6PQJwUv3OJow22qndFiOjrzr
         rPSA==
X-Forwarded-Encrypted: i=1; AJvYcCXxvKW1hx6KtMz4DkBxzAP5CdbEjS/4IlL8te5kONYme62OedWZjDZBsouZXqgdKAOcnrIYNPduATgKbNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Gbg21Qr+e+VOEUxA1gTIP3G9+TPNHyUQE9y66WSHmIcsrPlT
	89VvTO5K857xJEsEfWtETv8kY7uOdD7LhLUrJ9FQR/GkUkOqIfY3
X-Google-Smtp-Source: AGHT+IEaAGUdf0B+yyqrMnf/sPShcs+9+3IiKqzlWh/vF+IdGr9Icjy5lRRuPG0lV39sl16jyCVS9Q==
X-Received: by 2002:a05:600c:1d0b:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-429ed7f95cemr4215905e9.4.1723771680572;
        Thu, 15 Aug 2024 18:28:00 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:6f87:1ca5:9107:75? ([2a01:4b00:d20e:7300:6f87:1ca5:9107:75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed649019sm8768855e9.8.2024.08.15.18.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 18:28:00 -0700 (PDT)
Message-ID: <393fbdf0-7e56-486b-b932-3c7561e83740@gmail.com>
Date: Fri, 16 Aug 2024 02:27:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kees@kernel.org, davidgow@google.com, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, erhard_f@mailbox.org
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
 <20240815160402.a4c80b075082f537853fe2d0@linux-foundation.org>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240815160402.a4c80b075082f537853fe2d0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 00:04, Andrew Morton wrote:
> On Thu, 15 Aug 2024 01:04:31 +0100 Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
> 
>> Subject: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
> 
> What's "UB", btw?

UB in the patch title stands for "undefined behavior", since passing a 
pointer with such a short lifetime to kunit_device_register causes one.

I was not sure about how to call this type of issues (misallocation, 
probably?), so I decided to give it a generic name :)

-- 
Kind regards,
Ivan Orlov


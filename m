Return-Path: <linux-kernel+bounces-393649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF59BA3A6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C8A1C213BF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08C70836;
	Sun,  3 Nov 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsyUMDsX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032B54673
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730603883; cv=none; b=LFq2mKXNxkFXzFJqkgih1+dkNVD1R1VRRQJV+YvxQYZS4lZCVL7kvYCu/IzYZZP0BY+s3iCORPRWMfsEqjh447pXTRbW85CIjWeodHQcjGDhnGxQK571fUjG5FzR/MK0P/8Nz5CuRGoVx77mbqp9vuvj2HH4yD7whIYBOlEomKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730603883; c=relaxed/simple;
	bh=GzE3B8y4AseLNcANBIyXunRDcuWU4iElNFE7COh2qo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaS6O9SYos+JHraRoo9MQepDA9o7Xxwi8Xr80MDvsrgl2pR4CoI3oJJQL24G1ZPyJ4A2Qrgcgw9Oa5RPvatiO5SDhismmU1kZZ8j0wwgb9vdM88NidsicZfOswvaNSQkb5RuD3BeW7efzpsxqvN+WBZu+N5Cr0fDWq4rlPT9G8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsyUMDsX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ce65c8e13so35219135ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 20:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730603881; x=1731208681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exIatdvty5LJpxpHqh/69zu1wUv5L7Dzv2gQV88V1Kw=;
        b=gsyUMDsXw3tjTMiZ+MIImdO/hCXgq6MVPMCOyhJbFV48sWv70l6mBVtI54UP+Bz/zn
         RD81ZdLS/269gtWDQ3IKpZlaVrf1qp+F/9EnsnOYll5a+T2shTIY006uml6vebA2FlNX
         SD0CwiiWAMC/sSGQlj5ZzDKbcAfkyMkDGKT098yOcP3lMJi0+jLKReh3ypptwOsX9QRB
         XuZsjIGUJTgwDinwaueWgh4mLqx2zZJbFuG9Ox4xvQon70hUS6bNRkc35QkhPCNheJpk
         WntyD24yNL+R/RhLla8it/du5cnHcAKbTYW93eJ7NjgNLJjyQvjhHVhmUMipJUyuW851
         W4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730603881; x=1731208681;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exIatdvty5LJpxpHqh/69zu1wUv5L7Dzv2gQV88V1Kw=;
        b=hlLjvVKfXIDDDlRd3pZmMhPTe+MDnh+jdhXKuZYORdGd6cxE2wD+jSH2KB/yZY4alQ
         JR3veD2A3tVo4uJxDY87dJ+Puy7q7I/qkRGNYyXDNo+14FE+ljoH5tqARvliH+V6U+ii
         fZ4bhtNmIn49eXz4KHj0tAtBBHGlXnxMqqfO+kSWm5no0U24O0CL+SKQCqjAaF/2CASh
         kSk/7C/hE+Fvh/w39Xkl0cA0Vxa6FXe7pRUzGRNnteZ8IBMHAxRlfEceCqIxotKS0jrg
         87YoJs1E+ZzoXpiuzZrW3fBC9OzcoAzXLqXQXnc8PIAmX5Iwm7n0/fr9Xq3mXnBtkrVn
         yR8A==
X-Forwarded-Encrypted: i=1; AJvYcCWDseTt9OKEkCNhphRgpHxZBF5D0vefm6W6ezOMJXhxUXsDpwem3/+LVXapRzf+w72OyYITrVzVvG7aty0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhsYnbXLdRNkyaCiXay2bepnbh/sXUXvui1u8sZWVl32EYR/b
	mKoWQl5As3+OYuFxBazbxQEH8GVx50kicdL2bEwIdE7EJ2579IMjOD5O6JNGLw==
X-Google-Smtp-Source: AGHT+IFVAvNZzt5OoUkhykRu2I19QIG+rknpVTRzP7loL8WmCWEvTXq8Mfp5ROfrvskRYYVXq4jnOA==
X-Received: by 2002:a17:902:f68c:b0:20b:a6f5:2768 with SMTP id d9443c01a7336-21103ab9756mr180219545ad.10.1730603880755;
        Sat, 02 Nov 2024 20:18:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:4570:89a0:7f01:d6b3:84ff:4b6c? ([2600:1700:4570:89a0:7f01:d6b3:84ff:4b6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee46fsm40281455ad.21.2024.11.02.20.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 20:18:00 -0700 (PDT)
Message-ID: <a1707c7a-a874-421b-ae6a-0d3cc9fbccd7@google.com>
Date: Sat, 2 Nov 2024 20:17:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dt-bindings: usb: maxim,max33359.yaml: add usage
 of sink bc12 time property
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
 kyletso@google.com, rdbabiera@google.com, badhri@google.com,
 linux@roeck-us.net, xu.yang_2@nxp.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20241031235957.1261244-1-amitsd@google.com>
 <20241031235957.1261244-3-amitsd@google.com>
 <r44xdvk53c45bhyvwhy6722vj7wttkhfesta3ty22kkt6nfrtu@vcooujz3ywlj>
 <a86c8317-16d6-4aa0-b8fd-5c83b1445212@kernel.org>
 <kw6czm6ekl3m6qcqt37vgwaz4wu5zllfua4sjoif66lg6gt6ns@6seazbeefnhw>
 <0a15823f-d2b5-4b92-9a28-e3933394c907@kernel.org>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <0a15823f-d2b5-4b92-9a28-e3933394c907@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 11/1/24 1:34 AM, Krzysztof Kozlowski wrote:
> On 01/11/2024 08:59, Dmitry Baryshkov wrote:
>> On Fri, Nov 01, 2024 at 08:09:52AM +0100, Krzysztof Kozlowski wrote:
>>> On 01/11/2024 08:02, Krzysztof Kozlowski wrote:
>>>> On Thu, Oct 31, 2024 at 04:59:53PM -0700, Amit Sunil Dhamne wrote:
>>>>> Add usage of "sink-bc12-completion-time-ms"  connector property to
>>>> There is no such property. You cannot add it. You did not even
>>>> test this patch before sending :/
>>>>
>>> Sorry, now I see that's the patch 2, not 1. Somehow I thought you
>>> started with it and I got confused.
>> The question is why patch 2 generated the error even if it had patch 1
>> in front of it?
> I suspect patch #1 did not apply, because it depends on USB next tree.

Thanks for the review! That's right, as indicated in the cover, this
patch series is dependent on a patch series
(https://lore.kernel.org/all/20241022-pd-dt-time-props-v1-0-fea96f51b302@google.com/)
that's in the pipeline.


Regards,

Amit

>
> Best regards,
> Krzysztof
>


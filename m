Return-Path: <linux-kernel+bounces-345518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0A98B732
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F90A1F23137
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F63C19DFAE;
	Tue,  1 Oct 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvQbLgct"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396C19DF8D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771906; cv=none; b=f1AOr6QC61ed9sKEs1BKJOdNmrpajEuXnGEJduuhgdjABRJJt++eSL8FrJBNWiMYumV4k+HKUso5NcdwHvNV9AeOJkoBm2Anbs8SdpF/BCHC+Xi7lx/3lyMNdKk+NVZBJTsFcXTH5e60QbboZGFXh683wRqMV18senHSgZ0ZbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771906; c=relaxed/simple;
	bh=wgQgC9RCRJnIcZveGXttN0x3tBTsFRv2m9x2WqocIZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks9A4uqHjZNs6uxhOF1r3ZBzlaR38JyIOpVG9NPeXdm/5JZxWgSHCTDefPsM4M1UTTos0SFVwK5zDRmy/JaR6lvJaK4FbehxSlhCog1FS7Qx87eyeUj/MZGqmKLh0NvuuJIUdGdiFQv+55cwIX4Qfnqt1mHSfZ+YumOcMCAFcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvQbLgct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727771904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyfxFy3IhKen6jD/dEYL0rKxgj34Sx/xNCwG5QfH/EQ=;
	b=VvQbLgctA8+XPYL7+5Ne12z9wOH1niqjRwgavFvkmS0fZxRjEE0d/wQmRcp/Erugmy29vL
	yKwErqVTmlX1mMw23m4rgLYKqdMy8Puv88vpdW6FjTV6NagReu1tOtsTLMsjXMtRL2ntdG
	TVRTlH78bZWZ6UGVgJAPjtiSp0lyqu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Ykc4csMEMViO8EQXjQuXJA-1; Tue, 01 Oct 2024 04:38:23 -0400
X-MC-Unique: Ykc4csMEMViO8EQXjQuXJA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42caca7215dso29778375e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771902; x=1728376702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyfxFy3IhKen6jD/dEYL0rKxgj34Sx/xNCwG5QfH/EQ=;
        b=AjlYbsr5qRTJqYWsgPGQzBa/MDv0BtK4boZ4qotN1XXtyqGsY74znfV3hiKc4hzQa7
         Qrqf6/JcuL+686GS2mcv2zq7duAq1nh0mnnhIPRN9yeyUfCUGT9jnzGnOlydp6EAbh6f
         bMZ2Pu9/mVJEg2UBgpujba/wUe6qmWXZzO8Ww6JW5VNJCXgpyO1VgvBmFMMxLrfS19hB
         9BZZ5f5mhTzYFkKIkgQcToGLyjT4ACYGySLdP+LYGqZXuB0BSqMMNDVk6jF+8mDPOFzW
         dHjWUUu2rmo2gWqHFFj8CrsSKpeZ766UUyiL3JaUEr9e3Z+AHj/sFpklEGh9n6YzqQq3
         T2ow==
X-Forwarded-Encrypted: i=1; AJvYcCUdtf2ZHLpl1mmr5p2i1B8HJ7sx2vgCPX+ve3FvVe6hopdksflgRIYv5N2GZXC7R82wrtVQq08bZAbbffU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTddJZz3KQOxw2i7EhsIO9gp0GT2eeDaczWm0Xxeoyzm3A3Zql
	R8MF7DEjFxi197es0iP7pwq6L/yXSaD/Npb03ddiIEwo9UgO6GD7FJ3FD2wmmfypKluB0OMMzhS
	bhh1+XXfibsDSABegat/cVq64KwAXsN/ndCZBRJJ2TWjoKZjniJ8gc9wmJF8MwQ==
X-Received: by 2002:a05:600c:1d2a:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f58434112mr117674545e9.10.1727771901677;
        Tue, 01 Oct 2024 01:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSzGtY5AylcVmjPvCEOT5PJIwerGUumQV3fFEyTmnyEwtuxaT/BvGiQ3qbwzLqZZMnpncCQA==
X-Received: by 2002:a05:600c:1d2a:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f58434112mr117674395e9.10.1727771901255;
        Tue, 01 Oct 2024 01:38:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57d31283sm127176205e9.0.2024.10.01.01.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:38:20 -0700 (PDT)
Message-ID: <cf62e640-571d-4011-8d96-a37c17eb0fba@redhat.com>
Date: Tue, 1 Oct 2024 10:38:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: Add error pointer check in otx2_flows.c
To: Dipendra Khadka <kdipendra88@gmail.com>, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com,
 bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923063323.1935-1-kdipendra88@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240923063323.1935-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/23/24 08:33, Dipendra Khadka wrote:
> Adding error pointer check after calling otx2_mbox_get_rsp().
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

The commit message should include a 'Fixes' tag pointing to the commit 
introducing the issue.

Also please include some actual wording in the commit message itself 
describing the issue and the fix.

As Simon noted on the previous submission, please read carefully the 
process description under:

https://www.kernel.org/doc/html/latest/process/

and especially:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Thanks,

Paolo



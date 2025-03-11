Return-Path: <linux-kernel+bounces-556612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED71A5CC56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03F5177DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C12262D21;
	Tue, 11 Mar 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YJlDg6+G"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA15262D14
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714570; cv=none; b=EqF2CIGG51Zlpto47snZ5hTJBqpr0dqe8bjTwgG8oT2Wy1Qhaw8j/oMNUKqPphW9mxjtYryc3LvrQ28cqC140tdC2EotAzZYW6t4ww2Oip6BPttMhleMXSt5tzdi0V/V7gM6DFHFJcuxAZd/0S72Zx0v44o/hTXtaihzHcM0G+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714570; c=relaxed/simple;
	bh=5aUsqOrI16iMveQNEajx0BokuB8rnFuNsAld9sPRVSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAaaKSc0eO/Um3N4/HNKcN0sKJ+iOFC3FifFalietc+TPHdys3ArDjBWQ1wJQlWthIjmEkCJy7vaYEXBg6Gsf1OxAsvsWdiu52QE3lTxv8ZvBHkU5z5eW7WOsKsiqiFlcxj0PpjuzqK6B55QYppiwmTW1T1Inf76mx94xwL14ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YJlDg6+G; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so5474196fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741714568; x=1742319368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/AZGEVmfxF0jKoqVNVNRMBGz9sxfr8KBwzFyulmeIs=;
        b=YJlDg6+GFLBTrY5+hbodE6loh2u46+g1BNHmXUiata7GIe7AyA7U97p/a4f+9QdmGG
         MIxBquwZV7z4DtCoOXGES3AZteZc+Ei8I7q522qbgL6oHGZ9Ws8qNIYWxQOuWqD7m18U
         3YI3M31CEnkJ999vm+dQ0Luq3gaY7FwlAiA4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714568; x=1742319368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/AZGEVmfxF0jKoqVNVNRMBGz9sxfr8KBwzFyulmeIs=;
        b=C6M/y31KdmWTmx7rrrfuRBOK7sIqobTjnSoU2cgCtPTR/Nd0llv5zpIvob74LoXjAm
         MeqAa/YM7WW/2NzvYpBmlVdPJzHpAg9pd2Py45vfUEA7cTcJNXoGDl3DaV7lLimHh4RW
         NGO1HYbTl/e0v/x1/nBlP2Qvdj0EM6k8FTbfNE3TKv7la5gitXloeXeoGLkalHFpSLE/
         BoN9imdvyqTw4AuF9rS8094w919MaiyWIxPXMCyaVCIG+Cow9oJxuaMx1DI6pPObMy6t
         oSOM/Qt37QkwGRkAssEW3DgRvPs3QcLSjBHwLOwCpemJ2ufWoJitGrEcaUBsai7SkPCU
         hZbw==
X-Forwarded-Encrypted: i=1; AJvYcCXK2VDcOWk/83SC+Eh9yqiu7ezbPx6j1PvPjRHyuA+QDbW7tcTH/SBdicY3eMhwCF7EB0Z8S5+pUk7kHhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5f+j/oYyrLobjtlivyAXxZ04zTvNQlISG47+1VvlnP8syesVo
	+Zfgd+IMNuw/LTGK2OGpcxE8fjJwgAVbXKk47vb/WWFLFMfPE98JQBGUg7tZvQ==
X-Gm-Gg: ASbGncvTm3FCOdnZ8fzboa8z0rw0I/mtYbewQaHhv2lvSETs4Lh1pd/G6HhtGObnQYx
	FKHUgDKrIN2c9NgU9Hfsn1ONCc49mIryLOIDye1iOFhPGUnpxXDipLEu3AafVJluln2XpxzwY6p
	8+thVAKmtz8QfmKxTWxfrBGBBuXYKsLLHB2ldp15Rs0wrBUwwbvoxXHeECjow1OxWuZVsPyk5di
	ITob2uWgVoupNlzFJetm2V1nqG+i8oL5CRxt69TkAB/rPaH7e6lQpL4NpThz9eaygiedfpAzDnz
	/ayDH1tqp7aMsx6CVx6xvDFuT0PTEBwSe1VRSjhcfE7sHwiZPHE9hIPkcmbJipz0YWoi9mvHF3N
	fbhus
X-Google-Smtp-Source: AGHT+IF6stv4KV1HaEag5+77smmBKlZX0b6JVQBTx2uQ9Bg2ZjG5KNAD+BqnyMHU0PQVstMcpo8f2A==
X-Received: by 2002:a05:6871:8416:b0:2c2:c404:465f with SMTP id 586e51a60fabf-2c2c4044b38mr3090975fac.6.1741714568018;
        Tue, 11 Mar 2025 10:36:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c2d749e115sm661597fac.13.2025.03.11.10.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:36:06 -0700 (PDT)
Message-ID: <9188b3d1-ee61-c1d1-f06e-854ffd2ccff7@broadcom.com>
Date: Tue, 11 Mar 2025 10:20:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] misc: bcm-vk: avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z8_twT77rSIK-S_-@kspp>
Content-Language: en-US
From: Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <Z8_twT77rSIK-S_-@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gustavo,

On 2025-03-11 01:01, Gustavo A. R. Silva wrote:
> Hi all,
> 
> I'm trying to fix the following warning:
> 
> drivers/misc/bcm-vk/bcm_vk.h:415:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> after a quick look, I don't see any code directly using the flexible
> array `data[]`, so this patch should probably suffice:
> 
> diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
> index 386884c2a263..9344c2366a4b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk.h
> +++ b/drivers/misc/bcm-vk/bcm_vk.h
> @@ -311,7 +311,6 @@ struct bcm_vk_peer_log {
>          u32 wr_idx;
>          u32 buf_size;
>          u32 mask;
> -       char data[];
>   };
> 
> What do you think?
If it is changed to data[0] does the warning go away?  If not, you could 
remove it or change the code to use it instead of the sizeof used to
calculate peer offset.
> 
> Thanks
> --
> Gustavo


Return-Path: <linux-kernel+bounces-270757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558939444E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873601C2282D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455015855C;
	Thu,  1 Aug 2024 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FEERfxEQ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A32C853
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495264; cv=none; b=Uvl8HKNMNlYAE6Zy6RvNZ+KchdVK4qiUUULsW98av8pjwBOOzCg8T6bU5P5GoOdgQynNcfVz/fBhsrpgYu570k7niHafeO1eEXMvsQao1dXJR9mFRBGeOoo89pPVcs9ngyGDXIe/g2a+5OB3nnx24KqzzyZ8YdxyHC1A/vHRt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495264; c=relaxed/simple;
	bh=B2aduLbyl2w0DOqap6opE0ZMrWyZxDEAiEjEX4uiR5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCAZg5uIdNTDDJuVfclDmmzArkgajeyQze2xQoHmBhgHMXIVxJC68IQRqDWzwGsrwdYA+e08mRkxL4TD0LTwU8dpjQ5XQv089/R/GjMHAuFXKw5qLTDZfmRPZPYWwPjCDrVxa7MYGbeGR/S0mK3oi/ZNdNegeXn6GkKC+8+kHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FEERfxEQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so2645343a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722495261; x=1723100061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REx9tnLqztn/PqERh1PtnQ3iEqlwlxeIi55PMWMtu0k=;
        b=FEERfxEQ4RIn+rBplsgkujG0yD77hyiEKA7BXH0DMxSTs1B/54wlSGL1o6DbKTXDT2
         DUl1mkHHcBHT7nwMNDn3hV6rVsWdMDm55ABkJnwPBBzYwXTUxOtOJUXVvcCygMvoIcqc
         FWLWColyBrNUFk5fUmHFra8ejv8DkFD6aNAbSc0KMi+0WdY/VwEpqlCuhzWEbmydUF6b
         UdV+XJGxGiFqwRu+NRtOOtQy/tDKvrbMr6HgcLKVy97jbk5OujtsvldJYp+vVoX1VhUs
         0liAJwTlcAwVOG0yrOmcPfhTyy/bE6NcI6zZD7iOAujsDesFdZmQ2nPctLKcc6U2lcOG
         dC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495261; x=1723100061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REx9tnLqztn/PqERh1PtnQ3iEqlwlxeIi55PMWMtu0k=;
        b=gzXbFdvpvAYnPM/myOHXkTgwceuk2nPZi2ScKhrId7gp5CLBhIFa06Nm/lrwxJONQf
         ph5udwWOmgG8cLMNomG5V5TnkVC7trymGlmlnCY0bgAEvcbazudyD1lY70dbOmNZfmBb
         UXfxESNnf/jMHthcmsmuS6kYT4r/jvbh60Pu0f6LBAxckpmGhKV6WnGjcUtr4Iesjsb1
         BVLVj0wuNzUrzA8LtGbM06yo2QgYKggab+BG5IjVXl0psXxIGzivSnsfJakPKN97LtAR
         dWGKYEarUHNmpr10Zq1xH8tBwo7eF0GJcJWWph+tJkOSt7SsJ6M0cXKwcNUdvtNrdNi8
         RZPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFLSfYQrtBJDpAIHpHi3HNMH7SYh5uHWo2iYtIw1LkjF7S6G0F/Qxbm06RG+Gvns55ebRCExGAgYYBbHEHu5aW3IblKth+WagrAlF0
X-Gm-Message-State: AOJu0Yw+WLPPvuKb2pPwCCad8eA85jRkNSF/uZ93xvmZK4OENIokYMIn
	WuIMW2dIrzXaP0yWLReJp/ojSiKBA9HjApz1ks6L8Afu0G22RTWDXF/5liPRsxc=
X-Google-Smtp-Source: AGHT+IEx3GWmyFwZ41U1O+u9nI48xayCAcAUdP+Lr6251MaZzgfsFNonuaQsevOfxfxqTi9mkXxhsw==
X-Received: by 2002:a17:907:724e:b0:a7a:a2e3:3734 with SMTP id a640c23a62f3a-a7daf2d5ca8mr93384466b.28.1722495260167;
        Wed, 31 Jul 2024 23:54:20 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab53704sm856031766b.86.2024.07.31.23.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 23:54:19 -0700 (PDT)
Message-ID: <f5d4711f-9b4a-457c-b68c-c2e9aefbe4a8@suse.com>
Date: Thu, 1 Aug 2024 08:54:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: storage: ene_ub6250: Fix right shift warnings
To: Alan Stern <stern@rowland.harvard.edu>,
 Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com,
 usb-storage@lists.one-eyed-alien.net, linux-usb@vger.kernel.org,
 skhan@linuxfoundation.org, dan.carpenter@linaro.org, rbmarliere@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240729182348.451436-1-abhishektamboli9@gmail.com>
 <e72cc56a-3066-4cb8-848d-bfe27a48c095@suse.com>
 <ZqkpOQIjcBSAg8rC@embed-PC.myguest.virtualbox.org>
 <5d7870b0-6b63-430b-8885-2509b33dc78a@suse.com>
 <804a6d40-73a4-4af6-944b-95e9324d7429@rowland.harvard.edu>
 <Zqp8vbbIC8E/XrQY@embed-PC.myguest.virtualbox.org>
 <b35a344a-018b-44ae-975a-7767a3d5b6ec@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <b35a344a-018b-44ae-975a-7767a3d5b6ec@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31.07.24 20:19, Alan Stern wrote:
> On Wed, Jul 31, 2024 at 11:34:45PM +0530, Abhishek Tamboli wrote:
>> On Wed, Jul 31, 2024 at 10:04:33AM -0400, Alan Stern wrote:

Hi,

I should make my reasoning clearer.

>>> Replacing the variable with a constant won't make much difference.  The
>>> compiler will realize that bl_len has a constant value and will generate
>>> appropriate code anyway.  I think just changing the type is a fine fix.

While that is absolutely true, it kind of removes the reason for the patch
in the first place. The code gcc generates is unlikely to be changed.

We are reacting to a warning an automatic tool generates. That is a good thing.
We should have clean code. The question is how we react to such a report.
It just seems to me that if we fix such a warning, the code should really be clean
after that. Just doing the minimum that will make the checker shut up is
no good.

	Regards
		Oliver



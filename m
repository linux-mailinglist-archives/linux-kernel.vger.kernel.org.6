Return-Path: <linux-kernel+bounces-306406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A34963E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AF7B222AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D818CBEC;
	Thu, 29 Aug 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7FbqLbH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999714A60A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920244; cv=none; b=LD6TaOZCjS+3j2PNSFxPuDbhZDwY5ACVxgZNEdC9s0w9KRw3ZyEkIsNWkrIO86UjGFYEzBs7/VCABV6fog6i1UjOPQ9B9avRAFB7Zy5Tv+VXQcgXbfIXSJ2Q0AHnZp6b58K8DS53dLo5VEEPIWmyimUUcbGBr1LIJjoYyhNmZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920244; c=relaxed/simple;
	bh=uS0lQ6fVn+ubBBwBbVgMRJqxeIlXoLrJBWEyU8mTaTo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iefKGiVwbKsFqrCuxPdx0TvmGdkmqzmCdlEz4r6nmMn5Xp+6XevxbnUpPiir8xOkt8jeG72RWwXTxxKlIBvnezVK6McsHAJfGHjL45RMu/N1UQgKH8QGmho1NE8BzPnNKYguy3i09c/4i5ki99soHXIYAzkcpg61ai89xx0cdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7FbqLbH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724920242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvb93xLBJQ52OShbGm3thAYoRvo5bzwOoOyNaEarO2E=;
	b=S7FbqLbHc+IcEJabCPczuDYhf2y0uEtu/E2ZN0c4X55tzSXw5BFuKX4b/Fat6V/EMaXP18
	KPui5oQiTsDNWivNxFA6JlAx7klu2wwm4q3XLRzG8dwZcMDJctu08rf1XH8RiOo77MWG/Q
	Nl7y541LGs/OoKENF4NrKrhGkco9olg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-68fRTTwTPKaCgvfPRmUf9Q-1; Thu, 29 Aug 2024 04:30:34 -0400
X-MC-Unique: 68fRTTwTPKaCgvfPRmUf9Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37496a7daf2so338782f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920233; x=1725525033;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvb93xLBJQ52OShbGm3thAYoRvo5bzwOoOyNaEarO2E=;
        b=C7HDLRobvdJKVfHnjmMct0b01rONLnJLWxUcemZd4Z6ygMqxmHwSa2EyMG6ofkroMN
         fkN+BQpida7Ahg/EZcPEKcc8cpSOEObN6U34WtIw8sflZt/I2NACEQ21mOKcjnC0GonZ
         Qz1WgFjR2aSYARuJI7lBPCQt8aV86YISypTEgfsX2Kp+8x6TjwW2kP8x7133ceQjhU6o
         Xwt3sgi2Dzyb/IJPDu4XLf8iSWJBVci1+BaGNf0bn1ws+//ldKJaaw4nMWS2wcb27S4R
         38EsL8Z5Np0I1npGePT3AZGLUx9eOQtw2DuRlmvGqbXoIXETB3rUHb82Q/hAOqtcl1bj
         MgUw==
X-Forwarded-Encrypted: i=1; AJvYcCW2FagMUq3EA29XseeadX47nQzlcvkp/YygRmIRr0pqx994Gx8vjK6ZfJw5e72nT9x8coPyVTA5Bc6CnZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+EdZRyvdjXCttcGNU6JYW2tBG05AI0ha2Y4j475gUxAtJHZ6
	5PMuIj6Btrc6G5UPbeeEILCKK1y0Wn8XbttSAiAEt0HC7J7pJz0CucGObUn+2fro2eRdB/7Mowj
	V5YjBQATJpdVxvNxV/s2u7FwDuNivXcsOrJROydjxWQdbldXBWwrj3/R934dw0g==
X-Received: by 2002:a5d:40cd:0:b0:368:71fc:abbd with SMTP id ffacd0b85a97d-3749b54686cmr1375644f8f.26.1724920232744;
        Thu, 29 Aug 2024 01:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjKOfkBcyxNk8aRtN8xRTAWPJvrk7dkI8C75aJSmoes3B46tcFsjjT/IQq+JhIMmfOY+7W5w==
X-Received: by 2002:a5d:40cd:0:b0:368:71fc:abbd with SMTP id ffacd0b85a97d-3749b54686cmr1375623f8f.26.1724920232252;
        Thu, 29 Aug 2024 01:30:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efb1a25sm800269f8f.107.2024.08.29.01.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 01:30:31 -0700 (PDT)
Message-ID: <49f67272-b9e4-4974-9959-cada446e3811@redhat.com>
Date: Thu, 29 Aug 2024 10:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: pn533: Add poll mod list filling check
From: Paolo Abeni <pabeni@redhat.com>
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Samuel Ortiz <sameo@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240827084822.18785-1-amishin@t-argos.ru>
 <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
Content-Language: en-US
In-Reply-To: <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 10:26, Paolo Abeni wrote:
> The issue looks real to me and the proposed fix the correct one, but
> waiting a little more for Krzysztof feedback, as he expressed concerns
> on v1.

I almost forgot: for next submissions, please include the target tree in 
the subj prefix ('net' in this case) and avoid reply to the same thread 
with the new version: that usually confuses the patchbot.

Thanks,

Paolo



Return-Path: <linux-kernel+bounces-336999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C79843E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB7DB21F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1119CC19;
	Tue, 24 Sep 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQTsyQF6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AC19C57A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174618; cv=none; b=fvVWuxqvFbGfGF11aegdNirbBeDkYWwUdJmTkdxHzlekQCRRNmXJ37TmIcMsn/K4o2zUnaBAl1OhmoVL2u51Va0p6Sud3XETiCUaCd4xPdMWrp0z4JN1AV6f+1ad53ZJd8R1n1JKnPA0UC0/+9JNemkBh6cs6BQ+ZClRzfAE9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174618; c=relaxed/simple;
	bh=pS0OnUnMHt3x+dQfCCd9DYG82rNOAah6rAoIW93soDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgAsdiQ0Gg0eemp/yeolk7cnmxY7yssLyBu/BhdG8H+VNPdG1CGLDKxw4Wio8ND7lMkf+blGh16A7liQE0qaCTbhZj5m0MWo48BxxtezoR2GAtcbjyPhZVjK9SXCY0p2mXlNYkEcUGHk7y85AP22sHHJgIn3isytLD1aPvJSz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQTsyQF6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727174616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNkidy8tP2V0t8BDHsPRxDHfoz+Gz1VvYutaJSQeq0A=;
	b=VQTsyQF6V10BpUJW5qaoPVeXhMbESkoiHbwJQnlbpZbTbt6/wYiGTpG874GFKaB7IE8/O4
	XmQ2VkzT5S/mRKTZoQbTveMFgN1hmNxHSQmg2ojVpLev5i32bxWcbujRfZT4o6Ur5OH0UE
	I8Wtj6hL5/Y3LUzGytXGyujTlhOEFLg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-QRFVvdX_NL6DJXLy6sj4iA-1; Tue, 24 Sep 2024 06:43:33 -0400
X-MC-Unique: QRFVvdX_NL6DJXLy6sj4iA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374bfc57e2aso2787609f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727174613; x=1727779413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNkidy8tP2V0t8BDHsPRxDHfoz+Gz1VvYutaJSQeq0A=;
        b=dbUVU7sIB7Ztor7CWzXt9eS9etjGf0DK8B2nmLLB/nKmX5oSSz0TlV+EUZxjHpQHPP
         Sc6zcroURL8QbKIOfA4fGFcNLl8SNA/jpRlKuzKOF5kA2Q9uNaEu4WUM+MMZt9NT3rh0
         PjPStLDpo6BlFQuuConcMg0sOJWpE5c3RHSpQPwjyYLd0tUqZoo/z4yJYQU+Eqd312NR
         5Rq2i2F6ZokRlcEeVhlJgQ+F9oRG+b3Pe8UTvE/XCod8xfVLcPgiNwBgJ+ROWr3UT+sS
         iPjdm/vko6Oro0o0Ie8N89SvufVHYfPKkojr0roFiWi6Y8nwlrukA4fMzNH18BLMMozV
         JJSA==
X-Forwarded-Encrypted: i=1; AJvYcCV6UxWMJ3xcCYT3fQ1isTc/AeIgsnuz5auvRUi8rOGJePubZzfGynJSgwpz9p9g913cxhjotK8A/Dz3PYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVy/ZRxWq02SwYUYo4N3Kr6ATDTeEPk6+rQB2YaTsvhgL8Lqou
	iA2032e4EL5OiXd3DdFM+2q3fodT5U7xe9CJcsE3Npo4976oDUM+vOVzVN6v/dQ5b2yhYpv/j5e
	5I4XU9iFJ5HDypanyYsii6t3yhEJMA9Uw7sqmwu9CLr67zTIXtsVQC1g07QcLgA==
X-Received: by 2002:a5d:58e2:0:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37a42354020mr8608146f8f.43.1727174612668;
        Tue, 24 Sep 2024 03:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0dKgHWPlUM08f7dDvngustiUt9pe6+/LWynepDnxeXHhHsyb0kH/Zt/TQc3YFg2cXenoicg==
X-Received: by 2002:a5d:58e2:0:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37a42354020mr8608130f8f.43.1727174612216;
        Tue, 24 Sep 2024 03:43:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8c37sm1230316f8f.23.2024.09.24.03.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 03:43:31 -0700 (PDT)
Message-ID: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
Date: Tue, 24 Sep 2024 12:43:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] netlabel: Add missing comment to struct field
To: George Guo <dongtai.guo@linux.dev>, paul@paul-moore.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
References: <20240923080733.2914087-1-dongtai.guo@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240923080733.2914087-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 10:07, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> add a comment to doi_remove in struct netlbl_calipso_ops.
> 
> Flagged by ./scripts/kernel-doc -none.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

## Form letter - net-next-closed

The merge window for v6.12 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


